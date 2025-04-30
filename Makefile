#########################################################################
# 欢迎来到 Awesome Privacy!                                              #
# 本文件包含了项目（lib 和 web）的所有命令                              #
#                                                                       #
# lib 命令:                                                             #
# make install_lib_deps - 安装 lib/ 的 Python 依赖                      #
# make validate - 使用 schema 校验 awesome-privacy.yml                  #
# make gen_readme - 从 awesome-privacy.yml 生成 README.md               #
#                                                                       #
# web 命令:                                                             #
# make install_web_deps - 安装网站的 NPM 依赖                           #
# make build_web - 构建静态网站（输出到 web/dist/）                     #
# make start_web - 启动 web 服务器以服务静态网站                        #
#                                                                       #
# 更多文档请参考 GitHub 仓库：                                           #
# https://github.com/lissy93/awesome-privacy 或 awesome-privacy.xyz     #
#                                                                       #
#########################################################################
# 版权归 Alicia Sykes <https://aliciasykes.com>，采用 CC0-1.0 许可       #
#########################################################################

# 目标
.PHONY: all \
	install_lib_deps gen_readme validate lib \
	install_web_deps build_web start_web web

# 获取 Python 路径
PYTHON := $(shell which python3 2>/dev/null || which python)

# 目录位置
LIB_DIR := lib
WEB_DIR := web

# lib/ 相关目标
install_lib_deps:
	$(PYTHON) -m pip install -r $(LIB_DIR)/requirements.txt

gen_readme: install_lib_deps
	$(PYTHON) $(LIB_DIR)/awesome-privacy-readme-gen.py

validate: install_lib_deps
	$(PYTHON) $(LIB_DIR)/validate-awesome-privacy.py

lib: install_lib_deps validate gen_readme

# web/ 相关目标
install_web_deps:
	cd $(WEB_DIR) && yarn install

build_web: install_web_deps
	cd $(WEB_DIR) && yarn build

start_web: build_web
	cd $(WEB_DIR) && yarn start

dev_web: install_web_deps
	cd $(WEB_DIR) && yarn dev

web: install_web_deps build_web start_web
