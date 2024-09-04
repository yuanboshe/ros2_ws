# ros2_ws

这是本人常用的ros2_ws开发空间配置，参考自[vscode_ros2_workspace](https://github.com/athackst/vscode_ros2_workspace)。

工作空间的特性：
1. 配置了VSCode环境，包括头文件路径、python路径、调试等。
2. 配置了一些VSCode命令，包括安装依赖、编译、调试等。
3. 配置了一些VSCode的插件，包含常用插件的一键安装脚本。
4. 配置了符合ROS2 C++代码规范的格式化文件`.clang-format`，在工作空间自动生效。

## 部署ros2_ws

进入要部署ros2_ws的路径下，然后执行命令：

```bash
[ -d "ros2_ws" ] && echo "ros2_ws already exists, skipped." || (wget https://github.com/yuanboshe/ros2_ws/archive/refs/heads/humble.tar.gz && tar -zxvf humble.tar.gz && mv ros2_ws-humble ros2_ws && rm humble.tar.gz)
```

命令会在路径下生成ros2_ws目录，后面在该目录下进行ros2代码开发。

## 工程开发

### 前置条件

已经参考[Install ROS2 Humble](https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debs.html)，安装配置好ROS2开发环境。

（Optional）已经参考[Managing Dependencies with rosdep](https://docs.ros.org/en/humble/Tutorials/Intermediate/Rosdep.html)初始化rosdep。

已经参考前面的步骤部署ros2_ws。

### 下载工程代码

将需要开发的工程clone到ros2_ws/src目录下（本例中开发空间路径为`~/ros2_ws`），例如：

```bash
# 直接git clone
cd ~/ros2_ws/src && git clone https://github.com/yuanboshe/ros2_demos_cpp.git #填写自己的远程库地址
# 官方的demo包含的工程太多，编译起来很耗费时间，我这里做了精简，只包含talker和listener

# ------ 或者 ------

# vcs导入（如果包含ssh地址，需要事先配置密钥）
cd ~/ros2_ws && vcs import src < src/vcs_repos/ros2.repos
# 如果没有vcs工具，先安装，最后面的export PATH="$HOME/.local/bin:$PATH"可以放入~/.bashrc
sudo apt install python3-pip && pip install -U vcstool && export PATH="$HOME/.local/bin:$PATH"
```

### 安装依赖包

命令行安装：`rosdep install -i --from-path src --rosdistro humble -y`

或者

VSCode下：vscode界面 -> Terminal菜单 -> Run Task -> (下拉框选择) install dependencies

注意：要想VSCode对ROS2相关操作解析正确，必须保障当前工作路径在ros2_ws下，即“File -> Open Folder”是指向ros2_ws路径的。

### 编译

命令行编译：`colcon build --merge-install --symlink-install`

或者

VSCode下：vscode界面 -> Terminal菜单 -> Run Task -> (下拉框选择) build

编译默认为单任务模式（因为我主要在服务器上开发，并行任务容易崩），要并行编译选择`build parallel`。

### 添加环境变量

如果之前没有添加ros2_ws的环境变量，需要添加到~/.bashrc中。

```bash
# 注意改成自己的部署路径，这里是"~/ros2_ws"
echo "if [ -f $HOME/ros2_ws/install/local_setup.bash ]; then source $HOME/ros2_ws/install/local_setup.bash; fi" >> ~/.bashrc

# 检查是否生效
source ~/.bashrc && echo $AMENT_PREFIX_PATH
# 如果出现类似".../ros2_ws/install:/opt/ros/humble"则正确
```

### 测试：改源码编译

修改`src/ros2_demos_cpp/src/topics/talker.cpp`源码，编译。如第46行改成`"My Hello World: "`。

打开两个terminal（在build完成之后再开，否则需要先source ~/.bashrc才会生效），输入指令查看工程效果。

```bash
# terminal 1输入
ros2 run demo_nodes_cpp talker

# terminal 2输入
ros2 run demo_nodes_cpp listener
```

观察显示的是否是修改后的“My Hello World”。

## 调试

更多的调试方法参考[vscode-ros/doc/debug-support.md](https://github.com/ms-iot/vscode-ros/blob/master/doc/debug-support.md)。

### 配置环境

```bash
# 安装GDB
sudo apt install gdb

# 安装VSCode插件，会提示需要安装C/C++ Extension Pack依赖，同意
code --install-extension ms-iot.vscode-ros
```

### Attach方式调试

正常启动程序，打断点。debug选“ROS: Attach”，启动调试，按照提示选择正确的进程ID即可。

如果是普通用户执行ROS2 node，可能会显示没有GDB权限，需要先`echo 0| sudo tee /proc/sys/kernel/yama/ptrace_scope`设置权限。

### Launch方式调试

修改`ros2_ws/.vscode/launch.json`，修改"ROS: Launch"里面的"target"为要调试的文件。在源码里面打断点（如例子中的`src/ros2_demos_cpp/src/topics/talker.cpp`），然后调试选项选“ROS: Launch”，点击调试按钮即可。

### 调试Launch文件

对aunch文件打断点，调试选项选“ROS...”，点击调试按钮，继续选“ROS: Debug Launch File”即可。

## ros2_ws插件及其他

### 安装插件

```bash
# 先vscode连接，在IDE的terminal中使用脚本安装
cd ~/ros2_ws/scripts && ./install_plugins.sh
```

### Git Graph

ros2_ws工程已经自动配置检索3层目录的深度，能够把`ros2_ws/src/`下面的子文件夹全部包含在内，如果发现没有包含在repo下拉菜单，也可以手动配置增加。

View -> Command Palette...打开输入框，输入"Git Graph: Add Git Repository..."，然来填写需要增加的repo路径即可。

### CPP format

采用clang-format格式化代码，工程目录下的`.clang-format`是遵循ROS2规范的格式文件，装好插件后format CPP文件时会自动调用。（效果和`ament_clang_format`一致）

```bash
# 用标准的格式format当前路径下所有CPP文件
ament_clang_format --reformat .
```

## Q&A

### 被墙

因为墙的原因，多多少少都会出些意外，尤其是远程VSCode连接，得想一些办法变通达到目的。

方法一：科学上网。

但有可能配置得不科学，代理在VSCode的环境中无效，这样使用VSCode的相关命令还是不走代理的，解决方案是把命令拷出来在terminal里面运行。

方法二：github代理（只对github生效）。

针对github的部分，可以加`https://mirror.ghproxy.com/`前缀解决，即类似`https://mirror.ghproxy.com/https://github.com/yuanboshe/ros2_ws/archive/refs/heads/humble.tar.gz`的写法。

另外，也可配到git里面，如：

```bash
# 添加代理
git config --global http.proxy https://mirror.ghproxy.com
git config --global https.proxy https://mirror.ghproxy.com

# 取消代理
git config --global --unset http.proxy
git config --global --unset https.proxy
```

方法三：ros2 source 和 rosdep

用清华的，很完善。

### code-server命令找不到

用code-server的，可能会出现报错：

> /usr/lib/code-server/lib/vscode/bin/remote-cli/code-server: 12: /usr/lib/code-server/lib/vscode/node: not found

用命令`sudo ln -s /usr/lib/code-server/lib/node /usr/lib/code-server/lib/vscode`建立链接后在执行脚本安装插件。

### code-server部分插件缺失

因为code-server的应用市场与vscode的应用市场隔离，缺少一部分插件，可以自己改应用市场配置改成vscode的，网上找找很容易找到。
