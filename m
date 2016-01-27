References: <2215306.x9ci9DhAZ9@...2001...>
	<1453835508-26119-1-git-send-email-gert@...1296...>
	<20160126191913.GV24952@...1296...> <56A7D1F6.8030805@...515...>
	<20160126212431.GW24952@...1296...>
	<CAKuzo_jKX6+KAw3cfPR-VTGe1A_bMh=R93i+4p=eC4BbCqWtAg@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <56A87C5A.3050104@...515...>
Date: Wed, 27 Jan 2016 10:14:18 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jKX6+KAw3cfPR-VTGe1A_bMh=R93i+4p=eC4BbCqWtAg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] interactive service v3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Il 27/01/2016 00:54, Selva Nair ha scritto:
>
> On Tue, Jan 26, 2016 at 4:24 PM, Gert Doering <gert@...1296...
> <mailto:gert@...1296...>> wrote:
>
>     Since Heiko has reworked the "classic" code (in automatic.c now, as
>     he called this "automatic service") maybe we can just use the
>     opportunity
>     to get the remaining issues fixed - is there more than "restart
>     openvpn.exe
>     when it dies"?
>
>
> Haven't look at the new code, but of  if the "automatic service" logic
> is the same as before, it would take some work to make it behave like a
> watchdog of openvpn.exe processes. Using NSSM for "automatic" uses and
> this one only for interactive start ups by the GUI may be a better
> option. NSSM has the added advantage of one service per config which
> could be independently stopped and restarted etc.
>
> The original service starts all the configs and then sits there waiting
> for the exit event to trigger, at which point the service will just
> stop. For one, the exit event will not trigger when openvpn.exe quits
> and even if we make the event to trigger, there is only one common event
> for multiple configs, and the service just stopping at such an event
> serves no purpose.
>
> Instead of fixing it why not just use NSSM? Then the interactive service
> patch could be decoupled from openvpnserv and provided as a new feature
> independent of the original service.
>
> Selva

There actually is a drop-in replacement for the old openvpnserv.exe here:

<https://github.com/mattock/openvpnserv2>

It was announced here:

<https://community.openvpn.net/openvpn/ticket/595>

 From now on, I will call it openvpnserv2 to distinguish it from the old=20
crappy openvpnserv.exe and from the interactive service.

I would personally prefer openvpnserv2 over using glue and duct-tape=20
around NSSM to make it's configuration frontend suck less. Openvpnserv2=20
can already restart dead connections, e.g. after the computer has=20
resumed from suspend or hibernation. I did some very basic testing on a=20
Windows 7 laptop and confirmed suspend/resume worked fine. Of course=20
we'd need more extensive tests with test installers before releasing it=20
to a wider audience.

An added bonus is that openvpnserv2 is written in C#, which means it can=20
be developed on Linux using Mono, and the language choice probably helps=20
getting new contributions from people not fluent with C.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

