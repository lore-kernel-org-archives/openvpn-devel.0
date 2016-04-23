From: Jens Neuhalfen <openvpn-devel@...2127...>
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_2437BFEF-6848-4398-B92E-ABFCC3DA5629"
Message-Id: <24707088-3AB4-467D-8CC5-88F07A205702@...2127...>
Date: Sat, 23 Apr 2016 17:48:26 +0200
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: [Openvpn-devel] [PATCH 2/2] add script to launch t_client.sh
	against a VM
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <Openvpn-devel@lists.sourceforge.net>

--Apple-Mail=_2437BFEF-6848-4398-B92E-ABFCC3DA5629
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


This script will prepare (compile and start openvpn) a vm, run t_client.sh =
against it, and then halt the VM.



--Apple-Mail=_2437BFEF-6848-4398-B92E-ABFCC3DA5629
Content-Disposition: attachment;
	filename=0002-add-script-to-launch-t_client.sh-against-a-VM.patch
Content-Type: application/octet-stream;
	name="0002-add-script-to-launch-t_client.sh-against-a-VM.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=204cc7877a0d1678d1ac3994d169ee81537b945146=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Jens=20Neuhalfen=20<jens@...2127...>=0A=
Date:=20Sat,=2023=20Apr=202016=2017:33:47=20+0200=0ASubject:=20[PATCH=20=
2/2]=20add=20script=20to=20launch=20t_client.sh=20against=20a=20VM=0A=0A=
This=20script=20will=20prepare=20(compile=20and=20start=20openvpn)=20a=20=
vm,=20run=20t_client.sh=20against=20it,=20and=20then=20halts=20the=20VM.=0A=
---=0A=20tests/server/run_integration.sh=20|=20118=20=
++++++++++++++++++++++++++++++++++++++++=0A=201=20file=20changed,=20118=20=
insertions(+)=0A=20create=20mode=20100755=20=
tests/server/run_integration.sh=0A=0Adiff=20--git=20=
a/tests/server/run_integration.sh=20b/tests/server/run_integration.sh=0A=
new=20file=20mode=20100755=0Aindex=200000000..a74020c=0A---=20/dev/null=0A=
+++=20b/tests/server/run_integration.sh=0A@@=20-0,0=20+1,118=20@@=0A=
+#!/bin/bash=0A+=0A+if=20[=20$#=20-ne=201=20];=20then=0A+=20=20=20=20=
echo=20$0=20vm_folder=0A+=20=20=20=20exit=20-1=0A+fi=0A+=0A+=0A=
+VM_FOLDER=3D$1=0A+if=20[=20!=20-d=20=20"$VM_FOLDER"=20];=20then=0A+=20=20=
=20=20echo=20$0=20vm_folder=0A+=20=20=20=20echo=20"--=20'${VM_FOLDER}'=20=
is=20no=20directory"=0A+=20=20=20=20exit=20-1=0A+fi=0A+=0A+cd=20=
"${VM_FOLDER}"=0A+=0A+#=20Path=20is=20relative=20to=20the=20pth=20of=20=
the=20folder=20containing=20Vagrantfile=0A=
+TEST_PROGRAM=3D./launch_t_client.sh=0A+=0A+#=20result=2099:=20test=20=
not=20run=20bc.=20server=20could=20not=20be=20started=0A+test_result=3D99=0A=
+=0A+start_vm()=20{=0A+=20=20vagrant=20halt=0A+=20=20vagrant=20up=0A+=20=20=
vagrant=20ssh=20-c=20'/scripts/sync_codebase.sh=20&&=20=
/scripts/compile.sh'=0A+}=0A+=0A+START_TEST_ON=3D"Initialization=20=
Sequence=20Completed"=0A+=0A+colorize()=20{=0A+=20=20local=20=
BLACK=3D$(tput=20setaf=200)=0A+=20=20local=20RED=3D$(tput=20setaf=201)=0A=
+=20=20local=20GREEN=3D$(tput=20setaf=202)=0A+=20=20local=20=
YELLOW=3D$(tput=20setaf=203)=0A+=20=20local=20LIME_YELLOW=3D$(tput=20=
setaf=20190)=0A+=20=20local=20POWDER_BLUE=3D$(tput=20setaf=20153)=0A+=20=20=
local=20BLUE=3D$(tput=20setaf=204)=0A+=20=20local=20MAGENTA=3D$(tput=20=
setaf=205)=0A+=20=20local=20CYAN=3D$(tput=20setaf=206)=0A+=20=20local=20=
WHITE=3D$(tput=20setaf=207)=0A+=20=20local=20BRIGHT=3D$(tput=20bold)=0A+=20=
=20local=20NORMAL=3D$(tput=20sgr0)=0A+=20=20local=20BLINK=3D$(tput=20=
blink)=0A+=20=20local=20REVERSE=3D$(tput=20smso)=0A+=20=20local=20=
UNDERLINE=3D$(tput=20smul)=0A+=0A+=20=20local=20ERROR=3D"$RED"=0A+=0A+=20=
=20local=20msg=3D"$2"=0A+=20=20local=20color=3D""=0A+=0A+=20=20case=20=
"$1"=20in=0A+=20=20=20=20"S")=0A+=20=20=20=20=20=20=
color=3D"${POWDER_BLUE}"=0A+=20=20=20=20;;=0A+=20=20=20=20"C")=0A+=20=20=20=
=20=20=20color=3D"${YELLOW}"=0A+=20=20=20=20;;=0A+=20=20=20=20*)=0A+=20=20=
esac=0A+=0A+=20=20msg=3D"${color}${msg}${NORMAL}"=0A+=0A+=20=20=
msg=3D${msg/FATAL/${ERROR}FATAL${color}}=0A+=20=20=
msg=3D${msg/FAIL/${ERROR}FAIL${color}}=0A+=20=20echo=20$msg=0A+}=0A+=0A=
+print_log()=20{=0A+=20=20local=20src=3D"$1"=0A+=20=20local=20line=3D"$2"=0A=
+=0A+=20=20local=20sanitized=3D$(echo=20"$line"=20|=20=20tr=20-cd=20=
'\40-\176'=20|=20sed=20-e=20's/^[=20]+//'=20-e=20's/[=20]+$//')=0A+=20=20=
sanitized=3D$(colorize=20$src=20"$sanitized")=0A+=0A+=20=20printf=20"%s:=20=
%s\n"=20"$src"=20"$sanitized"=0A+}=0A+=0A+=0A+=0A+#=20Run=20the=20test=20=
command=20defined=20in=20$TEST_PROGRAM=20and=20halt=20the=20VM=20=
afterwards=0A+run_test()=20{=0A+=20=20=20=20=20=20=20=20echo=20Starting=20=
Client=0A+=20=20=20=20=20=20=20=20$TEST_PROGRAM=202>&1=20|=20while=20=
read=20client_line=0A+=20=20=20=20=20=20=20=20do=20=0A+=20=20=20=20=20=20=
=20=20=20=20print_log=20"C"=20"$client_line"=0A+=20=20=20=20=20=20=20=20=
done=20=20=0A+=0A+=20=20=20=20=20=20=20=20local=20=
result=3D${PIPESTATUS[0]}=0A+=20=20=20=20=20=20=20=20vagrant=20halt=0A+=20=
=20=20=20=20=20=20=20return=20$result=0A+}=0A+=0A+=0A+start_vm=0A+=0A=
+while=20read=20server_line=0A+do=0A+=20=20#=20At=20least=20on=20my=20=
Mac=20this=20is=20needed.=20Else=20the=20code=20only=20prints=20LF,=20=
but=20no=20CR=0A+=20=20reset=20-I=0A+=20=20#=20Remove=20non-ascii.=20=
Esp.=20remove=20CR/LF=20because=20they=20break=20the=20processing=20=
logic=0A+=20=20=0A+=20=20print_log=20"S"=20=20"$server_line"=0A+=0A+=20=20=
if=20[[=20"$server_line"=20=3D=3D=20*$START_TEST_ON*=20]]=20;=20then=0A+=20=
=20=20=20=20=20run_test=20&=0A+=20=20fi=0A+done=20<=20<(vagrant=20ssh=20=
-c=20'sudo=20/scripts/start_server.sh'=20&)=0A+=0A+echo=20"Waiting=20for=20=
all=20jobs=20to=20terminate=20...."=0A+=0A+wait=20%run_test=0A=
+test_result=3D$?=0A+wait=0A+=0A+exit=20$test_result=0A--=20=0A2.6.4=20=
(Apple=20Git-63)=0A=0A=

--Apple-Mail=_2437BFEF-6848-4398-B92E-ABFCC3DA5629--

