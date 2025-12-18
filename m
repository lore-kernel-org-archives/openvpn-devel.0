From: Yuriy Darnobyt <yuriy.darnobyt@...2722...>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_CE0DDBA4-1D3C-4EE5-A7B2-FD7F9B665277"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Message-Id: <FF81D452-5733-4137-8594-D579BA602996@...2722...>
Date: Thu, 18 Dec 2025 09:54:36 +0200
Subject: [Openvpn-devel] OpenVPN 2.7_rc4 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

--Apple-Mail=_CE0DDBA4-1D3C-4EE5-A7B2-FD7F9B665277
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN 2.7_rc4.

This is the fourth release candidate for the feature release 2.7.0.

Important bug fixes since 2.7_rc3:

* Windows interactive service: do not configure adapter DNS if
  there are no search-domains but there are resolve-domains (which
  get resolved via NRPT rules) - GH: OpenVPN/openvpn#473
* improve documentation and error messages for a number of deprecated
  options=20
* improve documentation for not-really-deprecated-yet ``--ns-cert-type``
* Windows IPv4 configuration with netsh.exe: ensure addresses are added
  with "store=3Dactive" (ensure proper cleanup) - GH: OpenVPN/openvpn#915
* Windows: set UTF8 code page in openvpn.exe manifest, to make cert/key
  loading work again for files with non-ASCII characters in their file
  name (GH: OpenVPN/openvpn#920)
* tun.c: unify read_tun()/write_tun() functions for all BSD platforms
* more type conversion related cleanups
* add NULL check before freeaddrinfo() call, which might lead to a
  crash on OpenBSD (GH: OpenVPN/openvpn#930)
* add NULL check to mbedtls handling of external and inline certificates
* add check for auth none / cipher none on FreeBSD DCO
* add CAP_SYS_NICE to positive list in Linux systemd unit files
  (GH: OpenVPN/openvpn#834)
* drop mbedtls 2.x support  (which is end of life, and work on mbedtls 4
  is much simplified by not having to take care of 2.x compat as well)
* PUSH_UPDATE: bugfix for the client side where split/continued messages
  (due to large number of "route" statements) would not correctly handle
  the full set of routes.  Add unit test.  (GH: OpenVPN/openvpn#925)
* new unit test module for mbuf handling
* deprecate --fast-io option (it got partially broken by the multisocket
  implementation, and the benefits of the existing implementation did
  not outweigh the extra code complexity to make it work again)
* change the ssl_ctx in struct tls_options to be a pointer - this is=20
  a shared data structure between various contexts, but previously it
  was shallow-copied, leading to needless CRL reloading - and when
  working on implementing the new OpenSSL CRL API, to segfaults
  (the existing code works, as these new APIs are not used yet).

More details can be found in the Changes document:

<https://github.com/OpenVPN/openvpn/blob/master/Changes.rst>

Source code and Windows installers can be downloaded from our download page:

<https://openvpn.net/community-downloads/>

Packages for Debian, Ubuntu, Fedora, RHEL, and openSUSE are available in th=
e various
official Community repositories:

<https://community.openvpn.net/Pages/OpenVPN%20software%20repos>

Kind regards,
Yuriy Darnobyt=

--Apple-Mail=_CE0DDBA4-1D3C-4EE5-A7B2-FD7F9B665277
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=
=3Dus-ascii"></head><body style=3D"overflow-wrap: break-word; -webkit-nbsp-=
mode: space; line-break: after-white-space;"><p style=3D"margin: 0px; font-=
width: normal; line-height: normal; font-size-adjust: none; font-kerning: a=
uto; font-variant-alternates: normal; font-variant-ligatures: normal; font-=
variant-numeric: normal; font-variant-east-asian: normal; font-variant-posi=
tion: normal; font-feature-settings: normal; font-optical-sizing: auto; fon=
t-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-colo=
r: rgb(0, 0, 0);">The OpenVPN community project team is proud to release Op=
enVPN 2.7_rc4.</p><p style=3D"margin: 0px; font-width: normal; line-height:=
 normal; font-size-adjust: none; font-kerning: auto; font-variant-alternate=
s: normal; font-variant-ligatures: normal; font-variant-numeric: normal; fo=
nt-variant-east-asian: normal; font-variant-position: normal; font-feature-=
settings: normal; font-optical-sizing: auto; font-variation-settings: norma=
l; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);"><br></p><=
p style=3D"margin: 0px; font-width: normal; line-height: normal; font-size-=
adjust: none; font-kerning: auto; font-variant-alternates: normal; font-var=
iant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asi=
an: normal; font-variant-position: normal; font-feature-settings: normal; f=
ont-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0,=
 0); -webkit-text-stroke-color: rgb(0, 0, 0);">This is the fourth release c=
andidate for the feature release 2.7.0.</p><p style=3D"margin: 0px; font-wi=
dth: normal; line-height: normal; font-size-adjust: none; font-kerning: aut=
o; font-variant-alternates: normal; font-variant-ligatures: normal; font-va=
riant-numeric: normal; font-variant-east-asian: normal; font-variant-positi=
on: normal; font-feature-settings: normal; font-optical-sizing: auto; font-=
variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color:=
 rgb(0, 0, 0);"><br></p><p style=3D"margin: 0px; font-width: normal; line-h=
eight: normal; font-size-adjust: none; font-kerning: auto; font-variant-alt=
ernates: normal; font-variant-ligatures: normal; font-variant-numeric: norm=
al; font-variant-east-asian: normal; font-variant-position: normal; font-fe=
ature-settings: normal; font-optical-sizing: auto; font-variation-settings:=
 normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">Imp=
ortant bug fixes since 2.7_rc3:</p><p style=3D"margin: 0px; font-width: nor=
mal; line-height: normal; font-size-adjust: none; font-kerning: auto; font-=
variant-alternates: normal; font-variant-ligatures: normal; font-variant-nu=
meric: normal; font-variant-east-asian: normal; font-variant-position: norm=
al; font-feature-settings: normal; font-optical-sizing: auto; font-variatio=
n-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, =
0, 0);"><br></p><p style=3D"margin: 0px; font-width: normal; line-height: n=
ormal; font-size-adjust: none; font-kerning: auto; font-variant-alternates:=
 normal; font-variant-ligatures: normal; font-variant-numeric: normal; font=
-variant-east-asian: normal; font-variant-position: normal; font-feature-se=
ttings: normal; font-optical-sizing: auto; font-variation-settings: normal;=
 color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">* Windows i=
nteractive service: do not configure adapter DNS if</p><p style=3D"margin: =
0px; font-width: normal; line-height: normal; font-size-adjust: none; font-=
kerning: auto; font-variant-alternates: normal; font-variant-ligatures: nor=
mal; font-variant-numeric: normal; font-variant-east-asian: normal; font-va=
riant-position: normal; font-feature-settings: normal; font-optical-sizing:=
 auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-s=
troke-color: rgb(0, 0, 0);">&nbsp; there are no search-domains but there ar=
e resolve-domains (which</p><p style=3D"margin: 0px; font-width: normal; li=
ne-height: normal; font-size-adjust: none; font-kerning: auto; font-variant=
-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: =
normal; font-variant-east-asian: normal; font-variant-position: normal; fon=
t-feature-settings: normal; font-optical-sizing: auto; font-variation-setti=
ngs: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);"=
>&nbsp; get resolved via NRPT rules) - GH: OpenVPN/openvpn#473</p><p style=
=3D"margin: 0px; font-width: normal; line-height: normal; font-size-adjust:=
 none; font-kerning: auto; font-variant-alternates: normal; font-variant-li=
gatures: normal; font-variant-numeric: normal; font-variant-east-asian: nor=
mal; font-variant-position: normal; font-feature-settings: normal; font-opt=
ical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -w=
ebkit-text-stroke-color: rgb(0, 0, 0);">* improve documentation and error m=
essages for a number of deprecated</p><p style=3D"margin: 0px; font-width: =
normal; line-height: normal; font-size-adjust: none; font-kerning: auto; fo=
nt-variant-alternates: normal; font-variant-ligatures: normal; font-variant=
-numeric: normal; font-variant-east-asian: normal; font-variant-position: n=
ormal; font-feature-settings: normal; font-optical-sizing: auto; font-varia=
tion-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(=
0, 0, 0);">&nbsp; options&nbsp;</p><p style=3D"margin: 0px; font-width: nor=
mal; line-height: normal; font-size-adjust: none; font-kerning: auto; font-=
variant-alternates: normal; font-variant-ligatures: normal; font-variant-nu=
meric: normal; font-variant-east-asian: normal; font-variant-position: norm=
al; font-feature-settings: normal; font-optical-sizing: auto; font-variatio=
n-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, =
0, 0);">* improve documentation for not-really-deprecated-yet ``--ns-cert-t=
ype``</p><p style=3D"margin: 0px; font-width: normal; line-height: normal; =
font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal=
; font-variant-ligatures: normal; font-variant-numeric: normal; font-varian=
t-east-asian: normal; font-variant-position: normal; font-feature-settings:=
 normal; font-optical-sizing: auto; font-variation-settings: normal; color:=
 rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">* Windows IPv4 con=
figuration with netsh.exe: ensure addresses are added</p><p style=3D"margin=
: 0px; font-width: normal; line-height: normal; font-size-adjust: none; fon=
t-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: n=
ormal; font-variant-numeric: normal; font-variant-east-asian: normal; font-=
variant-position: normal; font-feature-settings: normal; font-optical-sizin=
g: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text=
-stroke-color: rgb(0, 0, 0);">&nbsp; with "store=3Dactive" (ensure proper c=
leanup) - GH: OpenVPN/openvpn#915</p><p style=3D"margin: 0px; font-width: n=
ormal; line-height: normal; font-size-adjust: none; font-kerning: auto; fon=
t-variant-alternates: normal; font-variant-ligatures: normal; font-variant-=
numeric: normal; font-variant-east-asian: normal; font-variant-position: no=
rmal; font-feature-settings: normal; font-optical-sizing: auto; font-variat=
ion-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0=
, 0, 0);">* Windows: set UTF8 code page in openvpn.exe manifest, to make ce=
rt/key</p><p style=3D"margin: 0px; font-width: normal; line-height: normal;=
 font-size-adjust: none; font-kerning: auto; font-variant-alternates: norma=
l; font-variant-ligatures: normal; font-variant-numeric: normal; font-varia=
nt-east-asian: normal; font-variant-position: normal; font-feature-settings=
: normal; font-optical-sizing: auto; font-variation-settings: normal; color=
: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">&nbsp; loading wo=
rk again for files with non-ASCII characters in their file</p><p style=3D"m=
argin: 0px; font-width: normal; line-height: normal; font-size-adjust: none=
; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatur=
es: normal; font-variant-numeric: normal; font-variant-east-asian: normal; =
font-variant-position: normal; font-feature-settings: normal; font-optical-=
sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit=
-text-stroke-color: rgb(0, 0, 0);">&nbsp; name (GH: OpenVPN/openvpn#920)</p=
><p style=3D"margin: 0px; font-width: normal; line-height: normal; font-siz=
e-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-v=
ariant-ligatures: normal; font-variant-numeric: normal; font-variant-east-a=
sian: normal; font-variant-position: normal; font-feature-settings: normal;=
 font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, =
0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">* tun.c: unify read_tun()/=
write_tun() functions for all BSD platforms</p><p style=3D"margin: 0px; fon=
t-width: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-feature-settings: normal; font-optical-sizing: auto; f=
ont-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-co=
lor: rgb(0, 0, 0);">* more type conversion related cleanups</p><p style=3D"=
margin: 0px; font-width: normal; line-height: normal; font-size-adjust: non=
e; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatu=
res: normal; font-variant-numeric: normal; font-variant-east-asian: normal;=
 font-variant-position: normal; font-feature-settings: normal; font-optical=
-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webki=
t-text-stroke-color: rgb(0, 0, 0);">* add NULL check before freeaddrinfo() =
call, which might lead to a</p><p style=3D"margin: 0px; font-width: normal;=
 line-height: normal; font-size-adjust: none; font-kerning: auto; font-vari=
ant-alternates: normal; font-variant-ligatures: normal; font-variant-numeri=
c: normal; font-variant-east-asian: normal; font-variant-position: normal; =
font-feature-settings: normal; font-optical-sizing: auto; font-variation-se=
ttings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0=
);">&nbsp; crash on OpenBSD (GH: OpenVPN/openvpn#930)</p><p style=3D"margin=
: 0px; font-width: normal; line-height: normal; font-size-adjust: none; fon=
t-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: n=
ormal; font-variant-numeric: normal; font-variant-east-asian: normal; font-=
variant-position: normal; font-feature-settings: normal; font-optical-sizin=
g: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text=
-stroke-color: rgb(0, 0, 0);">* add NULL check to mbedtls handling of exter=
nal and inline certificates</p><p style=3D"margin: 0px; font-width: normal;=
 line-height: normal; font-size-adjust: none; font-kerning: auto; font-vari=
ant-alternates: normal; font-variant-ligatures: normal; font-variant-numeri=
c: normal; font-variant-east-asian: normal; font-variant-position: normal; =
font-feature-settings: normal; font-optical-sizing: auto; font-variation-se=
ttings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0=
);">* add check for auth none / cipher none on FreeBSD DCO</p><p style=3D"m=
argin: 0px; font-width: normal; line-height: normal; font-size-adjust: none=
; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatur=
es: normal; font-variant-numeric: normal; font-variant-east-asian: normal; =
font-variant-position: normal; font-feature-settings: normal; font-optical-=
sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit=
-text-stroke-color: rgb(0, 0, 0);">* add CAP_SYS_NICE to positive list in L=
inux systemd unit files</p><p style=3D"margin: 0px; font-width: normal; lin=
e-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-=
alternates: normal; font-variant-ligatures: normal; font-variant-numeric: n=
ormal; font-variant-east-asian: normal; font-variant-position: normal; font=
-feature-settings: normal; font-optical-sizing: auto; font-variation-settin=
gs: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">=
&nbsp; (GH: OpenVPN/openvpn#834)</p><p style=3D"margin: 0px; font-width: no=
rmal; line-height: normal; font-size-adjust: none; font-kerning: auto; font=
-variant-alternates: normal; font-variant-ligatures: normal; font-variant-n=
umeric: normal; font-variant-east-asian: normal; font-variant-position: nor=
mal; font-feature-settings: normal; font-optical-sizing: auto; font-variati=
on-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0,=
 0, 0);">* drop mbedtls 2.x support &nbsp;(which is end of life, and work o=
n mbedtls 4</p><p style=3D"margin: 0px; font-width: normal; line-height: no=
rmal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: =
normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-=
variant-east-asian: normal; font-variant-position: normal; font-feature-set=
tings: normal; font-optical-sizing: auto; font-variation-settings: normal; =
color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">&nbsp; is mu=
ch simplified by not having to take care of 2.x compat as well)</p><p style=
=3D"margin: 0px; font-width: normal; line-height: normal; font-size-adjust:=
 none; font-kerning: auto; font-variant-alternates: normal; font-variant-li=
gatures: normal; font-variant-numeric: normal; font-variant-east-asian: nor=
mal; font-variant-position: normal; font-feature-settings: normal; font-opt=
ical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -w=
ebkit-text-stroke-color: rgb(0, 0, 0);">* PUSH_UPDATE: bugfix for the clien=
t side where split/continued messages</p><p style=3D"margin: 0px; font-widt=
h: normal; line-height: normal; font-size-adjust: none; font-kerning: auto;=
 font-variant-alternates: normal; font-variant-ligatures: normal; font-vari=
ant-numeric: normal; font-variant-east-asian: normal; font-variant-position=
: normal; font-feature-settings: normal; font-optical-sizing: auto; font-va=
riation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: r=
gb(0, 0, 0);">&nbsp; (due to large number of "route" statements) would not =
correctly handle</p><p style=3D"margin: 0px; font-width: normal; line-heigh=
t: normal; font-size-adjust: none; font-kerning: auto; font-variant-alterna=
tes: normal; font-variant-ligatures: normal; font-variant-numeric: normal; =
font-variant-east-asian: normal; font-variant-position: normal; font-featur=
e-settings: normal; font-optical-sizing: auto; font-variation-settings: nor=
mal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">&nbsp; =
the full set of routes. &nbsp;Add unit test. &nbsp;(GH: OpenVPN/openvpn#925=
)</p><p style=3D"margin: 0px; font-width: normal; line-height: normal; font=
-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; fo=
nt-variant-ligatures: normal; font-variant-numeric: normal; font-variant-ea=
st-asian: normal; font-variant-position: normal; font-feature-settings: nor=
mal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb=
(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">* new unit test module=
 for mbuf handling</p><p style=3D"margin: 0px; font-width: normal; line-hei=
ght: normal; font-size-adjust: none; font-kerning: auto; font-variant-alter=
nates: normal; font-variant-ligatures: normal; font-variant-numeric: normal=
; font-variant-east-asian: normal; font-variant-position: normal; font-feat=
ure-settings: normal; font-optical-sizing: auto; font-variation-settings: n=
ormal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">* dep=
recate --fast-io option (it got partially broken by the multisocket</p><p s=
tyle=3D"margin: 0px; font-width: normal; line-height: normal; font-size-adj=
ust: none; font-kerning: auto; font-variant-alternates: normal; font-varian=
t-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian:=
 normal; font-variant-position: normal; font-feature-settings: normal; font=
-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0)=
; -webkit-text-stroke-color: rgb(0, 0, 0);">&nbsp; implementation, and the =
benefits of the existing implementation did</p><p style=3D"margin: 0px; fon=
t-width: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-feature-settings: normal; font-optical-sizing: auto; f=
ont-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-co=
lor: rgb(0, 0, 0);">&nbsp; not outweigh the extra code complexity to make i=
t work again)</p><p style=3D"margin: 0px; font-width: normal; line-height: =
normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates=
: normal; font-variant-ligatures: normal; font-variant-numeric: normal; fon=
t-variant-east-asian: normal; font-variant-position: normal; font-feature-s=
ettings: normal; font-optical-sizing: auto; font-variation-settings: normal=
; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">* change t=
he ssl_ctx in struct tls_options to be a pointer - this is&nbsp;</p><p styl=
e=3D"margin: 0px; font-width: normal; line-height: normal; font-size-adjust=
: none; font-kerning: auto; font-variant-alternates: normal; font-variant-l=
igatures: normal; font-variant-numeric: normal; font-variant-east-asian: no=
rmal; font-variant-position: normal; font-feature-settings: normal; font-op=
tical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -=
webkit-text-stroke-color: rgb(0, 0, 0);">&nbsp; a shared data structure bet=
ween various contexts, but previously it</p><p style=3D"margin: 0px; font-w=
idth: normal; line-height: normal; font-size-adjust: none; font-kerning: au=
to; font-variant-alternates: normal; font-variant-ligatures: normal; font-v=
ariant-numeric: normal; font-variant-east-asian: normal; font-variant-posit=
ion: normal; font-feature-settings: normal; font-optical-sizing: auto; font=
-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color=
: rgb(0, 0, 0);">&nbsp; was shallow-copied, leading to needless CRL reloadi=
ng - and when</p><p style=3D"margin: 0px; font-width: normal; line-height: =
normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates=
: normal; font-variant-ligatures: normal; font-variant-numeric: normal; fon=
t-variant-east-asian: normal; font-variant-position: normal; font-feature-s=
ettings: normal; font-optical-sizing: auto; font-variation-settings: normal=
; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">&nbsp; wor=
king on implementing the new OpenSSL CRL API, to segfaults</p><p style=3D"m=
argin: 0px; font-width: normal; line-height: normal; font-size-adjust: none=
; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatur=
es: normal; font-variant-numeric: normal; font-variant-east-asian: normal; =
font-variant-position: normal; font-feature-settings: normal; font-optical-=
sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit=
-text-stroke-color: rgb(0, 0, 0);">&nbsp; (the existing code works, as thes=
e new APIs are not used yet).</p><p style=3D"margin: 0px; font-width: norma=
l; line-height: normal; font-size-adjust: none; font-kerning: auto; font-va=
riant-alternates: normal; font-variant-ligatures: normal; font-variant-nume=
ric: normal; font-variant-east-asian: normal; font-variant-position: normal=
; font-feature-settings: normal; font-optical-sizing: auto; font-variation-=
settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0,=
 0); min-height: 14px;"><span style=3D"font-kerning: none;"></span><br></p>=
<p style=3D"margin: 0px; font-width: normal; line-height: normal; font-size=
-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-va=
riant-ligatures: normal; font-variant-numeric: normal; font-variant-east-as=
ian: normal; font-variant-position: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0=
, 0); -webkit-text-stroke-color: rgb(0, 0, 0);"><span style=3D"font-kerning=
: none;">More details can be found in the Changes document:</span></p><p st=
yle=3D"margin: 0px; font-width: normal; line-height: normal; font-size-adju=
st: none; font-kerning: auto; font-variant-alternates: normal; font-variant=
-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: =
normal; font-variant-position: normal; font-feature-settings: normal; font-=
optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);=
 -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 14px;"><span style=3D=
"font-kerning: none;"></span><br></p><p style=3D"margin: 0px; font-width: n=
ormal; line-height: normal; font-size-adjust: none; font-kerning: auto; fon=
t-variant-alternates: normal; font-variant-ligatures: normal; font-variant-=
numeric: normal; font-variant-east-asian: normal; font-variant-position: no=
rmal; font-feature-settings: normal; font-optical-sizing: auto; font-variat=
ion-settings: normal; color: rgb(53, 134, 255); -webkit-text-stroke-color: =
rgb(53, 134, 255);"><span style=3D"font-kerning: none; color: rgb(0, 0, 0);=
 -webkit-text-stroke-color: rgb(0, 0, 0);">&lt;<a href=3D"https://github.co=
m/OpenVPN/openvpn/blob/master/Changes.rst"><span style=3D"font-kerning: non=
e; color: rgb(53, 134, 255); -webkit-text-stroke-color: rgb(53, 134, 255);"=
>https://github.com/OpenVPN/openvpn/blob/master/Changes.rst</span></a>&gt;<=
/span></p><p style=3D"margin: 0px; font-width: normal; line-height: normal;=
 font-size-adjust: none; font-kerning: auto; font-variant-alternates: norma=
l; font-variant-ligatures: normal; font-variant-numeric: normal; font-varia=
nt-east-asian: normal; font-variant-position: normal; font-feature-settings=
: normal; font-optical-sizing: auto; font-variation-settings: normal; color=
: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 14px;"=
><span style=3D"font-kerning: none;"></span><br></p><p style=3D"margin: 0px=
; font-width: normal; line-height: normal; font-size-adjust: none; font-ker=
ning: auto; font-variant-alternates: normal; font-variant-ligatures: normal=
; font-variant-numeric: normal; font-variant-east-asian: normal; font-varia=
nt-position: normal; font-feature-settings: normal; font-optical-sizing: au=
to; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stro=
ke-color: rgb(0, 0, 0);"><span style=3D"font-kerning: none;">Source code an=
d Windows installers can be downloaded from our download page:</span></p><p=
 style=3D"margin: 0px; font-width: normal; line-height: normal; font-size-a=
djust: none; font-kerning: auto; font-variant-alternates: normal; font-vari=
ant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asia=
n: normal; font-variant-position: normal; font-feature-settings: normal; fo=
nt-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, =
0); -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 14px;"><span style=
=3D"font-kerning: none;"></span><br></p><p style=3D"margin: 0px; font-width=
: normal; line-height: normal; font-size-adjust: none; font-kerning: auto; =
font-variant-alternates: normal; font-variant-ligatures: normal; font-varia=
nt-numeric: normal; font-variant-east-asian: normal; font-variant-position:=
 normal; font-feature-settings: normal; font-optical-sizing: auto; font-var=
iation-settings: normal; color: rgb(53, 134, 255); -webkit-text-stroke-colo=
r: rgb(53, 134, 255);"><span style=3D"font-kerning: none; color: rgb(0, 0, =
0); -webkit-text-stroke-color: rgb(0, 0, 0);">&lt;<a href=3D"https://openvp=
n.net/community-downloads/"><span style=3D"font-kerning: none; color: rgb(5=
3, 134, 255); -webkit-text-stroke-color: rgb(53, 134, 255);">https://openvp=
n.net/community-downloads/</span></a>&gt;</span></p><p style=3D"margin: 0px=
; font-width: normal; line-height: normal; font-size-adjust: none; font-ker=
ning: auto; font-variant-alternates: normal; font-variant-ligatures: normal=
; font-variant-numeric: normal; font-variant-east-asian: normal; font-varia=
nt-position: normal; font-feature-settings: normal; font-optical-sizing: au=
to; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stro=
ke-color: rgb(0, 0, 0); min-height: 14px;"><span style=3D"font-kerning: non=
e;"></span><br></p><p style=3D"margin: 0px; font-width: normal; line-height=
: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternat=
es: normal; font-variant-ligatures: normal; font-variant-numeric: normal; f=
ont-variant-east-asian: normal; font-variant-position: normal; font-feature=
-settings: normal; font-optical-sizing: auto; font-variation-settings: norm=
al; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);"><span st=
yle=3D"font-kerning: none;">Packages for Debian, Ubuntu, Fedora, RHEL, and =
openSUSE are available in the various</span></p><p style=3D"margin: 0px; fo=
nt-width: normal; line-height: normal; font-size-adjust: none; font-kerning=
: auto; font-variant-alternates: normal; font-variant-ligatures: normal; fo=
nt-variant-numeric: normal; font-variant-east-asian: normal; font-variant-p=
osition: normal; font-feature-settings: normal; font-optical-sizing: auto; =
font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-c=
olor: rgb(0, 0, 0);"><span style=3D"font-kerning: none;">official Community=
 repositories:</span></p><p style=3D"margin: 0px; font-width: normal; line-=
height: normal; font-size-adjust: none; font-kerning: auto; font-variant-al=
ternates: normal; font-variant-ligatures: normal; font-variant-numeric: nor=
mal; font-variant-east-asian: normal; font-variant-position: normal; font-f=
eature-settings: normal; font-optical-sizing: auto; font-variation-settings=
: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0); min=
-height: 14px;"><span style=3D"font-kerning: none;"></span><br></p><p style=
=3D"margin: 0px; font-width: normal; line-height: normal; font-size-adjust:=
 none; font-kerning: auto; font-variant-alternates: normal; font-variant-li=
gatures: normal; font-variant-numeric: normal; font-variant-east-asian: nor=
mal; font-variant-position: normal; font-feature-settings: normal; font-opt=
ical-sizing: auto; font-variation-settings: normal; color: rgb(53, 134, 255=
); -webkit-text-stroke-color: rgb(53, 134, 255);"><span style=3D"font-kerni=
ng: none; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">&l=
t;<a href=3D"https://community.openvpn.net/Pages/OpenVPN%20software%20repos=
"><span style=3D"font-kerning: none; color: rgb(53, 134, 255); -webkit-text=
-stroke-color: rgb(53, 134, 255);">https://community.openvpn.net/Pages/Open=
VPN%20software%20repos</span></a>&gt;</span></p><p style=3D"margin: 0px; fo=
nt-width: normal; line-height: normal; font-size-adjust: none; font-kerning=
: auto; font-variant-alternates: normal; font-variant-ligatures: normal; fo=
nt-variant-numeric: normal; font-variant-east-asian: normal; font-variant-p=
osition: normal; font-feature-settings: normal; font-optical-sizing: auto; =
font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-c=
olor: rgb(0, 0, 0); min-height: 14px;"><span style=3D"font-kerning: none;">=
</span><br></p><p style=3D"margin: 0px; font-width: normal; line-height: no=
rmal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: =
normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-=
variant-east-asian: normal; font-variant-position: normal; font-feature-set=
tings: normal; font-optical-sizing: auto; font-variation-settings: normal; =
color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);"><span style=
=3D"font-kerning: none;">Kind regards,</span></p><p style=3D"margin: 0px; f=
ont-width: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-=
color: rgb(0, 0, 0);"><span style=3D"font-kerning: none;">Yuriy Darnobyt</s=
pan></p></body></html>=

--Apple-Mail=_CE0DDBA4-1D3C-4EE5-A7B2-FD7F9B665277--

