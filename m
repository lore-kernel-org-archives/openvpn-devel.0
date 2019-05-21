MIME-Version: 1.0
References: <CAEYw=WoZDJap1cwCh-SAqJr8KiQEv80XmBkVbVijTbCbOCOP0g@...278...>
 <CAEYw=Wqna4PnOf+ZQV2sqkrQ6sLdCUQgwxRnrFBVuRx60uAbZA@...278...>
 <bbf01b87-32bf-f234-cd95-6b5738ad463b@...1147...>
 <59329176-c948-a816-d128-4601d7720dcd@...2181...>
 <0600680d-4eb6-0790-9990-26a7cdf0b7cc@...1147...>
 <CAEYw=Woe1ycyBRx=FtL9pQOhSr66-Njwr5x3VR_46DFMQ9W52w@...278...>
 <CAEYw=WrCmqAwGDY=xEtL7Huy6pDvXVY=fgwrPz0zndKtdM1XRA@...278...>
 <20190426175629.GK31008@...1296...>
In-Reply-To: <20190426175629.GK31008@...1296...>
From: Pieter Hulshoff <pieter.hulshoff@...2499...>
Date: Tue, 21 May 2019 09:18:32 +0200
Message-ID: <CAEYw=WpHefDPtjU0nmY_k0rGsDKHLFT_5JmupG2VF4--ZeQtZg@...278...>
Content-Type: multipart/alternative; boundary="000000000000b0925a058960a843"
Subject: Re: [Openvpn-devel] Client reconnect issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Openvpn-users@lists.sourceforge.net
Cc: Jan Just Keijser <janjust@...1147...>, Antonio Quartulli <a@...2181...>, Gert Doering <gert@...1296...>

--000000000000b0925a058960a843
Content-Type: text/plain; charset="UTF-8"

Hallo all,

Op vr 26 apr. 2019 om 19:56 schreef Gert Doering <gert@...1296...>:

> On Fri, Apr 26, 2019 at 04:55:36PM +0200, Pieter Hulshoff wrote:
> > As you can see, the message is never actually decrypted after the
> > reconnect, and as such the server will never receive it.
>
> So that's most certainly a bug, but not related to the suppression
> of PUSH_REPLY messages - but "something handshake crypto mumble mumble".
>
> I'm not the one who understands these bits, though...
>

Who would be the best person to approach regarding this issue? It was
originally reported 2 years ago (
https://community.openvpn.net/openvpn/ticket/880), but perhaps wasn't
properly identified as bug at that time.

Kind regards,

Pieter Hulshoff

--000000000000b0925a058960a843
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:arial,helvetica,sans-serif">Hallo all,</div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Op vr 26 apr. 2019 o=
m 19:56 schreef Gert Doering &lt;<a href=3D"mailto:gert@...1296...">gert@...1186...=
.1296...</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On Fri, Apr 26, 2019 at 04:55:36PM +0200, Pieter Hulshoff wrote:<br>
&gt; As you can see, the message is never actually decrypted after the<br>
&gt; reconnect, and as such the server will never receive it.<br>
<br>
So that&#39;s most certainly a bug, but not related to the suppression<br>
of PUSH_REPLY messages - but &quot;something handshake crypto mumble mumble=
&quot;.<br>
<br>
I&#39;m not the one who understands these bits, though...<br></blockquote><=
div><br></div><div class=3D"gmail_default" style=3D"font-family:arial,helve=
tica,sans-serif">Who would be the best person to approach regarding this is=
sue? It was originally reported 2 years ago (<a href=3D"https://community.o=
penvpn.net/openvpn/ticket/880" style=3D"font-family:Arial,Helvetica,sans-se=
rif">https://community.openvpn.net/openvpn/ticket/880</a>), but perhaps was=
n&#39;t properly identified as bug at that time.</div><div class=3D"gmail_d=
efault" style=3D"font-family:arial,helvetica,sans-serif"><br></div><div cla=
ss=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">Kind =
regards,</div><div class=3D"gmail_default" style=3D"font-family:arial,helve=
tica,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-famil=
y:arial,helvetica,sans-serif">Pieter Hulshoff</div><div class=3D"gmail_defa=
ult" style=3D"font-family:arial,helvetica,sans-serif"><br></div></div></div>

--000000000000b0925a058960a843--

