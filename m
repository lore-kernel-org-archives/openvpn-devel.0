References: <2215306.x9ci9DhAZ9@...2001...>
	<1453835508-26119-1-git-send-email-gert@...1296...>
	<20160126191913.GV24952@...1296...> <56A7D1F6.8030805@...515...>
	<20160126212431.GW24952@...1296...>
	<CAKuzo_jKX6+KAw3cfPR-VTGe1A_bMh=R93i+4p=eC4BbCqWtAg@...278...>
	<56A87C5A.3050104@...515...> <20160127082046.GY24952@...1296...>
	<CAKuzo_gzKE9p+fev58_5dJZps=8tKXbLVu6jEnCH0wBdhHWMnA@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <56AB2C34.3010606@...515...>
Date: Fri, 29 Jan 2016 11:09:08 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gzKE9p+fev58_5dJZps=8tKXbLVu6jEnCH0wBdhHWMnA@...278...>
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


>
> On Wed, Jan 27, 2016 at 3:20 AM, Gert Doering <gert@...1296...
> <mailto:gert@...1296...>> wrote:
>
>     Hi,
>
>     On Wed, Jan 27, 2016 at 10:14:18AM +0200, Samuli Sepp=C3=A4nen wrote:
>     > An added bonus is that openvpnserv2 is written in C#, which means i=
t can
>     > be developed on Linux using Mono, and the language choice probably =
helps
>     > getting new contributions from people not fluent with C.
>
>     I'm not totally convinced that "mixing in a new language" is a *bonus*
>     (as it means that the core team won't be able to help unless also flu=
ent
>     with the other language).
>
>
> Currently the service is a part of the openvpn repo, but there is no
> reason to keep it thus. In fact, once the interactive service is
> available, in my view, it may not be even necessary to ship the original
> service with the windows binary distribution. Only advanced users would
> need the original service or its equivalent (openvpnserv2 or NSSM) usage
> of which could be made available as documentation in the wiki pages.

This would be a novel idea. The service component has very few ties to=20
OpenVPN, and is a very simple piece of software. I don't think it=20
_needs_ to be in the main OpenVPN repo, either. Splitting the project=20
into smaller chunks both code- and organization-vise has been beneficial=20
in the past by allowing us to get more people onboard. Plus we've been=20
able to optimize the development processes per subproject, so that the=20
strict patch review regime in the main project has not slowed down the=20
development of less critical components.

I have no idea how large a percentage of our users use the service.=20
Probably the only way to _really_ find that out would be to deselect the=20
service in the installer by default and see how loudly people scream. We=20
could have a poll, but in my experience only a few people would answer,=20
and we wouldn't be any better off. If most people would be basically ok=20
without the service, we could still provide it as a separate download on=20
the official download pages. That said, I have no strong opinions one=20
way or the other.

>
>     Given that services run with maximum privileges, strong review is as
>     important there as for core openvpn...
>
>     If the only reason why everyone is disliking the old openvpnserv is
>     "it is not restarting openvpn.exe when it breaks" - *that* should be
>     fairly easy to add.  So, what is that people consider "broken"?
>
>
> Although it is called a service, it only works like a one time task or
> an rc script. However, unlike a startup script, it does not terminate
> after spawning openvpn.exe processes, giving it the appearance of a
> service. It does not keep track of the spawned processes, has no way of
> knowing any of the processes stopped or crashed, has no way of editing
> one config and then restart only that connection leaving others up etc.

I believe openvpnserv2 - or rather the more generic MS code upon which=20
it builds - can monitor the individual processes and restart them as=20
necessary. So it definitely a more complete solution than what=20
openvpnserv.exe provides.

> Having said that, on the only windows 10 machine I have, the original
> service works the same way as on Windows 7. Early reports of "not
> working on windows 10" might have had more to do with unrelated TAP6 issu=
es.

Quite likely. Also some issues seem to have been related to specific=20
problematic Windows 10 builds.

Samuli


