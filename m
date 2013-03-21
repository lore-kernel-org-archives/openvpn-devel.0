From: Steffan Karger <steffan.karger@...1435...>
Date: Thu, 21 Mar 2013 18:41:04 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B9013B9050666@...1436...>
References: <1363624652-7001-1-git-send-email-steffan.karger@...1435...>
	<1363624652-7001-5-git-send-email-steffan.karger@...1435...>
	<20130320085250.GA953@...1296...>
In-Reply-To: <20130320085250.GA953@...1296...>
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_002_1CED409804E2164C8104F9E623B08B9013B9050666FOXDFT02FOXlo_"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 4/5] Config compatibility patch. Added
 translate_cipher_name.
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

--_002_1CED409804E2164C8104F9E623B08B9013B9050666FOXDFT02FOXlo_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Attached an updated version of the patch, which should resolve the issue. I=
t passes t_client tests.

-Steffan

-----Original Message-----
From: Gert Doering [mailto:gert@...1296...]=20
Sent: woensdag 20 maart 2013 9:53
To: Steffan Karger
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] [PATCH 4/5] Config compatibility patch. Added =
translate_cipher_name.

Hi,

On Mon, Mar 18, 2013 at 05:37:31PM +0100, steffan.karger@...1435... wrote:
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -6223,7 +6223,7 @@ add_option (struct options *options,
>      {
>        VERIFY_PERMISSION (OPT_P_CRYPTO);
>        options->ciphername_defined =3D true;
> -      options->ciphername =3D p[1];
> +      options->ciphername =3D translate_cipher_name(p[1]);
>        if (streq (options->ciphername, "none"))
>  	{
>  	  options->ciphername_defined =3D false;

Uh.  NAK, unfortunately, because while this should work for the actual ciph=
er translation, it fails OCC...

Tue Mar 19 15:45:01 2013 WARNING: 'cipher' is used inconsistently, local=3D=
'cipher BLOWFISH-CBC', remote=3D'cipher BF-CBC'

... incidentially, OCC also gives a hint why the interop test failed...

Tue Mar 19 15:45:01 2013 WARNING: 'keysize' is used inconsistently, local=
=3D'keysize 32', remote=3D'keysize 128'
Tue Mar 19 15:45:01 2013 Data Channel Encrypt: Cipher 'BLOWFISH-CBC' initia=
lized with 32 bit key

"wut?"

gert
--
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--_002_1CED409804E2164C8104F9E623B08B9013B9050666FOXDFT02FOXlo_
Content-Type: application/octet-stream;
	name="0004-Config-compatibility-patch.-Added-translate_cipher_n.patch"
Content-Description: 0004-Config-compatibility-patch.-Added-translate_cipher_n.patch
Content-Disposition: attachment;
	filename="0004-Config-compatibility-patch.-Added-translate_cipher_n.patch";
	size=5012; creation-date="Thu, 21 Mar 2013 17:38:48 GMT";
	modification-date="Thu, 21 Mar 2013 17:29:37 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlZjkzMWM0MTM2ZWRkY2E0MDdlN2EyMjRlYTE2OWU2YTAzNmZiNjNiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGVmZmFuIEthcmdlciA8c3RlZmZhbi5rYXJnZXJAZm94LWl0
LmNvbT4KRGF0ZTogVGh1LCAyMSBNYXIgMjAxMyAxMjo1MzoxNCArMDEwMApTdWJqZWN0OiBbUEFU
Q0ggNC82XSBDb25maWcgY29tcGF0aWJpbGl0eSBwYXRjaC4gQWRkZWQgdHJhbnNsYXRlX2NpcGhl
cl9uYW1lLgoKQWRkZWQgdHJhbnNsYXRlX2NpcGhlciBuYW1lIHRvIGNyeXB0b19vcGVuc3NsLmMg
YW5kIGNyeXB0b19wb2xhcnNzbC5jCnRvIHRyYW5zbGF0ZSBiZXR3ZWVuIE9wZW5WUE4oL09wZW5T
U0wpIGFuZCBQb2xhclNTTCBkYXRhIGNoYW5uZWwKY2lwaGVyIGFsZ29yaXRobSBuYW1lcy4gT3Bl
blNTTCBkb2VzIG5vdCByZXF1aXJlIGFueSB0cmFuc2xhdGluZywKUG9sYXJTU0wgZG9lcyBmb3Ig
YSBzbWFsbCBudW1iZXIgb2YgYWxnb3JpdGhtcy4gVGhpcyBpbXByb3ZlcyBvbgpjb25maWcgZmls
ZSBjb21wYXRpYmlsaXR5IGJldHdlZW4gdGhlIE9wZW5TU0wgYW5kIFBvbGFyU1NMIGJ1aWxkcy4K
ClNpZ25lZC1vZmYtYnk6IFN0ZWZmYW4gS2FyZ2VyIDxzdGVmZmFuLmthcmdlckBmb3gtaXQuY29t
PgotLS0KIHNyYy9vcGVudnBuL2NyeXB0by5jICAgICAgICAgIHwgICAgMiArLQogc3JjL29wZW52
cG4vY3J5cHRvX2JhY2tlbmQuaCAgfCAgIDEyICsrKysrKysrKysKIHNyYy9vcGVudnBuL2NyeXB0
b19vcGVuc3NsLmMgIHwgICAxMiArKysrKysrKysrCiBzcmMvb3BlbnZwbi9jcnlwdG9fcG9sYXJz
c2wuYyB8ICAgNTIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0KIDQg
ZmlsZXMgY2hhbmdlZCwgNzUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9zcmMvb3BlbnZwbi9jcnlwdG8uYyBiL3NyYy9vcGVudnBuL2NyeXB0by5jCmluZGV4IGFj
MmVlY2QuLjQwNWMwYWEgMTAwNjQ0Ci0tLSBhL3NyYy9vcGVudnBuL2NyeXB0by5jCisrKyBiL3Ny
Yy9vcGVudnBuL2NyeXB0by5jCkBAIC00MDEsNyArNDAxLDcgQEAgaW5pdF9rZXlfdHlwZSAoc3Ry
dWN0IGtleV90eXBlICprdCwgY29uc3QgY2hhciAqY2lwaGVybmFtZSwKICAgQ0xFQVIgKCprdCk7
CiAgIGlmIChjaXBoZXJuYW1lICYmIGNpcGhlcm5hbWVfZGVmaW5lZCkKICAgICB7Ci0gICAgICBr
dC0+Y2lwaGVyID0gY2lwaGVyX2t0X2dldCAoY2lwaGVybmFtZSk7CisgICAgICBrdC0+Y2lwaGVy
ID0gY2lwaGVyX2t0X2dldCAodHJhbnNsYXRlX2NpcGhlcl9uYW1lX2Zyb21fb3BlbnZwbihjaXBo
ZXJuYW1lKSk7CiAgICAgICBrdC0+Y2lwaGVyX2xlbmd0aCA9IGNpcGhlcl9rdF9rZXlfc2l6ZSAo
a3QtPmNpcGhlcik7CiAgICAgICBpZiAoa2V5c2l6ZSA+IDAgJiYga2V5c2l6ZSA8PSBNQVhfQ0lQ
SEVSX0tFWV9MRU5HVEgpCiAJa3QtPmNpcGhlcl9sZW5ndGggPSBrZXlzaXplOwpkaWZmIC0tZ2l0
IGEvc3JjL29wZW52cG4vY3J5cHRvX2JhY2tlbmQuaCBiL3NyYy9vcGVudnBuL2NyeXB0b19iYWNr
ZW5kLmgKaW5kZXggMWVhYzYxMS4uNWFlNDdlNiAxMDA2NDQKLS0tIGEvc3JjL29wZW52cG4vY3J5
cHRvX2JhY2tlbmQuaAorKysgYi9zcmMvb3BlbnZwbi9jcnlwdG9fYmFja2VuZC5oCkBAIC02Myw2
ICs2MywxOCBAQCB2b2lkIGNyeXB0b19pbml0X2xpYl9lbmdpbmUgKGNvbnN0IGNoYXIgKmVuZ2lu
ZV9uYW1lKTsKIHZvaWQgY3J5cHRvX2luaXRfZG1hbGxvYyAodm9pZCk7CiAjZW5kaWYgLyogRE1B
TExPQyAqLwogCisvKioKKyAqIFRyYW5zbGF0ZSBhIGRhdGEgY2hhbm5lbCBjaXBoZXIgbmFtZSBm
cm9tIHRoZSBPcGVuVlBOIGNvbmZpZyBmaWxlCisgKiAnbGFuZ3VhZ2UnIHRvIHRoZSBjcnlwdG8g
bGlicmFyeSBzcGVjaWZpYyBuYW1lLgorICovCitjb25zdCBjaGFyICogdHJhbnNsYXRlX2NpcGhl
cl9uYW1lX2Zyb21fb3BlbnZwbiAoY29uc3QgY2hhciAqY2lwaGVyX25hbWUpOworCisvKioKKyAq
IFRyYW5zbGF0ZSBhIGRhdGEgY2hhbm5lbCBjaXBoZXIgbmFtZSBmcm9tIHRoZSBjcnlwdG8gbGli
cmFyeSBzcGVjaWZpYyBuYW1lCisgKiB0byB0aGUgT3BlblZQTiBjb25maWcgZmlsZSAnbGFuZ3Vh
Z2UnLgorICovCitjb25zdCBjaGFyICogdHJhbnNsYXRlX2NpcGhlcl9uYW1lX2Zyb21fb3BlbnZw
biAoY29uc3QgY2hhciAqY2lwaGVyX25hbWUpOworCiB2b2lkIHNob3dfYXZhaWxhYmxlX2NpcGhl
cnMgKHZvaWQpOwogCiB2b2lkIHNob3dfYXZhaWxhYmxlX2RpZ2VzdHMgKHZvaWQpOwpkaWZmIC0t
Z2l0IGEvc3JjL29wZW52cG4vY3J5cHRvX29wZW5zc2wuYyBiL3NyYy9vcGVudnBuL2NyeXB0b19v
cGVuc3NsLmMKaW5kZXggNTM0MjUwMi4uMjFkMTc2MiAxMDA2NDQKLS0tIGEvc3JjL29wZW52cG4v
Y3J5cHRvX29wZW5zc2wuYworKysgYi9zcmMvb3BlbnZwbi9jcnlwdG9fb3BlbnNzbC5jCkBAIC0y
ODEsNiArMjgxLDE4IEBAIGNyeXB0b19pbml0X2RtYWxsb2MgKHZvaWQpCiB9CiAjZW5kaWYgLyog
RE1BTExPQyAqLwogCitjb25zdCBjaGFyICoKK3RyYW5zbGF0ZV9jaXBoZXJfbmFtZV9mcm9tX29w
ZW52cG4gKGNvbnN0IGNoYXIgKmNpcGhlcl9uYW1lKSB7CisgIC8vIE9wZW5TU0wgZG9lc24ndCBy
ZXF1aXJlIGFueSB0cmFuc2xhdGlvbgorICByZXR1cm4gY2lwaGVyX25hbWU7Cit9CisKK2NvbnN0
IGNoYXIgKgordHJhbnNsYXRlX2NpcGhlcl9uYW1lX3RvX29wZW52cG4gKGNvbnN0IGNoYXIgKmNp
cGhlcl9uYW1lKSB7CisgIC8vIE9wZW5TU0wgZG9lc24ndCByZXF1aXJlIGFueSB0cmFuc2xhdGlv
bgorICByZXR1cm4gY2lwaGVyX25hbWU7Cit9CisKIHZvaWQKIHNob3dfYXZhaWxhYmxlX2NpcGhl
cnMgKCkKIHsKZGlmZiAtLWdpdCBhL3NyYy9vcGVudnBuL2NyeXB0b19wb2xhcnNzbC5jIGIvc3Jj
L29wZW52cG4vY3J5cHRvX3BvbGFyc3NsLmMKaW5kZXggZWQ5ZGI1My4uMWYyN2Q2YyAxMDA2NDQK
LS0tIGEvc3JjL29wZW52cG4vY3J5cHRvX3BvbGFyc3NsLmMKKysrIGIvc3JjL29wZW52cG4vY3J5
cHRvX3BvbGFyc3NsLmMKQEAgLTk0LDYgKzk0LDUzIEBAIGNyeXB0b19pbml0X2RtYWxsb2MgKHZv
aWQpCiB9CiAjZW5kaWYgLyogRE1BTExPQyAqLwogCit0eXBlZGVmIHN0cnVjdCB7IGNvbnN0IGNo
YXIgKiBvcGVudnBuX25hbWU7IGNvbnN0IGNoYXIgKiBwb2xhcnNzbF9uYW1lOyB9IGNpcGhlcl9u
YW1lX3BhaXI7CitjaXBoZXJfbmFtZV9wYWlyIGNpcGhlcl9uYW1lX3RyYW5zbGF0aW9uX3RhYmxl
W10gPSB7CisgICAgeyAiQkYtQ0JDIiwgIkJMT1dGSVNILUNCQyIgfSwKKyAgICB7ICJCRi1DRkIi
LCAiQkxPV0ZJU0gtQ0ZCNjQiIH0sCisgICAgeyAiQ0FNRUxMSUEtMTI4LUNGQiIsICJDQU1FTExJ
QS0xMjgtQ0ZCMTI4IiB9LAorICAgIHsgIkNBTUVMTElBLTE5Mi1DRkIiLCAiQ0FNRUxMSUEtMTky
LUNGQjEyOCIgfSwKKyAgICB7ICJDQU1FTExJQS0yNTYtQ0ZCIiwgIkNBTUVMTElBLTI1Ni1DRkIx
MjgiIH0KK307CisKK2NvbnN0IGNpcGhlcl9uYW1lX3BhaXIgKgorZ2V0X2NpcGhlcl9uYW1lX3Bh
aXIoY29uc3QgY2hhciAqY2lwaGVyX25hbWUpIHsKKyAgY2lwaGVyX25hbWVfcGFpciAqcGFpcjsK
KyAgc2l6ZV90IGkgPSAwOworCisgIC8qIFNlYXJjaCBmb3IgYSBjaXBoZXIgbmFtZSB0cmFuc2xh
dGlvbiAqLworICBmb3IgKDsgaSA8IHNpemVvZiAoY2lwaGVyX25hbWVfdHJhbnNsYXRpb25fdGFi
bGUpIC8gc2l6ZW9mICgqY2lwaGVyX25hbWVfdHJhbnNsYXRpb25fdGFibGUpOyBpKyspCisgICAg
eworICAgICAgcGFpciA9ICZjaXBoZXJfbmFtZV90cmFuc2xhdGlvbl90YWJsZVtpXTsKKyAgICAg
IGlmICgwID09IHN0cmNtcCAoY2lwaGVyX25hbWUsIHBhaXItPm9wZW52cG5fbmFtZSkgfHwKKwkg
IDAgPT0gc3RyY21wIChjaXBoZXJfbmFtZSwgcGFpci0+cG9sYXJzc2xfbmFtZSkpCisJICByZXR1
cm4gcGFpcjsKKyAgICB9CisKKyAgLyogTm90aGluZyBmb3VuZCwgcmV0dXJuIG51bGwgKi8KKyAg
cmV0dXJuIE5VTEw7Cit9CisKK2NvbnN0IGNoYXIgKgordHJhbnNsYXRlX2NpcGhlcl9uYW1lX2Zy
b21fb3BlbnZwbiAoY29uc3QgY2hhciAqY2lwaGVyX25hbWUpIHsKKyAgY29uc3QgY2lwaGVyX25h
bWVfcGFpciAqcGFpciA9IGdldF9jaXBoZXJfbmFtZV9wYWlyKGNpcGhlcl9uYW1lKTsKKworICBp
ZiAoTlVMTCA9PSBwYWlyKQorICAgIHJldHVybiBjaXBoZXJfbmFtZTsKKworICByZXR1cm4gcGFp
ci0+cG9sYXJzc2xfbmFtZTsKK30KKworY29uc3QgY2hhciAqCit0cmFuc2xhdGVfY2lwaGVyX25h
bWVfdG9fb3BlbnZwbiAoY29uc3QgY2hhciAqY2lwaGVyX25hbWUpIHsKKyAgY29uc3QgY2lwaGVy
X25hbWVfcGFpciAqcGFpciA9IGdldF9jaXBoZXJfbmFtZV9wYWlyKGNpcGhlcl9uYW1lKTsKKwor
ICBpZiAoTlVMTCA9PSBwYWlyKQorICAgIHJldHVybiBjaXBoZXJfbmFtZTsKKworICByZXR1cm4g
cGFpci0+b3BlbnZwbl9uYW1lOworfQorCiB2b2lkCiBzaG93X2F2YWlsYWJsZV9jaXBoZXJzICgp
CiB7CkBAIC0xMTQsNyArMTYxLDcgQEAgc2hvd19hdmFpbGFibGVfY2lwaGVycyAoKQogCiAgICAg
ICBpZiAoaW5mbyAmJiBpbmZvLT5tb2RlID09IFBPTEFSU1NMX01PREVfQ0JDKQogCXByaW50ZiAo
IiVzICVkIGJpdCBkZWZhdWx0IGtleVxuIiwKLQkJaW5mby0+bmFtZSwgY2lwaGVyX2t0X2tleV9z
aXplKGluZm8pICogOCk7CisJCWNpcGhlcl9rdF9uYW1lKGluZm8pLCBjaXBoZXJfa3Rfa2V5X3Np
emUoaW5mbykgKiA4KTsKIAogICAgICAgY2lwaGVycysrOwogICAgIH0KQEAgLTMzMSw3ICszNzgs
OCBAQCBjaXBoZXJfa3RfbmFtZSAoY29uc3QgY2lwaGVyX2luZm9fdCAqY2lwaGVyX2t0KQogewog
ICBpZiAoTlVMTCA9PSBjaXBoZXJfa3QpCiAgICAgcmV0dXJuICJbbnVsbC1jaXBoZXJdIjsKLSAg
cmV0dXJuIGNpcGhlcl9rdC0+bmFtZTsKKworICByZXR1cm4gdHJhbnNsYXRlX2NpcGhlcl9uYW1l
X3RvX29wZW52cG4oY2lwaGVyX2t0LT5uYW1lKTsKIH0KIAogaW50Ci0tIAoxLjcuOS41Cgo=

--_002_1CED409804E2164C8104F9E623B08B9013B9050666FOXDFT02FOXlo_--

