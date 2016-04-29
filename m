From: Jens Neuhalfen <openvpn-devel@...2127...>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_EB352927-416A-4538-BA5A-63ADFB98979C"
Message-Id: <6A66E826-C5AA-461C-A961-EA535BF5BC0C@...2127...>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Date: Fri, 29 Apr 2016 10:36:05 +0200
References: <69E74833-0AD6-4FC4-A17F-FCD19BD0256A@...2127...>
In-Reply-To: <69E74833-0AD6-4FC4-A17F-FCD19BD0256A@...2127...>
Subject: Re: [Openvpn-devel] Request for comment: Adding unit tests to
	openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <Openvpn-devel@lists.sourceforge.net>

--Apple-Mail=_EB352927-416A-4538-BA5A-63ADFB98979C
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi everybody,

in order to keep my local master branch clean, I put the code into a dedica=
ted branch (and also did some polishing).

Unfortunately, github won=E2=80=99t allow me to change this in the pull req=
uest.

Without further ado, please have a look at the revised pull request: https:=
//github.com/OpenVPN/openvpn/pull/44 <https://github.com/OpenVPN/openvpn/pu=
ll/44>

As always: I=E2=80=99ll send the patches to the list, after I got some comm=
ents (or per request).=20

Cheers
Jens


> On 27 Apr 2016, at 20:55, Jens Neuhalfen <openvpn-devel@...2127...> wrote:
>=20
> Hi,
>=20
> I put together a set of patches that add unit testing support for openvpn=
. To make comments easier I put them together as pull request on github.
>=20
> Please review the patch and point out points of improvement. After that I=
 will post the =E2=80=9Creal=E2=80=9D patches to the list.
>=20
> https://github.com/OpenVPN/openvpn/pull/43 <https://github.com/OpenVPN/op=
envpn/pull/43>
>=20
> This set of patches adds unit test support to openvpn. The test framework=
 used is cmocka <https://cmocka.org/>
> cmocka source is added as submodule in vendor because a package depenency=
 is not feasible (e.g. not available on all platforms)
> cmocka is automatically build during make check.
> the patchset contains tests for searchandreplace as an example
> Tested on MacOS & Ubuntu Trusty
>=20
> CAVE:
>=20
> cmocka needs cmake to be installed
>=20
>=20
> Cheers=20
> Jens
> -------------------------------------------------------------------------=
-----
> Find and fix application performance issues faster with Applications Mana=
ger
> Applications Manager provides deep performance insights into multiple tie=
rs of
> your business applications. It resolves application problems quickly and
> reduces your MTTR. Get your free trial!
> https://ad.doubleclick.net/ddm/clk/302982198;130105516;z_________________=
______________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--Apple-Mail=_EB352927-416A-4538-BA5A-63ADFB98979C
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html charset=
=3Dutf-8"></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: s=
pace; -webkit-line-break: after-white-space;" class=3D"">Hi everybody,<div =
class=3D""><br class=3D""></div><div class=3D"">in order to keep my local m=
aster branch clean, I put the code into a dedicated branch (and also did so=
me polishing).</div><div class=3D""><br class=3D""></div><div class=3D"">Un=
fortunately, github won=E2=80=99t allow me to change this in the pull reque=
st.</div><div class=3D""><br class=3D""></div><div class=3D"">Without furth=
er ado, please have a look at the revised pull request:&nbsp;<a href=3D"htt=
ps://github.com/OpenVPN/openvpn/pull/44" class=3D"">https://github.com/Open=
VPN/openvpn/pull/44</a></div><div class=3D""><br class=3D""></div><div clas=
s=3D"">As always: I=E2=80=99ll send the patches to the list, after I got so=
me comments (or per request).&nbsp;</div><div class=3D""><br class=3D""></d=
iv><div class=3D"">Cheers</div><div class=3D"">Jens</div><div class=3D""><b=
r class=3D""></div><div class=3D""><br class=3D""><div><blockquote type=3D"=
cite" class=3D""><div class=3D"">On 27 Apr 2016, at 20:55, Jens Neuhalfen &=
lt;<a href=3D"mailto:openvpn-devel@...2127..." class=3D"">openvpn-devel@...493...=
2127...</a>&gt; wrote:</div><br class=3D"Apple-interchange-newline"><div cl=
ass=3D""><meta http-equiv=3D"Content-Type" content=3D"text/html charset=3Du=
tf-8" class=3D""><div style=3D"word-wrap: break-word; -webkit-nbsp-mode: sp=
ace; -webkit-line-break: after-white-space;" class=3D""><div class=3D"">Hi,=
</div><div class=3D""><br class=3D""></div><div class=3D"">I put together a=
 set of patches that add unit testing support for openvpn. To make comments=
 easier I put them together as pull request on github.</div><div class=3D""=
><br class=3D""></div><div class=3D"">Please review the patch and point out=
 points of improvement. After that I will post the =E2=80=9Creal=E2=80=9D p=
atches to the list.</div><div class=3D""><br class=3D""></div><div class=3D=
""><a href=3D"https://github.com/OpenVPN/openvpn/pull/43" class=3D"">https:=
//github.com/OpenVPN/openvpn/pull/43</a></div><div class=3D""><br class=3D"=
"></div><div class=3D""><p style=3D"box-sizing: border-box; margin-bottom: =
16px; color: rgb(51, 51, 51); font-family: 'Helvetica Neue', Helvetica, 'Se=
goe UI', Arial, freesans, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji'=
, 'Segoe UI Symbol'; font-size: 14px; font-variant-ligatures: normal; font-=
variant-position: normal; font-variant-numeric: normal; font-variant-altern=
ates: normal; font-variant-east-asian: normal; line-height: 22.4px; widows:=
 1; background-color: rgb(255, 255, 255); margin-top: 0px !important;" clas=
s=3D"">This set of patches adds unit test support to openvpn. The test fram=
ework used is&nbsp;<a href=3D"https://cmocka.org/" style=3D"box-sizing: bor=
der-box; color: rgb(64, 120, 192); text-decoration: none; background-color:=
 transparent;" class=3D"">cmocka</a></p><ul style=3D"box-sizing: border-box=
; padding-left: 2em; margin-top: 0px; margin-bottom: 16px; color: rgb(51, 5=
1, 51); font-family: 'Helvetica Neue', Helvetica, 'Segoe UI', Arial, freesa=
ns, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol'; f=
ont-size: 14px; font-variant-ligatures: normal; font-variant-position: norm=
al; font-variant-numeric: normal; font-variant-alternates: normal; font-var=
iant-east-asian: normal; line-height: 22.4px; widows: 1; background-color: =
rgb(255, 255, 255);" class=3D""><li style=3D"box-sizing: border-box;" class=
=3D"">cmocka source is added as submodule in&nbsp;<code style=3D"box-sizing=
: border-box; font-family: Consolas, 'Liberation Mono', Menlo, Courier, mon=
ospace; font-size: 11.9px; padding: 0.2em 0px; margin: 0px; border-radius: =
3px; background-color: rgba(0, 0, 0, 0.0392157);" class=3D"">vendor</code>&=
nbsp;because a package depenency is not feasible (e.g. not available on all=
 platforms)</li><li style=3D"box-sizing: border-box;" class=3D"">cmocka is =
automatically build during&nbsp;<code style=3D"box-sizing: border-box; font=
-family: Consolas, 'Liberation Mono', Menlo, Courier, monospace; font-size:=
 11.9px; padding: 0.2em 0px; margin: 0px; border-radius: 3px; background-co=
lor: rgba(0, 0, 0, 0.0392157);" class=3D"">make check</code>.</li><li style=
=3D"box-sizing: border-box;" class=3D"">the patchset contains tests for&nbs=
p;<code style=3D"box-sizing: border-box; font-family: Consolas, 'Liberation=
 Mono', Menlo, Courier, monospace; font-size: 11.9px; padding: 0.2em 0px; m=
argin: 0px; border-radius: 3px; background-color: rgba(0, 0, 0, 0.0392157);=
" class=3D"">searchandreplace</code>&nbsp;as an example</li></ul><p style=
=3D"box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; color: rg=
b(51, 51, 51); font-family: 'Helvetica Neue', Helvetica, 'Segoe UI', Arial,=
 freesans, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Sym=
bol'; font-size: 14px; font-variant-ligatures: normal; font-variant-positio=
n: normal; font-variant-numeric: normal; font-variant-alternates: normal; f=
ont-variant-east-asian: normal; line-height: 22.4px; widows: 1; background-=
color: rgb(255, 255, 255);" class=3D"">Tested on MacOS &amp; Ubuntu Trusty<=
/p><p style=3D"box-sizing: border-box; margin-top: 0px; margin-bottom: 16px=
; color: rgb(51, 51, 51); font-family: 'Helvetica Neue', Helvetica, 'Segoe =
UI', Arial, freesans, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'S=
egoe UI Symbol'; font-size: 14px; font-variant-ligatures: normal; font-vari=
ant-position: normal; font-variant-numeric: normal; font-variant-alternates=
: normal; font-variant-east-asian: normal; line-height: 22.4px; widows: 1; =
background-color: rgb(255, 255, 255);" class=3D"">CAVE:</p><ul style=3D"box=
-sizing: border-box; padding-left: 2em; margin-top: 0px; color: rgb(51, 51,=
 51); font-family: 'Helvetica Neue', Helvetica, 'Segoe UI', Arial, freesans=
, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol'; fon=
t-size: 14px; font-variant-ligatures: normal; font-variant-position: normal=
; font-variant-numeric: normal; font-variant-alternates: normal; font-varia=
nt-east-asian: normal; line-height: 22.4px; widows: 1; background-color: rg=
b(255, 255, 255); margin-bottom: 0px !important;" class=3D""><li style=3D"b=
ox-sizing: border-box;" class=3D"">cmocka needs cmake to be installed</li><=
/ul><div class=3D""><br class=3D""></div></div><div class=3D""><br class=3D=
""></div>Cheers&nbsp;<div class=3D"">Jens</div></div>----------------------=
--------------------------------------------------------<br class=3D"">Find=
 and fix application performance issues faster with Applications Manager<br=
 class=3D"">Applications Manager provides deep performance insights into mu=
ltiple tiers of<br class=3D"">your business applications. It resolves appli=
cation problems quickly and<br class=3D"">reduces your MTTR. Get your free =
trial!<br class=3D""><a href=3D"https://ad.doubleclick.net/ddm/clk/30298219=
8;130105516;z_______________________________________________" class=3D"">ht=
tps://ad.doubleclick.net/ddm/clk/302982198;130105516;z_____________________=
__________________________</a><br class=3D"">Openvpn-devel mailing list<br =
class=3D"">Openvpn-devel@lists.sourceforge.net<br class=3D"">https://lists.=
sourceforge.net/lists/listinfo/openvpn-devel<br class=3D""></div></blockquo=
te></div><br class=3D""></div></body></html>=

--Apple-Mail=_EB352927-416A-4538-BA5A-63ADFB98979C--

