MIME-Version: 1.0
In-Reply-To: <20160603181404.GM53051@...1296...>
References: <1464883738-904-1-git-send-email-openvpn@...2080...>
	<1464976163-6162-1-git-send-email-openvpn@...2080...>
	<20160603181404.GM53051@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 3 Jun 2016 14:37:45 -0400
Message-ID: <CAKuzo_hyz1g_VqiU_AR-Q69FiXA_9K+MmPYsE=J3M41iKjyDeA@...278...>
Content-Type: multipart/alternative; boundary=001a113f9b6afa69710534640590
Subject: Re: [Openvpn-devel] [PATCH] Another fix related to unit test
	framework
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

--001a113f9b6afa69710534640590
Content-Type: text/plain; charset=UTF-8

On Fri, Jun 3, 2016 at 2:14 PM, Gert Doering <gert@...1296...> wrote:

> On Fri, Jun 03, 2016 at 07:49:23PM +0200, David Sommerseth wrote:
> > From: David Sommerseth <dazo@...2145...>
> >
> > Continuing to fix breakage caused by commit 40cb4cfc5d011102.
> [..]
>
> Not having actually tested this, looking at it seems to properly quote
> the bits that caused buildbot explosion and "make dist" fails (also as
> discussed between David and Samuli on IRC).
>
> So - ACK!  Please apply and let's make the buildbots all green again :-)


Don't know about bots, at least one human cross-compiling for windows is
happy now..

Selva

--001a113f9b6afa69710534640590
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Jun 3, 2016 at 2:14 PM, Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><span>On Fri, Jun 03, 2016 at 07=
:49:23PM +0200, David Sommerseth wrote:<br>
&gt; From: David Sommerseth &lt;<a href=3D"mailto:dazo@...2145..." target=
=3D"_blank">dazo@...2145...</a>&gt;<br>
&gt;<br>
&gt; Continuing to fix breakage caused by commit 40cb4cfc5d011102.<br>
</span>[..]<br>
<br>
Not having actually tested this, looking at it seems to properly quote<br>
the bits that caused buildbot explosion and &quot;make dist&quot; fails (al=
so as<br>
discussed between David and Samuli on IRC).<br>
<br>
So - ACK!=C2=A0 Please apply and let&#39;s make the buildbots all green aga=
in :-)</blockquote></div><br>Don&#39;t know about bots, at least one human =
cross-compiling for windows is happy now..</div><div class=3D"gmail_extra">=
<br></div><div class=3D"gmail_extra">Selva</div></div>

--001a113f9b6afa69710534640590--

