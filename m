Message-ID: <4B657BC7.5030004@...515...>
Date: Sun, 31 Jan 2010 14:47:03 +0200
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <4B65724F.6080201@...515...>
	<9e0cf0bf1001310414i6462b9a9p6909b70978348a49@...278...>
In-Reply-To: <9e0cf0bf1001310414i6462b9a9p6909b70978348a49@...278...>
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Alon,

Could give a few concrete examples of the problems you've encountered
with Trac and/or Trac developers? I've used Trac myself almost daily for
~3 years with no problems. I don't think it ever even went down during
that time. Also, nobody else in the community site meetings (11th and
28th) had any noteworthy problems with Trac.

Also, we're not looking into just a bug tracker. We need a wiki, forums,
file releases, bug/feature request tracker etc. Trac combines many of
these into a neat package. The alternative is take a bunch of excellent
but separate services and integrate (=3Dhack) them together. This gets
very ugly very soon and requires a _lot_ of work: weeks or months
instead of days.

If Trac really proves to be a failure as you say we can migrate away
from it. It will be somewhat painful, but definitely doable. The
database scheme (at least the ticket part) is relatively straightforward
to export and convert to, say, Redmine. Some data will inevitably get
lost, though.

Samuli

> Trac is *THE* worse ticketing system there is on earth.
> It is almost unmaintained and even if something happens at the project
> it is minor and unusable.
> For example ticket dependency and duplication is unavailable for years.
>
> If you like to have sane system, use bugzilla.
>
> Yes, I know this was raised in meeting, but I think someone is going
> to regret this decision.
>
> 2010/1/31 Samuli Sepp=C3=A4nen <samuli@...515...>:
>=20=20=20
>> Here's the summary for last Thursday's community meeting.
>>
>> --
>> Samuli Sepp=C3=A4nen
>> Community Manager
>> OpenVPN Technologies, Inc
>>
>> irc freenode net: mattock
>>
>>
>> COMMUNITY MEETING
>>
>> Place: #openvpn-discussion on irc.freenode.net
>> Date: Thursday, 28th January 2010
>> Time: 19:00 UTC
>>
>> Full log available here:
>>
>> http://secure-computing.net/logs/%23%23openvpn-discussion.log
>>
>> Next meeting on Thu 4th Feb 2010. Same place, same time.
>>
>> SUMMARY
>>
>> Decided to start with a single Trac-based site for the whole community r=
ather than have separate user/developer sites. The main concern was the ris=
k of content getting fragmented (e.g. developer content in user wiki and vi=
ce versa). This means Trac will need to be themed to make it as approachabl=
e as possible for "normal" users (=3Dnot look too developer-oriented).
>>
>> Agreed that we need a set of documents describing how OpenVPN is develop=
ed - including things like common coding conventions. This should improve c=
ode quality as well as make the process less taxing for core developers.
>>
>> Agreed that the content from the new community site needs to be
>>
>>  a) mirrored to another server (e.g. ecrist's OpenvPN community server)
>>  b) backed up off-site (e.g. to ecrist's server and/or OpenVPN e.V.)
>>  c) accessible by a community member
>>
>> This helps prevent data loss for any reason - political or technical.
>>
>> Discussed community site spam prevention in some length:
>>
>> * There is an anti-spam plugin for Trac (see below)
>> * A proper user registration process needs to be chosen - not too bureau=
cratical but not too automated, either
>> * Forum posts could be automatically accepted only after the first few h=
ave been accepted manually by the admin(s)
>>
>> Discussed which forum software to use. PhpBB is apparently the best OSS =
solution out there.
>>
>> Discussed potentially useful Trac plugins:
>>
>> * http://trac.edgewall.org/wiki/PluginList
>> * http://trac-hacks.org/
>> * http://trac-hacks.org/wiki/DiscussionPlugin (for forums, probably not =
as good as phpBB and such)
>> * http://trac.edgewall.org/wiki/SpamFilter (spma filtering)
>> * http://trac-hacks.org/wiki/TicketImportPlugin (for importing SF.net ti=
ckets)
>> * http://trac-hacks.org/wiki/TracBuildbotIntegration (for automated buil=
ding and regression testing with buildbot)
>> * http://trac-hacks.org/wiki/MediaWikiPluginMacro (mediawiki syntax for =
Trac)
>> * http://trac-hacks.org/wiki/TocMacro (automated Table of contents creat=
ion)
>> * http://trac-hacks.org/wiki/DownloadsPlugin (downloads through Trac, e.=
g. for file releases)
>> * http://trac-hacks.org/wiki/DefaultCcPlugin (a default CC for tickets, =
e.g. inform James or devel-list)
>> * http://trac-hacks.org/wiki/IrcAnnouncerPlugin (Trac makes announcement=
s of changes to IRC)
>> * http://trac-hacks.org/wiki/IrcLogsPlugin (IRC logs to Trac)
>>
>> Also discussed IRC<->Trac integration using Trac's built-in RSS support.
>>
>> ------------------------------------------------------------------------=
------
>> The Planet: dedicated and managed hosting, cloud storage, colocation
>> Stay online with enterprise data centers and the best network in the bus=
iness
>> Choose flexible plans and management services without long-term contracts
>> Personal 24x7 support from experience hosting pros just a phone call awa=
y.
>> http://p.sf.net/sfu/theplanet-com
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
>>
>>=20=20=20=20=20



