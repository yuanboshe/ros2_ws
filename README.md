# aicrobo ros2_ws

## 部署环境

```bash
./deploy.sh
```

该脚本将下载并安装VSCode+Docker，并完成相关环境的部署工作。

## 启动VSCode，并进入ROS2容器

```bash
cd ros2_ws
code .
```

首次启动界面的右下角会提示"Reopen in Container"，确认。（如果错过了，还可以点击左下角的绿色图标，在出现的下拉框选择"Reopen in Container"。或者快捷键"Ctrl+Shift+P"，直接输入"Remote-Containers: Reopen in Container"。）
    

## 部署代码及编译

Step1: 将需要开发的ros2 package clone到src目录下
```bash
cd src
git clone <your resp url> #填写自己的远程库地址
```

Step2: 安装ros2 package的依赖包

vscode界面 -> Terminal菜单 -> Run Task -> (下拉框选择) install dependencies

Step3: 编译ros2 package

vscode界面 -> Terminal菜单 -> Run Task -> (下拉框选择) build

## 运行代码

虽然可以直接在vscode内部的terminal运行容器指令，但为避免某些指令让vscode崩溃，建议在外部terminal运行容器指令。

打开外部terminal，输入```goin-aicrobo_ros2_ws```即可进入容器内部。
