From: Magnus Larsson <list@...2692...>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_7F69D9C8-30F8-4F14-912E-10621AED915A"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Message-Id: <6900ED88-65D7-450E-8A3A-3D9509D206AD@...2692...>
Date: Wed, 17 Aug 2022 21:37:37 -0400
Subject: [Openvpn-devel] Possible bug?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Apple-Mail=_7F69D9C8-30F8-4F14-912E-10621AED915A
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I just moved from Ubuntu 20.04 LTS (where the exact command works fine and =
does not prompt for pass phrase) to Red Hat Enterprise Linux 9 and installe=
d Easy-RSA via EPEL.

When I run ./easyrsa build-ca nopass as root, it still prompts for PEM pass=
 phrase:


# ./easyrsa build-ca nopass
Using SSL: openssl OpenSSL 3.0.1 14 Dec 2021 (Library: OpenSSL 3.0.1 14 Dec=
 2021)
Enter PEM pass phrase:
Enter PEM pass phrase:
Enter PEM pass phrase:
Enter PEM pass phrase:
80DB8DBF7D7F0000:error:0480006D:PEM routines:PEM_def_callback:problems gett=
ing password:crypto/pem/pem_lib.c:62:
80DB8DBF7D7F0000:error:07880109:common libcrypto routines:do_ui_passphrase:=
interrupted or cancelled:crypto/passphrase.c:175:
80DB8DBF7D7F0000:error:1C80009F:Provider routines:p8info_to_encp8:unable to=
 get passphrase:providers/implementations/encode_decode/encode_key2any.c:11=
6:


# ./easyrsa --version
EasyRSA Version Information
Version:     3.0.8
Generated:   Wed Sep  9 15:59:45 CDT 2020
SSL Lib:     OpenSSL 3.0.1 14 Dec 2021 (Library: OpenSSL 3.0.1 14 Dec 2021)
Git Commit:  f12e00e53b4f486ce3d119ca429198780fa694ac
Source Repo: https://github.com/OpenVPN/easy-rsa


# ls -l
total 8
lrwxrwxrwx 1 root root   29 Aug 17 18:56 easyrsa -> /usr/share/easy-rsa/3/e=
asyrsa
lrwxrwxrwx 1 root root   41 Aug 17 18:56 openssl-easyrsa.cnf -> /usr/share/=
easy-rsa/3/openssl-easyrsa.cnf
drwx------ 9 root root 4096 Aug 17 20:10 pki
-rw-r--r-- 1 root root  332 Aug 17 18:56 vars
lrwxrwxrwx 1 root root   36 Aug 17 18:56 vars.example -> /usr/share/doc/eas=
y-rsa/vars.example
lrwxrwxrwx 1 root root   32 Aug 17 18:56 x509-types -> /usr/share/easy-rsa/=
3/x509-types


# cat /etc/os-release
NAME=3D"Red Hat Enterprise Linux"
VERSION=3D"9.0 (Plow)"
ID=3D"rhel"
ID_LIKE=3D"fedora"
VERSION_ID=3D"9.0"
PLATFORM_ID=3D"platform:el9"
PRETTY_NAME=3D"Red Hat Enterprise Linux 9.0 (Plow)"
ANSI_COLOR=3D"0;31"
LOGO=3D"fedora-logo-icon"
CPE_NAME=3D"cpe:/o:redhat:enterprise_linux:9::baseos"
HOME_URL=3D"https://www.redhat.com/"
DOCUMENTATION_URL=3D"https://access.redhat.com/documentation/red_hat_enterp=
rise_linux/9/"
BUG_REPORT_URL=3D"https://bugzilla.redhat.com/"

REDHAT_BUGZILLA_PRODUCT=3D"Red Hat Enterprise Linux 9"
REDHAT_BUGZILLA_PRODUCT_VERSION=3D9.0
REDHAT_SUPPORT_PRODUCT=3D"Red Hat Enterprise Linux"
REDHAT_SUPPORT_PRODUCT_VERSION=3D"9.0"


# dnf repolist
Updating Subscription Management repositories.
repo id                                                                    =
repo name
codeready-builder-for-rhel-9-x86_64-rpms                                   =
Red Hat CodeReady Linux Builder for RHEL 9 x86_64 (RPMs)
epel                                                                       =
Extra Packages for Enterprise Linux 9 - x86_64
rhel-9-for-x86_64-appstream-rpms                                           =
Red Hat Enterprise Linux 9 for x86_64 - AppStream (RPMs)
rhel-9-for-x86_64-baseos-rpms                                              =
Red Hat Enterprise Linux 9 for x86_64 - BaseOS (RPMs)


# getenforce
Disabled


# uname -a
Linux test 5.14.0-70.22.1.el9_0.x86_64 #1 SMP PREEMPT Tue Aug 2 10:02:12 ED=
T 2022 x86_64 x86_64 x86_64 GNU/Linux


Let me know if you need additional information.

Thanks,
Magnus


--Apple-Mail=_7F69D9C8-30F8-4F14-912E-10621AED915A
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dus-ascii"></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode=
: space; line-break: after-white-space;" class=3D"">Hi,<div class=3D""><br =
class=3D""></div><div class=3D"">I just moved from Ubuntu 20.04 LTS (where =
the exact command works fine and does not prompt for pass phrase) to Red Ha=
t Enterprise Linux 9 and installed Easy-RSA via EPEL.</div><div class=3D"">=
<br class=3D""></div><div class=3D"">When I run<font face=3D"Menlo" class=
=3D"">&nbsp;./easyrsa&nbsp;build-ca nopass </font>as root, it still prompts=
 for PEM pass phrase:</div><div class=3D""><br class=3D""></div><div class=
=3D""><br class=3D""></div><div class=3D""><div class=3D""><font face=3D"Me=
nlo" class=3D""># ./easyrsa build-ca nopass</font></div><div class=3D""><fo=
nt face=3D"Menlo" class=3D"">Using SSL: openssl OpenSSL 3.0.1 14 Dec 2021 (=
Library: OpenSSL 3.0.1 14 Dec 2021)</font></div></div><div class=3D""><font=
 face=3D"Menlo" class=3D"">Enter PEM pass phrase:</font></div><div class=3D=
""><font face=3D"Menlo" class=3D"">Enter PEM pass phrase:</font></div><div =
class=3D""><font face=3D"Menlo" class=3D"">Enter PEM pass phrase:</font></d=
iv><div class=3D""><font face=3D"Menlo" class=3D"">Enter PEM pass phrase:</=
font></div><div class=3D""><font face=3D"Menlo" class=3D"">80DB8DBF7D7F0000=
:error:0480006D:PEM routines:PEM_def_callback:problems getting password:cry=
pto/pem/pem_lib.c:62:</font></div><div class=3D""><font face=3D"Menlo" clas=
s=3D"">80DB8DBF7D7F0000:error:07880109:common libcrypto routines:do_ui_pass=
phrase:interrupted or cancelled:crypto/passphrase.c:175:</font></div><div c=
lass=3D""><font face=3D"Menlo" class=3D"">80DB8DBF7D7F0000:error:1C80009F:P=
rovider routines:p8info_to_encp8:unable to get passphrase:providers/impleme=
ntations/encode_decode/encode_key2any.c:116:</font></div><div class=3D""><f=
ont face=3D"Menlo" class=3D""><br class=3D""></font></div><div class=3D""><=
font face=3D"Menlo" class=3D""><br class=3D""></font></div><div class=3D"">=
<font face=3D"Menlo" class=3D"">#&nbsp;./easyrsa --version</font></div><div=
 class=3D""><div class=3D""><font face=3D"Menlo" class=3D"">EasyRSA Version=
 Information</font></div><div class=3D""><font face=3D"Menlo" class=3D"">Ve=
rsion: &nbsp; &nbsp; 3.0.8</font></div><div class=3D""><font face=3D"Menlo"=
 class=3D"">Generated: &nbsp; Wed Sep &nbsp;9 15:59:45 CDT 2020</font></div=
><div class=3D""><font face=3D"Menlo" class=3D"">SSL Lib: &nbsp; &nbsp; Ope=
nSSL 3.0.1 14 Dec 2021 (Library: OpenSSL 3.0.1 14 Dec 2021)</font></div><di=
v class=3D""><font face=3D"Menlo" class=3D"">Git Commit: &nbsp;f12e00e53b4f=
486ce3d119ca429198780fa694ac</font></div><div class=3D""><font face=3D"Menl=
o" class=3D"">Source Repo: <a href=3D"https://github.com/OpenVPN/easy-rsa" =
class=3D"">https://github.com/OpenVPN/easy-rsa</a></font></div></div><div c=
lass=3D""><font face=3D"Menlo" class=3D""><br class=3D""></font></div><div =
class=3D""><font face=3D"Menlo" class=3D""><br class=3D""></font></div><div=
 class=3D""><font face=3D"Menlo" class=3D"">#&nbsp;ls -l</font></div><div c=
lass=3D""><font face=3D"Menlo" class=3D"">total 8</font></div><div class=3D=
""><font face=3D"Menlo" class=3D"">lrwxrwxrwx 1 root root &nbsp; 29 Aug 17 =
18:56 easyrsa -&gt; /usr/share/easy-rsa/3/easyrsa</font></div><div class=3D=
""><font face=3D"Menlo" class=3D"">lrwxrwxrwx 1 root root &nbsp; 41 Aug 17 =
18:56 openssl-easyrsa.cnf -&gt; /usr/share/easy-rsa/3/openssl-easyrsa.cnf</=
font></div><div class=3D""><font face=3D"Menlo" class=3D"">drwx------ 9 roo=
t root 4096 Aug 17 20:10 pki</font></div><div class=3D""><font face=3D"Menl=
o" class=3D"">-rw-r--r-- 1 root root &nbsp;332 Aug 17 18:56 vars</font></di=
v><div class=3D""><font face=3D"Menlo" class=3D"">lrwxrwxrwx 1 root root &n=
bsp; 36 Aug 17 18:56 vars.example -&gt; /usr/share/doc/easy-rsa/vars.exampl=
e</font></div><div class=3D""><font face=3D"Menlo" class=3D"">lrwxrwxrwx 1 =
root root &nbsp; 32 Aug 17 18:56 x509-types -&gt; /usr/share/easy-rsa/3/x50=
9-types</font></div><div class=3D""><font face=3D"Menlo" class=3D""><br cla=
ss=3D""></font></div><div class=3D""><font face=3D"Menlo" class=3D""><br cl=
ass=3D""></font></div><div class=3D""><font face=3D"Menlo" class=3D""># cat=
 /etc/os-release</font></div><div class=3D""><font face=3D"Menlo" class=3D"=
">NAME=3D"Red Hat Enterprise Linux"</font></div><div class=3D""><font face=
=3D"Menlo" class=3D"">VERSION=3D"9.0 (Plow)"</font></div><div class=3D""><f=
ont face=3D"Menlo" class=3D"">ID=3D"rhel"</font></div><div class=3D""><font=
 face=3D"Menlo" class=3D"">ID_LIKE=3D"fedora"</font></div><div class=3D""><=
font face=3D"Menlo" class=3D"">VERSION_ID=3D"9.0"</font></div><div class=3D=
""><font face=3D"Menlo" class=3D"">PLATFORM_ID=3D"platform:el9"</font></div=
><div class=3D""><font face=3D"Menlo" class=3D"">PRETTY_NAME=3D"Red Hat Ent=
erprise Linux 9.0 (Plow)"</font></div><div class=3D""><font face=3D"Menlo" =
class=3D"">ANSI_COLOR=3D"0;31"</font></div><div class=3D""><font face=3D"Me=
nlo" class=3D"">LOGO=3D"fedora-logo-icon"</font></div><div class=3D""><font=
 face=3D"Menlo" class=3D"">CPE_NAME=3D"cpe:/o:redhat:enterprise_linux:9::ba=
seos"</font></div><div class=3D""><font face=3D"Menlo" class=3D"">HOME_URL=
=3D"<a href=3D"https://www.redhat.com/" class=3D"">https://www.redhat.com/<=
/a>"</font></div><div class=3D""><font face=3D"Menlo" class=3D"">DOCUMENTAT=
ION_URL=3D"<a href=3D"https://access.redhat.com/documentation/red_hat_enter=
prise_linux/9/" class=3D"">https://access.redhat.com/documentation/red_hat_=
enterprise_linux/9/</a>"</font></div><div class=3D""><font face=3D"Menlo" c=
lass=3D"">BUG_REPORT_URL=3D"<a href=3D"https://bugzilla.redhat.com/" class=
=3D"">https://bugzilla.redhat.com/</a>"</font></div><div class=3D""><font f=
ace=3D"Menlo" class=3D""><br class=3D""></font></div><div class=3D""><font =
face=3D"Menlo" class=3D"">REDHAT_BUGZILLA_PRODUCT=3D"Red Hat Enterprise Lin=
ux 9"</font></div><div class=3D""><font face=3D"Menlo" class=3D"">REDHAT_BU=
GZILLA_PRODUCT_VERSION=3D9.0</font></div><div class=3D""><font face=3D"Menl=
o" class=3D"">REDHAT_SUPPORT_PRODUCT=3D"Red Hat Enterprise Linux"</font></d=
iv><div class=3D""><font face=3D"Menlo" class=3D"">REDHAT_SUPPORT_PRODUCT_V=
ERSION=3D"9.0"</font></div><div class=3D""><font face=3D"Menlo" class=3D"">=
<br class=3D""></font></div><div class=3D""><font face=3D"Menlo" class=3D""=
><br class=3D""></font></div><div class=3D""><font face=3D"Menlo" class=3D"=
">#&nbsp;dnf repolist</font></div><div class=3D""><font face=3D"Menlo" clas=
s=3D"">Updating Subscription Management repositories.</font></div><div clas=
s=3D""><font face=3D"Menlo" class=3D"">repo id &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;repo name</font>=
</div><div class=3D""><font face=3D"Menlo" class=3D"">codeready-builder-for=
-rhel-9-x86_64-rpms &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Red Hat Cod=
eReady Linux Builder for RHEL 9 x86_64 (RPMs)</font></div><div class=3D""><=
font face=3D"Menlo" class=3D"">epel &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Extra Packages for =
Enterprise Linux 9 - x86_64</font></div><div class=3D""><font face=3D"Menlo=
" class=3D"">rhel-9-for-x86_64-appstream-rpms &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Red Hat Enterprise Linux 9 for x=
86_64 - AppStream (RPMs)</font></div><div class=3D""><font face=3D"Menlo" c=
lass=3D"">rhel-9-for-x86_64-baseos-rpms &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Red Hat Enterprise Linux =
9 for x86_64 - BaseOS (RPMs)</font></div><div class=3D""><font face=3D"Menl=
o" class=3D""><br class=3D""></font></div><div class=3D""><font face=3D"Men=
lo" class=3D""><br class=3D""></font></div><div class=3D""><font face=3D"Me=
nlo" class=3D"">#&nbsp;getenforce</font></div><div class=3D""><font face=3D=
"Menlo" class=3D"">Disabled</font></div><div class=3D""><font face=3D"Menlo=
" class=3D""><br class=3D""></font></div><div class=3D""><font face=3D"Menl=
o" class=3D""><br class=3D""></font></div><div class=3D""><font face=3D"Men=
lo" class=3D"">#&nbsp;uname -a</font></div><div class=3D""><font face=3D"Me=
nlo" class=3D"">Linux test 5.14.0-70.22.1.el9_0.x86_64 #1 SMP PREEMPT Tue A=
ug 2 10:02:12 EDT 2022 x86_64 x86_64 x86_64 GNU/Linux</font></div><div clas=
s=3D""><font face=3D"Menlo" class=3D""><br class=3D""></font></div><div cla=
ss=3D""><br class=3D""></div><div class=3D"">Let me know if you need additi=
onal information.</div><div class=3D""><br class=3D""></div><div class=3D""=
>Thanks,</div><div class=3D"">Magnus</div><div class=3D""><br class=3D""></=
div></body></html>=

--Apple-Mail=_7F69D9C8-30F8-4F14-912E-10621AED915A--

