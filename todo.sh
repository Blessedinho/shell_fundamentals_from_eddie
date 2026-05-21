#!/bin/bash

# Path to the todo file in the user's home directory
TODO_FILE="$HOME/todo.txt"

# Ensure the file exists right from the start
touch "$TODO_FILE"

while true; do
    echo "============================="
    echo "         TODO MENU           "
    echo "============================="
    echo "1. View all tasks"
    echo "2. Add a new task"
    echo "3. Delete a task"
    echo "4. Exit the program"
    echo "============================="
    
    # Use 'read' to get user input as per hints
    read -p "Please choose an option (1-4): " choice
    echo ""

    case $choice in
        1)
            echo "--- Current Tasks ---"
            if [ ! -s "$TODO_FILE" ]; then
                echo "Your todo list is currently empty."
            else
                # Use 'nl' to show line numbers dynamically
                nl -w2 -s". " "$TODO_FILE"
            fi
            echo ""
            ;;
            
        2)
            read -p "Enter the task you want to add: " new_task
            if [ -z "$new_task" ]; then
                echo "Task cannot be empty!"
            else
                # Use 'echo' to append tasks to the file
                echo "$new_task" >> "$TODO_FILE"
                echo "Task added successfully!"
            fi
            echo ""
            ;;
            
        3)
            echo "--- Delete a Task ---"
            if [ ! -s "$TODO_FILE" ]; then
                echo "No tasks available to delete."
            else
                # Show the tasks with numbers first so the user knows which one to pick
                nl -w2 -s". " "$TODO_FILE"
                echo "---------------------"
                read -p "Enter the task number to delete: " task_num
                
                # Validate that input is actually a number and not empty
                if [[ "$task_num" =~ ^[0-9]+$ ]]; then
                    # Check if the line number actually exists in the file
                    total_lines=$(wc -l < "$TODO_FILE")
                    if [ "$task_num" -le "$total_lines" ] && [ "$task_num" -gt 0 ]; then
                        # Use 'sed -i' to delete tasks by line number
                        sed -i "${task_num}d" "$TODO_FILE"
                        echo "Task #$task_num deleted successfully!"
                    else
                        echo "Invalid task number. Task does not exist."
                    fi
                else
                    echo "Invalid input. Please enter a valid number."
                fi
            fi
            echo ""
            ;;
            
        4)
            echo "Exiting the program. Goodbye!"
            exit 0
            ;;
            
        *)
            echo "Invalid option. Please select a number between 1 and 4."
            echo ""
            ;;
    esac
done
