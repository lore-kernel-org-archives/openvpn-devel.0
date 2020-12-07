MIME-Version: 1.0
References: <a7450cf9-f278-4e51-0c96-fa9aabddd169@...2181...>
 <f69a02a5-4e06-00ad-366e-56f5699c4d98@...1147...>
In-Reply-To: <f69a02a5-4e06-00ad-366e-56f5699c4d98@...1147...>
From: Tony He <huangya90@...277...>
Date: Mon, 7 Dec 2020 17:28:48 +0800
Message-ID: <CAAUX2SV7554ryDbbxYW1EWbppn2NiyGDEpdeqmetpsBv-C7nPg@...278...>
Content-Type: multipart/alternative; boundary="000000000000c5bbb705b5dc7431"
Subject: Re: [Openvpn-devel] [ovpn-dco] AES-CCM available for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000c5bbb705b5dc7431
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

yeah, also looking forward to add support authenc-hmac-sha256-cbc-aes
because I have another IPQ806x device which support this mode but not CCM
or GCM. IPQ806x devices
are widely used for router users.

Tony

Jan Just Keijser <janjust@...1147...> =E4=BA=8E2020=E5=B9=B412=E6=9C=887=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=885:12=E5=86=99=E9=81=93=EF=BC=9A

> Hi Antonio,
>
> On 06/12/20 17:09, Antonio Quartulli wrote:
>
> Hi all,
>
> Some people have expressed interest in ovpn-dco supporting AES-CBC.
>
> However, since ovpn-dco is currently using the AEAD kernel crypto API
> only, introducing support for CBC mode would require quite some
> refactoring and we do not really want to do that (the community believes
> that as of now AEAD ciphers should always be preferred moving forward).
>
> In a previous discussion on this mailing list, it was highlighted that
> AES-CCM is nothing else than AES-CBC in disguise as AEAD cipher.
>
> (for the curious: it is AES "Counter with CBC-MAC", known as CCM and
> described in RFC3610).
>
> For this reason I decided to give AES-CCM a try and I implemented in it
> the "aes-ccm" branch of the ovpn-dco repo.
>
> I am not sure if we're going to merge it to master yet, but for now it
> would be interesting to gather feedback from those interested in this
> cipher.
>
> Please note that OpenVPN3 does not yet support this cipher, therefore
> the only way to test AES-CCM in ovpn-dco is to use the ovpn-cli tool
> provided in the tests/ folder.
>
>
> To do so, just specify "aes-ccm" as algorithm when setting a new key.
>
>
>
>
> excellent news!
> Thank you very much for adding this so quickly; it won't help Tony He
> though, as he is stuck using a rather old AL314 + R9000 chip which does n=
ot
> support CCM or GCM. I just checked the driver code and indeed there is no
> HW support for GCM.  They *do* support some AEAD algorithms:
>
>   authenc-hmac-sha256-cbc-aes
>   authenc-hmac-sha384-cbc-aes
>
> which are listed as the (true) AEAD equivalent of AES+SHA ; the question
> is : how hard would it be to add support for this (and would it be worth
> it?)
>
> cheers,
>
> JJK
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000c5bbb705b5dc7431
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">yeah, also looking forward to add support authenc-hmac-sha=
256-cbc-aes because I have another IPQ806x device which support this mode b=
ut not CCM or GCM. IPQ806x devices<div>are widely used for router users.</d=
iv><div><br></div><div>Tony</div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">Jan Just Keijser &lt;<a href=3D"mailto:janjust@...220...=
..1147..." target=3D"_blank">janjust@...1147...</a>&gt; =E4=BA=8E2020=E5=B9=
=B412=E6=9C=887=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=885:12=E5=86=99=
=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
=20=20
=20=20=20=20
=20=20
  <div bgcolor=3D"#FFFFFF">
    <div>Hi Antonio,<br>
      <br>
      On 06/12/20 17:09, Antonio Quartulli wrote:<br>
    </div>
    <blockquote type=3D"cite">
      <pre>Hi all,

Some people have expressed interest in ovpn-dco supporting AES-CBC.

However, since ovpn-dco is currently using the AEAD kernel crypto API
only, introducing support for CBC mode would require quite some
refactoring and we do not really want to do that (the community believes
that as of now AEAD ciphers should always be preferred moving forward).

In a previous discussion on this mailing list, it was highlighted that
AES-CCM is nothing else than AES-CBC in disguise as AEAD cipher.

(for the curious: it is AES &quot;Counter with CBC-MAC&quot;, known as CCM =
and
described in RFC3610).

For this reason I decided to give AES-CCM a try and I implemented in it
the &quot;aes-ccm&quot; branch of the ovpn-dco repo.

I am not sure if we&#39;re going to merge it to master yet, but for now it
would be interesting to gather feedback from those interested in this
cipher.

Please note that OpenVPN3 does not yet support this cipher, therefore
the only way to test AES-CCM in ovpn-dco is to use the ovpn-cli tool
provided in the tests/ folder.


To do so, just specify &quot;aes-ccm&quot; as algorithm when setting a new =
key.



</pre>
    </blockquote>
    excellent news! <br>
    Thank you very much for adding this so quickly; it won&#39;t help Tony
    He though, as he is stuck using a rather old AL314 + R9000 chip
    which does not support CCM or GCM. I just checked the driver code
    and indeed there is no HW support for GCM.=C2=A0 They *do* support some
    AEAD algorithms:<br>
    <br>
    <span>=C2=A0 authenc-hmac-sha256-cbc-aes<br>
    </span><span><span>=C2=A0
        authenc-hmac-sha384-cbc-aes<br>
        <br>
        which are listed as the (true) AEAD equivalent of AES+SHA ; the
        question is : how hard would it be to add support for this (and
        would it be worth it?)<br>
        <br>
        cheers,<br>
        <br>
        JJK<br>
        <span></span></span><span></span></span>
  </div>

_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div></div>

--000000000000c5bbb705b5dc7431--

