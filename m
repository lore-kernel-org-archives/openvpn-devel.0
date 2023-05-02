MIME-Version: 1.0
References: <CAKasoNDCgjXHkj2SCn0Pe-MsO0+E5JUN08yJj3K8Ld+cWvfO=g@...278...>
 <12570dae-cf48-9969-dea9-16e25c6cad71@...2181...>
In-Reply-To: <12570dae-cf48-9969-dea9-16e25c6cad71@...2181...>
From: Shawn Asmussen <shawn.asmussen@...277...>
Date: Tue, 2 May 2023 14:18:04 -0700
Message-ID: <CAKasoNDVEsNBSceOgyTYGxE43tca2=yijV2mudC0WX4QnBL2=A@...278...>
Content-Type: multipart/alternative; boundary="0000000000004c6d6105fabc7a7b"
Subject: Re: [Openvpn-devel] Compiling DCO module on Oracle Linux 8,
 against UEK kernel
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--0000000000004c6d6105fabc7a7b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Certainly. Here is the contents of the redhat-release, oracle-release, and
os-release files. It's also worth noting that the UEK kernel is optional on
OEL, so theoretically an OEL system can be running either the RHEL kernel
(A recompile of the RHEL source code, just like CentOS 8 used to be before
the change), or Oracle's own UEK kernel. In my experience, most people
using Oracle tend to stick with the Oracle UEK kernel, though. Therefore,
an OEL user could either need the RHEL configuration when compiling the DCO
module, or not, depending on which kernel they were compiling against.

-[~:#]- cat /etc/os-release
NAME=3D"Oracle Linux Server"
VERSION=3D"8.7"
ID=3D"ol"
ID_LIKE=3D"fedora"
VARIANT=3D"Server"
VARIANT_ID=3D"server"
VERSION_ID=3D"8.7"
PLATFORM_ID=3D"platform:el8"
PRETTY_NAME=3D"Oracle Linux Server 8.7"
ANSI_COLOR=3D"0;31"
CPE_NAME=3D"cpe:/o:oracle:linux:8:7:server"
HOME_URL=3D"https://linux.oracle.com/"
BUG_REPORT_URL=3D"https://bugzilla.oracle.com/"

ORACLE_BUGZILLA_PRODUCT=3D"Oracle Linux 8"
ORACLE_BUGZILLA_PRODUCT_VERSION=3D8.7
ORACLE_SUPPORT_PRODUCT=3D"Oracle Linux"
ORACLE_SUPPORT_PRODUCT_VERSION=3D8.7




-[~:#]- cat /etc/oracle-release
Oracle Linux Server release 8.7



-[~:#]- cat /etc/redhat-release
Red Hat Enterprise Linux release 8.7 (Ootpa)

On Tue, May 2, 2023 at 2:06=E2=80=AFPM Antonio Quartulli <a@...2181...> wro=
te:

> Hi,
>
> On 02/05/2023 20:38, Shawn Asmussen wrote:
> > Today I began to setup a test platform in our organization for openvpn
> > DCO. We are running Oracle's OEL 8. The make of the dco module fails,
> > and I suspect that it is because the Makefile detects EL8, and tries to
> > compile using a configuration that is specific to RHEL's custom kernel
> > source code. However, Oracle Linux, by default uses
> > their own custom kernel called the UEK (Unbreakable Enterprise Kernel).
> > Commenting out the EL8 check in the Makefile results in the module
> > compiling, but I still have to configure the rest of the pieces of the
> > test before I can verify that the compiled module is functional.
>
> Unfortunately this is a bit of a mess with distros claiming to have a
> certain kernel, but then supporting features that do not belong to it.
>
> The RHEL workaround is just a way to deal with it in the Red Hat world.
>
> Somebody else on GitHub already reported about this logic not working
> for CentOS.
>
> Can you please paste the content of your /etc/redhat-release ?
>
> Regards,
>
> >
> >
> > -[~/dco-test/ovpn-dco:$]- make
> > /buildhome/oracle8/build/dco-test/ovpn-dco/gen-compat-autoconf.sh
> > /buildhome/oracle8/build/dco-test/ovpn-dco/compat-autoconf.h
> > make -C /lib/modules/5.4.17-2136.318.7.1.el8uek.x86_64/build
> > M=3D/buildhome/oracle8/build/dco-test/ovpn-dco
> > PWD=3D/buildhome/oracle8/build/dco-test/ovpn-dco REVISION=3D0.2.20230426
> > CONFIG_OVPN_DCO_V2=3Dm INSTALL_MOD_DIR=3Dupdates/    modules
> > make[1]: Entering directory
> > '/usr/src/kernels/5.4.17-2136.318.7.1.el8uek.x86_64'
> >    CC [M]
> >   /buildhome/oracle8/build/dco-test/ovpn-dco/drivers/net/ovpn-dco/main.o
> >
> /buildhome/oracle8/build/dco-test/ovpn-dco/drivers/net/ovpn-dco/main.c:11=
3:28:
> error: =E2=80=98dev_get_tstats64=E2=80=99 undeclared here (not in a funct=
ion); did you mean
> =E2=80=98dev_get_stats=E2=80=99?
> >    .ndo_get_stats64        =3D dev_get_tstats64,
> >                              ^~~~~~~~~~~~~~~~
> >                              dev_get_stats
> > make[3]: *** [scripts/Makefile.build:268:
> > /buildhome/oracle8/build/dco-test/ovpn-dco/drivers/net/ovpn-dco/main.o]
> > Error 1
> > make[2]: *** [scripts/Makefile.build:503:
> > /buildhome/oracle8/build/dco-test/ovpn-dco/drivers/net/ovpn-dco] Error 2
> > make[1]: *** [Makefile:1798: /buildhome/oracle8/build/dco-test/ovpn-dco]
> > Error 2
> > make[1]: Leaving directory
> > '/usr/src/kernels/5.4.17-2136.318.7.1.el8uek.x86_64'
> > make: *** [Makefile:59: all] Error 2
> >
> >
> > _______________________________________________
> > Openvpn-devel mailing list
> > Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
> --
> Antonio Quartulli
>

--0000000000004c6d6105fabc7a7b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Certainly. Here is the contents of the redhat-release, ora=
cle-release, and os-release files. It&#39;s also worth noting that the UEK =
kernel is optional on OEL, so theoretically an OEL system can be running ei=
ther the RHEL kernel (A recompile of the RHEL source code, just like CentOS=
 8 used to be before the change), or Oracle&#39;s own UEK kernel. In my exp=
erience, most people using Oracle tend to stick with the Oracle UEK kernel,=
 though. Therefore, an OEL user could either need the RHEL configuration wh=
en compiling the DCO module, or not, depending on which kernel they were co=
mpiling against.<div><br></div><div>-[~:#]- cat /etc/os-release<br>NAME=3D&=
quot;Oracle Linux Server&quot;<br>VERSION=3D&quot;8.7&quot;<br>ID=3D&quot;o=
l&quot;<br>ID_LIKE=3D&quot;fedora&quot;<br>VARIANT=3D&quot;Server&quot;<br>=
VARIANT_ID=3D&quot;server&quot;<br>VERSION_ID=3D&quot;8.7&quot;<br>PLATFORM=
_ID=3D&quot;platform:el8&quot;<br>PRETTY_NAME=3D&quot;Oracle Linux Server 8=
.7&quot;<br>ANSI_COLOR=3D&quot;0;31&quot;<br>CPE_NAME=3D&quot;cpe:/o:oracle=
:linux:8:7:server&quot;<br>HOME_URL=3D&quot;<a href=3D"https://linux.oracle=
.com/">https://linux.oracle.com/</a>&quot;<br>BUG_REPORT_URL=3D&quot;<a hre=
f=3D"https://bugzilla.oracle.com/">https://bugzilla.oracle.com/</a>&quot;<b=
r><br>ORACLE_BUGZILLA_PRODUCT=3D&quot;Oracle Linux 8&quot;<br>ORACLE_BUGZIL=
LA_PRODUCT_VERSION=3D8.7<br>ORACLE_SUPPORT_PRODUCT=3D&quot;Oracle Linux&quo=
t;<br>ORACLE_SUPPORT_PRODUCT_VERSION=3D8.7<br><br><br><br><br>-[~:#]- cat /=
etc/oracle-release<br>Oracle Linux Server release 8.7<br><br><br><br>-[~:#]=
- cat /etc/redhat-release<br>Red Hat Enterprise Linux release 8.7 (Ootpa)<b=
r></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Tue, May 2, 2023 at 2:06=E2=80=AFPM Antonio Quartulli &lt;<a hre=
f=3D"mailto:a@...2181...">a@...2181...</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On 02/05/2023 20:38, Shawn Asmussen wrote:<br>
&gt; Today I began to setup a test platform in our organization for openvpn=
 <br>
&gt; DCO. We are running Oracle&#39;s=C2=A0OEL 8. The make of the dco modul=
e fails, <br>
&gt; and I suspect that it is because the Makefile detects EL8, and tries t=
o <br>
&gt; compile using a configuration that is specific to RHEL&#39;s custom ke=
rnel <br>
&gt; source code. However, Oracle Linux, by default uses<br>
&gt; their own custom kernel called the UEK (Unbreakable Enterprise Kernel)=
. <br>
&gt; Commenting out the EL8 check in the Makefile results in the module <br>
&gt; compiling, but I still have to configure the rest of the pieces of the=
 <br>
&gt; test before I can verify that the compiled module is functional.<br>
<br>
Unfortunately this is a bit of a mess with distros claiming to have a <br>
certain kernel, but then supporting features that do not belong to it.<br>
<br>
The RHEL workaround is just a way to deal with it in the Red Hat world.<br>
<br>
Somebody else on GitHub already reported about this logic not working <br>
for CentOS.<br>
<br>
Can you please paste the content of your /etc/redhat-release ?<br>
<br>
Regards,<br>
<br>
&gt; <br>
&gt; <br>
&gt; -[~/dco-test/ovpn-dco:$]- make<br>
&gt; /buildhome/oracle8/build/dco-test/ovpn-dco/gen-compat-autoconf.sh <br>
&gt; /buildhome/oracle8/build/dco-test/ovpn-dco/compat-autoconf.h<br>
&gt; make -C /lib/modules/5.4.17-2136.318.7.1.el8uek.x86_64/build <br>
&gt; M=3D/buildhome/oracle8/build/dco-test/ovpn-dco <br>
&gt; PWD=3D/buildhome/oracle8/build/dco-test/ovpn-dco REVISION=3D0.2.202304=
26 <br>
&gt; CONFIG_OVPN_DCO_V2=3Dm INSTALL_MOD_DIR=3Dupdates/ =C2=A0 =C2=A0modules=
<br>
&gt; make[1]: Entering directory <br>
&gt; &#39;/usr/src/kernels/5.4.17-2136.318.7.1.el8uek.x86_64&#39;<br>
&gt;=C2=A0 =C2=A0 CC [M] <br>
&gt;=C2=A0 =C2=A0/buildhome/oracle8/build/dco-test/ovpn-dco/drivers/net/ovp=
n-dco/main.o<br>
&gt; /buildhome/oracle8/build/dco-test/ovpn-dco/drivers/net/ovpn-dco/main.c=
:113:28: error: =E2=80=98dev_get_tstats64=E2=80=99 undeclared here (not in =
a function); did you mean =E2=80=98dev_get_stats=E2=80=99?<br>
&gt;=C2=A0 =C2=A0 .ndo_get_stats64 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D dev_get_t=
stats64,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_get_stats<br>
&gt; make[3]: *** [scripts/Makefile.build:268: <br>
&gt; /buildhome/oracle8/build/dco-test/ovpn-dco/drivers/net/ovpn-dco/main.o=
] <br>
&gt; Error 1<br>
&gt; make[2]: *** [scripts/Makefile.build:503: <br>
&gt; /buildhome/oracle8/build/dco-test/ovpn-dco/drivers/net/ovpn-dco] Error=
 2<br>
&gt; make[1]: *** [Makefile:1798: /buildhome/oracle8/build/dco-test/ovpn-dc=
o] <br>
&gt; Error 2<br>
&gt; make[1]: Leaving directory <br>
&gt; &#39;/usr/src/kernels/5.4.17-2136.318.7.1.el8uek.x86_64&#39;<br>
&gt; make: *** [Makefile:59: all] Error 2<br>
&gt; <br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; Openvpn-devel mailing list<br>
&gt; <a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blan=
k">Openvpn-devel@lists.sourceforge.net</a><br>
&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/l=
istinfo/openvpn-devel</a><br>
<br>
-- <br>
Antonio Quartulli<br>
</blockquote></div>

--0000000000004c6d6105fabc7a7b--

