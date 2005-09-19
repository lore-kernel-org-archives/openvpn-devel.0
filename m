From: Mathias Sundman <mathias@...454...>
Message-ID: <Pine.LNX.4.61.0509192121340.24683@...210...>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; boundary="230776145-1904907378-1127158075=:24683"
Content-ID: <Pine.LNX.4.61.0509192129390.24683@...210...>
Subject: [Openvpn-devel] [PATCH] Support --ca together with --pkcs12
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Sep 19 12:44:28 2005
To: openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--230776145-1904907378-1127158075=:24683
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-ID: <Pine.LNX.4.61.0509192129391.24683@...210...>

As promised in the thread "use pkcs12 certificates or not" on 
openvpn-users list, here is a patch that enables the use of --ca together 
with --pkcs12.

If --ca is used at the same time as --pkcs12 the CA certificate is loaded 
from the file specified by --ca regardless if the pkcs12 file contain a CA 
cert or not.

Tested on windows with both a seperate CA file and with the CA file 
bundled in the pkcs12 archive.

The patch is also available here:
http://openvpn.se/files/patches/openvpn-2.0.2-pkcs12_seperate_ca.patch

-- 
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
OpenVPN GUI for Windows           X    NO HTML/RTF in e-mail
http://openvpn.se/               / \   NO Word docs in e-mail
--230776145-1904907378-1127158075=:24683
Content-Type: TEXT/PLAIN; charset=us-ascii; name="openvpn-2.0.2-pkcs12_seperate_ca.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0509192127550.24683@...210...>
Content-Description: 
Content-Disposition: attachment; filename="openvpn-2.0.2-pkcs12_seperate_ca.patch"

ZGlmZiAtdXJOIG9wZW52cG4tMi4wLjIvb3B0aW9ucy5jIG9wZW52cG4tMi4w
LjItY2Evb3B0aW9ucy5jDQotLS0gb3BlbnZwbi0yLjAuMi9vcHRpb25zLmMJ
VGh1IEF1ZyAgNCAwMToxNjoyOCAyMDA1DQorKysgb3BlbnZwbi0yLjAuMi1j
YS9vcHRpb25zLmMJTW9uIFNlcCAxOSAyMTowNToyMiAyMDA1DQpAQCAtNDAx
LDcgKzQwMSw3IEBADQogICAiICAgICAgICAgICAgICAgICAgYnkgYSBDZXJ0
aWZpY2F0ZSBBdXRob3JpdHkgaW4gLS1jYSBmaWxlLlxuIg0KICAgIi0ta2V5
IGZpbGUgICAgICA6IExvY2FsIHByaXZhdGUga2V5IGluIC5wZW0gZm9ybWF0
LlxuIg0KICAgIi0tcGtjczEyIGZpbGUgICA6IFBLQ1MjMTIgZmlsZSBjb250
YWluaW5nIGxvY2FsIHByaXZhdGUga2V5LCBsb2NhbCBjZXJ0aWZpY2F0ZVxu
Ig0KLSAgIiAgICAgICAgICAgICAgICAgIGFuZCByb290IENBIGNlcnRpZmlj
YXRlLlxuIg0KKyAgIiAgICAgICAgICAgICAgICAgIGFuZCBvcHRpb25hbGx5
IHRoZSByb290IENBIGNlcnRpZmljYXRlLlxuIg0KICNpZmRlZiBXSU4zMg0K
ICAgIi0tY3J5cHRvYXBpY2VydCBzZWxlY3Qtc3RyaW5nIDogTG9hZCB0aGUg
Y2VydGlmaWNhdGUgYW5kIHByaXZhdGUga2V5IGZyb20gdGhlXG4iDQogICAi
ICAgICAgICAgICAgICAgICAgV2luZG93cyBDZXJ0aWZpY2F0ZSBTeXN0ZW0g
U3RvcmUuXG4iDQpAQCAtMTU4Miw4ICsxNTgyLDYgQEANCiAjZW5kaWYNCiAg
ICAgICBpZiAob3B0aW9ucy0+cGtjczEyX2ZpbGUpDQogICAgICAgICB7DQot
ICAgICAgICAgIGlmIChvcHRpb25zLT5jYV9maWxlKQ0KLQkgICAgbXNnKE1f
VVNBR0UsICJQYXJhbWV0ZXIgLS1jYSBjYW5ub3QgYmUgdXNlZCB3aGVuIC0t
cGtjczEyIGlzIGFsc28gc3BlY2lmaWVkLiIpOw0KICAgICAgICAgICBpZiAo
b3B0aW9ucy0+Y2VydF9maWxlKQ0KIAkgICAgbXNnKE1fVVNBR0UsICJQYXJh
bWV0ZXIgLS1jZXJ0IGNhbm5vdCBiZSB1c2VkIHdoZW4gLS1wa2NzMTIgaXMg
YWxzbyBzcGVjaWZpZWQuIik7DQogICAgICAgICAgIGlmIChvcHRpb25zLT5w
cml2X2tleV9maWxlKQ0KZGlmZiAtdXJOIG9wZW52cG4tMi4wLjIvc3NsLmMg
b3BlbnZwbi0yLjAuMi1jYS9zc2wuYw0KLS0tIG9wZW52cG4tMi4wLjIvc3Ns
LmMJVGh1IEF1ZyAgNCAxMjo1MDowOCAyMDA1DQorKysgb3BlbnZwbi0yLjAu
Mi1jYS9zc2wuYwlNb24gU2VwIDE5IDIxOjAwOjI2IDIwMDUNCkBAIC04MzIs
MTQgKzgzMiwxNyBAQA0KICAgICAgICAgbXNnIChNX1NTTEVSUiwgIlByaXZh
dGUga2V5IGRvZXMgbm90IG1hdGNoIHRoZSBjZXJ0aWZpY2F0ZSIpOw0KIA0K
ICAgICAgIC8qIFNldCBDZXJ0aWZpY2F0ZSBWZXJpZmljYXRpb24gY2hhaW4g
Ki8NCi0gICAgICBpZiAoY2EgJiYgc2tfbnVtKGNhKSkNCisgICAgICBpZiAo
IW9wdGlvbnMtPmNhX2ZpbGUpDQogICAgICAgICB7DQotICAgICAgICAgIGZv
ciAoaSA9IDA7IGkgPCBza19YNTA5X251bShjYSk7IGkrKykNCisgICAgICAg
ICAgaWYgKGNhICYmIHNrX251bShjYSkpDQogICAgICAgICAgICAgew0KLQkg
ICAgICBpZiAoIVg1MDlfU1RPUkVfYWRkX2NlcnQoY3R4LT5jZXJ0X3N0b3Jl
LHNrX1g1MDlfdmFsdWUoY2EsIGkpKSkNCi0gICAgICAgICAgICAgICAgIG1z
ZyAoTV9TU0xFUlIsICJDYW5ub3QgYWRkIGNlcnRpZmljYXRlIHRvIGNlcnRp
ZmljYXRlIGNoYWluIChYNTA5X1NUT1JFX2FkZF9jZXJ0KSIpOw0KLSAgICAg
ICAgICAgICAgaWYgKCFTU0xfQ1RYX2FkZF9jbGllbnRfQ0EoY3R4LCBza19Y
NTA5X3ZhbHVlKGNhLCBpKSkpDQotICAgICAgICAgICAgICAgIG1zZyAoTV9T
U0xFUlIsICJDYW5ub3QgYWRkIGNlcnRpZmljYXRlIHRvIGNsaWVudCBDQSBs
aXN0IChTU0xfQ1RYX2FkZF9jbGllbnRfQ0EpIik7DQorICAgICAgICAgICAg
ICBmb3IgKGkgPSAwOyBpIDwgc2tfWDUwOV9udW0oY2EpOyBpKyspDQorICAg
ICAgICAgICAgICAgIHsNCisJICAgICAgICAgIGlmICghWDUwOV9TVE9SRV9h
ZGRfY2VydChjdHgtPmNlcnRfc3RvcmUsc2tfWDUwOV92YWx1ZShjYSwgaSkp
KQ0KKyAgICAgICAgICAgICAgICAgICAgbXNnIChNX1NTTEVSUiwgIkNhbm5v
dCBhZGQgY2VydGlmaWNhdGUgdG8gY2VydGlmaWNhdGUgY2hhaW4gKFg1MDlf
U1RPUkVfYWRkX2NlcnQpIik7DQorICAgICAgICAgICAgICAgICAgaWYgKCFT
U0xfQ1RYX2FkZF9jbGllbnRfQ0EoY3R4LCBza19YNTA5X3ZhbHVlKGNhLCBp
KSkpDQorICAgICAgICAgICAgICAgICAgICBtc2cgKE1fU1NMRVJSLCAiQ2Fu
bm90IGFkZCBjZXJ0aWZpY2F0ZSB0byBjbGllbnQgQ0EgbGlzdCAoU1NMX0NU
WF9hZGRfY2xpZW50X0NBKSIpOw0KKyAgICAgICAgICAgICAgICB9DQogICAg
ICAgICAgICAgfQ0KICAgICAgICAgfQ0KICAgICB9DQpAQCAtODg1LDcgKzg4
OCwxMCBAQA0KIAkJbXNnIChNX1NTTEVSUiwgIlByaXZhdGUga2V5IGRvZXMg
bm90IG1hdGNoIHRoZSBjZXJ0aWZpY2F0ZSIpOw0KIAkgICAgfQ0KIAl9DQor
ICAgIH0NCiANCisgIGlmIChvcHRpb25zLT5jYV9maWxlKQ0KKyAgICB7DQog
ICAgICAgLyogTG9hZCBDQSBmaWxlIGZvciB2ZXJpZnlpbmcgcGVlciBzdXBw
bGllZCBjZXJ0aWZpY2F0ZSAqLw0KICAgICAgIEFTU0VSVCAob3B0aW9ucy0+
Y2FfZmlsZSk7DQogICAgICAgaWYgKCFTU0xfQ1RYX2xvYWRfdmVyaWZ5X2xv
Y2F0aW9ucyAoY3R4LCBvcHRpb25zLT5jYV9maWxlLCBOVUxMKSkNCkBAIC04
OTksOSArOTA1LDggQEANCiAgICAgICAgICAgbXNnIChNX1NTTEVSUiwgIkNh
bm5vdCBsb2FkIENBIGNlcnRpZmljYXRlIGZpbGUgJXMgKFNTTF9sb2FkX2Ns
aWVudF9DQV9maWxlKSIsIG9wdGlvbnMtPmNhX2ZpbGUpOw0KICAgICAgICAg
U1NMX0NUWF9zZXRfY2xpZW50X0NBX2xpc3QgKGN0eCwgY2VydF9uYW1lcyk7
DQogICAgICAgfQ0KLQ0KICAgICB9DQotICANCisNCiAgIC8qIEVuYWJsZSB0
aGUgdXNlIG9mIGNlcnRpZmljYXRlIGNoYWlucyAqLw0KICAgaWYgKHVzaW5n
X2NlcnRfZmlsZSkNCiAgICAgew0K

--230776145-1904907378-1127158075=:24683--

