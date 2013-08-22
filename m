MIME-Version: 1.0
From: Nicholas Hall <ngharo@...277...>
Date: Thu, 22 Aug 2013 14:57:05 -0500
Message-ID: <CAK6ywbLVtSgRZEt4N+02fz+vQ0GNp==5KdsbqWtZ+fgUzrZq+g@...278...>
Content-Type: multipart/mixed; boundary=e89a8ff1cefef36c3804e48eb272
Subject: [Openvpn-devel] tls_ctx_load_ca: Improve certificate error messages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--e89a8ff1cefef36c3804e48eb272
Content-Type: multipart/alternative; boundary=e89a8ff1cefef36c3404e48eb270

--e89a8ff1cefef36c3404e48eb270
Content-Type: text/plain; charset=ISO-8859-1

From https://github.com/OpenVPN/openvpn/pull/4 (I am not the patch author)

If a CA certificate file includes intermediate certificates, and any
of them fail to verify, the current code will file with "Cannot load
CA certificate file". Instead, generate a more specific error message
identifying the specific sub-certificate(s) which did not validate.

I make no claim that I really understand the OpenVPN code, but here's the
scenario that led to this patch:

I was using the "pile of certificates" handed to me by StartSSL, and one of
them was expired, but unnecessary to the verification chain. So when I
tried to verify using openssl, it worked fine, but OpenVPN complained with
a not-very-helpful "Cannot load CA certificate file." The following patch
was what I ended up doing to figure out what was going wrong.

I have the suspicion that there are more complex procedures for submitting
a patch that I don't know about, but I figured I'd start like this to see
if the change was interesting enough to you for me to pursue it further.

--e89a8ff1cefef36c3404e48eb270
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">From=A0<a href=3D"https://github.com/OpenVPN/openvpn/pull/=
4">https://github.com/OpenVPN/openvpn/pull/4</a> (I am not the patch author=
)<div><br></div><div><div>If a CA certificate file includes intermediate ce=
rtificates, and any</div>

<div>of them fail to verify, the current code will file with &quot;Cannot l=
oad</div><div>CA certificate file&quot;. Instead, generate a more specific =
error message</div><div>identifying the specific sub-certificate(s) which d=
id not validate.</div>

<div><br></div><div>I make no claim that I really understand the OpenVPN co=
de, but here&#39;s the scenario that led to this patch:</div><div><br></div=
><div>I was using the &quot;pile of certificates&quot; handed to me by Star=
tSSL, and one of them was expired, but unnecessary to the verification chai=
n. So when I tried to verify using openssl, it worked fine, but OpenVPN com=
plained with a not-very-helpful &quot;Cannot load CA certificate file.&quot=
; The following patch was what I ended up doing to figure out what was goin=
g wrong.</div>

<div><br></div><div>I have the suspicion that there are more complex proced=
ures for submitting a patch that I don&#39;t know about, but I figured I&#3=
9;d start like this to see if the change was interesting enough to you for =
me to pursue it further.</div>

</div></div>

--e89a8ff1cefef36c3404e48eb270--

--e89a8ff1cefef36c3804e48eb272
Content-Type: application/octet-stream; 
	name="0001-tls_ctx_load_ca-Improve-certificate-error-messages.patch"
Content-Disposition: attachment; 
	filename="0001-tls_ctx_load_ca-Improve-certificate-error-messages.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hkoe5oq90

RnJvbSBjOWU3ODM3NWUxM2M0N2M3YzI3OWIxZjMxZTg1M2RmZTJiY2M2ZDZhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLbGVlIERpZW5lcyA8a2xlZUBtaXQuZWR1PgpEYXRlOiBTYXQs
IDYgSnVsIDIwMTMgMTc6MDA6MDIgLTA0MDAKU3ViamVjdDogW1BBVENIXSB0bHNfY3R4X2xvYWRf
Y2E6IEltcHJvdmUgY2VydGlmaWNhdGUgZXJyb3IgbWVzc2FnZXMKCklmIGEgQ0EgY2VydGlmaWNh
dGUgZmlsZSBpbmNsdWRlcyBpbnRlcm1lZGlhdGUgY2VydGlmaWNhdGVzLCBhbmQgYW55Cm9mIHRo
ZW0gZmFpbCB0byB2ZXJpZnksIHRoZSBjdXJyZW50IGNvZGUgd2lsbCBmaWxlIHdpdGggIkNhbm5v
dCBsb2FkCkNBIGNlcnRpZmljYXRlIGZpbGUiLiAgSW5zdGVhZCwgZ2VuZXJhdGUgYSBtb3JlIHNw
ZWNpZmljIGVycm9yIG1lc3NhZ2UKaWRlbnRpZnlpbmcgdGhlIHNwZWNpZmljIHN1Yi1jZXJ0aWZp
Y2F0ZShzKSB3aGljaCBkaWQgbm90IHZhbGlkYXRlLgotLS0KIHNyYy9vcGVudnBuL3NzbF9vcGVu
c3NsLmMgfCAgIDI3ICsrKysrKysrKysrKysrKysrKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQs
IDI0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL29wZW52
cG4vc3NsX29wZW5zc2wuYyBiL3NyYy9vcGVudnBuL3NzbF9vcGVuc3NsLmMKaW5kZXggNWRiNzE3
ZC4uYjI5ZDVlMSAxMDA2NDQKLS0tIGEvc3JjL29wZW52cG4vc3NsX29wZW5zc2wuYworKysgYi9z
cmMvb3BlbnZwbi9zc2xfb3BlbnNzbC5jCkBAIC02OTMsNyArNjkzLDcgQEAgdGxzX2N0eF9sb2Fk
X2NhIChzdHJ1Y3QgdGxzX3Jvb3RfY3R4ICpjdHgsIGNvbnN0IGNoYXIgKmNhX2ZpbGUsCiAgIFg1
MDlfU1RPUkUgKnN0b3JlID0gTlVMTDsKICAgWDUwOV9OQU1FICp4biA9IE5VTEw7CiAgIEJJTyAq
aW4gPSBOVUxMOwotICBpbnQgaSwgYWRkZWQgPSAwOworICBpbnQgaSwgYWRkZWQgPSAwLCBwcmV2
ID0gMDsKIAogICBBU1NFUlQoTlVMTCAhPSBjdHgpOwogCkBAIC03MjAsNiArNzIwLDExIEBAIHRs
c19jdHhfbG9hZF9jYSAoc3RydWN0IHRsc19yb290X2N0eCAqY3R4LCBjb25zdCBjaGFyICpjYV9m
aWxlLAogICAgICAgICAgICAgICBpZiAoaW5mby0+Y3JsKQogICAgICAgICAgICAgICAgICAgWDUw
OV9TVE9SRV9hZGRfY3JsIChzdG9yZSwgaW5mby0+Y3JsKTsKIAorICAgICAgICAgICAgICBpZiAo
dGxzX3NlcnZlciAmJiAhaW5mby0+eDUwOSkKKyAgICAgICAgICAgICAgICB7CisgICAgICAgICAg
ICAgICAgICBtc2cgKE1fU1NMRVJSLCAiWDUwOSBuYW1lIHdhcyBtaXNzaW5nIGluIFRMUyBtb2Rl
Iik7CisgICAgICAgICAgICAgICAgfQorCiAgICAgICAgICAgICAgIGlmIChpbmZvLT54NTA5KQog
ICAgICAgICAgICAgICAgIHsKICAgICAgICAgICAgICAgICAgIFg1MDlfU1RPUkVfYWRkX2NlcnQg
KHN0b3JlLCBpbmZvLT54NTA5KTsKQEAgLTc0OSw2ICs3NTQsMTUgQEAgdGxzX2N0eF9sb2FkX2Nh
IChzdHJ1Y3QgdGxzX3Jvb3RfY3R4ICpjdHgsIGNvbnN0IGNoYXIgKmNhX2ZpbGUsCiAgICAgICAg
ICAgICAgICAgICAgICAgc2tfWDUwOV9OQU1FX3B1c2ggKGNlcnRfbmFtZXMsIHhuKTsKICAgICAg
ICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgIH0KKworICAgICAgICAgICAgICBpZiAo
dGxzX3NlcnZlcikgeworICAgICAgICAgICAgICAgIGludCBjbnVtID0gc2tfWDUwOV9OQU1FX251
bSAoY2VydF9uYW1lcyk7CisgICAgICAgICAgICAgICAgaWYgKGNudW0gIT0gKHByZXYgKyAxKSkg
eworICAgICAgICAgICAgICAgICAgbXNnIChNX1dBUk4sICJDYW5ub3QgbG9hZCBDQSBjZXJ0aWZp
Y2F0ZSBmaWxlICVzIChlbnRyeSAlZCBkaWQgbm90IHZhbGlkYXRlKSIsIG5wKGNhX2ZpbGUpLCBh
ZGRlZCk7CisgICAgICAgICAgICAgICAgfQorICAgICAgICAgICAgICAgIHByZXYgPSBjbnVtOwor
ICAgICAgICAgICAgICB9CisKICAgICAgICAgICAgIH0KICAgICAgICAgICBza19YNTA5X0lORk9f
cG9wX2ZyZWUgKGluZm9fc3RhY2ssIFg1MDlfSU5GT19mcmVlKTsKICAgICAgICAgfQpAQCAtNzU2
LDggKzc3MCwxNSBAQCB0bHNfY3R4X2xvYWRfY2EgKHN0cnVjdCB0bHNfcm9vdF9jdHggKmN0eCwg
Y29uc3QgY2hhciAqY2FfZmlsZSwKICAgICAgIGlmICh0bHNfc2VydmVyKQogICAgICAgICBTU0xf
Q1RYX3NldF9jbGllbnRfQ0FfbGlzdCAoY3R4LT5jdHgsIGNlcnRfbmFtZXMpOwogCi0gICAgICBp
ZiAoIWFkZGVkIHx8ICh0bHNfc2VydmVyICYmIHNrX1g1MDlfTkFNRV9udW0gKGNlcnRfbmFtZXMp
ICE9IGFkZGVkKSkKLSAgICAgICAgbXNnIChNX1NTTEVSUiwgIkNhbm5vdCBsb2FkIENBIGNlcnRp
ZmljYXRlIGZpbGUgJXMiLCBucChjYV9maWxlKSk7CisgICAgICBpZiAoIWFkZGVkKQorICAgICAg
ICBtc2cgKE1fU1NMRVJSLCAiQ2Fubm90IGxvYWQgQ0EgY2VydGlmaWNhdGUgZmlsZSAlcyAobm8g
ZW50cmllcyB3ZXJlIHJlYWQpIiwgbnAoY2FfZmlsZSkpOworCisgICAgICBpZiAodGxzX3NlcnZl
cikgeworICAgICAgICBpbnQgY251bSA9IHNrX1g1MDlfTkFNRV9udW0gKGNlcnRfbmFtZXMpOwor
ICAgICAgICBpZiAoY251bSAhPSBhZGRlZCkKKyAgICAgICAgICBtc2cgKE1fU1NMRVJSLCAiQ2Fu
bm90IGxvYWQgQ0EgY2VydGlmaWNhdGUgZmlsZSAlcyAob25seSAlZCBvZiAlZCBlbnRyaWVzIHdl
cmUgdmFsaWQgWDUwOSBuYW1lcykiLCBucChjYV9maWxlKSwgY251bSwgYWRkZWQpOworICAgICAg
fQorCiAgICAgICBpZiAoaW4pCiAgICAgICAgIEJJT19mcmVlIChpbik7CiAgICAgfQotLSAKMS43
LjEwLjQKCg==
--e89a8ff1cefef36c3804e48eb272--

