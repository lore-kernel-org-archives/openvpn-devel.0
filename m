MIME-Version: 1.0
In-Reply-To: <e6c5f73e-2920-3e30-2539-702632d30e43@...2080...>
References: <CAFHpkQHuJmbYk2G58-VdexeUbrrYT1Qz+HdrZ9HZps3QuZD6ZA@...278...>
 <2764e29d-928d-a643-6fa7-0554ff7b7dfa@...2080...>
 <CAFHpkQEcyz9q=kYx6CM_kT9Jm3YFG9EZRe08NZnLm-G+knDktA@...278...>
 <e6c5f73e-2920-3e30-2539-702632d30e43@...2080...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 6 Oct 2017 14:37:45 +0500
Message-ID: <CAFHpkQHPpkb2GfsV4y7B3GntpoQ0JzZz2X+rWffYqexbiJzgYg@...278...>
Content-Type: multipart/alternative; boundary="001a11c14f7ce8db84055add9736"
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

--001a11c14f7ce8db84055add9736
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-10-06 14:11 GMT+05:00 David Sommerseth <
openvpn@...2080...>:

> On 06/10/17 11:02, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> >
> >
> > 2017-10-06 13:43 GMT+05:00 David Sommerseth
> > <openvpn@...2080...
> > <mailto:openvpn@...2080...>>:
> >
> >     On 06/10/17 08:58, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD wrote:
> >     > Hello,
> >     >
> >     > I used to run openvpn in login/password mode for years.
> >     > now, I'm getting working certificate setup.
> >     >
> >     >
> >     > what I found strange about revoked certificates ... from client
> point of
> >     > view it looks like any other "tls key negotiation timeout"
> >     >
> >     > is there a way to signal user "hey, you key is revoked" ?
> >
> >     Nope, not in the current implementation and design.  To be able to
> >     signal that, you need to have some established a connection.  And
> that
> >     cannot be done unless the client provides a valid certificate.  If
> the
> >     certificate is invalid (issued by wrong CA, expired, revoked), the
> >     server just drops the ball.
> >
> >     Perhaps we could look into adding a new OPCODE which could signal
> >     connection errors.  But that needs to be very carefully implemented
> so
> >     we don't open up for various DoS attacks or more effective brutefor=
ce
> >     attacks.  Such a message would also need to be verifiable too,
> otherwise
> >     it would be too easy for a filtering firewall or gateway to just
> respond
> >     back with such a rejection message instead of passing the packet
> >     further; effectively shutting down clients with the wrong
> presumptions.
> >     Plus it needs to be implemented in the OpenVPN 3 Core library as we=
ll
> >     (which OpenVPN Connect clients uses).  So this isn't even a
> quick-fix.
> >
> >     But I would also be very cautious about providing reasons back to
> >     clients though.  For all these various invalid certificate scenarios
> we
> >     definitely should not give a too fine grained explanation.  IMO,
> only a
> >     "Invalid certificate" message should be considered.
> >
> >
> > taking all the above into account, I would compare things in "https"
> world.
> > both "server cert error" and "client cert error" are handled in somewhat
> > friendly way (without considering such additional information as a
> > security breach)
>
> But the OpenVPN wire protocol is anything similar to standard SSL/TLS
> protocols.  The SSL/TLS protocol is wrapped into an OpenVPN container,
> where the SSL/TLS specifics packets happens in a limited set of of the
> OpenVPN wire protocol, most commonly referred to as the control channel.
>
> In addition, what happens when you try to use a revoked *client*
> certificate when connecting to an HTTPS server demanding client
> certificates to be present?
>

403

(with customizable error message)


>
>
> --
> kind regards,
>
> David Sommerseth
> OpenVPN, Inc
>
>
>

--001a11c14f7ce8db84055add9736
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-10-06 14:11 GMT+05:00 David Sommerseth <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2080...</a>&g=
t;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 06/10/17 1=
1:02, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD w=
rote:<br>
&gt;<br>
&gt;<br>
&gt; 2017-10-06 13:43 GMT+05:00 David Sommerseth<br>
&gt; &lt;<a href=3D"mailto:openvpn@...2080...">openvpn@...2142...<wbr>topph=
emmelig.net</a><br>
</span>&gt; &lt;mailto:<a href=3D"mailto:openvpn@...2080...">openvpn@...2261...=
2...<wbr>topphemmelig.net</a>&gt;&gt;:<br>
<div><div class=3D"h5">&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0On 06/10/17 08:58, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=
=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Hello,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I used to run openvpn in login/password mode f=
or years.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; now, I&#39;m getting working certificate setup=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; what I found strange about revoked certificate=
s ... from client point of<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; view it looks like any other &quot;tls key neg=
otiation timeout&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; is there a way to signal user &quot;hey, you k=
ey is revoked&quot; ?<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Nope, not in the current implementation and design.=
=C2=A0 To be able to<br>
&gt;=C2=A0 =C2=A0 =C2=A0signal that, you need to have some established a co=
nnection.=C2=A0 And that<br>
&gt;=C2=A0 =C2=A0 =C2=A0cannot be done unless the client provides a valid c=
ertificate.=C2=A0 If the<br>
&gt;=C2=A0 =C2=A0 =C2=A0certificate is invalid (issued by wrong CA, expired=
, revoked), the<br>
&gt;=C2=A0 =C2=A0 =C2=A0server just drops the ball.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Perhaps we could look into adding a new OPCODE whic=
h could signal<br>
&gt;=C2=A0 =C2=A0 =C2=A0connection errors.=C2=A0 But that needs to be very =
carefully implemented so<br>
&gt;=C2=A0 =C2=A0 =C2=A0we don&#39;t open up for various DoS attacks or mor=
e effective bruteforce<br>
&gt;=C2=A0 =C2=A0 =C2=A0attacks.=C2=A0 Such a message would also need to be=
 verifiable too, otherwise<br>
&gt;=C2=A0 =C2=A0 =C2=A0it would be too easy for a filtering firewall or ga=
teway to just respond<br>
&gt;=C2=A0 =C2=A0 =C2=A0back with such a rejection message instead of passi=
ng the packet<br>
&gt;=C2=A0 =C2=A0 =C2=A0further; effectively shutting down clients with the=
 wrong presumptions.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Plus it needs to be implemented in the OpenVPN 3 Co=
re library as well<br>
&gt;=C2=A0 =C2=A0 =C2=A0(which OpenVPN Connect clients uses).=C2=A0 So this=
 isn&#39;t even a quick-fix.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0But I would also be very cautious about providing r=
easons back to<br>
&gt;=C2=A0 =C2=A0 =C2=A0clients though.=C2=A0 For all these various invalid=
 certificate scenarios we<br>
&gt;=C2=A0 =C2=A0 =C2=A0definitely should not give a too fine grained expla=
nation.=C2=A0 IMO, only a<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;Invalid certificate&quot; message should be c=
onsidered.<br>
&gt;<br>
&gt;<br>
&gt; taking all the above into account, I would compare things in &quot;htt=
ps&quot; world.<br>
&gt; both &quot;server cert error&quot; and &quot;client cert error&quot; a=
re handled in somewhat<br>
&gt; friendly way (without considering such additional information as a<br>
&gt; security breach)<br>
<br>
</div></div>But the OpenVPN wire protocol is anything similar to standard S=
SL/TLS<br>
protocols.=C2=A0 The SSL/TLS protocol is wrapped into an OpenVPN container,=
<br>
where the SSL/TLS specifics packets happens in a limited set of of the<br>
OpenVPN wire protocol, most commonly referred to as the control channel.<br>
<br>
In addition, what happens when you try to use a revoked *client*<br>
certificate when connecting to an HTTPS server demanding client<br>
certificates to be present?<br></blockquote><div><br>403<br><br></div><div>=
(with customizable error message)<br></div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
--<br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN, Inc<br>
<br>
<br>
</div></div></blockquote></div><br></div></div>

--001a11c14f7ce8db84055add9736--

