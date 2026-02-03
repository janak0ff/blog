---
title: Linux-M3 - Introduction to Shell Scripting
date: 2025-05-21
categories: [linux]
tags:
  - Linux Introduction
  - Introduction
  - Shell Scripting
description: Learn the basics of shell scripting. Learn what a script is and when to use scripts. Describe the shebang interpreter directive and create and run a simple shell script. Additionally, Usage pipes and filters and set shell and environment variables. list features of Bash shell scripting and use crontab to schedule cron jobs, understand the cron syntax, and view and remove cron jobs.
---


# **Shell Scripting Basics in Linux**

---

## **1. What is a Script?**

A **script** is a **list of commands** stored in a file that can be executed as a program.

- Unlike compiled programs, scripts are interpreted at runtime.
- They are written in **scripting languages** like:
  - Bash (Bourne Again SHell)
  - Python
  - Perl
  - Ruby

### **Key Characteristics**

| Feature          | Description                                     |
| ---------------- | ----------------------------------------------- |
| Interpreted      | Not compiled; executed line by line             |
| Easy to write    | Faster development time than compiled languages |
| Slower execution | Compared to compiled code                       |
| Automation power | Used for automating repetitive tasks            |

---

## **2. Common Use Cases for Shell Scripts**

Shell scripting is widely used in system administration and automation:

| Use Case                    | Example                                    |
| --------------------------- | ------------------------------------------ |
| **Automation**              | Backing up files, rotating logs            |
| **ETL Jobs**                | Extracting, transforming, and loading data |
| **System Administration**   | Monitoring services, user management       |
| **Application Integration** | Chaining tools or APIs together            |
| **Web Development**         | Deployment scripts, build processes        |

> Shell scripts help save time and reduce human error by automating routine tasks.

---

## **3. The Shebang Line (`#!`) – Interpreter Directive**

The first line of any shell script should be the **shebang**, also known as the **interpreter directive**.

### **Purpose**

Tells the system which interpreter to use when running the script.

### **Syntax**

```bash
#!/path/to/interpreter [optional_argument]
```

### **Examples**

| Shebang                  | Meaning                            |
| ------------------------ | ---------------------------------- |
| `#!/bin/sh`              | Use the Bourne shell               |
| `#!/bin/bash`            | Use the Bash shell                 |
| `#!/usr/bin/env python3` | Use Python 3 from environment path |
| `#!/usr/bin/perl`        | Run with Perl interpreter          |

> Without a shebang, the script may run using the current shell — which could lead to unexpected behavior.

---

## **4. Creating Your First Shell Script: “Hello World”**

### **Step-by-step Instructions**

#### **Step 1: Create an empty file**

```bash
touch hello_world.sh
```

> `.sh` is a common extension for shell scripts (not required, but good practice).

---

#### **Step 2: Add the shebang and command**

```bash
echo '#!/bin/bash' >> hello_world.sh
echo 'echo "Hello World"' >> hello_world.sh
```

> This creates a script that runs in Bash and prints “Hello World”.

---

#### **Step 3: Make the script executable**

```bash
chmod +x hello_world.sh
```

> Before this, the file was readable and writable, but not executable.

Use `ls -l hello_world.sh` to check permissions:

```
-rw-r--r-- 1 user group 0 Jan 1 12:00 hello_world.sh   # Not executable
```

After `chmod +x`:

```
-rwxr-xr-x 1 user group 0 Jan 1 12:00 hello_world.sh   # Now executable
```

---

#### **Step 4: Run the script**

```bash
./hello_world.sh
```

> Output:

```
Hello World
```

---

## **5. Understanding File Permissions**

Linux uses a permission model to control access to files.

### **File Permission Breakdown**

Using `ls -l`, you’ll see something like:

```
-rwxr-xr-x 1 user group 0 Jan 1 12:00 hello_world.sh
```

- `-rwx` → Owner (user) has Read, Write, Execute
- `r-x` → Group has Read and Execute
- `r-x` → Others have Read and Execute

### **Changing Permissions with `chmod`**

```bash
chmod +x filename.sh     # Add execute permission for all users
chmod u+x filename.sh    # Add execute only for owner
chmod go-r filename.sh   # Remove read for group and others
```

---

## **6. Summary of Key Concepts**

| Concept                     | Description                                     |
| --------------------------- | ----------------------------------------------- |
| **Script**                  | A text file containing a list of shell commands |
| \*\*Shebang (`#!`)          | Specifies which interpreter to use              |
| **Interpreted Language**    | Runs directly without compiling                 |
| **Scripting Advantages**    | Fast to develop, great for automation           |
| **Scripting Disadvantages** | Slower than compiled languages                  |
| **Making Executable**       | Use `chmod +x` before running                   |
| **Running a Script**        | Use `./filename.sh` after making it executable  |

---

## **7. Quick Reference Table**

| Task                  | Command                                  |
| --------------------- | ---------------------------------------- |
| Create a new script   | `touch script.sh`                        |
| Add shebang           | `echo '#!/bin/bash' > script.sh`         |
| Add command           | `echo 'echo "Hello World"' >> script.sh` |
| Make executable       | `chmod +x script.sh`                     |
| Run script            | `./script.sh`                            |
| View file permissions | `ls -l script.sh`                        |

---

## **8. Final Tips**

✅ Always start your shell script with a shebang line (`#!/bin/bash`)  
✅ Use descriptive names for your scripts  
✅ Test small scripts before scaling them up  
✅ Keep scripts simple and modular  
✅ Comment your code to explain what it does  
✅ Use `chmod` to make scripts executable  
✅ Run scripts with `./script.sh` after setting permissions

---

## **9. Bonus: Anatomy of a Simple Bash Script**

```bash
#!/bin/bash
# This is a comment
echo "Welcome to Shell Scripting!"
```

Save this as `welcome.sh`, make it executable, and run it!

---

# 🧾 **Reading: A Brief Introduction to Shell Variables**

In this reading, you were introduced to one of the most powerful and essential features in shell scripting — **shell variables**. These allow you to store and manipulate data directly in the terminal or within scripts.

---

## 🎯 Learning Objectives Recap

After completing this reading, you can now:

✅ **Describe what shell variables are**  
✅ **Create and use your own shell variables**  
✅ **Read user input into a variable using `read`**

---

## 💡 What Is a Shell Variable?

A **shell variable** is a named storage location that holds a value — such as a string, number, or command output — for use in the shell environment.

### 🔹 Example:

```bash
firstname=Jeff
echo $firstname
```

Output:

```
Jeff
```

- `firstname=Jeff` → Assigns the value `Jeff` to the variable `firstname`
- `$firstname` → Retrieves (expands) the value stored in the variable

> ⚠️ No spaces around the `=` when assigning values:
>
> ```bash
> # Correct
> name=Linux
>
> # Incorrect
> name = Linux  ❌
> ```

---

## 🧩 Creating Shell Variables

### 🔹 Direct Assignment

You can create a variable by simply giving it a name and assigning a value:

```bash
greeting="Hello World"
echo $greeting
```

Output:

```
Hello World
```

Quotes help preserve whitespace and special characters.

---

### 🔹 Reading User Input with `read`

The `read` command lets you capture input from the user and store it in a variable.

#### Example:

```bash
read lastname
Grossman
echo $lastname
```

Output:

```
Grossman
```

This is especially useful in **scripts**, where you want to interactively gather information from users.

---

## 🧑‍💻 Combining Variables

You can combine multiple variables in one command:

```bash
echo $firstname $lastname
```

Output:

```
Jeff Grossman
```

This makes it easy to build dynamic messages or paths based on user input or system state.

---

## 📝 Summary Table

| Task                            | Command          |
| ------------------------------- | ---------------- |
| Create a variable               | `var_name=value` |
| Access variable value           | `$var_name`      |
| Read user input into a variable | `read var_name`  |
| Print variable content          | `echo $var_name` |

---

## 🧠 Why Shell Variables Matter

Shell variables are essential because they allow you to:

- **Store temporary data** during a session
- **Make scripts interactive** with user input
- **Customize behavior** of shell scripts
- **Reuse values** without hardcoding them

They're the foundation of automation in Bash scripting!

---

## 🛠️ Real-World Use Cases

| Scenario             | Example                          |
| -------------------- | -------------------------------- |
| Store a username     | `user=$(whoami)`                 |
| Prompt for file name | `read filename`                  |
| Build dynamic paths  | `path=/home/$USER/logs`          |
| Set custom message   | `message="Welcome back, $USER!"` |

---

# 📜 Exercise 1 – Create and Execute a Basic Shell Script

In this hands-on exercise, you created your **first Bash shell script** called `greet.sh`. You used:

- **Shell variables** to store user input
- The `echo` command to print messages
- **Comments** (`#`) to document the script
- The `read` command to accept input from the user

You then executed it using `bash greet.sh`.

---

## ✅ Step-by-Step Breakdown

### 🔹 1.1 Create a New Script File

#### Steps:

1. Opened a new file in the editor (via `File > New File`)
2. Saved it as: `greet.sh`
3. Pasted the following Bash script:

```bash
# This script accepts the user's name and prints
# a message greeting the user

# Print the prompt message on screen
echo -n "Enter your name :"

# Wait for user to enter a name, and save the entered name into the variable 'name'
read name

# Print the welcome message followed by the name
echo "Welcome $name"

# The following message should print on a single line. Hence the usage of '-n'
echo -n "Congratulations! You just created and ran your first shell script "
echo "using Bash on IBM Skills Network"
```

> 💡 Tip: The `-n` option in `echo` prevents the automatic newline — useful when printing across multiple lines.

4. Saved the file using `File > Save`

---

### 🔹 1.2 Execute the Script

#### Step 1: Open a Terminal

- Clicked `Terminal > New Terminal` to open a terminal window

#### Step 2: Check File Permissions

```bash
ls -l greet.sh
```

Make sure it exists and is readable.

#### Step 3: Run the script

```bash
bash greet.sh
```

#### What Happens:

- It prompts:
  ```
  Enter your name :
  ```
- You type your name and press **Enter**
- It responds with:
  ```
  Welcome [YourName]
  Congratulations! You just created and ran your first shell script using Bash on IBM Skills Network
  ```

✅ Success! You've run your **first Bash script**.

---

## 🧠 Why This Matters

This simple script introduces several key scripting concepts:

| Feature                | Purpose                                         |
| ---------------------- | ----------------------------------------------- |
| `#`                    | Adds comments to explain what the script does   |
| `echo`                 | Prints text or variables to the terminal        |
| `read`                 | Captures user input and stores it in a variable |
| Variables like `$name` | Store dynamic values for later use              |
| Multiple `echo` lines  | Control how output appears on screen            |

These are the building blocks of **Bash scripting**, which powers automation in Linux environments.

---

## 🛠️ Real-World Scripting Tips

- Make scripts executable:
  ```bash
  chmod +x greet.sh
  ./greet.sh
  ```
- Always test your scripts before sharing them
- Use comments to help others understand your code
- Use descriptive variable names like `username`, not `x`

---

# 🔧 Exercise 2 – Using a Shebang Line

In this exercise, you took your **first Bash script (`greet.sh`)** to the next level by:

- Adding a **shebang line** (`#!`) to specify the interpreter
- Making it **executable**, so you can run it like a regular command: `./greet.sh`

This is a foundational step toward writing **portable and reusable shell scripts**.

---

## 📋 Step-by-Step Breakdown

### 🔹 2.1 Find the Path to the Bash Interpreter

You used the `which` command to locate where `bash` is installed:

```bash
which bash
```

Output:

```
/bin/bash
```

This tells you that the Bash shell is located at `/bin/bash`.

---

### 🔹 2.2 Add the Shebang Line to Your Script

You opened `greet.sh` and added the shebang line at the very top:

```bash
#!/bin/bash
```

This line tells the system:

> "Use `/bin/bash` to interpret this script."

Your updated script now looks like:

```bash
#!/bin/bash

# This script accepts the user's name and prints
# a message greeting the user

echo -n "Enter your name :"
read name
echo "Welcome $name"
echo -n "Congratulations! You just created and ran your first shell script "
echo "using Bash on IBM Skills Network"
```

✅ This makes your script self-contained and portable — any system with Bash can now execute it.

---

### 🔹 2.3 Make the Script Executable

#### First, check current permissions:

```bash
ls -l greet.sh
```

It likely looked like:

```
-rw-r--r-- 1 user group 200 Apr 5 10:00 greet.sh
```

No execute permission yet!

#### Add execute permission for the owner:

```bash
chmod u+x greet.sh
```

Or make it executable for everyone:

```bash
chmod +x greet.sh
```

#### Verify the new permissions:

```bash
ls -l greet.sh
```

Now it should show:

```
-rwxr-xr-x 1 user group 200 Apr 5 10:00 greet.sh
```

The `x` means the file is now **executable**.

---

### 🔹 2.4 Run the Script Like a Command

You executed your script using:

```bash
./greet.sh
```

- `./` tells the shell to look in the **current directory**
- `greet.sh` is your **self-executable script**

You were prompted:

```
Enter your name :
```

After entering your name, you saw:

```
Welcome [YourName]
Congratulations! You just created and ran your first shell script using Bash on IBM Skills Network
```

✅ Congratulations again — you've successfully made your script **runnable as a command**!

---

## 📌 Summary Table

| Task                            | Command                          |
| ------------------------------- | -------------------------------- |
| Locate Bash interpreter         | `which bash`                     |
| Add shebang line                | `#!/bin/bash` (at top of script) |
| Make script executable for user | `chmod u+x greet.sh`             |
| Make executable for all users   | `chmod +x greet.sh`              |
| Check file permissions          | `ls -l greet.sh`                 |
| Run the script                  | `./greet.sh`                     |

---

## 🧠 Why This Matters

By adding the **shebang line** and making the script **executable**, you’ve learned how to:

- Turn a text file into a real **Linux command**
- Define which interpreter should run the script
- Improve **script portability** across systems
- Control **who can run** the script via permissions

These are essential steps in creating **custom automation tools** in Linux.

---

## 💡 Pro Tips

- Always test scripts with:
  ```bash
  bash greet.sh
  ```
  Before making them executable — helps catch syntax errors early.
- Use descriptive names for your scripts
- Keep your scripts in a dedicated folder like `~/scripts/` and add it to your `PATH` later
- Use comments liberally to explain what your script does

---

# **Filters, Pipes, and Variables in Linux Shell**

---

## **1. Introduction**

This video introduces three powerful features of the Linux shell:

✅ **Filters** – commands that process input and produce output  
✅ **Pipes (`|`)** – a way to chain filters together  
✅ **Shell & Environment Variables** – for storing and managing values

These tools are essential for building complex command chains and managing configuration in scripts and interactive sessions.

---

## **2. What Are Filters?**

### **Definition**

A **filter** is a command or program that:

- Accepts input from **standard input (stdin)** (e.g., keyboard)
- Processes or transforms the data
- Sends output to **standard output (stdout)** (e.g., terminal)

### **Common Filter Commands**

| Command        | Description                              |
| -------------- | ---------------------------------------- |
| `wc`           | Count lines, words, characters           |
| `cat`          | Print or concatenate files               |
| `more`, `less` | View content page by page                |
| `head`, `tail` | Show beginning or end of a file          |
| `sort`         | Sort lines alphabetically or numerically |
| `grep`         | Search for patterns in text              |

### **Example of a Filter Chain**

```bash
ls | sort -r
```

> Takes output from `ls` and sorts it in reverse order.

---

## **3. The Pipe Operator (`|`) – Chaining Filters Together**

### **Purpose**

The pipe operator allows you to **connect the output of one command as input to another**, forming a **pipeline**.

### **Syntax**

```bash
command1 | command2 | command3
```

### **Examples**

#### **Example 1: List variables and show only the first few**

```bash
set | head -n 4
```

> `set` lists all shell variables; `head -n 4` shows only the first four lines.

#### **Example 2: List environment variables matching a pattern**

```bash
env | grep GREE
```

> `env` lists all environment variables; `grep GREE` filters for those containing "GREE".

#### **Example 3: Count number of processes**

```bash
ps | wc -l
```

> Counts how many running processes there are.

---

## **4. Shell Variables**

### **What Are Shell Variables?**

Variables defined within a shell session that are **not available to child processes** (like subshells or other programs).

### **Creating a Shell Variable**

```bash
GREETINGS=hello
AUDIENCE=world
```

> ⚠️ No spaces around the `=` sign.

### **Accessing Variable Values**

Use the `$` symbol to access variable contents:

```bash
echo $GREETINGS $AUDIENCE
```

> Output:

```
hello world
```

### **Listing All Shell Variables**

```bash
set
```

> Shows all shell variables and functions visible in the current shell.

### **Removing a Shell Variable**

```bash
unset AUDIENCE
```

> Removes the variable `AUDIENCE`.

---

## **5. Environment Variables**

### **What Are Environment Variables?**

Environment variables are like shell variables but with **global scope** — they are visible to the current shell **and any child processes**.

### **Promoting a Shell Variable to Environment Variable**

```bash
export GREETINGS
```

> Now `GREETINGS` is an environment variable.

### **Listing All Environment Variables**

```bash
env
```

Or filter using `grep`:

```bash
env | grep GREETINGS
```

> Confirms `GREETINGS` is now an environment variable.

---

## **6. Key Differences Between Shell and Environment Variables**

| Feature          | Shell Variable                 | Environment Variable                   |
| ---------------- | ------------------------------ | -------------------------------------- |
| Scope            | Only current shell             | Current shell + child processes        |
| Created with     | `VAR=value`                    | `export VAR=value`                     |
| Visibility       | Not visible to child processes | Visible to child processes             |
| Example use case | Temporary storage in script    | Configurable settings for apps/scripts |

---

## **7. Summary Table: Commands for Working with Filters, Pipes, and Variables**

| Task                               | Command      | Description                            |
| ---------------------------------- | ------------ | -------------------------------------- | ---------------------------------------- |
| Run two commands in sequence       | `cmd1        | cmd2`                                  | Output of `cmd1` becomes input of `cmd2` |
| Count lines in a directory listing | `ls          | wc -l`                                 | Lists files and counts them              |
| View only top 4 shell variables    | `set         | head -n 4`                             | Lists shell vars and shows top 4         |
| Create a shell variable            | `VAR=value`  | No spaces around `=`                   |
| Access variable value              | `echo $VAR`  | Use `$` to get value                   |
| Remove a variable                  | `unset VAR`  | Deletes variable from shell            |
| Make shell var an env var          | `export VAR` | Makes var available to child processes |
| List all environment variables     | `env`        | Shows global variables                 |
| Filter environment variables       | `env         | grep PATTERN`                          | Search for specific variables            |

---

## **8. Full “Hello World” Example Using Variables**

```bash
GREETINGS=hello
AUDIENCE=world
echo $GREETINGS $AUDIENCE
# Output: hello world

unset AUDIENCE
export GREETINGS
env | grep GREETINGS
# Output confirms GREETINGS is now an environment variable
```

---

## **9. Final Tips**

- Use **pipes** to build powerful one-liners.
- Use **filters** to transform and analyze data.
- Use **shell variables** for temporary values inside scripts.
- Use **environment variables** to pass values to sub-processes or configure applications.
- Always check your syntax when assigning variables — no spaces around `=`.
- Combine these tools for automation, analysis, and scripting.

---

# 🔗 Examples of Pipes in Linux

Pipes (`|`) are one of the most powerful features in Linux and Bash scripting. They allow you to **connect commands**, using the output of one as input for the next.

---

## 🎯 Learning Objectives Recap

After this reading, you can now:

✅ Describe what **pipes** are  
✅ Use pipes to combine commands like `sort`, `uniq`, `tr`, etc.  
✅ Apply pipes to extract information from strings and files  
✅ Extract specific data (like Bitcoin price) from JSON or URLs using `grep` and pipes

---

## 🔧 What Are Pipes?

A **pipe** takes the **output of one command** and feeds it as **input to another**.

### 🔁 Basic Syntax:

```bash
command1 | command2 | command3
```

There's no limit on how many commands you can chain together!

> 💡 This is known as a **pipeline** — a sequence of processes where the output of each step becomes the input of the next.

---

## 🔄 Pipe Examples: Combining Commands

You used `sort` and `uniq` together to clean up text and remove duplicates.

### Example: Remove all duplicate lines from `pets.txt`

```bash
sort pets.txt | uniq
```

- `sort`: puts identical lines together
- `uniq`: removes consecutive duplicates

Together, they give you a list of **unique animals**:

```
cat
dog
goldfish
parrot
```

---

## 📄 Applying Commands to Strings and Files

Some tools like `tr` work with **standard input only** — so we use pipes to apply them to strings and file contents.

### Replace vowels in a string with `_`:

```bash
echo "Linux and shell scripting are awesome!" | tr "aeiou" "_"
```

Output:

```
L_n_x _nd sh_ll scr_pt_ng _r_ _w_s_m_!
```

### Convert entire file to uppercase:

```bash
cat pets.txt | tr "[a-z]" "[A-Z]"
```

### Combine with `sort` and `uniq`:

```bash
sort pets.txt | uniq | tr "[a-z]" "[A-Z]"
```

Result:

```
CAT
DOG
GOLDFISH
PARROT
```

---

## 🪣 Extracting Data from JSON Files

You practiced extracting structured data from a JSON file using `grep` and regular expressions.

### Given JSON content in `Bitcoinprice.txt`:

```json
{
  "coin": {
    "price": 57907.78008618953,
    ...
  }
}
```

### Extract the `"price"` field:

```bash
cat Bitcoinprice.txt | grep -oE "\"price\"\s*:\s*[0-9]*\.?[0-9]*"
```

#### Explanation:

- `-o` → show only matched part
- `-E` → enable extended regex
- `\"price\"` → match `"price"`
- `\s*` → match any amount of whitespace
- `:` → match colon
- `[0-9]*\.?[0-9]*` → match numbers with optional decimal point

This gives:

```
"price" : 57907.78008618953
```

---

## 🌐 Extracting Info from URLs

You can combine `curl` or `wget` with `grep` to extract live data from web APIs or pages.

### Example: Get current Bitcoin price from an API:

```bash
curl -s https://api.coinstats.app/public/v1/coins/bitcoin | grep -oE "\"price\": *[0-9]+\.?[0-9]*"
```

Or if you have the JSON saved locally:

```bash
cat Bitcoinprice.txt | grep -oE "\"price\": *[0-9]+\.?[0-9]*"
```

---

## 📋 Summary Table: Useful Pipe Combinations

| Task                           | Command                                    |
| ------------------------------ | ------------------------------------------ | --------------- |
| Sort and deduplicate lines     | `sort file.txt                             | uniq`           |
| Replace characters in a string | `echo "text"                               | tr "from" "to"` |
| Convert text to uppercase      | `tr "[a-z]" "[A-Z]"`                       |
| Extract price from JSON        | `grep -oE "\"price\": *[0-9.]*" file.json` |
| Download and parse data        | `curl example.com/data.json                | grep pattern`   |

---

## 🧠 Why Pipes Matter

Using pipes lets you:

- **Automate complex text processing**
- **Chain small tools into powerful pipelines**
- **Extract and transform data efficiently**
- **Build custom scripts that process logs, config files, or API responses**

They’re at the heart of **Unix philosophy**: _Do one thing well, and connect it with others._

---

## ✅ Final Takeaways

| Concept             | Description                                                         |
| ------------------- | ------------------------------------------------------------------- | --------------------------------------------------- |
| **Pipes** (`        | `)                                                                  | Connect outputs of one command to inputs of another |
| **Filters**         | Tools like `grep`, `uniq`, `tr` act on streamed input               |
| **Data extraction** | Use `grep` with regex to pull values from structured text like JSON |
| **Automation**      | Combine `curl` + `grep` to extract live data from the web           |

---

# **Useful Features of the Bash Shell**

---

## **1. Introduction**

✅ **Metacharacters** – special characters with built-in meanings  
✅ **Quoting & Escaping** – control how the shell interprets commands  
✅ **I/O Redirection** – manage input and output streams  
✅ **Command Substitution** – insert results from one command into another  
✅ **Command Line Arguments** – pass values to scripts  
✅ **Running Commands in Batch or Concurrent Mode**

These tools allow for powerful automation, customization, and efficiency.

---

## **2. Metacharacters – Special Characters in Bash**

### **Definition**

Metacharacters are symbols interpreted by the shell to perform specific operations.

| Symbol | Meaning                                     | Example                                             |
| ------ | ------------------------------------------- | --------------------------------------------------- |
| `#`    | Comment (ignored by shell)                  | `# This is a comment`                               |
| `;`    | Command separator                           | `echo "Hello"; echo "World"`                        |
| `*`    | Wildcard – matches any number of characters | `ls ba*` → matches `bash`, `bar`, etc.              |
| `?`    | Single-character wildcard                   | `ls b?sh` → matches `bash`, `bosh`, but not `bsssh` |
| `\`    | Escape character                            | `echo \$1` → prints `$1` literally                  |

---

## **3. Quoting – Literal vs Interpreted Text**

### **A. Single Quotes (`'...'`)**

- Treats everything inside as **literal text**
- Ignores variable substitution and metacharacter interpretation

> Example:

```bash
echo '$HOME is /home/user'
```

Output:

```
$HOME is /home/user
```

---

### **B. Double Quotes (`"..."`)**

- Allows some **interpretation**, such as:
  - Variable expansion (`$VAR`)
  - Command substitution (`$(...)` or backticks)

> Example:

```bash
echo "$HOME is my home directory"
```

Output (if `$HOME=/home/user`):

```
/home/user is my home directory
```

---

### **C. Backslash (`\`) – Escaping Metacharacters**

Use backslash to prevent interpretation of special characters.

> Example:

```bash
echo "The cost is \$1 only"
```

Output:

```
The cost is $1 only
```

---

## **4. Input/Output (I/O) Redirection**

Used to redirect standard input, output, and error streams.

| Operator | Description                      | Example                     |
| -------- | -------------------------------- | --------------------------- |
| `>`      | Redirect output (overwrite file) | `echo "line1" > eg.txt`     |
| `>>`     | Append output to a file          | `echo "line2" >> eg.txt`    |
| `<`      | Redirect input from a file       | `wc -l < eg.txt`            |
| `2>`     | Redirect standard error          | `somecommand 2> error.log`  |
| `2>>`    | Append standard error            | `somecommand 2>> error.log` |

> Example:

```bash
echo "line1" > eg.txt
echo "line2" >> eg.txt
cat eg.txt
```

Output:

```
line1
line2
```

---

## **5. Command Substitution – Run Command Inside Another**

Allows you to run a command and use its **output as part of another command**.

### **Syntax Options**

| Syntax          | Description             |
| --------------- | ----------------------- | ---------------------------- |
| `$(command)`    | Preferred modern syntax | `echo "Current dir: $(pwd)"` |
| `` `command` `` | Older backtick syntax   | `echo "Today is `date`" `    |

> Example:

```bash
here=$(pwd)
echo "You are in: $here"
```

Output:

```
You are in: /home/user
```

---

## **6. Command Line Arguments**

When running a script, you can pass **arguments** to it using the command line.

### **Accessing Arguments in Script**

| Notation        | Description                   |
| --------------- | ----------------------------- |
| `$0`            | Name of the script itself     |
| `$1`, `$2`, ... | First, second, etc., argument |
| `$@`            | All arguments as list         |
| `$#`            | Number of arguments passed    |

> Example:

```bash
./myscript.sh arg1 arg2
```

Inside `myscript.sh`:

```bash
echo "Script name: $0"
echo "First argument: $1"
echo "Second argument: $2"
echo "All arguments: $@"
echo "Number of arguments: $#"
```

---

## **7. Running Commands Sequentially vs Concurrently**

### **A. Batch Mode – Sequential Execution**

Commands are executed **one after another**.

> Example:

```bash
sleep 2; echo "Done"
```

- `sleep 2` runs first.
- `echo "Done"` runs after it finishes.

---

### **B. Concurrent Mode – Parallel Execution**

Use `&` to run a command **in the background**.

> Example:

```bash
long_process.sh & echo "Continuing..."
```

- `long_process.sh` runs in the background.
- `echo` runs immediately without waiting.

---

## **8. Summary Table**

| Feature                  | Purpose                               | Example                                                   |
| ------------------------ | ------------------------------------- | --------------------------------------------------------- |
| **Metacharacters**       | Perform special actions               | `*`, `?`, `#`, `;`, `\`                                   |
| **Single Quotes**        | Interpret text literally              | `'text'`                                                  |
| **Double Quotes**        | Allow variable/command interpretation | `"text $VAR"`                                             |
| **Backslash**            | Escape special meaning                | `\$`, `\*`                                                |
| **Redirection**          | Control input/output                  | `>` (overwrite), `>>` (append), `<` (input), `2>` (error) |
| **Command Substitution** | Use command output in another command | `$(command)` or `` `command` ``                           |
| **Command Line Args**    | Pass values to scripts                | `script.sh arg1 arg2`                                     |
| **Batch Mode**           | Run commands sequentially             | `cmd1; cmd2`                                              |
| **Concurrent Mode**      | Run commands in parallel              | `cmd1 & cmd2`                                             |

---

## **9. Full Example: Combining Concepts**

```bash
#!/bin/bash
# This is a comment

message="Script started at $(date)"
echo "$message" > log.txt

echo "Writing to log file..." >> log.txt

# Try something that causes an error
ls /invalid_path 2> error.txt

# Print contents of files
cat log.txt
cat error.txt
```

> Output:

```
Script started at [current date]
Writing to log file...
ls: cannot access '/invalid_path': No such file or directory
```

---

## **10. Final Tips**

- Use **metacharacters** to write compact and powerful commands.
- Use **quoting** to control whether variables and wildcards get expanded.
- Use **redirection** to capture outputs or errors into files.
- Use **command substitution** to dynamically insert command results.
- Use **command line arguments** to make your scripts more flexible.
- Use **batch mode** for sequential execution, **concurrent mode** for background tasks.
- Combine these features for efficient and readable shell scripts.

---

# 🧠 **Examples of Bash Shell Features – Summary & Highlights**

In this reading, you explored several powerful features of the **Bash shell**, which are essential for writing clean, effective, and dynamic scripts.

---

## 🔤 **Metacharacters in Bash**

These characters have special meanings to the shell and help control how commands behave.

| Metacharacter | Meaning                                        |
| ------------- | ---------------------------------------------- |
| `#`           | Starts a comment (everything after is ignored) |
| `;`           | Separates multiple commands on one line        |
| `*`           | Wildcard matching any number of characters     |
| `?`           | Matches exactly one character                  |

### Examples:

```bash
# This is a comment
echo "Hello"; echo "World"  # Runs both commands
ls *.txt                      # Lists all .txt files
ls file?.txt                  # Matches file1.txt, file2.txt, etc.
```

---

## “ ” `' '` `\` **Quoting and Escaping**

Use quoting to control how the shell interprets special characters.

| Symbol | Behavior                                   |
| ------ | ------------------------------------------ |
| `\`    | Escape single character (e.g., `\$`, `\*`) |
| `" "`  | Allows variable expansion inside string    |
| `' '`  | Treats everything literally — no expansion |

### Examples:

```bash
touch file\ with\ space.txt   # Creates a file with spaces in name
echo "Today is $USER"         # Expands variables like $USER
echo 'Today is $USER'         # Prints literal "$USER"
```

---

## 📥 **Input/Output Redirection**

You can redirect input (`<`), output (`>` or `>>`), and error streams (`2>`, `2>>`) to or from files.

| Operator | Purpose                                    |
| -------- | ------------------------------------------ |
| `>`      | Redirect standard output (overwrites file) |
| `>>`     | Append standard output to file             |
| `2>`     | Redirect standard error (overwrites)       |
| `2>>`    | Append standard error                      |
| `<`      | Redirect input from a file                 |

### Examples:

```bash
ls > files.txt          # Saves ls output to files.txt
ls >> files.txt         # Appends more data
grep "error" log.txt > errors.txt  # Saves only matching lines
sort < data.txt         # Sorts content from data.txt
```

---

## 💡 **Command Substitution**

Allows you to capture and reuse command outputs as values in your scripts.

### Syntax:

- Backticks: `` `command` `` _(legacy)_
- Preferred: `$(command)` _(modern and nested-friendly)_

### Example:

```bash
here=$(pwd)
cd /tmp
cd $here
```

This lets you store and reuse results dynamically in scripts — great for automation!

---

## 📝 **Command Line Arguments**

Arguments passed to a script when it’s executed. You can access them using positional parameters.

### Example:

```bash
./myscript.sh arg1 arg2
```

Inside the script:

```bash
echo "First argument: $1"
echo "Second argument: $2"
echo "All arguments: $@"
```

### Positional Parameters:

| Variable        | Description                                 |
| --------------- | ------------------------------------------- |
| `$0`            | Script name                                 |
| `$1`, `$2`, ... | First, second, etc., command-line arguments |
| `$@`            | All arguments as list                       |
| `$#`            | Number of arguments                         |
| `$$`            | PID (Process ID) of the script              |
| `$?`            | Exit status of last command                 |

---

## 🔄 Why These Bash Features Matter

| Feature                  | Use Case                                                        |
| ------------------------ | --------------------------------------------------------------- |
| **Metacharacters**       | Pattern matching, scripting logic                               |
| **Quoting/Escaping**     | Handling filenames, strings with spaces, and special characters |
| **Redirection**          | Logging, filtering, saving output                               |
| **Command substitution** | Dynamic values, reusable scripts                                |
| **Command line args**    | Flexible scripts that behave differently based on inputs        |

---

## ✅ Real-World Examples

### 1. Save and restore directory:

```bash
current_dir=$(pwd)
cd /tmp
cd "$current_dir"
```

### 2. Log output and errors separately:

```bash
my_script.sh > output.log 2> error.log
```

### 3. Pass and use arguments in a script:

```bash
#!/bin/bash
echo "Script name: $0"
echo "First argument: $1"
echo "Number of arguments: $#"
```

Run it:

```bash
chmod +x myscript.sh
./myscript.sh Hello World!
```

Output:

```
Script name: ./myscript.sh
First argument: Hello
Number of arguments: 2
```

---

## 🛠️ Best Practices

- Always quote variables to avoid word splitting:
  ```bash
  echo "$USER"
  ```
- Use `$(...)` over backticks for better readability and nesting
- Use `>` carefully — it **overwrites** by default
- Use `>>` to **append** instead
- Include comments using `#` for clarity and documentation

---

Great job learning these key Bash shell features!  
You now know how to:

- Control character interpretation with **quoting**
- Manipulate input/output with **redirection**
- Make scripts **dynamic** with **command substitution**
- Build **flexible scripts** that accept **command-line arguments**

---

# 🧠 Exercise 1 – Using Conditional Statements and Logical Operators in Bash

In this exercise, you learned how to use **conditional logic** in a Bash script — specifically using the `if`, `elif`, and `else` structure.

You built a script that:

- Asks the user a yes/no question
- Stores their response
- Responds differently depending on whether they typed `"y"` or `"n"`
- Handles invalid input gracefully

This is a foundational skill for writing **interactive shell scripts**.

---

## ✅ Step-by-Step Breakdown

### 🔹 1.1 Create a New Bash Script

#### Create and make it executable:

```bash
echo '#!/bin/bash' > conditional_script.sh
chmod u+x conditional_script.sh
```

> This creates a new script file with execute permissions for the owner.

---

### 🔹 1.2 Prompt the User and Store Their Response

#### Add code to ask a question and store input:

```bash
#!/bin/bash
echo 'Are you enjoying this course so far?'
echo -n "Enter \"y\" for yes, \"n\" for no: "
read response
```

- `echo` prints messages to the screen
- `echo -n` prevents a newline after printing (keeps prompt on same line)
- `read response` stores user input in a variable called `response`

---

### 🔹 1.3 Use a Conditional Block Based on User Input

#### Add the conditional logic:

```bash
if [ "$response" == "y" ]; then
    echo "I'm pleased to hear you are enjoying the course!"
    echo "Your feedback regarding what you have been enjoying would be most welcome!"

elif [ "$response" = "n" ]; then
    echo "I'm sorry to hear you are not enjoying the course."
    echo "Your feedback regarding what we can do to improve the learning experience"
    echo "for this course would be greatly appreciated!"

else
    echo "Your response must be either 'y' or 'n'."
    echo "Please re-run the script to try again."
fi
```

### 📝 Explanation:

| Feature                          | Description                                             |
| -------------------------------- | ------------------------------------------------------- |
| `[ ... ]`                        | Test condition syntax                                   |
| `==` or `=`                      | String comparison operators                             |
| `if/elif/else/fi`                | Conditional block                                       |
| Quoted variables (`"$response"`) | Prevents errors if variable is empty or contains spaces |

---

## 🧪 Sample Outputs

### If user enters `y`:

```
I'm pleased to hear you are enjoying the course!
Your feedback regarding what you have been enjoying would be most welcome!
```

### If user enters `n`:

```
I'm sorry to hear you are not enjoying the course.
Your feedback regarding what we can do to improve the learning experience
for this course would be greatly appreciated!
```

### If user enters something else:

```
Your response must be either 'y' or 'n'.
Please re-run the script to try again.
```

---

## 📋 Summary Table

| Task                | Command                          |
| ------------------- | -------------------------------- |
| Create a new script | `echo '#!/bin/bash' > script.sh` |
| Make it executable  | `chmod u+x script.sh`            |
| Read user input     | `read variable_name`             |
| Conditional logic   | `if [ condition ]; then ... fi`  |
| Compare strings     | `[ "$var" == "value" ]`          |
| Handle default case | `else`                           |
| Run your script     | `./script.sh`                    |

---

## 🛠️ Real-World Uses of Conditional Logic

Conditional statements like this are used for:

- Validating user input in setup scripts
- Checking system conditions before performing actions
- Controlling flow in automation tools
- Writing interactive CLI apps in Bash

---

## 💡 Pro Tips

- Always quote variables to avoid unexpected behavior:
  ```bash
  if [ "$response" = "y" ]; then
  ```
- Use `[[ ... ]]` instead of `[ ... ]` for advanced features (like regex matching) in modern Bash
- You can simplify responses by converting input to lowercase:
  ```bash
  response="${response,,}"
  ```

---

# 🧮 Exercise 2 – Performing Basic Math and Logical Comparisons in Bash

In this hands-on exercise, you created a **Bash script** that:

- Accepts two integers from the user
- Performs basic math: addition and multiplication
- Compares results using **numeric conditional operators**
- Outputs comparison results to the user

This helps you understand how to work with **arithmetic operations**, **variables**, and **numerical logic** in shell scripting.

---

## ✅ Step-by-Step Breakdown

### 🔹 2.1 Create a Bash Script for Input and Calculations

You created a script that takes two integers as input:

```bash
#!/bin/bash
echo -n "Enter an integer: "
read n1
echo -n "Enter another integer: "
read n2
```

Then calculated:

```bash
sum=$(($n1 + $n2))
product=$(($n1 * $n2))
```

And printed the result:

```bash
echo "The sum of $n1 and $n2 is $sum"
echo "The product of $n1 and $n2 is $product."
```

> 📝 The syntax `$(())` is used in Bash for **arithmetic expansion** — it evaluates mathematical expressions.

---

### 🔹 2.2 Add Logic to Compare Results

You added an `if-elif-else` block to compare the **sum** and **product**:

```bash
if [ $sum -lt $product ]; then
   echo "The sum is less than the product."
elif [[ $sum == $product ]]; then
   echo "The sum is equal to the product."
elif [ $sum -gt $product ]; then
   echo "The sum is greater than the product."
fi
```

> ⚠️ Note: You used `-lt`, `-gt`, and `==` for numeric comparisons.

| Operator | Meaning               |
| -------- | --------------------- |
| `-lt`    | Less than             |
| `-le`    | Less than or equal    |
| `-eq`    | Equal                 |
| `-ge`    | Greater than or equal |
| `-gt`    | Greater than          |

---

## 🧪 Sample Output Scenarios

### Case 1: Sum < Product

```
Enter an integer: 3
Enter another integer: 5
The sum of 3 and 5 is 8
The product of 3 and 5 is 15.
The sum is less than the product.
```

### Case 2: Sum == Product

```
Enter an integer: 2
Enter another integer: 2
The sum of 2 and 2 is 4
The product of 2 and 2 is 4.
The sum is equal to the product.
```

### Case 3: Sum > Product

```
Enter an integer: 5
Enter another integer: 1
The sum of 5 and 1 is 6
The product of 5 and 1 is 5.
The sum is greater than the product.
```

---

## 📋 Summary Table

| Task                           | Command                            |
| ------------------------------ | ---------------------------------- |
| Read user input                | `read var_name`                    |
| Perform arithmetic             | `$(($n1 + $n2))`, `$(($n1 * $n2))` |
| Print formatted output         | `echo "Result: $result"`           |
| Compare numbers (less than)    | `[ $a -lt $b ]`                    |
| Compare numbers (equal)        | `[ $a -eq $b ]`                    |
| Compare numbers (greater than) | `[ $a -gt $b ]`                    |

---

## 💡 Pro Tips

- Always use spaces around operators:

  ```bash
  # Correct
  if [ $a -gt $b ]

  # Incorrect
  if [$a-gt$b] ❌
  ```

- Validate input (optional enhancement):

  ```bash
  if ! [[ "$n1" =~ ^[0-9]+$ && "$n2" =~ ^[0-9]+$ ]]; then
      echo "Please enter valid integers."
      exit 1
  fi
  ```

  This checks if both inputs are integers before doing calculations.

- Use `let` for inline assignments:

  ```bash
  let sum=n1+n2
  ```

- Or use alternative syntax:
  ```bash
  (( sum = n1 + n2 ))
  ```

---

## 🤓 Why This Matters

You're now able to:

- Handle **user input**
- Perform **basic math** in Bash scripts
- Use **conditional logic** based on numerical comparisons
- Write more advanced scripts that can handle **dynamic user data**

These skills form the foundation for writing **interactive**, **logical**, and **automated** command-line tools in Linux.

---

# 🧮 Exercise 3 – Using Arrays and For Loops in Bash Scripts

In this exercise, you learned how to:

- **Download and inspect a CSV file**
- **Extract columns into arrays using `cut`**
- **Create a new array by performing arithmetic on other arrays**
- **Combine data back into a new CSV report using `paste`**

This is a powerful demonstration of how **Bash scripting can be used for basic data processing** — especially when working with structured text files like CSVs.

---

## ✅ Step-by-Step Breakdown

### 🔹 3.1 Download the CSV File

You downloaded a sample dataset:

```bash
csv_file="https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-LX0117EN-SkillsNetwork/labs/M3/L2/arrays_table.csv"
wget $csv_file
```

This gave you a file named `arrays_table.csv`.

---

### 🔹 3.2 View the CSV Content

You inspected it with:

```bash
cat arrays_table.csv
```

Example content:

```
column_0,column_1,column_2
A,10,50
B,20,40
C,30,30
D,40,20
E,50,10
```

Each line represents a row, and each column holds different types of data.

---

### 🔹 3.3 Parse Columns into Arrays

You extracted each column using `cut` and stored them in **Bash arrays**:

```bash
column_0=($(cut -d "," -f 1 $csv_file))
column_1=($(cut -d "," -f 2 $csv_file))
column_2=($(cut -d "," -f 3 $csv_file))
```

> 💡 This uses **command substitution** (`$(...)`) to populate arrays from command output.

Then you printed one of them:

```bash
echo "${column_0[@]}"
```

Output:

```
column_0 A B C D E
```

Note: The first element is the header (`column_0`, `column_1`, etc.)

---

### 🔹 3.4 Create a New Array as a Difference Between Two Columns

You created a new array, `column_3`, which stores the difference between `column_2` and `column_1`.

#### Initialize with header:

```bash
column_3=("column_3")
```

#### Count lines in the CSV:

```bash
nlines=$(cat $csv_file | wc -l)
```

#### Loop through rows and calculate:

```bash
for ((i=1; i<$nlines; i++)); do
  column_3[$i]=$((column_2[i] - column_1[i]))
done
```

Then you printed the result:

```bash
echo "${column_3[@]}"
```

Example output:

```
column_3 40 20 0 -20 -40
```

> ⚠️ Bash supports only integer math — so this works perfectly for numeric columns.

---

### 🔹 3.5 Combine New Column with Original CSV

You wrote the new column to a temporary file:

```bash
echo "${column_3[0]}" > column_3.txt
for ((i=1; i<nlines; i++)); do
  echo "${column_3[$i]}" >> column_3.txt
done
```

Then merged it with the original CSV:

```bash
paste -d "," $csv_file column_3.txt > report.csv
```

Now `report.csv` contains all four columns!

Example output:

```
column_0,column_1,column_2,column_3
A,10,50,40
B,20,40,20
C,30,30,0
D,40,20,-20
E,50,10,-40
```

---

## 📋 Summary Table

| Task                     | Command                                 |
| ------------------------ | --------------------------------------- |
| Download file            | `wget URL`                              |
| View file contents       | `cat arrays_table.csv`                  |
| Extract column 1         | `cut -d "," -f 1`                       |
| Store in array           | `arr=($(cut ...))`                      |
| Loop over elements       | `for ((i=1; i < $nlines; i++))`         |
| Perform arithmetic       | `$((col2 - col1))`                      |
| Write array to file      | `echo "value" >> file.txt`              |
| Merge files side-by-side | `paste -d "," file1 file2 > output.csv` |

---

## 🧠 Why This Matters

This exercise introduced you to:

- **Array manipulation** in Bash
- **Looping through indexed elements**
- Performing **basic arithmetic**
- Working with **CSV data** via shell commands

These skills are useful for:

- Processing logs or flat-file databases
- Automating simple data transformations
- Building lightweight reporting tools without external dependencies

---

## 💡 Pro Tips

- Use `${array[@]}` to access all elements in an array
- Remember array indexing starts at 0
- Always quote variables to avoid issues:
  ```bash
  echo "${column_0[@]}"
  ```
- You can validate that arrays have the same length before merging:
  ```bash
  [[ ${#column_0[@]} -eq ${#column_3[@]} ]] && echo "Arrays match in size"
  ```

---

## 🛠️ Real-World Uses

| Use Case            | Example                                                  |
| ------------------- | -------------------------------------------------------- |
| Log analysis        | Extract timestamps, process times, and compute durations |
| Data transformation | Add computed fields to CSV reports                       |
| Batch operations    | Process multiple files in order                          |
| Automation          | Generate summaries from system metrics                   |

---

# 🎉 **Conclusion – Great Job Completing the Lab!**

You've successfully completed a hands-on lab that dives into **advanced Bash scripting logic** — and you're now equipped with powerful tools to write more intelligent, dynamic, and efficient scripts.

---

## ✅ What You Learned

Here’s what you accomplished in this lab:

| Concept                     | Tool / Technique                                                              |
| --------------------------- | ----------------------------------------------------------------------------- |
| **Conditional Logic**       | `if`, `elif`, `else` blocks for decision-making                               |
| **Logical Operators**       | Used `-lt`, `-gt`, `-eq` for numeric comparisons                              |
| **Mathematical Operations** | Performed addition and subtraction using `$(( ... ))`                         |
| **Arrays**                  | Stored and accessed data like lists (`column_0=($(cut ...))`)                 |
| **For Loops**               | Repeated tasks efficiently using indexed loops                                |
| **Data Processing**         | Read from and wrote structured CSV data using `cut`, `paste`, and redirection |

---

## 🧠 Why This Matters

The skills you practiced are not just academic — they’re essential for:

- **Automation**: Build scripts that make decisions based on input
- **Data Wrangling**: Parse and transform structured text files (like logs or CSVs)
- **Reporting**: Generate clean output files dynamically from raw data
- **Scripting Efficiency**: Know when to use arrays vs. direct file writing

> 💡 Even though Bash isn’t a full-fledged programming language like Python, it's incredibly useful for quick automation, system management, and integration tasks.

---

## 🛠️ Real-World Applications

Here’s how these concepts apply beyond the lab:

| Skill                  | Use Case                                                         |
| ---------------------- | ---------------------------------------------------------------- |
| Conditional statements | Validate user input, check system status before running commands |
| Arithmetic operations  | Monitor thresholds, calculate durations                          |
| Arrays and loops       | Batch process files, manage large datasets                       |
| CSV manipulation       | Generate reports, analyze log files                              |
| Script modularity      | Break complex logic into reusable parts (coming soon!)           |

---

# **Scheduling Jobs Using Cron**

Cron is a powerful tool in Linux/Unix systems that lets you **schedule jobs (commands or scripts)** to run automatically at specific times.

### Key Concepts:

- **Cron**: The system utility that runs scheduled tasks.
- **Crond**: The background service (daemon) that checks and runs cron jobs.
- **Crontab**:
  - Short for "cron table" — a file that stores your scheduled jobs.
  - Also a command (`crontab`) used to edit, view, or remove these schedules.

### Basic Commands:

- `crontab -e` : Opens the editor to **edit** your cron jobs.
- `crontab -l` : **Lists** all current cron jobs.
- `crontab -r` : **Removes** all cron jobs (use with caution).

### Cron Syntax:

Each job has a line in the crontab file with this format:

```
*     *     *     *     *    command_to_run
|_____|_____|_____|_____|_____|
min   hour   day   month   day of week
```

You can use:

- Numbers (like `0`, `15`, `7`)
- Asterisks (`*`) as wildcards meaning “any”
- Commas (`,`) for multiple values
- Hyphens (`-`) for ranges

### Example:

```
30 15 * * 0 echo $(date) >> sundays.txt
```

This runs at **15:30 every Sunday**, appending the current date to `sundays.txt`.

### Tips:

- Use `crontab -e` to add/edit jobs.
- Save and exit the editor to activate changes.
- Keep it simple and test your scripts before scheduling.

Now you can automate routine tasks like backups, data loads, and more!

---

# 🕒 Exercise 1 - Understand `crontab` File Syntax

In this exercise, you learned the basics of **cron**, a time-based job scheduler in Linux, and how to structure entries in the **crontab file**.

---

## 🎯 Learning Objectives Recap

After completing this exercise, you can now:

✅ Explain what **Cron** is  
✅ Describe the purpose of a **crontab** file  
✅ Understand and write the **five time-and-date fields** that define when a task runs  
✅ Use proper syntax to schedule commands at specific times

---

## 🧠 What Is Cron?

- **Cron** is a background system process (daemon) used to execute tasks automatically at set times.
- It’s commonly used for:
  - Backups
  - Log rotation
  - System monitoring
  - Scripted maintenance tasks

---

## 📄 What Is a Crontab File?

- A **crontab** (short for "cron table") is a configuration file that defines scheduled jobs for your user account.
- Each line represents one job with a specific schedule.

### 🔁 How to Edit It

```bash
crontab -e
```

### 👀 How to View It

```bash
crontab -l
```

---

## ⏰ Crontab Time Fields

Each cron job has **five time fields**, followed by the command to run.

### Format:

```
minute hour day month weekday command_to_execute
```

| Field     | Description                      | Allowed Values          |
| --------- | -------------------------------- | ----------------------- |
| `minute`  | Minute of the hour               | `0–59`                  |
| `hour`    | Hour of the day (24-hour format) | `0–23` (`0` = midnight) |
| `day`     | Day of the month                 | `1–31`                  |
| `month`   | Month of the year                | `1–12`                  |
| `weekday` | Day of the week                  | `0–6` (`0` = Sunday)    |

> All fields must be separated by **spaces or tabs**  
> You cannot use spaces inside a field — each field is a single value or expression

---

## 🧩 Special Characters in Crontab

| Symbol | Meaning        | Example                                           |
| ------ | -------------- | ------------------------------------------------- |
| `*`    | Any value      | `* * * * *` → every minute                        |
| `,`    | List separator | `0 8 * * 1,5` → 8:00 AM on Monday and Friday      |
| `-`    | Range          | `0 0 1-5 * *` → runs from 1st to 5th of the month |
| `/`    | Step values    | `*/10 * * * *` → every 10 minutes                 |

---

## ✅ Example Entries

| Schedule                         | Crontab Line                      |
| -------------------------------- | --------------------------------- |
| Every minute                     | `* * * * * /path/to/script.sh`    |
| Daily at 2:00 AM                 | `0 2 * * * /path/to/script.sh`    |
| Every Monday at 1:30 AM          | `30 1 * * 1 /path/to/script.sh`   |
| First of every month at midnight | `0 0 1 * * /path/to/script.sh`    |
| Every 15 minutes                 | `*/15 * * * * /path/to/script.sh` |

---

## 📝 Sample Entry Breakdown

```bash
0 21 * * * echo "Welcome to cron" >> /tmp/echo.txt
```

This means:

- At **minute 0**
- At **hour 21** (9:00 PM)
- On **any day of the month**
- In **any month**
- On **any day of the week**
- Run: `echo "Welcome to cron" >> /tmp/echo.txt`

---

## 🛠️ Why This Matters

Understanding crontab syntax is key to:

- Automating repetitive tasks
- Ensuring scripts run reliably without manual input
- Managing system health and performance over time

This knowledge gives you the ability to build powerful automation workflows directly from the terminal.

---

## ✅ Summary Table

| Task                          | Command                        |
| ----------------------------- | ------------------------------ |
| Edit current user’s crontab   | `crontab -e`                   |
| View current user’s crontab   | `crontab -l`                   |
| Remove current user’s crontab | `crontab -r`                   |
| System-wide cron files        | `/etc/crontab`, `/etc/cron.d/` |

---

## 🛠️ Real-World Examples

| Schedule                              | Crontab Entry                           |
| ------------------------------------- | --------------------------------------- |
| Every day at 3:00 AM                  | `0 3 * * * /scripts/daily_backup.sh`    |
| Every 5 minutes                       | `*/5 * * * * /scripts/check_health.sh`  |
| At 12:00 PM on the 1st of every month | `0 12 1 * * /scripts/monthly_report.sh` |
| Every Saturday at 1:30 AM             | `30 1 * * 6 /scripts/weekly_cleanup.sh` |

---

## 💡 Pro Tips

- Always test your scripts manually before adding them to `crontab`.
- Use absolute paths for scripts in cron (e.g., `/home/user/scripts/backup.sh`)
- Redirect output to a log file or `/dev/null` to avoid email spam:
  ```bash
  0 2 * * * /scripts/log_system_stats.sh >> /var/log/system_stats.log 2>&1
  ```

---

# 📋 Exercise 2 – List Cron Jobs

In this exercise, you learned how to **view your current cron jobs** using the `crontab -l` command.

This is an essential step when managing scheduled tasks — whether you're checking what's already set up or preparing to add new automated jobs.

---

## ✅ Step-by-Step Breakdown

### 🔹 Open a New Terminal

You clicked:

- **Terminal → New Terminal** (from the menu bar)

A new terminal window opened at the bottom of the screen.

---

### 🔹 View Current User’s Crontab

You ran:

```bash
crontab -l
```

This command **lists** all scheduled jobs for the current user.

> Output example:

```
no crontab for theia
```

This message simply means that no cron jobs have been defined yet — which is normal in a fresh environment.

---

## 🧠 Why This Matters

Even if there were no existing cron jobs, knowing how to **list** them is critical for:

- Verifying scheduled scripts or commands
- Debugging issues with automation
- Ensuring system maintenance tasks are running
- Avoiding duplicate entries when adding new jobs

---

## 📌 Summary Table: Common Crontab Commands

| Task                                    | Command      |
| --------------------------------------- | ------------ |
| **List current user’s cron jobs**       | `crontab -l` |
| **Edit current user’s cron jobs**       | `crontab -e` |
| **Remove all current user’s cron jobs** | `crontab -r` |

---

## 💡 Pro Tips

- If you're using `sudo`, you may be editing a different crontab (system-wide):

  ```bash
  sudo crontab -l
  ```

- Always use `crontab -l` before making changes — it shows what’s already scheduled.

- Save output to a file for backup:
  ```bash
  crontab -l > my_crontab_backup.txt
  ```

---

# 🧑‍💻 Exercise 3 – Add a Job in the Crontab File

In this exercise, you learned how to **schedule recurring tasks** using the `crontab` file. You added two cron jobs:

- One that echoes a message daily at 9:00 PM
- Another that runs a custom script (`diskusage.sh`) at **midnight every day**, logging output to a file.

This is an essential skill for automating repetitive system tasks like:

- Running backups
- Monitoring disk usage
- Logging events
- Sending reports

---

## ✅ Step-by-Step Summary

### 🔹 3.1 Add a Daily Cron Job

You opened your crontab file with:

```bash
crontab -e
```

Then added this line:

```bash
0 21 * * * echo "Welcome to cron" >> /tmp/echo.txt
```

#### What it means:

| Field   | Value | When                   |
| ------- | ----- | ---------------------- |
| Minute  | `0`   | At the top of the hour |
| Hour    | `21`  | At 9:00 PM             |
| Day     | `*`   | Every day              |
| Month   | `*`   | Every month            |
| Weekday | `*`   | Any day                |

> This appends `"Welcome to cron"` to `/tmp/echo.txt` every night at 9 PM.

After saving with:

- **Ctrl + X**
- Pressed **Y** to confirm
- Pressed **Enter** to exit

You verified the job was saved by listing the crontab:

```bash
crontab -l
```

---

### 🔹 3.2 Schedule a Shell Script

You created a Bash script called `diskusage.sh`:

```bash
#!/bin/bash
# print current date/time
date
# print disk usage stats
df -h
```

Then made it executable and tested it:

```bash
chmod u+x diskusage.sh
./diskusage.sh
```

It should have printed:

- Current time (via `date`)
- Disk usage in human-readable format (via `df -h`)

---

### 🔁 Automate It with Cron

You scheduled the script to run every day at **midnight**:

```bash
0 0 * * * /home/project/diskusage.sh >> /home/project/diskusage.log
```

> ⚠️ Make sure the path to the script is correct — use absolute paths!

Each day at midnight, the script will:

- Print the current timestamp
- Show disk usage statistics
- Append the output to `/home/project/diskusage.log`

This helps track disk usage over time and monitor system behavior automatically.

---

## 📋 Summary Table

| Task                       | Command                                      |
| -------------------------- | -------------------------------------------- |
| Open crontab editor        | `crontab -e`                                 |
| List all cron jobs         | `crontab -l`                                 |
| Create and edit script     | Use File > New File > Save as `diskusage.sh` |
| Make script executable     | `chmod u+x diskusage.sh`                     |
| Run script manually        | `./diskusage.sh`                             |
| Schedule job at 9 PM daily | `0 21 * * * command`                         |
| Schedule job at midnight   | `0 0 * * * command`                          |
| Append output to log file  | `>> /path/to/logfile`                        |

---

## 🕒 Cron Timing Quick Reference

| Time Field | Description | Example                        |
| ---------- | ----------- | ------------------------------ |
| minute     | 0–59        | `0` = top of the hour          |
| hour       | 0–23        | `21` = 9:00 PM, `0` = midnight |
| day        | 1–31        | `*` = every day of the month   |
| month      | 1–12        | `*` = every month              |
| weekday    | 0–6 (Sun=0) | `*` = any day of the week      |

---

## 🧠 Why This Matters

By scheduling scripts with cron:

- You automate **repetitive tasks**
- You ensure important logs and checks happen **without manual input**
- You build **monitoring systems** that help maintain stability and performance

These are foundational skills for DevOps, system administration, and automation workflows.

---

## 💡 Pro Tips

- Always test your script before adding to cron:
  ```bash
  ./diskusage.sh
  ```
- Use full (absolute) paths in cron:
  ```bash
  /home/project/diskusage.sh
  ```
- Redirect both stdout and stderr for debugging:
  ```bash
  0 0 * * * /home/project/diskusage.sh >> /home/project/diskusage.log 2>&1
  ```
- Check system cron logs if your job doesn’t run:
  ```bash
  sudo grep CRON /var/log/syslog
  ```

---

# 🗑️ Exercise 4 – Remove the Current Crontab

In this exercise, you learned how to **remove all scheduled cron jobs** for your user using the `crontab -r` command.

This is a powerful and irreversible action — especially on production systems — so it’s important to understand when and how to use it safely.

---

## ✅ Step-by-Step Breakdown

### 🔹 Remove Your Current Crontab

You ran:

```bash
crontab -r
```

This command **removes** the current user's entire crontab file — all scheduled jobs are deleted.

> ⚠️ **Caution**: This action cannot be undone unless you have a backup!

---

### 🔍 Verify That the Crontab Was Removed

After deletion, you verified with:

```bash
crontab -l
```

The expected output is:

```
no crontab for theia
```

This confirms that no cron jobs are currently scheduled for this user.

---

## 📋 Summary Table

| Task                   | Command                 |
| ---------------------- | ----------------------- |
| Remove all cron jobs   | `crontab -r`            |
| List current cron jobs | `crontab -l`            |
| Restore from backup    | `crontab my_backup.txt` |

---

## 🧠 Why This Matters

Knowing how to remove or reset your crontab is useful in several scenarios:

- Cleaning up old or unused jobs
- Troubleshooting issues with scheduled tasks
- Resetting your environment during development
- Avoiding conflicts when re-scheduling scripts

Just remember:

> ❗ On live servers, always back up your crontab before removing it.

---

## 💡 Pro Tips

- Back up your crontab before deleting:

  ```bash
  crontab -l > my_crontab_backup.txt
  ```

- Restore from backup if needed:

  ```bash
  crontab my_crontab_backup.txt
  ```

- Remove only specific lines (instead of all) by editing:

  ```bash
  crontab -e
  ```

- Use `sudo` for system-wide cron jobs:
  ```bash
  sudo crontab -r -u username
  ```

---

# 🛠️ **Practice Exercises – Scheduling with Cron**

Here's a clean and detailed breakdown of the practice exercise you're working on:

---

## 🔹 **1. Create a cron job that runs `date >> /tmp/everymin.txt` every minute**

### 💡 Hint:

Use the crontab syntax:

````
*     *     *     *     *    command_to_run
|     |     |     |     |
minute hour  day  month weekday

To run something **every minute**, all five time fields should be `*`, or you can use `*` for just the minute field and set the rest to `*`.

---

### ✅ **Solution:**

#### Step 1: Open your crontab file in edit mode:
```bash
crontab -e
````

#### Step 2: Add the following line at the end of the file:

```bash
* * * * * date >> /tmp/everymin.txt
```

This means:

- Run the `date` command every minute
- Append (`>>`) the output to `/tmp/everymin.txt`

#### Step 3: Save and exit

- Press `Ctrl + X` (if using Nano)
- Type `y` to confirm changes
- Press `Enter` to save to the same file

---

### 🧪 What This Does:

Every minute, the current system date and time will be appended to `/tmp/everymin.txt`.

Example entry in `/tmp/everymin.txt`:

```
Sat Apr 5 10:00:00 UTC 2025
```

After one minute:

```
Sat Apr 5 10:01:00 UTC 2025
```

---

## 📋 Summary Table

| Task                             | Command                               |
| -------------------------------- | ------------------------------------- |
| Open crontab editor              | `crontab -e`                          |
| Schedule job every minute        | `* * * * * command`                   |
| Append date to file every minute | `* * * * * date >> /tmp/everymin.txt` |
| Check if job is added            | `crontab -l`                          |
| View log file content            | `cat /tmp/everymin.txt`               |

---

## 🧠 Why This Matters

This simple example demonstrates how you can use cron to:

- Log data over time
- Monitor system events
- Automate repetitive tasks like backups, health checks, and more

You can easily expand this idea to log other useful information:

```bash
* * * * * df -h >> /tmp/everymin.txt
* * * * * free -h >> /tmp/everymin.txt
```

---

# 🎉 **Summary – Mastering Cron Jobs in Linux**

Great job completing this hands-on lab! You've now learned how to manage scheduled tasks using **cron**, one of the most powerful tools for automation in Linux.

---

## 🔧 What You Learned

Here’s a quick recap of what you practiced in this lab:

| Task                      | Command      |
| ------------------------- | ------------ |
| ✅ View current cron jobs | `crontab -l` |
| ✏️ Edit your crontab file | `crontab -e` |
| 🗑️ Remove all cron jobs   | `crontab -r` |

---

## 🕒 Crontab Syntax Reminder

Each line in the crontab file follows this structure:

```
minute hour day month weekday command_to_execute
```

Example:

```bash
* * * * * echo "Hello" >> /tmp/output.txt
```

You used this format to schedule recurring tasks like logging system time and disk usage.

---

## 📌 Best Practices & Tips

- Always **test scripts manually** before scheduling them with cron.
- Use **absolute paths** in cron — it doesn't know about your current directory!
- Redirect output for logging or debugging:
  ```bash
  0 0 * * * /home/project/script.sh >> /home/project/output.log 2>&1
  ```
- **Back up** your crontab before editing or removing:
  ```bash
  crontab -l > my_crontab_backup.txt
  ```

---

## 💡 Real-World Automation Ideas

Now that you understand cron, try automating:

- Daily backups
- System health checks (CPU, memory, disk)
- Log rotation
- Sending automated reports or emails
- Updating repositories or checking software versions

---

# 📄 Module 3 Cheat Sheet – Introduction to Shell Scripting

This cheat sheet summarizes all the essential **Bash scripting** and **task automation** concepts covered in this module. Keep it handy for quick reference while writing scripts or scheduling jobs.

---

## 🐚 **Basic Bash Script Setup**

| Task                           | Command               |
| ------------------------------ | --------------------- |
| Shebang line (start of script) | `#!/bin/bash`         |
| Find path to interpreter       | `which bash`          |
| Make script executable         | `chmod u+x script.sh` |
| Run a script                   | `./script.sh`         |

---

## 🔗 **Pipes & Filters**

| Task                                            | Command                   |
| ----------------------------------------------- | ------------------------- | --------- | ----- |
| Pipe output from one command to another         | `command1                 | command2` |
| View first 20 lines of `man ls`                 | `man ls                   | head -20` |
| Extract column 1 from CSV and remove duplicates | `cut -d "," -f1 names.csv | sort      | uniq` |

---

## 💬 **Shell and Environment Variables**

| Task                               | Command                        |
| ---------------------------------- | ------------------------------ |
| List all shell variables           | `set`                          |
| Define a variable                  | `my_planet=Earth`              |
| Display variable value             | `echo $my_planet`              |
| Read user input into a variable    | `read first_name`              |
| List environment variables         | `env`                          |
| Export variable to child processes | `export my_planet`             |
| Assign and export in one line      | `export my_galaxy='Milky Way'` |

---

## ⌨️ **Metacharacters & Special Symbols**

| Symbol    | Purpose                                           |
| --------- | ------------------------------------------------- |
| `#`       | Start of comment or special directives            |
| `;`       | Separate multiple commands on one line            |
| `*`       | Wildcard — match any number of characters         |
| `?`       | Match exactly one character                       |
| `\`       | Escape special meaning of next character          |
| `' '`     | Literal interpretation — no variable expansion    |
| `" "`     | Interpret metacharacters like `$`, but not others |
| `<` / `>` | Input / Output redirection                        |

---

## 📥 **Input/Output Redirection**

| Task                            | Command                          |
| ------------------------------- | -------------------------------- | ------------------- |
| Redirect output, overwrite file | `echo 'Hello' > hello.txt`       |
| Append output to file           | `echo 'New line' >> hello.txt`   |
| Redirect standard error         | `bad_command 2> error.log`       |
| Append standard error           | `bad_command 2>> error.log`      |
| Send file content as input      | `tr "[a-z]" "[A-Z]" < input.txt` |
| Same using pipe                 | `cat input.txt                   | tr "[a-z]" "[A-Z]"` |

---

## 💡 **Command Substitution**

| Task                      | Syntax                         |
| ------------------------- | ------------------------------ |
| Store date in variable    | `THE_PRESENT=$(date)`          |
| Use substitution directly | `echo "Current time: $(date)"` |

---

## 📎 **Command Line Arguments**

| Usage                          | Example         |
| ------------------------------ | --------------- |
| Access arguments inside script | `$1`, `$2`, ... |
| Number of arguments            | `$#`            |
| All arguments as list          | `$@`            |
| Script name                    | `$0`            |

Example:

```bash
if [[ $# == 2 ]]; then
  echo "Exactly 2 arguments provided"
fi
```

---

## ⏱️ **Scheduling Jobs with Cron**

| Task                       | Command                                     |
| -------------------------- | ------------------------------------------- |
| Open crontab editor        | `crontab -e`                                |
| List current cron jobs     | `crontab -l`                                |
| Remove all cron jobs       | `crontab -r`                                |
| Every Sunday at 6 PM       | `15 18 * * 0 date >> sundays.txt`           |
| First minute of each month | `1 0 1 * * ./My_Shell_Script.sh`            |
| Daily backup at 3 AM       | `0 3 * * * tar -cvf /backup/home.tar /home` |

---

## ❓ **Conditionals in Bash**

### Basic `if` syntax:

```bash
if [[ $# == 2 ]]; then
  echo "Two arguments given"
else
  echo "Not two arguments"
fi
```

### Logical Operators:

- **AND**: `&&`
  ```bash
  if [ condition1 ] && [ condition2 ]
  ```
- **OR**: `||`
  ```bash
  if [ condition1 ] || [ condition2 ]
  ```

---

## ➕ **Arithmetic Operations**

| Operation      | Syntax              |
| -------------- | ------------------- |
| Addition       | `echo $((3 + 2))`   |
| Subtraction    | `echo $((10 - 5))`  |
| Multiplication | `echo $((4 * 5))`   |
| Division       | `echo $((10 / 3))`  |
| Negation       | `echo $((-1 * -2))` |

Use inside scripts or one-liners to perform basic math in Bash.

---

## 🧮 **Arrays in Bash**

| Task                 | Command                                           |
| -------------------- | ------------------------------------------------- |
| Declare array        | `my_array=(1 2 "three" "four" 5)`                 |
| Add item to array    | `my_array+="six"`                                 |
| Load file into array | `my_array=($(cat column.txt))`                    |
| Loop through array   | `for item in ${my_array[@]}; do echo $item; done` |
| Access by index      | `${my_array[0]}`                                  |
| Get array size       | `${#my_array[@]}`                                 |

---

## 🔁 **For Loops in Bash**

### Loop over range:

```bash
for i in {0..5}; do
    echo "Iteration $i"
done
```

### Loop through array items:

```bash
for item in ${my_array[@]}; do
    echo $item
done
```

### Loop with indexing:

```bash
for ((i=0; i<${#my_array[@]}; i++)); do
    echo ${my_array[$i]}
done
```

---

## 🛠️ Pro Tips

- Always quote your variables:
  ```bash
  echo "$HOME"
  ```
- Use `$(...)` instead of backticks for better readability
- Prefer `[[ ... ]]` over `[ ... ]` for safer comparisons
- Use `crontab -l > backup.txt` before editing or removing scheduled jobs
- Combine pipes and filters to process data efficiently

---

# 🎉 **Summary & Highlights – Shell Scripting Essentials**

Great job completing this module! You’ve now built a strong foundation in **Bash shell scripting**, **command chaining**, and **task automation**.

Here’s a quick recap of what you’ve learned:

---

## 🧾 Key Concepts Covered

| Concept                                | Description                                                                          |
| -------------------------------------- | ------------------------------------------------------------------------------------ | ------------------------------ | ----------------- |
| **Shell Scripts**                      | Programs that start with `#!/bin/bash` and are interpreted, not compiled             |
| **Shebang Line**                       | `#!/bin/bash` — tells the system which interpreter to use                            |
| **Filters + Pipes**                    | Commands like `sort`, `cut`, `uniq` can be chained using `                           | ` for powerful data processing |
| **Shell Variables**                    | Temporary storage inside a script: `my_var=value`                                    |
| **Environment Variables**              | Available to child processes; exported using `export`                                |
| **Metacharacters**                     | Special characters like `*`, `?`, `#`, and `;` used by the shell for logic           |
| **Quoting**                            | Controls interpretation of metacharacters: `' '` = literal, `" "` = expand variables |
| **I/O Redirection**                    | Send input/output to or from files using `>`, `>>`, `<`, `2>`, etc.                  |
| **Command Substitution**               | Use `$(command)` to insert output into another command or variable                   |
| **Command-line Arguments**             | Pass values to your script using `$1`, `$2`, ..., `$@`, `$#`                         |
| **Sequential vs Concurrent Execution** | Run commands one after another or in parallel using `&`                              |
| **Cron Jobs**                          | Schedule scripts to run automatically at set times using `crontab -e`                |
| **Listing Cron Jobs**                  | `crontab -l` shows all scheduled jobs                                                |
| **Conditional Logic**                  | Use `if`, `elif`, `else`, `&&`, `                                                    |                                | ` to control flow |
| **Loops and Arrays**                   | Use `for` loops and Bash arrays to process lists of items                            |

---

## 🔍 Core Syntax Reference

### 📌 Crontab Format

```
m  h  dom  mon  dow  command
```

- m = minute (0–59)
- h = hour (0–23)
- dom = day of month (1–31)
- mon = month (1–12)
- dow = day of week (0–6) where 0 = Sunday

Example:

```bash
0 2 * * * /home/user/scripts/backup.sh
```

### 🧮 Arithmetic in Bash

```bash
echo $((3 + 2))        # Outputs 5
echo $((-1 * -2))      # Outputs 2
```

### 🧪 Conditional Statements

```bash
if [[ $# == 2 ]]; then
  echo "Two arguments provided"
fi
```

### 🔁 For Loops

```bash
for i in {1..5}; do
  echo "Iteration $i"
done
```

### 📦 Arrays

```bash
my_array=(apple banana "orange juice" 42)
echo ${my_array[0]}     # apple
echo ${my_array[@]}     # all elements
```

---

## 💡 Why This Matters

You're now equipped to:

- Write **custom automation scripts**
- Process and analyze **log files, CSVs, and system data**
- Schedule **daily tasks** like backups and reports
- Make decisions in scripts using **conditionals and logic**
- Build **dynamic and reusable scripts** with functions (coming soon!)

These skills are essential for:

- System administration
- DevOps workflows
- Data engineering pipelines
- Linux development and scripting

---
