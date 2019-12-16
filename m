From: Simon Rozman <simon@...2293...>
Date: Mon, 16 Dec 2019 22:18:00 +0000
Message-ID: <162696E1-8F58-4B9A-A591-2622E3ADE746@...2293...>
References: <20191213191634.250-1-lstipakov@...277...>
 <20191213191901.300-1-lstipakov@...277...>
 <CAKuzo_jNn9NG-chJHx62H2CTiB64dCrq3S3_oW7oR8Tngf4F9w@...278...>
 <CAGyAFMVReSwJsYAKo5S4pV4POV31g0roxz4P2Ajvr+8hoEYbeA@...278...>
 <CAKuzo_hMws66xJsN69qa6WmgXNdrSKioHQrpE9VZ89-J2O7+KA@...278...>
In-Reply-To: <CAKuzo_hMws66xJsN69qa6WmgXNdrSKioHQrpE9VZ89-J2O7+KA@...278...>
Content-Language: en-US
Content-Type: multipart/signed;
 boundary="Apple-Mail=_84593F5D-BBAF-445D-9EB6-C9074471BE41";
 protocol="application/pkcs7-signature"; micalg=sha-256
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v6 4/7] wintun: ring buffers based I/O
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Lev Stipakov <lstipakov@...277...>, Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Apple-Mail=_84593F5D-BBAF-445D-9EB6-C9074471BE41
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_3BAE6E5C-7A63-428D-9F65-243AB25CE74C"

--Apple-Mail=_3BAE6E5C-7A63-428D-9F65-243AB25CE74C
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

>>> TLDR:
>>> (i) stealing SYSTEM access from winlogon.exe is not a good thing to do
>>=20
>>=20
>> This doesn't happen for the majority of use cases - only when iservice i=
s not used. We also
>> elevate only for the single DeviceIOControl call.
>=20
> I understand. But stealing access token from winlogon.exe is a hack and n=
ot
> something I would expect to see in a trustworthy executable. Diagnostic
> and forensic tools may be justified in doing such things.

Wintun has a hardcoded check to allow ring registration from the SYSTEM use=
r only.

To be honest: I am using a Windows 10 VPC in test mode with a modified Wint=
un driver installed that also allows ring registration for the members of A=
dministrators group. This allows me to quickly test ideas while reviewing/u=
pgrading Lev's work. I can run Visual Studio to compile openvpn.exe on my c=
omputer as an unprivileged user. Then have an elevated Remote Debugger runn=
ing on the VPC and Visual Studio to remotely run openvpn.exe with debugger =
attached with a single F5 click.

Having to use OpenVPN GUI and iservice, or running openvpn.exe as service w=
ould require a lot more clicks to replace the binary, attach debugger etc.

As far as I am concerned, this elevation hack may be removed from the OpenV=
PN source code in the final release. However, mind that this would prevent =
people from running openvpn.exe+Wintun from the command line.

>>> +bool
>>>=20
>>>> +impersonate_as_system()
>>>> +{
>>>=20
>>> This is implemented by stealing the access token from
>>> winlogon.exe. I don't think such tricks belong to OpenVPN.
>>> It may also trip some anti-virus software.
>>>=20
>>> That said, probably there are no "legitimate" ways of getting
>>> LOCAL SYSTEM rights on Windows without running a service.
>>>=20
>>> Why does wintun require SYSTEM for using it? If there is a
>>> good reason for that, we should not let every admin
>>> user bypass it.
>>=20
>>=20
>> I'll defer it to Simon.

Unfortunately, I don't do security decisions in Wintun.

Wintun was originally designed for WireGuard. WireGuard is architectured to=
 run all its tunnels as Windows services running as the SYSTEM user. Wintun=
's security is as tight as possible so the WireGuard can barely use it. I k=
now a guy who is tempted to introduce a userspace binary code signature che=
ck to the Wintun. :)

Given the relative ease to get SYSTEM token just by being an elevated proce=
ss =E2=80=94 mind there's also a hack to get from non-elevated to elevated =
completely bypassing the UAC prompt as long as you are a member of Administ=
rators =E2=80=94 this SYSTEM restriction really doesn't provide considerabl=
e additional security compared to being a member of Administrators group.

>>> Those who really need to test OpenVPN with wintun from
>>> command prompt can use diagnostic tools available to get
>>> a cmd prompt as system (e.g., psexec). That also  makes
>>> it explicit that SYSTEM privilege is required.
>>>=20
>>> In the longer run, we could provide a script to launch
>>> openvpn.exe using the interactive service. Modifying the
>>> automatic service to use interactive service for launching
>>> looks easy to do as well. Then, all privileged operations could
>>> be removed from openvpn core.
>>=20
>>=20
>> I think it is good not to break user experience and allow run openvpn as
>> an administrator without iservice using wintun at the expense on elevati=
on
>> to system for single API call.
>=20
> I have already said what I think of it. As an admin I wouldn't like to see
> users running processes that elevate to SYSTEM like this.

Selva, Windows is full of such hacks internally. :( This is no excuse for u=
s doing the same of course. Just saying Windows is far from ideal world.

I am running OpenVPN on Windows using NSSM wrapper for years. I had a brief=
 discussion on the Hackathon with Samuli about integrating SCM support dire=
ctly into openvpn.exe (imagine --daemon for Windows):

sc create OpenVPN$MyTunnel binpath=3D "C:\Program Files\OpenVPN\bin\openvpn=
" --daemon --config "C:\Program Files\OpenVPN\config\MyTunnel.ovpn" --log "=
C:\Program Files\OpenVPN\log\MyTunnel.log" start=3D auto depend=3D dhcp
sc start OpenVPN$MyTunnel

This would install openvpn.exe as a Windows service and run it as the SYSTE=
M user =E2=80=94 no need for iservice, no need for SYSTEM token hack. Other=
 than me, perhaps it could cover at least some of the users now running ope=
nvpn.exe directly.

Regards,
Simon=

--Apple-Mail=_3BAE6E5C-7A63-428D-9F65-243AB25CE74C
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dutf-8"></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: s=
pace; line-break: after-white-space;" class=3D"">Hi,<br class=3D""><div cla=
ss=3D"">
<div><br class=3D""></div></div><div><blockquote type=3D"cite" class=3D""><=
div class=3D""><blockquote type=3D"cite" style=3D"font-family: Menlo-Regula=
r; font-size: 14px; font-style: normal; font-variant-caps: normal; font-wei=
ght: normal; letter-spacing: normal; orphans: auto; text-align: start; text=
-indent: 0px; text-transform: none; white-space: normal; widows: auto; word=
-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0=
px; text-decoration: none;" class=3D""><blockquote type=3D"cite" class=3D""=
>TLDR:<br class=3D"">(i) stealing SYSTEM access from winlogon.exe is not a =
good thing to do<br class=3D""></blockquote><br class=3D""><br class=3D"">T=
his doesn't happen for the majority of use cases - only when iservice is no=
t used. We also<br class=3D"">elevate only for the single DeviceIOControl c=
all.<br class=3D""></blockquote><br style=3D"caret-color: rgb(0, 0, 0); fon=
t-family: Menlo-Regular; font-size: 14px; font-style: normal; font-variant-=
caps: normal; font-weight: normal; letter-spacing: normal; text-align: star=
t; text-indent: 0px; text-transform: none; white-space: normal; word-spacin=
g: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D"">=
<span style=3D"caret-color: rgb(0, 0, 0); font-family: Menlo-Regular; font-=
size: 14px; font-style: normal; font-variant-caps: normal; font-weight: nor=
mal; letter-spacing: normal; text-align: start; text-indent: 0px; text-tran=
sform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-wi=
dth: 0px; text-decoration: none; float: none; display: inline !important;" =
class=3D"">I understand. But stealing access token from winlogon.exe is a h=
ack and not</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Menl=
o-Regular; font-size: 14px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; text-indent=
: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -webki=
t-text-stroke-width: 0px; text-decoration: none;" class=3D""><span style=3D=
"caret-color: rgb(0, 0, 0); font-family: Menlo-Regular; font-size: 14px; fo=
nt-style: normal; font-variant-caps: normal; font-weight: normal; letter-sp=
acing: normal; text-align: start; text-indent: 0px; text-transform: none; w=
hite-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text=
-decoration: none; float: none; display: inline !important;" class=3D"">som=
ething I would expect to see in a trustworthy executable. Diagnostic</span>=
<br style=3D"caret-color: rgb(0, 0, 0); font-family: Menlo-Regular; font-si=
ze: 14px; font-style: normal; font-variant-caps: normal; font-weight: norma=
l; letter-spacing: normal; text-align: start; text-indent: 0px; text-transf=
orm: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-widt=
h: 0px; text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(=
0, 0, 0); font-family: Menlo-Regular; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; tex=
t-align: start; text-indent: 0px; text-transform: none; white-space: normal=
; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;=
 float: none; display: inline !important;" class=3D"">and forensic tools ma=
y be justified in doing such things.</span><br style=3D"caret-color: rgb(0,=
 0, 0); font-family: Menlo-Regular; font-size: 14px; font-style: normal; fo=
nt-variant-caps: normal; font-weight: normal; letter-spacing: normal; text-=
align: start; text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" =
class=3D""></div></blockquote><div><br class=3D""></div><div>Wintun has a h=
ardcoded check to allow ring registration from the SYSTEM user only.</div><=
div><br class=3D""></div><div>To be honest: I am using a Windows 10 VPC in =
test mode with a modified Wintun driver installed that also allows ring reg=
istration for the members of Administrators group. This allows me to quickl=
y test ideas&nbsp;<span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0=
, 0);" class=3D"">while reviewing/upgrading Lev's work. I can run Visual St=
udio to </span>compile openvpn.exe on my computer as an unprivileged user. =
Then have an elevated Remote Debugger running on the VPC and Visual Studio =
to&nbsp;<span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);" cla=
ss=3D"">remotely</span>&nbsp;run openvpn.exe with debugger attached with a =
single F5 click.</div><div><br class=3D""></div><div>Having to use OpenVPN =
GUI and iservice, or running openvpn.exe as service would require a lot mor=
e clicks to replace the binary, attach debugger etc.</div><div><br class=3D=
""></div><div><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0)=
;" class=3D"">As far as I am concerned, this elevation hack may be removed =
from the OpenVPN source code i</span><span style=3D"caret-color: rgb(0, 0, =
0); color: rgb(0, 0, 0);" class=3D"">n the final release. However, mind tha=
t&nbsp;</span><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0)=
;" class=3D"">this would prevent people from running openvpn.exe+Wintun fro=
m the command line.</span></div><div><br class=3D""></div><blockquote type=
=3D"cite" class=3D""><div class=3D""><blockquote type=3D"cite" style=3D"fon=
t-family: Menlo-Regular; font-size: 14px; font-style: normal; font-variant-=
caps: normal; font-weight: normal; letter-spacing: normal; orphans: auto; t=
ext-align: start; text-indent: 0px; text-transform: none; white-space: norm=
al; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; -webki=
t-text-stroke-width: 0px; text-decoration: none;" class=3D""><blockquote ty=
pe=3D"cite" class=3D"">+bool<br class=3D""><br class=3D""><blockquote type=
=3D"cite" class=3D"">+impersonate_as_system()<br class=3D"">+{<br class=3D"=
"></blockquote><br class=3D"">This is implemented by stealing the access to=
ken from<br class=3D"">winlogon.exe. I don't think such tricks belong to Op=
enVPN.<br class=3D"">It may also trip some anti-virus software.<br class=3D=
""><br class=3D"">That said, probably there are no "legitimate" ways of get=
ting<br class=3D"">LOCAL SYSTEM rights on Windows without running a service=
.<br class=3D""><br class=3D"">Why does wintun require SYSTEM for using it?=
 If there is a<br class=3D"">good reason for that, we should not let every =
admin<br class=3D"">user bypass it.<br class=3D""></blockquote><br class=3D=
""><br class=3D"">I'll defer it to Simon.<br class=3D""></blockquote></div>=
</blockquote><div><br class=3D""></div><div><span style=3D"caret-color: rgb=
(0, 0, 0); color: rgb(0, 0, 0);" class=3D"">Unfortunately, I don't do secur=
ity decisions in Wintun.</span></div><div><span style=3D"caret-color: rgb(0=
, 0, 0); color: rgb(0, 0, 0);" class=3D""><br class=3D""></span></div><div>=
Wintun was originally designed for WireGuard. WireGuard is architectured to=
 run all its tunnels as Windows services running as the SYSTEM user. Wintun=
's security is as tight as possible so the WireGuard can barely use it. I k=
now a guy who is tempted to introduce a&nbsp;<span style=3D"caret-color: rg=
b(0, 0, 0); color: rgb(0, 0, 0);" class=3D"">userspace binary</span>&nbsp;c=
ode signature check to the Wintun. :)</div><div><br class=3D""></div><div>G=
iven the relative ease to get SYSTEM token just by being an elevated proces=
s =E2=80=94 mind there's also a hack to&nbsp;<font color=3D"#000000" class=
=3D""><span style=3D"caret-color: rgb(0, 0, 0);" class=3D"">get from&nbsp;n=
on-elevated to elevated completely </span></font>bypassing the UAC prompt a=
s long as you are a member of Administrators&nbsp;<span style=3D"caret-colo=
r: rgb(0, 0, 0); color: rgb(0, 0, 0);" class=3D"">=E2=80=94</span>&nbsp;thi=
s SYSTEM restriction really doesn't provide considerable additional securit=
y compared to being a member of Administrators group.</div><div><br class=
=3D""></div><blockquote type=3D"cite" class=3D""><div class=3D""><blockquot=
e type=3D"cite" style=3D"font-family: Menlo-Regular; font-size: 14px; font-=
style: normal; font-variant-caps: normal; font-weight: normal; letter-spaci=
ng: normal; orphans: auto; text-align: start; text-indent: 0px; text-transf=
orm: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-te=
xt-size-adjust: auto; -webkit-text-stroke-width: 0px; text-decoration: none=
;" class=3D""><blockquote type=3D"cite" class=3D"">Those who really need to=
 test OpenVPN with wintun from<br class=3D"">command prompt can use diagnos=
tic tools available to get<br class=3D"">a cmd prompt as system (e.g., psex=
ec). That also &nbsp;makes<br class=3D"">it explicit that SYSTEM privilege =
is required.<br class=3D""><br class=3D"">In the longer run, we could provi=
de a script to launch<br class=3D"">openvpn.exe using the interactive servi=
ce. Modifying the<br class=3D"">automatic service to use interactive servic=
e for launching<br class=3D"">looks easy to do as well. Then, all privilege=
d operations could<br class=3D"">be removed from openvpn core.<br class=3D"=
"></blockquote><br class=3D""><br class=3D"">I think it is good not to brea=
k user experience and allow run openvpn as<br class=3D"">an administrator w=
ithout iservice using wintun at the expense on elevation<br class=3D"">to s=
ystem for single API call.<br class=3D""></blockquote><br style=3D"caret-co=
lor: rgb(0, 0, 0); font-family: Menlo-Regular; font-size: 14px; font-style:=
 normal; font-variant-caps: normal; font-weight: normal; letter-spacing: no=
rmal; text-align: start; text-indent: 0px; text-transform: none; white-spac=
e: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decorati=
on: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family=
: Menlo-Regular; font-size: 14px; font-style: normal; font-variant-caps: no=
rmal; font-weight: normal; letter-spacing: normal; text-align: start; text-=
indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; display=
: inline !important;" class=3D"">I have already said what I think of it. As=
 an admin I wouldn't like to see</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Menlo-Regular; font-size: 14px; font-style: normal; font-v=
ariant-caps: normal; font-weight: normal; letter-spacing: normal; text-alig=
n: start; text-indent: 0px; text-transform: none; white-space: normal; word=
-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" clas=
s=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Menlo-Regular=
; font-size: 14px; font-style: normal; font-variant-caps: normal; font-weig=
ht: normal; letter-spacing: normal; text-align: start; text-indent: 0px; te=
xt-transform: none; white-space: normal; word-spacing: 0px; -webkit-text-st=
roke-width: 0px; text-decoration: none; float: none; display: inline !impor=
tant;" class=3D"">users running processes that elevate to SYSTEM like this.=
</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Menlo-Regular; =
font-size: 14px; font-style: normal; font-variant-caps: normal; font-weight=
: normal; letter-spacing: normal; text-align: start; text-indent: 0px; text=
-transform: none; white-space: normal; word-spacing: 0px; -webkit-text-stro=
ke-width: 0px; text-decoration: none;" class=3D""></div></blockquote><div><=
br class=3D""></div><div>Selva, Windows is full of such hacks internally. :=
( This is no excuse for us doing the same of course. Just saying Windows is=
 far from ideal world.</div><div><br class=3D""></div><div>I am running Ope=
nVPN on Windows using NSSM wrapper for years. I had a brief discussion on t=
he Hackathon with Samuli about integrating SCM support directly into openvp=
n.exe (imagine --daemon for Windows):</div><div><br class=3D""></div><div>s=
c create OpenVPN$MyTunnel binpath=3D "C:\Program Files\OpenVPN\bin\openvpn"=
 --daemon --config "<span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0,=
 0, 0);" class=3D"">C:\Program Files\OpenVPN\config\</span>MyTunnel.ovpn" -=
-log "<span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);" class=
=3D"">C:\Program Files\OpenVPN</span>\log\MyTunnel.log"&nbsp;start=3D&nbsp;=
auto&nbsp;depend=3D dhcp</div><div>sc start&nbsp;<span style=3D"caret-color=
: rgb(0, 0, 0); color: rgb(0, 0, 0);" class=3D"">OpenVPN$MyTunnel</span></d=
iv><div><br class=3D""></div><div>This would install openvpn.exe as a Windo=
ws service and run it as the SYSTEM user&nbsp;<span style=3D"caret-color: r=
gb(0, 0, 0); color: rgb(0, 0, 0);" class=3D"">=E2=80=94</span>&nbsp;no need=
 for iservice, no need for SYSTEM token hack. Other than me, perhaps it cou=
ld cover at least some of the users now running openvpn.exe directly.</div>=
<div><br class=3D""></div><div>Regards,</div><div>Simon</div></div></body><=
/html>=

--Apple-Mail=_3BAE6E5C-7A63-428D-9F65-243AB25CE74C--

--Apple-Mail=_84593F5D-BBAF-445D-9EB6-C9074471BE41
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

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

--Apple-Mail=_84593F5D-BBAF-445D-9EB6-C9074471BE41--

