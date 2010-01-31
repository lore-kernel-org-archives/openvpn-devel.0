MIME-Version: 1.0
In-Reply-To: <4B65724F.6080201@...515...>
References: <4B65724F.6080201@...515...>
Date: Sun, 31 Jan 2010 14:14:04 +0200
Message-ID: <9e0cf0bf1001310414i6462b9a9p6909b70978348a49@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (28th Jan 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Trac is *THE* worse ticketing system there is on earth.
It is almost unmaintained and even if something happens at the project
it is minor and unusable.
For example ticket dependency and duplication is unavailable for years.

If you like to have sane system, use bugzilla.

Yes, I know this was raised in meeting, but I think someone is going
to regret this decision.

2010/1/31 Samuli Sepp=C3=A4nen <samuli@...515...>:
> Here's the summary for last Thursday's community meeting.
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
>
> COMMUNITY MEETING
>
> Place: #openvpn-discussion on irc.freenode.net
> Date: Thursday, 28th January 2010
> Time: 19:00 UTC
>
> Full log available here:
>
> http://secure-computing.net/logs/%23%23openvpn-discussion.log
>
> Next meeting on Thu 4th Feb 2010. Same place, same time.
>
> SUMMARY
>
> Decided to start with a single Trac-based site for the whole community ra=
ther than have separate user/developer sites. The main concern was the risk=
 of content getting fragmented (e.g. developer content in user wiki and vic=
e versa). This means Trac will need to be themed to make it as approachable=
 as possible for "normal" users (=3Dnot look too developer-oriented).
>
> Agreed that we need a set of documents describing how OpenVPN is develope=
d - including things like common coding conventions. This should improve co=
de quality as well as make the process less taxing for core developers.
>
> Agreed that the content from the new community site needs to be
>
> =C2=A0a) mirrored to another server (e.g. ecrist's OpenvPN community serv=
er)
> =C2=A0b) backed up off-site (e.g. to ecrist's server and/or OpenVPN e.V.)
> =C2=A0c) accessible by a community member
>
> This helps prevent data loss for any reason - political or technical.
>
> Discussed community site spam prevention in some length:
>
> * There is an anti-spam plugin for Trac (see below)
> * A proper user registration process needs to be chosen - not too bureauc=
ratical but not too automated, either
> * Forum posts could be automatically accepted only after the first few ha=
ve been accepted manually by the admin(s)
>
> Discussed which forum software to use. PhpBB is apparently the best OSS s=
olution out there.
>
> Discussed potentially useful Trac plugins:
>
> * http://trac.edgewall.org/wiki/PluginList
> * http://trac-hacks.org/
> * http://trac-hacks.org/wiki/DiscussionPlugin (for forums, probably not a=
s good as phpBB and such)
> * http://trac.edgewall.org/wiki/SpamFilter (spma filtering)
> * http://trac-hacks.org/wiki/TicketImportPlugin (for importing SF.net tic=
kets)
> * http://trac-hacks.org/wiki/TracBuildbotIntegration (for automated build=
ing and regression testing with buildbot)
> * http://trac-hacks.org/wiki/MediaWikiPluginMacro (mediawiki syntax for T=
rac)
> * http://trac-hacks.org/wiki/TocMacro (automated Table of contents creati=
on)
> * http://trac-hacks.org/wiki/DownloadsPlugin (downloads through Trac, e.g=
. for file releases)
> * http://trac-hacks.org/wiki/DefaultCcPlugin (a default CC for tickets, e=
.g. inform James or devel-list)
> * http://trac-hacks.org/wiki/IrcAnnouncerPlugin (Trac makes announcements=
 of changes to IRC)
> * http://trac-hacks.org/wiki/IrcLogsPlugin (IRC logs to Trac)
>
> Also discussed IRC<->Trac integration using Trac's built-in RSS support.
>
> -------------------------------------------------------------------------=
-----
> The Planet: dedicated and managed hosting, cloud storage, colocation
> Stay online with enterprise data centers and the best network in the busi=
ness
> Choose flexible plans and management services without long-term contracts
> Personal 24x7 support from experience hosting pros just a phone call away.
> http://p.sf.net/sfu/theplanet-com
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

