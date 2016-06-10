MIME-Version: 1.0
In-Reply-To: <20160610125457.GC62247@...1296...>
References: <575AA2BD.60908@...277...> <20160610125457.GC62247@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 10 Jun 2016 12:43:20 -0400
Message-ID: <CAKuzo_jrwK47wDtoLNCZXP8-OG0izGmjZRrDb5vdT5shhY7FMQ@...278...>
Content-Type: multipart/alternative; boundary=001a113a9c6caad9ae0534ef3d7d
Subject: Re: [Openvpn-devel] pull-filter reject = server hammering !
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113a9c6caad9ae0534ef3d7d
Content-Type: text/plain; charset=UTF-8

Hi,

On Fri, Jun 10, 2016 at 12:21:33PM +0100, debbie10t wrote:

> > If the server pushes an item the client rejects then
> > the client will just reconnect endlessly, completing a
> > full reconnect to the server then restarting !
> > Thispractically constitutes a DDOS ..


The logic used with reject is no different from what happens with many
other failures.  For example, try '--tls-verify /tmp' . For max effect use
2.3 so that the SIGUSR1 loop will wait only for 2 seconds between retries.
Well, this is not a full connect, but does put some load on the server.

Now suppose we only provide '--pull-filter ignore opt' which doesn't
trigger SIGUSR1. Then try this:

--pull-filter ignore ping --ping-restart 2

On Fri, Jun 10, 2016 at 8:54 AM, Gert Doering <gert@...1296...> wrote:

>
> "If you send me stuff that I find reject-worthy, you should be DoSed!!!"
>
> Seriously: I expect people to notice that their VPN isn't connecting, and
> check the log, no?
>
> @Selva, Arne: can we make the reconnect logic somewhat smarter overall,
> like
> "if reconnecting to the same host, wait 30 seconds instead of 5"?


This is possible, but the case for progressively increasing the restart
pause is not very strong. Can we get some feedback from people who serve
1000's of users?

Selva

--001a113a9c6caad9ae0534ef3d7d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Fri, Jun 10, 2016 at 12:21:33PM =
+0100, debbie10t wrote:</div><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">=
<span>&gt; If the server pushes an item the client rejects then<br>
&gt; the client will just reconnect endlessly, completing a<br>
&gt; full reconnect to the server then restarting !<br>
&gt; Thispractically constitutes a DDOS ..</span></blockquote><div><br>The =
logic used with reject is no different from what happens with many other fa=
ilures.=C2=A0 For example, try &#39;--<span class=3D"" id=3D":bph.1" tabind=
ex=3D"-1">tls</span>-verify /tmp&#39; . For max effect use 2.3 so that the =
SIGUSR1 loop will wait only for 2 seconds between retries. Well, this is no=
t a full connect, but does put some load on the server.<br><br></div><div>N=
ow suppose we only provide &#39;--pull-filter ignore opt&#39; which doesn&#=
39;t trigger SIGUSR1. Then try this:</div><div><br></div><div>--pull-filter=
 ignore ping --ping-restart 2</div><div><br></div><div>On Fri, Jun 10, 2016=
 at 8:54 AM, Gert <span class=3D"" id=3D":bph.2" tabindex=3D"-1">Doering</s=
pan> &lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank"><span class=
=3D"" id=3D":bph.3" tabindex=3D"-1">gert</span>@<span class=3D"" id=3D":bph=
.4" tabindex=3D"-1">greenie</span>.<span class=3D"" id=3D":bph.5" tabindex=
=3D"-1">muc</span>.<span class=3D"" id=3D":bph.6" tabindex=3D"-1">de</span>=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left=
-color:rgb(204,204,204);padding-left:1ex"><span>
<br>
</span>&quot;If you send me stuff that I find reject-worthy, you should be =
DoSed!!!&quot;<br>
<br>
Seriously: I expect people to notice that their VPN isn&#39;t connecting, a=
nd<br>
check the log, no?<br>
<br>
@Selva, Arne: can we make the reconnect logic somewhat smarter overall, lik=
e<br>
&quot;if reconnecting to the same host, wait 30 seconds instead of 5&quot;?=
</blockquote></div><br></div><div class=3D"gmail_extra">This is possible, b=
ut the case for progressively increasing the restart pause is not very stro=
ng. Can we get some feedback from people who serve 1000&#39;s of users?<br>=
</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><span=
 class=3D"" id=3D":bph.7" tabindex=3D"-1">Selva</span></div></div>

--001a113a9c6caad9ae0534ef3d7d--

