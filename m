From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <9cbe2737-df06-c921-1052-3dabe3fb4141@...515...>
Message-ID: <7d06c8e9-ea46-e050-04cd-dccf04d2ba00@...515...>
Date: Thu, 3 Dec 2020 22:09:32 +0200
MIME-Version: 1.0
In-Reply-To: <9cbe2737-df06-c921-1052-3dabe3fb4141@...515...>
Content-Type: multipart/mixed; boundary="------------838D93BD1BC141A2928A419D"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (3rd December 2020)
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
--------------838D93BD1BC141A2928A419D
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thu 3rd December 2020
Time: 20:00 CET (19:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-12-03>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

becm, cron2, dazo, mattock, ordex, plaisthos and syzzer participated in
this meeting.

---

Agreed to release OpenVPN 2.4.10 early next week, assuming OpenSSL has
made their pre-announced (=important) release before that.

---

Agreed to bundle libpkcs11-helper 1.27 with 2.4.10. We're at 1.26 now,
and the changes between the versions look safe.

---

Noted that some of the auth-token fixed from Git "master" could and
should be backported to release/2.5. The refactorings done in "master"
could be omitted. It seems like at the moment there's no real need to
push out 2.5.1.

---

Agreed to not have meeting on Dec 23rd or 31st. The last meeting this
month will be on 17th.

--

Talked about HackerOne bounties. Agreed to go through the current
HackerOne reports and set awards (bounties) and close all reports down
(if possible) in the next meeting. Then we can close our HackerOne
project for good.

---

Noted that "IPv6 to community.openvpn.net" has not moved forward. But
OpenVPN Inc. ops team manager is aware that cron2 needs to be kept happy
and that IPv6 will have to arrive eventually.

---

Talked about the buildbot upgrade. It will need a couple of days of
concentrated effort from mattock's part. Doing the upgrade around
Christmas time sounds realistic.

---

Full chatlog attached

--------------838D93BD1BC141A2928A419D
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-12-03.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-12-03.txt"

(21:01:32) ordex: aloha!
(21:01:57) syzzer_: hi!
(21:02:10) mattock: hi
(21:02:28) becm: hi
(21:02:47) ordex: cron2: dazo: plaisthos: ?
(21:02:53) ***cron2 hides
(21:03:16) cron2 ha scelto come argomento: https://community.openvpn.net/openvpn/wiki/Topics-2020-12-03
(21:03:35) dazo: Hey!
(21:03:41) cron2: yo!
(21:04:43) plaisthos: I am only semi here
(21:04:52) ordex: which part is here exactly?
(21:05:00) cron2: which is half more than usual on thursday evenings
(21:05:05) ordex: :D
(21:05:53) cron2: whoa, 4 ACKs on the list
(21:06:20) ordex: amazzing
(21:06:33) ordex: are we aiming at doing another 2.4.x release?
(21:07:26) cron2: yes
(21:08:00) cron2: a number of bugfixes have accumulated in release/2.4, so we agreed (2-3 weeks ago) to do a 2.4.10
(21:08:04) cron2: eventually
(21:08:18) mattock: internal meeting goes on and goes on...
(21:08:36) cron2: tell them you do not care until the IPv6 crisis is solved :)
(21:08:44) mattock: :)
(21:08:57) ordex: :D
(21:09:02) ordex: cron2: ok
(21:09:12) mattock: so 2.4.10 when?
(21:09:47) cron2: I want the line number fix to be in, but have not written the second version yet... so maybe early next week?  What works for you?
(21:10:31) mattock: early next week would be ok
(21:11:07) cron2: good.  I'll see that I can get the patch done tomorrow-ish, so ordex can review it ("he ACKed the other one but wanted to see a variant")
(21:11:39) ordex: yup, can do
(21:12:28) becm: will the 2.4.10 for Windows ship with the brand new pkcs11-helper 1.27?
(21:12:28) cron2: 25 patches in tree since 2.4.9
(21:13:05) cron2: do we have feedback about pcks11-helper in 2.5.0?
(21:13:30) cron2: like, "works!" or "breaks :-("?  I haven't seen *any* feedback on 2.5.0 yet, which is sort of... "what does that mean?"
(21:13:31) mattock: becm: it looks like we have 1.26 now in generic/build.vars
(21:13:50) mattock: cron2: I think it means it is stable and boring
(21:14:17) cron2: this is how I like my software :)
(21:14:20) mattock: which is somewhat surprising given how much stuff went to it
(21:14:31) mattock: perhaps we're doing something right :D
(21:14:37) ordex: :D
(21:14:38) ordex: it happens
(21:14:44) ***cron2 pats his test rig :)
(21:15:22) mattock: so, libpkcs11-helper 1.26 -> 1.27 in 2.4.10 and 2.5.1?
(21:15:28) mattock: any reason not to?
(21:15:35) cron2: becm: what is in there?
(21:16:08) dazo: https://github.com/OpenSC/pkcs11-helper/releases
(21:16:19) becm: looks like 2 bugfixes to me?
(21:16:59) dazo: "thanks to Tunnelblick" ... smells like it has been tested ;-)
(21:17:20) mattock: at least in tunnelblick
(21:17:37) mattock: also look like your libpkcs11-helper patch should apply ok
(21:17:46) mattock: I say "why not"
(21:17:53) cron2: yea
(21:17:54) cron2: h
(21:18:28) dazo: agreed
(21:19:17) ordex: looks good to me too
(21:20:47) cron2: anything else on 2.4?
(21:21:38) dazo: Don't think so
(21:21:44) cron2: good :-)
(21:21:48) cron2: 2.5 status, then
(21:22:05) mattock: I think we need to update all the other dependencies as well - build-complete.vars has not been updated since 2.4.9, but that's the normal procedure anyways
(21:22:23) cron2: 4 patches in tree since 2.5.0, 1 "make install" patch, 2 "client side fixup for auth-token + auth-nocache" patches
(21:22:34) dazo: oh, OpenSSL is about to do a critical release one of these days .... we should wait for that to arrive
(21:22:44) plaisthos: yeah
(21:22:47) cron2: for the windows release, yes...
(21:22:49) plaisthos: next week
(21:22:50) dazo: I have no details what it might carry, but they did a pre-announcement
(21:23:03) mattock: ok, let's not release anything before that openssl upgrade is out
(21:23:14) mattock: I don't want to do releases every other day :)
(21:23:29) cron2: anyway... we could do a 2.5.1 release, which has client side benefits, but the changes are small yet
(21:23:44) dazo: mattock: Do you know how many releases Amazone does per day? ;-)
(21:23:53) mattock: we're not Amazon
(21:24:01) syzzer_: cron2: and a couple of tls-crypt-v2 fixes, "soonish", right? :-p
(21:24:02) mattock: we have one guy doing releases
(21:24:04) mattock: :)
(21:24:15) cron2: master has a much larger fix set for auth-token in combination with plugin auth (or generally "multiple auth paths").  The patch is 3 lines, but it needs 7 pre-patches for cleanup... :-)
(21:24:50) cron2: this would be a good fix to have in 2.5.x, but I'm somewhat reluctant to pull in all the refactoring needed
(21:24:57) cron2: plaisthos: what do you think?
(21:25:03) plaisthos: yeah I think the main fix can be backported
(21:25:14) plaisthos: without the refactoring
(21:25:32) plaisthos: the refactoring was also due to better understanding of the code etc
(21:26:32) mattock: btw. do we want to have a meeting on 23rd Dec?
(21:26:38) cron2: agree.  I'm not sure which of the interesting bits it needs
(21:26:40) mattock: I'm sending the invite I forgot to send :)
(21:26:45) mattock: 31st is probably out of the question
(21:26:47) mattock: at least for me
(21:26:57) dazo: 23rd is also not an ideal date
(21:27:13) cron2: mattock: no 31st for me, and 23 is also interfering with family business :)
(21:27:34) dazo: I'd suggest 17th as the last meeting this year and we all go and have a nice holiday time until January
(21:27:57) cron2: syzzer_: yes, 3 tls-crypt related fixes coming in
(21:28:14) cron2: dazo: someone wanted to do a 2.6 release in January or so :-)
(21:28:27) cron2: "to meet debian cutoff"
(21:28:32) mattock: dazo: agreed
(21:28:34) ordex: :D
(21:28:36) mattock: 17th it shall be
(21:28:41) ordex: +1
(21:28:44) cron2: aye aye sir!
(21:29:21) dazo: cron2: I say a lot of crazy stuff :-P ... but! it's also depending on a lot of other factors, as the dco work and such
(21:29:44) cron2: ok, sounds like "2.5.1 when there is enough interesting bits in"
(21:30:19) cron2: dazo: haha :-) - I hear voices that tell me DCO is all done, it just needs a bit of polish
(21:30:49) dazo: but we all know the polishing is where all the hard work appears :-P
(21:30:55) cron2: well said :)
(21:32:03) cron2: that said... 2.6?  anything interesting?
(21:32:17) plaisthos: I broke ordex frist idea how to implement multiple peer mode
(21:32:28) ordex: well, we're getting there :D
(21:32:32) cron2: that was the wrong sort of polish :)
(21:32:41) plaisthos: and now I passed to token back to ordex
(21:35:12) cron2: sooo...
(21:35:45) mattock: more on?
(21:35:49) mattock: move on
(21:35:55) mattock: auth-nocache?
(21:36:05) cron2: auth-nocache went on the agenda because I felt it was a bit unclear what it was supposed to do... but since we managed to not change what it does while fixing the token stuff, it is somewhat "not that impotrant"
(21:36:18) mattock: ok
(21:36:23) mattock: next topic?
(21:36:29) mattock: that is, "HackerOne bounties"
(21:36:37) mattock: anyone remember how they're supposed to work?
(21:36:39) cron2: (so what it does: it cleans username *and* password after TLS connect, and still does, just now it does so "after PUSH_REPLY, if pull")
(21:36:46) cron2: mattock: i hoped that you could answer that
(21:37:13) cron2: we actually received a useful submission - one of our travis scripts was doing http downloads with no checksumming, while it could have done https.
(21:37:23) mattock: I have a vague recollection that we have to close the report down and then we can do something to tag the report as worth a bounty
(21:37:25) cron2: So I changed that (it's in tree)
(21:37:36) mattock: emphasis on "vague" :)
(21:37:40) cron2: but I have no idea what the rules, and the sums, and the process is
(21:37:48) mattock: we've never done it I believe
(21:37:55) syzzer_: I share a vague recollection that matches mattock's
(21:37:59) cron2: it's no critical bug, but worth some sort of thank you in any case
(21:38:03) mattock: yeah
(21:38:14) mattock: if two people have the same recollection that recollection may be correct :D
(21:38:15) cron2: mattock: can you find out?
(21:38:28) mattock: probably, I can try closing the report down now
(21:38:36) cron2: commit d3dd620b13a21c3ed73fd466390f471915937309
(21:38:38) cron2:     Reported by "jub0bs" on hackerone.com (#1039504)
(21:40:00) mattock: ah
(21:40:03) mattock: we can "Set award"
(21:40:07) mattock: in dollars
(21:40:08) cron2: ah!
(21:40:20) mattock: what is the report worth?
(21:40:23) cron2: so, what are the sums we are talking about, and who pays?
(21:40:39) mattock: I believe the money comes from IBB and/or OSTIF
(21:40:47) mattock: I'm not sure what kind of deal they did
(21:41:15) mattock: I'll check if OSTIF has some guidelines on this
(21:41:17) cron2: I have no idea what "someone could mess with your build scripts" is worth.  Less than "someone could crash your program", and much less than "someone can break into your software".  But in absolute numbers?
(21:41:22) cron2: yes, that would be good
(21:41:49) cron2: thanks :)
(21:42:06) mattock: Guido Vranken who reported several issues in OpenVPN got $5000
(21:42:09) mattock: https://ostif.org/congratulations-to-guido-vranken-for-earning-our-first-bug-bounty/
(21:42:11) vpnHelper: Title: Congratulations to Guido Vranken for earning our first bug bounty! Open Source Technology Improvement Fund (at ostif.org)
(21:42:32) cron2: that's quite a bit of money, but I seem to remember that he had at least one "crash our software" in them
(21:42:32) mattock: but he spend _way_ more time on it than jub0bs
(21:42:41) mattock: I'd say this is something like $50-$100
(21:42:50) cron2: definitely... so $50-ish sound okay-ish
(21:43:03) mattock: let's do $50, this kind of stuff is trivial to find by anyone
(21:43:16) cron2: okay
(21:43:18) mattock: nice that it was found, but not rocket science nor required much effort
(21:44:08) syzzer_: and without any user impact :)
(21:44:22) syzzer_: so yeah, sounds like the right order of magnitude
(21:45:50) mattock: hackerone suggested $100 minimum so I chose that one
(21:46:05) cron2: so this is what it is :)
(21:46:39) mattock: awarded and closed the report
(21:46:53) mattock: next topic?
(21:46:56) cron2: purrfect
(21:47:00) cron2: yes :)
(21:47:04) cron2: dear to my heart!
(21:47:34) mattock: the response ("no progress whatsover") is probably not what you'd like to hear
(21:48:04) mattock: I will periodically bug the ops team manager about it
(21:48:22) cron2: it is time for more interesting threats... has someone's dog died yet?
(21:48:28) mattock: no, not yet
(21:48:49) mattock: maybe you could hire a bunch of people to complain about lack of IPv6 support?
(21:48:53) mattock: to build some pressure
(21:48:58) mattock: :D
(21:49:04) becm: mattock: mayba bargain, "drop the cookie-requirement or enable IPv6" :)
(21:49:17) cron2: corp policy is "these are not serious customers, they are just complainers"
(21:49:38) mattock: believe it or not, they'd like to keep _you_ happy
(21:49:39) ordex: :D
(21:49:45) mattock: they know your role in OpenVPN 2
(21:50:27) mattock: I remind them that we need to keep you happy
(21:50:32) cron2: good to be appreciated :-)
(21:50:32) mattock: happy enough, at least :)
(21:50:37) cron2: totally so!
(21:50:50) mattock: I've _been reminding_ them
(21:50:55) mattock: and will keep doing so
(21:51:02) cron2: thanks.
(21:51:05) mattock: np
(21:51:07) cron2: sooo... buildbot...
(21:51:10) becm: so if cron to "likes" to complain... the keep IPv6 from him? :)
(21:51:28) cron2: becm: you could open a few sales inquiry tickets!
(21:51:30) dazo: mattock: can you complete all the bounties there ... so we can shut it down finally?
(21:51:46) mattock: dazo: just let me know which reports deserve a bounty
(21:51:52) mattock: and what size
(21:51:56) mattock: then it is no problem for me
(21:52:31) cron2: if we close down hackerone, we should agree on a different way to receive reports that might be bounty-worthy...
(21:52:55) cron2: (but I am too tired today to have good suggestions)
(21:53:14) mattock: what if we go through the remaining hackerone tickets in the next meeting, set bounties and close all of them down?
(21:53:25) cron2: okay
(21:53:37) mattock: we have a bunch open
(21:53:43) mattock: dazo: works for you?
(21:54:27) mattock: on the topic list: https://community.openvpn.net/openvpn/wiki/Topics-2020-12-09
(21:55:02) mattock: anyhow, buildbot: I think getting it nailed down around Christmas time looks realistic, possibly earlier
(21:55:11) mattock: it needs a focused effort of a couple of days
(21:55:22) mattock: with the Windows / tap-windows6 buildslave
(21:55:35) mattock: plus upgrade of the buildslaves
(21:55:43) cron2: with the *BSD zoo, the MacOS buildslave, the OpenSolaris buildslave :-) - yes
(21:56:04) cron2: just let me know, then, and "what do I need" - which packages, which versions, etc.
(21:56:11) ***cron2 <- python noob
(21:56:14) mattock: cron2: +1
(21:56:26) mattock: anything else for today?
(21:56:44) ordex: make ipv6 great again!
(21:57:24) cron2: there's a few ipv6 related bugs in trac... :-)
(21:57:26) cron2: but not today
(21:57:39) cron2: I wish you all a good evening!  I hear my sofa calling!
(21:57:49) mattock: good evening everyone!
(21:57:55) syzzer_: hehe, good night all!
(21:57:55) mattock: I'll wrap up the summary and then head home
(21:58:02) cron2: *wave*
(21:58:12) ordex: good night !
(21:58:26) dazo: mattock: I think I suggested $50 for a one report ... and that was about it
(21:59:16) dazo: mattock: I tried to close down a lot of tickets .... was not aware there where that many left
(22:06:48) mattock: dazo: ok

--------------838D93BD1BC141A2928A419D--

