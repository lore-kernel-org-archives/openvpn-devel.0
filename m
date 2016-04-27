From: Jens Neuhalfen <openvpn-devel@...2127...>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_C1801A75-3241-4EED-9652-F6A411278975"
Message-Id: <69E74833-0AD6-4FC4-A17F-FCD19BD0256A@...2127...>
Date: Wed, 27 Apr 2016 20:55:35 +0200
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: [Openvpn-devel] Request for comment: Adding unit tests to openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <Openvpn-devel@lists.sourceforge.net>

--Apple-Mail=_C1801A75-3241-4EED-9652-F6A411278975
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I put together a set of patches that add unit testing support for openvpn. =
To make comments easier I put them together as pull request on github.

Please review the patch and point out points of improvement. After that I w=
ill post the =E2=80=9Creal=E2=80=9D patches to the list.

https://github.com/OpenVPN/openvpn/pull/43 <https://github.com/OpenVPN/open=
vpn/pull/43>

This set of patches adds unit test support to openvpn. The test framework u=
sed is cmocka <https://cmocka.org/>
cmocka source is added as submodule in vendor because a package depenency i=
s not feasible (e.g. not available on all platforms)
cmocka is automatically build during make check.
the patchset contains tests for searchandreplace as an example
Tested on MacOS & Ubuntu Trusty

CAVE:

cmocka needs cmake to be installed


Cheers=20
Jens=

--Apple-Mail=_C1801A75-3241-4EED-9652-F6A411278975
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html charset=
=3Dutf-8"></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: s=
pace; -webkit-line-break: after-white-space;" class=3D""><div class=3D"">Hi=
,</div><div class=3D""><br class=3D""></div><div class=3D"">I put together =
a set of patches that add unit testing support for openvpn. To make comment=
s easier I put them together as pull request on github.</div><div class=3D"=
"><br class=3D""></div><div class=3D"">Please review the patch and point ou=
t points of improvement. After that I will post the =E2=80=9Creal=E2=80=9D =
patches to the list.</div><div class=3D""><br class=3D""></div><div class=
=3D""><a href=3D"https://github.com/OpenVPN/openvpn/pull/43" class=3D"">htt=
ps://github.com/OpenVPN/openvpn/pull/43</a></div><div class=3D""><br class=
=3D""></div><div class=3D""><p style=3D"box-sizing: border-box; margin-bott=
om: 16px; color: rgb(51, 51, 51); font-family: 'Helvetica Neue', Helvetica,=
 'Segoe UI', Arial, freesans, sans-serif, 'Apple Color Emoji', 'Segoe UI Em=
oji', 'Segoe UI Symbol'; font-size: 14px; font-variant-ligatures: normal; f=
ont-variant-position: normal; font-variant-numeric: normal; font-variant-al=
ternates: normal; font-variant-east-asian: normal; line-height: 22.4px; wid=
ows: 1; background-color: rgb(255, 255, 255); margin-top: 0px !important;" =
class=3D"">This set of patches adds unit test support to openvpn. The test =
framework used is&nbsp;<a href=3D"https://cmocka.org/" style=3D"box-sizing:=
 border-box; color: rgb(64, 120, 192); text-decoration: none; background-co=
lor: transparent;" class=3D"">cmocka</a></p><ul style=3D"box-sizing: border=
-box; padding-left: 2em; margin-top: 0px; margin-bottom: 16px; color: rgb(5=
1, 51, 51); font-family: 'Helvetica Neue', Helvetica, 'Segoe UI', Arial, fr=
eesans, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol=
'; font-size: 14px; font-variant-ligatures: normal; font-variant-position: =
normal; font-variant-numeric: normal; font-variant-alternates: normal; font=
-variant-east-asian: normal; line-height: 22.4px; widows: 1; background-col=
or: rgb(255, 255, 255);" class=3D""><li style=3D"box-sizing: border-box;" c=
lass=3D"">cmocka source is added as submodule in&nbsp;<code style=3D"box-si=
zing: border-box; font-family: Consolas, 'Liberation Mono', Menlo, Courier,=
 monospace; font-size: 11.9px; padding: 0.2em 0px; margin: 0px; border-radi=
us: 3px; background-color: rgba(0, 0, 0, 0.0392157);" class=3D"">vendor</co=
de>&nbsp;because a package depenency is not feasible (e.g. not available on=
 all platforms)</li><li style=3D"box-sizing: border-box;" class=3D"">cmocka=
 is automatically build during&nbsp;<code style=3D"box-sizing: border-box; =
font-family: Consolas, 'Liberation Mono', Menlo, Courier, monospace; font-s=
ize: 11.9px; padding: 0.2em 0px; margin: 0px; border-radius: 3px; backgroun=
d-color: rgba(0, 0, 0, 0.0392157);" class=3D"">make check</code>.</li><li s=
tyle=3D"box-sizing: border-box;" class=3D"">the patchset contains tests for=
&nbsp;<code style=3D"box-sizing: border-box; font-family: Consolas, 'Libera=
tion Mono', Menlo, Courier, monospace; font-size: 11.9px; padding: 0.2em 0p=
x; margin: 0px; border-radius: 3px; background-color: rgba(0, 0, 0, 0.03921=
57);" class=3D"">searchandreplace</code>&nbsp;as an example</li></ul><p sty=
le=3D"box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; color: =
rgb(51, 51, 51); font-family: 'Helvetica Neue', Helvetica, 'Segoe UI', Aria=
l, freesans, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI S=
ymbol'; font-size: 14px; font-variant-ligatures: normal; font-variant-posit=
ion: normal; font-variant-numeric: normal; font-variant-alternates: normal;=
 font-variant-east-asian: normal; line-height: 22.4px; widows: 1; backgroun=
d-color: rgb(255, 255, 255);" class=3D"">Tested on MacOS &amp; Ubuntu Trust=
y</p><p style=3D"box-sizing: border-box; margin-top: 0px; margin-bottom: 16=
px; color: rgb(51, 51, 51); font-family: 'Helvetica Neue', Helvetica, 'Sego=
e UI', Arial, freesans, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', =
'Segoe UI Symbol'; font-size: 14px; font-variant-ligatures: normal; font-va=
riant-position: normal; font-variant-numeric: normal; font-variant-alternat=
es: normal; font-variant-east-asian: normal; line-height: 22.4px; widows: 1=
; background-color: rgb(255, 255, 255);" class=3D"">CAVE:</p><ul style=3D"b=
ox-sizing: border-box; padding-left: 2em; margin-top: 0px; color: rgb(51, 5=
1, 51); font-family: 'Helvetica Neue', Helvetica, 'Segoe UI', Arial, freesa=
ns, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol'; f=
ont-size: 14px; font-variant-ligatures: normal; font-variant-position: norm=
al; font-variant-numeric: normal; font-variant-alternates: normal; font-var=
iant-east-asian: normal; line-height: 22.4px; widows: 1; background-color: =
rgb(255, 255, 255); margin-bottom: 0px !important;" class=3D""><li style=3D=
"box-sizing: border-box;" class=3D"">cmocka needs cmake to be installed</li=
></ul><div class=3D""><br class=3D""></div></div><div class=3D""><br class=
=3D""></div>Cheers&nbsp;<div class=3D"">Jens</div></body></html>=

--Apple-Mail=_C1801A75-3241-4EED-9652-F6A411278975--

