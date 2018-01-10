From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <e7876840-1c66-3094-ac39-0a5a7a13cf8c@...515...>
Message-ID: <fa757045-2c03-181b-9d77-a0f909ef323c@...515...>
Date: Wed, 10 Jan 2018 13:47:27 +0200
MIME-Version: 1.0
In-Reply-To: <e7876840-1c66-3094-ac39-0a5a7a13cf8c@...515...>
Content-Type: multipart/mixed; boundary="------------1F89EB54485928E1873BA5AF"
Content-Language: en-US
Subject: [Openvpn-devel] Sumamry of the community meeting (Wed,
 10th Jan 2018)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------1F89EB54485928E1873BA5AF
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 10th Jan 2017
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2018-01-10>

The next meeting should be at the same time next week, unless it is
cancelled.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

chipitsine, cron2, mattock, ordex and syzzer participated in this meeting.

--

Ordex is making an iOS bugfix release which will hopefully be out by
upcoming Monday. Cron2 will test the fixed version. Getting fixes to the
Appstore is much faster now that we use Apple's new API instead of the
old VPN plugin.

--

Discussed OpenVPN 2.4.5 release. It was agreed that we can and should
make the release soon. It will include latest changes to release/2.4
branch in OpenVPN. In addition Windows installers will include

- Upgrade to OpenSSL 1.1 (1.0.2n as a fallback if 1.1 gives trouble)
- Latest easy-rsa 2 version
- Latest openvpn-gui version
  - review and merge open PRs before release
- "PKCS#11 URIs compliant with RFC7512" patch
  - https://github.com/OpenVPN/openvpn-build/pull/110

Current 2.4.4 installers are using OpenSSL 1.0.2l, whereas latest
version is 1.0.2n. Syzzer reviewed the OpenSSL changes and they're not
really interesting in the OpenVPN context. This means we do not have to
rush the release out. Hence we aim to make the 2.4.5 release within a
couple of weeks.

---

Full chatlog attached.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------1F89EB54485928E1873BA5AF
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2018-01-10.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2018-01-10.txt"

(12:30:28) mattock: meeting time
(12:30:38) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
8-01-10
(12:30:40) vpnHelper: Title: Topics-2018-01-10 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:31:06) ***syzzer present
(12:31:10) mattock: hi!
(12:31:22) mattock: who else do we have?
(12:31:23) ordex: hi!
(12:31:29) mattock: hi ordex!
(12:31:35) ordex: hi there !
(12:33:48) syzzer: so, no specific subjects?
(12:35:21) chipitsine: hi
(12:35:28) mattock: hi!
(12:35:33) mattock: syzzer: I believe that is so
(12:35:40) mattock: just patch review
(12:36:06) ordex: I am almost done with the block-ipv6 patch. I will send=
 the review hopefully tomorros :S been a bit busy these days
(12:36:28) mattock: will cron2 be able to make it?
(12:37:28) mattock: according to backlog on #openvpn-devel it seems so
(12:37:54) mattock: anyhow, any patches on patchwork (https://patchwork.o=
penvpn.net/project/openvpn2/list/) that we could/should review today?
(12:37:56) vpnHelper: Title: OpenVPN 2 - Patchwork (at patchwork.openvpn.=
net)
(12:38:21) cron2: hi
(12:38:22) cron2: late
(12:38:24) cron2: sorry :)
(12:38:29) mattock: hi!
(12:38:44) mattock: it seems the oldest patches in patchwork are from syz=
zer and almost 1 year old
(12:38:48) ordex: :D
(12:38:50) mattock: https://patchwork.openvpn.net/project/openvpn2/list/?=
order=3Ddate
(12:38:52) vpnHelper: Title: OpenVPN 2 - Patchwork (at patchwork.openvpn.=
net)
(12:38:57) ordex: is that a record?
(12:38:58) cron2: yeah, we bounced these so they do not get lost
(12:41:42) cron2: syzzer: JFTR, I'll go on with your patches over the nex=
t days :-) - it's a pleasant change from "end of year paperwork"
(12:41:58) ordex: :D
(12:42:13) ordex: thanks
(12:43:25) cron2: ordex: do you have a time line for the iOS bugfix relea=
se?
(12:43:39) cron2: (so I can make a note in my calendar for re-testing DNS=
)
(12:44:04) ordex: cron2: hopefully by the end of this week. But we have t=
o see how long will apple take to review it too ..
(12:44:13) ordex: buy hopefully by Monday it will be out
(12:44:20) cron2: oh, so quick
(12:44:26) ordex: and ready to break..ehm fix people setups
(12:44:28) cron2: "back then" it took Apple like 4 weeks
(12:44:37) ordex: yeah, now it's much faster
(12:44:47) ordex: because of the migration tot he new API the process is =
much smoother
(12:45:04) ordex: no need for "special treatment" due to the VPN plugin
(12:45:08) cron2: cool
(12:45:20) ordex: (the special treatment was the very slow part as far as=
 I understood)
(12:47:01) cron2: but this is good news, so we can get back to a reasonab=
le feature velocity on iOS :-)
(12:48:01) ordex: yeah
(12:48:06) mattock: oh, one topic: OpenVPN Windows installers are using o=
penssl 1.0.2l, whereas 1.0.2n is the latest version
(12:48:31) mattock: 1.0.2n was released Dec 7th
(12:48:51) mattock: interestingly nobody has complained about this until =
today
(12:48:55) ordex: security upgrade ?
(12:48:58) ordex: ehe
(12:49:24) mattock: I can probably push out new Windows installers tomorr=
ow evening or on Friday
(12:49:56) mattock: but we (read: syzzer) should have a quick look at the=
 fixes in 1.0.2m and 1.0.2n to see what the impact is for OpenVPN (if any=
)
(12:50:27) cron2: what about windows installers with 1.1?  with selva's p=
atch this should be "easy" now...
(12:50:34) cron2: (as soon as this one is reviewed and merged :) )
(12:50:55) cron2: shall we offer test installers with 1.1?  Like, "I701" =
is "with 1.1"?
(12:51:09) cron2: "we" of course being "mattock" *duck*
(12:51:13) chipitsine: I'm working on that
(12:51:32) ordex: :D
(12:51:39) mattock: https://www.openssl.org/news/cl102.txt
(12:51:50) syzzer: mattock: yeah, reading...
(12:51:51) mattock: cron2: I'm fine with building with 1.1
(12:52:00) syzzer: (I recall I looked at this before, and decided=20
(12:52:04) mattock: cron2: lol yes
(12:52:05) syzzer: "not interesting")
(12:52:08) chipitsine: can we add https://github.com/OpenVPN/openvpn-buil=
d/pull/110 to new installer as well ?
(12:52:10) vpnHelper: Title: Add "PKCS#11 URIs compliant with RFC7512" pa=
tch by chipitsine =C2=B7 Pull Request #110 =C2=B7 OpenVPN/openvpn-build =C2=
=B7 GitHub (at github.com)
(12:52:52) mattock: chipitsine: makes sense - that PR just dropped below =
my radar
(12:53:03) syzzer: chipitsine: please don't.  That creates inconsistencie=
s between our OS builds, and doesn't work with mbedtls
(12:53:48) syzzer: (or am I missing something here?)
(12:54:13) chipitsine: nothing to worry about yet. it still does not buil=
d
(12:54:39) mattock:  I'm not sure I follow
(12:54:55) mattock: syzzer: are you saying that PR#110 above should not b=
e merged?
(12:55:30) mattock: it was acked by dazo and cron2 in a meeting (mentione=
d in the comments)
(12:56:35) syzzer: mattock: the openssl updates are quite minor, but it w=
ould be good to do a planned release "soonish"
(12:56:49) mattock: syzzer: next week perhaps?
(12:57:09) chipitsine: also, there was great UX feature from selva (autom=
atic connect if password saved), can we include new openvpn-gui into new =
installer ?
(12:57:24) mattock: do we have enough stuff for 2.4.5?
(12:57:29) eyal [5251e1f4@...2315.../web/freenode/ip.82.81.225.244] =C3=A8 e=
ntrato nella stanza.
(12:57:38) chipitsine: there are a couple of not merged PR related to tha=
t feature
(12:58:07) mattock: chipitsine: I generally put the latest openvpn-gui in=
to each Windows 2.4.x installer, so if that feature is merged by release =
time we sure can
(12:58:57) chipitsine: currently it is a bit buggy, https://github.com/Op=
enVPN/openvpn-gui/pull/202 resolves a bug
(12:59:00) vpnHelper: Title: Do not auto submit username/password after a=
n auth failure by selvanair =C2=B7 Pull Request #202 =C2=B7 OpenVPN/openv=
pn-gui =C2=B7 GitHub (at github.com)
(12:59:09) syzzer: mattock: I'm a bit concerned about the maintenance bur=
den of that patch.  It will create an inconsistency between openssl and m=
bedtls builds.  windows vs other os is probably not really an issue, as t=
hose configs are sufficiently different anyway
(12:59:37) syzzer: (still talking about the pkcs11 patch)
(13:00:04) syzzer: it kinda sucks, because I *do* like to support the new=
 URI format
(13:00:48) mattock: syzzer: it seems that you were not in the meeting whe=
re PR#110 was acked, so here's what was discussed: https://www.mail-archi=
ve.com/openvpn-devel@lists.sourceforge.net/msg15655.html
(13:00:50) vpnHelper: Title: [Openvpn-devel] Summary of the community mee=
ting (Wed, 18th Oct 2017) (at www.mail-archive.com)
(13:01:08) mattock: "It was agreed that bundling the patch with future 2.=
4-based Windows installers makes sense, and that the potential for breaka=
ge is small. Dazo can cron2 approved the approach, and mattock will merge=
 the PR."
(13:01:33) mattock: "dazo _and_ cron2" is probably more appropriate :P
(13:02:07) mattock: it seems that the chatlog is not there though - I wil=
l check my personal archive
(13:02:16) syzzer: if both maintainers agree, I'm fine with it
(13:03:11) syzzer: release/2.4 looks like this next release could indeed =
be 2.4.5 :)
(13:03:37) syzzer: if you're doing a release anyway, let's get the good s=
tuff out to the users
(13:03:39) mattock: can't find the full chatlog - odd
(13:04:07) mattock: ok, so 2.4.5 with pkcs11-helper RFC patch
(13:04:15) mattock: I will merge it as promised some months ago
(13:04:18) syzzer: and openssl update?
(13:04:21) mattock: yes
(13:04:25) syzzer: perfect
(13:04:36) mattock: and the openvpn-gui changes proposed by chipitsine
(13:04:36) chipitsine: also, there was very weird thing https://github.co=
m/OpenVPN/easy-rsa-old/pull/6
(13:04:37) vpnHelper: Title: build-dh.bat: use proper variable by chipits=
ine =C2=B7 Pull Request #6 =C2=B7 OpenVPN/easy-rsa-old =C2=B7 GitHub (at =
github.com)
(13:04:48) chipitsine: it seems, nobody uses that feature=20
(13:05:05) mattock: yeah
(13:05:14) chipitsine: we should include it in the new installer as well
(13:05:14) mattock: I will investigate and merge
(13:05:26) mattock: I'll create a ticket with all this info for myself
(13:05:35) syzzer: hopefully cron2 and dazo can get even more good stuff =
in before the release :)
(13:05:41) chipitsine: mattock, I wanted to ask what are plans on easy-rs=
a ?
(13:05:46) mattock: release date?
(13:06:00) mattock: chipitsine: you mean easy-rsa-old (2.x) or easy-rsa i=
n general?
(13:06:02) chipitsine: are we going to replace it with easy-rsa3 some day=
 ?
(13:06:26) chipitsine: I think of either adding some tests on Trac#968
(13:06:45) mattock: we sure can, especially now that ecrist is maintainin=
g easy-rsa3 fairly actively
(13:06:47) chipitsine: if we will get rid of easy-rsa2, I wouldn't care a=
bout it
(13:06:54) mattock: agreed
(13:07:00) mattock: do you use easy-rsa3 on Windows?
(13:07:05) chipitsine: not yet
(13:07:18) mattock: we should make sure the user experience is relatively=
 smooth there
(13:07:29) chipitsine: I had a look. it seems people did not know about p=
owershell ))
(13:07:36) mattock: on *NIX I tend to use easy-rsa3 because it's a separa=
te download anyways
(13:07:45) mattock: they generally don't
(13:07:54) chipitsine: windows part of easy-rsa3 looks strange
(13:08:15) mattock: I've never tested it on Windows
(13:08:35) chipitsine: ok, I will not care of easy-rsa2 auto testing
(13:08:41) mattock: please don't
(13:09:20) syzzer: mattock: doesn't easy-rsa3 has a totally different com=
mand interface than 2?
(13:09:25) mattock: syzzer: it does
(13:09:35) syzzer: In that case I wouldn't upgrade in a dot-release
(13:09:56) mattock: I was thinking about the same, but then again quite f=
ew people actually use easy-rsa on Windows
(13:10:05) syzzer: or at least still ship the old one too?
(13:10:06) mattock: 99% of users are probably not affected
(13:10:22) mattock: we could postpone the transition to 2.5 alphas
(13:10:30) syzzer: sure, but the 1% can create a big heap of tickets for =
you to handle ;-)
(13:10:36) chipitsine: old + Trac#968 patch :)
(13:10:38) mattock: nobody has been screaming about easy-rsa3 on Windows =
installers
(13:10:39) syzzer: ask ordex ;-)
(13:10:51) mattock: I'm sure, hence I think 2.5 alpha makes more sense
(13:11:54) syzzer: yeah, makes sense.  or you ship both, that could work =
too.
(13:13:29) ordex: I am also in favour of shipping easyrsa3 starting with =
2.5
(13:13:34) ordex: (was that the question? :D)
(13:14:02) syzzer: ordex: question was: how many work can 1% of your user=
s cause? :p
(13:14:14) ordex: infinite
(13:14:24) ordex: I am witnessing that NOW
(13:14:25) ordex: :p
(13:14:26) mattock: chipitsine: merged https://github.com/OpenVPN/easy-rs=
a-old/pull/6
(13:14:29) vpnHelper: Title: build-dh.bat: use proper variable by chipits=
ine =C2=B7 Pull Request #6 =C2=B7 OpenVPN/easy-rsa-old =C2=B7 GitHub (at =
github.com)
(13:15:13) syzzer: mattock: wrt 2.4.5 release, we'll need an okay from da=
zo and/or cron2 too.
(13:16:43) mattock: syzzer: yeah, let's wait a bit
(13:17:11) syzzer: anything else?  otherwise I'll go and fetch lunch :)
(13:17:21) mattock: nothing at my end
(13:17:36) syzzer: good good, lunch it is!
(13:18:11) ordex: good :)
(13:19:35) mattock: bye!
(13:21:40) eyal ha abbandonato la stanza (quit: Quit: Page closed).
(13:24:51) mattock: chipitsine: I will send email about the other openvpn=
-gui PRs: https://github.com/OpenVPN/openvpn-gui/pulls
(13:24:53) vpnHelper: Title: Pull Requests =C2=B7 OpenVPN/openvpn-gui =C2=
=B7 GitHub (at github.com)
(13:25:02) mattock: I think we should try to tackle as many as we can bef=
ore the release
(13:25:50) chipitsine: thanks

--------------1F89EB54485928E1873BA5AF--

