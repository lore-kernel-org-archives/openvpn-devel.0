From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <18bf72b4-0c3c-0f61-46b0-c5673a98552e@...515...>
Date: Wed, 7 Apr 2021 15:45:31 +0300
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------34FD546A689A55E791AA1D6C"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (7th April 2021)
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
--------------34FD546A689A55E791AA1D6C
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 7th April 2021
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2021-04-07>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, d12fk, lev, mattock, novaflash, ordex and plaisthos 
participated in this meeting.

--

Decided to postpone OpenVPN 2.5.2 and 2.4.11 releases to April 20th / 
21st due to Access Server-related challenges.

--

Decided not to release OpenVPN Windows installers before 2.5.2 and 
2.4.11 as the latest OpenSSL issues affect only Windows acting as an 
OpenVPN server and because there are ways to mitigate the issue while 
waiting for the new releases.

--

Noted that mattock will be able to start working on upgrading buildbots 
after 19th April once he's off the hook from ops work.

Also noted that MacOS buildslave is shown "offline". Mattock restarted 
the buildmaster as the slave had been restarted several times already.

--

Decided to reschedule the meetings to 14:00 CET/CEST. Everyone agreed 
that works better as it does not conflict with lunch time. It won't 
affect Americans as they're all asleep and generally not present in the 
meetings anyways.

--

Talked about removing OCC warnings completely. It was agreed that the 
feature is partially broken in modern client<->server setups. In p2p 
static key context it works better, but we're getting rid of that, so 
that point is moot. Did not decide anything on this topic, but noted 
that cleanups are needed before we can move forward with this.

--

Talked about LibreSSL support. We can perhaps drop support for older 
OpenBSDs if needed, but in general we want to avoid breaking LibreSSL 
support in OpenVPN	.

---

Full chatlog attached

--------------34FD546A689A55E791AA1D6C
Content-Type: text/plain; charset="utf-8"; name="openvpn_irc_meeting_chatlog_2021-04-07.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2021-04-07.txt"

(12:26:22) cron2: I am here!
(12:26:30) cron2: EARLIER THAN NEEDED! HAH!
(12:27:49) mattock: hi
(12:30:17) cron2: we have no topic and no agenda...
(12:30:47) mattock: of course, turn of the month catches mattock by surprise every month :)
(12:30:54) mattock: let's make something up then
(12:31:19) cron2: damn cloudflare messing up my links again
(12:31:54) lev__: hello
(12:32:39) cron2: ah, call interferes
(12:32:41) cron2: 5 min
(12:32:44) mattock: https://community.openvpn.net/openvpn/wiki/Topics-2021-04-07
(12:33:46) d12fk: hi and back in 3 -> coffee
(12:34:40) mattock: I have 26 minutes then I'll have to start multitasking due to a meeting
(12:37:35) cron2: let's go :)
(12:37:41) mattock: +1
(12:37:43) mattock: 2.5.2?
(12:38:32) dazo: so .... yet another delay due to the Easter eggs ...
(12:38:48) cron2: I have updated the agenda page
(12:39:08) novaflash [b9e34bf1@...2592...] è entrato nella stanza.
(12:39:23) cron2: AS has arm-twisted us into not releasing today, and I am very busy next week... so we compromised on a joint release in 2 weeks (April 20, April 21)
(12:39:36) cron2: we'll do a 2.5.2 and 2.4.11 release
(12:39:53) mattock: +1
(12:40:09) novaflash: so sorry about that :-)  but it's not good to do a release on a friday and that's what it would have amounted to. so thanks for agreeing to delay it.
(12:40:36) cron2: in corona times, all the days blur...
(12:40:57) d12fk: not if you have a wine cellar =)
(12:41:08) novaflash: with a wine cellar, EVERYTHING blurs
(12:41:11) cron2: the 2.5.2 release is actually all finished and in mattock's repo :-) - but will be overwritten when I push the next change to 2.5
(12:41:18) cron2: novaflash: I was about to say that
(12:41:37) novaflash: but yeah i would like to try to keep the weekend, well, the weekend
(12:41:47) cron2: but I have the 3+1 patches all ready, so for me it's not very much work to do
(12:41:48) plaisthos: With wine cellar I am surprised you are still alive during Covid
(12:41:53) novaflash: haha
(12:41:55) cron2: (unless plaisthos discovers new easter eggs)
(12:42:01) dazo: yeah, keeping releases to mon-wed is reasonable
(12:42:13) novaflash: oh is that what we're calling this vulnerability? the easter egg?
(12:42:34) dazo: it seems plaisthos and ordex was bored this easter :-P
(12:42:48) cron2: I think the last patch needed to fix all avenues is now called "the easter egg" because it came to novaflash as a surprise :)
(12:43:02) dazo: :-D
(12:43:20) dazo: So, anything else blocking the 2.5.2/2.4.11 releases?
(12:43:34) cron2: so - there remains the question whether "we" (*cough* mattock) wants to do a 2.5.1-I602 with updated OpenSSL interim...
(12:44:34) cron2: dazo: no blockers from my side.  My test infra needs a bit work to do a full server side test for 2.4 (because all the instances test "something of the new 2.5 stuff" nowadays, so 2.4 doesn't even start with these configs...)
(12:44:50) dazo: plaisthos: how critical would you classify the latest OpenSSL CVEs in OpenVPN context?
(12:45:07) plaisthos: client is unaffected
(12:45:19) cron2: can the server not trigger a SSL renegotiation?
(12:45:25) plaisthos: The server side crash well is a crash
(12:46:03) plaisthos: the server can trigger one but the crash only happens in the server side acoording to the CVE
(12:46:21) cron2: ah, so a pure windows client should be ok, then
(12:46:27) d12fk: is server on windows a thing anyways?
(12:46:45) dazo: Okay, then I don't think there is a too high risk postponing the OpenSSL update in the Windows builds.  The amount of Windows based OpenVPN servers are not expected to be that widespread
(12:47:14) plaisthos: and the 3 people affected can switch out their opnessl dll
(12:48:18) cron2: d12fk: people do the weirdest thing with windows, like "use as file server" or "use as openvpn server"...
(12:48:34) mattock: there's even a trac article about it
(12:48:46) dazo: even weirder things, like using Windows as a server ...
(12:48:53) dazo: :-P
(12:48:59) mattock: I would love to avoid unnecessary installer releases, though they're not horrible to make
(12:49:08) d12fk: as long as it runs stream...
(12:49:20) dazo: :-D
(12:49:40) cron2: since we do a full release anyway, and the risk is limited, this (not doing intermediates) sounds okayish to me as well
(12:49:53) mattock: +1
(12:49:55) plaisthos: looks there is also a NoRenegotiation you can set in the opnessl.conf
(12:50:28) cron2: which brings back the interesting question *where* this might be found on windows... Selva had a ticket about that recently (regarding algorithms and padding)...
(12:50:56) cron2: anyway
(12:50:59) mattock: does that discussion cover the upcoming releases?
(12:51:05) mattock: I have ten minutes to spare
(12:51:06) mattock: :)
(12:51:13) cron2: it does, for me
(12:51:23) mattock: #4 remove OCC warnings altogether?
(12:51:26) cron2: shall we tackle "buildslaves" a bit?
(12:52:22) mattock: yes, no progress, will work on it starting 19th
(12:52:29) mattock: when I'm off the hook from ops work
(12:54:17) mattock: I don't want to distract myself any more than I have to, the other ops guys are pretty good at it and I have one final project I need to wrap up in seven working days
(12:54:26) cron2: okay... I noticed that we need to do work there... the macos buildslave isn't talking to the master (even though it's up and the VPN is active)
(12:54:36) cron2: the centos7 buildslave seems to be "dead for good"
(12:55:01) cron2: and we might want to actually have 2 centos slaves, one for "the oldest supported release" and one for "the most recent entry in the museum"
(12:55:04) mattock: with docker setting up tons of (linux) buildslaves will be way easier than with VMs
(12:55:37) cron2: so you'd run a "centos 7" docker on "ubuntu 20", then?
(12:55:37) mattock: is the "museum" entry EOL?
(12:55:41) plaisthos: docker will probably not work for the tests
(12:55:51) plaisthos: mattock: 2025 or something like that for centos7
(12:55:52) mattock: it will when you misuse docker
(12:56:04) mattock: we already do it for other testing purposes
(12:56:08) cron2: mattock: nothing in RHEL/CentOS land is ever end of life.  They put it into the museum and lovingly look at it :-)
(12:56:30) novaflash: cron2: and their customers use it in production forever
(12:56:34) plaisthos: centos8 is eol next year for all the controversy around that
(12:57:09) plaisthos: oh end of life end of this year
(12:57:10) dazo: There should be some RHEL 8 Atomic images which would be useful in Docker context
(12:57:17) cron2: okay, so 19th, all will be good and shiny... any chance you could have a look at the macos buildbot beforehand?
(12:57:32) cron2: "you" = "mattock", on the server end
(12:59:01) mattock: well the usual way would be to restart the slave
(12:59:07) lev__: with mingw openssl build, the config is likely searched in c:\etc\ssl
(12:59:09) mattock: and if that does not do the trick, restart the master
(12:59:45) mattock: I propose owner of the macos buildslave restarts the buildslave process
(12:59:48) cron2: we restarted the slave a couple of times...
(12:59:52) mattock: ok
(12:59:58) mattock: then I shall restart the master
(13:00:03) mattock: that tends to help
(13:00:03) cron2: it's plaisthos-owned, but I can tackle it...
(13:00:16) mattock: ok, need to split, but will restart the buildmaster now
(13:00:30) cron2: youc an multitask :-)
(13:01:02) mattock: restarted
(13:01:11) mattock: I'll check back here every now and then
(13:02:09) cron2: 2021-04-07 12:00:35+0200 [Broker,client] message from master: attached
(13:02:24) cron2: so, this is what it always does... so let's see if it takes work now
(13:02:39) cron2: the server shows it as "offline"
(13:03:52) cron2: (can I use this quiet moment to state my annoyance at scheduled meetings during the community meeting time...?)
(13:04:24) dazo: I was just wondering what's next the next topic ....
(13:06:20) dazo: Maybe there is a slightly better meeting time, though, than too close to typical lunch hours in Europe ....
(13:06:31) dazo: anyhow .... shall we poke at OCC?
(13:07:13) cron2: we can shift around the meeting again... with Corona and homeoffice, and new people on the corp payroll, the old "why is it there?" reasoning might no longer be good
(13:07:28) cron2: for me, later in the day would be easier
(13:07:34) dazo: yeah, for me too
(13:07:46) cron2: customers always want "10-12"...
(13:08:23) cron2: so reschedule to 1400 MEDT?
(13:08:48) cron2: we could start with todays meeting and get more mattock time :-)  *duck*
(13:08:49) plaisthos: what is medt?
(13:08:59) plaisthos: I know MESZ and CEST
(13:09:04) cron2: "middle european daylight savings time" = Europe/Berlin
(13:09:18) novaflash: My Evil Damnation Time
(13:09:26) plaisthos: Ah also kown central european summer time :)
(13:09:28) novaflash: oh. berlin. okay.
(13:09:32) cron2: "cron2 and plaisthos wall time" :-)
(13:10:09) plaisthos: novaflash: at least you get dammned in local time
(13:10:15) plaisthos: I am fine with that
(13:10:19) novaflash: awesome
(13:10:24) d12fk: Berlin is just an alias for Amsterdam
(13:10:45) d12fk: yeah 1400 works better with weird sleep schedules as well
(13:10:57) dazo: :D
(13:11:21) plaisthos: it also just moves it from one middle of the night time to another middle of the night time for non-preent americans :D
(13:11:49) cron2: none of them have joined in a long time...
(13:11:59) d12fk: and australians are out of rush hour
(13:12:15) dazo: yeah, that's why we decided to skip the thursday evening and do wednesday only
(13:12:17) cron2: so, calendar updated :-) - mattock hasn't sent the invitations for April anyway yet...
(13:12:43) dazo: 1400 CEST/CET (depending on TZ season)
(13:12:47) cron2: yep
(13:13:27) cron2: so, short update on 2.6 and/or OCC?  (The latter is somewhat a copy-paste-item from last meeting's agenda)
(13:13:32) novaflash: one of my colleagues here just asked me if there was any update or progress on the bsd kernel DCO module - but all i could tell him is we connected the interested parties with each other and that's that, i don't know anything else :-)
(13:13:33) cron2: or "bridged windows"?
(13:13:48) cron2: novaflash: I have no update either.
(13:15:18) cron2: poking bz
(13:15:27) dazo: so to quickly grasp the OCC challenge .... why was it "invented"?  And is this "invention" needed a decade later?
(13:16:19) cron2: it was a useful debug tool to help debug "my VPN does not work!" issues due to option mismatch
(13:16:31) cron2: like, different hash or cipher settings
(13:16:46) cron2: or (p2p) ip address conflicts
(13:17:04) dazo: right .... and with today's pushable options, negotiations, etc, does it still make sense to preserve it?
(13:17:34) cron2: I think the idea is still sane, but it conflicts with push/nego, because it verifies option settings *before* negotiation and push happens, so half the warnings are wrong in a modern --client to --server setup
(13:17:48) dazo: It would be more useful in a plain p2p static key setup, without control channel to push options .... but we're killing that static key setup, so we will have the control channel
(13:17:54) cron2: we've removed a number of options from OCC checking in the last years
(13:18:13) cron2: --tls-client / --tls-server do have a control channel, but no "negotiation"
(13:18:22) cron2: on data channel options (cipher etc)
(13:18:48) dazo: ahh, I was not aware of that ... that makes it reasonable again; or to add "negotiation" in that use case as well
(13:19:19) cron2: and we still do not push everything / not everything is pushable yet, I think.  All the weird mtu/frame stuff isn't.
(13:19:19) plaisthos: not yet at least :P
(13:19:37) cron2: yes
(13:19:40) dazo: My general attitude is that the client config should be as small as possible ... ideally just carry --remote, --ca, --cert and --key ... and optionally some verification options (like --verify-x509 and such)
(13:20:44) dazo: There will also be some proxy options needed too ... but that's the standard "how to reach the server" options; but not "the server needs these options"
(13:20:54) cron2: yes
(13:21:25) dazo: So if we can set such a goal .... we figure out how OCC and other pushable options can fit into that
(13:22:09) dazo: and then plan for what we do in each release going forward
(13:22:58) cron2: you can have such a config today (+ auth-user-pass), the problem is more "people put other stuff in the config and then wonder about the result" :)
(13:24:36) dazo: we could just add a new M_IGNORED which just adds a standard "Client Option has been ignored in configuration; server will push this if needed" messages in the log
(13:25:12) plaisthos: dazo: and break compatibility with that
(13:25:25) dazo: and server could be more clever as well .... that if some options needed to be identical on both sides, automatically adds the --push ..... similar to what --keepalive does today
(13:25:59) dazo: plaisthos: ahh, yeah, when connecting to old servers ..... *sigh* yeah
(13:28:24) plaisthos: and I don't think there are many options that need the "add push" treatment
(13:28:51) dazo: I don't think so too ... so maybe that's the first step?
(13:28:53) plaisthos: comprezs related options are the only that I can currently think of but I think compress migrate is a better there
(13:29:38) cron2: the whole mtu/frame craze needs a clean up
(13:29:41) cron2: with a large flame thrower
(13:31:02) dazo: agreed
(13:31:26) novaflash ha abbandonato la stanza (quit: Quit: Connection closed).
(13:33:01) cron2: so... one note on 2.6 / master patches
(13:33:13) cron2: there are two patches related to OpenSSL/configure simplification on the list
(13:34:02) cron2: they do not seem to break something, but it might be good to have another view from the "are there no-go in there from the 'understand OpenSSL and configure' department?"
(13:34:23) plaisthos: did ordex already look at them?
(13:35:10) cron2: yeah, but more from the "it does not break anything" pov
(13:35:29) cron2: and he did not ACK 5/5...
(13:35:36) cron2: and I wonder about these defines in 4/5
(13:35:43) cron2: 1..3/5 have been merged and pushed already :)
(13:36:17) plaisthos: cron2: the openssl 1.1 header defines the GCM ones as the AEAD ones
(13:36:46) novaflash [b9e34bf1@...2592...] è entrato nella stanza.
(13:37:14) cron2: this is one of the bits I was missing :)
(13:38:23) plaisthos: so it is really only new names, the costants are the same
(13:38:57) cron2: ok on 4
(13:39:23) plaisthos: https://github.com/openssl/openssl/blob/master/include/openssl/evp.h#L379
(13:39:37) cron2: for 5, I wonder... originally there was a reason to do it this way... and it might have been LibreSSL (having some of the modern 1.1 OpenSSL API, but not all, and having no reasonable VERSION define)
(13:40:55) plaisthos: or just the way we did always checking for zillions of functions %)
(13:41:21) plaisthos: what opensbsd/libressl version do you have?
(13:41:45) cron2: 6.5 / 2.9.1
(13:42:13) cron2: but that's less of an issue... it's more about "which strategy will be best to handle these"
(13:49:32) plaisthos: like if this the right approach?
(13:51:49) cron2: yeah... but I'm looking at this somewhat from the outside... I see the bug reports and do the commit merges, but are not really "in" the SSL libraries, and differences, and versions, and compatibility
(13:52:39) plaisthos: So for OpenSSL the change is very solid as OpenSSL does not play games with its own version numbers
(13:52:52) cron2: for OpenSSL it indeed seems easy now - either it's 1.0.2, then "old API", or 1.1.x, then "new API"
(13:53:06) plaisthos: also for wolfSSL as it basically is also 1.1.1
(13:53:09) cron2: anything interesting there in OpenSSL 3.x?
(13:53:18) plaisthos: the only joker is LibreSSL
(13:53:23) cron2: oh, WolfSSL is 1.1.1 - I didn't know, but this is good
(13:54:56) cron2: well
(13:55:09) cron2: I'll leave it for a few days on the list, so people that have a strong opinion can voice it
(13:55:16) cron2: and then I'll just take it as it is, I think
(13:55:18) plaisthos: and for libressl it is just those few lines compatibility
(13:55:34) dazo: hmmm .... Is OpenVPN on OpenBSD so widely used that it makes sense for us to keep being annoyed by LibreSSL?
(13:55:41) plaisthos: but testing with an older versionn might show if there are more needed for older versions
(13:56:01) cron2: for LibreSSL the question is along the line of "if they grow some parts of the 1.1 API that would be beneficial for us to use, will we mess it"
(13:56:02) plaisthos: I only tested with 6.8
(13:56:16) cron2: but then, they can just send a patch
(13:56:19) plaisthos: they support most of the 1.1.1 apis
(13:56:29) plaisthos: if you look closely at the patch
(13:56:38) cron2: dazo: it's the system ssl library, so yes, we try not to break it
(13:57:04) cron2: some people feel about OpenBSD the way you feel about RHEL - like "current technology, worth supporting" :-)
(13:57:27) plaisthos: but then again it is master and by the time it becomes 2.6, the older OpenBSD versions are probably not worth supporting anymore
(13:57:41) dazo: Well, LibreSSL ..... I don't mind OpenBSD, but LibreSSL ....
(13:58:56) cron2: plaisthos: yeah.  I'll go test with OpenBSD 6.5, and if it breaks, I'll upgrade the buildslave to 6.8...
(13:59:24) cron2: ok... I need to break now... hungry
(14:10:31) novaflash ha abbandonato la stanza (quit: Quit: Connection closed).
(14:53:11) ordex: omg

--------------34FD546A689A55E791AA1D6C--

