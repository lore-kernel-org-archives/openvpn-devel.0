From: Jens Neuhalfen <openvpn-devel@...2127...>
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_F17A7FDF-1C6C-4DAE-B49B-B5AECE27522F"
Message-Id: <AAA08590-8376-431C-AE96-44060D64C6D9@...2127...>
Date: Sat, 23 Apr 2016 17:48:22 +0200
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: [Openvpn-devel] [PATCH 1/2] add test servers to use with t_client.sh
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <Openvpn-devel@lists.sourceforge.net>

--Apple-Mail=_F17A7FDF-1C6C-4DAE-B49B-B5AECE27522F
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

this patch will add test servers to use with t_client.sh. This will make te=
sting on different systems much easier. Bonus: testing on a laptop is a bre=
eze.


Virtual machines are defined by [Vagrant](https://www.vagrantup.com) script=
s. Virtualbox is used for virtualisation.

Each of the virtual machines is configured to compile openvpn and run a ser=
ver.

Inside the vm a openvpn server can be launched to run `t_client.sh` tests a=
gainst it. Sample launcher scripts are provided.


Patch as attachment because of its size.

Jens

--Apple-Mail=_F17A7FDF-1C6C-4DAE-B49B-B5AECE27522F
Content-Disposition: attachment;
	filename=0001-add-test-servers-to-use-with-t_client.sh.patch
Content-Type: application/octet-stream;
	name="0001-add-test-servers-to-use-with-t_client.sh.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=2049e38594839526e9185d8f0250d781ab43b39348=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Jens=20Neuhalfen=20<jens@...2127...>=0A=
Date:=20Fri,=2022=20Apr=202016=2017:37:43=20+0200=0ASubject:=20[PATCH=20=
1/2]=20add=20test=20servers=20to=20use=20with=20t_client.sh=0A=0AVirtual=20=
machines=20defined=20by=20[Vagrant](https://www.vagrantup.com)=20=
scripts.=20Virtualbox=20is=20used=20for=20virtualisation.=0A=0AEach=20of=20=
the=20virtual=20machines=20is=20configured=20to=20compile=20openvpn=20=
and=20run=20a=20server.=0A=0AInside=20the=20vm=20a=20openvpn=20server=20=
can=20be=20launched=20to=20run=20`t_client.sh`=20tests=20against=20it.=20=
Sample=20launcher=20scripts=20are=20provided.=0A=0ASigned-off-by:=20Jens=20=
Neuhalfen=20<jens@...2127...>=0A---=0A=20tests/server/.gitignore=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
|=20=201=20+=0A=20tests/server/README.md=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20|=2045=20++++++++++++=0A=20=
tests/server/scripts/compile.sh=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20|=20=208=20+++=0A=20tests/server/scripts/start_server.sh=20=20=
=20=20=20=20=20=20=20=20=20=20=20|=2088=20++++++++++++++++++++++++=0A=20=
tests/server/scripts/sync_codebase.sh=20=20=20=20=20=20=20=20=20=20=20=20=
|=20=206=20++=0A=20tests/server/ubuntu_precise64/README.md=20=20=20=20=20=
=20=20=20=20=20|=20=209=20+++=0A=20=
tests/server/ubuntu_precise64/Vagrantfile=20=20=20=20=20=20=20=20|=2037=20=
++++++++++=0A=20tests/server/ubuntu_precise64/launch_t_client.sh=20|=20=20=
4=20++=0A=20tests/server/ubuntu_trusty64/README.md=20=20=20=20=20=20=20=20=
=20=20=20|=20=209=20+++=0A=20tests/server/ubuntu_trusty64/Vagrantfile=20=20=
=20=20=20=20=20=20=20|=2037=20++++++++++=0A=20=
tests/server/ubuntu_trusty64/launch_t_client.sh=20=20|=20=204=20++=0A=20=
tests/t_client.rc-sample=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20|=2027=20++++++--=0A=2012=20files=20changed,=20=
271=20insertions(+),=204=20deletions(-)=0A=20create=20mode=20100644=20=
tests/server/.gitignore=0A=20create=20mode=20100644=20=
tests/server/README.md=0A=20create=20mode=20100755=20=
tests/server/scripts/compile.sh=0A=20create=20mode=20100755=20=
tests/server/scripts/start_server.sh=0A=20create=20mode=20100755=20=
tests/server/scripts/sync_codebase.sh=0A=20create=20mode=20100644=20=
tests/server/ubuntu_precise64/README.md=0A=20create=20mode=20100644=20=
tests/server/ubuntu_precise64/Vagrantfile=0A=20create=20mode=20100755=20=
tests/server/ubuntu_precise64/launch_t_client.sh=0A=20create=20mode=20=
100644=20tests/server/ubuntu_trusty64/README.md=0A=20create=20mode=20=
100644=20tests/server/ubuntu_trusty64/Vagrantfile=0A=20create=20mode=20=
100755=20tests/server/ubuntu_trusty64/launch_t_client.sh=0A=0Adiff=20=
--git=20a/tests/server/.gitignore=20b/tests/server/.gitignore=0Anew=20=
file=20mode=20100644=0Aindex=200000000..a977916=0A---=20/dev/null=0A+++=20=
b/tests/server/.gitignore=0A@@=20-0,0=20+1=20@@=0A+.vagrant/=0Adiff=20=
--git=20a/tests/server/README.md=20b/tests/server/README.md=0Anew=20file=20=
mode=20100644=0Aindex=200000000..0392ccd=0A---=20/dev/null=0A+++=20=
b/tests/server/README.md=0A@@=20-0,0=20+1,45=20@@=0A+VM=20definitions=20=
for=20test=20servers=0A+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A+=0A+Virtual=20machines=20=
defined=20by=20[Vagrant](https://www.vagrantup.com)=20scripts.=20=
Virtualbox=20is=20used=20for=20virtualisation.=0A+=0A+Each=20of=20the=20=
virtual=20machines=20is=20configured=20to=20compile=20openvpn=20and=20=
run=20a=20server.=0A+=0A+Inside=20the=20vm=20a=20openvpn=20server=20can=20=
be=20launched=20to=20run=20`t_client.sh`=20tests=20against=20it.=0A+=0A=
+Use=20Cases:=0A+---------------=0A+=20=0A+###=20Start=20the=20VM:=0A+=20=
=20*=20`vagrant=20up`=20from=20inside=20the=20VMs=20folder=20(e.g.=20=
`centos7`)=0A+=0A+###=20Login=20to=20=20the=20VM:=0A+=20=20*=20`vagrant=20=
ssh`=0A+=0A+###=20Synchronize=20local=20changes=20into=20the=20VM=20&=20=
rebuild=20the=20server=0A+=20=20*=20(insinde=20the=20vm)=0A+=20=20*=20=20=
`/scripts/sync_codebase.sh`=0A+=20=20*=20=20`/scripts/compile.sh`=0A+=0A=
+###=20Start=20the=20server=20for=20=20`t_client`=20tests=0A+=20=20*=20=
(outside=20of=20the=20vm)=20Modify=20`t_client.rc`=20(=20`REMOTE_IP`,=20=
`REMOTE_PORT`,=20`SERVER_KEY`,=20`SERVER_CERT`=0A+=20=20*=20(inside=20=
the=20vm)=20run=20`/scripts/sync_codebase.sh`=20(to=20sync=20the=20=
changed=20`t_client.rc`)=0A+=20=20*=20(inside=20the=20vm)=20run=20=
`/scripts/compile.sh`=0A+=20=20*=20(inside=20the=20vm)=20run=20=
`/scripts/start_server.sh`=0A+=0A+VM=20Layout=0A+-----------=0A+=20*=20=
The=20original=20source=20tree=20is=20mounted=20at=20/openvpn=0A+=20*=20=
The=20source=20tree=20used=20for=20compilation=20is=20copied=20to=20=
`~vagrant/openvpn`=0A+=20*=20Scripts=20are=20installed=20in=20the=20=
/scripts=20directory=0A+=20=20=20*=20`sync_codebase.sh`=20copies=20the=20=
codebase=20from=20the=20host=20into=20~/openvpn=20(=20so=20that=20it=20=
can=20be=20compiled=20for=20the=20VMs=20architecture/OS)=0A+=20=20=20*=20=
`rebuild.sh`=20builds=20the=20server=20inside=20the=20VM=20(at=20=
~/openvpn)=0A+=20=20=20*=20`start_server.sh`=20starts=20the=20server=20=
with=20a=20configuration=20from=20t_client.rc=0A+=0A+provided=20VMs=0A=
+--------------=0A+=0A+|=20Name=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20|=20external=20IPv4=20=20=20|=20external=20IPv6=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20|=0A=
+|--------------------------|-----------------|---------------------------=
-|=0A+|=20ubuntu_trusty64=20=20=20=20=20=20=20=20=20=20|=20192.168.33.66=20=
=20=20|=20IPv4=20only=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
|=0A+|=20ubuntu_precise64=20=20=20=20=20=20=20=20=20|=20192.168.33.67=20=20=
=20|=20IPv4=20only=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
|=0Adiff=20--git=20a/tests/server/scripts/compile.sh=20=
b/tests/server/scripts/compile.sh=0Anew=20file=20mode=20100755=0Aindex=20=
0000000..32e00a7=0A---=20/dev/null=0A+++=20=
b/tests/server/scripts/compile.sh=0A@@=20-0,0=20+1,8=20@@=0A+#=20-*-=20=
mode:=20sh=20-*-=0A+#=20vi:=20set=20ft=3Dsh=20:=0A+#!/bin/sh=0A+=0A+cd=20=
~/openvpn=0A+./configure=0A+make=20clean=0A+make=20-j3=0Adiff=20--git=20=
a/tests/server/scripts/start_server.sh=20=
b/tests/server/scripts/start_server.sh=0Anew=20file=20mode=20100755=0A=
index=200000000..5517dec=0A---=20/dev/null=0A+++=20=
b/tests/server/scripts/start_server.sh=0A@@=20-0,0=20+1,88=20@@=0A+#=20=
-*-=20mode:=20sh=20-*-=0A+#=20vi:=20set=20ft=3Dsh=20:=0A+#!/bin/bash=0A+=0A=
+#=0A+#=20-=20Expects=20the=20source=20to=20be=20located=20at=20=
"~/openvpn"=0A+#=20-=20Must=20be=20run=20as=20root=0A+#=20-=20Expects=20=
a=20t_client.rc=20to=20be=20present=0A+#=0A+=0A+cd=20=
~vagrant/openvpn/tests=0A+=0A+#=20Look=20for=20t_client.rc=20in=20the=20=
same=20locations=20t_client.sh=20does=0A+=0A+srcdir=3D"${srcdir:-.}"=0A=
+top_builddir=3D"${top_builddir:-..}"=0A+if=20[=20-r=20=
"${top_builddir}"/t_client.rc=20]=20;=20then=0A+=20=20=20=20.=20=
"${top_builddir}"/t_client.rc=0A+elif=20[=20-r=20"${srcdir}"/t_client.rc=20=
]=20;=20then=0A+=20=20=20=20.=20"${srcdir}"/t_client.rc=0A+else=0A+=20=20=
=20=20echo=20"$0:=20cannot=20find=20't_client.rc'=20in=20build=20dir=20=
('${top_builddir}')"=20>&2=0A+=20=20=20=20echo=20"$0:=20or=20source=20=
directory=20('${srcdir}').=20SKIPPING=20TEST."=20>&2=0A+=20=20=20=20exit=20=
77=0A+fi=0A+=0A=
+CA_CERT=3D"${CA_CERT:-${top_srcdir}/sample/sample-keys/ca.crt}"=0A=
+CLIENT_KEY=3D"${CLIENT_KEY:-${top_srcdir}/sample/sample-keys/client.key}"=
=0A=
+CLIENT_CERT=3D"${CLIENT_CERT:-${top_srcdir}/sample/sample-keys/client.crt=
}"=0A+=0A=
+VM_SERVER_KEY=3D"${VM_SERVER_KEY:-${top_srcdir}/sample/sample-keys/server=
.key}"=0A=
+VM_SERVER_CERT=3D"${VM_SERVER_CERT:-${top_srcdir}/sample/sample-keys/serv=
er.crt}"=0A=
+VM_SERVER_DH=3D"${VM_SERVER_DH:-${top_srcdir}/sample/sample-keys//dh2048.=
pem}"=0A+=0A+=0A+assert_var_set()=20{=0A+=20=20local=20varname=3D"$1"=0A=
+=20=20local=20value=3D=0A+=20=20eval=20value=3D\$$varname=0A+=0A+=20=20=
if=20[=20-n=20"${value}"=20];=20then=0A+=20=20=20=20=20echo=20"=20-=20=
$varname=20=20:=3D=20'${value}'"=0A+=20=20else=0A+=20=20=20=20=20echo=20=
"$varname=20not=20defined=20in=20't_client.rc'.=20abort."=20>&2=0A+=20=20=
=20=20=20exit=2077=0A+=20=20fi=0A+}=0A+=0A+assert_var_set=20CA_CERT=0A=
+assert_var_set=20VM_SERVER_KEY=0A+assert_var_set=20VM_SERVER_CERT=0A=
+assert_var_set=20VM_SERVER_DH=0A+assert_var_set=20VM_SERVER_NET=0A=
+assert_var_set=20VM_SERVER_MASK=0A+assert_var_set=20REMOTE_PORT=0A+=0A+=0A=
+OPENVPN=3D"${top_builddir}/src/openvpn/openvpn"=0A+=0A+if=20[=20!=20-x=20=
"${OPENVPN}"=20]=20;=20=20then=0A+=20=20=20=20echo=20"openvpn=20not=20=
found=20at=20'${OPENVPN}'"=20>&2=0A+=20=20=20=20exit=2077=0A+fi=0A+=0A=
+SERVER=3D"$VM_SERVER_NET=20$VM_SERVER_MASK"=0A+=0A+#=20Bind=20to=20all=20=
adresses=0A+LOCAL=3D"0.0.0.0"=0A+=0A+CMD=3D"\"${OPENVPN}\"=20\=0A+=20=
--mode=20server=20\=0A+=20--dev=20tun=20\=0A+=20--tls-server=20\=0A+=20=
--dh=20"${VM_SERVER_DH}"=20\=0A+=20--ca=20"${CA_CERT}"=20\=0A+=20--cert=20=
"${VM_SERVER_CERT}"=20\=0A+=20--key=20"${VM_SERVER_KEY}"=20\=0A+=20=
--server=20${SERVER}=20\=0A+=20--local=20=20${LOCAL}=20\=0A+=20--port=20=20=
=20${REMOTE_PORT}=20\=0A+=20--topology=20subnet=20\=0A+=20--comp-lzo=20\=0A=
+=20--management=20${LOCAL}=207505=20\=0A+=20--verb=203=20\=0A+"=0A+=0A=
+echo=20$CMD=0A+eval=20$CMD=0Adiff=20--git=20=
a/tests/server/scripts/sync_codebase.sh=20=
b/tests/server/scripts/sync_codebase.sh=0Anew=20file=20mode=20100755=0A=
index=200000000..c4ec27a=0A---=20/dev/null=0A+++=20=
b/tests/server/scripts/sync_codebase.sh=0A@@=20-0,0=20+1,6=20@@=0A+#=20=
-*-=20mode:=20sh=20-*-=0A+#=20vi:=20set=20ft=3Dsh=20:=0A+#!/bin/sh=0A+=0A=
+cd=20~=0A+rsync=20-avd=20--no-o=20/openvpn=20.=0Adiff=20--git=20=
a/tests/server/ubuntu_precise64/README.md=20=
b/tests/server/ubuntu_precise64/README.md=0Anew=20file=20mode=20100644=0A=
index=200000000..0c48d60=0A---=20/dev/null=0A+++=20=
b/tests/server/ubuntu_precise64/README.md=0A@@=20-0,0=20+1,9=20@@=0A=
+OpenVPN=20testserver=0A+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=0A+=0A+|=20VM=20Definition=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20|=0A=
+|------------|-------------------------|=0A+|=20**Distro**=20|=20Ubuntu=20=
Precise=20Pangolin=20|=0A+|=20**Arch**=20=20=20|=20x86_64=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20|=0A+|=20**IPv4**=20=20=20|=20=
192.168.33.66=20=20=20=20=20=20=20=20=20=20=20|=0A+|=20**IPv6**=20=20=20=
|=20N/A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20|=0A=
diff=20--git=20a/tests/server/ubuntu_precise64/Vagrantfile=20=
b/tests/server/ubuntu_precise64/Vagrantfile=0Anew=20file=20mode=20100644=0A=
index=200000000..11f3b22=0A---=20/dev/null=0A+++=20=
b/tests/server/ubuntu_precise64/Vagrantfile=0A@@=20-0,0=20+1,37=20@@=0A=
+#=20-*-=20mode:=20ruby=20-*-=0A+#=20vi:=20set=20ft=3Druby=20:=0A+=0A+=0A=
+Vagrant.configure(2)=20do=20|config|=0A+=20=20config.vm.box=20=3D=20=
"hashicorp/precise64"=0A+=0A+=20=20#=20Create=20a=20private=20network,=20=
which=20allows=20host-only=20access=20to=20the=20machine=0A+=20=20#=20=
using=20a=20specific=20IP.=0A+=20=20#=0A+=20=20#=20This=20IP=20is=20used=20=
in=20=20t_client.rc=20(REMOTE_IP).=20Make=20sure=20that=20both=20are=0A+=20=
=20#=20the=20same,=20if=20you=20want=20to=20use=20this=20Vagrant=20VM=0A=
+=20=20config.vm.network=20"private_network",=20ip:=20"192.168.33.67",=20=
netmask:=20"24"=0A+=0A+=20=20#=20Mount=20the=20source=20root=20under=20=
/openvpn.=0A+=20=20#=20TODO:=20mount=20read-only=0A+=20=20=
config.vm.synced_folder=20"../../..",=20"/openvpn"=0A+=20=20=
config.vm.synced_folder=20"../scripts",=20"/scripts"=0A+=0A+=20=20=
config.vm.provider=20"virtualbox"=20do=20|vb|=0A+=20=20=20=20=20=
vb.memory=20=3D=201024=0A+=20=20=20=20=20#=20for=20compiling;=20only=20=
works=20in=2064=20bit=20VMs=0A+=20=20=20=20=20vb.cpus=20=3D=202=0A+=20=20=
=20=20=20#=20Faster=20imports=0A+=20=20=20=20=20vb.linked_clone=20=3D=20=
true=20if=20Vagrant::VERSION=20=3D~=20/^1.8/=0A+=20=20end=0A+=0A+=20=20=20=
config.vm.provision=20"shell",=20inline:=20<<-SHELL=0A+=0A+sudo=20=
apt-get=20update=0A+sudo=20apt-get=20install=20=20-y=20autoconf=20g++=20=
make=20liblzo2-dev=20libpam0g-dev=20openssl=0A+=0A+echo=20=
'/scripts/sync_codebase.sh=20&&=20/scripts/compile.sh=20&&=20sudo=20=
/scripts/start_server.sh'=20>=20~vagrant/compile_and_run.sh=0A+chmod=20=
755=20~vagrant/compile_and_run.sh=0A+chown=20vagrant:vagrant=20=
~vagrant/compile_and_run.sh=0A+SHELL=0A+end=0Adiff=20--git=20=
a/tests/server/ubuntu_precise64/launch_t_client.sh=20=
b/tests/server/ubuntu_precise64/launch_t_client.sh=0Anew=20file=20mode=20=
100755=0Aindex=200000000..ed9a09d=0A---=20/dev/null=0A+++=20=
b/tests/server/ubuntu_precise64/launch_t_client.sh=0A@@=20-0,0=20+1,4=20=
@@=0A+#!/bin/sh=0A+=0A+cd=20../..=0A+REMOTE_IP=3D192.168.33.67=20=
./t_client.sh=0Adiff=20--git=20a/tests/server/ubuntu_trusty64/README.md=20=
b/tests/server/ubuntu_trusty64/README.md=0Anew=20file=20mode=20100644=0A=
index=200000000..111373f=0A---=20/dev/null=0A+++=20=
b/tests/server/ubuntu_trusty64/README.md=0A@@=20-0,0=20+1,9=20@@=0A=
+OpenVPN=20testserver=0A+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=0A+=0A+|=20VM=20Definition=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20|=0A+|------------|-----------------------|=0A=
+|=20**Distro**=20|=20Ubuntu=20Trusty=20Tahr=20=20=20=20|=0A+|=20=
**Arch**=20=20=20|=20x86_64=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
|=0A+|=20**IPv4**=20=20=20|=20192.168.33.66=20=20=20=20=20=20=20=20=20|=0A=
+|=20**IPv6**=20=20=20|=20N/A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20|=0Adiff=20--git=20=
a/tests/server/ubuntu_trusty64/Vagrantfile=20=
b/tests/server/ubuntu_trusty64/Vagrantfile=0Anew=20file=20mode=20100644=0A=
index=200000000..57f0232=0A---=20/dev/null=0A+++=20=
b/tests/server/ubuntu_trusty64/Vagrantfile=0A@@=20-0,0=20+1,37=20@@=0A+#=20=
-*-=20mode:=20ruby=20-*-=0A+#=20vi:=20set=20ft=3Druby=20:=0A+=0A+=0A=
+Vagrant.configure(2)=20do=20|config|=0A+=20=20config.vm.box=20=3D=20=
"ubuntu/trusty64"=0A+=0A+=20=20#=20Create=20a=20private=20network,=20=
which=20allows=20host-only=20access=20to=20the=20machine=0A+=20=20#=20=
using=20a=20specific=20IP.=0A+=20=20#=0A+=20=20#=20This=20IP=20is=20used=20=
in=20=20t_client.rc=20(REMOTE_IP).=20Make=20sure=20that=20both=20are=0A+=20=
=20#=20the=20same,=20if=20you=20want=20to=20use=20this=20Vagrant=20VM=0A=
+=20=20config.vm.network=20"private_network",=20ip:=20"192.168.33.66",=20=
netmask:=20"24"=0A+=0A+=20=20#=20Mount=20the=20source=20root=20under=20=
/openvpn.=0A+=20=20#=20TODO:=20mount=20read-only=0A+=20=20=
config.vm.synced_folder=20"../../..",=20"/openvpn"=0A+=20=20=
config.vm.synced_folder=20"../scripts",=20"/scripts"=0A+=0A+=20=20=
config.vm.provider=20"virtualbox"=20do=20|vb|=0A+=20=20=20=20=20=
vb.memory=20=3D=201024=0A+=20=20=20=20=20#=20for=20compiling;=20only=20=
works=20in=2064=20bit=20VMs=0A+=20=20=20=20=20vb.cpus=20=3D=202=0A+=20=20=
=20=20=20#=20Faster=20imports=0A+=20=20=20=20=20vb.linked_clone=20=3D=20=
true=20if=20Vagrant::VERSION=20=3D~=20/^1.8/=0A+=20=20end=0A+=0A+=20=20=20=
config.vm.provision=20"shell",=20inline:=20<<-SHELL=0A+=0A+sudo=20=
apt-get=20update=0A+sudo=20apt-get=20install=20=20-y=20autoconf=20g++=20=
make=20liblzo2-dev=20libpam0g-dev=20libssl-dev=20libtool=0A+=0A+echo=20=
'/scripts/sync_codebase.sh=20&&=20/scripts/compile.sh=20&&=20sudo=20=
/scripts/start_server.sh'=20>=20~vagrant/compile_and_run.sh=0A+chmod=20=
755=20~vagrant/compile_and_run.sh=0A+chown=20vagrant:vagrant=20=
~vagrant/compile_and_run.sh=0A+SHELL=0A+end=0Adiff=20--git=20=
a/tests/server/ubuntu_trusty64/launch_t_client.sh=20=
b/tests/server/ubuntu_trusty64/launch_t_client.sh=0Anew=20file=20mode=20=
100755=0Aindex=200000000..4996478=0A---=20/dev/null=0A+++=20=
b/tests/server/ubuntu_trusty64/launch_t_client.sh=0A@@=20-0,0=20+1,4=20=
@@=0A+#!/bin/sh=0A+=0A+cd=20../..=0A+REMOTE_IP=3D192.168.33.66=20=
./t_client.sh=0Adiff=20--git=20a/tests/t_client.rc-sample=20=
b/tests/t_client.rc-sample=0Aindex=206e66607..ef6035f=20100644=0A---=20=
a/tests/t_client.rc-sample=0A+++=20b/tests/t_client.rc-sample=0A@@=20=
-4,6=20+4,9=20@@=0A=20#=0A=20#=20(sample=20config,=20copy=20to=20=
t_client.rc=20and=20adapt=20to=20your=20environment)=0A=20#=0A+#=20This=20=
script=20is=20also=20sourced=20by=20the=20example=20OpenVPN=20servers=20=
(Vagrant=20files).=0A+#=0A+#=20The=20example=20servers=20can=20be=20run=20=
for=20instant=20remote=20endpoints=20for=20t_client.sh=0A=20#=0A=20#=20=
define=20these=20-=20if=20empty,=20no=20tests=20will=20run=0A=20#=0A@@=20=
-12,9=20+15,25=20@@=20CA_CERT=3D"${top_srcdir}/sample/sample-keys/ca.crt"=0A=
=20CLIENT_KEY=3D"${top_srcdir}/sample/sample-keys/client.key"=0A=20=
CLIENT_CERT=3D"${top_srcdir}/sample/sample-keys/client.crt"=0A=20#=0A-#=20=
remote=20host=20(used=20as=20macro=20below)=0A+#=20Configuration=20for=20=
the=20test=20server=20started=20via=20vagrant=0A+#=0A=
+VM_SERVER_KEY=3D"${top_srcdir}/sample/sample-keys/server.key"=0A=
+VM_SERVER_CERT=3D"${top_srcdir}/sample/sample-keys/server.crt"=0A=
+VM_SERVER_DH=3D"${top_srcdir}/sample/sample-keys//dh2048.pem"=0A+=0A+#=0A=
+VM_SERVER_IP=3D"10.8.0.1"=0A+#=20Passed=20as=20--server=20=
$VM_SERVER_NET=20$VM_SERVER_MASK=0A+VM_SERVER_NET=3D"10.8.0.0"=0A=
+VM_SERVER_MASK=3D"255.255.255.0"=0A+=0A=20#=0A-REMOTE=3Dmytestserver=0A=
+#=20remote=20host=20(used=20as=20macro=20below=20and=20for=20the=20test=20=
server=20in=20the=20vm)=0A+#=20When=20the=20test=20server=20(Vagrant)=20=
is=20used,=20make=20sure=20that=0A+#=20the=20IP=20=20equals=20the=20IP=20=
in=20Vagrantfile=0A+REMOTE_IP=3D"192.168.33.67"=0A+REMOTE_PORT=3D"51194"=0A=
+=0A=20#=0A=20#=20tests=20to=20run=20(list=20suffixes=20for=20config=20=
stanzas=20below)=0A=20#=0A@@=20-57,7=20+76,7=20@@=20=
OPENVPN_BASE_P2P=3D"..."=0A=20#=20=20=20specify=20IPv4+IPv6=20addresses=20=
expected=20from=20server=20and=20ping=20targets=0A=20#=0A=20=
RUN_TITLE_1=3D"testing=20tun/udp/ipv4+ipv6"=0A=
-OPENVPN_CONF_1=3D"$OPENVPN_BASE_P2MP=20--dev=20tun=20--proto=20udp=20=
--remote=20$REMOTE=20--port=2051194"=0A=
+OPENVPN_CONF_1=3D"$OPENVPN_BASE_P2MP=20--dev=20tun=20--proto=20udp=20=
--remote=20${REMOTE_IP}=20--port=20${REMOTE_PORT}"=0A=20=
EXPECT_IFCONFIG4_1=3D"10.100.50.6"=0A=20=
EXPECT_IFCONFIG6_1=3D"2001:db8:a050::1:0"=0A=20=
PING4_HOSTS_1=3D"10.100.50.1=2010.100.0.1"=0A@@=20-66,7=20+85,7=20@@=20=
PING6_HOSTS_1=3D"2001:db8::1=202001:db8:a050::1"=0A=20#=20Test=202:=20=
TCP=20/=20p2mp=20tun=0A=20#=0A=20RUN_TITLE_2=3D"testing=20=
tun/tcp/ipv4+ipv6"=0A-OPENVPN_CONF_2=3D"$OPENVPN_BASE_P2MP=20--dev=20tun=20=
--proto=20tcp=20--remote=20$REMOTE=20--port=2051194"=0A=
+OPENVPN_CONF_2=3D"$OPENVPN_BASE_P2MP=20--dev=20tun=20--proto=20tcp=20=
--remote=20${REMOTE_IP}=20--port=20${REMOTE_PORT}"=0A=20=
EXPECT_IFCONFIG4_2=3D"10.100.51.6"=0A=20=
EXPECT_IFCONFIG6_2=3D"2001:db8:a051::1:0"=0A=20=
PING4_HOSTS_2=3D"10.100.51.1=2010.100.0.1"=0A--=20=0A2.6.4=20(Apple=20=
Git-63)=0A=0A=

--Apple-Mail=_F17A7FDF-1C6C-4DAE-B49B-B5AECE27522F--

