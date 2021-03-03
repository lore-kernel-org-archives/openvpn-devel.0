From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <3898de1c-1799-46f3-2ec2-55f70fa04679@...515...>
Message-ID: <0673dc92-3a0c-7174-0378-9bddb1e18322@...515...>
Date: Wed, 3 Mar 2021 13:47:46 +0200
MIME-Version: 1.0
In-Reply-To: <3898de1c-1799-46f3-2ec2-55f70fa04679@...515...>
Content-Type: multipart/mixed; boundary="------------5BE0BF6E424027EB0580B3CD"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (3rd March 2021)
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
--------------5BE0BF6E424027EB0580B3CD
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 3rd March 2021
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2021-03-03>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, lev, mattock, novaflash and ordex participated in this meeting.

---

Mattock is planning to automate agenda wiki page creation [and
invitation email sending] as he forgets to do that almost every month.

--

Noted that Access Server needs IPv6 support, but Python 3 port needs to
go in first.

--

Lev IPv6 and TCP support for ovpn-dco-win. TCP is a bit slower
comparison to UDP but still good enough. Server-side support is missing,
but that is not the primary goal anyways. Installer (MSI) support is
also missing.

The goal is to have both Linux and Windows DCO in 2.6.

--

Mattock reopened discussion with Microsoft (and Simon and Lev) about
Windows ARM64 support in OpenVPN 2.5 MSI installers. No progress yet on
that front. Agreed that Microsoft should put the effort to patch the
MSIs to work on ARM64. For now we have the legacy NSIS snapshot
installers for 2.5 which ARM64 people can use if they wish.

--

Mattock will start work on the buildbot upgrade and refactoring with
krzee soon. The test coverage will also be increased a lot [by adding
some internal OpenVPN Inc. test scenarios to the mix].

--

Agreed to try to release OpenVPN 2.5.2 next Wednesday (10th Mar). If we
fail to do that postpone the release by one week. This release will have
a security fix.

--

Noted that novaflash is training an OpenVPN Inc. support guy to answer
forum posts that are related to OpenVPN Inc. products. Novaflash is also
slowly moving product tickets from Trac to internal developers to solve.

---

Full chatlog attached

--------------5BE0BF6E424027EB0580B3CD
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2021-03-03.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2021-03-03.txt"

(12:32:32) lev__: guten tag
(12:32:45) novaflash: tag cloud
(12:33:34) novaflash: why is topic linking to wed 3rd feb meeting
(12:34:03) cron2_: our meeting organizer seems distracted...
(12:34:06) mattock: yellow
(12:34:31) mattock: I trust that somebody else remembers to change the topic here :D
(12:34:33) cron2_ ha scelto come argomento: Agenda https://community.openvpn.net/openvpn/wiki/Topics-2021-03-03
(12:34:40) cron2_: (but that page is not yet existing...)
(12:34:42) mattock: an it worked!
(12:34:49) mattock: oh shit, the months go by
(12:34:54) dazo: hey!
(12:34:58) mattock: well, at least these meetings are 100% predictable now
(12:35:05) mattock: let me create that page now
(12:36:05) dazo: cron2_: did you see the link to the analogue terminal bell on #openvpn-devel? .... could probably arrange that for you! :-D
(12:37:27) cron2_: dazo: yes, this what I'm referring to :)
(12:38:58) dazo: :)
(12:39:59) mattock: I think I'll look into the Trac API and see if I could create meeting pages from now to 2025 (https://www.edgewall.org/docs/branches-1.2-stable/html/api/index.html)
(12:40:02) vpnHelper: Title: API Reference Trac branches-1.2-stable-r17480 documentation (at www.edgewall.org)
(12:40:49) dazo: mattock: make something which writes the minutes automatically from our meeting discussions and creates real topics for the next meeting automatically ;-)
(12:40:52) novaflash: yes it would be excellent if you could just plan the next few years of topics for us, that would give us some insight in what needs to be developed next hehe
(12:41:06) ordex: do we have any topic for today? :D
(12:41:07) cron2_: novaflash: AS needs IPv6
(12:41:14) ordex: other than the usual suspect ?
(12:41:18) novaflash: yeah i agree cron2_
(12:41:18) cron2_: well, we wanted to reopen the topics from 2 weeks ago
(12:41:26) mattock: dazo: should I also write something that will have the meetings on our behalf?
(12:41:31) ***cron2_ goes copypaasta
(12:41:47) novaflash: we're getting to python3 first and then we'll look at ipv7
(12:41:50) novaflash: ipv6
(12:41:56) dazo: mattock: hmmmm ... lets call that version 2 ;-)
(12:41:58) novaflash: oops. man i'm in the future already.
(12:42:01) mattock: dazo: ok
(12:42:08) mattock: :)
(12:42:18) lev__: I have finished IPv6 and TCP support for ovpn-dco-win, now instrumenting driver with trace framework
(12:42:33) cron2_: so, topics
(12:42:42) cron2_: lev__: wohoo!
(12:43:15) lev__: TCP is a bit slower comparison to UDP but still good enough
(12:43:41) cron2_: so what is missing from dco-win?  this is client-only or client+server?
(12:43:58) lev__: server support is missing
(12:44:28) ordex: i think the idea is to get client-only out first, no lev? as window server is not really a high priority
(12:44:46) lev__: and installer (openvpn-build/msi) has to be changed to add new driver there
(12:45:02) ordex: cron2_: ideally it will be published along with some basic ovpn3 support, so that people can test it, instead of staring at it only
(12:45:09) cron2_: I just wanted to know.  Some people do run servers on windows, and then ask interesting questions :-) - but like 99% do "client on windows, server on real OS"
(12:45:24) ordex: :D
(12:45:27) ordex: *real OS*
(12:45:36) cron2_: lev__: is this with ovpn3 or do you have ovpn2 code as well?
(12:45:40) lev__: I have a hacky ovpn3 support, but waiting for d12fk to implement the "proper one"
(12:46:09) lev__: plaisthos is going to add win-dco support since he has enough dco experience
(12:46:17) dazo: mattock: https://github.com/rkdarst/MeetBot/blob/master/doc/Manual.txt ;-)
(12:46:18) cron2_: ok
(12:46:27) ordex: plaisthos is the dcoman for ovpn2 nowadays
(12:46:53) lev__: the driver includes test client though with which one can establish VPN tunnel
(12:47:18) cron2_: but having win-doc plus linux-dco in 2 is good, because if that all works, freebsd-dco should have "ovpn2 code" that tells them what to do fbsd-side
(12:47:22) lev__: you can make tunnel between ovpn-dco-win and ovpn-dco linux (which also includes test client)
(12:47:52) ordex: cron2_: yeah, that's the plan
(12:47:58) ordex: goind full dco !
(12:48:01) ordex: *going
(12:48:35) cron2_: very nice :-)
(12:49:45) novaflash: insert 'never go full retard' meme here
(12:50:39) cron2_: okay, anything else on 2.6?  I got distracted again from merging those patches that *do* have ACKs, but will return to it.  Waiting for a new version of 03/11 though :-)
(12:51:18) dazo: I've managed to postpone reviewing updated patches from plaisthos two days ... I'll try to get it done today
(12:51:21) lev__: can we agree that 2.6 will include dco-win ?
(12:51:36) dazo: lev__: if it is ready for it, sure
(12:51:44) cron2_: dazo: nothing to review yet, we need a new version of 03 and (I think) 05
(12:52:09) cron2_: lev__: I'm operating under the assumption "the big thing for 2.6 is DCO", and if we can have all platforms, even better
(12:52:27) ordex: yeah
(12:52:30) cron2_: some day we need to agree on a release date, and then we know if win-dco is in or not :-)
(12:52:30) ordex: i think it would be nice
(12:52:32) dazo: cron2_: it's the auth-pending patches, I reviewed the last few patches of the whole round .... some minor things, iirc ... unless somebody else acked it already :D
(12:52:33) lev__: good good
(12:52:34) ordex: so we don't have to wait for 2.7
(12:52:35) cron2_: what about: August 1?
(12:52:57) cron2_: dazo: yes, these.  03 and 05 have NAKs because they do not compile individually
(12:52:57) dazo: SGTM!
(12:53:05) novaflash: well, if you want to release on a sunday...
(12:53:28) cron2_: we planned 2.5.0 for "July 1st" IIRC and released in October :-)
(12:53:37) ***novaflash does the math
(12:53:40) ordex: :D
(12:53:51) cron2_: this is more "will it happen mid of this year" or "in 3 years, as we usually do major releases"
(12:53:57) novaflash: let's agree to release last month, then it will be ready for august 1
(12:54:26) cron2_: but "roughly 1 year after 2.5.0" is what we wanted to aim for
(12:55:00) mattock: if "DCO" is the goal then that goal seems reasonable
(12:55:12) mattock: if more features start creeping in then it might be tough
(12:56:02) cron2_: I see "DCO", "delayed auth" and "the TLS renegotion cleanup" on my mental roadmap
(12:56:08) cron2_: half of that is already half-done
(12:56:09) dazo: plaisthos: did you also have an update on patch 11/11 of the delayed auth stuff?
(12:56:59) mattock: mmm, I wonder if we have a planning page for 2.6...
(12:57:32) cron2_: of course
(12:58:17) cron2_: I can't find it, though
(12:58:31) dazo: https://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn26
(12:58:43) cron2_: so easy
(12:58:48) mattock: yes
(12:58:55) mattock: on the front page in the most logical place possible :D
(12:59:42) cron2_: ah, yes, if ordex and I get bored, we wanted to revamp the whole "how can the client react more sensibly to external network changes" thing
(12:59:58) ordex: yeah
(13:00:00) ordex: get bored ..
(13:00:02) cron2_: and of course the multi-socket thing
(13:00:16) ordex: that has been idling there for a bit ... plaisthos may be willing to take on it
(13:00:32) ordex: and continue my work, that I continued from d12fk's work :D
(13:00:32) cron2_: yeah, plaisthos said something about "understanding the code better now"
(13:00:44) cron2_: plaisthos could hand it back to d12fk then
(13:00:51) ordex: yap
(13:00:55) ordex: he says[tm]
(13:01:04) ***cron2_ <- silly wednesday
(13:02:39) dazo: well, we're trying to trick d12fk into getting back into the multi-socket saddle again ... no luck so far :-P
(13:02:51) cron2_: the page lists "August 21" and "DCO (on Windows)" now.
(13:03:02) dazo: nice!
(13:04:11) cron2_: anything else on 2.6?
(13:05:28) dazo: Lets say that's enough for 2.6, we shouldn't get tempted to add more into it ;-)
(13:06:08) cron2_: more about the "agenda item" - anything else to mention wrt 2.6?
(13:07:20) mattock: not really, but I should mention that I reignited the discussion with Microsoft (Jon et al) about ARM64 support in 2.5
(13:07:50) mattock: maybe they would interest enough about their own platform to put in the work to make MSI installers work there
(13:07:52) cron2_: we're coming to 2.5 now :-)
(13:07:53) mattock: in 2.6
(13:08:07) cron2_: what is lacking in the MSI installers?
(13:08:20) mattock: MSIs assume all contents are the same architecture
(13:08:45) cron2_: so you can't bundle arm64/tap + intel/openvpn.exe?
(13:08:47) mattock: therefore the 32-bit MSI installer which you're supposed to use on ARM64 will fail, because they will try to install 32-bit Intel drivers as well
(13:09:00) mattock: you can, but it requires some MSI custom action magic
(13:09:08) mattock: which would be the easy way to do it
(13:09:17) cron2_: and "someone" needs to write that?
(13:09:36) cron2_: (we could compile openvpn for arm64...)
(13:09:43) cron2_: would that work?
(13:10:05) mattock: that "someone" should somebody from "Microsoft" imho
(13:10:38) mattock: I suspect OpenVPN 2 may not be buildable on Windows ARM64 now
(13:10:42) mattock: even on MSVC
(13:10:43) cron2_: why?
(13:10:53) mattock: I recall Jon mentioning something along those lines
(13:10:59) mattock: he only ported the tap-windows6 driver to arm64
(13:11:05) mattock: but I could be wrong
(13:11:15) mattock: anyhow, I think this is on MS plate
(13:11:25) cron2_: well, I seem to remember that the idea was "no need to port openvpn, because intel binaries do work"
(13:11:34) mattock: yes, that is correct
(13:11:46) cron2_: the Tunnelblick people ship ARM64 openvpn on M1 macs, and only the "Tunnelblick" binary is translated
(13:12:15) mattock: anyways, no response yet from Microsoft, so we'll have to wait a bit
(13:12:21) cron2_: so there is nothing in openvpn that would make it "arm incompatible" (unsurprisingly, I also tested FreeBSD/rPI ARM64), but "can we get the pieces to build" is harder, of course
(13:12:28) mattock: this also ties in with ovpn-dco-win
(13:12:46) cron2_: indeed
(13:13:12) mattock: but I'd just let microsoft take the initiative here, I heard from novaflash that windows arm64-related (customer) requests are quite rare
(13:13:46) mattock: and afaik nobody has asked about 2.5 on win+arm64
(13:14:49) mattock: I'm going to add links to the NSIS snapshot builds (which are in a limbo I believe) to the download page
(13:15:00) mattock: anyways, that's all from me
(13:15:27) mattock: well, not really, I will start the buildbot upgrade / refactoring soonish with Jeff, and we'll expand the test coverage a lot
(13:15:39) cron2_: not sure if arm64 windows is really still a thing... apple is playing this game very differently :-)
(13:15:40) mattock: more on that later when there's an actual plan :)
(13:15:45) cron2_: who is Jeff?
(13:15:49) mattock: oh yes
(13:15:51) mattock: krzee
(13:15:54) mattock: I blowed his cover
(13:16:10) cron2_: ah, the person working on IPv6 for community...
(13:16:23) cron2_: I'm not asking, because we need to spend some time on 2.5.2 now...
(13:16:51) mattock: yes, let's go to 2.5.2
(13:17:20) cron2_: so, I propose to do 2.5.2 middle next week
(13:17:29) cron2_: we need a CVE# (dazo)
(13:17:36) cron2_: our first own, I think
(13:18:14) cron2_: there is a bit of windows gui goodness which could use a review or testing... so we could this actually have new features as well :-)
(13:22:17) mattock: everyone fell asleep?
(13:22:27) cron2_: seems everybody agrees :-)
(13:22:29) cron2_: well
(13:22:45) ***cron2_ assigns tasks now, and if you do not complain, it is considered "accepted"
(13:22:50) cron2_: dazo: please make a CVE number
(13:22:58) cron2_: mattock: please prepare a release next wednesday
(13:23:09) cron2_: lev__: please have a look at the openvpn-gui niceness from Selva
(13:23:26) cron2_: ordex: please fix multi-socket by Thursday
(13:23:48) cron2_: now that sounds promising :-)))
(13:24:03) dazo: I'm catching up on the CNA changes .... there's some automation going on nowadays
(13:27:05) cron2_: so where did everyone else run to?  free beer?
(13:27:56) mattock: wednesday seems to be ok for me
(13:28:13) novaflash: i'm just waiting for the forums topic to come up
(13:29:01) dazo: I'm slightly reluctant to 2.5.2 next week, but lets see if we can manage it.  It's an important fix, but it's not burning our feet as it is now. It's not too trivial to trigger
(13:29:01) cron2_: novaflash: I've seen that you already moved quite some denys tickets to "inc" - thanks for that
(13:29:19) cron2_: dazo: which part of "next week" are you worried about?
(13:29:27) lev__: I will look into gui changes
(13:29:45) cron2_: lev__: cool, thanks :-) (that was half-joking and half-hoping)
(13:30:15) dazo: cron2_: the CVE assignment .... we need to return unused 2020 numbers, and then we can get new 2021 numbers ... and then there's this whole potentially new automation project MITRE got running
(13:30:24) cron2_: if we do "in 2 weeks", that is also fine, but we need to set a date, and then get stuff done in time :)
(13:30:55) cron2_: what about "we try to make next wednesday, and if that does not work, we won't make it"? :-)
(13:31:05) dazo: let's have next Wednesday as the tentative goal .... and if we miss it, we shift it one week
(13:31:10) dazo: right
(13:31:11) cron2_: works for me
(13:31:18) dazo: sounds good
(13:31:34) mattock: +1
(13:31:57) cron2_: ok, so novaflash has -1 minute for "forums" :)
(13:32:05) novaflash: nice
(13:32:26) novaflash: well i am now participating there and training one other guy manually now
(13:32:38) novaflash: and based on that making an internal training program to add more guys later
(13:32:53) novaflash: i've reorganized the forums in the openvpn inc section quite a bit
(13:33:06) novaflash: added a forum for openvpn cloud product, and for openvpn connect for windows and smackOS
(13:33:23) novaflash: and removed a lot of subforums and moved the tickets in there to one of the main forums
(13:33:45) novaflash: we had things like 'feature requests' and 'how to' and 'troubleshooting' and so on and we don't want that complexity in the openvpn inc section
(13:33:52) novaflash: just KISS principle
(13:34:13) novaflash: i do still see the same problem i experienced before with the community section - in that i have no clue where to move things to that are about community version
(13:34:24) novaflash: sometimes i just take a gamble and throw it somewhere
(13:34:46) cron2_: move to "general" and have the "community manager" pick it up?
(13:34:49) novaflash: but there's no really good 'troubleshooting why my connection does not work' section in community area except perhaps server configuration or such
(13:34:59) novaflash: is there a general?
(13:35:16) novaflash: because i don't see a 'general' board
(13:35:20) cron2_: I thought we wanted to add that (troubleshooting)...
(13:35:31) novaflash: oh i see. well i have not seen it materialize yet
(13:35:44) novaflash: so anyways i guess the status there is unchanged then
(13:36:31) novaflash: then regarding trac, i'm very slowly picking those up a few at a time to avoid pissing off our devs, but also to ensure i can chase down results of each item i pick up - that it either gets logged internally in our ticketing system or that i have sufficient explanation why it is not getting picked up. so i'll continue doing that.
(13:36:47) cron2_: maybe have a chat with ecrist and pippin on that?
(13:36:59) cron2_: (that was related to the forums)
(13:37:01) novaflash: anyway, that's it from my side - just curious to learn if anyone is going to pick anything up about forum updates and reorganzing the boards
(13:37:21) novaflash: yeah i can bug those two, kinda hoping one of them would be here like last time pippin was here
(13:37:28) cron2_: I'm not a forums person ("I only look there if someone points an URL at me")
(13:37:31) cron2_: yeah
(13:37:39) cron2_: we did not send a meeting invitation methinks :)
(13:37:43) novaflash: anyway that's all the bitching from my end
(13:37:47) cron2_: thanks
(13:38:12) cron2_: I am tired and everyone else seems to be asleep already... push the rest to next week?
(13:38:59) novaflash: :-)
(13:39:52) dazo: sounds good
(13:41:39) ***cron2_ rings the bell for mattock to conclude the meeting
(13:41:46) cron2_: dazo: we need physical bells!
(13:43:06) mattock: yep, I wrote the summary
(13:43:19) mattock: I don't want to pick up any forum posts, never done it, never will :D
(13:43:55) cron2_: enjoy lunch :)

--------------5BE0BF6E424027EB0580B3CD--

