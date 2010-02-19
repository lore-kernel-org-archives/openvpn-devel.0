Message-ID: <4B7E71A5.3020806@...1114...>
Date: Fri, 19 Feb 2010 12:10:29 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040809090209050400080802"
Subject: [Openvpn-devel] [IPv6] Merge conflicts in mroute.c (was: Re:
 openvpn-testing tree available)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: JuanJo Ciarlante <jjo+ml@...410...>, Gert Doering <gert@...1296...>
Cc: Openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------040809090209050400080802
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi guys!
On 18/02/10 22:45, JuanJo Ciarlante wrote:
> On Wed, Feb 17, 2010 at 6:46 PM, JuanJo Ciarlante <jjo+ml@...410...>
wrote:
>
>> I still need to do some touches for allmerged, as
>> we conflict w/ Gert's IPv6 patch on a mroute.c chunk
>> IIRC.
>

Even though I know you both have told me that there would be a merge
conflict in mroute.c, I decided to put it on the mailing list -
hopefully to get an open discussion about it!

I've attached the merge conflict.  It would be great if you could sort
this out soon.  Then I'll get both of your trees into the allmerged
branch ASAP.  Right now only Gert's code is in the allmerged branch.

What I do see might be a challenge (without knowing the code in
details), is that JJO's code is using #ifdef, while Gert's code is not.
 With a conflict in mroute_addr_print_ex(), which includes an #ifdef I
see a potential disaster here.

Personally, I would like to evaluate Gert's patches to see if they could
be #ifdef'ed.  Then both IPv6 branches can both use USE_PF_INET6 to
enable or disable the IPv6 support.  I have not studied these patches,
so I don't know how doable that is.  And this is my personal opinion, I
don't mean to instruct anyone into a direction.  I will let you guys
find the proper direction.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkt+caIACgkQDC186MBRfrr5ZACgqLxiXN70pCOGY0zyvQGSCpo6
n2EAn1le6hzZe4aThLfAKvYwK7d3CPSG
=e7yX
-----END PGP SIGNATURE-----

--------------040809090209050400080802
Content-Type: text/plain;
 name="ipv6-merge-conflict.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="ipv6-merge-conflict.txt"

ZGlmZiAtLWNjIG1yb3V0ZS5jCmluZGV4IGI3ZTNlOWMsYmJhODg5ZC4uMDAwMDAwMAotLS0g
YS9tcm91dGUuYworKysgYi9tcm91dGUuYwpAQEAgLTM5OSwyNCAtMzU5LDQ3ICs0MjEsNjgg
QEBAIG1yb3V0ZV9hZGRyX3ByaW50X2V4IChjb25zdCBzdHJ1Y3QgbXJvdQogIAkgIH0KICAJ
ICBicmVhazsKICAJY2FzZSBNUl9BRERSX0lQVjY6CisrPDw8PDw8PCBIRUFECiArCSAgewog
KwkgICAgYnVmX3ByaW50ZiAoJm91dCwgIiVzIiwKICsJCSAgcHJpbnRfaW42X2FkZHIoICoo
c3RydWN0IGluNl9hZGRyKikmbWFkZHIuYWRkciwgMCwgZ2MpKTsgCiArCSAgICBpZiAobWFk
ZHIudHlwZSAmIE1SX1dJVEhfTkVUQklUUykKICsJICAgICAgewogKwkJYnVmX3ByaW50ZiAo
Jm91dCwgIi8lZCIsIG1hZGRyLm5ldGJpdHMpOwogKwkgICAgICB9CiArCSAgICB9CiArCSAg
ICBicmVhazsKICsJICBkZWZhdWx0OgogKwkgICAgYnVmX3ByaW50ZiAoJm91dCwgIlVOS05P
V04iKTsgCiArCSAgICBicmVhazsKICsJICB9CiArCXJldHVybiBCU1RSICgmb3V0KTsKICsg
ICAgICB9CiArICAgIGVsc2UKICsgICAgICByZXR1cm4gIltOVUxMXSI7CiArICB9CisrPT09
PT09PQorICNpZmRlZiBVU0VfUEZfSU5FVDYKKyAgICAgICAgICAgeworIAkgICAgc3RydWN0
IGJ1ZmZlciBidWY7CisgCSAgICBzdHJ1Y3Qgc29ja2FkZHJfaW42IHNpbjY7CisgCSAgICBp
bnQgcG9ydDsKKyAJICAgIGNoYXIgYnVmNltJTkVUNl9BRERSU1RSTEVOXSA9ICIiOworIAkg
ICAgQ0xFQVIoc2luNik7CisgCSAgICBzaW42LnNpbjZfZmFtaWx5ID0gQUZfSU5FVDY7Cisg
CSAgICBidWZfc2V0X3JlYWQgKCZidWYsIG1hZGRyLmFkZHIsIG1hZGRyLmxlbik7CisgICAg
ICAgICAgICAgaWYgKGJ1Zl9yZWFkKCZidWYsICZzaW42LnNpbjZfYWRkciwgc2l6ZW9mIChz
aW42LnNpbjZfYWRkcikpKQorICAgICAgICAgICAgIHsKKyAgICAgICAgICAgICAgIGlmIChn
ZXRuYW1laW5mbygoc3RydWN0IHNvY2thZGRyICopJnNpbjYsIHNpemVvZiAoc3RydWN0IHNv
Y2thZGRyX2luNiksCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBi
dWY2LCBzaXplb2YgKGJ1ZjYpLCBOVUxMLCAwLCBOSV9OVU1FUklDSE9TVCkgIT0gMCkKKyAg
ICAgICAgICAgICAgICAgeworICAgICAgICAgICAgICAgICAgIGJ1Zl9wcmludGYgKCZvdXQs
ICJNUl9BRERSX0lQVjYgZ2V0bmFtZWluZm8oKSBlcnIiKTsKKyAgICAgICAgICAgICAgICAg
ICBicmVhazsKKyAJCX0KKyAgICAgICAgICAgICAgIGJ1Zl9wdXRzICgmb3V0LCBidWY2KTsK
KyAJICAgICAgaWYgKG1hZGRyLnR5cGUgJiBNUl9XSVRIX05FVEJJVFMpCisgCSAgICAgICAg
YnVmX3ByaW50ZiAoJm91dCwgIi8lZCIsIG1hZGRyLm5ldGJpdHMpOworICAgICAgICAgICAg
ICAgaWYgKG1hZGRyLnR5cGUgJiBNUl9XSVRIX1BPUlQpCisgICAgICAgICAgICAgICAgIHsK
KyAgICAgICAgICAgICAgICAgICBwb3J0ID0gYnVmX3JlYWRfdTE2ICgmYnVmKTsKKyAgICAg
ICAgICAgICAgICAgICBpZiAocG9ydCA+PSAwKQorICAgICAgICAgICAgICAgICAgICAgYnVm
X3ByaW50ZiAoJm91dCwgIjolZCIsIHBvcnQpOworICAgICAgICAgICAgICAgICB9CisgCSAg
ICB9CisgICAgICAgICAgIH0KKyAjZWxzZSAvKiBvbGQsIHByZSBVU0VfUEZfSU5FVDYgY29k
ZSAqLworIAkgIGJ1Zl9wcmludGYgKCZvdXQsICJJUFY2Iik7IAorICNlbmRpZgorIAkgIGJy
ZWFrOworIAlkZWZhdWx0OgorIAkgIGJ1Zl9wcmludGYgKCZvdXQsICJVTktOT1dOIik7IAor
IAkgIGJyZWFrOworIAl9CisgICAgICAgcmV0dXJuIEJTVFIgKCZvdXQpOworICAgICB9Cisg
ICBlbHNlCisgICAgIHJldHVybiAiW05VTExdIjsKKyB9CisrPj4+Pj4+PiBmZWF0X2lwdjZf
dHJhbnNwb3J0CiAgCiAgLyoKICAgKiBtcm91dGVfaGVscGVyJ3MgbWFpbiBqb2IgaXMga2Vl
cGluZyB0cmFjayBvZgo=
--------------040809090209050400080802--

