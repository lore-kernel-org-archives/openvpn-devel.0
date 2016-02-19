MIME-Version: 1.0
In-Reply-To: <56C724C7.1020603@...1227...>
References: <CAP=zTkOduThZFBXdewpYv1RQyi9z0Hzaz6MPuRXSt5HkbMTewQ@...278...>
	<56C71B50.4040502@...1227...>
	<CAP=zTkPMdCrhn16pLOmmGCrZ=tbpP=1mwewULove_tXF-QqH6Q@...278...>
	<56C724C7.1020603@...1227...>
Date: Fri, 19 Feb 2016 19:58:39 +0530
Message-ID: <CAP=zTkMC4M6woOgLcv7yNXG0nPTKy2YDkOAtX8W+7jYHAZsR6g@...278...>
From: Shubham Chauhan <shubham13099@...2124...>
Content-Type: multipart/alternative; boundary=001a1140769c979246052c204c4f
Subject: Re: [Openvpn-devel] Enabling TLS Session Resumption in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--001a1140769c979246052c204c4f
Content-Type: text/plain; charset=UTF-8

Thanks. I didn't knew about this. This will be helpful.

I am specifically looking for enabling TLS session resumptions though.
Resuming the session with  session IDs stored in a cache at server side
(the general process of an abbreviated handshake).
On Feb 19, 2016 7:50 PM, "Arne Schwabe" <arne@...1227...> wrote:

>
>
> Am 19.02.16 um 15:00 schrieb Shubham Chauhan:
> > Thank you for such a quick reply.
> >
> > I agree that VPN sessions and SSL sessions are not necessarily the same.
> > Let me be more specific with my question for a better discussion.
> >
> > In an active OpenVPN session, at regular intervals, a full SSL
> > handshake takes place (because the SSL session expires). I checked
> > this by capturing packets with "openvpn && ssl" filter.
> > In my implementation I don't want those regular full SSL negotiations
> > to take place.
> > It should ideally check if the SSL session key or the session context
> > is present in the cache (or some storage place), and if it is present,
> > then full handshake should NOT take place. Instead an abbreviated
> > handshake should take place which happens during TLS session resumption.
> > I am looking for changes in the code that can be made to do this task
> > (as minimal as possible).
> >
> > I understand the use of SSL_OP_NO_TICKET by OpenVPN against the triple
> > handshake vulnerability, but my project is really specific and wants
> > some specific functionality, which includes Session Resumptions.
> >
> Note that this interval is defined by --reneg-sec and you can disable
> them by setting that to 0.
>
> Arne
>

--001a1140769c979246052c204c4f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Thanks. I didn&#39;t knew about this. This will be helpful. =
</p>
<p dir=3D"ltr">I am specifically looking for enabling TLS session resumptio=
ns though. Resuming the session with=C2=A0 session IDs stored in a cache at=
 server side (the general process of an abbreviated handshake). </p>
<div class=3D"gmail_quote">On Feb 19, 2016 7:50 PM, &quot;Arne Schwabe&quot=
; &lt;<a href=3D"mailto:arne@...1227...">arne@...1227...</a>&gt; wrote:<br =
type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
<br>
Am 19.02.16 um 15:00 schrieb Shubham Chauhan:<br>
&gt; Thank you for such a quick reply.<br>
&gt;<br>
&gt; I agree that VPN sessions and SSL sessions are not necessarily the sam=
e.<br>
&gt; Let me be more specific with my question for a better discussion.<br>
&gt;<br>
&gt; In an active OpenVPN session, at regular intervals, a full SSL<br>
&gt; handshake takes place (because the SSL session expires). I checked<br>
&gt; this by capturing packets with &quot;openvpn &amp;&amp; ssl&quot; filt=
er.<br>
&gt; In my implementation I don&#39;t want those regular full SSL negotiati=
ons<br>
&gt; to take place.<br>
&gt; It should ideally check if the SSL session key or the session context<=
br>
&gt; is present in the cache (or some storage place), and if it is present,=
<br>
&gt; then full handshake should NOT take place. Instead an abbreviated<br>
&gt; handshake should take place which happens during TLS session resumptio=
n.<br>
&gt; I am looking for changes in the code that can be made to do this task<=
br>
&gt; (as minimal as possible).<br>
&gt;<br>
&gt; I understand the use of SSL_OP_NO_TICKET by OpenVPN against the triple=
<br>
&gt; handshake vulnerability, but my project is really specific and wants<b=
r>
&gt; some specific functionality, which includes Session Resumptions.<br>
&gt;<br>
Note that this interval is defined by --reneg-sec and you can disable<br>
them by setting that to 0.<br>
<br>
Arne<br>
</blockquote></div>

--001a1140769c979246052c204c4f--

