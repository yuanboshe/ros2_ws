# aicrobo ros2_ws

## 目录结构

```bash
.
├── deploy.sh            #部署脚本
├── README.md            #说明文档
├── scripts              #相关命令脚本
│   └── goin-aicrobo_ros2_ws.sh
└── src                  #源代码放在src目录下
```

## 部署环境

```bash
#在用户目录下下载ros2_ws
cd ~ && git clone https://codeup.aliyun.com/aicrobo/aicans/ros2_ws.git

#执行部署脚本，将会下载安装VSCode+Docker，并完成相关环境的部署工作。
#注意：执行前务必保障磁盘剩余空间大于6G！
cd ~/ros2_ws && ./deploy.sh
```

## 启动VSCode，并进入ROS2容器

```bash
#进入ros2_ws工程目录，启动vscode
cd ~/ros2_ws && code .
```

首次启动，会有一系列初始化设置，比如:"Yes, I trust the authores" > Install Remote-Containers ...

注意界面的右下角会提示"Reopen in Container"，确认。（如果错过了，还可以点击左下角的绿色图标，在出现的下拉框选择"Reopen in Container"。或者快捷键"Ctrl+Shift+P"，直接输入"Remote-Containers: Reopen in Container"。）

如果是首次"Reopen in Container"，系统会自动下载镜像，需要较长时间（1G多），具体进度点击右下角的"Starting Dev Container (show log)"查看，在底部TERMINAL窗口会显示操作进度，一切结束后会显示"Start: Run in container: cat /proc/????/environ"信息。

判断vscode有没有进入容器，观察左下角的图标，显示"Dev Container"则表示此时在容器环境中运行vscode，代码开发必须在容器中进行。

## 部署代码及编译

Step1: 将需要开发的ros2 package clone到src目录下

```bash
#直接导入
cd ~/ros2_ws/src && git clone <your resp url> #填写自己的远程库地址

#vcs导入。对于私有库，需要事先配置ssh_rsa密钥
vcs import src < src/vcs_repos/mini.repos
#如果没有vcs工具，先安装
sudo apt install python3-pip && pip install -U vcstool
```

Step2: 安装ros2 package的依赖包

vscode界面 -> Terminal菜单 -> Run Task -> (下拉框选择) install dependencies

Step3: 编译ros2 package

vscode界面 -> Terminal菜单 -> Run Task -> (下拉框选择) build

## 运行代码

虽然可以直接在vscode内部的terminal运行容器指令，但为避免某些指令让vscode崩溃，建议在外部terminal运行容器指令。

打开外部terminal，输入```goin-aicrobo_ros2_ws```即可进入容器内部，然后在容器内部运行ros2相关指令。
