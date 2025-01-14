<?php
include('user_header.php');
?>

<?php include('includes/sideBar.php'); ?>
    
<main class="main-content">
    <section id="dashboard">
        <h2>JOB SATISFACTION SURVEY</h2>

        <?php
        $conn = mysqli_connect('localhost', 'root', '', 'esetech');

        if (!$conn) {
            die("Connection failed: " . mysqli_connect_error());
        }
        
        $current_year = date('Y');
        $employee_id = $_SESSION['employee_id'];
        echo "Session Employee ID: " . $_SESSION['employee_id'];
        $check_sql = "SELECT * FROM job_satisfaction_surveys 
                      WHERE employee_id = '$employee_id' 
                      AND YEAR(survey_date) = '$current_year'";
        $check_result = mysqli_query($conn, $check_sql);

        if (mysqli_num_rows($check_result) > 0) {
            echo "<p>You have already submitted your satisfaction survey for this year ($current_year). Thank you!</p>";
        } else {
            if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                $questions = [
                    'clarity_of_responsibilities' => '1. Clarity of job responsibilities',
                    'work_environment' => '2. Physical work environment',
                    'work_life_balance' => '3. Work-life balance',
                    'manager_support' => '4. Support from manager',
                    'team_collaboration' => '5. Team collaboration',
                ];

                // Collecting responses
                $responses = [];
                foreach ($questions as $key => $question) {
                    $responses[$key] = $_POST[$key];
                }

                $survey_date = date('Y-m-d');
                $questions_json = json_encode($responses);
                $overall_rating = array_sum($responses) / count($responses);

                $employee_check = "SELECT * FROM employees WHERE employee_id = '$employee_id'";
                $employee_result = mysqli_query($conn, $employee_check);

                if (mysqli_num_rows($employee_result) == 0) {
                    die("Error: Employee ID does not exist in the employees table.");
                }

                $sql = "INSERT INTO job_satisfaction_surveys (employee_id, survey_date, questions, overall_rating)
                        VALUES ('$employee_id', '$survey_date', '$questions_json', '$overall_rating')";

                if (mysqli_query($conn, $sql)) {
                    echo "<p style='color: green;'>Survey submitted successfully!</p>";
                } else {
                    echo "<p style='color: red;'>Error: " . mysqli_error($conn) . "</p>";
                }
            }
        ?>

<form method="POST">
    <label for="clarity_of_responsibilities">1. Clarity of job responsibilities</label>
    <div style="display: flex; justify-content: space-around; align-items: center; padding: 20px; font-size: 2rem;">
        <span title="Love" class="emoji" onclick="selectEmoji('clarity_of_responsibilities', 5)">&#x1F60D;</span>
        <span title="Happy" class="emoji" onclick="selectEmoji('clarity_of_responsibilities', 4)">&#x1F600;</span>
        <span title="Neutral" class="emoji" onclick="selectEmoji('clarity_of_responsibilities', 3)">&#x1F610;</span>
        <span title="Worried" class="emoji" onclick="selectEmoji('clarity_of_responsibilities', 2)">&#x1F625;</span>
        <span title="Sad" class="emoji" onclick="selectEmoji('clarity_of_responsibilities', 1)">&#x1F62B;</span>
    </div>
    <input type="hidden" id="clarity_of_responsibilities" name="clarity_of_responsibilities">
    <br><br>

    <label for="work_environment">2. Physical work environment</label>
    <div style="display: flex; justify-content: space-around; align-items: center; padding: 20px; font-size: 2rem;">
        <span title="Love" class="emoji" onclick="selectEmoji('work_environment', 5)">&#x1F60D;</span>
        <span title="Happy" class="emoji" onclick="selectEmoji('work_environment', 4)">&#x1F600;</span>
        <span title="Neutral" class="emoji" onclick="selectEmoji('work_environment', 3)">&#x1F610;</span>
        <span title="Worried" class="emoji" onclick="selectEmoji('work_environment', 2)">&#x1F625;</span>
        <span title="Sad" class="emoji" onclick="selectEmoji('work_environment', 1)">&#x1F62B;</span>
    </div>
    <input type="hidden" id="work_environment" name="work_environment">
    <br><br>

    <label for="work_life_balance">3. Work-life balance</label>
    <div style="display: flex; justify-content: space-around; align-items: center; padding: 20px; font-size: 2rem;">
        <span title="Love" class="emoji" onclick="selectEmoji('work_life_balance', 5)">&#x1F60D;</span>
        <span title="Happy" class="emoji" onclick="selectEmoji('work_life_balance', 4)">&#x1F600;</span>
        <span title="Neutral" class="emoji" onclick="selectEmoji('work_life_balance', 3)">&#x1F610;</span>
        <span title="Worried" class="emoji" onclick="selectEmoji('work_life_balance', 2)">&#x1F625;</span>
        <span title="Sad" class="emoji" onclick="selectEmoji('work_life_balance', 1)">&#x1F62B;</span>
    </div>
    <input type="hidden" id="work_life_balance" name="work_life_balance">
    <br><br>

    <label for="manager_support">4. Support from manager</label>
    <div style="display: flex; justify-content: space-around; align-items: center; padding: 20px; font-size: 2rem;">
        <span title="Love" class="emoji" onclick="selectEmoji('manager_support', 5)">&#x1F60D;</span>
        <span title="Happy" class="emoji" onclick="selectEmoji('manager_support', 4)">&#x1F600;</span>
        <span title="Neutral" class="emoji" onclick="selectEmoji('manager_support', 3)">&#x1F610;</span>
        <span title="Worried" class="emoji" onclick="selectEmoji('manager_support', 2)">&#x1F625;</span>
        <span title="Sad" class="emoji" onclick="selectEmoji('manager_support', 1)">&#x1F62B;</span>
    </div>
    <input type="hidden" id="manager_support" name="manager_support">
    <br><br>

    <label for="team_collaboration">5. Team collaboration</label>
    <div style="display: flex; justify-content: space-around; align-items: center; padding: 20px; font-size: 2rem;">
        <span title="Love" class="emoji" onclick="selectEmoji('team_collaboration', 5)">&#x1F60D;</span>
        <span title="Happy" class="emoji" onclick="selectEmoji('team_collaboration', 4)">&#x1F600;</span>
        <span title="Neutral" class="emoji" onclick="selectEmoji('team_collaboration', 3)">&#x1F610;</span>
        <span title="Worried" class="emoji" onclick="selectEmoji('team_collaboration', 2)">&#x1F625;</span>
        <span title="Sad" class="emoji" onclick="selectEmoji('team_collaboration', 1)">&#x1F62B;</span>
    </div>
    <input type="hidden" id="team_collaboration" name="team_collaboration">
    <br><br>

    <label for="compensation">6. Compensation</label>
    <div style="display: flex; justify-content: space-around; align-items: center; padding: 20px; font-size: 2rem;">
        <span title="Love" class="emoji" onclick="selectEmoji('compensation', 5)">&#x1F60D;</span>
        <span title="Happy" class="emoji" onclick="selectEmoji('compensation', 4)">&#x1F600;</span>
        <span title="Neutral" class="emoji" onclick="selectEmoji('compensation', 3)">&#x1F610;</span>
        <span title="Worried" class="emoji" onclick="selectEmoji('compensation', 2)">&#x1F625;</span>
        <span title="Sad" class="emoji" onclick="selectEmoji('compensation', 1)">&#x1F62B;</span>
    </div>
    <input type="hidden" id="compensation" name="compensation">
    <br><br>

    <label for="career_growth">7. Career growth</label>
    <div style="display: flex; justify-content: space-around; align-items: center; padding: 20px; font-size: 2rem;">
        <span title="Love" class="emoji" onclick="selectEmoji('career_growth', 5)">&#x1F60D;</span>
        <span title="Happy" class="emoji" onclick="selectEmoji('career_growth', 4)">&#x1F600;</span>
        <span title="Neutral" class="emoji" onclick="selectEmoji('career_growth', 3)">&#x1F610;</span>
        <span title="Worried" class="emoji" onclick="selectEmoji('career_growth', 2)">&#x1F625;</span>
        <span title="Sad" class="emoji" onclick="selectEmoji('career_growth', 1)">&#x1F62B;</span>
    </div>
    <input type="hidden" id="career_growth" name="career_growth">
    <br><br>

    <input type="submit" class="btn" value="Submit Survey">
</form>

        <?php
        }
        mysqli_close($conn);
        ?>

    </section>
</main>
<script>
function selectEmoji(question, rating) {
    // Get all emoji elements for the given question
    const emojis = document.querySelectorAll(`span[title][onclick*="${question}"]`);

    // Remove the 'selected' class from all emojis
    emojis.forEach(emoji => {
        emoji.classList.remove('selected');
    });

    // Add 'selected' class to the clicked emoji
    const selectedEmoji = document.querySelector(`span[onclick*="${question}"][onclick*="${rating}"]`);
    selectedEmoji.classList.add('selected');

    // Set the corresponding rating value for the question
    document.getElementById(question).value = rating; // This will update the hidden input value
}
</script>
<style>
    input[type="radio"]:checked + span {
    transform: scale(1.5);
    transition: transform 0.2s;
}
.emoji {
    font-size: 3rem;
    cursor: pointer;
}

.emoji.selected {
    border: 2px solid #4CAF50; /* Green border */
    border-radius: 50%;      /* Round border */
    padding: 5px;            /* Add padding for visual appeal */
    background-color: #E8F5E9; /* Light green background */
}
</style>
<?php include('user_footer.php'); ?>