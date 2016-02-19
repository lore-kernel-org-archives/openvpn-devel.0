MIME-Version: 1.0
In-Reply-To: <56C71B50.4040502@...1227...>
References: <CAP=zTkOduThZFBXdewpYv1RQyi9z0Hzaz6MPuRXSt5HkbMTewQ@...278...>
	<56C71B50.4040502@...1227...>
Date: Fri, 19 Feb 2016 19:30:06 +0530
Message-ID: <CAP=zTkPMdCrhn16pLOmmGCrZ=tbpP=1mwewULove_tXF-QqH6Q@...278...>
From: Shubham Chauhan <shubham13099@...2124...>
Content-Type: multipart/alternative; boundary=001a11c3eb767fab19052c1fe679
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

--001a11c3eb767fab19052c1fe679
Content-Type: text/plain; charset=UTF-8

Thank you for such a quick reply.

I agree that VPN sessions and SSL sessions are not necessarily the same.
Let me be more specific with my question for a better discussion.

In an active OpenVPN session, at regular intervals, a full SSL handshake
takes place (because the SSL session expires). I checked this by capturing
packets with "openvpn && ssl" filter.
In my implementation I don't want those regular full SSL negotiations to
take place.
It should ideally check if the SSL session key or the session context is
present in the cache (or some storage place), and if it is present, then
full handshake should NOT take place. Instead an abbreviated handshake
should take place which happens during TLS session resumption.
I am looking for changes in the code that can be made to do this task (as
minimal as possible).

I understand the use of SSL_OP_NO_TICKET by OpenVPN against the triple
handshake vulnerability, but my project is really specific and wants some
specific functionality, which includes Session Resumptions.

Thanks

On Fri, Feb 19, 2016 at 7:10 PM, Arne Schwabe <arne@...1227...> wrote:

>
>
> Am 19.02.16 um 14:32 schrieb Shubham Chauhan:
> > Hello,
> >
> > I am currently working on a project that requires SSL VPN to use
> > session resumptions.
> >
> > I need to add the TLS Session Resumption functionality to OpenVPN. Any
> > starters as in how I could achieve this?
> > I know about the SSL_OP_NO_TICKET flag added to disable the resumption
> > process. Will deleting it from the code enable SSL resumption
> > automatically?
> >
> VPN session and SSL session are not necessarily the same. You can
> restablish a VPN session with a new TLS session.
>
> I think OpenVPN will still insist on a full authentication in a new
> session, even with SSL_OP_NO_TICKET removed.  I would have to the check
> the code myself to be sure.
>
> Arne
>



-- 
Regards
Shubham Chauhan
2013099
B.Tech CSE

--001a11c3eb767fab19052c1fe679
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you for such a quick reply.=C2=A0<br><div><br></div>=
<div>I agree that VPN sessions and SSL sessions are not necessarily the sam=
e.</div><div>Let me be more specific with my question for a better discussi=
on.</div><div><br></div><div>In an active OpenVPN session, at regular inter=
vals, a full SSL handshake takes place (because the SSL session expires). I=
 checked this by capturing packets with &quot;openvpn &amp;&amp; ssl&quot; =
filter.</div><div>In my implementation I don&#39;t want those regular full =
SSL negotiations to take place.=C2=A0</div><div>It should ideally check if =
the SSL session key or the session context is present in the cache (or some=
 storage place), and if it is present, then full handshake should NOT take =
place. Instead an abbreviated handshake should take place which happens dur=
ing TLS session resumption.</div><div>I am looking for changes in the code =
that can be made to do this task (as minimal as possible).<br></div><div><b=
r></div><div>I understand the use of SSL_OP_NO_TICKET by OpenVPN against th=
e triple handshake vulnerability, but my project is really specific and wan=
ts some specific functionality, which includes Session Resumptions.</div><d=
iv><br></div><div>Thanks</div></div><div class=3D"gmail_extra"><br><div cla=
ss=3D"gmail_quote">On Fri, Feb 19, 2016 at 7:10 PM, Arne Schwabe <span dir=
=3D"ltr">&lt;<a href=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1386...=
227...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
<br>
Am 19.02.16 um 14:32 schrieb Shubham Chauhan:<br>
<span class=3D"">&gt; Hello,<br>
&gt;<br>
&gt; I am currently working on a project that requires SSL VPN to use<br>
&gt; session resumptions.<br>
&gt;<br>
&gt; I need to add the TLS Session Resumption functionality to OpenVPN. Any=
<br>
&gt; starters as in how I could achieve this?<br>
&gt; I know about the SSL_OP_NO_TICKET flag added to disable the resumption=
<br>
&gt; process. Will deleting it from the code enable SSL resumption<br>
&gt; automatically?<br>
&gt;<br>
</span>VPN session and SSL session are not necessarily the same. You can<br>
restablish a VPN session with a new TLS session.<br>
<br>
I think OpenVPN will still insist on a full authentication in a new<br>
session, even with SSL_OP_NO_TICKET removed.=C2=A0 I would have to the chec=
k<br>
the code myself to be sure.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Arne<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature"><div dir=3D"ltr">Regards<br>Shubham Chauha=
n<br>2013099<br>B.Tech CSE</div></div>
</div>

--001a11c3eb767fab19052c1fe679--

