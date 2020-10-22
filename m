From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <4bf0a788-1a6a-34a8-7ecf-587d23c3eb6b@...515...>
Message-ID: <a8c69d9c-d5a4-1627-e210-2f59bf11458a@...515...>
Date: Thu, 22 Oct 2020 22:08:19 +0300
MIME-Version: 1.0
In-Reply-To: <4bf0a788-1a6a-34a8-7ecf-587d23c3eb6b@...515...>
Content-Type: multipart/mixed; boundary="------------65BC7593DA36C39B407D5E23"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (22nd October 2020)
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
--------------65BC7593DA36C39B407D5E23
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thu 22nd October 2020
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-10-22>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

becm, cron2, dazo, mattock and plaisthos participated in this meeting.

---

Talked about turning on IPv6 on the openvpn.net domain, in particular 
community.openvpn.net. As turning on IPv6 in Cloudflare is per-domain, 
the current plan from OpenVPN Inc. operations' team is to finish a 
migration of some critical servers/services to the openvpn.com domain 
(which has IPv6 enabled), then try turning on IPv6 on openvpn.net 
domain. This will happen in November (optimistic estimate) or this 
quarter (realistic estimate).

---

Mattock has started the long overdue buildbot upgrade by setting up a 
PoC buildmaster (2.x). The initial targets for the new buildbot setup are:

- Building tap-windows6 (to get automated HLK testing running)
- Building MSI snapshot installers

The existing buildslaves and master.cfg can be migrated later.

---

Noted that there are no known issues in OpenVPN 2.5-rc3. This gives 
confidence that we can release 2.5.0 soon.

---

Planned the OpenVPN 2.5.0 release.

Agreed that we should invest some time in the release announcement text 
(pointing out surprises with BF-CBC using setups and 2.3 servers), and 
maybe have a thorough look at Changes.rst as well.

Changes.rst change could be drafted in a public Etherpad such as this:

<https://wiki.mozilla.org/Etherpad>

It allows GitHub logins among other things.

We will aim to have the release announcement and tag ready next Tuesday 
so that the release can be made on Wednesday.

---

Dazo is wrapping up the openvpn3-linux v11 beta release and has ovpn-dco 
packages for Ubuntu 20.04 and Fedora 31, 32 and 33 ready.

--

Full chatlog attached


--------------65BC7593DA36C39B407D5E23
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-10-22.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-10-22.txt"

(21:00:10) mattock: good evening people!
(21:01:20) mattock: I believe it is meeting time
(21:01:44) cron2: yo
(21:01:46) mattock: hi!
(21:02:00) mattock: while waiting let's start with cron2's favorite topic
(21:02:14) cron2: haha :)
(21:02:25) cron2: so, any well-tasting cakes today?
(21:02:36) mattock: so, the proposal from the ops team/manager regarding IPv6 on openvpn.net domain
(21:02:40) mattock: no cakes
(21:02:52) cron2: "no cake" is not one of my favourite topics
(21:03:22) mattock: the is a large number of critical servers getting moved away from openvpn.net to openvpn.com
(21:03:30) mattock: servers/services
(21:03:51) mattock: that will optimistically happen in November, and realistically by the end of the year
(21:03:56) dazo: Hey!
(21:04:12) mattock: after that the risks of turning on IPv6 would be way smaller
(21:04:18) cron2: well, I do not think this is a strategy worth of a technology company... "AVOID IPV6 AT ALL COSTS!".  But if it brings back IPv6 to the rest...
(21:04:44) cron2: I could sell some IPv6 consulting... :-)
(21:04:50) mattock: so basically: migrate the critical stuff over to .com (which has IPv6 enabled, btw), then switch on IPv6 on openvpn.net
(21:05:00) cron2: wat
(21:05:10) mattock: yes
(21:05:22) cron2: watever :)
(21:05:38) dazo: there are more voices internally which also questions these worries about IPv6
(21:05:56) mattock: the problem with those voices is that it's not their head on the plate if money stops flowing
(21:06:13) mattock: it's not even my head on the plate
(21:06:40) dazo: well, lets not dive into that here :)
(21:06:46) mattock: yep
(21:07:18) mattock: anyways, the only alternative I can offer is turning off cloudflare on community.openvpn.net and then trying to figure out some way to prevent DoS which tends to happen soon after CF is off
(21:07:29) mattock: I'd like not to go that route, too much stuff to do anyways
(21:07:44) mattock: well, that's all
(21:07:55) mattock: I do have some unrelated news though
(21:08:22) mattock: due to various circumstances which included HCR/HLK-CI I decided to start the buildmaster upgrade process
(21:08:32) cron2: like, "python 3"?
(21:08:43) mattock: among other things
(21:08:57) mattock: but if that is an issue we can have the old buildmaster running for a long while still
(21:09:10) cron2: nah, it is great news
(21:09:11) mattock: the main goal now is:
(21:09:11) mattock: - tap-windows6 builds
(21:09:11) mattock: - automated openvpn MSIs
(21:09:34) mattock: tap-windows6 first and foremost, as HLK-CI guys need build artefacts to test
(21:09:39) cron2: my FreeBSDs are sending me lengthy mails every day that 43 py27-xxx modules are now considered deprecated
(21:09:55) cron2: so while the conversion will be some work, I think it is a useful thing to do
(21:09:59) mattock: yep
(21:10:12) mattock: it should not be too bad
(21:10:45) mattock: I did a PoC master setup already - the setup has not changed _that_ much, but the webui is definitely nicer
(21:10:51) mattock: out of the box
(21:10:58) cron2: my python installations are messy (some is "system packages", some is "pip installed"), so it's "throw away everything and re-do from scratch"
(21:11:16) mattock: I think on the slave side less changes are needed
(21:11:41) mattock: slaves are called "workers" now btw
(21:11:46) mattock: we need to change our terminology :D
(21:11:47) cron2: yeah :-)
(21:12:05) cron2: but it will still need a python install cleanup, and then isntall all the new prerequisites for 3
(21:12:11) mattock: yep
(21:12:49) cron2: yeah, but still.  the path forward
(21:14:18) cron2: shall we assume all the rest got lost?
(21:14:34) plaisthos: we can still be faster with py3 than coverity which promises support for next year
(21:15:07) cron2: let's see which one can be dragged out longer... py3 workers or ipv6 on community
(21:16:22) mattock: anyhow
(21:16:31) mattock: shall we talk about 2.5.0?
(21:16:45) cron2: I have put a few things on the agenda
(21:17:01) dazo ha scelto come argomento: Agenda at https://community.openvpn.net/openvpn/wiki/Topics-2020-10-22
(21:18:31) dazo: so ... 2.5 .... any feedback on 2.5_rc3?
(21:18:42) mattock: no, though I've avoided emails recently it seems
(21:18:47) mattock: I'm going through the backlog
(21:18:55) cron2: the redirect-gateway bug has been confirmed-fixed
(21:19:02) cron2: no other reports so far
(21:19:48) becm: the driver update no longer breaks references.
(21:19:54) dazo: so, basically rc3 is the 2.5.0 :)
(21:20:11) dazo: (ignoring Windows builds, that is)
(21:21:48) cron2: yep
(21:22:05) cron2: plaisthos is working on untwisting the deferred authentication methods, but that looks 2.5.1-ish
(21:22:17) dazo: alright
(21:22:21) cron2: that stuff is buggy, but the untanglement needs thorough testing
(21:25:49) mattock: ok so "2.5.0" when?
(21:26:41) cron2: we should invest some time in the release announcement text (pointing out surprises with BF-CBC using setups and 2.3 servers), and maybe have a thorough look at Changes.rst as well
(21:27:14) cron2: my next week is semi-busy (too many video chats, but always time in between), so I can make "whatever works for you"
(21:27:43) mattock: I'd opt for mid next week, maybe Wednesday
(21:27:48) mattock: I could do the release before the community meeting
(21:28:32) dazo: lets have everything tagged and built ... and hold the announcement until the meeting for the last text review?
(21:28:45) mattock: yeah makes sense
(21:29:11) dazo: well, Changes.rst might need some adjustments
(21:29:13) cron2: but that means I need change requests for Changes.rst by tuesday :)
(21:29:26) dazo: yeah, that's what I just realised :-P
(21:29:47) cron2: I'd suggest to not follow standard patch process here, but just send text amendments and I'll do a version.m4 / Changes.rst commit with these changes
(21:30:29) dazo: agreed
(21:33:58) mattock: or we craft the Changes.rst in the meeting and release after that?
(21:34:10) mattock: I don't have strong opinions
(21:34:42) dazo: do we have some public etherpad place we could just place it and review it?
(21:35:20) cron2: I have no etherpad (but would be fine using google docs)
(21:35:20) mattock: nothing from OpenVPN Inc. side
(21:36:26) mattock: doesn't fedora or some other project have public etherpads?
(21:37:50) mattock: well here's one option: https://wiki.mozilla.org/Etherpad
(21:37:53) mattock: login with google or something
(21:38:01) mattock: or github
(21:38:14) mattock: or firefox (account)
(21:39:42) cron2: yeah
(21:40:40) mattock: anyways, anything else?
(21:41:16) dazo: I'm good
(21:41:29) cron2: I have an appointment wednesday 10am-10:45, so "before the meeting" isn't going to work out - monday or tuesday works for me
(21:41:48) mattock: ok, whatever works for you developers
(21:41:55) mattock: I can do the release wed before the meeting
(21:42:04) mattock: or at least get it well under way
(21:42:17) cron2: then let's aim for "text ready on tuesday, tagging tuesday evening, hand over to mattock"
(21:42:23) mattock: +1
(21:42:26) dazo: sounds good!
(21:42:31) mattock: I will give a heads up to our marketing/website folks
(21:42:43) cron2: +1
(21:43:30) dazo: mattock: give me a heads-up when the push to s3 is done .... so I can get the Fedora builds for F33 running.  I'm also going to setup a new openvpn25 Copr repo for 2.5 releases for F32 and EPEL-7 and EPEL-8
(21:44:07) mattock: dazo: ok, my assumption is that it will happen around lunch time on Wed
(21:44:17) mattock: it takes a bit of time to build and test all the stuff
(21:44:28) mattock: we can coordinate in the meeting probably
(21:44:39) dazo: All I need is the tarball in the usual places :)
(21:44:44) dazo: yeah, lets do that
(21:44:47) cron2: sounds good
(21:44:48) mattock: S3 push is the third last step in the process
(21:44:54) mattock: S3 -> Website update -> Announcements
(21:45:04) mattock: pushing bad things to S3 is really bad idea
(21:45:09) mattock: :)
(21:45:18) mattock: ok, we have a plan
(21:45:23) mattock: anything else? 15 minutes left
(21:46:38) cron2: *yawn*
(21:46:42) cron2: my tv is calling :-)
(21:46:49) cron2: and I do not want to review patches now
(21:47:07) mattock: I want to eat and hit the sack :)
(21:47:13) cron2: enjoy
(21:47:30) mattock: ok, until next time then!
(21:47:32) mattock: good night guys!
(21:47:36) dazo: I'm wrapping up the openvpn3-linux v11 beta release ... I have ovpn-dco packages for Ubuntu 20.04 and Fedora 31, 32 and 33 ready .... was just delayed due to internal Jenkins issues with the .deb builds for openvpn3-linux pre-release testing
(21:47:54) dazo: that's all I had on top of everything :)
(21:48:04) mattock: dazo: btw. we discussed that issue in the ops meeting and I'm sure there will be some resolution to it
(21:48:17) dazo: good!
(21:48:46) dazo: plaisthos has been debugging things as well, so I hope we will find a proper solution
(21:50:02) cron2: dazo: any finds regarding the openvpn protocol specs?
(21:50:02) mattock: yep
(21:53:07) dazo: cron2: sorry, I've just been soaked into the v11 release challenges, I've barely been able to think about anything else. It is on my todo list ... but it's not too much there, and mostly focusing on the control channel
(21:53:43) dazo: I'm unavailable tomorrow and wanted the v11 release out today .... but that went down into the drain, so to speak

--------------65BC7593DA36C39B407D5E23--

