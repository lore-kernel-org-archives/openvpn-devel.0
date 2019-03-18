MIME-Version: 1.0
References: <CAEYw=WpUJNWUtjoBNkZrewsTxcbxfOe5u=t5vxuyMzsb6Z=Eug@...278...>
 <6bd0356c-ed50-6602-c39c-9a41ad5b31cb@...1856...>
In-Reply-To: <6bd0356c-ed50-6602-c39c-9a41ad5b31cb@...1856...>
From: Pieter Hulshoff <pieter.hulshoff@...2499...>
Date: Mon, 18 Mar 2019 09:12:54 +0100
Message-ID: <CAEYw=WqfxxK7yz55H2Ldh98EW=FQm8C_FTq9GKQJtUisiXvHQA@...278...>
Content-Type: multipart/alternative; boundary="0000000000003fda5e058459f506"
Subject: Re: [Openvpn-devel] [Openvpn-users] Why is the authentication tag
 transmitted before the encrypted data?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-users@lists.sourceforge.net, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--0000000000003fda5e058459f506
Content-Type: text/plain; charset="UTF-8"

Hello Steffan,

Op zo 17 mrt. 2019 om 09:31 schreef Steffan Karger <steffan@...1856...>:

> As far as I understand, mostly because the V1 data channel protocol put
> the HMAC before the ciphertext. James might remember why the original
> data channel protocol put the tag in front.
>
> The current GCM wire spec was proposed by James in
> <54648EAC.70204@...515...>
> (
> https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg09516.html
> ).
>
> I had a short (off-list) discussion with James in 2015 where I proposed
> moving the tag to the end of the data frame, to facilitate hardware
> implementations. But because (software) implementation of the proposed
> protocol had already progressed, we ended up not adopting that proposal.
>

Your (unanswered) question in the discussion on that topic was actually
what triggered my question, Steffan. :) From a software design perspective,
I can understand how having the tag at a specific location can be handy,
but from a telecom hardware based streaming perspective it is a tad
unfortunate. Since I'm mostly involved with the latter, I ran into this
issue when designing the architecture for our next development cycle.I
compared it with MACsec, because in the past I've been involved with
implementing that in hardware (up to 400 Gb/s).

Kind regards,

Pieter Hulshoff

--0000000000003fda5e058459f506
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:arial,helvetica,sans-serif">Hello Steffan,</div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Op zo 17 mrt. 2019=
 om 09:31 schreef Steffan Karger &lt;<a href=3D"mailto:steffan@...1856...">=
steffan@...1856...</a>&gt;:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">As far as I understand, mostly because the V1 data channel prot=
ocol put<br>
the HMAC before the ciphertext. James might remember why the original<br>
data channel protocol put the tag in front.<br>
<br>
The current GCM wire spec was proposed by James in<br>
&lt;<a href=3D"mailto:54648EAC.70204@...515..." target=3D"_blank">54648EAC.=
70204@...515...</a>&gt;<br>
(<a href=3D"https://www.mail-archive.com/openvpn-devel@...475...=
t/msg09516.html" rel=3D"noreferrer" target=3D"_blank">https://www.mail-arch=
ive.com/openvpn-devel@lists.sourceforge.net/msg09516.html</a>).<br>
<br>
I had a short (off-list) discussion with James in 2015 where I proposed<br>
moving the tag to the end of the data frame, to facilitate hardware<br>
implementations. But because (software) implementation of the proposed<br>
protocol had already progressed, we ended up not adopting that proposal.<br=
></blockquote><div><br></div><div class=3D"gmail_default" style=3D"font-fam=
ily:arial,helvetica,sans-serif">Your (unanswered) question in the discussio=
n on that topic was actually what triggered my question, Steffan. :) From a=
 software design perspective, I can understand how having the tag at a spec=
ific location can be handy, but from a telecom hardware based streaming per=
spective it is a tad unfortunate. Since I&#39;m mostly involved with the la=
tter, I ran into this issue when designing the architecture for our next de=
velopment cycle.I compared it with MACsec, because in the past I&#39;ve bee=
n involved with implementing that in hardware (up to 400 Gb/s).</div><div c=
lass=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif"><br=
></div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sa=
ns-serif">Kind regards,</div><div class=3D"gmail_default" style=3D"font-fam=
ily:arial,helvetica,sans-serif"><br></div><div class=3D"gmail_default" styl=
e=3D"font-family:arial,helvetica,sans-serif">Pieter Hulshoff</div><div clas=
s=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif"><br></=
div></div></div>

--0000000000003fda5e058459f506--

