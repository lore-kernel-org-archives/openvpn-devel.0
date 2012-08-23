Message-ID: <1345727389.42365.YahooMailNeo@...1744...>
Date: Thu, 23 Aug 2012 21:09:49 +0800 (SGT)
From: "ammdispose-vpn@...109..." <ammdispose-vpn@...109...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="730575183-87606464-1345727389=:42365"
Subject: [Openvpn-devel] patch for 2.2.2 to include --script-dir
Reply-To: "ammdispose-vpn@...109..." <ammdispose-vpn@...109...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--730575183-87606464-1345727389=:42365
Content-Type: multipart/alternative;
	boundary="730575183-1566446307-1345727389=:42365"

--730575183-1566446307-1345727389=:42365
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello all,

I am submitting a minor patch which includes an option to specify --script-=
dir.
i.e. any user defined script will be run ONLY IF it is present in "script-d=
ir".

The reason I needed this is because I had a frontend to configuration file =
which allowed administrator to change configuration.

I also have script-security set to 2 because I wanted to run a script when =
client connects.

These two option make it insecure. As admin (with bad intention or if admin=
 password is leaked) can simply call "rm -rf /" for certain commands.

So my idea was
1) Add a new option called script-dir
2) Frontend will not allow word "script-dir" in config file (so admin cant =
change it)
3) script-dir will be passed on command line

This way admin can not run anything other than what I have put in script-di=
r. This also helps prevent accidentally run script in some other path.

Patch also fixes minor bug in init.c where warning for SSEC_PW_ENV actually=
 would never be shown.



So please have a look at it and if acceptable then merge in source tree.

Thanks

AMM.

--730575183-1566446307-1345727389=:42365
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ve=
rdana, helvetica, sans-serif;font-size:10pt">Hello all,<br><br>I am submitt=
ing a minor patch which includes an option to specify --script-dir.<br>i.e.=
 any user defined script will be run ONLY IF it is present in "script-dir".=
<br><br>The reason I needed this is because I had a frontend to configurati=
on file which allowed administrator to change configuration.<br><br>I also =
have script-security set to 2 because I wanted to run a script when client =
connects.<br><br>These two option make it insecure. As admin (with bad inte=
ntion or if admin password is leaked) can simply call "rm -rf /" for certai=
n commands.<br><br>So my idea was<br>1) Add a new option called script-dir<=
br>2) Frontend will not allow word "script-dir" in config file (so admin ca=
nt change it)<br>3) script-dir will be passed on command line<br><br>This w=
ay admin can not run anything other than what I have put in
 script-dir. This also helps prevent accidentally run script in some other =
path.<br><br>Patch also fixes minor bug in init.c where warning for SSEC_PW=
_ENV actually would never be shown.<br><div><br></div><div style=3D"color: =
rgb(0, 0, 0); font-size: 13.3333px; font-family: verdana,helvetica,sans-ser=
if; background-color: transparent; font-style: normal;"><br></div><div styl=
e=3D"color: rgb(0, 0, 0); font-size: 13.3333px; font-family: verdana,helvet=
ica,sans-serif; background-color: transparent; font-style: normal;">So plea=
se have a look at it and if acceptable then merge in source tree.</div><div=
 style=3D"color: rgb(0, 0, 0); font-size: 13.3333px; font-family: verdana,h=
elvetica,sans-serif; background-color: transparent; font-style: normal;"><b=
r></div><div style=3D"color: rgb(0, 0, 0); font-size: 13.3333px; font-famil=
y: verdana,helvetica,sans-serif; background-color: transparent; font-style:=
 normal;">Thanks</div><div style=3D"color: rgb(0, 0, 0); font-size: 13.3333=
px;
 font-family: verdana,helvetica,sans-serif; background-color: transparent; =
font-style: normal;"><br></div><div style=3D"color: rgb(0, 0, 0); font-size=
: 13.3333px; font-family: verdana,helvetica,sans-serif; background-color: t=
ransparent; font-style: normal;">AMM.<br></div></div></body></html>=

--730575183-1566446307-1345727389=:42365--

--730575183-87606464-1345727389=:42365
Content-Type: text/x-patch; name="openvpn-2.2.2-scriptdir.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="openvpn-2.2.2-scriptdir.patch"

LS0tIG9wZW52cG4tMi4yLjIvaW5pdC5jCTIwMTEtMTItMTMgMjI6Mjg6NTYu
MDAwMDAwMDAwICswNTMwCisrKyBvcGVudnBuLTIuMi4yL2luaXQuYwkyMDEy
LTA4LTIxIDExOjUzOjIyLjgwOTQxMDA4NSArMDUzMApAQCAtMjI5MSw5ICsy
MjkxLDEzIEBACiAjZW5kaWYKIAogICBpZiAoc2NyaXB0X3NlY3VyaXR5ID49
IFNTRUNfU0NSSVBUUykKLSAgICBtc2cgKE1fV0FSTiwgIk5PVEU6IHRoZSBj
dXJyZW50IC0tc2NyaXB0LXNlY3VyaXR5IHNldHRpbmcgbWF5IGFsbG93IHRo
aXMgY29uZmlndXJhdGlvbiB0byBjYWxsIHVzZXItZGVmaW5lZCBzY3JpcHRz
Iik7Ci0gIGVsc2UgaWYgKHNjcmlwdF9zZWN1cml0eSA+PSBTU0VDX1BXX0VO
VikKLSAgICBtc2cgKE1fV0FSTiwgIldBUk5JTkc6IHRoZSBjdXJyZW50IC0t
c2NyaXB0LXNlY3VyaXR5IHNldHRpbmcgbWF5IGFsbG93IHBhc3N3b3JkcyB0
byBiZSBwYXNzZWQgdG8gc2NyaXB0cyB2aWEgZW52aXJvbm1lbnRhbCB2YXJp
YWJsZXMiKTsKKyAgICB7CisgICAgICBtc2cgKE1fV0FSTiwgIk5PVEU6IHRo
ZSBjdXJyZW50IC0tc2NyaXB0LXNlY3VyaXR5IHNldHRpbmcgbWF5IGFsbG93
IHRoaXMgY29uZmlndXJhdGlvbiB0byBjYWxsIHVzZXItZGVmaW5lZCBzY3Jp
cHRzIik7CisgICAgICBpZiAoc2NyaXB0X3NlY3VyaXR5ID49IFNTRUNfUFdf
RU5WKQorICAgICAgICBtc2cgKE1fV0FSTiwgIldBUk5JTkc6IHRoZSBjdXJy
ZW50IC0tc2NyaXB0LXNlY3VyaXR5IHNldHRpbmcgbWF5IGFsbG93IHBhc3N3
b3JkcyB0byBiZSBwYXNzZWQgdG8gc2NyaXB0cyB2aWEgZW52aXJvbm1lbnRh
bCB2YXJpYWJsZXMiKTsKKyAgICAgIGlmIChzY3JpcHRfZGlyID09IE5VTEwp
CisgICAgICAgIG1zZyAoTV9XQVJOLCAiV0FSTklORzogc2V0dGluZyAtLXNj
cmlwdC1kaXIgaXMgcmVjb21tZW5kZWQgZm9yIGhpZ2hlciBzZWN1cml0eSIp
OworICAgIH0KICAgZWxzZQogICAgIG1zZyAoTV9XQVJOLCAiTk9URTogIiBQ
QUNLQUdFX05BTUUgIiAyLjEgcmVxdWlyZXMgJy0tc2NyaXB0LXNlY3VyaXR5
IDInIG9yIGhpZ2hlciB0byBjYWxsIHVzZXItZGVmaW5lZCBzY3JpcHRzIG9y
IGV4ZWN1dGFibGVzIik7CiAKLS0tIG9wZW52cG4tMi4yLjIvbWlzYy5jCTIw
MTEtMTItMTMgMjI6Mjg6NTYuMDAwMDAwMDAwICswNTMwCisrKyBvcGVudnBu
LTIuMi4yL21pc2MuYwkyMDEyLTA4LTIxIDEyOjI3OjI0LjMzMjI5Njc3OCAr
MDUzMApAQCAtNDUsNiArNDUsNyBAQAogCiAvKiBjb250YWlucyBhbiBTU0VD
X3ggdmFsdWUgZGVmaW5lZCBpbiBtaXNjLmggKi8KIGludCBzY3JpcHRfc2Vj
dXJpdHkgPSBTU0VDX0JVSUxUX0lOOyAvKiBHTE9CQUwgKi8KK2NvbnN0IGNo
YXIgKnNjcmlwdF9kaXIgPSBOVUxMOyAvKiBHTE9CQUwgKi8KIAogLyogY29u
dGFpbnMgU01feCB2YWx1ZSBkZWZpbmVkIGluIG1pc2MuaCAqLwogaW50IHNj
cmlwdF9tZXRob2QgPSBTTV9FWEVDVkU7IC8qIEdMT0JBTCAqLwpAQCAtNDg0
LDEwICs0ODUsMTQgQEAKIH0KIAogYm9vbAotb3BlbnZwbl9leGVjdmVfYWxs
b3dlZCAoY29uc3QgdW5zaWduZWQgaW50IGZsYWdzKQorb3BlbnZwbl9leGVj
dmVfYWxsb3dlZCAoY29uc3QgY2hhciAqY21kLCBjb25zdCB1bnNpZ25lZCBp
bnQgZmxhZ3MpCiB7CiAgIGlmIChmbGFncyAmIFNfU0NSSVBUKQotICAgIHJl
dHVybiBzY3JpcHRfc2VjdXJpdHkgPj0gU1NFQ19TQ1JJUFRTOworICAgIHsK
KyAgICAgIGlmIChzY3JpcHRfZGlyICE9IE5VTEwgJiYgc3RybmNtcChzY3Jp
cHRfZGlyLCBjbWQsIHN0cmxlbihzY3JpcHRfZGlyKSkpCisJcmV0dXJuIGZh
bHNlOworICAgICAgcmV0dXJuIHNjcmlwdF9zZWN1cml0eSA+PSBTU0VDX1ND
UklQVFM7CisgICAgfQogICBlbHNlCiAgICAgcmV0dXJuIHNjcmlwdF9zZWN1
cml0eSA+PSBTU0VDX0JVSUxUX0lOOwogfQpAQCAtNTA5LDExICs1MTQsMTEg
QEAKICAgaWYgKGEgJiYgYS0+YXJndlswXSkKICAgICB7CiAjaWYgZGVmaW5l
ZChFTkFCTEVfRVhFQ1ZFKQotICAgICAgaWYgKG9wZW52cG5fZXhlY3ZlX2Fs
bG93ZWQgKGZsYWdzKSkKKyAgICAgIGNvbnN0IGNoYXIgKmNtZCA9IGEtPmFy
Z3ZbMF07CisgICAgICBpZiAob3BlbnZwbl9leGVjdmVfYWxsb3dlZCAoY21k
LCBmbGFncykpCiAJewogCSAgaWYgKHNjcmlwdF9tZXRob2QgPT0gU01fRVhF
Q1ZFKQogCSAgICB7Ci0JICAgICAgY29uc3QgY2hhciAqY21kID0gYS0+YXJn
dlswXTsKIAkgICAgICBjaGFyICpjb25zdCAqYXJndiA9IGEtPmFyZ3Y7CiAJ
ICAgICAgY2hhciAqY29uc3QgKmVudnAgPSAoY2hhciAqY29uc3QgKiltYWtl
X2Vudl9hcnJheSAoZXMsIHRydWUsICZnYyk7CiAJICAgICAgcGlkX3QgcGlk
OwotLS0gb3BlbnZwbi0yLjIuMi9taXNjLmgJMjAxMS0xMi0xMyAyMjoyODo1
Ni4wMDAwMDAwMDAgKzA1MzAKKysrIG9wZW52cG4tMi4yLjIvbWlzYy5oCTIw
MTItMDgtMjEgMTI6MTA6NTkuOTE2MDUwOTE5ICswNTMwCkBAIC0xMzMsNyAr
MTMzLDcgQEAKIC8qIHdyYXBwZXIgYXJvdW5kIHRoZSBleGVjdmUoKSBjYWxs
ICovCiBpbnQgb3BlbnZwbl9leGVjdmUgKGNvbnN0IHN0cnVjdCBhcmd2ICph
LCBjb25zdCBzdHJ1Y3QgZW52X3NldCAqZXMsIGNvbnN0IHVuc2lnbmVkIGlu
dCBmbGFncyk7CiBib29sIG9wZW52cG5fZXhlY3ZlX2NoZWNrIChjb25zdCBz
dHJ1Y3QgYXJndiAqYSwgY29uc3Qgc3RydWN0IGVudl9zZXQgKmVzLCBjb25z
dCB1bnNpZ25lZCBpbnQgZmxhZ3MsIGNvbnN0IGNoYXIgKmVycm9yX21lc3Nh
Z2UpOwotYm9vbCBvcGVudnBuX2V4ZWN2ZV9hbGxvd2VkIChjb25zdCB1bnNp
Z25lZCBpbnQgZmxhZ3MpOworYm9vbCBvcGVudnBuX2V4ZWN2ZV9hbGxvd2Vk
IChjb25zdCBjaGFyICpjbWQsIGNvbnN0IHVuc2lnbmVkIGludCBmbGFncyk7
CiBpbnQgb3BlbnZwbl9zeXN0ZW0gKGNvbnN0IGNoYXIgKmNvbW1hbmQsIGNv
bnN0IHN0cnVjdCBlbnZfc2V0ICplcywgdW5zaWduZWQgaW50IGZsYWdzKTsK
IAogc3RhdGljIGlubGluZSBib29sCkBAIC0zNTMsNiArMzUzLDcgQEAKICNk
ZWZpbmUgU1NFQ19TQ1JJUFRTICAgMiAvKiBhbGxvdyBjYWxsaW5nIG9mIGJ1
aWx0LWluIHByb2dyYW1zIGFuZCB1c2VyLWRlZmluZWQgc2NyaXB0cyAqLwog
I2RlZmluZSBTU0VDX1BXX0VOViAgICAzIC8qIGFsbG93IGNhbGxpbmcgb2Yg
YnVpbHQtaW4gcHJvZ3JhbXMgYW5kIHVzZXItZGVmaW5lZCBzY3JpcHRzIHRo
YXQgbWF5IHJlY2VpdmUgYSBwYXNzd29yZCBhcyBhbiBlbnZpcm9ubWVudGFs
IHZhcmlhYmxlICovCiBleHRlcm4gaW50IHNjcmlwdF9zZWN1cml0eTsgLyog
R0xPQkFMICovCitleHRlcm4gY29uc3QgY2hhciAqc2NyaXB0X2RpcjsgLyog
R0xPQkFMICovCiAKICNkZWZpbmUgU01fRVhFQ1ZFIDAgICAgICAvKiBjYWxs
IGV4dGVybmFsIHByb2dyYW1zIHdpdGggZXhlY3ZlKCkgb3IgQ3JlYXRlUHJv
Y2VzcygpICovCiAjZGVmaW5lIFNNX1NZU1RFTSAxICAgICAgLyogY2FsbCBl
eHRlcm5hbCBwcm9ncmFtcyB3aXRoIHN5c3RlbSgpICovCi0tLSBvcGVudnBu
LTIuMi4yL29wdGlvbnMuYwkyMDExLTEyLTEzIDIyOjI4OjU2LjAwMDAwMDAw
MCArMDUzMAorKysgb3BlbnZwbi0yLjIuMi9vcHRpb25zLmMJMjAxMi0wOC0y
MSAxMTozMzoxNS45NTU2NDg2NjYgKzA1MzAKQEAgLTIxOCw2ICsyMTgsNyBA
QAogICAiICAgICAgICAgICAgICAgICAgMSAtLSAoZGVmYXVsdCkgb25seSBj
YWxsIGJ1aWx0LWlucyBzdWNoIGFzIGlmY29uZmlnXG4iCiAgICIgICAgICAg
ICAgICAgICAgICAyIC0tIGFsbG93IGNhbGxpbmcgb2YgYnVpbHQtaW5zIGFu
ZCBzY3JpcHRzXG4iCiAgICIgICAgICAgICAgICAgICAgICAzIC0tIGFsbG93
IHBhc3N3b3JkIHRvIGJlIHBhc3NlZCB0byBzY3JpcHRzIHZpYSBlbnZcbiIK
KyAgIi0tc2NyaXB0LWRpciBkaXI6IE9ubHkgcnVuIHVzZXItZGVmaW5lZCBz
Y3JpcHRzIGlmIGl0IHJlc2lkZXMgaW4gdGhpcyBkaXJlY3RvcnlcbiIKICAg
Ii0tc2hhcGVyIG4gICAgICA6IFJlc3RyaWN0IG91dHB1dCB0byBwZWVyIHRv
IG4gYnl0ZXMgcGVyIHNlY29uZC5cbiIKICAgIi0ta2VlcGFsaXZlIG4gbSA6
IEhlbHBlciBvcHRpb24gZm9yIHNldHRpbmcgdGltZW91dHMgaW4gc2VydmVy
IG1vZGUuICBTZW5kXG4iCiAgICIgICAgICAgICAgICAgICAgICBwaW5nIG9u
Y2UgZXZlcnkgbiBzZWNvbmRzLCByZXN0YXJ0IGlmIHBpbmcgbm90IHJlY2Vp
dmVkXG4iCkBAIC00NzQ4LDYgKzQ3NDksMTEgQEAKICAgICAgIGVsc2UKIAlz
Y3JpcHRfbWV0aG9kID0gU01fRVhFQ1ZFOwogICAgIH0KKyAgZWxzZSBpZiAo
c3RyZXEgKHBbMF0sICJzY3JpcHQtZGlyIikgJiYgcFsxXSkKKyAgICB7Cisg
ICAgICBWRVJJRllfUEVSTUlTU0lPTiAoT1BUX1BfR0VORVJBTCk7CisgICAg
ICBzY3JpcHRfZGlyID0gcFsxXTsKKyAgICB9CiAgIGVsc2UgaWYgKHN0cmVx
IChwWzBdLCAibXNzZml4IikpCiAgICAgewogICAgICAgVkVSSUZZX1BFUk1J
U1NJT04gKE9QVF9QX0dFTkVSQUwpOwotLS0gb3BlbnZwbi0yLjIuMi93aW4z
Mi5jCTIwMTEtMTItMTMgMjI6Mjg6NTYuMDAwMDAwMDAwICswNTMwCisrKyBv
cGVudnBuLTIuMi4yL3dpbjMyLmMJMjAxMi0wOC0yMSAxMjoxNTo1Ni4zNTU2
Mjc5NzQgKzA1MzAKQEAgLTk1Niw3ICs5NTYsOCBAQAogCiAgIGlmIChhICYm
IGEtPmFyZ3ZbMF0pCiAgICAgewotICAgICAgaWYgKG9wZW52cG5fZXhlY3Zl
X2FsbG93ZWQgKGZsYWdzKSkKKyAgICAgIGNoYXIgKmNtZCA9IGEtPmFyZ3Zb
MF07CisgICAgICBpZiAob3BlbnZwbl9leGVjdmVfYWxsb3dlZCAoY21kLCBm
bGFncykpCiAJewogCSAgaWYgKHNjcmlwdF9tZXRob2QgPT0gU01fRVhFQ1ZF
KQogCSAgICB7CkBAIC05NjUsNyArOTY2LDYgQEAKIAogCSAgICAgIGNoYXIg
KmVudiA9IGVudl9ibG9jayAoZXMpOwogCSAgICAgIGNoYXIgKmNsID0gY21k
X2xpbmUgKGEpOwotCSAgICAgIGNoYXIgKmNtZCA9IGEtPmFyZ3ZbMF07CiAK
IAkgICAgICBDTEVBUiAoc3RhcnRfaW5mbyk7CiAJICAgICAgQ0xFQVIgKHBy
b2NfaW5mbyk7Cg==

--730575183-87606464-1345727389=:42365--

