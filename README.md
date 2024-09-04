# ros2_ws

This is the configuration of my commonly used `ros2_ws` development space, which is based on [vscode_ros2_workspace](https://github.com/athackst/vscode_ros2_workspace).

Features of the workspace:
1. Configured the VSCode environment, including header file paths, Python paths, debugging, etc.
2. Set up some VSCode commands, including installation of dependencies, compilation, debugging, etc.
3. Configured some VSCode extensions, including one-click installation scripts for commonly used extensions.
4. Configured the `.clang-format` formatting file that complies with ROS2 C++ code standards, which takes effect automatically in the workspace.

## Deploying ros2_ws

Navigate to the path where you want to deploy `ros2_ws`, and then execute the command:

```bash
[ -d "ros2_ws" ] && echo "ros2_ws already exists, skipped." || (wget https://github.com/yuanboshe/ros2_ws/archive/refs/heads/humble.tar.gz  && tar -zxvf humble.tar.gz && mv ros2_ws-humble ros2_ws && rm humble.tar.gz)
```

The command will create a `ros2_ws` directory in the path, and subsequent ROS2 code development will be carried out in this directory.

## Project Development

### Prerequisites

You have already installed and configured the ROS2 development environment by referring to [Install ROS2 Humble](https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debs.html).

(Optional) You have initialized `rosdep` by referring to [Managing Dependencies with rosdep](https://docs.ros.org/en/humble/Tutorials/Intermediate/Rosdep.html).

You have deployed `ros2_ws` as per the previous steps.

### Download Project Code

Clone the project you need to develop into the `ros2_ws/src` directory (the development space path in this example is `~/ros2_ws`), for example:

```bash
# Direct git clone
cd ~/ros2_ws/src && git clone https://github.com/yuanboshe/ros2_demos_cpp.git  # Replace to your own remote repository address
# The official demo includes too many projects, which takes a long time to compile. I have made a simplification here, only including talker and listener.

# ------ Or ------

# vcs import (if it includes SSH addresses, you need to configure the key in advance)
cd ~/ros2_ws && vcs import src < src/vcs_repos/ros2.repos
# If you do not have the vcs tool, install it first, the last export PATH="$HOME/.local/bin:$PATH" can be added to ~/.bashrc
sudo apt install python3-pip && pip install -U vcstool && export PATH="$HOME/.local/bin:$PATH"
```

### Install Dependency Packages

Install via command line: `rosdep install -i --from-path src --rosdistro humble -y`

Or

In VSCode: VSCode interface -> Terminal menu -> Run Task -> (select from the dropdown) install dependencies

Note: To ensure that VSCode correctly interprets ROS2-related operations, the current working path must be under `ros2_ws`, i.e., "File -> Open Folder" should point to the `ros2_ws` path.

### Compilation

Compile via command line: `colcon build --merge-install --symlink-install`

Or

In VSCode: VSCode interface -> Terminal menu -> Run Task -> (select from the dropdown) build

The compilation defaults to single-task mode (as I mainly develop on the server, parallel tasks are prone to crashes), to compile in parallel, select `build parallel`.

### Add Environment Variables

If you have not previously added environment variables for `ros2_ws`, you need to add them to your `~/.bashrc`.

```bash
# Note to change to your own deployment path, here it is "$HOME/ros2_ws"
echo "if [ -f $HOME/ros2_ws/install/local_setup.bash ]; then source $HOME/ros2_ws/install/local_setup.bash; fi" >> ~/.bashrc

# Check if it takes effect
source ~/.bashrc && echo $AMENT_PREFIX_PATH
# If it shows something like ".../ros2_ws/install:/opt/ros/humble", then it is correct
```

### Testing: Modify and Compile Source Code

Modify the source code `src/ros2_demos_cpp/src/topics/talker.cpp`, for example, change line 46 to `"My Hello World: "`.

Open two terminals (after the build is complete, otherwise you need to source ~/.bashrc first for it to take effect), and enter the commands to see the effect of the project.

```bash
# Terminal 1 input
ros2 run demo_nodes_cpp talker

# Terminal 2 input
ros2 run demo_nodes_cpp listener
```

Observe whether the displayed text is the modified "My Hello World".

## Debugging

For more debugging methods, refer to [vscode-ros/doc/debug-support.md](https://github.com/ms-iot/vscode-ros/blob/master/doc/debug-support.md).

### Setting Up the Environment

```bash
# Install GDB
sudo apt install gdb

# Install the VSCode extension, it will prompt you to install the C/C++ Extension Pack dependency, agree to it
code --install-extension ms-iot.vscode-ros
```

### Attach Debugging

Start the program normally, set breakpoints. Select "ROS: Attach" for debugging, and follow the prompts to choose the correct process ID.

If a regular user executes a ROS2 node, it may show that there is no GDB permission, you need to set the permission first with `echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope`.

### Launch Debugging

Modify the `ros2_ws/.vscode/launch.json`, change the "target" in "ROS: Launch" to the file you want to debug. Set breakpoints in the source code (e.g., `src/ros2_demos_cpp/src/topics/talker.cpp`), then select "ROS: Launch" in the debug options and click the debug button to start.

### Debugging Launch Files

Set breakpoints in the launch file, select "ROS..." in the debug options, click the debug button, and continue by selecting "ROS: Debug Launch File".

## Plugins and Other Features of ros2_ws

### Installing Plugins

```bash
# Connect with VSCode first, then use the script to install in the IDE's terminal
cd ~/ros2_ws/scripts && ./install_plugins.sh
```

### Git Graph

The ros2_ws project has been automatically configured to search up to 3 levels of directories, which can include all subfolders under `ros2_ws/src/`. If you find that it is not included in the repo dropdown menu, you can also manually configure to add it.

Open the Command Palette... by typing in the input box, type "Git Graph: Add Git Repository...", and then fill in the path of the repo you need to add.

### CPP Format

Use clang-format to format the code. The `.clang-format` in the project directory is a formatting file that follows the ROS2 standards. After installing the plugin, it will be automatically invoked when formatting CPP files. (The effect is consistent with `ament_clang_format`)

```bash
# Format all CPP files in the current path with the standard format
ament_clang_format --reformat .
```

## Q&A

### Blocked by the GFW

Due to GFW issues, there are bound to be some unexpected problems, especially when connecting with VSCode remotely. Some workarounds are necessary to achieve the desired outcome.

Method 1: Use a VPN.

However, the VPN configuration might not be effective, and the proxy may not work within the VSCode environment. Thus, using related VSCode commands might not route through the proxy. The solution is to copy the commands and run them in the terminal.

Method 2: GitHub proxy (effective only for GitHub).

For GitHub-specific issues, you can prepend `https://mirror.ghproxy.com/` to the URL, like so: `https://mirror.ghproxy.com/https://github.com/yuanboshe/ros2_ws/archive/refs/heads/humble.tar.gz`.

Additionally, you can configure it directly in git, as follows:

```bash
# Add proxy
git config --global http.proxy https://mirror.ghproxy.com
git config --global https.proxy https://mirror.ghproxy.com

# Clean proxy
git config --global --unset http.proxy
git config --global --unset https.proxy
```

Method 3: ros2 source and rosdep

Use the Tsinghua University mirror; it's well-maintained.

### code-server command not found

For those using code-server, you might encounter an error:

> /usr/lib/code-server/lib/vscode/bin/remote-cli/code-server: 12: /usr/lib/code-server/lib/vscode/node: not found

Create a symbolic link with the command `sudo ln -s /usr/lib/code-server/lib/node /usr/lib/code-server/lib/vscode` and then run the script to install plugins.

### Missing plugins in code-server

Since the code-server's marketplace is isolated from the VSCode's marketplace, some plugins are missing. You can modify the marketplace settings to match those of VSCode's, which is easy to find online.
