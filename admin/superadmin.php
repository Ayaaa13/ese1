<?php
ob_start();

// Database connection
$conn = mysqli_connect('localhost', 'root', '', 'esetech');
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}
include('header.php');

if (!isset($_SESSION['superadmin'])) {
    // Redirect to the dashboard if the user is not a superadmin
    header("Location: ./dashboard");
    exit();
}

require '../vendor/autoload.php';
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '../vendor/PHPMailer-6.9.3/PHPMailer-6.9.3/src/Exception.php';
require '../vendor/PHPMailer-6.9.3/PHPMailer-6.9.3/src/PHPMailer.php';
require '../vendor/PHPMailer-6.9.3/PHPMailer-6.9.3/src/SMTP.php';

// Function to execute queries with error handling
function executeQuery($conn, $sql, $types = null, $params = []) {
    $stmt = mysqli_prepare($conn, $sql);
    if ($types && $params) {
        mysqli_stmt_bind_param($stmt, $types, ...$params);
    }
    if (!mysqli_stmt_execute($stmt)) {
        die("Query failed: " . mysqli_stmt_error($stmt)); // Add this to catch errors
    }
    mysqli_stmt_close($stmt);
}

// Add these validation functions at the top of the file, after the database connection
function validateUsername($username) {
    // Only allow letters, numbers, and no special characters
    return preg_match('/^[a-zA-Z0-9]+$/', $username);
}

function validateName($name) {
    // Only allow letters and spaces
    return preg_match('/^[a-zA-Z\s]+$/', $name);
}

function validateEmail($email) {
    // Check if email ends with @gmail.com
    return preg_match('/^[a-zA-Z0-9._%+-]+@gmail\.com$/', $email);
}

function validateContactNumber($number) {
    // Check if number is exactly 11 digits
    return preg_match('/^[0-9]{11}$/', $number);
}

// Add Admin
if (isset($_POST['add_admin'])) {
    $errors = array();
    
    // Validate username
    $username = $_POST['username'];
    if (!validateUsername($username)) {
        $errors[] = "Username can only contain letters and numbers.";
    }
    
    // Validate names
    $first_name = $_POST['first_name'];
    $middle_name = $_POST['middle_name'];
    $last_name = $_POST['last_name'];
    
    if (!validateName($first_name)) {
        $errors[] = "First name can only contain letters.";
    }
    if (!empty($middle_name) && !validateName($middle_name)) {
        $errors[] = "Middle name can only contain letters.";
    }
    if (!validateName($last_name)) {
        $errors[] = "Last name can only contain letters.";
    }
    
    // Validate email
    $email = $_POST['email'];
    if (!validateEmail($email)) {
        $errors[] = "Email must be a valid Gmail address (@gmail.com).";
    }
    
    // Validate contact number
    $contact_number = $_POST['contact_number'];
    if (!validateContactNumber($contact_number)) {
        $errors[] = "Contact number must be exactly 11 digits.";
    }

    if (empty($errors)) {
        // Existing username check
        $sql_check = "SELECT COUNT(*) FROM admin WHERE username = ?";
        $stmt_check = mysqli_prepare($conn, $sql_check);
        mysqli_stmt_bind_param($stmt_check, 's', $username);
        mysqli_stmt_execute($stmt_check);
        mysqli_stmt_bind_result($stmt_check, $username_count);
        mysqli_stmt_fetch($stmt_check);
        mysqli_stmt_close($stmt_check);

        if ($username_count > 0) {
            echo "<script>alert('Username already exists!');</script>";
        } else {
            $password = $_POST['password'];
            $password_hashed = password_hash($password, PASSWORD_DEFAULT);
            $user_type = 1;
            $status = $_POST['status'];
            $suffix = $_POST['suffix'];
            $birthday = $_POST['birthday'];
            $position = $_POST['position'];

            $sql = "INSERT INTO admin (username, password, user_type, status, first_name, middle_name, last_name, suffix, email, contact_number, birthday, position) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
            if ($stmt = mysqli_prepare($conn, $sql)) {
                mysqli_stmt_bind_param($stmt, 'ssisssssssss', 
                    $username, 
                    $password_hashed, 
                    $user_type, 
                    $status, 
                    $first_name, 
                    $middle_name, 
                    $last_name, 
                    $suffix, 
                    $email, 
                    $contact_number, 
                    $birthday, 
                    $position
                );
                
                if (mysqli_stmt_execute($stmt)) {
                    // Send email using PHPMailer 
                    $mail = new PHPMailer(true);

                    try {
                        // SMTP Settings
                        $mail->isSMTP();
                        $mail->Host = 'smtp.gmail.com'; // Gmail SMTP server
                        $mail->SMTPAuth = true;
                        $mail->Username = 'rroquero26@gmail.com'; // Your SMTP email
                        $mail->Password = 'plxj aziw yqbo wkbs'; // Use an App Password for Gmail
                        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
                        $mail->Port = 587;
                               
                        // Email Headers
                        $mail->setFrom('no-reply@yourwebsite.com', 'ESE-Tech Industrial Solutions Corporation System'); // Corrected "From" email
                        $mail->addAddress($email); // The recipient's email
                        $mail->Subject = 'Your Account from ESE-Tech Industrial Solutions Corporation System';

                        // Prepare the email message
                        $message = "Good day! <br><br> Welcome to ESE-Tech Industrial Solutions Corporation System! Below are your login credentials for the ESE-Tech Human Resource System: <br><br>Your Username is: $username <br>Your Password is: $password <br><br> You may log in using the link below: <br>ESE-Tech-HR-System-Login.com <br><br>If you encounter any issues while logging in, please email us at hrsupport@ese-tech.com. <br><br>Thank you! <br>Best regards, <br>ESE-Tech HR Team <br>hrsupport@ese-tech.com";

                        // Set email format to plain text
                        $mail->isHTML(true);
                        $mail->Body = $message;

                        // Send the email
                        if ($mail->send()) {
                            $_SESSION['success_message'] = "The employee, $first_name $last_name, has been successfully added.";
                            header("Location: " . preg_replace('/\.php$/', '', $_SERVER['REQUEST_URI']));
                            exit();
                        } else {
                            $errmsg = "An error occurred: " . $stmt->error;
                        }
                    } catch (Exception $e) {
                        $errmsg = "Mailer Error: " . $mail->ErrorInfo;
                    }
                }
                mysqli_stmt_close($stmt);
            }
        }
    } else {
        // Display all validation errors
        echo "<script>alert('" . implode("\\n", $errors) . "');</script>";
    }
}

// Update Admin
if (isset($_POST['update_admin'])) {
    $id = $_POST['id'];
    $username = $_POST['username'];
    $password = $_POST['password'] ? password_hash($_POST['password'], PASSWORD_BCRYPT) : null;
    $user_type = $_POST['user_type'];
    $status = $_POST['status'];
    $first_name = $_POST['first_name'];
    $last_name = $_POST['last_name'];
    $email = $_POST['email'];
    $contact_number = $_POST['contact_number'];

    if ($password) {
        $sql = "UPDATE admin SET username=?, password=?, user_type=?, status=?, first_name=?, last_name=?, email=?, contact_number=? WHERE id=?";
        executeQuery($conn, $sql, 'ssisssssi', [
            $username, $password, $user_type, $status, $first_name, $last_name, $email, $contact_number, $id
        ]);
    } else {
        $sql = "UPDATE admin SET username=?, user_type=?, status=?, first_name=?, last_name=?, email=?, contact_number=? WHERE id=?";
        executeQuery($conn, $sql, 'sisssssi', [
            $username, $user_type, $status, $first_name, $last_name, $email, $contact_number, $id
        ]);
    }
}

// Fetch Admins
$searchQuery = '';
if (isset($_GET['search'])) {
    $searchQuery = $_GET['search'];
}

$sql = "SELECT * FROM admin WHERE is_archived = 0";
if (!empty($searchQuery)) {
    $sql .= " WHERE LOWER(username) LIKE LOWER(?) 
              OR LOWER(first_name) LIKE LOWER(?) 
              OR LOWER(last_name) LIKE LOWER(?) 
              OR LOWER(email) LIKE LOWER(?)";
    $sql .= " ORDER BY id DESC"; // Order results by latest
    $stmt = mysqli_prepare($conn, $sql);
    $searchParam = '%' . $searchQuery . '%';
    mysqli_stmt_bind_param($stmt, 'ssss', $searchParam, $searchParam, $searchParam, $searchParam);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);
} else {
    $sql .= " ORDER BY id DESC"; // Order results by latest
    $result = mysqli_query($conn, $sql);
}

//Instead of delete Archive the user
// Instead of deleting, archive the user
if (isset($_GET['archive_id'])) {
    $id = $_GET['archive_id'];
    
    // Ensure the ID exists and check if the user is superadmin
    $checkQuery = "SELECT id, username FROM admin WHERE id = ?";
    $stmtCheck = mysqli_prepare($conn, $checkQuery);
    mysqli_stmt_bind_param($stmtCheck, 'i', $id);
    mysqli_stmt_execute($stmtCheck);
    mysqli_stmt_bind_result($stmtCheck, $userId, $username);
    mysqli_stmt_fetch($stmtCheck);
    mysqli_stmt_close($stmtCheck);
    
    if ($userId) {
        if ($username === 'superadmin') {
            echo "<script>alert('You cannot archive the superadmin!'); window.history.back();</script>";
            exit();
        } else {
            $sql = "UPDATE admin SET is_archived = 1 WHERE id=?";
            executeQuery($conn, $sql, 'i', [$id]);
            header("Location: superadmin"); // Redirect properly
            exit();
        }
    } else {
        echo "<script>alert('Admin not found!'); window.history.back();</script>";
        exit();
    }
}

// Add success message display
if (isset($_SESSION['success_message'])) {
    echo "<script>alert('" . $_SESSION['success_message'] . "');</script>";
    unset($_SESSION['success_message']);
}
ob_end_flush();
?>

<?php include('includes/sideBar.php'); ?>

<link rel="stylesheet" href="https://cdn.datatables.net/1.13.5/css/jquery.dataTables.min.css" />
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css" />
<script src="https://kit.fontawesome.com/a076d05399.js"></script> <!-- FontAwesome for the eye icon -->

<style>
    .input-group {
        position: relative;
    }
    .input-group-append {
        position: absolute;
        right: 10px;
        top: 50%;
        transform: translateY(-50%);
    }
</style>


<!-- Admin Management UI -->
<main class="main-content">
    <section id="dashboard">
        <h2 class="text-2xl font-bold mb-6">ADMIN MANAGEMENT</h2>
        
        <!-- Add Admin Form -->
        <div class="card">
            <div class="card-header">
                <h3>Add New Admin</h3>
            </div>
            <div class="card-body">
                <form method="POST">
                    <div class="form-row">
                        <div class="col-md-4">
                            <label for="username">Username</label>
                            <input type="text" class="form-control" name="username" placeholder="Username" required>
                        </div>

                        <div class="col-md-4">
                            <label for="password">Password</label>
                            <div class="input-group">
                                <input type="password" class="form-control" name="password" id="password" placeholder="Password" required>
                                <div class="input-group-append">
                                    <span class="input-group-text" id="togglePassword">
                                        <i class="fas fa-eye"></i> <!-- Eye icon from FontAwesome -->
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <label for="user_type">User Type</label>
                            <input type="text" class="form-control" name="user_type" id="user_type" value="Admin" required>
                            <!-- <select name="user_type" required>
                                <option value="1">Admin</option>
                                <option value="2">User</option>
                            </select> -->
                        </div>

                        <div class="col-md-4">
                            <label for="status">Status</label>
                            <select name="status" required>
                                <option value="1">Active</option>
                                <option value="2">Inactive</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-md-6">
                            <label for="first_name">First Name</label>
                            <input type="text" class="form-control" name="first_name" placeholder="First Name" required>
                        </div>

                        <div class="col-md-6">
                            <label for="middle_name">Middle Name</label>
                            <input type="text" class="form-control" name="middle_name" placeholder="Middle Name" required>
                        </div>

                        <div class="col-md-6">
                            <label for="last_name">Last Name</label>
                            <input type="text" class="form-control" name="last_name" placeholder="Last Name" required>
                        </div>

                        <div class="col-md-4">
                            <label for="suffix">Suffix</label>
                            <input type="text" class="form-control" name="suffix" id="suffix" placeholder="e.g., Sr., Jr., III" list="suffixes">
                            <datalist id="suffixes">
                                <option value="Sr.">
                                <option value="Jr.">
                                <option value="III">
                                <option value="II">
                                <option value="IV">
                                <option value="V">
                            </datalist>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-md-6">
                            <label for="birthday">Date Of Birth</label>
                            <input type="date" max="2005-12-31" class="form-control" name="birthday" placeholder="Date Of Birth" required>
                        </div>
                        <div class="col-md-6">
                            <label for="email">Email</label>
                            <input type="email" class="form-control" name="email" placeholder="Email" required>
                        </div>

                        <div class="col-md-6">
                            <label for="contact_number">Contact Number</label>
                            <input type="text" class="form-control" name="contact_number" placeholder="Contact Number" required>
                        </div>

                        <div class="col-md-6">
                            <label for="position">Position</label>
                            <input type="text" class="form-control" name="position" placeholder="Position" required>
                        </div>
                    </div>

                    <div class="form-row justify-content-center mt-4">
                        <div class="col-md-4 text-center">
                            <button type="submit" name="add_admin" class="btn btn-primary">Add Admin</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Admin Table -->
        <div class="card">
    <div class="card-header">
        <h3>Admin List</h3>
    </div>
    <div class="card-body">
        <table id="myTable" class="employee-table">
            <thead>
                <tr>
                    <th>No.</th>
                    <th>Username</th>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Position</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
            <?php 
                $counter = 1; // Initialize the counter
                while ($employee = mysqli_fetch_assoc($result)): 
                    $fullName = htmlspecialchars($employee['first_name']) . ' ' . 
                                (!empty($employee['middle_name']) ? htmlspecialchars($employee['middle_name']) . ' ' : '') . 
                                htmlspecialchars($employee['last_name']) . 
                                (!empty($employee['suffix']) ? ', ' . htmlspecialchars($employee['suffix']) : '');
            ?>
                <tr>
                    <td><?php echo $counter++; ?></td> <!-- Display the counter and increment it -->
                    <td><?php echo htmlspecialchars($employee['username']); ?></td>
                    <td><?php echo $fullName; ?></td>
                    <td><?php echo htmlspecialchars($employee['email']); ?></td>
                    <td><?php echo htmlspecialchars($employee['position']); ?></td>
                    <td class="actions action-buttons">
                        <a href="./edit_admin?id=<?php echo $employee['id']; ?>" class="btn btn-warning">Edit</a>
                        <a href="?archive_id=<?php echo $employee['id']; ?>" class="btn btn-danger" onclick="return confirm('Are you sure you want to Archive this employee?');">Archive</a>
                    </td>
                </tr>
            <?php endwhile; ?>
            </tbody>
        </table>
    </div>
</div>
    </section>
</main>

<?php include('footer.php'); ?>

<script>
$(document).ready(function () {
    $('#myTable').DataTable();
});
</script>

<script>
    // Get the password input and the eye icon
    const togglePassword = document.getElementById("togglePassword");
    const password = document.getElementById("password");

    togglePassword.addEventListener("click", function () {
        // Toggle the type of the password input between 'password' and 'text'
        const type = password.type === "password" ? "text" : "password";
        password.type = type;

        // Toggle the eye icon between open and closed
        this.querySelector("i").classList.toggle("fa-eye-slash");
    });
</script>

<script>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>

</body>
</html>

<script>
document.querySelector('form').addEventListener('submit', function(e) {
    let errors = [];
    
    // Username validation
    const username = document.querySelector('input[name="username"]').value;
    if (!/^[a-zA-Z0-9]+$/.test(username)) {
        errors.push("Username can only contain letters and numbers.");
    }
    
    // Name validations
    const firstName = document.querySelector('input[name="first_name"]').value;
    const middleName = document.querySelector('input[name="middle_name"]').value;
    const lastName = document.querySelector('input[name="last_name"]').value;
    
    if (!/^[a-zA-Z\s]+$/.test(firstName)) {
        errors.push("First name can only contain letters.");
    }
    if (middleName && !/^[a-zA-Z\s]+$/.test(middleName)) {
        errors.push("Middle name can only contain letters.");
    }
    if (!/^[a-zA-Z\s]+$/.test(lastName)) {
        errors.push("Last name can only contain letters.");
    }
    
    // Email validation
    const email = document.querySelector('input[name="email"]').value;
    if (!/^[a-zA-Z0-9._%+-]+@gmail\.com$/.test(email)) {
        errors.push("Email must be a valid Gmail address (@gmail.com).");
    }
    
    // Contact number validation
    const contactNumber = document.querySelector('input[name="contact_number"]').value;
    if (!/^[0-9]{11}$/.test(contactNumber)) {
        errors.push("Contact number must be exactly 11 digits.");
    }
    
    if (errors.length > 0) {
        e.preventDefault();
        alert(errors.join("\n"));
    } else {
        // If form is valid, submit it and reset
        setTimeout(resetForm, 1000);
    }
});
</script>

<script>
// Function to reset form
function resetForm() {
    document.querySelector('form').reset();
}

// Reset form on page load if it was a redirect
if (window.performance && window.performance.navigation.type === window.performance.navigation.TYPE_BACK_FORWARD) {
    resetForm();
}

// Prevent form resubmission on page refresh
if (window.history.replaceState) {
    window.history.replaceState(null, null, window.location.href);
}

// Modified form submit event listener
document.querySelector('form').addEventListener('submit', function(e) {
    let errors = [];
    
    // Your existing validation code...
    
    if (errors.length > 0) {
        e.preventDefault();
        alert(errors.join("\n"));
    } else {
        // If form is valid, submit it and reset
        setTimeout(resetForm, 1000);
    }
});
</script>
