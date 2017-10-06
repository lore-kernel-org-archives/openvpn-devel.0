MIME-Version: 1.0
In-Reply-To: <9561c64d-3c54-b65b-9fce-f99b4ef9c3b3@...2080...>
References: <CAFHpkQHuJmbYk2G58-VdexeUbrrYT1Qz+HdrZ9HZps3QuZD6ZA@...278...>
 <2764e29d-928d-a643-6fa7-0554ff7b7dfa@...2080...>
 <CAFHpkQEcyz9q=kYx6CM_kT9Jm3YFG9EZRe08NZnLm-G+knDktA@...278...>
 <e6c5f73e-2920-3e30-2539-702632d30e43@...2080...>
 <CAFHpkQHPpkb2GfsV4y7B3GntpoQ0JzZz2X+rWffYqexbiJzgYg@...278...>
 <9561c64d-3c54-b65b-9fce-f99b4ef9c3b3@...2080...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 6 Oct 2017 14:52:28 +0500
Message-ID: <CAFHpkQHZXbMDBPXV=dGWYs0M2B4C9AU-FY4KE2pCZqsxe5iJbw@...278...>
Content-Type: multipart/alternative; boundary="001a113ec2ac836549055addcc62"
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

--001a113ec2ac836549055addcc62
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-10-06 14:42 GMT+05:00 David Sommerseth <
openvpn@...2080...>:

> On 06/10/17 11:37, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> >
> >
> > 2017-10-06 14:11 GMT+05:00 David Sommerseth
> > <openvpn@...2080...
> > <mailto:openvpn@...2080...>>:
> >
> >     On 06/10/17 11:02, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD wrote:
> >     >
> >     >
> >     > 2017-10-06 13:43 GMT+05:00 David Sommerseth
> >     > <openvpn@...2080...
> >     <mailto:openvpn@...2080...>
> >     > <mailto:openvpn@...2080...
> >     <mailto:openvpn@...2080...>>>:
> >     >
> >     >     On 06/10/17 08:58, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD wrote:
> >     >     > Hello,
> >     >     >
> >     >     > I used to run openvpn in login/password mode for years.
> >     >     > now, I'm getting working certificate setup.
> >     >     >
> >     >     >
> >     >     > what I found strange about revoked certificates ... from
> >     client point of
> >     >     > view it looks like any other "tls key negotiation timeout"
> >     >     >
> >     >     > is there a way to signal user "hey, you key is revoked" ?
> >     >
> >     >     Nope, not in the current implementation and design.  To be
> able to
> >     >     signal that, you need to have some established a connection.
> >     And that
> >     >     cannot be done unless the client provides a valid
> >     certificate.  If the
> >     >     certificate is invalid (issued by wrong CA, expired, revoked),
> the
> >     >     server just drops the ball.
> >     >
> >     >     Perhaps we could look into adding a new OPCODE which could
> signal
> >     >     connection errors.  But that needs to be very carefully
> >     implemented so
> >     >     we don't open up for various DoS attacks or more effective
> >     bruteforce
> >     >     attacks.  Such a message would also need to be verifiable too,
> >     otherwise
> >     >     it would be too easy for a filtering firewall or gateway to
> >     just respond
> >     >     back with such a rejection message instead of passing the
> packet
> >     >     further; effectively shutting down clients with the wrong
> >     presumptions.
> >     >     Plus it needs to be implemented in the OpenVPN 3 Core library
> >     as well
> >     >     (which OpenVPN Connect clients uses).  So this isn't even a
> >     quick-fix.
> >     >
> >     >     But I would also be very cautious about providing reasons back
> to
> >     >     clients though.  For all these various invalid certificate
> >     scenarios we
> >     >     definitely should not give a too fine grained explanation.
> >     IMO, only a
> >     >     "Invalid certificate" message should be considered.
> >     >
> >     >
> >     > taking all the above into account, I would compare things in
> >     "https" world.
> >     > both "server cert error" and "client cert error" are handled in
> >     somewhat
> >     > friendly way (without considering such additional information as a
> >     > security breach)
> >
> >     But the OpenVPN wire protocol is anything similar to standard SSL/T=
LS
> >     protocols.  The SSL/TLS protocol is wrapped into an OpenVPN
> container,
> >     where the SSL/TLS specifics packets happens in a limited set of of
> the
> >     OpenVPN wire protocol, most commonly referred to as the control
> channel.
> >
> >     In addition, what happens when you try to use a revoked *client*
> >     certificate when connecting to an HTTPS server demanding client
> >     certificates to be present?
> >
> >
> > 403
> >
> > (with customizable error message)
> Really?  That shouldn't be possible, as you don't have an established
> TLS connection to provide the HTTP 403 response.  Because the server
> should reject the connection as the *client* certificate is invalid.
>


I did test on IIS with "certificate required", when you connect without
cert, you can see 403.
ok, I'll test with revoked cert as well


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

--001a113ec2ac836549055addcc62
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-10-06 14:42 GMT+05:00 David Sommerseth <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2080...</a>&g=
t;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 06/10/17 1=
1:37, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD w=
rote:<br>
&gt;<br>
&gt;<br>
&gt; 2017-10-06 14:11 GMT+05:00 David Sommerseth<br>
&gt; &lt;<a href=3D"mailto:openvpn@...2080...">openvpn@...2142...<wbr>topph=
emmelig.net</a><br>
</span>&gt; &lt;mailto:<a href=3D"mailto:openvpn@...2080...">openvpn@...2261...=
2...<wbr>topphemmelig.net</a>&gt;&gt;:<br>
<span class=3D"">&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0On 06/10/17 11:02, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=
=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; 2017-10-06 13:43 GMT+05:00 David Sommerseth<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &lt;<a href=3D"mailto:openvpn@...2080...">open=
vpn@...2142...<wbr>topphemmelig.net</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:openvpn@...2080...">op=
envpn@...2142...<wbr>topphemmelig.net</a>&gt;<br>
</span>&gt;=C2=A0 =C2=A0 =C2=A0&gt; &lt;mailto:<a href=3D"mailto:openvpn@...1186...=
.2080...">openvpn@...2142...<wbr>topphemmelig.net</a><br>
<div><div class=3D"h5">&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto=
:openvpn@...2080...">openvpn@...2142...<wbr>topphemmelig.net</a>&gt;&gt;&gt=
;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0On 06/10/17 08:58, =D0=98=
=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; Hello,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; I used to run openvpn =
in login/password mode for years.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; now, I&#39;m getting w=
orking certificate setup.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; what I found strange a=
bout revoked certificates ... from<br>
&gt;=C2=A0 =C2=A0 =C2=A0client point of<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; view it looks like any=
 other &quot;tls key negotiation timeout&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; is there a way to sign=
al user &quot;hey, you key is revoked&quot; ?<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Nope, not in the current im=
plementation and design.=C2=A0 To be able to<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0signal that, you need to ha=
ve some established a connection.=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0And that<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0cannot be done unless the c=
lient provides a valid<br>
&gt;=C2=A0 =C2=A0 =C2=A0certificate.=C2=A0 If the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0certificate is invalid (iss=
ued by wrong CA, expired, revoked), the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0server just drops the ball.=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Perhaps we could look into =
adding a new OPCODE which could signal<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0connection errors.=C2=A0 Bu=
t that needs to be very carefully<br>
&gt;=C2=A0 =C2=A0 =C2=A0implemented so<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0we don&#39;t open up for va=
rious DoS attacks or more effective<br>
&gt;=C2=A0 =C2=A0 =C2=A0bruteforce<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0attacks.=C2=A0 Such a messa=
ge would also need to be verifiable too,<br>
&gt;=C2=A0 =C2=A0 =C2=A0otherwise<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0it would be too easy for a =
filtering firewall or gateway to<br>
&gt;=C2=A0 =C2=A0 =C2=A0just respond<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0back with such a rejection =
message instead of passing the packet<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0further; effectively shutti=
ng down clients with the wrong<br>
&gt;=C2=A0 =C2=A0 =C2=A0presumptions.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Plus it needs to be impleme=
nted in the OpenVPN 3 Core library<br>
&gt;=C2=A0 =C2=A0 =C2=A0as well<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0(which OpenVPN Connect clie=
nts uses).=C2=A0 So this isn&#39;t even a<br>
&gt;=C2=A0 =C2=A0 =C2=A0quick-fix.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0But I would also be very ca=
utious about providing reasons back to<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0clients though.=C2=A0 For a=
ll these various invalid certificate<br>
&gt;=C2=A0 =C2=A0 =C2=A0scenarios we<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0definitely should not give =
a too fine grained explanation.=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0IMO, only a<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&quot;Invalid certificate&q=
uot; message should be considered.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; taking all the above into account, I would com=
pare things in<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;https&quot; world.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; both &quot;server cert error&quot; and &quot;c=
lient cert error&quot; are handled in<br>
&gt;=C2=A0 =C2=A0 =C2=A0somewhat<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; friendly way (without considering such additio=
nal information as a<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; security breach)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0But the OpenVPN wire protocol is anything similar t=
o standard SSL/TLS<br>
&gt;=C2=A0 =C2=A0 =C2=A0protocols.=C2=A0 The SSL/TLS protocol is wrapped in=
to an OpenVPN container,<br>
&gt;=C2=A0 =C2=A0 =C2=A0where the SSL/TLS specifics packets happens in a li=
mited set of of the<br>
&gt;=C2=A0 =C2=A0 =C2=A0OpenVPN wire protocol, most commonly referred to as=
 the control channel.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0In addition, what happens when you try to use a rev=
oked *client*<br>
&gt;=C2=A0 =C2=A0 =C2=A0certificate when connecting to an HTTPS server dema=
nding client<br>
&gt;=C2=A0 =C2=A0 =C2=A0certificates to be present?<br>
&gt;<br>
&gt;<br>
&gt; 403<br>
&gt;<br>
&gt; (with customizable error message)<br>
</div></div>Really?=C2=A0 That shouldn&#39;t be possible, as you don&#39;t =
have an established<br>
TLS connection to provide the HTTP 403 response.=C2=A0 Because the server<b=
r>
should reject the connection as the *client* certificate is invalid.<br></b=
lockquote><div><br><br></div><div>I did test on IIS with &quot;certificate =
required&quot;, when you connect without cert, you can see 403.<br></div><d=
iv>ok, I&#39;ll test with revoked cert as well<br></div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
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

--001a113ec2ac836549055addcc62--

