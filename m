MIME-Version: 1.0
In-Reply-To: <201009030851.28881.hhund@...194...>
References: <AANLkTina=B8Z8v2euOJYjZxMQhJ9WB6UMdY0qtnc_qyT@...278...>
	<201009030851.28881.hhund@...194...>
Date: Fri, 3 Sep 2010 10:37:58 -0700
Message-ID: <AANLkTintc4F9CBaR8itY6fPDPuQ7aC7OyxLsygTDO1Mp@...278...>
From: Ansis Atteka <ansisatteka.dev@...277...>
Content-Type: multipart/alternative; boundary=001636af020945437e048f5e648c
Subject: Re: [Openvpn-devel] My results of OpenVPN Benchmarking
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <hhund@...194...>
Cc: openvpn-devel@lists.sourceforge.net

--001636af020945437e048f5e648c
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Yes those files were TCP sockets, and I was using "--proto tcp" option. I
did not observe this issue for UDP, because it is connectionless protocol.

But the bad thing is that OpenVPN did not recover even after I killed all
those 1200 clients and OpenVPN server continued to consume CPU at 100%
(because ep_poll() returned immediately and was infinitely looping), while
network load was 0. It would be nice that OpenVPN would be able to recover
after all VPN clients are killed in TCP mode.

Ansis Atteka

On Thu, Sep 2, 2010 at 11:51 PM, Heiko Hund <hhund@...194...> wrote:

> Hi Ansis,
>
> On Thursday 26 August 2010 19:56:56 Ansis Atteka wrote:
> > 4. During a OpenVPN 1200 client bomb test I observed that OpenVPN stall=
ed
> > with 100% CPU. In the openvpn log I saw that there are too many opened
> > files (output of "ls /proc/PID/fd | wc -l" showed that there were 1027
> > opened files). The bad thing is that killing all those 1200 clients did
> > not help the OpenVPN server to recover and it remained in stall state. =
It
> > looks like a bug for me.
>
> If you used --proto tcp it probably just were the connected sockets.
>
> Heiko
> --
> Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
> Astaro GmbH & Co. KG | An der RaumFabrik 33a | 76227 Karlsruhe | Germany
> Commercial Register: Mannheim HRA 702710 | Headquarter Location: Karlsruhe
>
> Represented by the General Partner Astaro Verwaltungs GmbH
> An der RaumFabrik 33a | 76227 Karlsruhe | Germany
> Commercial Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,
> Markus Hennig, Jan Hichert, G=FCnter Junk, Dr. Frank Nellissen
>

--001636af020945437e048f5e648c
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Yes those files were TCP sockets, and I was using &quot;--proto tcp&quot; o=
ption. I did not observe this issue for UDP, because it is connectionless p=
rotocol.<br><br>But the bad thing is that OpenVPN did not recover even afte=
r I killed all those 1200 clients and OpenVPN server continued to consume C=
PU at 100% (because ep_poll() returned immediately and was infinitely loopi=
ng), while network load was 0. It would be nice that OpenVPN would be able =
to recover after all VPN clients are killed in TCP mode.<br>
<br>Ansis Atteka<br><br><div class=3D"gmail_quote">On Thu, Sep 2, 2010 at 1=
1:51 PM, Heiko Hund <span dir=3D"ltr">&lt;<a href=3D"mailto:hhund@...194...=
">hhund@...194...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, =
204); padding-left: 1ex;">
Hi Ansis,<br>
<div class=3D"im"><br>
On Thursday 26 August 2010 19:56:56 Ansis Atteka wrote:<br>
&gt; 4. During a OpenVPN 1200 client bomb test I observed that OpenVPN stal=
led<br>
&gt; with 100% CPU. In the openvpn log I saw that there are too many opened=
<br>
&gt; files (output of &quot;ls /proc/PID/fd | wc -l&quot; showed that there=
 were 1027<br>
&gt; opened files). The bad thing is that killing all those 1200 clients di=
d<br>
&gt; not help the OpenVPN server to recover and it remained in stall state.=
 It<br>
&gt; looks like a bug for me.<br>
<br>
</div>If you used --proto tcp it probably just were the connected sockets.<=
br>
<br>
Heiko<br>
--<br>
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200<br>
Astaro GmbH &amp; Co. KG | An der RaumFabrik 33a | 76227 Karlsruhe | German=
y<br>
Commercial Register: Mannheim HRA 702710 | Headquarter Location: Karlsruhe<=
br>
<br>
Represented by the General Partner Astaro Verwaltungs GmbH<br>
An der RaumFabrik 33a | 76227 Karlsruhe | Germany<br>
Commercial Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,<br>
Markus Hennig, Jan Hichert, G=FCnter Junk, Dr. Frank Nellissen<br>
</blockquote></div><br>

--001636af020945437e048f5e648c--

