MIME-Version: 1.0
In-Reply-To: <4B657BC7.5030004@...515...>
References: <4B65724F.6080201@...515...>
	<9e0cf0bf1001310414i6462b9a9p6909b70978348a49@...278...>
	<4B657BC7.5030004@...515...>
Date: Sun, 31 Jan 2010 14:59:10 +0200
Message-ID: <9e0cf0bf1001310459v345ede35mfa4b8233c65bc666@...278...>
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

Trac is promises to provide all but provides none, I really don't know
which project you managed with Trac, but without ticket dependencies
and without proper CC lists and workflow it is difficult to manage a
real project.

You are better use separate products for each category.

1. Bugzilla - bug tracking - most production activity goes here,
failing to manage bugs/tasks properly results in failure to manage
releases.

2. ViewVC/ViewGIT/Whatever - Browse code.

3. MediaWiki - wiki - much better than trac.

4. File releases, well... a simple webdav does the trick.

5. Forums... Why not mailing list with archive? As it always had been?
And use mailman?

I looked at redmine some time ago and tracked the project, it has a
single active developer, much like OpenVPN, and as such no much
progress/support is made.

Consider to use tools that do what you require, stable tools, and best
in each task.

Alon.

2010/1/31 Samuli Sepp=C3=A4nen <samuli@...515...>:
> Hi Alon,
>
> Could give a few concrete examples of the problems you've encountered
> with Trac and/or Trac developers? I've used Trac myself almost daily for
> ~3 years with no problems. I don't think it ever even went down during
> that time. Also, nobody else in the community site meetings (11th and
> 28th) had any noteworthy problems with Trac.
>
> Also, we're not looking into just a bug tracker. We need a wiki, forums,
> file releases, bug/feature request tracker etc. Trac combines many of
> these into a neat package. The alternative is take a bunch of excellent
> but separate services and integrate (=3Dhack) them together. This gets
> very ugly very soon and requires a _lot_ of work: weeks or months
> instead of days.
>
> If Trac really proves to be a failure as you say we can migrate away
> from it. It will be somewhat painful, but definitely doable. The
> database scheme (at least the ticket part) is relatively straightforward
> to export and convert to, say, Redmine. Some data will inevitably get
> lost, though.
>
> Samuli
>
>> Trac is *THE* worse ticketing system there is on earth.
>> It is almost unmaintained and even if something happens at the project
>> it is minor and unusable.
>> For example ticket dependency and duplication is unavailable for years.
>>
>> If you like to have sane system, use bugzilla.
>>
>> Yes, I know this was raised in meeting, but I think someone is going
>> to regret this decision.
>>
>> 2010/1/31 Samuli Sepp=C3=A4nen <samuli@...515...>:
>>
>>> Here's the summary for last Thursday's community meeting.
>>>
>>> --
>>> Samuli Sepp=C3=A4nen
>>> Community Manager
>>> OpenVPN Technologies, Inc
>>>
>>> irc freenode net: mattock
>>>
>>>
>>> COMMUNITY MEETING
>>>
>>> Place: #openvpn-discussion on irc.freenode.net
>>> Date: Thursday, 28th January 2010
>>> Time: 19:00 UTC
>>>
>>> Full log available here:
>>>
>>> http://secure-computing.net/logs/%23%23openvpn-discussion.log
>>>
>>> Next meeting on Thu 4th Feb 2010. Same place, same time.
>>>
>>> SUMMARY
>>>
>>> Decided to start with a single Trac-based site for the whole community =
rather than have separate user/developer sites. The main concern was the ri=
sk of content getting fragmented (e.g. developer content in user wiki and v=
ice versa). This means Trac will need to be themed to make it as approachab=
le as possible for "normal" users (=3Dnot look too developer-oriented).
>>>
>>> Agreed that we need a set of documents describing how OpenVPN is develo=
ped - including things like common coding conventions. This should improve =
code quality as well as make the process less taxing for core developers.
>>>
>>> Agreed that the content from the new community site needs to be
>>>
>>> =C2=A0a) mirrored to another server (e.g. ecrist's OpenvPN community se=
rver)
>>> =C2=A0b) backed up off-site (e.g. to ecrist's server and/or OpenVPN e.V=
.)
>>> =C2=A0c) accessible by a community member
>>>
>>> This helps prevent data loss for any reason - political or technical.
>>>
>>> Discussed community site spam prevention in some length:
>>>
>>> * There is an anti-spam plugin for Trac (see below)
>>> * A proper user registration process needs to be chosen - not too burea=
ucratical but not too automated, either
>>> * Forum posts could be automatically accepted only after the first few =
have been accepted manually by the admin(s)
>>>
>>> Discussed which forum software to use. PhpBB is apparently the best OSS=
 solution out there.
>>>
>>> Discussed potentially useful Trac plugins:
>>>
>>> * http://trac.edgewall.org/wiki/PluginList
>>> * http://trac-hacks.org/
>>> * http://trac-hacks.org/wiki/DiscussionPlugin (for forums, probably not=
 as good as phpBB and such)
>>> * http://trac.edgewall.org/wiki/SpamFilter (spma filtering)
>>> * http://trac-hacks.org/wiki/TicketImportPlugin (for importing SF.net t=
ickets)
>>> * http://trac-hacks.org/wiki/TracBuildbotIntegration (for automated bui=
lding and regression testing with buildbot)
>>> * http://trac-hacks.org/wiki/MediaWikiPluginMacro (mediawiki syntax for=
 Trac)
>>> * http://trac-hacks.org/wiki/TocMacro (automated Table of contents crea=
tion)
>>> * http://trac-hacks.org/wiki/DownloadsPlugin (downloads through Trac, e=
.g. for file releases)
>>> * http://trac-hacks.org/wiki/DefaultCcPlugin (a default CC for tickets,=
 e.g. inform James or devel-list)
>>> * http://trac-hacks.org/wiki/IrcAnnouncerPlugin (Trac makes announcemen=
ts of changes to IRC)
>>> * http://trac-hacks.org/wiki/IrcLogsPlugin (IRC logs to Trac)
>>>
>>> Also discussed IRC<->Trac integration using Trac's built-in RSS support.
>>>
>>> -----------------------------------------------------------------------=
-------
>>> The Planet: dedicated and managed hosting, cloud storage, colocation
>>> Stay online with enterprise data centers and the best network in the bu=
siness
>>> Choose flexible plans and management services without long-term contrac=
ts
>>> Personal 24x7 support from experience hosting pros just a phone call aw=
ay.
>>> http://p.sf.net/sfu/theplanet-com
>>> _______________________________________________
>>> Openvpn-devel mailing list
>>> Openvpn-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>>
>>>
>>>
>
>
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

