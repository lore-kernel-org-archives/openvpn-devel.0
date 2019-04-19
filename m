MIME-Version: 1.0
References: <CAM1xzG1X-iERU2ZXFS_m_VqCKOwjt_gD8oi0F8J5h38Xx+FQ9A@...278...>
 <CAKuzo_gXgqWSLhpvMhjTS+VfbWmQ8JXnHEiOVEPyPSOMCbPKcQ@...278...>
 <63b81ed6-dce7-94b8-0dd5-8864a8314ec6@...1147...>
 <CAKuzo_iikr28FJcXNMz+xSbkoqZAyutJ3cx5J5zBvnEnEEw5bw@...278...>
 <d2f35ef2-dfbc-0202-2eb9-68e69051f742@...1147...>
 <CAKuzo_jn38kJm4izesNzK6fedgbc55MUYmmsyZRrZa1oaix5wg@...278...>
 <f120b337-53d1-b6b3-2188-db81fadc5bae@...1147...>
In-Reply-To: <f120b337-53d1-b6b3-2188-db81fadc5bae@...1147...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 19 Apr 2019 15:03:50 -0400
Message-ID: <CAKuzo_jHw0O32Qn58tiHfORcM=frZWpV1u73Mj80=SqR89wJiA@...278...>
Content-Type: multipart/alternative; boundary="0000000000001f31cc0586e6c8a6"
Subject: Re: [Openvpn-devel] Issue with smartcard authentication for openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: Francois Gelis <francois.gelis@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000001f31cc0586e6c8a6
Content-Type: text/plain; charset="UTF-8"

Hi,

On Fri, Apr 19, 2019 at 9:13 AM Jan Just Keijser <janjust@...1147...> wrote:

> Hi Selva,I had not written a patch when I wrote my earlier email, but your
> patch is exactly what I had in mind; getting it all to compile and run with
> OpenSSL 1.1.1b + OpenVPN 2.4.7 was a bit of a challenge, but I finally
> managed...
>
> and yes, your patch works admirably - I can connect again using TLSv1.3 +
> token.  If I comment out your patch, do a rebuild of libpkcs11helper.so
> then it fails again, proving your patch works.
>

Good to know.


>
> Can you do a pull request for your pkcs11-helper patch on the pkcs11helper
> github page?  or shall we simply patch pkcs11-helper ourselves?
>

Getting this upstream is better for us, so let's first try a PR.

Regards,

Selva

--0000000000001f31cc0586e6c8a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"ltr"><div dir=3D"ltr">Hi,<br></div><div><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"><br></div><div =
dir=3D"ltr" class=3D"gmail_attr">On Fri, Apr 19, 2019 at 9:13 AM Jan Just K=
eijser &lt;<a href=3D"mailto:janjust@...1147..." target=3D"_blank" rel=3D"n=
oreferrer">janjust@...1147...</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
=20=20
=20=20=20=20
=20=20
  <div bgcolor=3D"#FFFFFF">
    <div class=3D"m_-3403413149518377972m_4087526890082092629gmail-m_-81603=
19810566586441moz-cite-prefix">Hi Selva,I had not written a patch when I wr=
ote my earlier email, but your
    patch is exactly what I had in mind; getting it all to compile and
    run with OpenSSL 1.1.1b + OpenVPN 2.4.7 was a bit of a challenge,
    but I finally managed...<br></div>
    <br>
    and yes, your patch works admirably - I can connect again using
    TLSv1.3 + token.=C2=A0 If I comment out your patch, do a rebuild of
    libpkcs11helper.so then it fails again, proving your patch works.<br></=
div></blockquote><div><br></div><div>Good to know.</div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex"><div bgcolor=3D"#FFFFFF">
    <br>
    Can you do a pull request for your pkcs11-helper patch on the
    pkcs11helper github page?=C2=A0 or shall we simply patch pkcs11-helper
    ourselves?<br></div></blockquote><div><br></div><div>Getting this upstr=
eam is better for us, so let&#39;s first try a PR.</div><div><br></div><div=
>Regards,</div><div><br></div><div>Selva</div></div></div></div></div>

--0000000000001f31cc0586e6c8a6--

