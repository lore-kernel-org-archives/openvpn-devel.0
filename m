MIME-Version: 1.0
From: Shawn Asmussen <shawn.asmussen@...277...>
Date: Tue, 2 May 2023 11:38:52 -0700
Message-ID: <CAKasoNDCgjXHkj2SCn0Pe-MsO0+E5JUN08yJj3K8Ld+cWvfO=g@...278...>
Content-Type: multipart/alternative; boundary="000000000000e49c5905faba40d0"
Subject: [Openvpn-devel] Compiling DCO module on Oracle Linux 8,
 against UEK kernel
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--000000000000e49c5905faba40d0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Today I began to setup a test platform in our organization for openvpn DCO.
We are running Oracle's OEL 8. The make of the dco module fails, and I
suspect that it is because the Makefile detects EL8, and tries to compile
using a configuration that is specific to RHEL's custom kernel source code.
However, Oracle Linux, by default uses
their own custom kernel called the UEK (Unbreakable Enterprise Kernel).
Commenting out the EL8 check in the Makefile results in the module
compiling, but I still have to configure the rest of the pieces of the test
before I can verify that the compiled module is functional.


-[~/dco-test/ovpn-dco:$]- make
/buildhome/oracle8/build/dco-test/ovpn-dco/gen-compat-autoconf.sh
/buildhome/oracle8/build/dco-test/ovpn-dco/compat-autoconf.h
make -C /lib/modules/5.4.17-2136.318.7.1.el8uek.x86_64/build
M=3D/buildhome/oracle8/build/dco-test/ovpn-dco
PWD=3D/buildhome/oracle8/build/dco-test/ovpn-dco REVISION=3D0.2.20230426
CONFIG_OVPN_DCO_V2=3Dm INSTALL_MOD_DIR=3Dupdates/    modules
make[1]: Entering directory
'/usr/src/kernels/5.4.17-2136.318.7.1.el8uek.x86_64'
  CC [M]
 /buildhome/oracle8/build/dco-test/ovpn-dco/drivers/net/ovpn-dco/main.o
/buildhome/oracle8/build/dco-test/ovpn-dco/drivers/net/ovpn-dco/main.c:113:=
28:
error: =E2=80=98dev_get_tstats64=E2=80=99 undeclared here (not in a functio=
n); did you mean
=E2=80=98dev_get_stats=E2=80=99?
  .ndo_get_stats64        =3D dev_get_tstats64,
                            ^~~~~~~~~~~~~~~~
                            dev_get_stats
make[3]: *** [scripts/Makefile.build:268:
/buildhome/oracle8/build/dco-test/ovpn-dco/drivers/net/ovpn-dco/main.o]
Error 1
make[2]: *** [scripts/Makefile.build:503:
/buildhome/oracle8/build/dco-test/ovpn-dco/drivers/net/ovpn-dco] Error 2
make[1]: *** [Makefile:1798: /buildhome/oracle8/build/dco-test/ovpn-dco]
Error 2
make[1]: Leaving directory
'/usr/src/kernels/5.4.17-2136.318.7.1.el8uek.x86_64'
make: *** [Makefile:59: all] Error 2

--000000000000e49c5905faba40d0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Today I began to setup a test platform in our organization=
 for openvpn DCO. We are running Oracle&#39;s=C2=A0OEL 8. The make of the d=
co module fails, and I suspect that it is because the Makefile detects EL8,=
 and tries to compile using a configuration that is specific to RHEL&#39;s =
custom kernel source code. However, Oracle Linux, by default uses=C2=A0<div=
>their own custom kernel called the UEK (Unbreakable Enterprise Kernel). Co=
mmenting out the EL8 check in the Makefile results in the module compiling,=
 but I still have to configure the rest of the pieces of the test before I =
can verify that the compiled module is functional.</div><div><br></div><div=
><br></div><div>-[~/dco-test/ovpn-dco:$]- make<br>/buildhome/oracle8/build/=
dco-test/ovpn-dco/gen-compat-autoconf.sh /buildhome/oracle8/build/dco-test/=
ovpn-dco/compat-autoconf.h<br>make -C /lib/modules/5.4.17-2136.318.7.1.el8u=
ek.x86_64/build M=3D/buildhome/oracle8/build/dco-test/ovpn-dco PWD=3D/build=
home/oracle8/build/dco-test/ovpn-dco REVISION=3D0.2.20230426 CONFIG_OVPN_DC=
O_V2=3Dm INSTALL_MOD_DIR=3Dupdates/ =C2=A0 =C2=A0modules<br>make[1]: Enteri=
ng directory &#39;/usr/src/kernels/5.4.17-2136.318.7.1.el8uek.x86_64&#39;<b=
r>=C2=A0 CC [M] =C2=A0/buildhome/oracle8/build/dco-test/ovpn-dco/drivers/ne=
t/ovpn-dco/main.o<br>/buildhome/oracle8/build/dco-test/ovpn-dco/drivers/net=
/ovpn-dco/main.c:113:28: error: =E2=80=98dev_get_tstats64=E2=80=99 undeclar=
ed here (not in a function); did you mean =E2=80=98dev_get_stats=E2=80=99?<=
br>=C2=A0 .ndo_get_stats64 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D dev_get_tstats64,=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_=
get_stats<br>make[3]: *** [scripts/Makefile.build:268: /buildhome/oracle8/b=
uild/dco-test/ovpn-dco/drivers/net/ovpn-dco/main.o] Error 1<br>make[2]: ***=
 [scripts/Makefile.build:503: /buildhome/oracle8/build/dco-test/ovpn-dco/dr=
ivers/net/ovpn-dco] Error 2<br>make[1]: *** [Makefile:1798: /buildhome/orac=
le8/build/dco-test/ovpn-dco] Error 2<br>make[1]: Leaving directory &#39;/us=
r/src/kernels/5.4.17-2136.318.7.1.el8uek.x86_64&#39;<br>make: *** [Makefile=
:59: all] Error 2<br></div></div>

--000000000000e49c5905faba40d0--

