MIME-Version: 1.0
References: <20230323143140.76949-1-frank@...2641...>
In-Reply-To: <20230323143140.76949-1-frank@...2641...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 24 Mar 2023 13:13:22 -0400
Message-ID: <CAKuzo_i+EEaThhmtOHjJGwprtnRgQGxDSNMpeJ+aHHH1FPGNOw@...278...>
Content-Type: multipart/mixed; boundary="000000000000a1a36005f7a88339"
Subject: Re: [Openvpn-devel] [PATCH] unit_tests: make cert_data.h compile
 with MSVC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000a1a36005f7a88339
Content-Type: multipart/alternative; boundary="000000000000a1a35e05f7a88337"

--000000000000a1a35e05f7a88337
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 23, 2023 at 10:31=E2=80=AFAM Frank Lichtenheld <frank@...2723...=
.>
wrote:

> Currently this is not obvious since we never build the
> UTs with MSVC, but it doesn't like the initializers with
> "const" variables. They cause
> error C2099: initializer is not a constant
> when used in an initializer.
> So change all of them to preprocessor defines instead.
>
> It also doesn't like the empty initializer.
> error C2059: syntax error: '}'
>
> CC: Selva Nair <selva.nair@...277...>
> Signed-off-by: Frank Lichtenheld <frank@...2641...>
> ---
>  tests/unit_tests/openvpn/cert_data.h      | 240 +++++++++++-----------
>  tests/unit_tests/openvpn/test_cryptoapi.c |  10 +-
>  tests/unit_tests/openvpn/test_pkcs11.c    |  10 +-
>  3 files changed, 127 insertions(+), 133 deletions(-)
>
> Notes:
> * this is an prereq for my CMake patch but is otherwise independent,
>   so submitting separately
> * this is on top of Selva's "Unit tests: Test for PKCS#11 using a
>   softhsm2 token"
>
> diff --git a/tests/unit_tests/openvpn/cert_data.h
> b/tests/unit_tests/openvpn/cert_data.h
> index 33de35ec..359718bb 100644
> --- a/tests/unit_tests/openvpn/cert_data.h
> +++ b/tests/unit_tests/openvpn/cert_data.h
> @@ -36,131 +36,125 @@
>   */
>
...


>  /* sample-ec.crt */
> +#define cd_cert1 "-----BEGIN CERTIFICATE-----\n" \
> +    "MIIClzCCAX+gAwIBAgIRAIJr3cy95V63CPEtaAA8JN4wDQYJKoZIhvcNAQELBQAw\n"=
 \
> +    "GDEWMBQGA1UEAwwNT1ZQTiBURVNUIENBMTAgFw0yMzAzMTMxNjExMjhaGA8yMTIz\n"=
 \
> +    "MDIxNzE2MTEyOFowGDEWMBQGA1UEAwwNb3Zwbi10ZXN0LWVjMTBZMBMGByqGSM49\n"=
 \
> +    "AgEGCCqGSM49AwEHA0IABHhJG+dK4Z0mY+K0pupwVtyDLOwwGWHjBY6u3LgjRmUh\n"=
 \
> +    "fFjaoSfJvdgrPg50wbOkrsUt9Bl6EeDosZuVwuzgRbujgaQwgaEwCQYDVR0TBAIw\n"=
 \
> +    "ADAdBgNVHQ4EFgQUPWeU5BEmD8VEOSKeNf9kAvhcVuowUwYDVR0jBEwwSoAU3MLD\n"=
 \
> +    "NDOK13DqflQ8ra7FeGBXK06hHKQaMBgxFjAUBgNVBAMMDU9WUE4gVEVTVCBDQTGC\n"=
 \
> +    "FD55ErHXpK2JXS3WkfBm0NB1r3vKMBMGA1UdJQQMMAoGCCsGAQUFBwMCMAsGA1Ud\n"=
 \
> +    "DwQEAwIHgDANBgkqhkiG9w0BAQsFAAOCAQEAhH/wOFqP4R+FK5QvU+oW/XacFMku\n"=
 \
> +    "+qT8lL9J7BG28WhZ0ZcAy/AmtnyynkDyuZSwnlzGgJ5m4L/RfwTzJKhEHiSU3BvB\n"=
 \
> +    "5C1Z1Q8k67MHSfb565iCn8GzPUQLK4zsILCoTkJPvimv2bJ/RZmNaD+D4LWiySD4\n"=
 \
> +    "tuOEdHKrxIrbJ5eAaN0WxRrvDdwGlyPvbMFvfhXzd/tbkP4R2xvlm7S2DPeSTJ8s\n"=
 \
> +    "srXMaPe0lAea4etMSZsjIRPwGRMXBrwbRmb6iN2Cq40867HdaJoAryYig7IiDwSX\n"=
 \
> +    "htCbOA6sX+60+FEOYDEx5cmkogl633Pw7LJ3ICkyzIrUSEt6BOT1Gsc1eQ=3D=3D\n"=
 \
> +    "-----END CERTIFICATE-----\n"
>

I would like to avoid such long preprocessor #defines with continuation
lines.

Would the attached small patch be acceptable instead? It covers only
test_cryptoapi --- if this will do, I can incorporate similar changes for
test_pkcs11 into a v2 of the relevant patch as those have not been
ACK-ed yet.


> --- a/tests/unit_tests/openvpn/test_pkcs11.c
> +++ b/tests/unit_tests/openvpn/test_pkcs11.c
> @@ -113,11 +113,11 @@ static struct test_cert
>      uint8_t hash[HASHSIZE];             /* SHA1 fingerprint: computed and
> filled in later */
>      char *p11_id;                       /* PKCS#11 id -- filled in later
> */
>  } certs[] =3D {
> -    {cert1,  key1,  cname1,  "OVPN TEST CA1",  "OVPN Test Cert 1",  {},
> NULL},
> -    {cert2,  key2,  cname2,  "OVPN TEST CA2",  "OVPN Test Cert 2",  {},
> NULL},
> -    {cert3,  key3,  cname3,  "OVPN TEST CA1",  "OVPN Test Cert 3",  {},
> NULL},
> -    {cert4,  key4,  cname4,  "OVPN TEST CA2",  "OVPN Test Cert 4",  {},
> NULL},
> -    {}
> +    {cd_cert1,  cd_key1,  cd_cname1,  "OVPN TEST CA1",  "OVPN Test Cert
> 1",  {},  NULL},
>

Isn't it necessary to change these {} to {0} as well? The build may not
report it now as we haven't yet enabled test_pkcs11 on Windows.


> +    {cd_cert2,  cd_key2,  cd_cname2,  "OVPN TEST CA2",  "OVPN Test Cert
> 2",  {},  NULL},
> +    {cd_cert3,  cd_key3,  cd_cname3,  "OVPN TEST CA1",  "OVPN Test Cert
> 3",  {},  NULL},
> +    {cd_cert4,  cd_key4,  cd_cname4,  "OVPN TEST CA2",  "OVPN Test Cert
> 4",  {},  NULL},
> +    {NULL,      NULL,     NULL,       NULL,              NULL,
>    {},  NULL}
>

A single {0} should be enough here as well.

Selva

--000000000000a1a35e05f7a88337
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 23, 2023 at 10:31=E2=80=AF=
AM Frank Lichtenheld &lt;<a href=3D"mailto:frank@...2641..." target=3D"_bla=
nk">frank@...2641...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">Currently this is not obvious since we never build the<=
br>
UTs with MSVC, but it doesn&#39;t like the initializers with<br>
&quot;const&quot; variables. They cause<br>
error C2099: initializer is not a constant<br>
when used in an initializer.<br>
So change all of them to preprocessor defines instead.<br>
<br>
It also doesn&#39;t like the empty initializer.<br>
error C2059: syntax error: &#39;}&#39;<br>
<br>
CC: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank=
">selva.nair@...277...</a>&gt;<br>
Signed-off-by: Frank Lichtenheld &lt;<a href=3D"mailto:frank@...2641..." ta=
rget=3D"_blank">frank@...2641...</a>&gt;<br>
---<br>
=C2=A0tests/unit_tests/openvpn/cert_data.h=C2=A0 =C2=A0 =C2=A0 | 240 ++++++=
+++++-----------<br>
=C2=A0tests/unit_tests/openvpn/test_cryptoapi.c |=C2=A0 10 +-<br>
=C2=A0tests/unit_tests/openvpn/test_pkcs11.c=C2=A0 =C2=A0 |=C2=A0 10 +-<br>
=C2=A03 files changed, 127 insertions(+), 133 deletions(-)<br>
<br>
Notes:<br>
* this is an prereq for my CMake patch but is otherwise independent,<br>
=C2=A0 so submitting separately<br>
* this is on top of Selva&#39;s &quot;Unit tests: Test for PKCS#11 using a<=
br>
=C2=A0 softhsm2 token&quot;<br>
<br>
diff --git a/tests/unit_tests/openvpn/cert_data.h b/tests/unit_tests/openvp=
n/cert_data.h<br>
index 33de35ec..359718bb 100644<br>
--- a/tests/unit_tests/openvpn/cert_data.h<br>
+++ b/tests/unit_tests/openvpn/cert_data.h<br>
@@ -36,131 +36,125 @@<br>
=C2=A0 */<br></blockquote><div>...</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
=C2=A0/* sample-ec.crt */<br>+#define cd_cert1 &quot;-----BEGIN CERTIFICATE=
-----\n&quot; \<br>+=C2=A0 =C2=A0 &quot;MIIClzCCAX+gAwIBAgIRAIJr3cy95V63CPE=
taAA8JN4wDQYJKoZIhvcNAQELBQAw\n&quot; \<br>+=C2=A0 =C2=A0 &quot;GDEWMBQGA1U=
EAwwNT1ZQTiBURVNUIENBMTAgFw0yMzAzMTMxNjExMjhaGA8yMTIz\n&quot; \<br>+=C2=A0 =
=C2=A0 &quot;MDIxNzE2MTEyOFowGDEWMBQGA1UEAwwNb3Zwbi10ZXN0LWVjMTBZMBMGByqGSM=
49\n&quot; \<br>+=C2=A0 =C2=A0 &quot;AgEGCCqGSM49AwEHA0IABHhJG+dK4Z0mY+K0pu=
pwVtyDLOwwGWHjBY6u3LgjRmUh\n&quot; \<br>+=C2=A0 =C2=A0 &quot;fFjaoSfJvdgrPg=
50wbOkrsUt9Bl6EeDosZuVwuzgRbujgaQwgaEwCQYDVR0TBAIw\n&quot; \<br>+=C2=A0 =C2=
=A0 &quot;ADAdBgNVHQ4EFgQUPWeU5BEmD8VEOSKeNf9kAvhcVuowUwYDVR0jBEwwSoAU3MLD\=
n&quot; \<br>+=C2=A0 =C2=A0 &quot;NDOK13DqflQ8ra7FeGBXK06hHKQaMBgxFjAUBgNVB=
AMMDU9WUE4gVEVTVCBDQTGC\n&quot; \<br>+=C2=A0 =C2=A0 &quot;FD55ErHXpK2JXS3Wk=
fBm0NB1r3vKMBMGA1UdJQQMMAoGCCsGAQUFBwMCMAsGA1Ud\n&quot; \<br>+=C2=A0 =C2=A0=
 &quot;DwQEAwIHgDANBgkqhkiG9w0BAQsFAAOCAQEAhH/wOFqP4R+FK5QvU+oW/XacFMku\n&q=
uot; \<br>+=C2=A0 =C2=A0 &quot;+qT8lL9J7BG28WhZ0ZcAy/AmtnyynkDyuZSwnlzGgJ5m=
4L/RfwTzJKhEHiSU3BvB\n&quot; \<br>+=C2=A0 =C2=A0 &quot;5C1Z1Q8k67MHSfb565iC=
n8GzPUQLK4zsILCoTkJPvimv2bJ/RZmNaD+D4LWiySD4\n&quot; \<br>+=C2=A0 =C2=A0 &q=
uot;tuOEdHKrxIrbJ5eAaN0WxRrvDdwGlyPvbMFvfhXzd/tbkP4R2xvlm7S2DPeSTJ8s\n&quot=
; \<br>+=C2=A0 =C2=A0 &quot;srXMaPe0lAea4etMSZsjIRPwGRMXBrwbRmb6iN2Cq40867H=
daJoAryYig7IiDwSX\n&quot; \<br>+=C2=A0 =C2=A0 &quot;htCbOA6sX+60+FEOYDEx5cm=
kogl633Pw7LJ3ICkyzIrUSEt6BOT1Gsc1eQ=3D=3D\n&quot; \<br>+=C2=A0 =C2=A0 &quot=
;-----END CERTIFICATE-----\n&quot;<br></blockquote><div><br></div><div>I wo=
uld like to avoid such long preprocessor #defines with continuation lines.<=
/div><div><br></div><div>Would the attached small patch be acceptable inste=
ad? It covers only test_cryptoapi --- if this will do, I can incorporate si=
milar changes for test_pkcs11 into a v2 of the relevant patch as those have=
 not been ACK-ed=C2=A0yet.</div><div>=C2=A0 =C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
--- a/tests/unit_tests/openvpn/test_pkcs11.c<br>
+++ b/tests/unit_tests/openvpn/test_pkcs11.c<br>
@@ -113,11 +113,11 @@ static struct test_cert<br>
=C2=A0 =C2=A0 =C2=A0uint8_t hash[HASHSIZE];=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* SHA1 fingerprint: computed and filled in later */<br>
=C2=A0 =C2=A0 =C2=A0char *p11_id;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* PKCS#11 id -- filled in later *=
/<br>
=C2=A0} certs[] =3D {<br>
-=C2=A0 =C2=A0 {cert1,=C2=A0 key1,=C2=A0 cname1,=C2=A0 &quot;OVPN TEST CA1&=
quot;,=C2=A0 &quot;OVPN Test Cert 1&quot;,=C2=A0 {},=C2=A0 NULL},<br>
-=C2=A0 =C2=A0 {cert2,=C2=A0 key2,=C2=A0 cname2,=C2=A0 &quot;OVPN TEST CA2&=
quot;,=C2=A0 &quot;OVPN Test Cert 2&quot;,=C2=A0 {},=C2=A0 NULL},<br>
-=C2=A0 =C2=A0 {cert3,=C2=A0 key3,=C2=A0 cname3,=C2=A0 &quot;OVPN TEST CA1&=
quot;,=C2=A0 &quot;OVPN Test Cert 3&quot;,=C2=A0 {},=C2=A0 NULL},<br>
-=C2=A0 =C2=A0 {cert4,=C2=A0 key4,=C2=A0 cname4,=C2=A0 &quot;OVPN TEST CA2&=
quot;,=C2=A0 &quot;OVPN Test Cert 4&quot;,=C2=A0 {},=C2=A0 NULL},<br>
-=C2=A0 =C2=A0 {}<br>
+=C2=A0 =C2=A0 {cd_cert1,=C2=A0 cd_key1,=C2=A0 cd_cname1,=C2=A0 &quot;OVPN =
TEST CA1&quot;,=C2=A0 &quot;OVPN Test Cert 1&quot;,=C2=A0 {},=C2=A0 NULL},<=
br></blockquote><div><br></div><div>Isn&#39;t it necessary to change these =
{} to {0} as well? The build may not report it now as we haven&#39;t yet en=
abled test_pkcs11 on Windows.</div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
+=C2=A0 =C2=A0 {cd_cert2,=C2=A0 cd_key2,=C2=A0 cd_cname2,=C2=A0 &quot;OVPN =
TEST CA2&quot;,=C2=A0 &quot;OVPN Test Cert 2&quot;,=C2=A0 {},=C2=A0 NULL},<=
br>
+=C2=A0 =C2=A0 {cd_cert3,=C2=A0 cd_key3,=C2=A0 cd_cname3,=C2=A0 &quot;OVPN =
TEST CA1&quot;,=C2=A0 &quot;OVPN Test Cert 3&quot;,=C2=A0 {},=C2=A0 NULL},<=
br>
+=C2=A0 =C2=A0 {cd_cert4,=C2=A0 cd_key4,=C2=A0 cd_cname4,=C2=A0 &quot;OVPN =
TEST CA2&quot;,=C2=A0 &quot;OVPN Test Cert 4&quot;,=C2=A0 {},=C2=A0 NULL},<=
br>
+=C2=A0 =C2=A0 {NULL,=C2=A0 =C2=A0 =C2=A0 NULL,=C2=A0 =C2=A0 =C2=A0NULL,=C2=
=A0 =C2=A0 =C2=A0 =C2=A0NULL,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 NULL,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{},=C2=A0 N=
ULL}<br></blockquote><div><br></div><div>A single {0} should be enough here=
 as well.=C2=A0</div><div><br></div><div>Selva</div></div></div>

--000000000000a1a35e05f7a88337--

--000000000000a1a36005f7a88339
Content-Type: application/x-patch; 
	name="0001-Make-cert_data.h-and-test_cryptoapi.c-MSVC-compliant.patch"
Content-Disposition: attachment; 
	filename="0001-Make-cert_data.h-and-test_cryptoapi.c-MSVC-compliant.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lfmssod40>
X-Attachment-Id: f_lfmssod40

RnJvbSAwOGQ0ODEzZmRjM2M5MDk2OWM0OWRjMDdiZTUyOTExMWE3ZTg0YWM0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZWx2YSBOYWlyIDxzZWx2YS5uYWlyQGdtYWlsLmNvbT4KRGF0
ZTogVGh1LCAyMyBNYXIgMjAyMyAyMzoyNDozOCAtMDQwMApTdWJqZWN0OiBbUEFUQ0ggMS8yXSBN
YWtlIGNlcnRfZGF0YS5oIGFuZCB0ZXN0X2NyeXB0b2FwaS5jIE1TVkMgY29tcGxpYW50CgotIERv
IG5vdCB1c2Ugbm9uLWxpdGVyYWwgaW5pdGlhbGl6ZXJzIGZvciBzdGF0aWMgb2JqZWN0cwotIFJl
cGxhY2UgZW1wdHkgaW5pdGlhbGl6ZXIge30gYnkgezB9CgpTaWduZWQtb2ZmLWJ5OiBTZWx2YSBO
YWlyIDxzZWx2YS5uYWlyQGdtYWlsLmNvbT4KLS0tCiB0ZXN0cy91bml0X3Rlc3RzL29wZW52cG4v
Y2VydF9kYXRhLmggICAgICB8ICA2ICsrKy0tLQogdGVzdHMvdW5pdF90ZXN0cy9vcGVudnBuL3Rl
c3RfY3J5cHRvYXBpLmMgfCAyNCArKysrKysrKysrKysrKysrLS0tLS0tLQogMiBmaWxlcyBjaGFu
Z2VkLCAyMCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0
cy91bml0X3Rlc3RzL29wZW52cG4vY2VydF9kYXRhLmggYi90ZXN0cy91bml0X3Rlc3RzL29wZW52
cG4vY2VydF9kYXRhLmgKaW5kZXggMzNkZTM1ZWMuLjA4ODZiMDcxIDEwMDY0NAotLS0gYS90ZXN0
cy91bml0X3Rlc3RzL29wZW52cG4vY2VydF9kYXRhLmgKKysrIGIvdGVzdHMvdW5pdF90ZXN0cy9v
cGVudnBuL2NlcnRfZGF0YS5oCkBAIC03OSw3ICs3OSw3IEBAIHN0YXRpYyBjb25zdCBjaGFyICpj
b25zdCBjZXJ0MiA9CiAgICAgIkhlVHNBbEhqZkZFUmVWRGlOQ0k5dk1RTEtGS0tXbkFvclQyK2l5
UnVlQTNidDJnY2hmODYzQkJoWnZKZGRMN1FcbiIKICAgICAiS0JhMG9zWHcrZUdCUkF3c203bTFx
Q2hvM2IzZk4ybkZBYStrMDdwdFJrT2VhYmxtRmRYRTgxblZsQT09XG4iCiAgICAgIi0tLS0tRU5E
IENFUlRJRklDQVRFLS0tLS1cbiI7Ci1zdGF0aWMgY29uc3QgY2hhciAqY29uc3Qga2V5MiA9IGtl
eTE7CisjZGVmaW5lIGtleTIga2V5MQogc3RhdGljIGNvbnN0IGNoYXIgKmNvbnN0IGhhc2gyID0g
IkZBMThGRDM0QkFBQkU0N0Q2RTI5MTBFMDgwRjQyMUMxMDlDQTk3RjUiOwogc3RhdGljIGNvbnN0
IGNoYXIgKmNvbnN0IGNuYW1lMiA9ICJvdnBuLXRlc3QtZWMyIjsKIApAQCAtMTU5LDggKzE1OSw4
IEBAIHN0YXRpYyBjb25zdCBjaGFyICpjb25zdCBjZXJ0NCA9CiAgICAgIjM1M1BwSko5czJiL0Zx
b2M0ZDd1ZHFoUW9nQTdqcWJheVRLaEp4YlQxMzRsMk56cURST3p1UzBrWGJYOGJYQ2lcbiIKICAg
ICAibVhTYTRjOD1cbiIKICAgICAiLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLVxuIjsKLXN0YXRp
YyBjb25zdCBjaGFyICpjb25zdCBrZXk0ID0ga2V5MzsKKyNkZWZpbmUga2V5NCBrZXkzCiBzdGF0
aWMgY29uc3QgY2hhciAqY29uc3QgaGFzaDQgPSAiRTE0MDFENDQ5N0M5NDQ3ODNFM0Q2MkNEQkQy
QTFGNjlGNUU1MDcxRSI7Ci1zdGF0aWMgY29uc3QgY2hhciAqY29uc3QgY25hbWU0ID0gY25hbWUz
OyAvKiBzYW1lIENOIGFzIHRoYXQgb2YgY2VydDMgKi8KKyNkZWZpbmUgY25hbWU0IGNuYW1lMyAv
KiBzYW1lIENOIGFzIHRoYXQgb2YgY2VydDMgKi8KIAogI2VuZGlmIC8qIENFUlRfREFUQV9IICov
CmRpZmYgLS1naXQgYS90ZXN0cy91bml0X3Rlc3RzL29wZW52cG4vdGVzdF9jcnlwdG9hcGkuYyBi
L3Rlc3RzL3VuaXRfdGVzdHMvb3BlbnZwbi90ZXN0X2NyeXB0b2FwaS5jCmluZGV4IGM4NDY4MTAz
Li4yMTUwYjc3YyAxMDA2NDQKLS0tIGEvdGVzdHMvdW5pdF90ZXN0cy9vcGVudnBuL3Rlc3RfY3J5
cHRvYXBpLmMKKysrIGIvdGVzdHMvdW5pdF90ZXN0cy9vcGVudnBuL3Rlc3RfY3J5cHRvYXBpLmMK
QEAgLTk5LDE3ICs5OSwyNiBAQCBzdGF0aWMgc3RydWN0IHRlc3RfY2VydAogICAgIGNvbnN0IGNo
YXIgKmNvbnN0IGZyaWVuZGx5X25hbWU7ICAgIC8qIGlkZW50aWZpZXMgY2VydHMgbG9hZGVkIHRv
IHRoZSBzdG9yZSAtLSBrZWVwIHVuaXF1ZSAqLwogICAgIGNvbnN0IGNoYXIgKmhhc2g7ICAgICAg
ICAgICAgICAgICAgIC8qIFNIQTEgZmluZ2VycHJpbnQgKi8KICAgICBpbnQgdmFsaWQ7ICAgICAg
ICAgICAgICAgICAgICAgICAgICAvKiBub256ZXJvIGlmIGNlcnRpZmljYXRlIGhhcyBub3QgZXhw
aXJlZCAqLwotfSBjZXJ0c1tdID0gewotICAgIHtjZXJ0MSwgIGtleTEsICBjbmFtZTEsICAiT1ZQ
TiBURVNUIENBMSIsICAiT1ZQTiBUZXN0IENlcnQgMSIsICBoYXNoMSwgIDF9LAotICAgIHtjZXJ0
MiwgIGtleTIsICBjbmFtZTIsICAiT1ZQTiBURVNUIENBMiIsICAiT1ZQTiBUZXN0IENlcnQgMiIs
ICBoYXNoMiwgIDF9LAotICAgIHtjZXJ0MywgIGtleTMsICBjbmFtZTMsICAiT1ZQTiBURVNUIENB
MSIsICAiT1ZQTiBUZXN0IENlcnQgMyIsICBoYXNoMywgIDF9LAotICAgIHtjZXJ0NCwgIGtleTQs
ICBjbmFtZTQsICAiT1ZQTiBURVNUIENBMiIsICAiT1ZQTiBUZXN0IENlcnQgNCIsICBoYXNoNCwg
IDB9LAotICAgIHt9Ci19OworfSBjZXJ0c1s1XTsKIAogc3RhdGljIGJvb2wgY2VydHNfbG9hZGVk
Owogc3RhdGljIEhDRVJUU1RPUkUgdXNlcl9zdG9yZTsKIAorLyogRmlsbC1pbiBjZXJ0c1tdIGFy
cmF5ICovCit2b2lkCitpbml0X2NlcnRfZGF0YSgpCit7CisgICAgc3RydWN0IHRlc3RfY2VydCBj
ZXJ0c19sb2NhbFtdID0geworICAgICAgICB7Y2VydDEsICBrZXkxLCAgY25hbWUxLCAgIk9WUE4g
VEVTVCBDQTEiLCAgIk9WUE4gVGVzdCBDZXJ0IDEiLCAgaGFzaDEsICAxfSwKKyAgICAgICAge2Nl
cnQyLCAga2V5MiwgIGNuYW1lMiwgICJPVlBOIFRFU1QgQ0EyIiwgICJPVlBOIFRlc3QgQ2VydCAy
IiwgIGhhc2gyLCAgMX0sCisgICAgICAgIHtjZXJ0MywgIGtleTMsICBjbmFtZTMsICAiT1ZQTiBU
RVNUIENBMSIsICAiT1ZQTiBUZXN0IENlcnQgMyIsICBoYXNoMywgIDF9LAorICAgICAgICB7Y2Vy
dDQsICBrZXk0LCAgY25hbWU0LCAgIk9WUE4gVEVTVCBDQTIiLCAgIk9WUE4gVGVzdCBDZXJ0IDQi
LCAgaGFzaDQsICAwfSwKKyAgICAgICAgezB9CisgICAgfTsKKyAgICBhc3NlcnQoc2l6ZW9mKGNl
cnRzX2xvY2FsKSA9PSBzaXplb2YoY2VydHMpKTsKKyAgICBtZW1jcHkoY2VydHMsIGNlcnRzX2xv
Y2FsLCBzaXplb2YoY2VydHNfbG9jYWwpKTsKK30KKwogLyogTG9va3VwIGEgY2VydGlmaWNhdGUg
aW4gb3VyIGNlcnRpZmljYXRlL2tleSBkYiAqLwogc3RhdGljIHN0cnVjdCB0ZXN0X2NlcnQgKgog
bG9va3VwX2NlcnQoY29uc3QgY2hhciAqZnJpZW5kbHlfbmFtZSkKQEAgLTEzMSw2ICsxNDAsNyBA
QCBpbXBvcnRfY2VydHModm9pZCAqKnN0YXRlKQogICAgIHsKICAgICAgICAgcmV0dXJuOwogICAg
IH0KKyAgICBpbml0X2NlcnRfZGF0YSgpOwogICAgIHVzZXJfc3RvcmUgPSBDZXJ0T3BlblN0b3Jl
KENFUlRfU1RPUkVfUFJPVl9TWVNURU0sIDAsIDAsIENFUlRfU1lTVEVNX1NUT1JFX0NVUlJFTlRf
VVNFUgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHxDRVJUX1NUT1JFX09QRU5fRVhJ
U1RJTkdfRkxBRywgTCJNWSIpOwogICAgIGFzc2VydF9ub25fbnVsbCh1c2VyX3N0b3JlKTsKLS0g
CjIuMzQuMQoK
--000000000000a1a36005f7a88339--

