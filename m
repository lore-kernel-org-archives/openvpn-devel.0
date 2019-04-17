MIME-Version: 1.0
References: <CAM1xzG1X-iERU2ZXFS_m_VqCKOwjt_gD8oi0F8J5h38Xx+FQ9A@...278...>
 <CAKuzo_gXgqWSLhpvMhjTS+VfbWmQ8JXnHEiOVEPyPSOMCbPKcQ@...278...>
 <63b81ed6-dce7-94b8-0dd5-8864a8314ec6@...1147...>
 <CAKuzo_iikr28FJcXNMz+xSbkoqZAyutJ3cx5J5zBvnEnEEw5bw@...278...>
 <d2f35ef2-dfbc-0202-2eb9-68e69051f742@...1147...>
In-Reply-To: <d2f35ef2-dfbc-0202-2eb9-68e69051f742@...1147...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 17 Apr 2019 11:52:57 -0400
Message-ID: <CAKuzo_jn38kJm4izesNzK6fedgbc55MUYmmsyZRrZa1oaix5wg@...278...>
Content-Type: multipart/mixed; boundary="0000000000003718250586bbe29b"
Subject: Re: [Openvpn-devel] Issue with smartcard authentication for openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>, Francois Gelis <francois.gelis@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000003718250586bbe29b
Content-Type: multipart/alternative; boundary="0000000000003718210586bbe299"

--0000000000003718210586bbe299
Content-Type: text/plain; charset="UTF-8"

Hi JJK,

On Wed, Apr 17, 2019 at 10:50 AM Jan Just Keijser <janjust@...1147...> wrote:

> Hi Selva,
>
> On 10/04/19 19:09, Selva Nair wrote:
>
>
>
> On Wed, Apr 10, 2019 at 12:59 PM Jan Just Keijser <janjust@...1147...>
> wrote:
>
>
snipped...


> patching pkcs11-helper does not seem too difficult for this particular
>> case - but how can we test it? I have access to hw tokens but I don't know
>> how to trigger the "raw signature" bit.
>>
>
> If both server and client are built with OpenSSL 1.1.1 and TLS version is
> >= 1.2, PSS padding will get used and trigger this. OpenSSL does PSS
> padding internally and passes the padded data to the rsa_priv_enc calback
> for raw signature.
>
> This is based on my tests for our Windows cryptoapi and
> management-external-key patches for the same -- never tried this using
> pkcs11-helper, but I expect the same behaviour.
>
>
> The good news: I can reproduce this with
> - openvpn 2.4.7
> - openssl 1.1.1b
> - pkcs11helper 1.25.1
> - Safenet etoken
> - client+server CentOS 7
>
> The bad news: I don't have a fix yet.
>

What I has in mind was a very simple patch like the one attached (totally
untested).
But I guess you tried that already and it doesn't work? Is it because the
token
does not support raw signature (not all do) or something else?

Selva

--0000000000003718210586bbe299
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div>Hi JJK,</div></div></div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr =
17, 2019 at 10:50 AM Jan Just Keijser &lt;<a href=3D"mailto:janjust@...2303...=
...">janjust@...1147...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
=20=20
=20=20=20=20
=20=20
  <div bgcolor=3D"#FFFFFF">
    <div class=3D"gmail-m_-4512286871544203907moz-cite-prefix">Hi Selva,<br>
      <br>
      On 10/04/19 19:09, Selva Nair wrote:<br>
    </div>
    <blockquote type=3D"cite">
=20=20=20=20=20=20
      <div dir=3D"ltr">
        <div dir=3D"ltr"><br>
        </div>
        <br>
        <div class=3D"gmail_quote">
          <div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 10, 2019 at
            12:59 PM Jan Just Keijser &lt;<a href=3D"mailto:janjust@...2303...=
..." target=3D"_blank">janjust@...1147...</a>&gt; wrote:<br></div></div></d=
iv></blockquote></div></blockquote><div><br></div><div>snipped...<br>=C2=A0=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div bgcolor=3D=
"#FFFFFF"><blockquote type=3D"cite"><div dir=3D"ltr"><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">
          </div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div bgcolor=3D"#FFFFFF">patching pkcs11-helper does not seem t=
oo difficult for
              this particular case - but how can we test it? I have
              access to hw tokens but I don&#39;t know how to trigger the
              &quot;raw signature&quot; bit.<br>
            </div>
          </blockquote>
          <div><br>
          </div>
          <div>If both server and client are built with OpenSSL 1.1.1
            and TLS version is &gt;=3D 1.2, PSS padding will get used and
            trigger this. OpenSSL does PSS padding internally and passes
            the padded data to the rsa_priv_enc calback for raw
            signature.<br>
            <br>
          </div>
          <div>This is based on my tests for our Windows cryptoapi and
            management-external-key patches for the same -- never tried
            this using pkcs11-helper, but I expect the same behaviour.<br>
            <br>
          </div>
          <br>
        </div>
      </div>
    </blockquote>
    The good news: I can reproduce this with<br>
    - openvpn 2.4.7<br>
    - openssl 1.1.1b<br>
    - pkcs11helper 1.25.1<br>
    - Safenet etoken<br>
    - client+server CentOS 7<br>
    <br>
    The bad news: I don&#39;t have a fix yet.=C2=A0 <br></div></blockquote>=
<div><br>What I has in mind was a very simple patch like the one attached (=
totally untested).<br>But I guess you tried that already and it doesn&#39;t=
 work? Is it because the token<br>does not support raw signature (not all d=
o) or something else?<br><br></div><div>Selva<br></div></div></div>

--0000000000003718210586bbe299--

--0000000000003718250586bbe29b
Content-Type: text/x-patch; charset="US-ASCII"; name="0001-Support-raw-RSA-signature.patch"
Content-Disposition: attachment; 
	filename="0001-Support-raw-RSA-signature.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jule7pja0>
X-Attachment-Id: f_jule7pja0

RnJvbSA1NDdjNThjZTI0ZTc2NTk4YjUwNGM5MDYyODIwZGFlNDNmYTljYzM4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZWx2YSBOYWlyIDxzZWx2YS5uYWlyQGdtYWlsLmNvbT4KRGF0
ZTogV2VkLCAxNyBBcHIgMjAxOSAxMToyNjo0MCAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIFN1cHBv
cnQgcmF3IFJTQSBzaWduYXR1cmUKClNpZ25lZC1vZmYtYnk6IFNlbHZhIE5haXIgPHNlbHZhLm5h
aXJAZ21haWwuY29tPgotLS0KIGxpYi9wa2NzMTFoLW9wZW5zc2wuYyB8IDEwICsrKysrKysrLS0K
IDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvbGliL3BrY3MxMWgtb3BlbnNzbC5jIGIvbGliL3BrY3MxMWgtb3BlbnNzbC5jCmluZGV4
IDRlYmMyMTEuLjZhMzk2YmIgMTAwNjQ0Ci0tLSBhL2xpYi9wa2NzMTFoLW9wZW5zc2wuYworKysg
Yi9saWIvcGtjczExaC1vcGVuc3NsLmMKQEAgLTU2Nyw3ICs1NjcsMTMgQEAgX19wa2NzMTFoX29w
ZW5zc2xfcnNhX2VuYyAoCiAJCXBhZGRpbmcKIAkpOwogCi0JaWYgKHBhZGRpbmcgIT0gUlNBX1BL
Q1MxX1BBRERJTkcpIHsKKwlpZiAocGFkZGluZyA9PSBSU0FfUEtDUzFfUEFERElORykgeworCQlw
YWRkaW5nID0gQ0tNX1JTQV9QS0NTOworCX0KKwllbHNlIGlmIChwYWRkaW5nID09IFJTQV9OT19Q
QURESU5HKSB7CisJCXBhZGRpbmcgPSBDS01fUlNBX1hfNTA5OworCX0KKwllbHNlIHsKIAkJcnYg
PSBDS1JfTUVDSEFOSVNNX0lOVkFMSUQ7CiAJCWdvdG8gY2xlYW51cDsKIAl9CkBAIC01ODcsNyAr
NTkzLDcgQEAgX19wa2NzMTFoX29wZW5zc2xfcnNhX2VuYyAoCiAJaWYgKAogCQkocnYgPSBwa2Nz
MTFoX2NlcnRpZmljYXRlX3NpZ25BbnkgKAogCQkJY2VydGlmaWNhdGUsCi0JCQlDS01fUlNBX1BL
Q1MsCisJCQlwYWRkaW5nLAogCQkJZnJvbSwKIAkJCWZsZW4sCiAJCQl0bywKLS0gCjIuMS40Cgo=
--0000000000003718250586bbe29b--

