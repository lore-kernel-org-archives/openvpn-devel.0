References: <2215306.x9ci9DhAZ9@...2001...>
	<1453835508-26119-1-git-send-email-gert@...1296...>
	<20160126191913.GV24952@...1296...> <56A7D1F6.8030805@...515...>
	<20160126212431.GW24952@...1296...>
	<CAKuzo_jKX6+KAw3cfPR-VTGe1A_bMh=R93i+4p=eC4BbCqWtAg@...278...>
	<56A87C5A.3050104@...515...> <20160127082046.GY24952@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <56A8BA4F.1030706@...515...>
Date: Wed, 27 Jan 2016 14:38:39 +0200
MIME-Version: 1.0
In-Reply-To: <20160127082046.GY24952@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v3] interactive service v3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

> Hi,
>
> On Wed, Jan 27, 2016 at 10:14:18AM +0200, Samuli Sepp=E4nen wrote:
>> An added bonus is that openvpnserv2 is written in C#, which means it can
>> be developed on Linux using Mono, and the language choice probably helps
>> getting new contributions from people not fluent with C.
>
> I'm not totally convinced that "mixing in a new language" is a *bonus*
> (as it means that the core team won't be able to help unless also fluent
> with the other language).

Well, I just reviewed all of the code with no difficulty, so would I=20
have no trouble co-maintaining it. Openvpnserv2 is built on top of=20
generic Service C# classes provided by Microsoft and overrides a few=20
methods such as OnStart, OnStop, and sets some some capabilities based=20
on what OpenVPN processes can (be ordered to) do. For an overview of the=20
ServiceBase class look here:

<https://msdn.microsoft.com/en-us/library/system.serviceprocess.servicebase=
%28v=3Dvs.110%29.aspx>

The core of openvpnserv2 is in this file:

<https://github.com/xkjyeah/openvpnserv2/blob/master/Service.cs>

The remaining files are mostly stuff added by the IDE. The only thing=20
that openvpnserv2 really adds on top of generic MS service classes is:

- loading of OpenVPN registry keys
- building the command-line(s) to launch the connection(s)
- monitoring the individual OpenVPN processes and restart them if they crash
- stopping the processes before suspend
- starting the processes on resume

That said, the code does not seem to handle 32/64-bit registry keys yet.=20
This needs to be fixed, unless there is some underlying magic in there I=20
missed. Adding support for selecting which connections to launch=20
automatically would also be nice, e.g. via registry or a config file.

I would not be worried about current core developers not being able to=20
help with openvpnserv2. First, they haven't really been able to help=20
with openvpnserv.exe, either. If they had, we wouldn't be having this=20
discussion in the first place. I would be inclined to think that instead=20
of overloading the existing C maintainers we should try to get _new_=20
people to maintain the Windows service part.

I don't see a problem with moving to C# for a number of reasons:

- The codebase pretty small
- Most of the hard lifting is done in the classes maintained by MS
- There is already a maintainer for this code
- There is a volunteering co-maintainer (=3Dme) in the core group
- C# is easier than C to understand/develop (imho), if you already know=20
a high-level language (especially Java, but also Python etc.)

> Given that services run with maximum privileges, strong review is as
> important there as for core openvpn...

Yes, agreed. But note that most of the functionality is stock=20
functionality provided by Microsoft in their libraries, so there's not=20
much to review. As said, I reviewed the code already, but of course it=20
does not hurt if an experienced C# developer has a second look.

One thing to bear in mind is that making horrible mistakes (e.g. create=20
a gaping security hole) with C# is more difficult than with C, so while=20
review is of course necessary, every single line does not have to picked=20
apart for potential vulnerabilities.

> If the only reason why everyone is disliking the old openvpnserv is
> "it is not restarting openvpn.exe when it breaks" - *that* should be
> fairly easy to add.  So, what is that people consider "broken"?

It does not work at all in Windows 10 afaik, and only barely works in=20
Windows 8.1. It does not handle suspend/resume. It is not maintained,=20
and there are no maintainers, and I don't see any maintainers appearing.=20
There are a bunch of tickets in Trac related to openvpnserv.exe,=20
directly or indirectly. Interestingly openvpnserv.exe has been dropped=20
from the OpenVPN Chocolatey package[1], apparently because it's fairly=20
useless nowadays.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


[1] <https://chocolatey.org/packages/openvpn>

