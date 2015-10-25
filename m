Date: Sun, 25 Oct 2015 18:40:35 +0000 (UTC)
From: Jeffrey Cutter <jeff_m_cutter@...109...>
Message-ID: <935402641.3344982.1445798435869.JavaMail.yahoo@...2084...>
In-Reply-To: <20151025183324.GI22054@...1296...>
References: <20151025183324.GI22054@...1296...>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3344981_1942767370.1445798435868"
Subject: [Openvpn-devel] [PATCH] Update contrib/pull-resolv-conf/client.up
	for no DOMAIN
Reply-To: Jeffrey Cutter <jeff_m_cutter@...109...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

------=_Part_3344981_1942767370.1445798435868
Content-Type: multipart/alternative; 
	boundary="----=_Part_3344980_633604963.1445798435865"

------=_Part_3344980_633604963.1445798435865
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Author: Jeffrey Cutter <jeff_m_cutter@...109...>

Update contrib/pull-resolv-conf/client.up for no DOMAIN

When no DOMAIN is received from push/pull, do not add either domain or search to the resolv.conf.
Fix typo in comment resolv.con[f].
Only add new line when using domain or search.

Signed-off-by: Jeffrey Cutter <jeff_m_cutter@...109...>
 
------=_Part_3344980_633604963.1445798435865
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"color:#000; background-color:#fff; f=
ont-family:HelveticaNeue-Light, Helvetica Neue Light, Helvetica Neue, Helve=
tica, Arial, Lucida Grande, sans-serif;font-size:16px"><div id=3D"yiv723751=
6434yui_3_16_0_1_1445789144280_16646" class=3D"">Author: Jeffrey Cutter &lt=
;jeff_m_cutter@...109...&gt;<br clear=3D"none" id=3D"yui_3_16_0_1_144578914=
4280_20429" class=3D""></div><div id=3D"yiv7237516434yui_3_16_0_1_144578914=
4280_16658" class=3D""><div id=3D"yiv7237516434yui_3_16_0_1_1445789144280_1=
6657" style=3D"font-family: HelveticaNeue, 'Helvetica Neue', Helvetica, Ari=
al, 'Lucida Grande', sans-serif;" class=3D""><div class=3D"" id=3D"yiv72375=
16434yui_3_16_0_1_1445789144280_16672"><div id=3D"yiv7237516434" class=3D""=
><div id=3D"yiv7237516434yui_3_16_0_1_1445789144280_16671" style=3D"font-fa=
mily: HelveticaNeue-Light, 'Helvetica Neue Light', 'Helvetica Neue', Helvet=
ica, Arial, 'Lucida Grande', sans-serif;" class=3D""><div id=3D"yiv72375164=
34yui_3_16_0_1_1443622177058_34127" class=3D""><br clear=3D"none" id=3D"yui=
_3_16_0_1_1445789144280_20437" class=3D""></div><div dir=3D"ltr" id=3D"yiv7=
237516434yui_3_16_0_1_1443622177058_34127" class=3D""><span class=3D"" id=
=3D"yiv7237516434yui_3_16_0_1_1443622177058_35346" style=3D"font-family: He=
lveticaNeue, 'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-seri=
f; font-size: 13.3333px;">Update contrib/pull-resolv-conf/client.up for no =
DOMAIN</span><br clear=3D"none" class=3D"" id=3D"yiv7237516434yui_3_16_0_1_=
1443622177058_35348" style=3D"font-family: HelveticaNeue, 'Helvetica Neue',=
 Helvetica, Arial, 'Lucida Grande', sans-serif; font-size: 13.3333px;"><br =
clear=3D"none" class=3D"" id=3D"yiv7237516434yui_3_16_0_1_1443622177058_353=
50" style=3D"font-family: HelveticaNeue, 'Helvetica Neue', Helvetica, Arial=
, 'Lucida Grande', sans-serif; font-size: 13.3333px;"><span class=3D"" id=
=3D"yiv7237516434yui_3_16_0_1_1443622177058_35352" style=3D"font-family: He=
lveticaNeue, 'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-seri=
f; font-size: 13.3333px;">When no DOMAIN is received from push/pull, do not=
 add either domain or search to the resolv.conf.</span><br clear=3D"none" c=
lass=3D"" id=3D"yiv7237516434yui_3_16_0_1_1443622177058_35354" style=3D"fon=
t-family: HelveticaNeue, 'Helvetica Neue', Helvetica, Arial, 'Lucida Grande=
', sans-serif; font-size: 13.3333px;"><span class=3D"" id=3D"yiv7237516434y=
ui_3_16_0_1_1443622177058_35356" style=3D"font-family: HelveticaNeue, 'Helv=
etica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif; font-size: 13.3=
333px;">Fix typo in comment resolv.con[f].</span><br clear=3D"none" class=
=3D"" id=3D"yiv7237516434yui_3_16_0_1_1443622177058_35358" style=3D"font-fa=
mily: HelveticaNeue, 'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', s=
ans-serif; font-size: 13.3333px;"><span class=3D"" id=3D"yiv7237516434yui_3=
_16_0_1_1443622177058_35360" style=3D"font-family: HelveticaNeue, 'Helvetic=
a Neue', Helvetica, Arial, 'Lucida Grande', sans-serif; font-size: 13.3333p=
x;">Only add new line when using domain or search.</span><br clear=3D"none"=
 id=3D"yui_3_16_0_1_1445789144280_20448" class=3D""></div><div dir=3D"ltr" =
id=3D"yiv7237516434yui_3_16_0_1_1443622177058_34127" class=3D""><span class=
=3D"" style=3D"font-family: HelveticaNeue, 'Helvetica Neue', Helvetica, Ari=
al, 'Lucida Grande', sans-serif; font-size: 13.3333px;" id=3D"yui_3_16_0_1_=
1445789144280_20451"><br clear=3D"none" id=3D"yui_3_16_0_1_1445789144280_20=
453" class=3D""></span></div><div dir=3D"ltr" id=3D"yiv7237516434yui_3_16_0=
_1_1443622177058_34127" class=3D""><span class=3D"" id=3D"yiv7237516434yui_=
3_16_0_1_1443622177058_35399" style=3D"font-family: HelveticaNeue, 'Helveti=
ca Neue', Helvetica, Arial, 'Lucida Grande', sans-serif; font-size: 13.3333=
px;">Signed-off-by: Jeffrey Cutter &lt;jeff_m_cutter@...109...&gt;</span></=
div><div dir=3D"ltr" id=3D"yui_3_16_0_1_1445789144280_20457" class=3D""><sp=
an class=3D"" style=3D"font-family: HelveticaNeue, 'Helvetica Neue', Helvet=
ica, Arial, 'Lucida Grande', sans-serif; font-size: 13.3333px;" id=3D"yui_3=
_16_0_1_1445789144280_20459"><br id=3D"yui_3_16_0_1_1445789144280_20461" cl=
ass=3D""></span></div></div></div></div></div></div>  </div></body></html>=

------=_Part_3344980_633604963.1445798435865--

------=_Part_3344981_1942767370.1445798435868
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; 
	filename=0001-Update-contrib-pull-resolv-conf-client.up-for-no-DOM.patch
Content-ID: <cc50ed6a-37c1-fc3f-ac68-ca15c2747d70@...109...>

RnJvbSAxMTk5YThmNmQ2NTQ1ZWIzZDlmYTlkNGY2YWM3MmY2OTJhNWI3MzVhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKZWZmcmV5IEN1dHRlciA8amVmZl9tX2N1dHRlckB5YWhvby5j
b20+CkRhdGU6IFNhdCwgMTIgU2VwIDIwMTUgMjA6MDM6MTggLTA0MDAKU3ViamVjdDogW1BBVENI
XSBVcGRhdGUgY29udHJpYi9wdWxsLXJlc29sdi1jb25mL2NsaWVudC51cCBmb3Igbm8gRE9NQUlO
IFdoZW4KIG5vIERPTUFJTiBpcyByZWNlaXZlZCBmcm9tIHB1c2gvcHVsbCwgZG8gbm90IGFkZCBl
aXRoZXIgZG9tYWluIG9yIHNlYXJjaCB0bwogdGhlIHJlc29sdi5jb25mLiBGaXggdHlwbyBpbiBj
b21tZW50IHJlc29sdi5jb25bZl0uIE9ubHkgYWRkIG5ldyBsaW5lIHdoZW4KIHVzaW5nIGRvbWFp
biBvciBzZWFyY2guCgotLS0KIGNvbnRyaWIvcHVsbC1yZXNvbHYtY29uZi9jbGllbnQudXAgfCAx
MyArKysrKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA1IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2NvbnRyaWIvcHVsbC1yZXNvbHYtY29uZi9jbGllbnQudXAg
Yi9jb250cmliL3B1bGwtcmVzb2x2LWNvbmYvY2xpZW50LnVwCmluZGV4IGIyOGQ0ZDEuLjg4NThi
NDcgMTAwNjQ0Ci0tLSBhL2NvbnRyaWIvcHVsbC1yZXNvbHYtY29uZi9jbGllbnQudXAKKysrIGIv
Y29udHJpYi9wdWxsLXJlc29sdi1jb25mL2NsaWVudC51cApAQCAtNTAsOSArNTAsMTAgQEAgbmw9
JwogIyBvcgogIyAiZGhjcC1vcHRpb24gRE5TIDEwLjEwLjEwLjEwIiAobXVsdGlwbGUgYWxsb3dl
ZCkKIAotIyBlYWNoIEROUyBvcHRpb24gYmVjb21lcyBhICJuYW1lc2VydmVyIiBvcHRpb24gaW4g
cmVzb2x2LmNvbgorIyBlYWNoIEROUyBvcHRpb24gYmVjb21lcyBhICJuYW1lc2VydmVyIiBvcHRp
b24gaW4gcmVzb2x2LmNvbmYKICMgaWYgd2UgZ2V0IG9uZSBET01BSU4sIHRoYXQgYmVjb21lcyAi
ZG9tYWluIiBpbiByZXNvbHYuY29uZgogIyBpZiB3ZSBnZXQgbXVsdGlwbGUgRE9NQUlOUywgdGhv
c2UgYmVjb21lICJzZWFyY2giIGxpbmVzIGluIHJlc29sdi5jb25mCisjIGlmIHdlIGdldCBubyBE
T01BSU5TLCB0aGVuIGRvbid0IHVzZSBlaXRoZXIgZG9tYWluIG9yIHNlYXJjaC4KIAogd2hpbGUg
dHJ1ZTsgZG8KICAgZXZhbCBmb3B0PVwkZm9yZWlnbl9vcHRpb25fJHtpfQpAQCAtNzgsMTMgKzc5
LDE1IEBAIHdoaWxlIHRydWU7IGRvCiAgIGk9JCgoaSArIDEpKQogZG9uZQogCi1kcz1kb21haW4K
LWlmIFsgJG5kb21zIC1ndCAxIF07IHRoZW4KLSAgZHM9c2VhcmNoCitkcz0iIgoraWYgWyAkbmRv
bXMgLWVxIDEgXTsgdGhlbgorICBkcz0iJHtubH1kb21haW4iCitlbGlmIFsgJG5kb21zIC1ndCAx
IF07IHRoZW4KKyAgZHM9IiR7bmx9c2VhcmNoIgogZmkKIAogIyBUaGlzIGlzIHRoZSBjb21wbGV0
ZSBmaWxlIC0gIiRkb21haW5zIiBoYXMgYSBsZWFkaW5nIHNwYWNlIGFscmVhZHkKLW91dD0iIyBy
ZXNvbHYuY29uZiBhdXRvZ2VuZXJhdGVkIGJ5ICR7MH0gKCR7MX0pJHtubH0ke2Ruc30ke25sfSR7
ZHN9JHtkb21haW5zfSIKK291dD0iIyByZXNvbHYuY29uZiBhdXRvZ2VuZXJhdGVkIGJ5ICR7MH0g
KCR7MX0pJHtubH0ke2Ruc30ke2RzfSR7ZG9tYWluc30iCiAKICMgdXNlIHJlc29sdmNvbmYgaWYg
aXQncyBhdmFpbGFibGUKIGlmIHR5cGUgcmVzb2x2Y29uZiA+L2Rldi9udWxsIDI+JjE7IHRoZW4K
LS0gCjIuNC4zCgo=

------=_Part_3344981_1942767370.1445798435868--

