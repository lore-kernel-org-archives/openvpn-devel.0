MIME-Version: 1.0
References: <CAAUX2SWGzsjeCxjQ1C+zh8+qKXL3mUv5AJqEd6rM=A8f-Q1dBA@...278...>
 <a2152b6e-1429-6637-aef8-7eaf527316e3@...2181...>
 <CAAUX2SWEOk5TC1J9jBoiS6=chMbY_6DTMvPV1J07d3L26k9b0A@...278...>
 <228b401e-e700-447c-4c30-29d28cb22585@...2181...>
 <CAAUX2SX-90sKC-+MBQ9ycimK0YvHZC0rMjVKMKH_oFSDW=x5Tw@...278...>
 <8a1dc0cf-61d4-2ded-1c51-ccb755ba7ef9@...2181...>
 <CAAUX2SUqFRWcP+aTXUaW2+5zK6AGcAO51-rbcikexKXVPsc84g@...278...>
 <f34acee4-d928-509e-5bb3-9900c1578d5b@...2181...>
 <CAAUX2SXreiLnX5z0X9-oiKPJXT75=VjkdKsEb_taPHBGsP-39Q@...278...>
 <20201126085648.GM976@...1296...>
In-Reply-To: <20201126085648.GM976@...1296...>
From: Tony He <huangya90@...277...>
Date: Thu, 26 Nov 2020 17:04:45 +0800
Message-ID: <CAAUX2SVsOOfk0Z7rB5Z8SqUuU7d1+9AJFDqjJgJKLHxEDcAXDQ@...278...>
Content-Type: multipart/alternative; boundary="00000000000081fd3505b4fed643"
Subject: Re: [Openvpn-devel] [ovpn-dco] Is cbc-hmac supported?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Antonio Quartulli <a@...2181...>, lev@...515..., openvpn-devel@lists.sourceforge.net

--00000000000081fd3505b4fed643
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gert,

Because there is HW crypto engine in some  embedded devices, the crypto
engine maybe only supports hmac-sha256-cbc-aes.

Tony

Gert Doering <gert@...1296...> =E4=BA=8E2020=E5=B9=B411=E6=9C=8826=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=884:56=E5=86=99=E9=81=93=EF=BC=9A

> Hi,
>
> On Thu, Nov 26, 2020 at 04:53:14PM +0800, Tony He wrote:
> > Understood.  We have dicussed this in the OpenWRT forum. Maybe some kind
> > OpenWRT guys will implement  aead hmac-sha256-cbc-aes
> > for ovpn-dco module in the future.
>
> Why?  If you do AES in the first place, all numbers I have seen so far
> say "AES-GCM modes are faster / use less CPU =3D battery".  And, less
> overhead on the wire.
>
> And on non-intel devices, CHACHA-POLY, because there is ARM acceleration.
>
> gert
>
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never
> doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh
> Mistress
>
> Gert Doering - Munich, Germany
> gert@...1296...
>

--00000000000081fd3505b4fed643
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Gert,<div><br></div><div>Because there is HW crypto eng=
ine in some=C2=A0=C2=A0embedded=C2=A0devices, the crypto engine maybe only =
supports hmac-sha256-cbc-aes.</div><div><br></div><div>Tony</div></div><br>=
<div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Gert Doeri=
ng &lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; =E4=BA=8E=
2020=E5=B9=B411=E6=9C=8826=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=884:5=
6=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">Hi,<br>
<br>
On Thu, Nov 26, 2020 at 04:53:14PM +0800, Tony He wrote:<br>
&gt; Understood.=C2=A0 We have dicussed this in the OpenWRT forum. Maybe so=
me kind<br>
&gt; OpenWRT guys will implement=C2=A0 aead hmac-sha256-cbc-aes<br>
&gt; for ovpn-dco module in the future.<br>
<br>
Why?=C2=A0 If you do AES in the first place, all numbers I have seen so far=
<br>
say &quot;AES-GCM modes are faster / use less CPU =3D battery&quot;.=C2=A0 =
And, less<br>
overhead on the wire.<br>
<br>
And on non-intel devices, CHACHA-POLY, because there is ARM acceleration.<b=
r>
<br>
gert<br>
<br>
-- <br>
&quot;If was one thing all people took for granted, was conviction that if =
you <br>
=C2=A0feed honest figures into a computer, honest figures come out. Never d=
oubted <br>
=C2=A0it myself till I met a computer with a sense of humor.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Robert A. Heinlein, The Moon is a Harsh Mist=
ress<br>
<br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296..." target=3D"_blank">gert@...1296...</a><br>
</blockquote></div>

--00000000000081fd3505b4fed643--

