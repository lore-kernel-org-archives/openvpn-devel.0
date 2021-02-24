From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <316dbdbb-5a21-1a08-9369-26010b106b18@...515...>
Message-ID: <1ac112f2-41c0-63ea-f004-9a175b19aeaa@...515...>
Date: Wed, 24 Feb 2021 16:13:24 +0200
MIME-Version: 1.0
In-Reply-To: <316dbdbb-5a21-1a08-9369-26010b106b18@...515...>
Content-Type: multipart/mixed; boundary="------------75C91B141A4E4C1B21CBD7AA"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (24th February
 2021)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------75C91B141A4E4C1B21CBD7AA
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 24th February 2021
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2021-02-24>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, d12fk, lev, mattock and plaisthos participated in this meeting.

---

Talked about OpenVPN 2.5.1 release. The release was tagged today
morning. Packages were being built during the meeting and the release
was pushed out after the meeting.

--

Plaishos is planning on writing an email announcing the alpha version of
openvpn2+dco. It was noted that we need to pick up slack on "master/2.6"
stuff or merging these DCO bits will become extremely painful.

--

Lev is working on ovpn-dco-win stability - added missing locks, SAL
annotations, running under driver verifier / KMDF verifier etc. Right
now he's adding IPv6 support.

--

Decided to move the rest of the discussion topics to next week as cron2
needed to split early and mattock wanted to push out the 2.5.1 release.

---

Full chatlog attached



--------------75C91B141A4E4C1B21CBD7AA
Content-Type: text/plain; charset="utf-8"; name="openvpn_irc_meeting_chatlog_2021-02-24.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2021-02-24.txt"

(12:30:04) cron2_: hah!
(12:30:05) cron2_: made it!
(12:31:19) d12fk: hiho
(12:31:56) ***plaisthos hides under a rock
(12:32:09) d12fk: you hide too loud
(12:32:29) cron2_: hiho d12fk :)
(12:35:25) lev__: hello
(12:35:25) dazo: hey!
(12:35:28) mattock: hi
(12:37:13) mattock: msi builds just finished
(12:37:16) cron2_: so.  I do not have very much time today.  My wife needs milk for her coffee... I will be pained otherwise... :-)
(12:37:18) mattock: so, topics for today?
(12:37:23) cron2_: 2.5.1 release!
(12:37:29) mattock: it is ongoing, end of story :D
(12:37:37) mattock: the less we babble here, the faster :D
(12:37:52) mattock: I'm about to push the windows msi packages for testing
(12:37:53) mattock: then testing
(12:37:54) cron2_: yeah.  For the others: 2.5.1 has been tagged and pushed this morning.
(12:37:56) mattock: then release notes etc.
(12:38:00) dazo: I'm running test builds of 2.5.1 for Fedora 34 now ... kicking of the Copr builds soon after that
(12:38:20) cron2_: cool.
(12:38:52) plaisthos: I will probably write a email announcing the alpha version of openvpn2+dco
(12:39:02) plaisthos: this week or early next week
(12:39:06) cron2_: cool!
(12:39:37) cron2_: we need to pick up slack on "master/2.6" stuff, otherwise merging these bits will be extremely painful
(12:39:41) plaisthos: draft for the announcement so far: https://github.com/schwabe/openvpn/blob/dco/Readme.dco.md
(12:40:18) plaisthos: relax, it is only 51 commits ahead of master ;)
(12:40:36) dazo: :-D
(12:40:46) cron2_: I'm worried about the SRV patch from themiron, which I assume to be conflict prone
(12:40:58) plaisthos: should be too bad
(12:41:05) plaisthos: I barely touch that part
(12:41:16) cron2_: "not" missing, I hope :-)
(12:41:29) dazo: "shouldn't be too bad" ... or ... "would be too bad"  ;-(
(12:41:30) dazo: ;-)
(12:41:34) mattock: fyi: https://build.openvpn.net/downloads/releases/OpenVPN-2.5.1-I601-amd64.msi
(12:41:37) mattock: I'll smoke-test that one
(12:41:43) cron2_: and I want to get rid of the heap of half-acked delayed-auth patches :-)
(12:42:21) plaisthos: yeah, there is also the patch that fixed a bug for jjk but I never heard back from him
(12:43:01) lev__: I was working on ovpn-dco-win stability - added missing locks, SAL annotations, running under driver verifier / KMDF verifier etc
(12:43:05) dazo: plaisthos: If you get the last outstanding bits of the 4 last delayed-auth patches updated, I can have a quick look at those
(12:43:08) lev__: now adding IPv6 support
(12:43:18) cron2_: the announcement sounds good.  I wonder about the "IPv6 mapped IPv4 addresses", but this is maybe better discussed this afternoon, outside the meeting
(12:43:28) cron2_: lev__: cool
(12:43:55) plaisthos: cron2_: currently bug/limitation in ovpn-dco itself.
(12:44:51) cron2_: plaisthos: but what is the limitation?  "receiving an IPv4 connection on an IPv6 socket, and passing the v4-mapped v6 socket to the kernel"?
(12:45:02) cron2_: or "inside"?
(12:45:30) cron2_: payload should never ever see v4-mapped addresses - they are illegal to be "put on the wire"
(12:45:46) plaisthos: cron2_: the first thing
(12:46:18) plaisthos: for inside the the tunnel that is something we leave to the linux kernel :)
(12:46:26) cron2_: okay.  These ugly code paths... - but as long as we have no dual-listen-sockets, we'll have to make this work
(12:46:51) cron2_: I would be totally OK with "we have no dual-stack sockets anymore", but that requires "dual listen sockets"
(12:46:52) plaisthos: Yeah multiple sockets might came later since I understand those code paths better now but one step at a time
(12:47:21) cron2_: whatever is the more sane path forward for dual-stacked servers
(12:47:35) plaisthos: the other strange multi ip option is also not supported
(12:47:48) cron2_: which one?
(12:47:51) plaisthos: that uses recvfrom/sendto to allow multiple ips on one socket
(12:48:02) cron2_: oh, --multihome
(12:48:09) plaisthos: yes
(12:48:31) cron2_: that needs to go to the limitations section
(12:48:46) cron2_: (because it breaks UDP-mode on hosts with multiple IP addresses)
(12:49:03) plaisthos: yeah
(12:49:11) cron2_: UDP server, that is, client works
(12:50:26) cron2_: ah, dafuq.  Need to go over and fix my ISP... something exploded.  Sorry.
(12:50:46) mattock: windows smoke testing passed
(12:53:59) mattock: anything we need to discuss? I'd love to wrap up the release if there's nothing
(12:56:40) mattock2 [~mattock@...1423.../corp/admin/mattock] è entrato nella stanza.
(12:56:40) modalità (+o mattock2) da ChanServ
(13:02:39) cron2_: let's move the remaining stuff from *last* week to *next* week :-)
(13:12:41) becm [~becm@...2595...] è entrato nella stanza.
(13:14:40) mattock2: +1

--------------75C91B141A4E4C1B21CBD7AA--

