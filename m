MIME-Version: 1.0
In-Reply-To: <2764e29d-928d-a643-6fa7-0554ff7b7dfa@...2080...>
References: <CAFHpkQHuJmbYk2G58-VdexeUbrrYT1Qz+HdrZ9HZps3QuZD6ZA@...278...>
 <2764e29d-928d-a643-6fa7-0554ff7b7dfa@...2080...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 6 Oct 2017 14:02:34 +0500
Message-ID: <CAFHpkQEcyz9q=kYx6CM_kT9Jm3YFG9EZRe08NZnLm-G+knDktA@...278...>
Content-Type: multipart/alternative; boundary="001a11c14f7c0f866d055add1a86"
Subject: Re: [Openvpn-devel] better handling of revoked certs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11c14f7c0f866d055add1a86
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-10-06 13:43 GMT+05:00 David Sommerseth <
openvpn@...2080...>:

> On 06/10/17 08:58, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> > Hello,
> >
> > I used to run openvpn in login/password mode for years.
> > now, I'm getting working certificate setup.
> >
> >
> > what I found strange about revoked certificates ... from client point of
> > view it looks like any other "tls key negotiation timeout"
> >
> > is there a way to signal user "hey, you key is revoked" ?
>
> Nope, not in the current implementation and design.  To be able to
> signal that, you need to have some established a connection.  And that
> cannot be done unless the client provides a valid certificate.  If the
> certificate is invalid (issued by wrong CA, expired, revoked), the
> server just drops the ball.
>
> Perhaps we could look into adding a new OPCODE which could signal
> connection errors.  But that needs to be very carefully implemented so
> we don't open up for various DoS attacks or more effective bruteforce
> attacks.  Such a message would also need to be verifiable too, otherwise
> it would be too easy for a filtering firewall or gateway to just respond
> back with such a rejection message instead of passing the packet
> further; effectively shutting down clients with the wrong presumptions.
> Plus it needs to be implemented in the OpenVPN 3 Core library as well
> (which OpenVPN Connect clients uses).  So this isn't even a quick-fix.
>
> But I would also be very cautious about providing reasons back to
> clients though.  For all these various invalid certificate scenarios we
> definitely should not give a too fine grained explanation.  IMO, only a
> "Invalid certificate" message should be considered.
>
>
taking all the above into account, I would compare things in "https" world.
both "server cert error" and "client cert error" are handled in somewhat
friendly way (without considering such additional information as a security
breach)


>
> --
> kind regards,
>
> David Sommerseth
> OpenVPN, Inc
>
>
>

--001a11c14f7c0f866d055add1a86
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-10-06 13:43 GMT+05:00 David Sommerseth <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2080...</a>&g=
t;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 06/10/17 0=
8:58, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD w=
rote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; I used to run openvpn in login/password mode for years.<br>
&gt; now, I&#39;m getting working certificate setup.<br>
&gt;<br>
&gt;<br>
&gt; what I found strange about revoked certificates ... from client point =
of<br>
&gt; view it looks like any other &quot;tls key negotiation timeout&quot;<b=
r>
&gt;<br>
&gt; is there a way to signal user &quot;hey, you key is revoked&quot; ?<br>
<br>
</span>Nope, not in the current implementation and design.=C2=A0 To be able=
 to<br>
signal that, you need to have some established a connection.=C2=A0 And that=
<br>
cannot be done unless the client provides a valid certificate.=C2=A0 If the=
<br>
certificate is invalid (issued by wrong CA, expired, revoked), the<br>
server just drops the ball.<br>
<br>
Perhaps we could look into adding a new OPCODE which could signal<br>
connection errors.=C2=A0 But that needs to be very carefully implemented so=
<br>
we don&#39;t open up for various DoS attacks or more effective bruteforce<b=
r>
attacks.=C2=A0 Such a message would also need to be verifiable too, otherwi=
se<br>
it would be too easy for a filtering firewall or gateway to just respond<br>
back with such a rejection message instead of passing the packet<br>
further; effectively shutting down clients with the wrong presumptions.<br>
Plus it needs to be implemented in the OpenVPN 3 Core library as well<br>
(which OpenVPN Connect clients uses).=C2=A0 So this isn&#39;t even a quick-=
fix.<br>
<br>
But I would also be very cautious about providing reasons back to<br>
clients though.=C2=A0 For all these various invalid certificate scenarios w=
e<br>
definitely should not give a too fine grained explanation.=C2=A0 IMO, only =
a<br>
&quot;Invalid certificate&quot; message should be considered.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br></font></span></blockquo=
te><div><br></div><div>taking all the above into account, I would compare t=
hings in &quot;https&quot; world.<br></div><div>both &quot;server cert erro=
r&quot; and &quot;client cert error&quot; are handled in somewhat friendly =
way (without considering such additional information as a security breach)<=
br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"HOE=
nZb"><font color=3D"#888888">
<br>
--<br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN, Inc<br>
<br>
<br>
</font></span></blockquote></div><br></div></div>

--001a11c14f7c0f866d055add1a86--

