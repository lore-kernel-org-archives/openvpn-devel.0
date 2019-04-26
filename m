MIME-Version: 1.0
References: <CAEYw=WoZDJap1cwCh-SAqJr8KiQEv80XmBkVbVijTbCbOCOP0g@...278...>
 <CAEYw=Wqna4PnOf+ZQV2sqkrQ6sLdCUQgwxRnrFBVuRx60uAbZA@...278...>
 <24961e3f-19da-a7b3-50db-d67aef792b62@...2181...>
In-Reply-To: <24961e3f-19da-a7b3-50db-d67aef792b62@...2181...>
From: Pieter Hulshoff <pieter.hulshoff@...2499...>
Date: Fri, 26 Apr 2019 16:16:35 +0200
Message-ID: <CAEYw=WqAYxSvofw4dKbjsa2G78TShPV1L9Y77+yY7vQkuxUWwA@...278...>
Content-Type: multipart/alternative; boundary="000000000000be4be405876f95cf"
Subject: Re: [Openvpn-devel] Client reconnect issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Openvpn-users@lists.sourceforge.net

--000000000000be4be405876f95cf
Content-Type: text/plain; charset="UTF-8"

Hello Antonio,

Op vr 26 apr. 2019 om 15:47 schreef Antonio Quartulli <a@...2181...>:

> This said, OpenVPN has a protection that prevents a server to reply to a
> PUSH_REQUEST from the same client more than once within 30 seconds.
>
> Therefore if you are shutting down a client and restarting it within
> this short timeframe, it is expected that you won't get any PUSH_REPLY.
>
> Does this match your observations?
>

No, unfortunately it does not. This suggestion was also offered by Gert in
2017, but I tried disconnecting after a 2 minute connection, and the issue
remained.


> If not, could you please mention step by step what to do to reproduce
> the faulty problem?
>

The ticket also contains a step description, and it's rather simple:
Set up a server using OpenVPN-NL 2.4.4 or above (I last tried this with
2.4.6).
Set up a client using OpenVPN 2.3.9 with a bound client port (so the server
sees a new connection as the same connection).
Connect the client to the server. Keep the connection up for as long as you
like.
Close the client (CTRL-C in Linux worked well), and restart it immediately.
Using OpenVPN 2.3.9 client, you will never reconnect.
Using OpenVPN 2.4.4+ client, you will reconnect after the increasing
reconnect timer exceeds the server time-out setting.

Note: that using nobind probably fools this logic because the client
> will re-connect using a different source port and thus will be
> recognized as different.
>

That was my conclusion as well. :)
Kind regards,

Pieter Hulshoff

--000000000000be4be405876f95cf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:arial,helvetica,sans-serif">Hello Antonio,</div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Op vr 26 apr. 2019=
 om 15:47 schreef Antonio Quartulli &lt;a@...2181...&gt;:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">This said, OpenVPN has a protecti=
on that prevents a server to reply to a<br>
PUSH_REQUEST from the same client more than once within 30 seconds.<br>
<br>
Therefore if you are shutting down a client and restarting it within<br>
this short timeframe, it is expected that you won&#39;t get any PUSH_REPLY.=
<br>
<br>
Does this match your observations?<br></blockquote><div><br></div><div><div=
 class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">N=
o, unfortunately it does not. This suggestion was also offered by Gert in 2=
017, but I tried disconnecting after a 2 minute connection, and the issue r=
emained.</div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">If not, could you please mention step by step what to do to rep=
roduce<br>
the faulty problem?<br></blockquote><div><br></div><div><div class=3D"gmail=
_default" style=3D"font-family:arial,helvetica,sans-serif">The ticket also =
contains a step description, and it&#39;s rather simple:</div><div class=3D=
"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">Set up a s=
erver using OpenVPN-NL 2.4.4 or above (I last tried this with 2.4.6).</div>=
<div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-seri=
f">Set up a client using OpenVPN 2.3.9 with a bound client port (so the ser=
ver sees a new connection as the same connection).</div><div class=3D"gmail=
_default" style=3D"font-family:arial,helvetica,sans-serif">Connect the clie=
nt to the server. Keep the connection up for as long as you like.</div><div=
 class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">C=
lose the client (CTRL-C in Linux worked well), and restart it immediately.<=
/div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans=
-serif">Using OpenVPN 2.3.9 client, you will never reconnect.</div><div cla=
ss=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">Using=
 OpenVPN 2.4.4+ client, you will reconnect after the increasing reconnect t=
imer exceeds the server time-out setting.</div></div><div class=3D"gmail_de=
fault" style=3D"font-family:arial,helvetica,sans-serif"><br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
Note: that using nobind probably fools this logic because the client<br>
will re-connect using a different source port and thus will be<br>
recognized as different.<br></blockquote><div><br></div><div class=3D"gmail=
_default" style=3D"font-family:arial,helvetica,sans-serif">That was my conc=
lusion as well. :)</div></div><div><div class=3D"gmail_default" style=3D"fo=
nt-family:arial,helvetica,sans-serif"></div></div><div class=3D"gmail_defau=
lt" style=3D"font-family:arial,helvetica,sans-serif">Kind regards,</div><di=
v class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">=
<br></div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica=
,sans-serif">Pieter Hulshoff</div><div class=3D"gmail_default" style=3D"fon=
t-family:arial,helvetica,sans-serif"><br></div></div>

--000000000000be4be405876f95cf--

