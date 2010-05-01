Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: multipart/mixed; boundary=Apple-Mail-42-182273120
From: Brian Raderman <brian@...1360...>
In-Reply-To: <4BD7DB78.2010704@...1114...>
Date: Sat, 1 May 2010 02:18:52 -0400
Message-Id: <C5DC4FDD-13FA-45AC-9D17-35BE15E03C1D@...1360...>
References: <B23F897A-5ADC-4A29-A34B-3BB16C18B4F3@...1360...>
	<4BD7DB78.2010704@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Mac OSX Keychain certificate support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

--Apple-Mail-42-182273120
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi David,

Thank you for taking a look at the patch and providing such thorough feedba=
ck so quickly.  I have done everything that you asked:

* Changed printf() calls to use msg().  The prints are not actually used ri=
ght now, but they are a part of the debug code that I wrote for testing the=
 certificate reading functions.  They were actually tested in a separate ap=
plication, but I thought I should keep them with the rest of the code in ca=
se the certificate lookup functionality needs to be debugged inside of open=
vpn at a later date.

* Changed malloc calls to the gc_arena api.

* Removed the XCode project and updated configure.ac and Makefile.am to pro=
perly build the changes.  I was well aware that this is what needed to be d=
one, I only included the XCode project in the first patch in the hopes that=
 someone with XCode and Automake knowledge would take a look at it and give=
 me some pointers.  You were correct, though, it was not as bad as I though=
t it was going to be.  The information you provided was very useful.=20=20

* Removed the dummy1() function from keychain.c.  Keychain.c/.h are based o=
n cryptoapi.c/.h in the openvpn source tree.  When editing the original fil=
e to work with the Keychain services libraries instead of the Windows Crypt=
o API, I decided to change as little as possible, the theory being that wha=
t was there was approved and accepted.  You will see a static dummy() funct=
ion defined at the bottom of that file as well.  I had no idea what it was =
there for, but I figured there was a reason for it so I left it alone.  I t=
hink I tacked on the 1 to the end without thinking too hard because I was b=
eing very defensive and trying to prevent a scope problem, which was silly =
of me because the function is static and you would never compile Windows-on=
ly and Mac-only code at the same time.  If you grep for "dummy" in the sour=
ce tree, you will see a number of places where this paradigm is used.  Perh=
aps because some compilers will not compile a file that has had all of its =
code ifdef'd out?  I tested this theory on my mac and no error occurred, so=
 I went ahead and removed the function per your request.  I should also poi=
nt out that cryptoapi.c makes calls to calloc, which you may want to change=
 at some point if you are trying to standardize on the gc_arena API.

Please let me know if you have any questions or if more changes are require=
d.

Thanks,
Brian Raderman



--Apple-Mail-42-182273120
Content-Disposition: attachment;
	filename=osxkeychain.patch
Content-Type: application/octet-stream;
	name="osxkeychain.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20c157d2a2704cff2e03c92f296532f20aa88db710=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Brian=20Raderman=20=
<brian@...1360...>=0ADate:=20Wed,=2028=20Apr=202010=20=
00:26:00=20-0400=0ASubject:=20[PATCH]=20Adding=20functionality=20that=20=
allows=20the=20use=20of=20Mac=20OSX=20Keychain=20certificates=20to=20=
authenticate=20with=20the=20server=20so=20that=20the=20certificate=20and=20=
the=20private=20key=20don't=20need=20to=20be=20stored=20in=20the=20=
config=20file.=20This=20also=20supports=20hardware=20tokens=20that=20=
conform=20to=20Apple's=20tokend=20specification=20and=20can=20be=20=
accessed=20like=20any=20other=20Keychain=20certificate.=20The=20changes=20=
are=20based=20on=20the=20Crypto=20API=20functionality=20for=20Windows=20=
that=20already=20exists=20in=20the=20cryptoapi.c/.h=20files.=0A=0A=
Signed-off-by:=20Brian=20Raderman=20<brian@...1360...>=0A=
---=0A=20Makefile.am=20=20=20=20=20=20|=20=20=20=209=20+-=0A=20=
configure.ac=20=20=20=20=20|=20=20=2019=20++=0A=20openvpn.8=20=20=20=20=20=
=20=20=20|=20=20=2057=20+++++=0A=20options.c=20=20=20=20=20=20=20=20|=20=20=
=2040=20+++-=0A=20options.h=20=20=20=20=20=20=20=20|=20=20=20=203=20+=0A=20=
osx/cert_data.c=20=20|=20=20641=20=
++++++++++++++++++++++++++++++++++++++++++++++++++++++=0A=20=
osx/cert_data.h=20=20|=20=20=2046=20++++=0A=20osx/common_osx.c=20|=20=20=20=
99=20+++++++++=0A=20osx/common_osx.h=20|=20=20=2036=20+++=0A=20=
osx/crypto_osx.c=20|=20=20=2076=20+++++++=0A=20osx/crypto_osx.h=20|=20=20=
=2034=20+++=0A=20osx/keychain.c=20=20=20|=20=20290=20=
++++++++++++++++++++++++=0A=20osx/keychain.h=20=20=20|=20=20=20=207=20+=0A=
=20ssl.c=20=20=20=20=20=20=20=20=20=20=20=20|=20=20=2010=20+=0A=2014=20=
files=20changed,=201363=20insertions(+),=204=20deletions(-)=0A=20create=20=
mode=20100755=20osx/cert_data.c=0A=20create=20mode=20100755=20=
osx/cert_data.h=0A=20create=20mode=20100755=20osx/common_osx.c=0A=20=
create=20mode=20100755=20osx/common_osx.h=0A=20create=20mode=20100755=20=
osx/crypto_osx.c=0A=20create=20mode=20100755=20osx/crypto_osx.h=0A=20=
create=20mode=20100755=20osx/keychain.c=0A=20create=20mode=20100755=20=
osx/keychain.h=0A=0Adiff=20--git=20a/Makefile.am=20b/Makefile.am=0Aindex=20=
4cc3ce2..652a9bb=20100644=0A---=20a/Makefile.am=0A+++=20b/Makefile.am=0A=
@@=20-137,8=20+137,15=20@@=20openvpn_SOURCES=20=3D=20\=0A=20=09thread.c=20=
thread.h=20\=0A=20=09tun.c=20tun.h=20\=0A=20=09win32.h=20win32.c=20\=0A-=09=
cryptoapi.h=20cryptoapi.c=0A+=20=20=20=20cryptoapi.h=20cryptoapi.c=0A=20=0A=
+if=20KEYCHAINCERT=0A+openvpn_SOURCES=20+=3D=20\=0A+=09osx/cert_data.h=20=
osx/cert_data.c=20\=0A+=09osx/common_osx.h=20osx/common_osx.c=20\=0A+=09=
osx/crypto_osx.h=20osx/crypto_osx.c=20\=0A+=09osx/keychain.h=20=
osx/keychain.c=0A+endif=0A=20=0A=20dist-hook:=0A=20=09cd=20$(distdir)=20=
&&=20for=20i=20in=20$(EXTRA_DIST)=20$(SUBDIRS)=20;=20do=20find=20$$i=20=
-name=20.svn=20-type=20d=20-prune=20-exec=20rm=20-rf=20'{}'=20';'=20;=20=
rm=20-f=20`find=20$$i=20-type=20f=20|=20grep=20-E=20=
'(^|\/)\.?\#|\~$$|\.s?o$$'`=20;=20done=0Adiff=20--git=20a/configure.ac=20=
b/configure.ac=0Aindex=204f7231a..5c5e5b5=20100644=0A---=20=
a/configure.ac=0A+++=20b/configure.ac=0A@@=20-212,6=20+212,12=20@@=20=
AC_ARG_ENABLE(selinux,=0A=20=20=20=20[SELINUX=3D"yes"]=0A=20)=0A=20=0A=
+AC_ARG_ENABLE(keychaincert,=0A+=20=20=20[=20=20--disable-keychaincert=20=
=20Disable=20support=20for=20Mac=20OSX=20Keychain=20certificate=20=
services=20(Mac=20OSX=20only)],=0A+=20=20=20[KEYCHAINCERT=3D"$enableval"],=
=0A+=20=20=20[KEYCHAINCERT=3D"yes"]=0A+)=0A+=0A=20=
AC_ARG_WITH(ssl-headers,=0A=20=20=20=20[=20=20--with-ssl-headers=3DDIR=20=
=20Crypto/SSL=20Include=20files=20location],=0A=20=20=20=20=
[CS_HDR_DIR=3D"$withval"]=0A@@=20-276,6=20+282,7=20@@=20dnl=20fix=20=
search=20path,=20to=20allow=20compilers=20to=20find=20syshead.h=0A=20=
CPPFLAGS=3D"$CPPFLAGS=20-I${srcdir}"=0A=20=0A=20dnl=20check=20target=20=
OS=0A+MACOSX=3D"no"=0A=20openvpn_target=3D$target=0A=20if=20test=20=
$target_alias;=20then=0A=20=20=20openvpn_target=3D$target_alias=0A@@=20=
-305,6=20+312,7=20@@=20case=20"$target"=20in=0A=20=09dnl=20some=20Mac=20=
OS=20X=20tendering=20(we=20use=20vararg=20macros...)=0A=20=09=
AC_DEFINE(TARGET_DARWIN,=201,=20[Are=20we=20running=20on=20Mac=20OS=20=
X?])=0A=20=09CPPFLAGS=3D"$CPPFLAGS=20-no-cpp-precomp"=0A+=09MACOSX=3D"yes"=
=0A=20=09;;=0A=20*mingw*)=0A=20=09AC_DEFINE(TARGET_WIN32,=201,=20[Are=20=
we=20running=20WIN32?])=0A@@=20-886,6=20+894,17=20@@=20if=20test=20=
"$SELINUX"=20=3D=20"yes";=20then=0A=20=20=20=20)=0A=20fi=0A=20=0A+dnl=20=
enable=20Mac=20OSX=20Keychain=20certificate=20support=0A+if=20test=20=
"$MACOSX"=20=3D=20"yes"=20-a=20"$KEYCHAINCERT"=20=3D=20"yes";=20then=0A+=09=
OPENVPN_ADD_LIBS(-framework=20CoreFoundation)=0A+=09=
OPENVPN_ADD_LIBS(-framework=20Security)=0A+=09AC_DEFINE(KEYCHAINCERT,=20=
1,=20[Enable=20support=20for=20MAc=20OSX=20Keychain=20certificate=20=
services])=0A+else=0A+=09KEYCHAINCERT=3D"no"=0A+fi=0A+=0A=
+AM_CONDITIONAL(KEYCHAINCERT,=20test=20"$KEYCHAINCERT"=20=3D=20"yes")=0A=
+=0A=20TAP_ID=3D"PRODUCT_TAP_ID"=0A=20=
TAP_WIN32_MIN_MAJOR=3D"PRODUCT_TAP_WIN32_MIN_MAJOR"=0A=20=
TAP_WIN32_MIN_MINOR=3D"PRODUCT_TAP_WIN32_MIN_MINOR"=0Adiff=20--git=20=
a/openvpn.8=20b/openvpn.8=0Aindex=2045e61fa..f3ff3da=20100644=0A---=20=
a/openvpn.8=0A+++=20b/openvpn.8=0A@@=20-3928,6=20+3928,63=20@@=20=
Certificate=20Store=20GUI.=0A=20=0A=20=
.\"*********************************************************=0A=20.TP=0A=
+.B=20--keychaincert=20select-string=0A+Load=20the=20certificate=20and=20=
private=20key=20from=20the=0A+Mac=20OSX=20Keychain=20(Mac=20OSX=20Only).=0A=
+=0A+Use=20this=20option=20instead=20of=0A+.B=20--cert=0A+and=0A+.B=20=
--key.=0A+=0A+This=20makes=20it=20possible=20to=20use=20any=20smart=20=
card=20supported=20by=20Mac=20OSX=20using=20the=20tokend=20interface,=20=
but=20also=20any=0A+kind=20of=20certificate,=20residing=20in=20the=20=
Keychain,=20where=20you=20have=20access=20to=0A+the=20private=20key.=20=20=
This=20option=20has=20been=20tested=20on=20the=20client=20side=20with=20=
an=20Aladdin=20eToken=0A+on=20Mac=20OSX=20Leopard=20and=20with=20=
software=20certificates=20stored=20in=20the=20Keychain=20on=20Mac=20OSX=20=
Leopard=20and=0A+Mac=20OSX=20Snow=20Leopard.=20=20As=20of=20this=20=
writing=20(4/27/10)=20Aladdin=20has=20not=20yet=20released=20Snow=20=
Leopard=20drivers.=0A+=0A+To=20select=20a=20certificate=20based=20on=20a=20=
string=20search=20in=20the=0A+certificate's=20subject=20and/or=20issuer:=0A=
+=0A+.B=20keychaincert=0A+"SUBJECT:c=3DUS/o=3DApple=20=
Inc./ou=3Dme.com/cn=3Dusername=20ISSUER:c=3DUS/o=3DApple=20Computer,=20=
Inc./ou=3DApple=20Computer=20Certificate=20Authority/cn=3DApple=20.Mac=20=
Certificate=20Authority"=0A+=0A+.I=20"Distinguished=20Name=20Component=20=
Abbreviations:"=20=0A+.br=0A+o=20=3D=20organization=0A+.br=0A+ou=20=3D=20=
organizational=20unit=0A+.br=0A+c=20=3D=20country=0A+.br=0A+l=20=3D=20=
locality=0A+.br=0A+st=20=3D=20state=0A+.br=0A+cn=20=3D=20common=20name=0A=
+.br=0A+e=20=3D=20email=0A+.br=0A+=0A+All=20of=20the=20distinguished=20=
name=20components=20are=20optional,=20although=20you=20do=20need=20to=20=
specify=20at=20least=20one=20of=20them.=20=20You=20can=20=0A+add=20=
spaces=20around=20the=20'/'=20and=20'=3D'=20characters,=20e.g.=20=
"SUBJECT:=20c=20=3D=20US=20/=20o=20=3D=20Apple=20Inc.".=20=20You=20do=20=
not=20need=20to=20specify=0A+both=20the=20subject=20and=20the=20issuer,=20=
one=20or=20the=20other=20will=20work=20fine.=20=20The=20identity=20=
searching=20algorithm=20will=20return=20the=20first=0A+certificate=20it=20=
finds=20that=20matches=20all=20of=20the=20criteria=20you=20have=20=
specified.=20=20You=20can=20also=20include=20the=20MD5=20and/or=20SHA1=20=
thumbprints=20=0A+along=20with=20the=20subject=20and=20issuer=20(see=20=
example=20of=20thumbprint=20search=20criteria=20below).=20=20=0A+=0A+To=20=
select=20a=20certificate=20based=20on=20certificate's=20MD5=20or=20SHA1=20=
thumbprint:=0A+=0A+.B=20keychaincert=0A+"SHA1:=2030=20F7=203A=207A=20B7=20=
73=202A=2098=2054=2033=204A=20A7=2000=206F=206E=20AC=20EC=20D1=20EF=2002=20=
MD5:=20D5=20F5=2011=20F1=2038=20EB=205F=204D=20CF=2023=20B6=2094=20E8=20=
33=20D8=20B5"=0A+=0A+Again,=20you=20can=20include=20both=20the=20SHA1=20=
and=20the=20MD5=20thumbprints,=20but=20you=20can=20also=20use=20just=20=
one=20of=20them.=20=20The=20thumbprint=20hex=0A+strings=20can=20easily=20=
be=20copy-and-pasted=20from=20the=20OSX=20Keychain=20Access=20GUI=20in=20=
the=20Applications/Utilities=20folder.=20=20The=20hex=20string=20=
comparison=20is=0A+not=20case=20sensitive.=0A+=0A+Note=20that=20this=20=
option=20cannot=20be=20used=20with=20the=20--daemon=20option.=20=20Mac=20=
OSX=20needs=20to=20present=20the=20user=20with=20an=20authentication=20=
GUI=20when=20the=20Keychain=0A+is=20accessed=20by=20openvpn=20and=20the=20=
--daemon=20option=20will=20prevent=20the=20GUI=20from=20being=20shown=20=
and=20therefore=20cause=20the=20authentication=20to=20silently=20fail.=0A=
+.\"*********************************************************=0A+.TP=0A=20=
.B=20--key-method=20m=0A=20Use=20data=20channel=20key=20negotiation=20=
method=0A=20.B=20m.=0Adiff=20--git=20a/options.c=20b/options.c=0Aindex=20=
812c3de..da90a29=20100644=0A---=20a/options.c=0A+++=20b/options.c=0A@@=20=
-503,6=20+503,10=20@@=20static=20const=20char=20usage_message[]=20=3D=0A=20=
=20=20"--cryptoapicert=20select-string=20:=20Load=20the=20certificate=20=
and=20private=20key=20from=20the\n"=0A=20=20=20"=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20Windows=20Certificate=20System=20Store.\n"=0A=20=
#endif=0A+#ifdef=20KEYCHAINCERT=0A+=20=20"--keychaincert=20=20=
select-string=20:=20Load=20the=20certificate=20and=20private=20key=20=
from=20the\n"=0A+=20=20"=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20Mac=20OSX=20Keychain.\n"=0A+#endif=0A=20=20=20"--tls-cipher=20l=20=20=
:=20A=20list=20l=20of=20allowable=20TLS=20ciphers=20separated=20by=20:=20=
(optional).\n"=0A=20=20=20"=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
:=20Use=20--show-tls=20to=20see=20a=20list=20of=20supported=20TLS=20=
ciphers.\n"=0A=20=20=20"--tls-timeout=20n=20:=20Packet=20retransmit=20=
timeout=20on=20TLS=20control=20channel\n"=0A@@=20-1323,6=20+1327,9=20@@=20=
show_settings=20(const=20struct=20options=20*o)=0A=20#ifdef=20WIN32=0A=20=
=20=20SHOW_STR=20(cryptoapi_cert);=0A=20#endif=0A+#ifdef=20KEYCHAINCERT=0A=
+=09SHOW_STR=20(keychain_cert);=0A+#endif=0A=20=20=20SHOW_STR=20=
(cipher_list);=0A=20=20=20SHOW_STR=20(tls_verify);=0A=20=20=20SHOW_STR=20=
(tls_remote);=0A@@=20-1841,11=20+1848,15=20@@=20=
options_postprocess_verify_ce=20(const=20struct=20options=20*options,=20=
const=20struct=20conne=0A=20=09if=20(options->cryptoapi_cert)=0A=20=09=20=
=20msg(M_USAGE,=20"Parameter=20--cryptoapicert=20cannot=20be=20used=20=
when=20--pkcs11-provider=20is=20also=20specified.");=0A=20#endif=0A=
+#ifdef=20KEYCHAINCERT=0A+=09if=20(options->keychain_cert)=0A+=09=20=20=20=
msg(M_USAGE,=20"Parameter=20--keychaincert=20cannot=20be=20used=20when=20=
--pkcs11-provider=20is=20also=20specified.");=0A+#endif=0A=20=20=20=20=20=
=20=20=20}=0A=20=20=20=20=20=20=20else=0A=20#endif=0A=20#ifdef=20WIN32=0A=
-=20=20=20=20=20=20if=20(options->cryptoapi_cert)=0A+=09if=20=
(options->cryptoapi_cert)=0A=20=09{=0A=20=09=20=20if=20=
((!(options->ca_file))=20&&=20(!(options->ca_path)))=0A=20=09=20=20=20=20=
msg(M_USAGE,=20"You=20must=20define=20CA=20file=20(--ca)=20or=20CA=20=
path=20(--capath)");=0A@@=20-1856,9=20+1867,25=20@@=20=
options_postprocess_verify_ce=20(const=20struct=20options=20*options,=20=
const=20struct=20conne=0A=20=20=20=20=20=20=20=20=20=20=20if=20=
(options->pkcs12_file)=0A=20=09=20=20=20=20msg(M_USAGE,=20"Parameter=20=
--pkcs12=20cannot=20be=20used=20when=20--cryptoapicert=20is=20also=20=
specified.");=0A=20=09}=0A-=20=20=20=20=20=20else=0A+=09else=0A+#endif=0A=
+#ifdef=20KEYCHAINCERT=0A+=09if=20(options->keychain_cert)=0A+=09{=0A+=09=
=09if=20((!(options->ca_file))=20&&=20(!(options->ca_path)))=0A+=09=09=09=
msg(M_USAGE,=20"You=20must=20define=20CA=20file=20(--ca)=20or=20CA=20=
path=20(--capath)");=0A+=09=09if=20(options->cert_file)=0A+=09=09=09=
msg(M_USAGE,=20"Parameter=20--cert=20cannot=20be=20used=20when=20=
--keychaincert=20is=20also=20specified.");=0A+=09=09if=20=
(options->priv_key_file)=0A+=09=09=09msg(M_USAGE,=20"Parameter=20--key=20=
cannot=20be=20used=20when=20--keychaincert=20is=20also=20specified.");=0A=
+=09=09if=20(options->pkcs12_file)=0A+=09=09=09msg(M_USAGE,=20"Parameter=20=
--pkcs12=20cannot=20be=20used=20when=20--keychaincert=20is=20also=20=
specified.");=0A+=20=20=20=20=20=20=20=20if=20(options->daemon)=0A+=20=20=
=20=20=20=20=20=20=20=20=20=20msg(M_USAGE,=20"Parameter=20--daemon=20=
cannot=20be=20used=20when=20--keychaincert=20is=20also=20specified.");=0A=
+=09}=0A+=09else=0A=20#endif=0A-=20=20=20=20=20=20if=20=
(options->pkcs12_file)=0A+=20=20=20=20=20=20=20if=20=
(options->pkcs12_file)=0A=20=20=20=20=20=20=20=20=20{=0A=20=20=20=20=20=20=
=20=20=20=20=20if=20(options->ca_path)=0A=20=09=20=20=20=20msg(M_USAGE,=20=
"Parameter=20--capath=20cannot=20be=20used=20when=20--pkcs12=20is=20also=20=
specified.");=0A@@=20-5472,6=20+5499,13=20@@=20add_option=20(struct=20=
options=20*options,=0A=20=20=20=20=20=20=20options->cryptoapi_cert=20=3D=20=
p[1];=0A=20=20=20=20=20}=0A=20#endif=0A+#ifdef=20KEYCHAINCERT=20=0A+=20=20=
else=20if=20(streq=20(p[0],=20"keychaincert")=20&&=20p[1])=0A+=20=20{=0A=
+=20=20=20=20=20=20VERIFY_PERMISSION=20(OPT_P_GENERAL);=0A+=20=20=20=20=20=
=20options->keychain_cert=20=3D=20p[1];=0A+=20=20}=0A+#endif=0A=20=20=20=
else=20if=20(streq=20(p[0],=20"key")=20&&=20p[1])=0A=20=20=20=20=20{=0A=20=
=20=20=20=20=20=20VERIFY_PERMISSION=20(OPT_P_GENERAL);=0Adiff=20--git=20=
a/options.h=20b/options.h=0Aindex=20740e18e..2152079=20100644=0A---=20=
a/options.h=0A+++=20b/options.h=0A@@=20-467,6=20+467,9=20@@=20struct=20=
options=0A=20#ifdef=20WIN32=0A=20=20=20const=20char=20*cryptoapi_cert;=0A=
=20#endif=0A+#ifdef=20KEYCHAINCERT=0A+=20=20const=20char=20=
*keychain_cert;=0A+#endif=0A=20=0A=20=20=20/*=20data=20channel=20key=20=
exchange=20method=20*/=0A=20=20=20int=20key_method;=0Adiff=20--git=20=
a/osx/cert_data.c=20b/osx/cert_data.c=0Anew=20file=20mode=20100755=0A=
index=200000000..c90b0b1=0A---=20/dev/null=0A+++=20b/osx/cert_data.c=0A=
@@=20-0,0=20+1,641=20@@=0A+/*=0A+=20*=20=20OpenVPN=20--=20An=20=
application=20to=20securely=20tunnel=20IP=20networks=0A+=20*=20=20=20=20=20=
=20=20=20=20=20=20=20=20over=20a=20single=20UDP=20port,=20with=20support=20=
for=20SSL/TLS-based=0A+=20*=20=20=20=20=20=20=20=20=20=20=20=20=20=
session=20authentication=20and=20key=20exchange,=0A+=20*=20=20=20=20=20=20=
=20=20=20=20=20=20=20packet=20encryption,=20packet=20authentication,=20=
and=0A+=20*=20=20=20=20=20=20=20=20=20=20=20=20=20packet=20compression.=0A=
+=20*=0A+=20*=20=20Copyright=20(C)=202010=20Brian=20Raderman=20=
<brian@...1360...>=0A+=20*=0A+=20*=20=20This=20program=20is=20=
free=20software;=20you=20can=20redistribute=20it=20and/or=20modify=0A+=20=
*=20=20it=20under=20the=20terms=20of=20the=20GNU=20General=20Public=20=
License=20version=202=0A+=20*=20=20as=20published=20by=20the=20Free=20=
Software=20Foundation.=0A+=20*=0A+=20*=20=20This=20program=20is=20=
distributed=20in=20the=20hope=20that=20it=20will=20be=20useful,=0A+=20*=20=
=20but=20WITHOUT=20ANY=20WARRANTY;=20without=20even=20the=20implied=20=
warranty=20of=0A+=20*=20=20MERCHANTABILITY=20or=20FITNESS=20FOR=20A=20=
PARTICULAR=20PURPOSE.=20=20See=20the=0A+=20*=20=20GNU=20General=20Public=20=
License=20for=20more=20details.=0A+=20*=0A+=20*=20=20You=20should=20have=20=
received=20a=20copy=20of=20the=20GNU=20General=20Public=20License=0A+=20=
*=20=20along=20with=20this=20program=20(see=20the=20file=20COPYING=20=
included=20with=20this=0A+=20*=20=20distribution);=20if=20not,=20write=20=
to=20the=20Free=20Software=20Foundation,=20Inc.,=0A+=20*=20=2059=20=
Temple=20Place,=20Suite=20330,=20Boston,=20MA=20=2002111-1307=20=20USA=0A=
+=20*/=0A+=0A+#include=20"../syshead.h"=0A+#include=20"../error.h"=0A=
+#include=20"../buffer.h"=0A+#include=20<CommonCrypto/CommonDigest.h>=0A=
+#include=20"cert_data.h"=0A+#include=20"common_osx.h"=0A+=0A=
+CFStringRef=20kCertDataSubjectName=20=3D=20CFSTR("subject"),=20=
kCertDataIssuerName=20=3D=20CFSTR("issuer"),=20kCertDataSha1Name=20=3D=20=
CFSTR("SHA1"),=20kCertDataMd5Name=20=3D=20CFSTR("MD5"),=20=
kCertNameFwdSlash=20=3D=20CFSTR("/"),=20kCertNameEquals=20=3D=20=
CFSTR("=3D");=0A+CFStringRef=20kCertNameOrganization=20=3D=20CFSTR("o"),=20=
kCertNameOrganizationalUnit=20=3D=20CFSTR("ou"),=20kCertNameCountry=20=3D=20=
CFSTR("c"),=20kCertNameLocality=20=3D=20CFSTR("l"),=20kCertNameState=20=3D=
=20CFSTR("st"),=20kCertNameCommonName=20=3D=20CFSTR("cn"),=20=
kCertNameEmail=20=3D=20CFSTR("e"),=20kCertNameDomainComponent=20=3D=20=
CFSTR("dc");=0A+CFStringRef=20kStringSpace=20=3D=20CFSTR("=20"),=20=
kStringEmpty=20=3D=20CFSTR("");=0A+=0A+typedef=20struct=20_CertName=0A+{=0A=
+=09CFArrayRef=20countryName,=20organization,=20organizationalUnit,=20=
commonName,=20description,=20emailAddress,=20=0A+=09stateName,=20=
localityName,=20distinguishedName,=20domainComponent;=0A+}=20CertName,=20=
*CertNameRef;=09=09=0A+=0A+typedef=20struct=20_DescData=0A+{=0A+=09=
CFStringRef=20name,=20value;=0A+}=20DescData,=20*DescDataRef;=0A+=0A=
+static=20struct=20gc_arena=20g_gc;=0A+=0A+void=20initCertData()=0A+{=0A=
+=09g_gc=20=3D=20gc_new();=0A+}=0A+=0A+void=20freeCertData()=0A+{=0A+=09=
gc_free(&g_gc);=0A+}=0A+=0A+CertNameRef=20createCertName()=0A+{=0A+=09=
CertNameRef=20pCertName=20=3D=20(CertNameRef)gc_malloc(sizeof(CertName),=20=
false,=20&g_gc);=0A+=09pCertName->countryName=20=3D=20=
CFArrayCreateMutable(NULL,=200,=20&kCFTypeArrayCallBacks);=0A+=09=
pCertName->organization=20=3D=20=20CFArrayCreateMutable(NULL,=200,=20=
&kCFTypeArrayCallBacks);=0A+=09pCertName->organizationalUnit=20=3D=20=
CFArrayCreateMutable(NULL,=200,=20&kCFTypeArrayCallBacks);=0A+=09=
pCertName->commonName=20=3D=20CFArrayCreateMutable(NULL,=200,=20=
&kCFTypeArrayCallBacks);=0A+=09pCertName->description=20=3D=20=
CFArrayCreateMutable(NULL,=200,=20&kCFTypeArrayCallBacks);=09=0A+=09=
pCertName->emailAddress=20=3D=20CFArrayCreateMutable(NULL,=200,=20=
&kCFTypeArrayCallBacks);=0A+=09pCertName->stateName=20=3D=20=
CFArrayCreateMutable(NULL,=200,=20&kCFTypeArrayCallBacks);=0A+=09=
pCertName->localityName=20=3D=20CFArrayCreateMutable(NULL,=200,=20=
&kCFTypeArrayCallBacks);=0A+=09pCertName->distinguishedName=20=3D=20=
CFArrayCreateMutable(NULL,=200,=20&kCFTypeArrayCallBacks);=0A+=09=
pCertName->domainComponent=20=3D=20CFArrayCreateMutable(NULL,=200,=20=
&kCFTypeArrayCallBacks);=0A+=09return=20pCertName;=0A+}=0A+=0A+void=20=
destroyCertName(CertNameRef=20pCertName)=0A+{=09=0A+=09if=20(!pCertName)=0A=
+=09=09return;=0A+=09=0A+=09CFRelease(pCertName->countryName);=0A+=09=
CFRelease(pCertName->organization);=0A+=09=
CFRelease(pCertName->organizationalUnit);=0A+=09=
CFRelease(pCertName->commonName);=0A+=09=
CFRelease(pCertName->description);=0A+=09=
CFRelease(pCertName->emailAddress);=0A+=09=
CFRelease(pCertName->stateName);=0A+=09=
CFRelease(pCertName->localityName);=0A+=09=
CFRelease(pCertName->distinguishedName);=0A+=09=
CFRelease(pCertName->domainComponent);=0A+}=0A+=0A+=0A+CertNameRef=20=
dataToName(CSSM_DATA_PTR=20pData)=0A+{=0A+=20=20=20=20CSSM_X509_NAME_PTR=20=
pName=20=3D=20(CSSM_X509_NAME_PTR)pData->Data;=0A+=09CertNameRef=20=
pCertName=20=3D=20createCertName();=0A+=20=20=20=20int=20i,=20j;=0A+=09=20=
=20=20=20=0A+=20=20=20=20for(i=20=3D=200;i=20<=20=
pName->numberOfRDNs;i++)=0A+=20=20=20=20{=0A+=20=20=20=20=20=20=20=20=
CSSM_X509_RDN=20rdn=20=3D=20pName->RelativeDistinguishedName[i];=0A+=20=20=
=20=20=20=20=20=20=0A+=20=20=20=20=20=20=20=20for(j=20=3D=200;j=20<=20=
rdn.numberOfPairs;j++)=0A+=20=20=20=20=20=20=20=20{=0A+=20=20=20=20=20=20=
=20=20=20=20=20=20CSSM_X509_TYPE_VALUE_PAIR=20nvp=20=3D=20=
rdn.AttributeTypeAndValue[j];=0A+=09=09=09CFStringRef=20str=20=3D=20=
CFStringCreateWithBytes=20(NULL,=20nvp.value.Data,=20nvp.value.Length,=20=
kCFStringEncodingUTF8,=20false);=0A+=20=20=20=20=20=20=20=20=20=20=20=20=0A=
+=09=09=09if=20(memcmp(nvp.type.Data,=20CSSMOID_CountryName.Data,=20=
CSSMOID_CountryName.Length)=20=3D=3D=200)=0A+=09=09=09=09=
CFArrayAppendValue((CFMutableArrayRef)pCertName->countryName,=20str);=0A=
+=09=09=09else=20if=20(memcmp(nvp.type.Data,=20=
CSSMOID_OrganizationName.Data,=20CSSMOID_OrganizationName.Length)=20=3D=3D=
=200)=0A+=09=09=09=09=
CFArrayAppendValue((CFMutableArrayRef)pCertName->organization,=20str);=0A=
+=09=09=09else=20if=20(memcmp(nvp.type.Data,=20=
CSSMOID_OrganizationalUnitName.Data,=20=
CSSMOID_OrganizationalUnitName.Length)=20=3D=3D=200)=0A+=09=09=09=09=
CFArrayAppendValue((CFMutableArrayRef)pCertName->organizationalUnit,=20=
str);=0A+=09=09=09else=20if=20(memcmp(nvp.type.Data,=20=
CSSMOID_CommonName.Data,=20CSSMOID_CommonName.Length)=20=3D=3D=200)=0A+=09=
=09=09=09CFArrayAppendValue((CFMutableArrayRef)pCertName->commonName,=20=
str);=0A+=09=09=09else=20if=20(memcmp(nvp.type.Data,=20=
CSSMOID_Description.Data,=20CSSMOID_Description.Length)=20=3D=3D=200)=0A=
+=09=09=09=09=
CFArrayAppendValue((CFMutableArrayRef)pCertName->description,=20str);=0A=
+=09=09=09else=20if=20(memcmp(nvp.type.Data,=20=
CSSMOID_EmailAddress.Data,=20CSSMOID_EmailAddress.Length)=20=3D=3D=200)=0A=
+=09=09=09=09=
CFArrayAppendValue((CFMutableArrayRef)pCertName->emailAddress,=20str);=0A=
+=09=09=09else=20if=20(memcmp(nvp.type.Data,=20=
CSSMOID_StateProvinceName.Data,=20CSSMOID_StateProvinceName.Length)=20=3D=3D=
=200)=0A+=09=09=09=09=
CFArrayAppendValue((CFMutableArrayRef)pCertName->stateName,=20str);=0A+=09=
=09=09else=20if=20(memcmp(nvp.type.Data,=20CSSMOID_LocalityName.Data,=20=
CSSMOID_LocalityName.Length)=20=3D=3D=200)=0A+=09=09=09=09=
CFArrayAppendValue((CFMutableArrayRef)pCertName->localityName,=20str);=0A=
+=09=09=09else=20if=20(memcmp(nvp.type.Data,=20=
CSSMOID_DistinguishedName.Data,=20CSSMOID_DistinguishedName.Length)=20=3D=3D=
=200)=0A+=09=09=09=09=
CFArrayAppendValue((CFMutableArrayRef)pCertName->distinguishedName,=20=
str);=0A+=09=09=09=0A+=09=09=09CFRelease(str);=0A+=20=20=20=20=20=20=20=20=
}=0A+=20=20=20=20}=0A+=20=20=20=20=0A+=20=20=20=20return=20pCertName;=0A=
+}=0A+=0A+CFArrayRef=20GetFieldsFromCssmCertData(CSSM_CL_HANDLE=20hCL,=20=
CSSM_DATA_PTR=20pCertData,=20CSSM_OID=20oid)=0A+{=0A+=09CSSM_DATA_PTR=20=
pData=20=3D=20NULL;=0A+=09CFMutableArrayRef=20fields=20=3D=20=
CFArrayCreateMutable(NULL,=200,=20NULL);=0A+=09uint32=20numFields,=20i;=0A=
+=09=0A+=09CSSM_HANDLE=20ResultsHandle=20=3D=20(CSSM_HANDLE)NULL;=0A+=09=
numFields=20=3D=200;=0A+=09=0A+=09CSSM_CL_CertGetFirstFieldValue(hCL,=20=
pCertData,=20&oid,=20&ResultsHandle,=20&numFields,=20&pData);=0A+=09=0A+=09=
if=20(!pData)=0A+=09{=0A+=09=09CSSM_CL_CertAbortQuery(hCL,=20=
ResultsHandle);=0A+=09=09return=20NULL;=0A+=09}=0A+=09=0A+=09for=20(i=20=
=3D=200;=20i=20<=20numFields;=20i++)=20=0A+=09{=09=09=0A+=09=09=
CertNameRef=20pName=20=3D=20dataToName(pData);=0A+=09=09=
CFArrayAppendValue(fields,=20pName);=0A+=09=09CSSM_CL_FreeFieldValue=20=
(hCL,=20&oid,=20pData);=09=09=0A+=09=09if=20(i=20<=20(numFields=20-=20=
1))=0A+=09=09=09CSSM_CL_CertGetNextFieldValue(hCL,=20ResultsHandle,=20=
&pData);=0A+=09}=0A+=0A+=09CSSM_CL_CertAbortQuery(hCL,=20ResultsHandle);=0A=
+=09return=20fields;=0A+}=0A+=0A+CFArrayRef=20=
GetFieldsFromCertificate(SecCertificateRef=20certificate,=20CSSM_OID=20=
oid)=0A+{=0A+=09CSSM_CL_HANDLE=20hCL;=0A+=09CSSM_DATA=20certData;=0A+=09=
CFArrayRef=20fieldValues;=0A+=09=0A+=09=
SecCertificateGetCLHandle(certificate,=20&hCL);=0A+=09=
SecCertificateGetData(certificate,=20&certData);=0A+=09=0A+=09=
fieldValues=20=3D=20GetFieldsFromCssmCertData(hCL,=20&certData,=20oid);=0A=
+=09=0A+=09if=20(fieldValues=20=3D=3D=20NULL)=20=09=09=0A+=09{=0A+=09=09=
return=20NULL;=20=0A+=09}=0A+=09else=20if=20=
(CFArrayGetCount(fieldValues)=20=3D=3D=200)=0A+=09{=0A+=09=09=
CFRelease(fieldValues);=0A+=09=09return=20NULL;=0A+=09}=0A+=09=0A+=09=
return=20fieldValues;=0A+}=0A+=0A+CertDataRef=20=
createCertDataFromCertificate(SecCertificateRef=20certificate)=0A+{=0A+=09=
=0A+=09CertDataRef=20pCertData=20=3D=20=
(CertDataRef)gc_malloc(sizeof(CertData),=20false,=20&g_gc);=0A+=09=
pCertData->subject=20=3D=20GetFieldsFromCertificate(certificate,=20=
CSSMOID_X509V1SubjectNameCStruct);=0A+=09pCertData->issuer=20=3D=20=
GetFieldsFromCertificate(certificate,=20=
CSSMOID_X509V1IssuerNameCStruct);=0A+=0A+=09CSSM_DATA=20cssmCertData;=0A=
+=09SecCertificateGetData=20(certificate,=20&cssmCertData);=0A+=0A+=09=
unsigned=20char=20sha1[CC_SHA1_DIGEST_LENGTH];=20=0A+=09=
CC_SHA1(cssmCertData.Data,=20cssmCertData.Length,=20sha1);=20=0A+=09=
pCertData->sha1=20=3D=20createHexString(sha1,=20CC_SHA1_DIGEST_LENGTH);=0A=
+=09=0A+=09unsigned=20char=20md5[CC_MD5_DIGEST_LENGTH];=20=0A+=09=
CC_MD5(cssmCertData.Data,=20cssmCertData.Length,=20md5);=20=0A+=09=
pCertData->md5=20=3D=20createHexString((unsigned=20char*)md5,=20=
CC_MD5_DIGEST_LENGTH);=0A+=09=0A+=09return=20pCertData;=0A+}=0A+=0A=
+CFStringRef=20stringFromRange(const=20char=20*cstring,=20CFRange=20=
range)=0A+{=0A+=09CFStringRef=20str=20=3D=20CFStringCreateWithBytes=20=
(NULL,=20(uint8*)&cstring[range.location],=20range.length,=20=
kCFStringEncodingUTF8,=20false);=0A+=09CFMutableStringRef=20mutableStr=20=
=3D=20CFStringCreateMutableCopy(NULL,=200,=20str);=0A+=09=
CFStringTrimWhitespace(mutableStr);=0A+=09CFRelease(str);=0A+=09return=20=
mutableStr;=0A+}=0A+=0A+DescDataRef=20createDescData(const=20char=20=
*description,=20CFRange=20nameRange,=20CFRange=20valueRange)=0A+{=0A+=09=
DescDataRef=20pRetVal=20=3D=20(DescDataRef)gc_malloc(sizeof(DescData),=20=
false,=20&g_gc);=0A+=09=0A+=09memset(pRetVal,=200,=20sizeof(DescData));=0A=
+=09=0A+=09if=20(nameRange.length=20>=200)=0A+=09=09pRetVal->name=20=3D=20=
stringFromRange(description,=20nameRange);=0A+=09=0A+=09if=20=
(valueRange.length=20>=200)=0A+=09=09pRetVal->value=20=3D=20=
stringFromRange(description,=20valueRange);=0A+=09=0A+=09return=20=
pRetVal;=0A+}=0A+=0A+void=20destroyDescData(DescDataRef=20pData)=0A+{=0A=
+=09if=20(pData->name)=0A+=09=09CFRelease(pData->name);=0A+=09=0A+=09if=20=
(pData->value)=0A+=09=09CFRelease(pData->value);=0A+}=0A+=0A+CFArrayRef=20=
createDescDataPairs(const=20char=20*description)=0A+{=0A+=09int=20=
numChars=20=3D=20strlen(description);=0A+=09CFRange=20nameRange,=20=
valueRange;=0A+=09DescDataRef=20pData;=0A+=09CFMutableArrayRef=20retVal=20=
=3D=20CFArrayCreateMutable(NULL,=200,=20NULL);=0A+=09=0A+=09int=20i=20=3D=20=
0;=0A+=09=0A+=09nameRange=20=3D=20CFRangeMake(0,=200);=0A+=09valueRange=20=
=3D=20CFRangeMake(0,=200);=0A+=09bool=20bInValue=20=3D=20false;=0A+=09=0A=
+=09while(i=20<=20numChars)=0A+=09{=0A+=09=09if=20(!bInValue=20&&=20=
(description[i]=20!=3D=20':'))=0A+=09=09{=0A+=09=09=09=
nameRange.length++;=0A+=09=09}=0A+=09=09else=20if=20(bInValue=20&&=20=
(description[i]=20!=3D=20':'))=0A+=09=09{=0A+=09=09=09=
valueRange.length++;=0A+=09=09}=0A+=09=09else=20if(!bInValue)=0A+=09=09{=0A=
+=09=09=09bInValue=20=3D=20true;=0A+=09=09=09valueRange.location=20=3D=20=
i=20+=201;=0A+=09=09=09valueRange.length=20=3D=200;=0A+=09=09}=0A+=09=09=
else=20//(bInValue)=0A+=09=09{=0A+=09=09=09bInValue=20=3D=20false;=0A+=09=
=09=09while(description[i]=20!=3D=20'=20')=0A+=09=09=09{=0A+=09=09=09=09=
valueRange.length--;=0A+=09=09=09=09i--;=0A+=09=09=09}=0A+=09=09=09=0A+=09=
=09=09pData=20=3D=20createDescData(description,=20nameRange,=20=
valueRange);=0A+=09=09=09CFArrayAppendValue(retVal,=20pData);=0A+=09=09=09=
=0A+=09=09=09nameRange.location=20=3D=20i=20+=201;=0A+=09=09=09=
nameRange.length=20=3D=200;=0A+=09=09}=0A+=09=09=0A+=09=09i++;=0A+=09}=0A=
+=09=0A+=09pData=20=3D=20createDescData(description,=20nameRange,=20=
valueRange);=0A+=09CFArrayAppendValue(retVal,=20pData);=0A+=09return=20=
retVal;=0A+}=0A+=0A+void=20arrayDestroyDescData(const=20void=20*val,=20=
void=20*context)=0A+{=0A+=09DescDataRef=20pData=20=3D=20(DescDataRef)=20=
val;=0A+=09destroyDescData(pData);=0A+}=0A+=0A+=0A+void=20=
parseNameComponent(CFStringRef=20dn,=20CFStringRef=20*pName,=20=
CFStringRef=20*pValue)=0A+{=0A+=09CFArrayRef=20nameStrings=20=3D=20=
CFStringCreateArrayBySeparatingStrings(NULL,=20dn,=20kCertNameEquals);=0A=
+=09=0A+=09*pName=20=3D=20*pValue=20=3D=20NULL;=0A+=09=0A+=09if=20=
(CFArrayGetCount(nameStrings)=20!=3D=202)=0A+=09=09return;=0A+=09=0A+=09=
CFMutableStringRef=20str;=0A+=09=0A+=09str=20=3D=20=
CFStringCreateMutableCopy(NULL,=200,=20=
CFArrayGetValueAtIndex(nameStrings,=200));=0A+=09=
CFStringTrimWhitespace(str);=0A+=09*pName=20=3D=20str;=0A+=09=0A+=09str=20=
=3D=20CFStringCreateMutableCopy(NULL,=200,=20=
CFArrayGetValueAtIndex(nameStrings,=201));=0A+=09=
CFStringTrimWhitespace(str);=0A+=09*pValue=20=3D=20str;=0A+=09=0A+=09=
CFRelease(nameStrings);=0A+}=0A+=0A+void=20parseCertName(CFStringRef=20=
nameDesc,=20CFMutableArrayRef=20names)=0A+{=0A+=09CFArrayRef=20=
nameStrings=20=3D=20CFStringCreateArrayBySeparatingStrings(NULL,=20=
nameDesc,=20kCertNameFwdSlash);=0A+=09int=20count=20=3D=20=
CFArrayGetCount(nameStrings);=0A+=20=20=20=20int=20i;=0A+=09=0A+=09=
CertNameRef=20pCertName=20=3D=20createCertName();=0A+=09=0A+=09for(i=20=3D=
=200;i=20<=20count;i++)=0A+=09{=0A+=09=09CFMutableStringRef=20dn=20=3D=20=
CFStringCreateMutableCopy(NULL,=200,=20=
CFArrayGetValueAtIndex(nameStrings,=20i));=0A+=09=09=
CFStringTrimWhitespace(dn);=0A+=09=09=0A+=09=09CFStringRef=20name,=20=
value;=0A+=09=09=0A+=09=09parseNameComponent(dn,=20&name,=20&value);=0A+=09=
=09=0A+=09=09if=20(!name=20||=20!value)=0A+=09=09{=0A+=09=09=09if=20=
(name)=0A+=09=09=09=09CFRelease(name);=0A+=09=09=09=0A+=09=09=09if=20=
(value)=0A+=09=09=09=09CFRelease(value);=0A+=09=09=09=0A+=09=09=09=
CFRelease(dn);=0A+=09=09=09continue;=0A+=09=09}=0A+=09=09=0A+=09=09if=20=
(CFStringCompareWithOptions(name,=20kCertNameOrganization,=20=
CFRangeMake(0,=20CFStringGetLength(name)),=20kCFCompareCaseInsensitive)=20=
=3D=3D=20kCFCompareEqualTo)=0A+=09=09=09=
CFArrayAppendValue((CFMutableArrayRef)pCertName->organization,=20value);=0A=
+=09=09else=20if=20(CFStringCompareWithOptions(name,=20=
kCertNameOrganizationalUnit,=20CFRangeMake(0,=20=
CFStringGetLength(name)),=20kCFCompareCaseInsensitive)=20=3D=3D=20=
kCFCompareEqualTo)=0A+=09=09=09=
CFArrayAppendValue((CFMutableArrayRef)pCertName->organizationalUnit,=20=
value);=0A+=09=09else=20if=20(CFStringCompareWithOptions(name,=20=
kCertNameCountry,=20CFRangeMake(0,=20CFStringGetLength(name)),=20=
kCFCompareCaseInsensitive)=20=3D=3D=20kCFCompareEqualTo)=0A+=09=09=09=
CFArrayAppendValue((CFMutableArrayRef)pCertName->countryName,=20value);=0A=
+=09=09else=20if=20(CFStringCompareWithOptions(name,=20=
kCertNameLocality,=20CFRangeMake(0,=20CFStringGetLength(name)),=20=
kCFCompareCaseInsensitive)=20=3D=3D=20kCFCompareEqualTo)=0A+=09=09=09=
CFArrayAppendValue((CFMutableArrayRef)pCertName->localityName,=20value);=0A=
+=09=09else=20if=20(CFStringCompareWithOptions(name,=20kCertNameState,=20=
CFRangeMake(0,=20CFStringGetLength(name)),=20kCFCompareCaseInsensitive)=20=
=3D=3D=20kCFCompareEqualTo)=0A+=09=09=09=
CFArrayAppendValue((CFMutableArrayRef)pCertName->stateName,=20value);=0A=
+=09=09else=20if=20(CFStringCompareWithOptions(name,=20=
kCertNameCommonName,=20CFRangeMake(0,=20CFStringGetLength(name)),=20=
kCFCompareCaseInsensitive)=20=3D=3D=20kCFCompareEqualTo)=0A+=09=09=09=
CFArrayAppendValue((CFMutableArrayRef)pCertName->commonName,=20value);=0A=
+=09=09else=20if=20(CFStringCompareWithOptions(name,=20kCertNameEmail,=20=
CFRangeMake(0,=20CFStringGetLength(name)),=20kCFCompareCaseInsensitive)=20=
=3D=3D=20kCFCompareEqualTo)=0A+=09=09=09=
CFArrayAppendValue((CFMutableArrayRef)pCertName->emailAddress,=20value);=0A=
+=09=09else=20if=20(CFStringCompareWithOptions(name,=20=
kCertNameDomainComponent,=20CFRangeMake(0,=20CFStringGetLength(name)),=20=
kCFCompareCaseInsensitive)=20=3D=3D=20kCFCompareEqualTo)=0A+=09=09=09=
CFArrayAppendValue((CFMutableArrayRef)pCertName->domainComponent,=20=
value);=0A+=09=09=0A+=09=09CFRelease(name);=0A+=09=09CFRelease(value);=0A=
+=09=09CFRelease(dn);=0A+=09}=0A+=09=0A+=09CFArrayAppendValue(names,=20=
pCertName);=0A+=09CFRelease(nameStrings);=0A+}=0A+=0A+void=20=
arrayParseDescDataPair(const=20void=20*val,=20void=20*context)=0A+{=0A+=09=
DescDataRef=20pDescData=20=3D=20(DescDataRef)val;=0A+=09CertDataRef=20=
pCertData=20=3D=20(CertDataRef)context;=0A+=09=0A+=09if=20=
(!pDescData->name=20||=20!pDescData->value)=0A+=09=09return;=0A+=09=0A+=09=
if=20(CFStringCompareWithOptions(pDescData->name,=20=
kCertDataSubjectName,=20CFRangeMake(0,=20=
CFStringGetLength(pDescData->name)),=20kCFCompareCaseInsensitive)=20=3D=3D=
=20kCFCompareEqualTo)=0A+=09=09parseCertName(pDescData->value,=20=
(CFMutableArrayRef)pCertData->subject);=0A+=09else=20if=20=
(CFStringCompareWithOptions(pDescData->name,=20kCertDataIssuerName,=20=
CFRangeMake(0,=20CFStringGetLength(pDescData->name)),=20=
kCFCompareCaseInsensitive)=20=3D=3D=20kCFCompareEqualTo)=0A+=09=09=
parseCertName(pDescData->value,=20(CFMutableArrayRef)pCertData->issuer);=0A=
+=09else=20if=20(CFStringCompareWithOptions(pDescData->name,=20=
kCertDataSha1Name,=20CFRangeMake(0,=20=
CFStringGetLength(pDescData->name)),=20kCFCompareCaseInsensitive)=20=3D=3D=
=20kCFCompareEqualTo)=0A+=09=09pCertData->sha1=20=3D=20=
CFRetain(pDescData->value);=0A+=09else=20if=20=
(CFStringCompareWithOptions(pDescData->name,=20kCertDataMd5Name,=20=
CFRangeMake(0,=20CFStringGetLength(pDescData->name)),=20=
kCFCompareCaseInsensitive)=20=3D=3D=20kCFCompareEqualTo)=0A+=09=09=
pCertData->md5=20=3D=20CFRetain(pDescData->value);=0A+}=0A+=0A=
+CertDataRef=20createCertDataFromString(const=20char=20*description)=0A=
+{=0A+=09CertDataRef=20pCertData=20=3D=20=
(CertDataRef)gc_malloc(sizeof(CertData),=20false,=20&g_gc);=0A+=09=
pCertData->subject=20=3D=20CFArrayCreateMutable(NULL,=200,=20NULL);=0A+=09=
pCertData->issuer=20=3D=20CFArrayCreateMutable(NULL,=200,=20NULL);=0A+=09=
pCertData->sha1=20=3D=20NULL;=0A+=09pCertData->md5=20=3D=20NULL;=0A+=09=0A=
+=09CFArrayRef=20pairs=20=3D=20createDescDataPairs(description);=0A+=09=
CFArrayApplyFunction(pairs,=20CFRangeMake(0,=20CFArrayGetCount(pairs)),=20=
arrayParseDescDataPair,=20pCertData);=0A+=09CFArrayApplyFunction(pairs,=20=
CFRangeMake(0,=20CFArrayGetCount(pairs)),=20arrayDestroyDescData,=20=
NULL);=0A+=09CFRelease(pairs);=0A+=09return=20pCertData;=0A+}=0A+=0A=
+void=20arrayDestroyCertName(const=20void=20*val,=20void=20*context)=0A=
+{=0A+=09CertNameRef=20pCertName=20=3D=20(CertNameRef)val;=0A+=09=
destroyCertName(pCertName);=0A+}=0A+=0A+void=20=
destroyCertData(CertDataRef=20pCertData)=0A+{=0A+=09if=20=
(pCertData->subject)=0A+=09{=0A+=09=09=
CFArrayApplyFunction(pCertData->subject,=20CFRangeMake(0,=20=
CFArrayGetCount(pCertData->subject)),=20arrayDestroyCertName,=20NULL);=0A=
+=09=09CFRelease(pCertData->subject);=0A+=09}=0A+=09=0A+=09if=20=
(pCertData->issuer)=0A+=09{=0A+=09=09=
CFArrayApplyFunction(pCertData->issuer,=20CFRangeMake(0,=20=
CFArrayGetCount(pCertData->issuer)),=20arrayDestroyCertName,=20NULL);=0A=
+=09=09CFRelease(pCertData->issuer);=0A+=09}=0A+=09=0A+=09if=20=
(pCertData->sha1)=0A+=09=09CFRelease(pCertData->sha1);=0A+=09=0A+=09if=20=
(pCertData->md5)=0A+=09=09CFRelease(pCertData->md5);=0A+}=0A+=0A+bool=20=
stringArrayMatchesTemplate(CFArrayRef=20strings,=20CFArrayRef=20=
templateArray)=0A+{=0A+=09int=20templateCount,=20stringCount,=20i;=0A+=09=
=0A+=09templateCount=20=3D=20CFArrayGetCount(templateArray);=0A+=09=0A+=09=
if=20(templateCount=20>=200)=0A+=09{=0A+=09=09stringCount=20=3D=20=
CFArrayGetCount(strings);=0A+=09=09if=20(stringCount=20!=3D=20=
templateCount)=0A+=09=09=09return=20false;=0A+=09=09=0A+=09=09for(i=20=3D=20=
0;i=20<=20stringCount;i++)=0A+=09=09{=0A+=09=09=09CFStringRef=20str,=20=
template;=0A+=09=09=09=0A+=09=09=09template=20=3D=20=
(CFStringRef)CFArrayGetValueAtIndex(templateArray,=20i);=0A+=09=09=09str=20=
=3D=20(CFStringRef)CFArrayGetValueAtIndex(strings,=20i);=0A+=09=09=09=0A=
+=09=09=09if=20(CFStringCompareWithOptions(template,=20str,=20=
CFRangeMake(0,=20CFStringGetLength(template)),=20=
kCFCompareCaseInsensitive)=20!=3D=20kCFCompareEqualTo)=0A+=09=09=09=09=
return=20false;=0A+=09=09}=0A+=09}=0A+=09=0A+=09return=20true;=0A+=09=0A=
+}=0A+=0A+bool=20certNameMatchesTemplate(CertNameRef=20pCertName,=20=
CertNameRef=20pTemplate)=0A+{=0A+=09if=20=
(!stringArrayMatchesTemplate(pCertName->countryName,=20=
pTemplate->countryName))=0A+=09=09return=20false;=0A+=09else=20if=20=
(!stringArrayMatchesTemplate(pCertName->organization,=20=
pTemplate->organization))=0A+=09=09return=20false;=0A+=09else=20if=20=
(!stringArrayMatchesTemplate(pCertName->organizationalUnit,=20=
pTemplate->organizationalUnit))=0A+=09=09return=20false;=0A+=09else=20if=20=
(!stringArrayMatchesTemplate(pCertName->commonName,=20=
pTemplate->commonName))=0A+=09=09return=20false;=0A+=09else=20if=20=
(!stringArrayMatchesTemplate(pCertName->emailAddress,=20=
pTemplate->emailAddress))=0A+=09=09return=20false;=0A+=09else=20if=20=
(!stringArrayMatchesTemplate(pCertName->stateName,=20=
pTemplate->stateName))=0A+=09=09return=20false;=0A+=09else=20if=20=
(!stringArrayMatchesTemplate(pCertName->localityName,=20=
pTemplate->localityName))=0A+=09=09return=20false;=0A+=09else=0A+=09=09=
return=20true;=0A+}=0A+=0A+bool=20=
certNameArrayMatchesTemplate(CFArrayRef=20certNameArray,=20CFArrayRef=20=
templateArray)=0A+{=0A+=09int=20templateCount,=20certCount,=20i;=0A+=09=0A=
+=09templateCount=20=3D=20CFArrayGetCount(templateArray);=0A+=09=0A+=09=
if=20(templateCount=20>=200)=0A+=09{=0A+=09=09certCount=20=3D=20=
CFArrayGetCount(certNameArray);=0A+=09=09if=20(certCount=20!=3D=20=
templateCount)=0A+=09=09=09return=20false;=0A+=09=09=0A+=09=09for(i=20=3D=20=
0;i=20<=20certCount;i++)=0A+=09=09{=0A+=09=09=09CertNameRef=20pName,=20=
pTemplateName;=0A+=09=09=09=0A+=09=09=09pTemplateName=20=3D=20=
(CertNameRef)CFArrayGetValueAtIndex(templateArray,=20i);=0A+=09=09=09=
pName=20=3D=20(CertNameRef)CFArrayGetValueAtIndex(certNameArray,=20i);=0A=
+=09=09=09=0A+=09=09=09if=20(!certNameMatchesTemplate(pName,=20=
pTemplateName))=0A+=09=09=09=09return=20false;=0A+=09=09}=0A+=09}=0A+=09=0A=
+=09return=20true;=0A+}=0A+=0A+bool=20=
hexStringMatchesTemplate(CFStringRef=20str,=20CFStringRef=20template)=0A=
+{=0A+=09if=20(template)=0A+=09{=0A+=09=09if=20(!str)=0A+=09=09=09return=20=
false;=0A+=09=09=0A+=09=09CFMutableStringRef=20strMutable,=20=
templateMutable;=0A+=09=09=0A+=09=09strMutable=20=3D=20=
CFStringCreateMutableCopy(NULL,=200,=20str);=0A+=09=09templateMutable=20=
=3D=20CFStringCreateMutableCopy(NULL,=200,=20template);=0A+=09=09=0A+=09=09=
CFStringFindAndReplace(strMutable,=20kStringSpace,=20kStringEmpty,=20=
CFRangeMake(0,=20CFStringGetLength(strMutable)),=200);=0A+=09=09=
CFStringFindAndReplace(templateMutable,=20kStringSpace,=20kStringEmpty,=20=
CFRangeMake(0,=20CFStringGetLength(templateMutable)),=200);=0A+=0A+=20=20=
=20=20=20=20=20=20CFComparisonResult=20result=20=3D=20=
CFStringCompareWithOptions(templateMutable,=20strMutable,=20=
CFRangeMake(0,=20CFStringGetLength(templateMutable)),=20=
kCFCompareCaseInsensitive);=0A+=09=09=0A+=09=09CFRelease(strMutable);=0A=
+=09=09CFRelease(templateMutable);=0A+=09=09=09=09=0A+=09=09if=20(result=20=
!=3D=20kCFCompareEqualTo)=0A+=09=09=09return=20false;=0A+=09}=0A+=09=0A+=09=
return=20true;=0A+}=0A+=0A+bool=20certDataMatchesTemplate(CertDataRef=20=
pCertData,=20CertDataRef=20pTemplate)=0A+{=0A+=09if=20=
(!certNameArrayMatchesTemplate(pCertData->subject,=20=
pTemplate->subject))=0A+=09=09return=20false;=0A+=09=0A+=09if=20=
(!certNameArrayMatchesTemplate(pCertData->issuer,=20pTemplate->issuer))=0A=
+=09=09return=20false;=0A+=09=0A+=09if=20=
(!hexStringMatchesTemplate(pCertData->sha1,=20pTemplate->sha1))=0A+=09=09=
return=20false;=0A+=09=0A+=09if=20=
(!hexStringMatchesTemplate(pCertData->md5,=20pTemplate->md5))=0A+=09=09=
return=20false;=0A+=0A+=09return=20true;=0A+}=0A+=0A+void=20=
printString(const=20void=20*val,=20void=20*context)=20=0A+{=0A+=20=20=20=20=
CFStringRef=20str=20=3D=20(CFStringRef)val;=0A+=09const=20char=20*label=20=
=3D=20(const=20char=20*)context;=0A+=09msg(M_DEBUG,=20"%s=20=3D=20",=20=
label);=0A+=09printCFString(str,=20&g_gc);=0A+=09msg(M_DEBUG,=20"\n");=0A=
+}=0A+=0A+void=20printCertName(CertNameRef=20pCertName)=20=0A+{=0A+=09=
CFArrayApplyFunction(pCertName->countryName,=20CFRangeMake(0,=20=
CFArrayGetCount(pCertName->countryName)),=20printString,=20"Country=20=
Name");=0A+=09CFArrayApplyFunction(pCertName->organization,=20=
CFRangeMake(0,=20CFArrayGetCount(pCertName->organization)),=20=
printString,=20"Organization");=0A+=09=
CFArrayApplyFunction(pCertName->organizationalUnit,=20CFRangeMake(0,=20=
CFArrayGetCount(pCertName->organizationalUnit)),=20printString,=20=
"Organizational=20Unit");=0A+=09=
CFArrayApplyFunction(pCertName->commonName,=20CFRangeMake(0,=20=
CFArrayGetCount(pCertName->commonName)),=20printString,=20"Common=20=
Name");=0A+=09CFArrayApplyFunction(pCertName->description,=20=
CFRangeMake(0,=20CFArrayGetCount(pCertName->description)),=20=
printString,=20"Description");=0A+=09=
CFArrayApplyFunction(pCertName->emailAddress,=20CFRangeMake(0,=20=
CFArrayGetCount(pCertName->emailAddress)),=20printString,=20"Email=20=
Address");=0A+=09CFArrayApplyFunction(pCertName->stateName,=20=
CFRangeMake(0,=20CFArrayGetCount(pCertName->stateName)),=20printString,=20=
"State=20Name");=0A+=09CFArrayApplyFunction(pCertName->localityName,=20=
CFRangeMake(0,=20CFArrayGetCount(pCertName->localityName)),=20=
printString,=20"Locality=20Name");=0A+=09=
CFArrayApplyFunction(pCertName->distinguishedName,=20CFRangeMake(0,=20=
CFArrayGetCount(pCertName->distinguishedName)),=20printString,=20=
"Distinguished=20Name");=09=0A+}=0A+=0A+void=20arrayPrintCertName(const=20=
void=20*val,=20void=20*context)=0A+{=0A+=09CertNameRef=20pCertName=20=3D=20=
(CertNameRef)=20val;=0A+=09printCertName(pCertName);=0A+}=0A+=0A+void=20=
printCertData(CertDataRef=20pCertData)=0A+{=0A+=09msg(M_DEBUG,=20"***=20=
Subject=20***\n");=0A+=09if=20(pCertData->subject)=0A+=09=09=
CFArrayApplyFunction(pCertData->subject,=20CFRangeMake(0,=20=
CFArrayGetCount(pCertData->subject)),=20arrayPrintCertName,=20NULL);=0A+=0A=
+=09msg(M_DEBUG,=20"***=20Issuer=20***\n");=0A+=09if=20=
(pCertData->issuer)=0A+=09=09CFArrayApplyFunction(pCertData->issuer,=20=
CFRangeMake(0,=20CFArrayGetCount(pCertData->issuer)),=20=
arrayPrintCertName,=20NULL);=0A+=09=0A+=09msg(M_DEBUG,=20"***=20=
Fingerprints=20***\n");=0A+=09=0A+=09msg(M_DEBUG,=20"SHA1=20=3D=20");=0A=
+=09if=20(pCertData->sha1)=0A+=09=09printCFString(pCertData->sha1,=20=
&g_gc);=0A+=09=0A+=09msg(M_DEBUG,=20"\n");=0A+=09=09=0A+=09msg(M_DEBUG,=20=
"MD5=20=3D=20");=0A+=09if=20(pCertData->md5)=0A+=09=09=
printCFString(pCertData->md5,=20&g_gc);=0A+=09=0A+=09msg(M_DEBUG,=20=
"\n");=09=0A+}=0A+=0A+SecIdentityRef=20findIdentity(CertDataRef=20=
pCertDataTemplate)=0A+{=0A+=09SecIdentitySearchRef=20search;=0A+=09=
SecIdentitySearchCreate(NULL,=200,=20&search);=0A+=09=0A+=09=
SecIdentityRef=20identity;=0A+=09while(SecIdentitySearchCopyNext(search,=20=
&identity)=20!=3D=20errSecItemNotFound)=0A+=09{=0A+=09=09=
SecCertificateRef=20certificate;=0A+=09=09SecIdentityCopyCertificate=20=
(identity,=20&certificate);=0A+=09=09=0A+=09=09CertDataRef=20pCertData=20=
=3D=20createCertDataFromCertificate(certificate);=09=09=0A+=09=09bool=20=
bMatches=20=3D=20certDataMatchesTemplate(pCertData,=20=
pCertDataTemplate);=0A+=0A+=09=09destroyCertData(pCertData);=0A+=09=09=
CFRelease(certificate);=0A+=0A+=09=09if=20(bMatches)=0A+=09=09{=0A+=09=09=
=09break;=0A+=09=09}=0A+=09=09else=0A+=09=09{=09=09=09=0A+=09=09=09=
CFRelease(identity);=0A+=09=09=09identity=20=3D=20NULL;=0A+=09=09}=0A+=09=
}=0A+=09=0A+=09CFRelease(search);=0A+=09return=20identity;=0A+}=0Adiff=20=
--git=20a/osx/cert_data.h=20b/osx/cert_data.h=0Anew=20file=20mode=20=
100755=0Aindex=200000000..639678e=0A---=20/dev/null=0A+++=20=
b/osx/cert_data.h=0A@@=20-0,0=20+1,46=20@@=0A+/*=0A+=20*=20=20OpenVPN=20=
--=20An=20application=20to=20securely=20tunnel=20IP=20networks=0A+=20*=20=
=20=20=20=20=20=20=20=20=20=20=20=20over=20a=20single=20UDP=20port,=20=
with=20support=20for=20SSL/TLS-based=0A+=20*=20=20=20=20=20=20=20=20=20=20=
=20=20=20session=20authentication=20and=20key=20exchange,=0A+=20*=20=20=20=
=20=20=20=20=20=20=20=20=20=20packet=20encryption,=20packet=20=
authentication,=20and=0A+=20*=20=20=20=20=20=20=20=20=20=20=20=20=20=
packet=20compression.=0A+=20*=0A+=20*=20=20Copyright=20(C)=202010=20=
Brian=20Raderman=20<brian@...1360...>=0A+=20*=0A+=20*=20=20=
This=20program=20is=20free=20software;=20you=20can=20redistribute=20it=20=
and/or=20modify=0A+=20*=20=20it=20under=20the=20terms=20of=20the=20GNU=20=
General=20Public=20License=20version=202=0A+=20*=20=20as=20published=20=
by=20the=20Free=20Software=20Foundation.=0A+=20*=0A+=20*=20=20This=20=
program=20is=20distributed=20in=20the=20hope=20that=20it=20will=20be=20=
useful,=0A+=20*=20=20but=20WITHOUT=20ANY=20WARRANTY;=20without=20even=20=
the=20implied=20warranty=20of=0A+=20*=20=20MERCHANTABILITY=20or=20=
FITNESS=20FOR=20A=20PARTICULAR=20PURPOSE.=20=20See=20the=0A+=20*=20=20=
GNU=20General=20Public=20License=20for=20more=20details.=0A+=20*=0A+=20*=20=
=20You=20should=20have=20received=20a=20copy=20of=20the=20GNU=20General=20=
Public=20License=0A+=20*=20=20along=20with=20this=20program=20(see=20the=20=
file=20COPYING=20included=20with=20this=0A+=20*=20=20distribution);=20if=20=
not,=20write=20to=20the=20Free=20Software=20Foundation,=20Inc.,=0A+=20*=20=
=2059=20Temple=20Place,=20Suite=20330,=20Boston,=20MA=20=2002111-1307=20=20=
USA=0A+=20*/=0A+#ifndef=20__cert_data_h__=0A+#define=20__cert_data_h__=0A=
+=0A+#include=20<CoreFoundation/CoreFoundation.h>=0A+#include=20=
<Security/Security.h>=0A+=0A+typedef=20struct=20_CertData=0A+{=0A+=09=
CFArrayRef=20subject;=0A+=09CFArrayRef=20issuer;=0A+=09CFStringRef=20=
md5,=20sha1;=0A+}=20CertData,=20*CertDataRef;=0A+=0A+CertDataRef=20=
createCertDataFromCertificate(SecCertificateRef=20certificate);=0A=
+CertDataRef=20createCertDataFromString(const=20char=20*description);=0A=
+void=20destroyCertData(CertDataRef=20pCertData);=0A+bool=20=
certDataMatchesTemplate(CertDataRef=20pCertData,=20CertDataRef=20=
pTemplate);=0A+void=20printCertData(CertDataRef=20pCertData);=0A=
+SecIdentityRef=20findIdentity(CertDataRef=20pCertDataTemplate);=0A+void=20=
initCertData();=0A+void=20freeCertData();=0A+=0A+#endif=0A\=20No=20=
newline=20at=20end=20of=20file=0Adiff=20--git=20a/osx/common_osx.c=20=
b/osx/common_osx.c=0Anew=20file=20mode=20100755=0Aindex=20=
0000000..4909acd=0A---=20/dev/null=0A+++=20b/osx/common_osx.c=0A@@=20=
-0,0=20+1,99=20@@=0A+/*=0A+=20*=20=20OpenVPN=20--=20An=20application=20=
to=20securely=20tunnel=20IP=20networks=0A+=20*=20=20=20=20=20=20=20=20=20=
=20=20=20=20over=20a=20single=20UDP=20port,=20with=20support=20for=20=
SSL/TLS-based=0A+=20*=20=20=20=20=20=20=20=20=20=20=20=20=20session=20=
authentication=20and=20key=20exchange,=0A+=20*=20=20=20=20=20=20=20=20=20=
=20=20=20=20packet=20encryption,=20packet=20authentication,=20and=0A+=20=
*=20=20=20=20=20=20=20=20=20=20=20=20=20packet=20compression.=0A+=20*=0A=
+=20*=20=20Copyright=20(C)=202010=20Brian=20Raderman=20=
<brian@...1360...>=0A+=20*=0A+=20*=20=20This=20program=20is=20=
free=20software;=20you=20can=20redistribute=20it=20and/or=20modify=0A+=20=
*=20=20it=20under=20the=20terms=20of=20the=20GNU=20General=20Public=20=
License=20version=202=0A+=20*=20=20as=20published=20by=20the=20Free=20=
Software=20Foundation.=0A+=20*=0A+=20*=20=20This=20program=20is=20=
distributed=20in=20the=20hope=20that=20it=20will=20be=20useful,=0A+=20*=20=
=20but=20WITHOUT=20ANY=20WARRANTY;=20without=20even=20the=20implied=20=
warranty=20of=0A+=20*=20=20MERCHANTABILITY=20or=20FITNESS=20FOR=20A=20=
PARTICULAR=20PURPOSE.=20=20See=20the=0A+=20*=20=20GNU=20General=20Public=20=
License=20for=20more=20details.=0A+=20*=0A+=20*=20=20You=20should=20have=20=
received=20a=20copy=20of=20the=20GNU=20General=20Public=20License=0A+=20=
*=20=20along=20with=20this=20program=20(see=20the=20file=20COPYING=20=
included=20with=20this=0A+=20*=20=20distribution);=20if=20not,=20write=20=
to=20the=20Free=20Software=20Foundation,=20Inc.,=0A+=20*=20=2059=20=
Temple=20Place,=20Suite=20330,=20Boston,=20MA=20=2002111-1307=20=20USA=0A=
+=20*/=0A+#include=20"../syshead.h"=0A+#include=20"../error.h"=0A=
+#include=20"common_osx.h"=0A+=0A+void=20printCFString(CFStringRef=20=
str,=20struct=20gc_arena=20*pGc)=0A+{=0A+=09CFIndex=20bufferLength=20=3D=20=
CFStringGetLength(str)=20+=201;=0A+=09char=20*pBuffer=20=3D=20=
(char*)gc_malloc(sizeof(char)=20*=20bufferLength,=20false,=20pGc);=0A+=09=
CFStringGetCString(str,=20pBuffer,=20bufferLength,=20=
kCFStringEncodingUTF8);=0A+=09msg(M_DEBUG,=20"%s",=20pBuffer);=0A+}=0A+=0A=
+char*=20cfstringToCstr(CFStringRef=20str,=20struct=20gc_arena=20*pGc)=0A=
+{=0A+=09CFIndex=20bufferLength=20=3D=20CFStringGetLength(str)=20+=201;=0A=
+=09char=20*pBuffer=20=3D=20(char*)gc_malloc(sizeof(char)=20*=20=
bufferLength,=20false,=20pGc);=0A+=09CFStringGetCString(str,=20pBuffer,=20=
bufferLength,=20kCFStringEncodingUTF8);=0A+=09return=20pBuffer;=0A+}=0A+=0A=
+void=20appendHexChar(CFMutableStringRef=20str,=20unsigned=20char=20=
halfByte)=0A+{=0A+=09if=20(halfByte=20<=2010)=0A+=09=09=
CFStringAppendFormat=20(str,=20NULL,=20CFSTR("%d"),=20halfByte);=0A+=09=0A=
+=09switch(halfByte)=0A+=09{=0A+=09=09case=2010:=0A+=09=09=09=
CFStringAppendCString(str,=20"A",=20kCFStringEncodingUTF8);=0A+=09=09=09=
break;=0A+=09=09case=2011:=0A+=09=09=09CFStringAppendCString(str,=20"B",=20=
kCFStringEncodingUTF8);=0A+=09=09=09break;=0A+=09=09case=2012:=0A+=09=09=09=
CFStringAppendCString(str,=20"C",=20kCFStringEncodingUTF8);=0A+=09=09=09=
break;=0A+=09=09case=2013:=0A+=09=09=09CFStringAppendCString(str,=20"D",=20=
kCFStringEncodingUTF8);=0A+=09=09=09break;=0A+=09=09case=2014:=0A+=09=09=09=
CFStringAppendCString(str,=20"E",=20kCFStringEncodingUTF8);=0A+=09=09=09=
break;=0A+=09=09case=2015:=0A+=09=09=09CFStringAppendCString(str,=20"F",=20=
kCFStringEncodingUTF8);=0A+=09=09=09break;=0A+=09}=0A+}=0A+=0A=
+CFStringRef=20createHexString(unsigned=20char=20*pData,=20int=20length)=0A=
+{=0A+=09unsigned=20char=20byte,=20low,=20high;=0A+=09int=20i;=0A+=09=
CFMutableStringRef=20str=20=3D=20CFStringCreateMutable(NULL,=200);=0A+=09=
=0A+=09for(i=20=3D=200;i=20<=20length;i++)=0A+=09{=0A+=09=09byte=20=3D=20=
pData[i];=0A+=09=09low=20=3D=20byte=20&=200x0F;=0A+=09=09high=20=3D=20=
(byte=20>>=204);=0A+=09=09=0A+=09=09appendHexChar(str,=20high);=0A+=09=09=
appendHexChar(str,=20low);=0A+=09=09=0A+=09=09if=20(i=20!=3D=20(length=20=
-=201))=0A+=09=09=09CFStringAppendCString(str,=20"=20",=20=
kCFStringEncodingUTF8);=0A+=09}=0A+=09=0A+=09return=20str;=0A+}=0A+=0A=
+void=20printHex(unsigned=20char=20*pData,=20int=20length,=20struct=20=
gc_arena=20*pGc)=0A+{=0A+=09CFStringRef=20hexStr=20=3D=20=
createHexString(pData,=20length);=0A+=09printCFString(hexStr,=20pGc);=0A=
+=09CFRelease(hexStr);=0A+}=0A\=20No=20newline=20at=20end=20of=20file=0A=
diff=20--git=20a/osx/common_osx.h=20b/osx/common_osx.h=0Anew=20file=20=
mode=20100755=0Aindex=200000000..88b58c1=0A---=20/dev/null=0A+++=20=
b/osx/common_osx.h=0A@@=20-0,0=20+1,36=20@@=0A+/*=0A+=20*=20=20OpenVPN=20=
--=20An=20application=20to=20securely=20tunnel=20IP=20networks=0A+=20*=20=
=20=20=20=20=20=20=20=20=20=20=20=20over=20a=20single=20UDP=20port,=20=
with=20support=20for=20SSL/TLS-based=0A+=20*=20=20=20=20=20=20=20=20=20=20=
=20=20=20session=20authentication=20and=20key=20exchange,=0A+=20*=20=20=20=
=20=20=20=20=20=20=20=20=20=20packet=20encryption,=20packet=20=
authentication,=20and=0A+=20*=20=20=20=20=20=20=20=20=20=20=20=20=20=
packet=20compression.=0A+=20*=0A+=20*=20=20Copyright=20(C)=202010=20=
Brian=20Raderman=20<brian@...1360...>=0A+=20*=0A+=20*=20=20=
This=20program=20is=20free=20software;=20you=20can=20redistribute=20it=20=
and/or=20modify=0A+=20*=20=20it=20under=20the=20terms=20of=20the=20GNU=20=
General=20Public=20License=20version=202=0A+=20*=20=20as=20published=20=
by=20the=20Free=20Software=20Foundation.=0A+=20*=0A+=20*=20=20This=20=
program=20is=20distributed=20in=20the=20hope=20that=20it=20will=20be=20=
useful,=0A+=20*=20=20but=20WITHOUT=20ANY=20WARRANTY;=20without=20even=20=
the=20implied=20warranty=20of=0A+=20*=20=20MERCHANTABILITY=20or=20=
FITNESS=20FOR=20A=20PARTICULAR=20PURPOSE.=20=20See=20the=0A+=20*=20=20=
GNU=20General=20Public=20License=20for=20more=20details.=0A+=20*=0A+=20*=20=
=20You=20should=20have=20received=20a=20copy=20of=20the=20GNU=20General=20=
Public=20License=0A+=20*=20=20along=20with=20this=20program=20(see=20the=20=
file=20COPYING=20included=20with=20this=0A+=20*=20=20distribution);=20if=20=
not,=20write=20to=20the=20Free=20Software=20Foundation,=20Inc.,=0A+=20*=20=
=2059=20Temple=20Place,=20Suite=20330,=20Boston,=20MA=20=2002111-1307=20=20=
USA=0A+=20*/=0A+=0A+#ifndef=20__common_osx_h__=0A+#define=20=
__common_osx_h__=0A+=0A+#include=20"../buffer.h"=0A+#include=20=
<CoreFoundation/CoreFoundation.h>=0A+=0A+void=20=
printCFString(CFStringRef=20str,=20struct=20gc_arena=20*pGc);=0A+char*=20=
cfstringToCstr(CFStringRef=20str,=20struct=20gc_arena=20*pGc);=0A=
+CFStringRef=20createHexString(unsigned=20char=20*pData,=20int=20=
length);=0A+void=20printHex(unsigned=20char=20*pData,=20int=20length,=20=
struct=20gc_arena=20*pGc);=0A+=0A+#endif=20//__Common_osx_h__=0A\=20No=20=
newline=20at=20end=20of=20file=0Adiff=20--git=20a/osx/crypto_osx.c=20=
b/osx/crypto_osx.c=0Anew=20file=20mode=20100755=0Aindex=20=
0000000..a0b83bc=0A---=20/dev/null=0A+++=20b/osx/crypto_osx.c=0A@@=20=
-0,0=20+1,76=20@@=0A+/*=0A+=20*=20=20OpenVPN=20--=20An=20application=20=
to=20securely=20tunnel=20IP=20networks=0A+=20*=20=20=20=20=20=20=20=20=20=
=20=20=20=20over=20a=20single=20UDP=20port,=20with=20support=20for=20=
SSL/TLS-based=0A+=20*=20=20=20=20=20=20=20=20=20=20=20=20=20session=20=
authentication=20and=20key=20exchange,=0A+=20*=20=20=20=20=20=20=20=20=20=
=20=20=20=20packet=20encryption,=20packet=20authentication,=20and=0A+=20=
*=20=20=20=20=20=20=20=20=20=20=20=20=20packet=20compression.=0A+=20*=0A=
+=20*=20=20Copyright=20(C)=202010=20Brian=20Raderman=20=
<brian@...1360...>=0A+=20*=0A+=20*=20=20This=20program=20is=20=
free=20software;=20you=20can=20redistribute=20it=20and/or=20modify=0A+=20=
*=20=20it=20under=20the=20terms=20of=20the=20GNU=20General=20Public=20=
License=20version=202=0A+=20*=20=20as=20published=20by=20the=20Free=20=
Software=20Foundation.=0A+=20*=0A+=20*=20=20This=20program=20is=20=
distributed=20in=20the=20hope=20that=20it=20will=20be=20useful,=0A+=20*=20=
=20but=20WITHOUT=20ANY=20WARRANTY;=20without=20even=20the=20implied=20=
warranty=20of=0A+=20*=20=20MERCHANTABILITY=20or=20FITNESS=20FOR=20A=20=
PARTICULAR=20PURPOSE.=20=20See=20the=0A+=20*=20=20GNU=20General=20Public=20=
License=20for=20more=20details.=0A+=20*=0A+=20*=20=20You=20should=20have=20=
received=20a=20copy=20of=20the=20GNU=20General=20Public=20License=0A+=20=
*=20=20along=20with=20this=20program=20(see=20the=20file=20COPYING=20=
included=20with=20this=0A+=20*=20=20distribution);=20if=20not,=20write=20=
to=20the=20Free=20Software=20Foundation,=20Inc.,=0A+=20*=20=2059=20=
Temple=20Place,=20Suite=20330,=20Boston,=20MA=20=2002111-1307=20=20USA=0A=
+=20*/=0A+=0A+#include=20"crypto_osx.h"=0A+#include=20=
<CommonCrypto/CommonDigest.h>=0A+=0A+CSSM_DATA=20signData(SecIdentityRef=20=
identity,=20CSSM_DATA=20dataBuf)=0A+{=0A+=20=20=20=20SecKeyRef=20=
privateKey;=0A+=20=20=20=20=0A+=20=20=20=20=
SecIdentityCopyPrivateKey(identity,=20=20&privateKey);=20=0A+=20=20=20=20=
const=20CSSM_ACCESS_CREDENTIALS=20*pCredentials;=0A+=20=20=20=20=
SecKeyGetCredentials(privateKey,=20CSSM_ACL_AUTHORIZATION_SIGN,=20=
kSecCredentialTypeDefault,=20&pCredentials);=20=0A+=20=20=20=20=0A+=20=20=
=20=20CSSM_CSP_HANDLE=20cspHandle;=0A+=20=20=20=20=
SecKeyGetCSPHandle(privateKey,=20&cspHandle);=0A+=20=20=20=20=0A+=20=20=20=
=20const=20CSSM_KEY=20*pCssmKey;=0A+=20=20=20=20SecKeyGetCSSMKey=20=
(privateKey,=20&pCssmKey);=20=0A+=20=20=20=20=0A+=20=20=20=20CSSM_DATA=20=
signBuf;=0A+=20=20=20=20signBuf.Data=20=3D=20NULL;=0A+=20=20=20=20=
signBuf.Length=20=3D=200;=0A+=20=20=20=20=0A+=20=20=20=20if=20=
(!(pCssmKey->KeyHeader.KeyUsage=20&=20CSSM_KEYUSE_SIGN))=0A+=09{=0A+=09=09=
CFRelease(privateKey);=0A+=09=09return=20signBuf;=0A+=09}=0A+=20=20=20=20=
=0A+=20=20=20=20CSSM_CC_HANDLE=20cryptoContextHandle;=0A+=20=20=20=20=
CSSM_CSP_CreateSignatureContext(cspHandle,=20CSSM_ALGID_RSA,=20=
pCredentials,=20pCssmKey,=20&cryptoContextHandle);=0A+=09=0A+=20=20=20=20=
CSSM_SignData(cryptoContextHandle,=20&dataBuf,=201,=20CSSM_ALGID_NONE,=20=
&signBuf);=0A+=20=20=20=20=0A+=20=20=20=20=
CSSM_DeleteContext(cryptoContextHandle);=0A+=20=20=20=20=
CFRelease(privateKey);=0A+=20=20=20=20return=20signBuf;=0A+}=0A+=0A+void=20=
freeSignature(SecIdentityRef=20identity,=20CSSM_DATA=20sigBuf)=0A+{=0A+=20=
=20=20=20SecKeyRef=20privateKey;=0A+=20=20=20=20=0A+=20=20=20=20=
SecIdentityCopyPrivateKey(identity,=20=20&privateKey);=20=0A+=20=20=20=20=
=0A+=20=20=20=20CSSM_CSP_HANDLE=20cspHandle;=0A+=20=20=20=20=
SecKeyGetCSPHandle(privateKey,=20&cspHandle);=0A+=09=0A+=09=
CSSM_API_MEMORY_FUNCS=20memFuncs;=0A+=09=
CSSM_GetAPIMemoryFunctions(cspHandle,=20&memFuncs);=09=0A+=09=0A+=09=
memFuncs.free_func(sigBuf.Data,=20memFuncs.AllocRef);=0A+}=0A+=0Adiff=20=
--git=20a/osx/crypto_osx.h=20b/osx/crypto_osx.h=0Anew=20file=20mode=20=
100755=0Aindex=200000000..b4fc8ee=0A---=20/dev/null=0A+++=20=
b/osx/crypto_osx.h=0A@@=20-0,0=20+1,34=20@@=0A+/*=0A+=20*=20=20OpenVPN=20=
--=20An=20application=20to=20securely=20tunnel=20IP=20networks=0A+=20*=20=
=20=20=20=20=20=20=20=20=20=20=20=20over=20a=20single=20UDP=20port,=20=
with=20support=20for=20SSL/TLS-based=0A+=20*=20=20=20=20=20=20=20=20=20=20=
=20=20=20session=20authentication=20and=20key=20exchange,=0A+=20*=20=20=20=
=20=20=20=20=20=20=20=20=20=20packet=20encryption,=20packet=20=
authentication,=20and=0A+=20*=20=20=20=20=20=20=20=20=20=20=20=20=20=
packet=20compression.=0A+=20*=0A+=20*=20=20Copyright=20(C)=202010=20=
Brian=20Raderman=20<brian@...1360...>=0A+=20*=0A+=20*=20=20=
This=20program=20is=20free=20software;=20you=20can=20redistribute=20it=20=
and/or=20modify=0A+=20*=20=20it=20under=20the=20terms=20of=20the=20GNU=20=
General=20Public=20License=20version=202=0A+=20*=20=20as=20published=20=
by=20the=20Free=20Software=20Foundation.=0A+=20*=0A+=20*=20=20This=20=
program=20is=20distributed=20in=20the=20hope=20that=20it=20will=20be=20=
useful,=0A+=20*=20=20but=20WITHOUT=20ANY=20WARRANTY;=20without=20even=20=
the=20implied=20warranty=20of=0A+=20*=20=20MERCHANTABILITY=20or=20=
FITNESS=20FOR=20A=20PARTICULAR=20PURPOSE.=20=20See=20the=0A+=20*=20=20=
GNU=20General=20Public=20License=20for=20more=20details.=0A+=20*=0A+=20*=20=
=20You=20should=20have=20received=20a=20copy=20of=20the=20GNU=20General=20=
Public=20License=0A+=20*=20=20along=20with=20this=20program=20(see=20the=20=
file=20COPYING=20included=20with=20this=0A+=20*=20=20distribution);=20if=20=
not,=20write=20to=20the=20Free=20Software=20Foundation,=20Inc.,=0A+=20*=20=
=2059=20Temple=20Place,=20Suite=20330,=20Boston,=20MA=20=2002111-1307=20=20=
USA=0A+=20*/=0A+=0A+#ifndef=20__crypto_osx_h__=0A+#define=20=
__crypto_osx_h__=0A+=0A+#include=20<CoreFoundation/CoreFoundation.h>=0A=
+#include=20<Security/Security.h>=0A+=0A+CSSM_DATA=20=
signData(SecIdentityRef=20identity,=20CSSM_DATA=20dataBuf);=0A+void=20=
freeSignature(SecIdentityRef=20identity,=20CSSM_DATA=20sigBuf);=0A+=0A=
+#endif=20//__crypto_osx_h__=0Adiff=20--git=20a/osx/keychain.c=20=
b/osx/keychain.c=0Anew=20file=20mode=20100755=0Aindex=200000000..238dc9a=0A=
---=20/dev/null=0A+++=20b/osx/keychain.c=0A@@=20-0,0=20+1,290=20@@=0A+/*=0A=
+=20*=20File:=20keyhchain.c.=20=20Original=20was=20named=20cryptoapi.c.=0A=
+=20*=0A+=20*=20Copyright=20(c)=202004=20Peter=20'Luna'=20Runestig=20=
<peter@...292...>=0A+=20*=20All=20rights=20reserved.=0A+=20*=0A+=20*=20=
Redistribution=20and=20use=20in=20source=20and=20binary=20forms,=20with=20=
or=20without=20modifi-=0A+=20*=20cation,=20are=20permitted=20provided=20=
that=20the=20following=20conditions=20are=20met:=0A+=20*=0A+=20*=20=20=20=
o=20=20Redistributions=20of=20source=20code=20must=20retain=20the=20=
above=20copyright=20notice,=0A+=20*=20=20=20=20=20=20this=20list=20of=20=
conditions=20and=20the=20following=20disclaimer.=0A+=20*=0A+=20*=20=20=20=
o=20=20Redistributions=20in=20binary=20form=20must=20reproduce=20the=20=
above=20copyright=20no-=0A+=20*=20=20=20=20=20=20tice,=20this=20list=20=
of=20conditions=20and=20the=20following=20disclaimer=20in=20the=20do-=0A=
+=20*=20=20=20=20=20=20cumentation=20and/or=20other=20materials=20=
provided=20with=20the=20distribution.=0A+=20*=0A+=20*=20=20=20o=20=20The=20=
names=20of=20the=20contributors=20may=20not=20be=20used=20to=20endorse=20=
or=20promote=0A+=20*=20=20=20=20=20=20products=20derived=20from=20this=20=
software=20without=20specific=20prior=20written=0A+=20*=20=20=20=20=20=20=
permission.=0A+=20*=0A+=20*=20THIS=20SOFTWARE=20IS=20PROVIDED=20BY=20THE=20=
COPYRIGHT=20HOLDERS=20AND=20CONTRIBUTORS=0A+=20*=20``AS=20IS''=20AND=20=
ANY=20EXPRESS=20OR=20IMPLIED=20WARRANTIES,=20INCLUDING,=20BUT=20NOT=20=
LIMITED=0A+=20*=20TO,=20THE=20IMPLIED=20WARRANTIES=20OF=20=
MERCHANTABILITY=20AND=20FITNESS=20FOR=20A=20PARTICULAR=0A+=20*=20PURPOSE=20=
ARE=20DISCLAIMED.=20IN=20NO=20EVENT=20SHALL=20THE=20REGENTS=20OR=20=
CONTRIBUTORS=20BE=20LI-=0A+=20*=20ABLE=20FOR=20ANY=20DIRECT,=20INDIRECT,=20=
INCIDENTAL,=20SPECIAL,=20EXEMPLARY,=20OR=20CONSEQUEN-=0A+=20*=20TIAL=20=
DAMAGES=20(INCLUDING,=20BUT=20NOT=20LIMITED=20TO,=20PROCUREMENT=20OF=20=
SUBSTITUTE=20GOODS=0A+=20*=20OR=20SERVICES;=20LOSS=20OF=20USE,=20DATA,=20=
OR=20PROFITS;=20OR=20BUSINESS=20INTERRUPTION)=20HOWEV-=0A+=20*=20ER=20=
CAUSED=20AND=20ON=20ANY=20THEORY=20OF=20LIABILITY,=20WHETHER=20IN=20=
CONTRACT,=20STRICT=20LIABI-=0A+=20*=20LITY,=20OR=20TORT=20(INCLUDING=20=
NEGLIGENCE=20OR=20OTHERWISE)=20ARISING=20IN=20ANY=20WAY=20OUT=20OF=0A+=20=
*=20THE=20USE=20OF=20THIS=20SOFTWARE,=20EVEN=20IF=20ADVISED=20OF=20THE=20=
POSSIBILITY=20OF=20SUCH=20DAMAGE.=0A+=20*=0A+=20*=20This=20code=20has=20=
been=20modified=20from=20the=20original=20version=20by=20Brian=20=
Raderman=20=0A+=20*=20<brian@...1360...>.=20=20It=20was=20=
changed=20to=20work=20with=20the=20Mac=20OSX=0A+=20*=20Keychain=20=
services=20instead=20of=20the=20Microsoft=20Crypto=20API,=20which=20was=20=
its=20original=0A+=20*=20intent.=0A+=20*/=0A+=0A+#include=20"syshead.h"=0A=
+=0A+#if=20defined(USE_CRYPTO)=20&&=20defined(USE_SSL)=0A+=0A+#include=20=
<openssl/ssl.h>=0A+#include=20<openssl/err.h>=0A+#include=20<stdio.h>=0A=
+#include=20<ctype.h>=0A+#include=20<assert.h>=0A+#include=20=
<CoreFoundation/CoreFoundation.h>=0A+#include=20<Security/Security.h>=0A=
+#include=20"cert_data.h"=0A+#include=20"common_osx.h"=0A+#include=20=
"crypto_osx.h"=0A+=0A+/*=20Size=20of=20an=20SSL=20signature:=20MD5+SHA1=20=
*/=0A+#define=20SSL_SIG_LENGTH=0936=0A+=0A+/*=20try=20to=20funnel=20any=20=
Keychain/CSSM=20error=20messages=20to=20OpenSSL=20ERR_...=20*/=0A=
+#define=20ERR_LIB_KEYCHAIN=20(ERR_LIB_USER=20+=2070)=0A+#define=20=
KeychainErr(f)=20=20=20err_put_apple_error((f),=20__FILE__,=20__LINE__)=0A=
+#define=20KEYCHAIN_F_FIND_IDENTITY=09=20=20=20=20101=0A+#define=20=
KEYCHAIN_F_CREATE_CERT_DATA_FROM_STRING=20=20=20102=0A+#define=20=
KEYCHAIN_F_SIGN_DATA=09=09=09=20=20=20=20103=0A+=0A+static=20=
ERR_STRING_DATA=20KEYCHAIN_str_functs[]=20=3D=09{=0A+=20=20=20=20{=20=
ERR_PACK(ERR_LIB_KEYCHAIN,=200,=200),=09=09=09=09=20=20=20=20"Mac=20OSX=20=
Keychain"},=0A+=20=20=20=20{=20ERR_PACK(0,=20KEYCHAIN_F_FIND_IDENTITY,=20=
0),=09=09=20=20=20=20"findIdentity"=20},=0A+=20=20=20=20{=20ERR_PACK(0,=20=
KEYCHAIN_F_CREATE_CERT_DATA_FROM_STRING,=200),=09=20=20=20=20=
"createCertDataFromString"=20},=0A+=20=20=20=20{=20ERR_PACK(0,=20=
KEYCHAIN_F_SIGN_DATA,=200),=20=20=20=20"signData"=20},=0A+=20=20=20=20{=20=
0,=20NULL=20}=0A+};=0A+=0A+typedef=20struct=20_AppData=0A+{=0A+=09=
SecIdentityRef=20identity;=0A+=09struct=20gc_arena=20arena;=0A+}=20=
AppData;=0A+=0A+static=20void=20err_put_apple_error(int=20func,=20const=20=
char=20*file,=20int=20line)=0A+{=0A+=20=20=20=20static=20int=20init=20=3D=20=
0;=0A+=0A+=20=20=20=20if=20(!init)=20{=0A+=09=09=
ERR_load_strings(ERR_LIB_KEYCHAIN,=20KEYCHAIN_str_functs);=0A+=0A+=09=20=20=
=20=20ERR_STRING_DATA=20*esd=20=3D=20calloc(4,=20=
sizeof(ERR_STRING_DATA));=0A+=09=20=20=20=20if=20(esd)=0A+=09=09{=0A+=09=09=
=09esd[0].error=20=3D=20101;=0A+=09=09=09esd[0].string=20=3D=20"Unable=20=
to=20find=20identity=20in=20keychain=20(certificate=20+=20private=20=
key)";=0A+=0A+=09=09=09esd[1].error=20=3D=20102;=0A+=09=09=09=
esd[1].string=20=3D=20"Unable=20to=20parse=20certificate=20description=20=
string";=0A+=0A+=09=09=09esd[2].error=20=3D=20103;=0A+=09=09=09=
esd[2].string=20=3D=20"Unable=20to=20sign=20data=20with=20private=20=
key";=0A+=0A+=09=09=09ERR_load_strings(ERR_LIB_KEYCHAIN,=20esd);=0A+=09=09=
}=0A+=09=09=0A+=09=09init++;=0A+=20=20=20=20}=0A+=09=0A+=09=
ERR_PUT_error(ERR_LIB_KEYCHAIN,=20func,=200,=20file,=20line);=0A+}=0A+=0A=
+/*=20encrypt=20*/=0A+static=20int=20rsa_pub_enc(int=20flen,=20const=20=
unsigned=20char=20*from,=20unsigned=20char=20*to,=20RSA=20*rsa,=20int=20=
padding)=0A+{=0A+=20=20=20=20/*=20I=20haven't=20been=20able=20to=20=
trigger=20this=20one,=20but=20I=20want=20to=20know=20if=20it=20=
happens...=20*/=0A+=20=20=20=20assert(0);=0A+=20=20=20=20return=200;=0A=
+}=0A+=0A+/*=20verify=20arbitrary=20data=20*/=0A+static=20int=20=
rsa_pub_dec(int=20flen,=20const=20unsigned=20char=20*from,=20unsigned=20=
char=20*to,=20RSA=20*rsa,=20int=20padding)=0A+{=0A+=20=20=20=20/*=20I=20=
haven't=20been=20able=20to=20trigger=20this=20one,=20but=20I=20want=20to=20=
know=20if=20it=20happens...=20*/=0A+=20=20=20=20assert(0);=0A+=20=20=20=20=
return=200;=0A+}=0A+=0A+/*=20sign=20arbitrary=20data=20*/=0A+static=20=
int=20rsa_priv_enc(int=20flen,=20const=20unsigned=20char=20*from,=20=
unsigned=20char=20*to,=20RSA=20*rsa,=20int=20padding)=0A+{=0A+=09AppData=20=
*pData=20=3D=20(AppData*)=20rsa->meth->app_data;=0A+=09int=20length;=0A+=09=
=0A+=20=20=20=20if=20(!pData->identity)=20=0A+=09{=0A+=09=09=
RSAerr(RSA_F_RSA_EAY_PRIVATE_ENCRYPT,=20ERR_R_PASSED_NULL_PARAMETER);=0A=
+=09=09return=200;=0A+=20=20=20=20}=0A+=09=0A+=20=20=20=20if=20(padding=20=
!=3D=20RSA_PKCS1_PADDING)=20=0A+=09{=0A+=09=09=
RSAerr(RSA_F_RSA_EAY_PRIVATE_ENCRYPT,=20RSA_R_UNKNOWN_PADDING_TYPE);=0A+=09=
=09return=200;=0A+=20=20=20=20}=0A+=09=0A+=09CSSM_DATA=20fromData;=0A+=09=
fromData.Data=20=3D=20(uint8*)from;=0A+=09fromData.Length=20=3D=20flen;=0A=
+=09CSSM_DATA=20sigBuf=20=3D=20signData(pData->identity,=20fromData);=0A=
+=09length=20=3D=20sigBuf.Length;=0A+=09memcpy(to,=20sigBuf.Data,=20=
sigBuf.Length);=0A+=09freeSignature(pData->identity,=20sigBuf);=0A+=20=20=
=20=20return=20length;=0A+}=0A+=0A+/*=20decrypt=20*/=0A+static=20int=20=
rsa_priv_dec(int=20flen,=20const=20unsigned=20char=20*from,=20unsigned=20=
char=20*to,=20RSA=20*rsa,=20int=20padding)=0A+{=0A+=20=20=20=20/*=20I=20=
haven't=20been=20able=20to=20trigger=20this=20one,=20but=20I=20want=20to=20=
know=20if=20it=20happens...=20*/=0A+=20=20=20=20assert(0);=0A+=20=20=20=20=
return=200;=0A+}=0A+=0A+/*=20called=20at=20RSA_new=20*/=0A+static=20int=20=
init(RSA=20*rsa)=0A+{=0A+=20=20=20=20return=200;=0A+}=0A+=0A+/*=20called=20=
at=20RSA_free=20*/=0A+static=20int=20finish(RSA=20*rsa)=0A+{=0A+=09=
AppData=20*pData=20=3D=20(AppData*)=20rsa->meth->app_data;=0A+=0A+=20=20=20=
=20if=20(!pData->identity)=0A+=09=09return=200;=0A+=09=0A+=09=
CFRelease(pData->identity);=0A+=09gc_free(&(pData->arena));=0A+=20=20=20=20=
rsa->meth=20=3D=20NULL;=0A+=20=20=20=20return=201;=0A+}=0A+=0A+int=20=
SSL_CTX_use_Keychain_certificate(SSL_CTX=20*ssl_ctx,=20const=20char=20=
*cert_prop)=0A+{=0A+=20=20=20=20X509=20*cert=20=3D=20NULL;=0A+=20=20=20=20=
RSA=20*rsa=20=3D=20NULL,=20*pub_rsa;=0A+=20=20=20=20RSA_METHOD=20=
*my_rsa_method;=20=0A+=09SecIdentityRef=20identity=20=3D=20NULL;=0A+=09=
struct=20gc_arena=20arena=20=3D=20gc_new();=0A+=09=0A+=09initCertData();=0A=
+=09=0A+=09my_rsa_method=20=3D=20=
(RSA_METHOD*)gc_malloc(sizeof(RSA_METHOD),=20true,=20&arena);=0A+=09=0A+=20=
=20=20=20if=20(my_rsa_method=20=3D=3D=20NULL)=20=0A+=09{=0A+=09=09=
SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE,=20ERR_R_MALLOC_FAILURE);=0A+=09=
=09goto=20err;=0A+=20=20=20=20}=0A+=0A+=09AppData=20*pData=20=3D=20=
(AppData*)gc_malloc(sizeof(AppData),=20false,=20&arena);=0A+=09=
pData->arena=20=3D=20arena;=0A+=09=0A+=09CertDataRef=20pCertDataTemplate=20=
=3D=20createCertDataFromString(cert_prop);=0A+=09identity=20=3D=20=
findIdentity(pCertDataTemplate);=0A+=09=
destroyCertData(pCertDataTemplate);=0A+=09freeCertData();=0A+=09=0A+=20=09=
if=20(!identity)=20=0A+=09{=0A+=09=20=20=20=20=
KeychainErr(KEYCHAIN_F_FIND_IDENTITY);=0A+=09=20=20=20=20goto=20err;=0A+=09=
}=0A+=09=0A+=09pData->identity=20=3D=20identity;=0A+=09=0A+=20=20=20=20=
CSSM_DATA=20cssmCertData;=0A+=09SecCertificateRef=20certificate;=0A+=0A+=20=
=20=20=20SecIdentityCopyCertificate(identity,=20&certificate);=0A+=09=
SecCertificateGetData=20(certificate,=20&cssmCertData);=0A+=09=
CFRelease(certificate);=0A+=0A+=20=20=20=20/*=20=
cert_context->pbCertEncoded=20is=20the=20cert=20X509=20DER=20encoded.=20=
*/=0A+=20=20=20=20cert=20=3D=20d2i_X509(NULL,=20(unsigned=20char=20**)=20=
&cssmCertData.Data,=20cssmCertData.Length);=0A+=20=20=20=20if=20(cert=20=
=3D=3D=20NULL)=20=0A+=09{=0A+=09=09=
SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE,=20ERR_R_ASN1_LIB);=0A+=09=09=
goto=20err;=0A+=20=20=20=20}=0A+=0A+=20=20=20=20my_rsa_method->name=20=3D=20=
"Mac=20OSX=20Keychain=20RSA=20Method";=0A+=20=20=20=20=
my_rsa_method->rsa_pub_enc=20=3D=20rsa_pub_enc;=0A+=20=20=20=20=
my_rsa_method->rsa_pub_dec=20=3D=20rsa_pub_dec;=0A+=20=20=20=20=
my_rsa_method->rsa_priv_enc=20=3D=20rsa_priv_enc;=0A+=20=20=20=20=
my_rsa_method->rsa_priv_dec=20=3D=20rsa_priv_dec;=0A+=20=20=20=20/*=20=
my_rsa_method->init=20=3D=20init;=20*/=0A+=20=20=20=20=
my_rsa_method->finish=20=3D=20finish;=0A+=20=20=20=20=
my_rsa_method->flags=20=3D=20RSA_METHOD_FLAG_NO_CHECK;=0A+=20=20=20=20=
my_rsa_method->app_data=20=3D=20(char=20*)=20pData;=0A+=0A+=20=20=20=20=
rsa=20=3D=20RSA_new();=0A+=20=20=20=20if=20(rsa=20=3D=3D=20NULL)=0A+=09{=0A=
+=09=09SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE,=20=
ERR_R_MALLOC_FAILURE);=0A+=09=09goto=20err;=0A+=20=20=20=20}=0A+=0A+=20=20=
=20=20/*=20cert->cert_info->key->pkey=20is=20NULL=20until=20we=20call=20=
SSL_CTX_use_certificate(),=0A+=20=20=20=20=20*=20so=20we=20do=20it=20=
here=20then...=20=20*/=0A+=20=20=20=20if=20=
(!SSL_CTX_use_certificate(ssl_ctx,=20cert))=0A+=09=09goto=20err;=0A+=09=0A=
+=20=20=20=20/*=20the=20public=20key=20*/=0A+=20=20=20=20pub_rsa=20=3D=20=
cert->cert_info->key->pkey->pkey.rsa;=0A+=20=20=20=20/*=20=
SSL_CTX_use_certificate()=20increased=20the=20reference=20count=20in=20=
'cert',=20so=0A+=20=20=20=20=20*=20we=20decrease=20it=20here=20with=20=
X509_free(),=20or=20it=20will=20never=20be=20cleaned=20up.=20*/=0A+=20=20=
=20=20X509_free(cert);=0A+=20=20=20=20cert=20=3D=20NULL;=0A+=0A+=20=20=20=
=20/*=20I'm=20not=20sure=20about=20what=20we=20have=20to=20fill=20in=20=
in=20the=20RSA,=20trying=20out=20stuff...=20*/=0A+=20=20=20=20/*=20=
rsa->n=20indicates=20the=20key=20size=20*/=0A+=20=20=20=20rsa->n=20=3D=20=
BN_dup(pub_rsa->n);=0A+=20=20=20=20rsa->flags=20|=3D=20=
RSA_FLAG_EXT_PKEY;=0A+=20=20=20=20if=20(!RSA_set_method(rsa,=20=
my_rsa_method))=0A+=09=09goto=20err;=0A+=0A+=20=20=20=20if=20=
(!SSL_CTX_use_RSAPrivateKey(ssl_ctx,=20rsa))=0A+=09=09goto=20err;=0A+=09=0A=
+=20=20=20=20/*=20SSL_CTX_use_RSAPrivateKey()=20increased=20the=20=
reference=20count=20in=20'rsa',=20so=0A+=20=20=20=20=20*=20we=20decrease=20=
it=20here=20with=20RSA_free(),=20or=20it=20will=20never=20be=20cleaned=20=
up.=20*/=0A+=20=20=20=20RSA_free(rsa);=0A+=20=20=20=20return=201;=0A+=0A=
+=20=20err:=09=0A+=20=20=20=20if=20(cert)=0A+=09=09X509_free(cert);=0A+=09=
=0A+=20=20=20=20if=20(rsa)=0A+=09{=0A+=09=09RSA_free(rsa);=0A+=09}=0A+=20=
=20=20=20else=20=0A+=09{=09=09=0A+=09=09if=20(identity)=20=0A+=09=09=09=
CFRelease(identity);=0A+=20=20=20=20}=0A+=09=0A+=09freeCertData();=0A+=09=
gc_free(&arena);=0A+=0A+=20=20=20=20return=200;=0A+}=0A+=0A+#endif=09=09=09=
=09/*=20=20defined(USE_CRYPTO)=20&&=20defined(USE_SSL)=20*/=0Adiff=20=
--git=20a/osx/keychain.h=20b/osx/keychain.h=0Anew=20file=20mode=20100755=0A=
index=200000000..ba6e1b1=0A---=20/dev/null=0A+++=20b/osx/keychain.h=0A@@=20=
-0,0=20+1,7=20@@=0A+#ifndef=20_OSXKEYCHAIN_H_=0A+#define=20=
_OSXKEYCHAIN_H_=0A+=0A+int=20SSL_CTX_use_Keychain_certificate(SSL_CTX=20=
*ssl_ctx,=20const=20char=20*cert_prop);=0A+=0A+=0A+#endif=20/*=20=
!_OSXKEYCHAIN_H_=20*/=0Adiff=20--git=20a/ssl.c=20b/ssl.c=0Aindex=20=
1b275af..3a2dd85=20100644=0A---=20a/ssl.c=0A+++=20b/ssl.c=0A@@=20-1601,6=20=
+1601,16=20@@=20init_ssl=20(const=20struct=20options=20*options)=0A=20=09=
}=0A=20=20=20=20=20=20=20else=0A=20#endif=0A+#ifdef=20KEYCHAINCERT=0A+=09=
if=20(options->keychain_cert)=0A+=09{=0A+=09=20=20/*=20Load=20=
Certificate=20and=20Private=20Key=20*/=0A+=09=20=20if=20=
(!SSL_CTX_use_Keychain_certificate=20(ctx,=20options->keychain_cert))=0A=
+=09=09=20=20msg=20(M_SSLERR,=20"Cannot=20load=20certificate=20\"%s\"=20=
from=20Mac=20OSX=20Keychain",=0A+=09=09=09=20=20=20=
options->keychain_cert);=0A+=09}=0A+=09else=0A+#endif=0A=20=09{=0A=20=09=20=
=20/*=20Load=20Certificate=20*/=0A=20=09=20=20if=20(options->cert_file)=0A=
--=20=0A1.7.0=0A=0A=

--Apple-Mail-42-182273120
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



On Apr 28, 2010, at 2:53 AM, David Sommerseth wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Hi Brian,
>=20
> Thanks a lot for your patch!  This is indeed a neat feature we want to
> really consider for inclusion!  But there are of course a few things I
> spotted which I'd like to see being improved.
>=20
> I am not familiar with OSX details at all, but I hope someone else with
> better OSX understanding can review those parts more thoroughly.  My
> comments will be of the more generic type.
>=20
> * usage of printf()
> Please use the msg() function instead.  Don't print things to console
> directly via {f,}printf() directly.  There are plenty of places in the
> code where you can see msg() being used for a lot of logging.
>=20
> * malloc()
> You use malloc() several places.  If possible try to make use of the
> gc_arena API instead.  This API is also used a lot of places in the
> code, so you'll most likely find some good examples there as well.
>=20
> * static void dummy1() function
> In osx/keychain.c you define a rather silly function, which is not used
> anywhere.  Please take this one out.
>=20
> * xcode files and migration to autotools
> Even though Xcode is probably a very good tool on OSX, it's not what we
> can base OpenVPN on.  I would like to see this migrated over to
> autotools.  It's not as hard and difficult as you might think
> immediately, but there are several traps on the way.  Some traps more
> visible than others.
>=20
> First of all, it's a pretty good autotools tutorial [1] which is worth
> going through to understand the concept and how to get started.
>=20
> Then you'll need to modify configure.ac and Makefile.am.  And that's
> basically it.  Have a look for SOCKS in configure.ac to get an idea.
> Further, you'll also need to add the source files of our osx/ C and H
> files to openvpn_SOURCES.  But! These files should probably be depending
> on if this OSX feature is enabled or not.  There's probably several ways
> how to solve this, and I'm not sure what's the best solution right now.
> But digging into automake docs[2] might be the proper place to start.
>=20
> When you think you're done, ./configure works and it seems to compile
> flawlessly by running 'make', try runnning 'make distcheck' to be sure
> it will package itself properly, that the test compilation and test run
> works as expected as well.
>=20
>=20
> That's basically all I had to comment so far.  But thanks again for your
> patch!  Looking forward to hear from you again with further updates as we=
ll.
>=20
>=20
> kind regards,
>=20
> David Sommerseth
>=20
>=20
> [1] <http://www.lrde.epita.fr/~adl/autotools.html>
> [2] <http://sources.redhat.com/automake/automake.html>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>=20
> iEYEARECAAYFAkvX23gACgkQDC186MBRfroWXgCfeZUA1pFrSsu55MMk3gg9TIcJ
> M0EAoKO/OYi2v5YMNDankep5vqMEX7hC
> =3DsXAB
> -----END PGP SIGNATURE-----


--Apple-Mail-42-182273120--

