# aicrobo ros2_ws

## 工程开发

### 下载工程代码

将需要开发的ros2 package clone到src目录下

```bash
#直接导入
cd ~/ros2_ws/src && git clone <your resp url> #填写自己的远程库地址

#vcs导入。对于私有库，需要事先配置ssh_rsa密钥
vcs import src < src/vcs_repos/mini.repos
#如果没有vcs工具，先安装
sudo apt install python3-pip && pip install -U vcstool
```

### 安装依赖包

vscode界面 -> Terminal菜单 -> Run Task -> (下拉框选择) install dependencies

### 编译

vscode界面 -> Terminal菜单 -> Run Task -> (下拉框选择) build

## ros2_ws特性

### 安装插件

```bash
#使用脚本安装
cd ~/ros2_ws/scripts && ./code-server.sh
```

### CPP format

采用clang-format格式化代码，工程目录下的`.clang-format`是遵循ROS2规范的格式文件，装好插件后format CPP文件时会自动调用。（效果和`ament_clang_format`一致）

```bash
#用标准的格式format当前路径下所有CPP文件
ament_clang_format --reformat .
```
