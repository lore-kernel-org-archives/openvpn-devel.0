MIME-Version: 1.0
In-Reply-To: <CAA1AbxKk7Mb-s823PprMKL-xVCoD2qQa5EEQNED_F6YDLRTNfw@...278...>
References: <1456993146-63968-1-git-send-email-james@...515...>
	<1456993146-63968-6-git-send-email-james@...515...>
	<CAA1AbxKk7Mb-s823PprMKL-xVCoD2qQa5EEQNED_F6YDLRTNfw@...278...>
From: Steffan Karger <steffan@...1856...>
Date: Mon, 4 Apr 2016 22:01:06 +0200
Message-ID: <CAA1AbxL=QYUy6N+jKgxVVuftmF=75mSEz3rYUbisT245UfB5Dg@...278...>
Content-Type: multipart/mixed; boundary=001a113dc9a296f89e052fae3134
Subject: Re: [Openvpn-devel] [PATCH 06/10] PolarSSL x509_get_sha1_hash now
 returns correct SHA1 fingerprint.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Yonan <james@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a113dc9a296f89e052fae3134
Content-Type: text/plain; charset=UTF-8

Hi list,

I just noticed I sent my previous reply only to James, instead of to
the list.  See below.

On Sat, Mar 5, 2016 at 10:23 AM, Steffan Karger <steffan@...1856...> wrote:
> Hi James,
>
> On Thu, Mar 3, 2016 at 9:19 AM, James Yonan <james@...515...> wrote:
>> Signed-off-by: James Yonan <james@...515...>
>> ---
>>  src/openvpn/ssl_verify_polarssl.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
>> index e87d2e2..9d0d086 100644
>> --- a/src/openvpn/ssl_verify_polarssl.c
>> +++ b/src/openvpn/ssl_verify_polarssl.c
>> @@ -176,7 +176,7 @@ unsigned char *
>>  x509_get_sha1_hash (x509_crt *cert, struct gc_arena *gc)
>>  {
>>    unsigned char *sha1_hash = gc_malloc(SHA_DIGEST_LENGTH, false, gc);
>> -  sha1(cert->tbs.p, cert->tbs.len, sha1_hash);
>> +  sha1(cert->raw.p, cert->raw.len, sha1_hash);
>>    return sha1_hash;
>>  }
>
> I agree with the change, but this needs a bit more explanation in the
> commit msg and a note in Changes.rst, because it changes
> externally-visible behaviour for PolarSSL/mbedTLS builds  (at least
> for --verify-hash, maybe more?).
>
> It took me a bit of time to figure out *why* this is the correct, so
> I'll jot down my findings here.
>
> At first, this didn't not look correct to me.  A certificate digest is
> calculated over the TBSCertificate/cert.tbs (TBS = To Be Signed), not
> the Certificate/cert.raw field. This must be, because the Certificate
> field contains the TBSCertificate and the signatureValue (which
> depends on the hash).  Also see section 4.1 of RFC5280
> (https://tools.ietf.org/html/rfc5280#page-16).
>
> However, a certificate *fingerprint* (i.e. the output op openssl x509
> -fingerprint) is calculated over the (contents of the) Certificate
> field.  And this is what this function should be doing.  To make this
> more clear I suggest renaming this function to
> x509_get_sha1_fingerprint(), and updating the doxygen.
>
> -Steffan

So, since Gert is looking into applying these, ACK to the code, and
attached an updated patch with suggestions for the commit msg and
Changes.rst.

-Steffan

--001a113dc9a296f89e052fae3134
Content-Type: text/x-diff; charset=US-ASCII; 
	name="0001-PolarSSL-x509_get_sha1_hash-now-returns-correct-SHA1.patch"
Content-Disposition: attachment; 
	filename="0001-PolarSSL-x509_get_sha1_hash-now-returns-correct-SHA1.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_immf9hsf0

RnJvbSA2ZjM3MmJlNDQ5MjZmNTU1ZWM5Zjg2MDc0NmRkYThjNWUwMDY0MGY4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGVmZmFuIEthcmdlciA8c3RlZmZhbkBrYXJnZXIubWU+CkRh
dGU6IE1vbiwgNCBBcHIgMjAxNiAyMTo1OTozOCArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIFBvbGFy
U1NMIHg1MDlfZ2V0X3NoYTFfaGFzaCBub3cgcmV0dXJucyBjb3JyZWN0IFNIQTEKIGZpbmdlcnBy
aW50LgoKNTA5X2dldF9zaGExX2hhc2goKSBpcyBzdXBwb3NlZCB0byByZXR1cm4gdGhlIGNlcnRp
ZmljYXRlIGZpbmdlcnByaW50LAp3aGljaCBpcyB0aGUgaGFzaCBvZiB0aGUgZW50aXJlIGNlcnRp
ZmljYXRlIC0gaW5jbHVkaW5nIHRoZSBzaWduYXR1cmUgLQphbmQgbm90IGp1c3QgdGhlICd0byBi
ZSBzaWduZWQnIGRhdGEgKGNlcnQtPnRicyBpbiBwb2xhcnNzbCkuCgpUaGlzIGNoYW5nZXMgZXh0
ZXJuYWxseSB2aXNpYmxlIGJlaGF2aW9yIGZvciBwb2xhcnNzbCBidWlsZHM6IGl0IHdpbGwKY2hh
bmdlIHRoZSB2YWx1ZSBvZiB0aGUgdGxzX2RpZ2VzdF9OIHZhbHVlcyBleHBvcnRlZCB0byB0aGUg
ZW52aXJvbm1lbnQKZm9yIHNjcmlwdHMuCgp2MiBTdGVmZmFuIEthcmdlcjogYWRkZWQgY29tbWl0
IG1lc3NhZ2UgYW5kIENoYW5nZXMucnN0IGVudHJ5LgogICAgICAgICAgICAgICAgICAgQ29kZSB1
bmNoYW5nZWQgZnJvbSB2MSBieSBKYW1lcy4KClNpZ25lZC1vZmYtYnk6IEphbWVzIFlvbmFuIDxq
YW1lc0BvcGVudnBuLm5ldD4KU2lnbmVkLW9mZi1ieTogU3RlZmZhbiBLYXJnZXIgPHN0ZWZmYW5A
a2FyZ2VyLm1lPgotLS0KIENoYW5nZXMucnN0ICAgICAgICAgICAgICAgICAgICAgICB8IDYgKysr
KystCiBzcmMvb3BlbnZwbi9zc2xfdmVyaWZ5X3BvbGFyc3NsLmMgfCAyICstCiAyIGZpbGVzIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9DaGFu
Z2VzLnJzdCBiL0NoYW5nZXMucnN0CmluZGV4IGFmNzBkMTQuLmNiOTAwZGMgMTAwNjQ0Ci0tLSBh
L0NoYW5nZXMucnN0CisrKyBiL0NoYW5nZXMucnN0CkBAIC02Myw3ICs2Myw2IEBAIFVzZXItdmlz
aWJsZSBDaGFuZ2VzCiAgIEluIC0tc3RhdGljIG1vZGUgY29ubmVjdC10aW1lb3V0IHNwZWNpZmll
cyB0aGUgdGltZW91dCBmb3IgVENQIGFuZAogICBwcm94eSBjb25uZWN0aW9uIGVzdGFibGlzaG1l
bnQKIAotCiAtIGNvbm5lY3QtcmV0cnkgbm93IHNwZWNpZmllcyB0aGUgbWF4aW11bSBudW1iZXIg
b2YgdW5zdWNlc3NmdWxseQogICB0cnlpbmcgYWxsIHJlbW90ZS9jb25uZWN0aW9uIGVudHJpZXMg
YmVmb3JlIGV4aXRpbmcuCiAKQEAgLTg2LDYgKzg1LDExIEBAIFVzZXItdmlzaWJsZSBDaGFuZ2Vz
CiAtIFJlbW92ZWQgLS1lbmFibGUtcGFzc3dvcmQtc2F2ZSBmcm9tIGNvbmZpZ3VyZS4gVGhpcyBv
cHRpb24gaXMgbm93CiAgIGFsd2F5cyBlbmFibGVkLgogCistIFBvbGFyU1NMIGJ1aWxkczogY2hh
bmdlZCB0aGUgdGxzX2RpZ2VzdF9OIHZhbHVlcyBleHBvcnRlZCB0byB0aGUgc2NyaXB0CisgIGVu
dmlyb25tZW50IHRvIGJlIGVxdWFsIHRvIHRoZSBvbmVzIGV4cG9ydGVkIGJ5IE9wZW5TU0wgYnVp
bGRzLCBuYW1lbHkKKyAgdGhlIGNlcnRpZmljYXRlIGZpbmdlcnByaW50ICh3YXMgdGhlIGhhc2gg
b2YgdGhlICd0byBiZSBzaWduZWQnIGRhdGEpLgorCisKIE1haW50YWluZXItdmlzaWJsZSBjaGFu
Z2VzCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogLSBPcGVuVlBOIG5vIGxvbmdlciBzdXBw
b3J0cyBidWlsZGluZyB3aXRoIGNyeXB0byBzdXBwb3J0LCBidXQgd2l0aG91dCBUTFMKZGlmZiAt
LWdpdCBhL3NyYy9vcGVudnBuL3NzbF92ZXJpZnlfcG9sYXJzc2wuYyBiL3NyYy9vcGVudnBuL3Nz
bF92ZXJpZnlfcG9sYXJzc2wuYwppbmRleCBhMmU2YThlLi5iZjFhNmVjIDEwMDY0NAotLS0gYS9z
cmMvb3BlbnZwbi9zc2xfdmVyaWZ5X3BvbGFyc3NsLmMKKysrIGIvc3JjL29wZW52cG4vc3NsX3Zl
cmlmeV9wb2xhcnNzbC5jCkBAIC0xNzUsNyArMTc1LDcgQEAgdW5zaWduZWQgY2hhciAqCiB4NTA5
X2dldF9zaGExX2hhc2ggKHg1MDlfY3J0ICpjZXJ0LCBzdHJ1Y3QgZ2NfYXJlbmEgKmdjKQogewog
ICB1bnNpZ25lZCBjaGFyICpzaGExX2hhc2ggPSBnY19tYWxsb2MoU0hBX0RJR0VTVF9MRU5HVEgs
IGZhbHNlLCBnYyk7Ci0gIHNoYTEoY2VydC0+dGJzLnAsIGNlcnQtPnRicy5sZW4sIHNoYTFfaGFz
aCk7CisgIHNoYTEoY2VydC0+cmF3LnAsIGNlcnQtPnJhdy5sZW4sIHNoYTFfaGFzaCk7CiAgIHJl
dHVybiBzaGExX2hhc2g7CiB9CiAKLS0gCjIuNS4wCgo=
--001a113dc9a296f89e052fae3134--

