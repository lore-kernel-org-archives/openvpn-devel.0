MIME-Version: 1.0
In-Reply-To: <20161228203748.3ef54708@...1799...>
References: <20161228130721.683-1-list@...1798...>
	<20161228185700.GJ78624@...1296...>
	<20161228203748.3ef54708@...1799...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 28 Dec 2016 16:17:15 -0500
Message-ID: <CAKuzo_iVDLQTAQWetSxpAm14jAgC7XT1EcKRdrez6Pq28EpLaA@...278...>
Content-Type: multipart/alternative; boundary=001a114d8ca46744670544be7f7b
Subject: Re: [Openvpn-devel] [PATCH 1/1] fix timeout in non-TLS mode with
	systemd
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>
Cc: OpenVPN Development <openvpn-devel@lists.sourceforge.net>

--001a114d8ca46744670544be7f7b
Content-Type: text/plain; charset=UTF-8

Hi,

On Wed, Dec 28, 2016 at 2:37 PM, Christian Hesse <list@...1798...> wrote:

>
> For informational purpose we could add even more calls. That would allow to
> set intermediate status message, something like: "Up and running, currently
> serving 25 client connections."


If the daemon has to send specially crafted messages to systemd there is no
end to it. Arguably, we should also register as an event provider and send
event logs to Windows and whatever the equivalent be on OS X etc...

A cleaner approach would be to leverage on the existing management
interface and use standalone modules to do a translation between the
management and systemd/launchd//whatever. We already have  the status and
progress info sent to the management interface. Just as windows GUI uses
the management interface we could somehow have an external connector from
mgmt to systemd and keep such systemd specific stuff out of openvpn.

Selva

P.S.
I am not a fan of systemd so the above is partly colored by my dislike for
it.. (it has done several extremely bad things to me in the past including
uninstalling zfs modules on update on a system which had zfs on root and no
rescue disk.. well partly my fault..)

--001a114d8ca46744670544be7f7b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Wed, Dec 28, 2016 at 2:37 PM, Ch=
ristian Hesse <span dir=3D"ltr">&lt;<a href=3D"mailto:list@...1798..." targ=
et=3D"_blank">list@<span class=3D"" style=3D"" id=3D":4ix.1" tabindex=3D"-1=
">eworm</span>.<span class=3D"" style=3D"" id=3D":4ix.2" tabindex=3D"-1">de=
</span></a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
For informational purpose we could add even more calls. That would allow to=
<br>
set intermediate status message, something like: &quot;Up and running, curr=
ently<br>
serving 25 client connections.&quot;</blockquote></div><br>If the daemon ha=
s to send specially crafted messages to <span class=3D"" style=3D"" id=3D":=
4ix.3" tabindex=3D"-1">systemd</span> there is no end to it. Arguably, we s=
hould also register as an event provider and send event logs to Windows and=
 whatever the equivalent be on OS X etc...<br><br>A cleaner approach would =
be to leverage on the existing management interface and use standalone modu=
les to do a translation between the management and <span class=3D"" style=
=3D"" id=3D":4ix.4" tabindex=3D"-1">systemd</span>/<span class=3D"" style=
=3D"" id=3D":4ix.5" tabindex=3D"-1">launchd</span>//whatever. We already ha=
ve=C2=A0 the status and progress info s<span class=3D"" style=3D"" id=3D":4=
ix.6" tabindex=3D"-1">ent</span> to the management interface. Just as windo=
ws GUI uses the management interface we could somehow have an external conn=
ector from <span class=3D"" style=3D"" id=3D":4ix.7" tabindex=3D"-1">mgmt</=
span> to <span class=3D"" style=3D"" id=3D":4ix.8" tabindex=3D"-1">systemd<=
/span> and keep such <span class=3D"" style=3D"" id=3D":4ix.9" tabindex=3D"=
-1">systemd</span> specific stuff out of <span class=3D"" style=3D"" id=3D"=
:4ix.10" tabindex=3D"-1">openvpn</span>.<br><br></div><div class=3D"gmail_e=
xtra"><span class=3D"" style=3D"" id=3D":4ix.11" tabindex=3D"-1">Selva</spa=
n><br><br></div><div class=3D"gmail_extra">P.S.<br></div><div class=3D"gmai=
l_extra">I am not a fan of <span class=3D"" style=3D"" id=3D":4ix.12" tabin=
dex=3D"-1">systemd</span> so the above is partly colored by my dislike for =
it.. (it has done several extremely bad things to me in the past including =
<span class=3D"" style=3D"" id=3D":4ix.13" tabindex=3D"-1">uninstalling</sp=
an> <span class=3D"" style=3D"" id=3D":4ix.14" tabindex=3D"-1">zfs</span> m=
odules on update on a system which had <span class=3D"" style=3D"" id=3D":4=
ix.15" tabindex=3D"-1">zfs</span> on root and no rescue disk.. well partly =
my fault..)<br></div></div>

--001a114d8ca46744670544be7f7b--

