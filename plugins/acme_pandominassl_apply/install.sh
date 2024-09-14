#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin:/opt/homebrew/bin
export PATH

curPath=`pwd`
rootPath=$(dirname "$curPath")
rootPath=$(dirname "$rootPath")
serverPath=$(dirname "$rootPath")

install_tmp=${rootPath}/tmp/mw_install.pl
VERSION=$2

# cd /www/server/mdserver-web && python3 plugins/acme_pandominassl_apply/index.py run_hook

Install_App()
{
	echo '正在安装脚本文件...' > $install_tmp
	mkdir -p $serverPath/source
	mkdir -p $serverPath/acme_pandominassl_apply
	echo "${VERSION}" > $serverPath/acme_pandominassl_apply/version.pl

	cd ${rootPath} && python3 ${rootPath}/plugins/acme_pandominassl_apply/index.py start
	echo '安装[ACME泛域名SSL]完成'
}

Uninstall_App()
{
	cd ${rootPath} && python3 ${rootPath}/plugins/acme_pandominassl_apply/index.py stop
	rm -rf $serverPath/acme_pandominassl_apply
	echo "卸载[ACME泛域名SSL]成功"
}

action=$1
if [ "${1}" == 'install' ];then
	Install_App
else
	Uninstall_App
fi
