Message-ID: <4B65724F.6080201@...515...>
Date: Sun, 31 Jan 2010 14:06:39 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040205020102080902010500"
Subject: [Openvpn-devel] Summary of the IRC meeting (28th Jan 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------040205020102080902010500
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Here's the summary for last Thursday's community meeting.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------040205020102080902010500
Content-Type: text/plain;
 name="openvpn_irc_meeting_2010-01-28.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn_irc_meeting_2010-01-28.txt"

COMMUNITY MEETING

Place: #openvpn-discussion on irc.freenode.net
Date: Thursday, 28th January 2010
Time: 19:00 UTC

Full log available here:

http://secure-computing.net/logs/%23%23openvpn-discussion.log

Next meeting on Thu 4th Feb 2010. Same place, same time.

SUMMARY

Decided to start with a single Trac-based site for the whole community rather than have separate user/developer sites. The main concern was the risk of content getting fragmented (e.g. developer content in user wiki and vice versa). This means Trac will need to be themed to make it as approachable as possible for "normal" users (=not look too developer-oriented).

Agreed that we need a set of documents describing how OpenVPN is developed - including things like common coding conventions. This should improve code quality as well as make the process less taxing for core developers.

Agreed that the content from the new community site needs to be 

 a) mirrored to another server (e.g. ecrist's OpenvPN community server)
 b) backed up off-site (e.g. to ecrist's server and/or OpenVPN e.V.)
 c) accessible by a community member

This helps prevent data loss for any reason - political or technical.

Discussed community site spam prevention in some length:

* There is an anti-spam plugin for Trac (see below)
* A proper user registration process needs to be chosen - not too bureaucratical but not too automated, either
* Forum posts could be automatically accepted only after the first few have been accepted manually by the admin(s)

Discussed which forum software to use. PhpBB is apparently the best OSS solution out there.

Discussed potentially useful Trac plugins:

* http://trac.edgewall.org/wiki/PluginList
* http://trac-hacks.org/
* http://trac-hacks.org/wiki/DiscussionPlugin (for forums, probably not as good as phpBB and such)
* http://trac.edgewall.org/wiki/SpamFilter (spma filtering)
* http://trac-hacks.org/wiki/TicketImportPlugin (for importing SF.net tickets)
* http://trac-hacks.org/wiki/TracBuildbotIntegration (for automated building and regression testing with buildbot)
* http://trac-hacks.org/wiki/MediaWikiPluginMacro (mediawiki syntax for Trac)
* http://trac-hacks.org/wiki/TocMacro (automated Table of contents creation)
* http://trac-hacks.org/wiki/DownloadsPlugin (downloads through Trac, e.g. for file releases)
* http://trac-hacks.org/wiki/DefaultCcPlugin (a default CC for tickets, e.g. inform James or devel-list)
* http://trac-hacks.org/wiki/IrcAnnouncerPlugin (Trac makes announcements of changes to IRC)
* http://trac-hacks.org/wiki/IrcLogsPlugin (IRC logs to Trac)

Also discussed IRC<->Trac integration using Trac's built-in RSS support.

--------------040205020102080902010500--

