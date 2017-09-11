MIME-Version: 1.0
In-Reply-To: <c0d738c1-2f62-3746-21cd-e451a3d90824@...2080...>
References: <CAFHpkQGG9x_kYP6bthSxgB+1Y38r45ffD1WCnaA+Jp4Ed8PbQw@...278...>
 <cf0cbe5b-238c-8790-5be1-3cb693ac4148@...1147...>
 <CAFHpkQGu93WJEhFMyA1y4RFdL9bJJijdMrQWOMdHt+DU1iVO-g@...278...>
 <CAFHpkQEZDWqMbwU07LGtLVXyN2_VGz3v8jHZdwRAfGg07Jw3wA@...278...>
 <c0d738c1-2f62-3746-21cd-e451a3d90824@...2080...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 11 Sep 2017 18:23:00 +0500
Message-ID: <CAFHpkQFFoiPaBFPWaQhW85+JRjgNW9acM3EMw9p6b1GkZOYYeg@...278...>
Content-Type: multipart/alternative; boundary="001a11408a4e6457760558e9d312"
Subject: Re: [Openvpn-devel] proper configuring of "tls-verify"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11408a4e6457760558e9d312
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-09-11 17:30 GMT+05:00 David Sommerseth <
openvpn@...2080...>:

> On 11/09/17 14:02, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> >
> >
> > 2017-09-11 16:54 GMT+05:00 =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...
> > <mailto:chipitsine@...277...>>:
> >
> >
> >
> >     2017-09-11 16:45 GMT+05:00 Jan Just Keijser <janjust@...1147...
> >     <mailto:janjust@...1147...>>:
> >
> >         Hi,
> >
> >         On 11/09/17 13:22, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD wrote:
> >
> >             Hello,
> >
> >             is someone actually using "tls-verify" in production ?
> >             we tried to implement additional certificate check using
> >             tls-verify
> >
> >
> >             while it works in general, in case when it hits "exit 1", it
> >             look like a timeout from client point of view. it is not any
> >             good
> >
> >
> >         do you mean that when a client is denied access (i.e. the
> >         tls-verify script exits 1 on the server) that the client sees
> >         this as a timeout?  that is "normal" behaviour, as the server
> >         does not tell the client *WHY* access is refused - it simply
> >         stop responding to a client that does not pass
> >         authentication/authorization. The client will not hear from the
> >         server, and will time out after a specified interval.  This is
> >         actually the most secure way to do things, as a rogue client
> >         cannot DoS a server this way.
> >
> >
> >     I'd say it depends.
> >
> >     we run a lot of openvpn-gui with real people sitting in front of
> >     them, from their point of view it "oh, it does not work! fix it!"
> >     in out case better UX is to deliver proper reason to the client
> >
> >     for someone maybe the better UX is to keep silence
> >
> >
> >
> > what is wrong with timeout is endless retry.
> > there's no way to pass authentication once it failed, so why does client
> > have to retry ?
>
> User-friendliness and security seldom walks hand-in-hand.  As this
> friendliness provides enough information fragments for an attacker to
> figure out "I need to try something else".  A non-responding server
> gives no clues.  It can be a crappy server or it can be access denied;
> the attacker doesn't know - thus making it harder to figure out what to
> do next.
>


an attacker can brute force a password, for example.
but what do you mean "to try next" in case of ssl certificate ?


>
> The client will by default try to reconnect, because that is what it in
> most cases is told to do when the server is unresponsive.  And since
> this happens with many seconds in between, a single client will not
> attempt to DoS a server by mistake by retrying in a too tight loop.
>
> A failed authentication is a failed authentication.  Thus UX client
> front-ends could treat this silence like that - but also account for
> other types of connectivity issues.  If it should try to reconnect or
> not, well, that's entirely up to the configuration file.   There is
> --single-session which can be used to control this.
>
> But for servers running OpenVPN clients, retrying indefinitely at
>

if retry might be successful, yes.
if authentication failed - no


> regular intervals may just as well be valuable; if it is an issue which
> is temporary.  Then these clients would reconnect once everything is
> back online again on the server side.
>
>
> --
> kind regards,
>
> David Sommerseth
> OpenVPN Technologies, Inc
>
>
>

--001a11408a4e6457760558e9d312
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-09-11 17:30 GMT+05:00 David Sommerseth <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2080...</a>&g=
t;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 11/09/17 1=
4:02, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD w=
rote:<br>
&gt;<br>
&gt;<br>
&gt; 2017-09-11 16:54 GMT+05:00 =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD &lt;<a href=3D"mailto:chipitsine@...277...">chipit=
sine@...277...</a><br>
</span>&gt; &lt;mailto:<a href=3D"mailto:chipitsine@...277...">chipitsine@...220...=
..277...</a>&gt;&gt;<wbr>:<br>
<span class=3D"">&gt;<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A02017-09-11 16:45 GMT+05:00 Jan Just Keijser &lt;<a =
href=3D"mailto:janjust@...1147...">janjust@...1147...</a><br>
</span>&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:janjust@...2303...=
...">janjust@...1147...</a>&gt;&gt;:<br>
<div><div class=3D"h5">&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Hi,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0On 11/09/17 13:22, =D0=98=D0=BB=D1=8C=
=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Hello,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0is someone actually usi=
ng &quot;tls-verify&quot; in production ?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0we tried to implement a=
dditional certificate check using<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tls-verify<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while it works in gener=
al, in case when it hits &quot;exit 1&quot;, it<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0look like a timeout fro=
m client point of view. it is not any<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0good<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do you mean that when a client is den=
ied access (i.e. the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tls-verify script exits 1 on the serv=
er) that the client sees<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0this as a timeout?=C2=A0 that is &quo=
t;normal&quot; behaviour, as the server<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0does not tell the client *WHY* access=
 is refused - it simply<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stop responding to a client that does=
 not pass<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0authentication/authorization. The cli=
ent will not hear from the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0server, and will time out after a spe=
cified interval.=C2=A0 This is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0actually the most secure way to do th=
ings, as a rogue client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cannot DoS a server this way.<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0I&#39;d say it depends.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0we run a lot of openvpn-gui with real people sittin=
g in front of<br>
&gt;=C2=A0 =C2=A0 =C2=A0them, from their point of view it &quot;oh, it does=
 not work! fix it!&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0in out case better UX is to deliver proper reason t=
o the client<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0for someone maybe the better UX is to keep silence<=
br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; what is wrong with timeout is endless retry.<br>
&gt; there&#39;s no way to pass authentication once it failed, so why does =
client<br>
&gt; have to retry ?<br>
<br>
</div></div>User-friendliness and security seldom walks hand-in-hand.=C2=A0=
 As this<br>
friendliness provides enough information fragments for an attacker to<br>
figure out &quot;I need to try something else&quot;.=C2=A0 A non-responding=
 server<br>
gives no clues.=C2=A0 It can be a crappy server or it can be access denied;=
<br>
the attacker doesn&#39;t know - thus making it harder to figure out what to=
<br>
do next.<br></blockquote><div><br><br></div><div>an attacker can brute forc=
e a password, for example.<br></div><div>but what do you mean &quot;to try =
next&quot; in case of ssl certificate ?<br></div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">
<br>
The client will by default try to reconnect, because that is what it in<br>
most cases is told to do when the server is unresponsive.=C2=A0 And since<b=
r>
this happens with many seconds in between, a single client will not<br>
attempt to DoS a server by mistake by retrying in a too tight loop.<br>
<br>
A failed authentication is a failed authentication.=C2=A0 Thus UX client<br>
front-ends could treat this silence like that - but also account for<br>
other types of connectivity issues.=C2=A0 If it should try to reconnect or<=
br>
not, well, that&#39;s entirely up to the configuration file.=C2=A0 =C2=A0Th=
ere is<br>
--single-session which can be used to control this.<br>
<br>
But for servers running OpenVPN clients, retrying indefinitely at<br></bloc=
kquote><div><br></div><div>if retry might be successful, yes.<br></div><div=
>if authentication failed - no<br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
regular intervals may just as well be valuable; if it is an issue which<br>
is temporary.=C2=A0 Then these clients would reconnect once everything is<b=
r>
back online again on the server side.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN Technologies, Inc<br>
<br>
<br>
</font></span></blockquote></div><br></div></div>

--001a11408a4e6457760558e9d312--

