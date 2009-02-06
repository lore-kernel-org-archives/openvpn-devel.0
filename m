Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C987F6.87F08A1F"
Date: Thu, 5 Feb 2009 17:03:01 -0800
Message-ID: <39A060190A2C9C40BA31D79BC186E0586F6947@...1195...>
From: "Roman Vasilyev" <roman@...1194...>
Subject: [Openvpn-devel] Openvpn Traffic handling
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C987F6.87F08A1F
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C987F6.87F08A1F"

------_=_NextPart_002_01C987F6.87F08A1F
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

=20

I'm an Anchorfree employee who is adding new functionality to the HSS
servers. One of my responsibilities is Intrusion Detection.

The best performance for IDS seems to come from embedding Snort into
OpenVPN. In order to achieve this,  I have modified OpenVPN  to provide
packet handling.

Also we need to have our internal statistics on management interface.

=20

My question for you is: would it be  possible to integrate my changes
into the main OpenVPN branch ?

=20

Please find all this functionality attached in patch file.

=20

Regards


------_=_NextPart_002_01C987F6.87F08A1F
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>I&#8217;m an Anchorfree employee who is adding new
functionality to the HSS servers. One of my responsibilities is Intrusion
Detection.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>The best performance for IDS seems to come from embedding
Snort into OpenVPN. In order to achieve this,&nbsp; I have modified OpenVPN
&nbsp;to provide packet handling.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Also we need to have our internal statistics on manageme=
nt
interface.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>My question for you is: would it be&nbsp; possible to
integrate my changes into the main OpenVPN branch ?<o:p></o:p></span></font=
></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Please find all this functionality attached in patch fil=
e.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Regards<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_002_01C987F6.87F08A1F--

------_=_NextPart_001_01C987F6.87F08A1F
Content-Type: application/octet-stream;
	name="traffic-handling.patch"
Content-Transfer-Encoding: base64
Content-Description: traffic-handling.patch
Content-Disposition: attachment;
	filename="traffic-handling.patch"

ZGlmZiAtcnUgb3BlbnZwbi5vcmlnL2ZvcndhcmQuYyBvcGVudnBuLm5ldy9mb3J3YXJkLmMKLS0t
IG9wZW52cG4ub3JpZy9mb3J3YXJkLmMJMjAwOC0xMS0xNyAxNzowMzozNi4wMDAwMDAwMDAgLTA4
MDAKKysrIG9wZW52cG4ubmV3L2ZvcndhcmQuYwkyMDA4LTExLTE0IDEzOjU3OjA3LjAwMDAwMDAw
MCAtMDgwMApAQCAtOTQzLDYgKzk0Myw4IEBACiAgICAgICAgKiB1cyB0byBleGFtaW5lIHRoZSBJ
UHY0IGhlYWRlci4KICAgICAgICAqLwogICAgICAgcHJvY2Vzc19pcHY0X2hlYWRlciAoYywgUElQ
VjRfUEFTU1RPU3xQSVBWNF9NU1NGSVgsICZjLT5jMi5idWYpOworICAgICAgaWYgKHBsdWdpbl9s
aXN0X2hhbmRsZV9pcF9pbihjLT5wbHVnaW5zLCBCUFRSKCZjLT5jMi5idWYpLCBCTEVOKCZjLT5j
Mi5idWYpKT09MCkKKyAgICAgIHsKIAogI2lmZGVmIFBBQ0tFVF9UUlVOQ0FUSU9OX0NIRUNLCiAg
ICAgICAvKiBpZiAoYy0+YzIuYnVmLmxlbiA+IDEpIC0tYy0+YzIuYnVmLmxlbjsgKi8KQEAgLTk1
NCw2ICs5NTYsNyBAQAogI2VuZGlmCiAKICAgICAgIGVuY3J5cHRfc2lnbiAoYywgdHJ1ZSk7Cisg
ICAgICB9CiAgICAgfQogICBlbHNlCiAgICAgewpAQCAtMTE0Nyw2ICsxMTUwLDkgQEAKICAgICov
CiAgIHByb2Nlc3NfaXB2NF9oZWFkZXIgKGMsIFBJUFY0X01TU0ZJWHxQSVBWNF9PVVRHT0lORywg
JmMtPmMyLnRvX3R1bik7CiAKKyAgaWYgKHBsdWdpbl9saXN0X2hhbmRsZV9pcF9vdXQoYy0+cGx1
Z2lucywgQlBUUigmYy0+YzIudG9fdHVuKSwgQkxFTigmYy0+YzIudG9fdHVuKSk9PTApCisgIHsK
KwogICBpZiAoYy0+YzIudG9fdHVuLmxlbiA8PSBNQVhfUldfU0laRV9UVU4gKCZjLT5jMi5mcmFt
ZSkpCiAgICAgewogICAgICAgLyoKQEAgLTEyMDMsNiArMTIwOSw3IEBACiAJICAgYy0+YzIudG9f
dHVuLmxlbiwKIAkgICBNQVhfUldfU0laRV9UVU4gKCZjLT5jMi5mcmFtZSkpOwogICAgIH0KKyAg
fQogCiAgIGJ1Zl9yZXNldCAoJmMtPmMyLnRvX3R1bik7CiAKZGlmZiAtcnUgb3BlbnZwbi5vcmln
L2luaXQuYyBvcGVudnBuLm5ldy9pbml0LmMKLS0tIG9wZW52cG4ub3JpZy9pbml0LmMJMjAwOC0x
MS0xNyAxNzowMzozNi4wMDAwMDAwMDAgLTA4MDAKKysrIG9wZW52cG4ubmV3L2luaXQuYwkyMDA4
LTExLTE0IDE0OjMyOjM2LjAwMDAwMDAwMCAtMDgwMApAQCAtMjQ0Nyw3ICsyNDQ3LDcgQEAKIGlu
aXRfbWFuYWdlbWVudCAoc3RydWN0IGNvbnRleHQgKmMpCiB7CiAgIGlmICghbWFuYWdlbWVudCkK
LSAgICBtYW5hZ2VtZW50ID0gbWFuYWdlbWVudF9pbml0ICgpOworICAgIG1hbmFnZW1lbnQgPSBt
YW5hZ2VtZW50X2luaXQgKGMpOwogfQogCiBib29sCmRpZmYgLXJ1IG9wZW52cG4ub3JpZy9tYW5h
Z2UuYyBvcGVudnBuLm5ldy9tYW5hZ2UuYwotLS0gb3BlbnZwbi5vcmlnL21hbmFnZS5jCTIwMDgt
MTEtMTcgMTc6MDM6MzYuMDAwMDAwMDAwIC0wODAwCisrKyBvcGVudnBuLm5ldy9tYW5hZ2UuYwky
MDA4LTExLTE0IDE1OjIxOjA1LjAwMDAwMDAwMCAtMDgwMApAQCAtMzIsNiArMzIsNyBAQAogCiAj
aWZkZWYgRU5BQkxFX01BTkFHRU1FTlQKIAorI2luY2x1ZGUgIm9wZW52cG4uaCIKICNpbmNsdWRl
ICJlcnJvci5oIgogI2luY2x1ZGUgImZkbWlzYy5oIgogI2luY2x1ZGUgIm9wdGlvbnMuaCIKQEAg
LTY3MSw3ICs2NzIsMTIgQEAKICAgc3RydWN0IGdjX2FyZW5hIGdjID0gZ2NfbmV3ICgpOwogCiAg
IEFTU0VSVCAocFswXSk7Ci0gIGlmIChzdHJlcSAocFswXSwgImV4aXQiKSB8fCBzdHJlcSAocFsw
XSwgInF1aXQiKSkKKyAgaWYgKHN0cmVxIChwWzBdLCAiYWZzdGF0IikpCisgICAgeworICAgICAg
cGx1Z2luX2xpc3Rfc3RhdChtYW4tPmN0eHQtPnBsdWdpbnMsIHAsIHhfbXNnKTsKKyAgICAgIGdv
dG8gZG9uZTsKKyAgICB9CisgIGVsc2UgaWYgKHN0cmVxIChwWzBdLCAiZXhpdCIpIHx8IHN0cmVx
IChwWzBdLCAicXVpdCIpKQogICAgIHsKICAgICAgIG1hbi0+Y29ubmVjdGlvbi5oYWx0ID0gdHJ1
ZTsKICAgICAgIGdvdG8gZG9uZTsKQEAgLTE0NTcsNyArMTQ2Myw3IEBACiB9CiAKIHN0cnVjdCBt
YW5hZ2VtZW50ICoKLW1hbmFnZW1lbnRfaW5pdCAodm9pZCkKK21hbmFnZW1lbnRfaW5pdCAoc3Ry
dWN0IGNvbnRleHQgKmMpCiB7CiAgIHN0cnVjdCBtYW5hZ2VtZW50ICptYW47CiAgIEFMTE9DX09C
Sl9DTEVBUiAobWFuLCBzdHJ1Y3QgbWFuYWdlbWVudCk7CkBAIC0xNDY4LDYgKzE0NzQsNyBAQAog
CQkgICAgTUFOQUdFTUVOVF9TVEFURV9CVUZGRVJfU0laRSk7CiAKICAgbWFuX2Nvbm5lY3Rpb25f
Y2xlYXIgKCZtYW4tPmNvbm5lY3Rpb24pOworICBtYW4tPmN0eHQ9YzsKIAogICByZXR1cm4gbWFu
OwogfQpkaWZmIC1ydSBvcGVudnBuLm9yaWcvbWFuYWdlLmggb3BlbnZwbi5uZXcvbWFuYWdlLmgK
LS0tIG9wZW52cG4ub3JpZy9tYW5hZ2UuaAkyMDA4LTExLTE3IDE3OjAzOjM2LjAwMDAwMDAwMCAt
MDgwMAorKysgb3BlbnZwbi5uZXcvbWFuYWdlLmgJMjAwOC0xMS0xNCAxNDozNToyOC4wMDAwMDAw
MDAgLTA4MDAKQEAgLTI2MywxMyArMjYzLDE0IEBACiAgIHN0cnVjdCBtYW5fcGVyc2lzdCBwZXJz
aXN0OwogICBzdHJ1Y3QgbWFuX3NldHRpbmdzIHNldHRpbmdzOwogICBzdHJ1Y3QgbWFuX2Nvbm5l
Y3Rpb24gY29ubmVjdGlvbjsKKyAgc3RydWN0IGNvbnRleHQgKmN0eHQ7CiB9OwogCiBleHRlcm4g
c3RydWN0IG1hbmFnZW1lbnQgKm1hbmFnZW1lbnQ7CiAKIHN0cnVjdCB1c2VyX3Bhc3M7CiAKLXN0
cnVjdCBtYW5hZ2VtZW50ICptYW5hZ2VtZW50X2luaXQgKHZvaWQpOworc3RydWN0IG1hbmFnZW1l
bnQgKm1hbmFnZW1lbnRfaW5pdCAoc3RydWN0IGNvbnRleHQgKmMpOwogCiBib29sIG1hbmFnZW1l
bnRfb3BlbiAoc3RydWN0IG1hbmFnZW1lbnQgKm1hbiwKIAkJICAgICAgY29uc3QgY2hhciAqYWRk
ciwKZGlmZiAtcnUgb3BlbnZwbi5vcmlnL29wZW52cG4tcGx1Z2luLmggb3BlbnZwbi5uZXcvb3Bl
bnZwbi1wbHVnaW4uaAotLS0gb3BlbnZwbi5vcmlnL29wZW52cG4tcGx1Z2luLmgJMjAwOC0xMS0x
NyAxNzowMzozNi4wMDAwMDAwMDAgLTA4MDAKKysrIG9wZW52cG4ubmV3L29wZW52cG4tcGx1Z2lu
LmgJMjAwOC0xMS0xNCAxNToxNzo1MS4wMDAwMDAwMDAgLTA4MDAKQEAgLTM0MSwzICszNDEsMTEg
QEAKIAogT1BFTlZQTl9QTFVHSU5fREVGIGludCBPUEVOVlBOX1BMVUdJTl9GVU5DKG9wZW52cG5f
cGx1Z2luX2Z1bmNfdjEpCiAgICAgIChvcGVudnBuX3BsdWdpbl9oYW5kbGVfdCBoYW5kbGUsIGNv
bnN0IGludCB0eXBlLCBjb25zdCBjaGFyICphcmd2W10sIGNvbnN0IGNoYXIgKmVudnBbXSk7CisK
K09QRU5WUE5fUExVR0lOX0RFRiBpbnQgT1BFTlZQTl9QTFVHSU5fRlVOQyhvcGVudnBuX3BsdWdp
bl9pcF9oYW5kbGVyKQorICAgICAob3BlbnZwbl9wbHVnaW5faGFuZGxlX3QgaGFuZGxlLCB1aW50
OF90ICpkYXRhLCBzaXplX3Qgc2l6ZSwgdm9pZCAqYXR0cik7CisKK3R5cGVkZWYgdm9pZCAoKm91
dF9mdW5jKSAoY29uc3QgdW5zaWduZWQgaW50IGZsYWdzLCBjb25zdCBjaGFyICpmb3JtYXQsIC4u
Lik7CisKK09QRU5WUE5fUExVR0lOX0RFRiBpbnQgT1BFTlZQTl9QTFVHSU5fRlVOQyhvcGVudnBu
X3BsdWdpbl9zdGF0KQorICAgICAob3BlbnZwbl9wbHVnaW5faGFuZGxlX3QgaGFuZGxlLCBjb25z
dCBjaGFyICphcmd2W10sIG91dF9mdW5jIGZ1bmMpOwpkaWZmIC1ydSBvcGVudnBuLm9yaWcvcGx1
Z2luLmMgb3BlbnZwbi5uZXcvcGx1Z2luLmMKLS0tIG9wZW52cG4ub3JpZy9wbHVnaW4uYwkyMDA4
LTExLTE3IDE3OjAzOjM2LjAwMDAwMDAwMCAtMDgwMAorKysgb3BlbnZwbi5uZXcvcGx1Z2luLmMJ
MjAwOC0xMS0xNCAxNToxOTowOS4wMDAwMDAwMDAgLTA4MDAKQEAgLTIxMyw2ICsyMTMsOSBAQAog
ICBQTFVHSU5fU1lNIChmdW5jMiwgIm9wZW52cG5fcGx1Z2luX2Z1bmNfdjIiLCAwKTsKICAgUExV
R0lOX1NZTSAoY2xvc2UsICJvcGVudnBuX3BsdWdpbl9jbG9zZV92MSIsIFBMVUdJTl9TWU1CT0xf
UkVRVUlSRUQpOwogICBQTFVHSU5fU1lNIChhYm9ydCwgIm9wZW52cG5fcGx1Z2luX2Fib3J0X3Yx
IiwgMCk7CisgIFBMVUdJTl9TWU0gKGhhbmRsX2luLCAib3BlbnZwbl9wbHVnaW5faXBfaGFuZGxl
cl9pbiIsIDApOworICBQTFVHSU5fU1lNIChoYW5kbF9vdXQsICJvcGVudnBuX3BsdWdpbl9pcF9o
YW5kbGVyX291dCIsIDApOworICBQTFVHSU5fU1lNIChzdGF0LCAib3BlbnZwbl9wbHVnaW5fc3Rh
dCIsIDApOwogICBQTFVHSU5fU1lNIChjbGllbnRfY29uc3RydWN0b3IsICJvcGVudnBuX3BsdWdp
bl9jbGllbnRfY29uc3RydWN0b3JfdjEiLCAwKTsKICAgUExVR0lOX1NZTSAoY2xpZW50X2Rlc3Ry
dWN0b3IsICJvcGVudnBuX3BsdWdpbl9jbGllbnRfZGVzdHJ1Y3Rvcl92MSIsIDApOwogICBQTFVH
SU5fU1lNIChtaW5fdmVyc2lvbl9yZXF1aXJlZCwgIm9wZW52cG5fcGx1Z2luX21pbl92ZXJzaW9u
X3JlcXVpcmVkX3YxIiwgMCk7CkBAIC01MTMsNiArNTE2LDc1IEBACiB9CiAKIGludAorcGx1Z2lu
X2xpc3Rfc3RhdCAoc3RydWN0IHBsdWdpbl9saXN0ICpwbCwgY29uc3QgY2hhciAqYXJndltdLCBv
dXRfZnVuYyBmdW5jKQoreworICBpZiAocGwpCisgIHsKKyAgICBpZiAocGwtPmNvbW1vbikKKyAg
ICB7CisgICAgICBzdHJ1Y3QgcGx1Z2luX2NvbW1vbiAqcGMgPSBwbC0+Y29tbW9uOworICAgICAg
aW50IGk7CisgICAgICAKKyAgICAgIGZvciAoaSA9IDA7IGkgPCBwYy0+bjsgKytpKQorICAgICAg
eworICAgICAgCWNvbnN0IHN0cnVjdCBwbHVnaW4gKnA9JnBjLT5wbHVnaW5zW2ldOworICAgICAg
CWlmIChwLT5zdGF0KQorICAgICAgCSAgKCpwLT5zdGF0KShwLT5wbHVnaW5faGFuZGxlLCBhcmd2
LCBmdW5jKTsKKyAgICAgIH0KKyAgICB9CisgICAgCisgIH0KKyAgcmV0dXJuIDA7Cit9CisKK2lu
dAorcGx1Z2luX2xpc3RfaGFuZGxlX2lwX2luIChzdHJ1Y3QgcGx1Z2luX2xpc3QgKnBsLCB1aW50
OF90ICpkYXRhLCBzaXplX3Qgc2l6ZSkKK3sKKyAgaWYgKHBsKQorICB7CisgICAgaWYgKHBsLT5j
b21tb24pCisgICAgeworICAgICAgc3RydWN0IHBsdWdpbl9jb21tb24gKnBjID0gcGwtPmNvbW1v
bjsKKyAgICAgIGludCBpOworICAgICAgCisgICAgICBmb3IgKGkgPSAwOyBpIDwgcGMtPm47ICsr
aSkKKyAgICAgIHsKKyAgICAgIAljb25zdCBzdHJ1Y3QgcGx1Z2luICpwPSZwYy0+cGx1Z2luc1tp
XTsKKyAgICAgIAlpZiAocC0+aGFuZGxfaW4pCisgICAgICAJICBpZiAoKCpwLT5oYW5kbF9pbiko
cC0+cGx1Z2luX2hhbmRsZSwgZGF0YSwgc2l6ZSwgcGwtPnBlcl9jbGllbnQucGVyX2NsaWVudF9j
b250ZXh0W2ldKSE9MCkKKyAgICAgIAkgICAgcmV0dXJuIC0xOworICAgICAgfQorICAgIH0KKyAg
ICAKKyAgfQorICByZXR1cm4gMDsKK30KKworaW50CitwbHVnaW5fbGlzdF9oYW5kbGVfaXBfb3V0
IChzdHJ1Y3QgcGx1Z2luX2xpc3QgKnBsLCB1aW50OF90ICpkYXRhLCBzaXplX3Qgc2l6ZSkKK3sK
KyAgaWYgKHBsKQorICB7CisgICAgaWYgKHBsLT5jb21tb24pCisgICAgeworICAgICAgc3RydWN0
IHBsdWdpbl9jb21tb24gKnBjID0gcGwtPmNvbW1vbjsKKyAgICAgIGludCBpOworICAgICAgCisg
ICAgICBmb3IgKGkgPSAwOyBpIDwgcGMtPm47ICsraSkKKyAgICAgIHsKKyAgICAgIAljb25zdCBz
dHJ1Y3QgcGx1Z2luICpwPSZwYy0+cGx1Z2luc1tpXTsKKyAgICAgIAlpZiAocC0+aGFuZGxfb3V0
KQorICAgICAgCSAgaWYgKCgqcC0+aGFuZGxfb3V0KShwLT5wbHVnaW5faGFuZGxlLCBkYXRhLCBz
aXplLCBwbC0+cGVyX2NsaWVudC5wZXJfY2xpZW50X2NvbnRleHRbaV0pIT0wKQorICAgICAgCSAg
ICByZXR1cm4gLTE7CisgICAgICB9CisgICAgfQorICAgIAorICB9CisgIHJldHVybiAwOworfQor
CisKK2ludAogcGx1Z2luX2NhbGwgKGNvbnN0IHN0cnVjdCBwbHVnaW5fbGlzdCAqcGwsCiAJICAg
ICBjb25zdCBpbnQgdHlwZSwKIAkgICAgIGNvbnN0IGNoYXIgKmFyZ3MsCmRpZmYgLXJ1IG9wZW52
cG4ub3JpZy9wbHVnaW4uaCBvcGVudnBuLm5ldy9wbHVnaW4uaAotLS0gb3BlbnZwbi5vcmlnL3Bs
dWdpbi5oCTIwMDgtMTEtMTcgMTc6MDM6MzYuMDAwMDAwMDAwIC0wODAwCisrKyBvcGVudnBuLm5l
dy9wbHVnaW4uaAkyMDA4LTExLTE0IDE1OjE4OjE3LjAwMDAwMDAwMCAtMDgwMApAQCAtNjksNiAr
NjksOSBAQAogICBvcGVudnBuX3BsdWdpbl9jbGllbnRfZGVzdHJ1Y3Rvcl92MSBjbGllbnRfZGVz
dHJ1Y3RvcjsKICAgb3BlbnZwbl9wbHVnaW5fbWluX3ZlcnNpb25fcmVxdWlyZWRfdjEgbWluX3Zl
cnNpb25fcmVxdWlyZWQ7CiAgIG9wZW52cG5fcGx1Z2luX3NlbGVjdF9pbml0aWFsaXphdGlvbl9w
b2ludF92MSBpbml0aWFsaXphdGlvbl9wb2ludDsKKyAgb3BlbnZwbl9wbHVnaW5faXBfaGFuZGxl
ciBoYW5kbF9pbjsKKyAgb3BlbnZwbl9wbHVnaW5faXBfaGFuZGxlciBoYW5kbF9vdXQ7CisgIG9w
ZW52cG5fcGx1Z2luX3N0YXQgc3RhdDsKIAogICBvcGVudnBuX3BsdWdpbl9oYW5kbGVfdCBwbHVn
aW5faGFuZGxlOwogfTsKQEAgLTk3LDYgKzEwMCwxMCBAQAogICBzdHJ1Y3Qgb3BlbnZwbl9wbHVn
aW5fc3RyaW5nX2xpc3QgKmxpc3RbTUFYX1BMVUdJTlNdOwogfTsKIAoraW50IHBsdWdpbl9saXN0
X2hhbmRsZV9pcF9pbiAoc3RydWN0IHBsdWdpbl9saXN0ICpwbCwgdWludDhfdCAqZGF0YSwgc2l6
ZV90IHNpemUpOworaW50IHBsdWdpbl9saXN0X2hhbmRsZV9pcF9vdXQgKHN0cnVjdCBwbHVnaW5f
bGlzdCAqcGwsIHVpbnQ4X3QgKmRhdGEsIHNpemVfdCBzaXplKTsKK2ludCBwbHVnaW5fbGlzdF9z
dGF0KHN0cnVjdCBwbHVnaW5fbGlzdCAqcGwsIGNvbnN0IGNoYXIqIGFyZ3ZbXSwgb3V0X2Z1bmMp
OworCiBzdHJ1Y3QgcGx1Z2luX29wdGlvbl9saXN0ICpwbHVnaW5fb3B0aW9uX2xpc3RfbmV3IChz
dHJ1Y3QgZ2NfYXJlbmEgKmdjKTsKIGJvb2wgcGx1Z2luX29wdGlvbl9saXN0X2FkZCAoc3RydWN0
IHBsdWdpbl9vcHRpb25fbGlzdCAqbGlzdCwgY2hhciAqKnAsIHN0cnVjdCBnY19hcmVuYSAqZ2Mp
OwogCg==

------_=_NextPart_001_01C987F6.87F08A1F--

