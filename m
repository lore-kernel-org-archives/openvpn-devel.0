MIME-Version: 1.0
In-Reply-To: <7bc9701e-b5dd-f9cb-7edf-76e38e36f6a2@...2080...>
References: <CAFHpkQHuJmbYk2G58-VdexeUbrrYT1Qz+HdrZ9HZps3QuZD6ZA@...278...>
 <2764e29d-928d-a643-6fa7-0554ff7b7dfa@...2080...>
 <CAFHpkQEcyz9q=kYx6CM_kT9Jm3YFG9EZRe08NZnLm-G+knDktA@...278...>
 <e6c5f73e-2920-3e30-2539-702632d30e43@...2080...>
 <CAFHpkQHPpkb2GfsV4y7B3GntpoQ0JzZz2X+rWffYqexbiJzgYg@...278...>
 <9561c64d-3c54-b65b-9fce-f99b4ef9c3b3@...2080...>
 <CAFHpkQHZXbMDBPXV=dGWYs0M2B4C9AU-FY4KE2pCZqsxe5iJbw@...278...>
 <7bc9701e-b5dd-f9cb-7edf-76e38e36f6a2@...2080...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 6 Oct 2017 16:41:54 +0500
Message-ID: <CAFHpkQEURezQAdY0zWe6B_STEecscFQDZpXSrw4AgS-FFNDa4w@...278...>
Content-Type: multipart/alternative; boundary="001a113d206ae2a2d0055adf53ae"
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

--001a113d206ae2a2d0055adf53ae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-10-06 16:23 GMT+05:00 David Sommerseth <
openvpn@...2080...>:

> On 06/10/17 11:52, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> [...snip...]
> >     >
> >     >     In addition, what happens when you try to use a revoked
> *client*
> >     >     certificate when connecting to an HTTPS server demanding clie=
nt
> >     >     certificates to be present?
> >     >
> >     >
> >     > 403
> >     >
> >     > (with customizable error message)
> >     Really?  That shouldn't be possible, as you don't have an establish=
ed
> >     TLS connection to provide the HTTP 403 response.  Because the server
> >     should reject the connection as the *client* certificate is invalid.
> >
> >
> >
> > I did test on IIS with "certificate required", when you connect without
> > cert, you can see 403.
> > ok, I'll test with revoked cert as well
>
> Okay, I've done some testing with my own Nginx server.  HTTPS is
> actually different from the plain SSL/TLS protocol.
>
> In HTTPS, the client certificate transfer is handled differently, where
> it exists an unauthenticated TLS connection when invalid certificates
> are sent to the server.  This allows the server to respond with HTTP 40*
> messages over HTTPS.
>
> When trying the same using openssl s_client and s_server, the server
> side instantly dumps a "certificate verify failed" message and it
> disconnects.
>
> This latter behaviour is the approach implemented in OpenVPN.  And I
> doubt this can easily be changed, to have an unauthenticated response
> channel, without breaking backwards compatibility with older clients.
> We need to facilitate a few other approaches which ensures the clients
> won't get confused.
>
> Since both these HTTPS and the s_client/s_server tests happens over TCP
> (as SSL/TLS is strictly designed for TCP only; which is why OpenVPN
> encapsulates the SSL/TLS packets to allow it to use UDP), the client
> will also disconnect when the TCP socket gets closed.  This is not
> possible with UDP sockets, and is why why have --explicit-exit-notify
> for UDP connections, to simulate the TCP FIN behaviour.
>
> I hope this makes sense.
>

yes, it does


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

--001a113d206ae2a2d0055adf53ae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-10-06 16:23 GMT+05:00 David Sommerseth <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2080...</a>&g=
t;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">On 06/10/17 11:52, =D0=98=D0=
=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD wrote:<br>
[...snip...]<br>
<span class=3D"">&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0In addition, what happens w=
hen you try to use a revoked *client*<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0certificate when connecting=
 to an HTTPS server demanding client<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0certificates to be present?=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; 403<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; (with customizable error message)<br>
&gt;=C2=A0 =C2=A0 =C2=A0Really?=C2=A0 That shouldn&#39;t be possible, as yo=
u don&#39;t have an established<br>
&gt;=C2=A0 =C2=A0 =C2=A0TLS connection to provide the HTTP 403 response.=C2=
=A0 Because the server<br>
&gt;=C2=A0 =C2=A0 =C2=A0should reject the connection as the *client* certif=
icate is invalid.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; I did test on IIS with &quot;certificate required&quot;, when you conn=
ect without<br>
&gt; cert, you can see 403.<br>
&gt; ok, I&#39;ll test with revoked cert as well<br>
<br>
</span>Okay, I&#39;ve done some testing with my own Nginx server.=C2=A0 HTT=
PS is<br>
actually different from the plain SSL/TLS protocol.<br>
<br>
In HTTPS, the client certificate transfer is handled differently, where<br>
it exists an unauthenticated TLS connection when invalid certificates<br>
are sent to the server.=C2=A0 This allows the server to respond with HTTP 4=
0*<br>
messages over HTTPS.<br>
<br>
When trying the same using openssl s_client and s_server, the server<br>
side instantly dumps a &quot;certificate verify failed&quot; message and it=
<br>
disconnects.<br>
<br>
This latter behaviour is the approach implemented in OpenVPN.=C2=A0 And I<b=
r>
doubt this can easily be changed, to have an unauthenticated response<br>
channel, without breaking backwards compatibility with older clients.<br>
We need to facilitate a few other approaches which ensures the clients<br>
won&#39;t get confused.<br>
<br>
Since both these HTTPS and the s_client/s_server tests happens over TCP<br>
(as SSL/TLS is strictly designed for TCP only; which is why OpenVPN<br>
encapsulates the SSL/TLS packets to allow it to use UDP), the client<br>
will also disconnect when the TCP socket gets closed.=C2=A0 This is not<br>
possible with UDP sockets, and is why why have --explicit-exit-notify<br>
for UDP connections, to simulate the TCP FIN behaviour.<br>
<br>
I hope this makes sense.<br></blockquote><div><br></div><div>yes, it does<b=
r></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
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

--001a113d206ae2a2d0055adf53ae--

