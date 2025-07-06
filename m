From: Klemens Nanni <klemens@...2010...>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_EEF6A6A4-0BB2-4431-A0FC-B2BF2CACD818"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Date: Sun, 6 Jul 2025 03:51:04 +0300
References: <5738dcfa-3fbc-484c-9e32-d125368d6433 () rfc2549 ! org>
In-Reply-To: <5738dcfa-3fbc-484c-9e32-d125368d6433 () rfc2549 ! org>
Message-Id: <77ADE51C-80F1-4568-941A-207C31685B1C@...2010...>
Subject: Re: [Openvpn-devel] [SPAM] [PATCH 1/1] Accept "issuer" in
 `x509-username-field` for the peer certifi
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Openvpn-devel@lists.sourceforge.net

--Apple-Mail=_EEF6A6A4-0BB2-4431-A0FC-B2BF2CACD818
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


> 8 =D0=BC=D0=B0=D1=8F 2025=E2=80=AF=D0=B3., =D0=B2 14:46, Arne Schwabe <ar=
ne rfc2549 ! org> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0):
>=20
> Am 21.04.25 um 23:44 schrieb Klemens Nanni:
>> This allows for accepting clients based on their certificate authority:
>> 	x509-username-field issuer CN
>> 	verify-x509-name    ...CA=3DExampleCA_ match-prefix
>>=20
>> `tls-verify` or `plugin` can do the equivalent, but require additional c=
ode
>> execution and always incur overhead or may not be an option when running=
 with
>> reduced privileges, e.g. `chroot`
>=20
> I am trying to understand the use case for this patch. Issuer is only=20
> something you can trust and verify if you verified the fingerprint of=20
> the certificate or that the certificate is issued by a given CA. But if=20
> it is already verified to belong to a trusted CA, then you don't need=20
> issuer CN anymore.

=E2=80=94ca contains the root CA and the intermediate CA issuing client cer=
tificates
for use as VPN use.

Under the same root CA, another intermediate CA exists not intended for VPN.

The problem is OpenVPN successfully validates both certificate chains whilst
only one intermediate CA should allow peers to connect.

AFAIU, this is expected OpenSSL behaviour, at least when OpenVPN peers
send not only their own, but also their issuer CA=E2=80=99s certificate via=
 =E2=80=94cert.

Having said that, =E2=80=94remote-cert-ku might be a viable alternative, bu=
t that
requires the X509v3 extension and respective key usage bits set up front;
(I have not tried that approach.)

Thus reusing the customisable username mechanism allows for limiting to
certain CAs, i.e. rejecting undesired peers, early during handshake.

> I would also be good to try to add a unit test. Since is is probably a=20
> quite exotic use case, this will not be tested regularly and as such is=20
> in danger to be become broken and since this an auth related option that=
=20
> might then be an authentication bypass. We really want to avoid that.

If the patch still makes sense to you and seems worth pursuing, I=E2=80=99l=
l happily
work on tests next.=

--Apple-Mail=_EEF6A6A4-0BB2-4431-A0FC-B2BF2CACD818
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=
=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; -webkit-nbsp-mod=
e: space; line-break: after-white-space;"><br><div><blockquote type=3D"cite=
"><div>8 =D0=BC=D0=B0=D1=8F 2025=E2=80=AF=D0=B3., =D0=B2 14:46, Arne Schwab=
e &lt;arne rfc2549 ! org&gt; =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=
=B0):</div><br class=3D"Apple-interchange-newline"><div><meta charset=3D"UT=
F-8"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font=
-size: 12px; font-style: normal; font-variant-caps: normal; font-weight: 40=
0; letter-spacing: normal; text-align: start; text-indent: 0px; text-transf=
orm: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-widt=
h: 0px; text-decoration: none; float: none; display: inline !important;">Am=
 21.04.25 um 23:44 schrieb Klemens Nanni:</span><br style=3D"caret-color: r=
gb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; f=
ont-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-al=
ign: start; text-indent: 0px; text-transform: none; white-space: normal; wo=
rd-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;"><b=
lockquote type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px; f=
ont-style: normal; font-variant-caps: normal; font-weight: 400; letter-spac=
ing: normal; orphans: auto; text-align: start; text-indent: 0px; text-trans=
form: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-t=
ext-stroke-width: 0px; text-decoration: none;">This allows for accepting cl=
ients based on their certificate authority:<br><span class=3D"Apple-tab-spa=
n" style=3D"white-space: pre;">	</span>x509-username-field issuer CN<br><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>verify-x509=
-name &nbsp;&nbsp;&nbsp;...CA=3DExampleCA_ match-prefix<br><br>`tls-verify`=
 or `plugin` can do the equivalent, but require additional code<br>executio=
n and always incur overhead or may not be an option when running with<br>re=
duced privileges, e.g. `chroot`<br></blockquote><br style=3D"caret-color: r=
gb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; f=
ont-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-al=
ign: start; text-indent: 0px; text-transform: none; white-space: normal; wo=
rd-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;"><s=
pan style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; lett=
er-spacing: normal; text-align: start; text-indent: 0px; text-transform: no=
ne; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;=
 text-decoration: none; float: none; display: inline !important;">I am tryi=
ng to understand the use case for this patch. Issuer is only<span class=3D"=
Apple-converted-space">&nbsp;</span></span><br style=3D"caret-color: rgb(0,=
 0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; font-v=
ariant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; word-sp=
acing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;"><span s=
tyle=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px;=
 font-style: normal; font-variant-caps: normal; font-weight: 400; letter-sp=
acing: normal; text-align: start; text-indent: 0px; text-transform: none; w=
hite-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text=
-decoration: none; float: none; display: inline !important;">something you =
can trust and verify if you verified the fingerprint of<span class=3D"Apple=
-converted-space">&nbsp;</span></span><br style=3D"caret-color: rgb(0, 0, 0=
); font-family: Helvetica; font-size: 12px; font-style: normal; font-varian=
t-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start=
; text-indent: 0px; text-transform: none; white-space: normal; word-spacing=
: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;"><span style=
=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; fon=
t-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacin=
g: normal; text-align: start; text-indent: 0px; text-transform: none; white=
-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-dec=
oration: none; float: none; display: inline !important;">the certificate or=
 that the certificate is issued by a given CA. But if<span class=3D"Apple-c=
onverted-space">&nbsp;</span></span><br style=3D"caret-color: rgb(0, 0, 0);=
 font-family: Helvetica; font-size: 12px; font-style: normal; font-variant-=
caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; word-spacing: =
0px; -webkit-text-stroke-width: 0px; text-decoration: none;"><span style=3D=
"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-s=
tyle: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; white-sp=
ace: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decora=
tion: none; float: none; display: inline !important;">it is already verifie=
d to belong to a trusted CA, then you don't need<span class=3D"Apple-conver=
ted-space">&nbsp;</span></span><br style=3D"caret-color: rgb(0, 0, 0); font=
-family: Helvetica; font-size: 12px; font-style: normal; font-variant-caps:=
 normal; font-weight: 400; letter-spacing: normal; text-align: start; text-=
indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span style=3D"care=
t-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style:=
 normal; font-variant-caps: normal; font-weight: 400; letter-spacing: norma=
l; text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration:=
 none; float: none; display: inline !important;">issuer CN anymore.</span><=
/div></blockquote><div><br></div><div>=E2=80=94ca contains the root CA and =
the intermediate CA issuing client certificates</div><div>for use as VPN us=
e.</div></div><div><br></div><div>Under the same root CA, another intermedi=
ate CA exists not intended for VPN.</div><div><br></div><div>The problem is=
 OpenVPN successfully validates both certificate chains whilst</div><div>on=
ly one intermediate CA should allow peers to connect.</div><div><br></div><=
div>AFAIU, this is expected OpenSSL behaviour, at least when OpenVPN peers<=
/div><div>send not only their own, but also their issuer CA=E2=80=99s certi=
ficate via =E2=80=94cert.</div><div><br></div><div><div style=3D"caret-colo=
r: rgb(0, 0, 0); color: rgb(0, 0, 0);">Having said that, =E2=80=94remote-ce=
rt-ku might be a viable alternative, but that</div><div style=3D"caret-colo=
r: rgb(0, 0, 0); color: rgb(0, 0, 0);">requires the X509v3 extension and re=
spective key usage bits set up front;</div><div style=3D"caret-color: rgb(0=
, 0, 0); color: rgb(0, 0, 0);">(I have not tried that approach.)</div><div>=
<br></div></div><div>Thus reusing the customisable username mechanism allow=
s for limiting to</div><div>certain CAs, i.e. rejecting undesired peers, ea=
rly during handshake.</div><div><br></div><div><blockquote type=3D"cite"><d=
iv><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-s=
ize: 12px; font-style: normal; font-variant-caps: normal; font-weight: 400;=
 letter-spacing: normal; text-align: start; text-indent: 0px; text-transfor=
m: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width:=
 0px; text-decoration: none; float: none; display: inline !important;">I wo=
uld also be good to try to add a unit test. Since is is probably a<span cla=
ss=3D"Apple-converted-space">&nbsp;</span></span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-a=
lign: start; text-indent: 0px; text-transform: none; white-space: normal; w=
ord-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;"><=
span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:=
 12px; font-style: normal; font-variant-caps: normal; font-weight: 400; let=
ter-spacing: normal; text-align: start; text-indent: 0px; text-transform: n=
one; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px=
; text-decoration: none; float: none; display: inline !important;">quite ex=
otic use case, this will not be tested regularly and as such is<span class=
=3D"Apple-converted-space">&nbsp;</span></span><br style=3D"caret-color: rg=
b(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; fo=
nt-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-ali=
gn: start; text-indent: 0px; text-transform: none; white-space: normal; wor=
d-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;"><sp=
an style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 1=
2px; font-style: normal; font-variant-caps: normal; font-weight: 400; lette=
r-spacing: normal; text-align: start; text-indent: 0px; text-transform: non=
e; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">in danger =
to be become broken and since this an auth related option that<span class=
=3D"Apple-converted-space">&nbsp;</span></span><br style=3D"caret-color: rg=
b(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; fo=
nt-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-ali=
gn: start; text-indent: 0px; text-transform: none; white-space: normal; wor=
d-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;"><sp=
an style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 1=
2px; font-style: normal; font-variant-caps: normal; font-weight: 400; lette=
r-spacing: normal; text-align: start; text-indent: 0px; text-transform: non=
e; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">might then=
 be an authentication bypass. We really want to avoid that.</span><br style=
=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; fon=
t-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacin=
g: normal; text-align: start; text-indent: 0px; text-transform: none; white=
-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-dec=
oration: none;"></div></blockquote><div><br></div>If the patch still makes =
sense to you and seems worth pursuing, I=E2=80=99ll happily</div><div>work =
on tests next.</div></body></html>=

--Apple-Mail=_EEF6A6A4-0BB2-4431-A0FC-B2BF2CACD818--

