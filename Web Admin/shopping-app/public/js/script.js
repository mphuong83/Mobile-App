// Show the modal
        document.querySelector(".add-button").addEventListener("click", function() {
            document.getElementById("modal").style.display = "block";
        });

        // Close the modal
        document.querySelector(".close-button").addEventListener("click", function() {
            document.getElementById("modal").style.display = "none";
        });

        // Close the modal when clicking outside of it
        window.onclick = function(event) {
            if (event.target == document.getElementById("modal")) {
                document.getElementById("modal").style.display = "none";
            }
        };