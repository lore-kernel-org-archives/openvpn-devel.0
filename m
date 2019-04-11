From: Eric Thorpe <eric@...1918...>
Message-ID: <cc9094b8-caa6-34b6-ed7a-3ccb34560113@...1918...>
Date: Thu, 11 Apr 2019 12:07:27 +1000
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------91480A2F3C293E4E9F1C8503"
Content-Language: en-US
Subject: [Openvpn-devel] [PATCH v2 1/2] Send auth fail to client on reneg
 failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------91480A2F3C293E4E9F1C8503
Content-Type: multipart/alternative;
 boundary="------------7007B8F8F7080F28F5F4B798"

--------------7007B8F8F7080F28F5F4B798
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

This patch relies on Arne's "Add send_control_channel_string_dowork
variant" patch.

This patch modifies auth so that on a renegotiation the client is
informed of a SESSION re-auth failure during a renegotiation if either
their auth-token has expired, or they enter a wrong password in the case
of auth-nocache for example.

This also addresses my previous patch for supporting a client reason
being rejected.

Regards,
Eric

--=20
--
Eric Thorpe
SparkLabs Developer
https://www.sparklabs.com
https://twitter.com/sparklabs
support@...1918...


--------------7007B8F8F7080F28F5F4B798
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>

    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF-8=
">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    <p>Hi All,</p>
    <p>This patch relies on Arne's "Add
      send_control_channel_string_dowork variant" patch.</p>
    <p>This patch modifies auth so that on a renegotiation the client is
      informed of a SESSION re-auth failure during a renegotiation if
      either their auth-token has expired, or they enter a wrong
      password in the case of auth-nocache for example.</p>
    <p>This also addresses my previous patch for supporting a client
      reason being rejected.<br>
    </p>
    <p>Regards,<br>
      Eric<br>
    </p>
    <pre class=3D"moz-signature" cols=3D"72">--=20
--
Eric Thorpe
SparkLabs Developer
<a class=3D"moz-txt-link-freetext" href=3D"https://www.sparklabs.com">https=
://www.sparklabs.com</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://twitter.com/sparklabs">h=
ttps://twitter.com/sparklabs</a>
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:support@...1918...">su=
pport@...1918...</a></pre>
  </body>
</html>

--------------7007B8F8F7080F28F5F4B798--

--------------91480A2F3C293E4E9F1C8503
Content-Type: text/plain; charset=UTF-8;
 name="1_send_auth_fail_on_reneg_fail.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="1_send_auth_fail_on_reneg_fail.patch"

RnJvbSBiYjBmYWRhODk5YTQzZTQ4ZTJjYTM4MzU4OTEyZjkyNDQ3NDIyZjUzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBFcmljIFRob3JwZSA8ZXJpYytnaXRAc3BhcmtsYWJz
LmNvbT4KRGF0ZTogV2VkLCAxMCBBcHIgMjAxOSAxOTowNjoxNiArMTAwMApTdWJqZWN0OiBb
UEFUQ0hdIFNlbmQgYXV0aCBmYWlsZWQgbWVzc2FnZSB0byBjbGllbnQgb24gcmVuZWdvdGlh
dGlvbiBmYWlsdXJlCiB2aWEgdXNlci1wYXNzIG9yIGF1dGgtdG9rZW4gZXhwaXJ5CgotLS0K
IHNyYy9vcGVudnBuL211bHRpLmMgICAgICB8ICAxICsKIHNyYy9vcGVudnBuL3B1c2guYyAg
ICAgICB8IDMwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogc3JjL29wZW52cG4v
c3NsX2NvbW1vbi5oIHwgIDEgKwogc3JjL29wZW52cG4vc3NsX3ZlcmlmeS5jIHwgIDcgKysr
KysrKwogNCBmaWxlcyBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
c3JjL29wZW52cG4vbXVsdGkuYyBiL3NyYy9vcGVudnBuL211bHRpLmMKaW5kZXggMjhjM2I4
ODY3Li5hODgzZmFhNzkgMTAwNjQ0Ci0tLSBhL3NyYy9vcGVudnBuL211bHRpLmMKKysrIGIv
c3JjL29wZW52cG4vbXVsdGkuYwpAQCAtMjA4NSw2ICsyMDg1LDcgQEAgbXVsdGlfY29ubmVj
dGlvbl9lc3RhYmxpc2hlZChzdHJ1Y3QgbXVsdGlfY29udGV4dCAqbSwgc3RydWN0IG11bHRp
X2luc3RhbmNlICptaSkKIAogICAgICAgICAvKiBzZXQgZmxhZyBzbyB3ZSBkb24ndCBnZXQg
Y2FsbGVkIGFnYWluICovCiAgICAgICAgIG1pLT5jb25uZWN0aW9uX2VzdGFibGlzaGVkX2Zs
YWcgPSB0cnVlOworICAgICAgICBtaS0+Y29udGV4dC5jMi50bHNfbXVsdGktPmNvbm5lY3Rp
b25fZXN0YWJsaXNoZWQgPSB0cnVlOwogCiAgICAgICAgIC8qIGluY3JlbWVudCBudW1iZXIg
b2YgY3VycmVudCBhdXRoZW50aWNhdGVkIGNsaWVudHMgKi8KICAgICAgICAgKyttLT5uX2Ns
aWVudHM7CmRpZmYgLS1naXQgYS9zcmMvb3BlbnZwbi9wdXNoLmMgYi9zcmMvb3BlbnZwbi9w
dXNoLmMKaW5kZXggZGQ1YmQ0MTYzLi4zMjdhZTA4OTEgMTAwNjQ0Ci0tLSBhL3NyYy9vcGVu
dnBuL3B1c2guYworKysgYi9zcmMvb3BlbnZwbi9wdXNoLmMKQEAgLTIzMyw2ICsyMzMsMzYg
QEAgc2VuZF9hdXRoX2ZhaWxlZChzdHJ1Y3QgY29udGV4dCAqYywgY29uc3QgY2hhciAqY2xp
ZW50X3JlYXNvbikKICAgICBnY19mcmVlKCZnYyk7CiB9CiAKKy8qCisgKiBTZW5kIGF1dGgg
ZmFpbGVkIG1lc3NhZ2UgZnJvbSBzZXJ2ZXIgdG8gY2xpZW50IHdpdGhvdXQgc2NoZWR1bGlu
Zy4KKyAqIE1haW4gdXNlIGZvciBxdWV1aW5nIGEgbWVzc2FnZSBkdXJpbmcgcmVuZWdvdGlh
dGlvbgorICovCit2b2lkCitzZW5kX3B1c2hfcmVwbHlfYXV0aF9mYWlsZWQoc3RydWN0IHRs
c19tdWx0aSAqbXVsdGksIGNvbnN0IGNoYXIgKmNsaWVudF9yZWFzb24pCit7CisgICAgc3Ry
dWN0IGdjX2FyZW5hIGdjID0gZ2NfbmV3KCk7CisgICAgc3RhdGljIGNvbnN0IGNoYXIgYXV0
aF9mYWlsZWRbXSA9ICJBVVRIX0ZBSUxFRCI7CisgICAgc2l6ZV90IGxlbjsKKworICAgIGxl
biA9IChjbGllbnRfcmVhc29uID8gc3RybGVuKGNsaWVudF9yZWFzb24pKzEgOiAwKSArIHNp
emVvZihhdXRoX2ZhaWxlZCk7CisgICAgaWYgKGxlbiA+IFBVU0hfQlVORExFX1NJWkUpCisg
ICAgeworICAgICAgICBsZW4gPSBQVVNIX0JVTkRMRV9TSVpFOworICAgIH0KKworICAgIHsK
KyAgICAgICAgc3RydWN0IGJ1ZmZlciBidWYgPSBhbGxvY19idWZfZ2MobGVuLCAmZ2MpOwor
ICAgICAgICBidWZfcHJpbnRmKCZidWYsIGF1dGhfZmFpbGVkKTsKKyAgICAgICAgaWYgKGNs
aWVudF9yZWFzb24pCisgICAgICAgIHsKKyAgICAgICAgICAgIGJ1Zl9wcmludGYoJmJ1Ziwg
IiwlcyIsIGNsaWVudF9yZWFzb24pOworICAgICAgICB9CisgICAgICAgIHNlbmRfY29udHJv
bF9jaGFubmVsX3N0cmluZ19kb3dvcmsobXVsdGksIEJTVFIoJmJ1ZiksIERfUFVTSCk7Cisg
ICAgfQorCisgICAgZ2NfZnJlZSgmZ2MpOworfQorCiAvKgogICogU2VuZCByZXN0YXJ0IG1l
c3NhZ2UgZnJvbSBzZXJ2ZXIgdG8gY2xpZW50LgogICovCmRpZmYgLS1naXQgYS9zcmMvb3Bl
bnZwbi9zc2xfY29tbW9uLmggYi9zcmMvb3BlbnZwbi9zc2xfY29tbW9uLmgKaW5kZXggYWMy
NWZmYTc4Li5iODJhMDE0YTAgMTAwNjQ0Ci0tLSBhL3NyYy9vcGVudnBuL3NzbF9jb21tb24u
aAorKysgYi9zcmMvb3BlbnZwbi9zc2xfY29tbW9uLmgKQEAgLTU0Nyw2ICs1NDcsNyBAQCBz
dHJ1Y3QgdGxzX211bHRpCiAgICAgdGltZV90IGF1dGhfdG9rZW5fdHN0YW1wOyAvKio8IHRp
bWVzdGFtcCBvZiB0aGUgZ2VuZXJhdGVkIHRva2VuICovCiAgICAgYm9vbCBhdXRoX3Rva2Vu
X3NlbnQ7IC8qKjwgSWYgc2VydmVyIHVzZXMgLS1hdXRoLWdlbi10b2tlbiBhbmQKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICogICB0b2tlbiBoYXMgYmVlbiBzZW50IHRvIGNsaWVu
dCAqLworICAgIGJvb2wgY29ubmVjdGlvbl9lc3RhYmxpc2hlZCA7IC8qKiBOb3RpZmllcyBm
dXR1cmUgYXV0aCBjYWxscyB0aGlzIGlzIGEgcmVuZWcgKi8KICAgICAvKgogICAgICAqIE91
ciBzZXNzaW9uIG9iamVjdHMuCiAgICAgICovCmRpZmYgLS1naXQgYS9zcmMvb3BlbnZwbi9z
c2xfdmVyaWZ5LmMgYi9zcmMvb3BlbnZwbi9zc2xfdmVyaWZ5LmMKaW5kZXggYzdlNTk1ZTQ2
Li5mZDgzY2RlODUgMTAwNjQ0Ci0tLSBhL3NyYy9vcGVudnBuL3NzbF92ZXJpZnkuYworKysg
Yi9zcmMvb3BlbnZwbi9zc2xfdmVyaWZ5LmMKQEAgLTEzMzYsNiArMTMzNiw3IEBAIHZlcmlm
eV91c2VyX3Bhc3Moc3RydWN0IHVzZXJfcGFzcyAqdXAsIHN0cnVjdCB0bHNfbXVsdGkgKm11
bHRpLAogICAgICAgICAgICAgJiYgKG11bHRpLT5hdXRoX3Rva2VuX3RzdGFtcCArIHNlc3Np
b24tPm9wdC0+YXV0aF90b2tlbl9saWZldGltZSkgPCBub3cpCiAgICAgICAgIHsKICAgICAg
ICAgICAgIG1zZyhEX0hBTkRTSEFLRSwgIkF1dGgtdG9rZW4gZm9yIGNsaWVudCBleHBpcmVk
XG4iKTsKKyAgICAgICAgICAgIHNlbmRfcHVzaF9yZXBseV9hdXRoX2ZhaWxlZChtdWx0aSwg
IlNFU1NJT046QXV0aC10b2tlbiBleHBpcmVkIik7CiAgICAgICAgICAgICB3aXBlX2F1dGhf
dG9rZW4obXVsdGkpOwogICAgICAgICAgICAga3MtPmF1dGhlbnRpY2F0ZWQgPSBmYWxzZTsK
ICAgICAgICAgICAgIGdvdG8gZG9uZTsKQEAgLTE0NTgsNiArMTQ1OSwxMiBAQCB2ZXJpZnlf
dXNlcl9wYXNzKHN0cnVjdCB1c2VyX3Bhc3MgKnVwLCBzdHJ1Y3QgdGxzX211bHRpICptdWx0
aSwKICAgICB9CiAgICAgZWxzZQogICAgIHsKKyAgICAgICAgaWYgKG11bHRpLT5jb25uZWN0
aW9uX2VzdGFibGlzaGVkKQorICAgICAgICB7CisgICAgICAgICAgICAvKiBOb3RpZnkgdGhl
IGNsaWVudCAqLworICAgICAgICAgICAgc2VuZF9wdXNoX3JlcGx5X2F1dGhfZmFpbGVkKG11
bHRpLCAiU0VTU0lPTjpBdXRoIGZhaWxlZCIpOworCisgICAgICAgIH0KICAgICAgICAgbXNn
KERfVExTX0VSUk9SUywgIlRMUyBBdXRoIEVycm9yOiBBdXRoIFVzZXJuYW1lL1Bhc3N3b3Jk
IHZlcmlmaWNhdGlvbiBmYWlsZWQgZm9yIHBlZXIiKTsKICAgICB9CiAK
--------------91480A2F3C293E4E9F1C8503--

