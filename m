MIME-Version: 1.0
References: <CAEYw=WoZDJap1cwCh-SAqJr8KiQEv80XmBkVbVijTbCbOCOP0g@...278...>
In-Reply-To: <CAEYw=WoZDJap1cwCh-SAqJr8KiQEv80XmBkVbVijTbCbOCOP0g@...278...>
From: Pieter Hulshoff <pieter.hulshoff@...2499...>
Date: Fri, 26 Apr 2019 15:32:02 +0200
Message-ID: <CAEYw=Wqna4PnOf+ZQV2sqkrQ6sLdCUQgwxRnrFBVuRx60uAbZA@...278...>
Content-Type: multipart/alternative; boundary="00000000000066f16805876ef660"
Subject: Re: [Openvpn-devel] Client reconnect issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Openvpn-users@lists.sourceforge.net, Gert Doering <gert@...1296...>

--00000000000066f16805876ef660
Content-Type: text/plain; charset="UTF-8"

Gert,

Op vr 19 apr. 2019 om 13:38 schreef Pieter Hulshoff <
pieter.hulshoff@...2499...>:

> I've been looking at https://community.openvpn.net/openvpn/ticket/880 for
> a while now, and was wondering if there'd been any answers to this problem
> yet. It appears that mbedtls (according to krzee the problem disappeared
> when using OpenSSL, but since I use OpenVPN-NL that's not an option for me)
> refuses to answer a PUSH request for a connection it considers to already
> exist. As a result, a reconnect (e.g. after a client reboot) will stall
> until the reconnect timer exceeds the server's time-out, after which the
> server closes the connection, and accepts the following reconnect attempt.
> Reconnect from a 2.3.9 client is stalled indefinitely, since the re-connect
> seems fixed at 2 seconds.
>
> Using nobind will also solve the issue, since the server will see it as a
> new connection, but I'm not sure nobind is a proper solution for everyone.
>
> Any thoughts on this matter? Is it true that this only happens with
> mbedtls, and as such should this issue be taken up with that community in
> stead of this one? Any idea on why the server would refuse a PUSH request
> for an already existing connection?
>

You were looking into this matter in 2017. Did you ever figure out what the
cause of this issue was, and if so how it could be remedied?

Kind regards,

Pieter Hulshoff

--00000000000066f16805876ef660
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:arial,helvetica,sans-serif">Gert,</div><div class=3D"gmail_default=
" style=3D"font-family:arial,helvetica,sans-serif"><br></div><div class=3D"=
gmail_default" style=3D"font-family:arial,helvetica,sans-serif"><span style=
=3D"font-family:Arial,Helvetica,sans-serif">Op vr 19 apr. 2019 om 13:38 sch=
reef Pieter Hulshoff &lt;<a href=3D"mailto:pieter.hulshoff@...2499...">piet=
er.hulshoff@...2499...</a>&gt;:</span><br></div></div><div class=3D"gmail_q=
uote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><d=
iv style=3D"font-family:arial,helvetica,sans-serif">I&#39;ve been looking a=
t=C2=A0<a href=3D"https://community.openvpn.net/openvpn/ticket/880" target=
=3D"_blank" style=3D"font-family:Arial,Helvetica,sans-serif">https://commun=
ity.openvpn.net/openvpn/ticket/880</a>=C2=A0for a while now, and was wonder=
ing if there&#39;d been any answers to this problem yet. It appears that mb=
edtls (according to krzee the problem disappeared when using OpenSSL, but s=
ince I use OpenVPN-NL that&#39;s not an option for me) refuses to answer a =
PUSH request for a connection it considers to already exist. As a result, a=
 reconnect (e.g. after a client reboot) will stall until the reconnect time=
r exceeds the server&#39;s time-out, after which the server closes the conn=
ection, and accepts the following reconnect attempt. Reconnect from a 2.3.9=
 client is stalled indefinitely, since the re-connect seems fixed at 2 seco=
nds.<br></div><div style=3D"font-family:arial,helvetica,sans-serif"><br></d=
iv><div style=3D"font-family:arial,helvetica,sans-serif">Using nobind will =
also solve the issue, since the server will see it as a new connection, but=
 I&#39;m not sure nobind is a proper solution for everyone.</div><div style=
=3D"font-family:arial,helvetica,sans-serif"><br></div><div style=3D"font-fa=
mily:arial,helvetica,sans-serif">Any thoughts on this matter? Is it true th=
at this only happens with mbedtls, and as such should this issue be taken u=
p with that community in stead of this one? Any idea on why the server woul=
d refuse a PUSH request for an already existing connection?</div></div></bl=
ockquote><div><br></div><div class=3D"gmail_default" style=3D"font-family:a=
rial,helvetica,sans-serif">You were looking into this matter in 2017. Did y=
ou ever figure out what the cause of this issue was, and if so how it could=
 be remedied?</div><div class=3D"gmail_default" style=3D"font-family:arial,=
helvetica,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-=
family:arial,helvetica,sans-serif">Kind regards,</div><div class=3D"gmail_d=
efault" style=3D"font-family:arial,helvetica,sans-serif"><br></div><div cla=
ss=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">Piete=
r Hulshoff</div><div class=3D"gmail_default" style=3D"font-family:arial,hel=
vetica,sans-serif"><br></div></div></div>

--00000000000066f16805876ef660--

