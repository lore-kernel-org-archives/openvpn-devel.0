From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <e1a7b7cb-85e6-037d-4c2e-d9e5f6c95bcd@...515...>
Message-ID: <e0fe0e8a-6be1-3078-87c2-8e47daa11215@...515...>
Date: Wed, 20 Sep 2017 21:12:26 +0300
MIME-Version: 1.0
In-Reply-To: <e1a7b7cb-85e6-037d-4c2e-d9e5f6c95bcd@...515...>
Content-Type: multipart/mixed; boundary="------------6C077A9E069120BA1519113F"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of community meeting (Wed, 20th Sep 2017)
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
--------------6C077A9E069120BA1519113F
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable



Hi,

Here's the summary of today's IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 20th Sep 2017
Time: 19:00 CET (17:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2017-09-20>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock and ordex participated in this meeting.

--

Noted that the meeting invitation had a wrong time (one hour later than
intended).

Discussed the upcoming 2.4.4 release. Dazo and mattock agreed to work on
the press release concerning feature deprecation on Friday:

<https://community.openvpn.net/openvpn/wiki/DeprecatedOptions>

It was agreed that the pending patches will be reviewed on Thu-Sun and
the Git repo tagged on Monday next week. Mattock will make the release
on Tuesday.

We will also release OpenVPN 2.3.17 with a backported security fix. The
same security fix will also be backported to release/2.2 branch in Git.

--

Discussed the VLAN patchset. Ordex had expressed interest in reviewing
it on GitHub. It was agreed that this invasive patchset can only go to
"master" and from there to release/2.5.

--

Discussed release schedule for OpenVPN 2.5. Right now there is not
enough stuff in "master" to warrant a 2.5 release anytime soon. It was
agreed to discuss this topic in more detail in this year's hackathon.

--

Discussed setting up patchwork to ease patch management. This task has
been on mattock's plate for many months. He will try to set it up late
next week.

--

Discussed open GitHub PRs. This is a known issue for which there is an
internal OpenVPN Tech JIRA ticket.

--

Next meeting is schedule for next week at the same (note: correct time
is shown at the top).

---

Full chatlog has been attached to this email.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------6C077A9E069120BA1519113F
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2017-09-20.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2017-09-20.txt"

(20:00:56) mattock: meeting time
(20:01:05) cron2: is it?
(20:01:23) mattock: hmm
(20:01:27) cron2: you announced 20:00 CEST / 18:00 UTC
(20:01:42) mattock: I will have to check our discussion from last week
(20:02:01) ordex: I also thought it was now
(20:02:12) cron2: my calendar says "now!" but your announcement doesn't, =
so I am slightly confused
(20:03:09) ordex: yeah also the topic says 18:00UTC (for the last meeting=
)
(20:03:21) ***dazo is confused too ... got 2 calendar alarms ... now and =
in 1 hour
(20:03:29) ordex: I have two set for now
(20:03:57) mattock: ok, so we agreed 19:00 CET it seems
(20:04:08) mattock: wrong time in the announcement
(20:04:19) mattock: sorry about that
(20:04:49) ordex: [0243.45]9/<g?/ gcron2_g9/>g egood, so "weekly, wednesd=
ay, 19:00 CEST / 20:00 EEST" is it
(20:04:56) ordex: this is what cron2 confirmed :P
(20:05:00) ordex: taken from my log
(20:05:03) mattock: yeah
(20:05:13) ordex: but then the announcement was wrong
(20:05:14) cron2: my calender agrees with me
(20:05:14) ordex: ok
(20:05:19) ordex: that's good :D
(20:05:21) ordex: hehe
(20:05:23) cron2: indeed :)
(20:05:25) mattock: perhaps we could just start?
(20:05:38) mattock: do we have everyone we know will be joining?
(20:05:49) ordex: how about james ?
(20:06:12) mattock: do we have any topics for james?
(20:06:14) ordex: although syzzer is not here, so we can't discuss the tl=
s-cryp-v2 thing for real
(20:06:18) mattock: tls-crypt-v2 would have been one
(20:06:21) mattock: yeah, exactly
(20:06:25) cron2: any word from dazo?
(20:06:29) ***dazo is here
(20:06:50) cron2: cool.  So, let's start :-) - 2.4 release date
(20:06:54) dazo: mattock: regarding v2.4 release ... we need to get the P=
R text ready
(20:06:56) mattock: +1
(20:07:02) mattock: dazo: +1
(20:07:04) ordex: yap
(20:07:14) mattock: did we get a link to the press release?
(20:07:35) dazo: not really, there's a google doc from nineveh, which is =
basically nothing
(20:07:40) dazo: (at least last time I checked)
(20:07:40) mattock: mkay
(20:08:27) mattock: the PR was going to be mostly about deprecation featu=
res, right?
(20:08:42) dazo: correct
(20:08:54) dazo: but we need to word it like a security enhancement :)
(20:09:08) mattock: ok, then it does not have to be released at 2.4.4 rel=
ease time necessarily=20
(20:09:14) mattock: +1
(20:10:57) mattock: I probably won't have much time to work on the PR tom=
orrow, but Friday would work
(20:11:23) mattock: how about you dazo?
(20:11:25) dazo: yeah, it's nice to tie it to the 2.4.4 release though ..=
=2E. don't recall now if there are any new ones now, but we're removing/w=
arning about features going away in the 2.4 logs already ...
(20:11:34) dazo: Okay, I can do Friday
(20:11:37) mattock: great!
(20:11:47) mattock: what else about 2.4.4?
(20:12:07) dazo: there's a few patches to be reviewed though
(20:12:13) ordex: yap
(20:12:16) cron2: yep
(20:12:38) cron2: (my week was even more crazy than normal *sigh* but hop=
efully things will improve now...)
(20:12:43) dazo: the lz4 api stuff ... and some systemd unit file changes=
 .... and .... /me pulls up his mail filter
(20:13:07) ordex: we have a couple of fixes
(20:13:16) lev__ [~lev@...1423.../corp/lev] =C3=A8 entrato nella stanza.
(20:13:17) dazo: yeah, ordex have been busy as well :)
(20:13:18) ordex: one is the af_family fix for tcp-server
(20:13:22) cron2: ordex' af_unspec patch wants to be merged (which I can =
do), and the mtu-disc stuff wants an extra patch to get rid of that M_FAT=
AL
(20:13:25) cron2: yes
(20:13:33) cron2: it already has an ACK
(20:14:00) ordex: cron2: the M_FATAL thing needs to go in 2.4.4? or can t=
hat be postponed? I don't think it's "fixing" something crucial? it's mor=
e a cleanup,no ?
(20:15:05) ordex ha scelto come argomento: Meeting 2017-09-20 19:00 CEST:=
 Agenda at https://community.openvpn.net/openvpn/wiki/Topics-2017-09-20
(20:15:58) cron2: ordex: who knows when we'll do the next release :-) - a=
nd since it's annoying people again and again, time to get rid of it
(20:16:05) ordex: alright
(20:16:16) cron2: we shouldn't have M_FATAL in normal code paths...
(20:16:32) ordex: agreed and it was even confusing because it wasn't clea=
r why we'd hit it
(20:16:41) cron2: so, we get to work Thu-Sun, and then dazo tags on Monda=
y?
(20:16:57) ordex: cr0p, here i's Thu already
(20:17:00) ordex: *it's
(20:17:01) ordex: :D
(20:17:01) cron2: (I have time on Monday as well, my all-day customer app=
ointment was postponed to October, hooray)
(20:18:07) dazo: okay, makes sense to me
(20:18:38) mattock: do we have somebody working on the security announcem=
ent(s)?
(20:19:22) dazo: I think those will not be so critical this time ... but =
perhaps syzzer wants to review comments related to his patch?
(20:19:54) dazo: (we should do it, just it is far easier to tackle)
(20:20:28) ordex: which syzzer's patch are you talking about exactly?
(20:20:43) dazo: ordex: its on security@
(20:20:51) ordex: ah right
(20:21:13) cron2: dazo: how are we going to tackle the security patch?  y=
ou merge privately on monday, and send mail with patch + ACK together wit=
h push + 2.4.4 announcement?
(20:21:36) cron2: or do we just declare it harmless enough, and follow no=
rmal patch-on-list-ACK-on-list-push procedures?
(20:21:37) dazo: due to the low security impact ... I say we push it once=
 its acked
(20:21:55) cron2: it's not ACKed yet?
(20:22:04) dazo: get an ack on sec-list ... and I'll bounce patch + ack
(20:22:08) dazo: nope, not afair
(20:23:01) ordex: what's the subject of the patch?
(20:23:04) ordex: I can't find it
(20:23:12) ordex: maybe i was not yet subscribed at that time
(20:23:30) dazo: ordex: PMed
(20:23:36) ordex: thanks
(20:25:45) mattock: actually Monday would be slightly tricky day for me t=
o do a release (or rather two) - maybe we could postpone tagging to Tuesd=
ay morning?
(20:25:57) mattock: unless it is fine to have the tag in there waiting fo=
r a while
(20:26:04) cron2: reviewed (again), ACKed (thought I had done that before=
)
(20:26:17) dazo: mattock: we will tag it ... and do the release when we'r=
e ready to roll the release machinery
(20:26:23) mattock: ok, sounds good
(20:26:36) mattock: I can then do part of the release on Monday and finis=
h on Tuesday
(20:27:06) cron2: mattock: "two"?
(20:27:11) dazo: Monday is probably fairly alright fror me ... but Tue I =
will be a bit absent minded (packing lots of stuff) ... and travelling on=
 Wed
(20:27:16) mattock: we're doing 2.3 + 2.4, right?
(20:27:36) cron2: let me check if there is enough interesting stuff in 2.=
3
(20:27:48) mattock: there is the one security fix
(20:27:53) dazo: I think it makes sense, yes .... and I'd even pull that =
patch into release/2.2 (no full release, just add it in git) *if* it is e=
asy enough to tackle
(20:28:23) dazo: * 5071f678 - OpenSSL: Always set SSL_OP_CIPHER_SERVER_PR=
EFERENCE flag (2017-09-07 00:39:21 +0200)
(20:28:24) dazo: * 49e12a39 - Deprecate --ns-cert-type (2017-08-15 13:37:=
32 +0200)
(20:28:24) dazo: * ca870b13 - crypto: correct typ0 in error message (2017=
-06-27 16:46:51 +0200)
(20:28:25) cron2: ah, well, yes.
(20:28:38) dazo: the first one is reasonable
(20:29:08) ***cron2 forgot about the CVE, but that one is old code, so "b=
ack until 2.2" -> 2.3 and 2.4 release
(20:29:14) cron2: sorry for being confused
(20:30:12) ordex: dazo: btw syzzer's patch was already ACK'd on security@=

(20:30:25) dazo: what do you mean with "back until 2.2"?   just apply to =
git, right?
(20:30:38) dazo: ordex: ahh ... okay ... well, I'm confused too :)
(20:30:43) cron2: dazo: well, apply to master, cherry-pick to 2.4, 2.3, 2=
=2E2
(20:30:52) cron2: but we do not do 2.2 releases
(20:31:00) mattock: definitely no
(20:31:03) dazo: cron2: agreed!
(20:31:15) cron2: ordex: who ACKed?
(20:31:23) ***dazo don't see the ack either
(20:31:23) cron2: (I *thought* I had seen an ACK :) )
(20:31:35) ordex: cron2: you did
(20:31:36) mattock: oh, btw, I issued a PR to easy-rsa-old to fix the PAT=
H problem that got introduced when OpenVPN no longer modifies system PATH=

(20:31:36) ordex: :D
(20:31:37) cron2: but anyway, I just sent one, the patch is straightforwa=
rd enough
(20:31:50) ordex: 20/09/17 19:25 +0200
(20:31:50) mattock: I hope to get that in by release time
(20:31:53) ordex: ah
(20:31:58) ordex: it's now :D
(20:32:00) cron2: yes
(20:32:01) ordex: sorry guys
(20:32:03) ordex: I am confused too
(20:32:04) dazo: lol
(20:32:23) mattock: who is _not_ confused? :P
(20:32:27) dazo: cron2: ordex, lev__, mattock and I have spent an hour ta=
king C++ stuff with james
(20:32:29) mattock: I've so far been unconfused
(20:32:32) mattock: :P
(20:32:39) ordex: hehe
(20:32:39) mattock: deep C++ stuff
(20:32:46) cron2: lev__ has been slurped into openvpn tech as well?
(20:32:50) dazo: mattock: ahh, you didn't pay enough attention to C++ the=
n! :-P
(20:33:00) dazo: cron2: yep :)
(20:33:12) ***cron2 got into serious quarrels with Gentoo about C++11 las=
t week... that was enough for my taste
(20:33:15) cron2: dazo: fun :-)
(20:33:35) mattock: dazo: I definitely did not, although I did have the b=
asic idea what a lambda function does (I think), but C++ goes over my hea=
d badly=20
(20:33:46) dazo: :)
(20:33:48) ***cron2 has the feeling that the 2018 hackathon will be in Ca=
nada, and more of an "OpenVPN Tech employee" meeting :)
(20:33:57) mattock: anyways, the easy-rsa-old fix for Windows installers:=
 https://github.com/OpenVPN/easy-rsa-old/pull/5
(20:33:57) cron2: (canada because nobody wants to go to .us)
(20:33:58) vpnHelper: Title: Set openssl PATH based on registry registry =
lookup by mattock =C2=B7 Pull Request #5 =C2=B7 OpenVPN/easy-rsa-old =C2=B7=
 GitHub (at github.com)
(20:34:30) ordex: (/me wants to propose the 2018 hackathon to be in a war=
m place in asia :P)
(20:34:40) ***dazo won't spoil any surprises regarding openvpn hackathons=
 :-P
(20:35:00) ordex: :D
(20:35:12) ordex: mattock: who is supposed to ack/review that normally?
(20:35:30) mattock: there's no particular person, so if you want to have =
a look feel free
(20:35:49) dazo: mattock: can we please let easy-rsa die, burn and be for=
gotten?   and move forward with easy-rsa 3?
(20:35:51) mattock: easy-rsa-old is pretty much forgotten, except that we=
've had to apply a few fixes lately
(20:36:10) mattock: dazo: yes, when somebody starts working on easy-rsa 3=
 :P
(20:36:21) mattock: actually, ecrist has become active on it in recent we=
eks, so there is hope
(20:36:26) dazo: mattock: ehm ... ecrist and chipitsine have been doing t=
hat already, not?
(20:36:40) mattock: ecrist yes, but only very recently
(20:36:52) dazo: I even think I remember him saying easy-rsa-3 is in a fa=
irly good shape even for windows
(20:37:00) ordex: mattock: I have no clue about that registry stuff, sorr=
y :/
(20:37:23) ***chipitsine does not mind if mattock will submit a patch
(20:37:34) mattock: already did
(20:37:49) mattock: it uses code by chipitsine :)
(20:37:51) dazo: otherwise, in regards to reviewing easy-rsa .... I think=
 that's okay for those involved there to ensure things moves forward
(20:38:05) mattock: yeah, that makes most sense
(20:38:36) mattock: I think tincantech has a vested interest in reviewing=
 my PR, as he found the problem in the first place
(20:39:01) chipitsine: it turned out that none of the person who reviewed=
 "remove openssl from PATH" use easy-rsa on regular basis
(20:39:19) mattock: yeah, that included me
(20:39:32) mattock: but the problem was not that bad to solve, especially=
 as several solutions were ready at hand
(20:39:35) dazo: yeah ... lets hear what ecrist says and take it from the=
re
(20:39:36) chipitsine: I will probably add easy-rsa to openvpn-windows-te=
st
(20:39:56) mattock: chipitsine: would make sense
(20:40:04) mattock: anyways, let's move forward shall we?
(20:40:28) chipitsine: to vlan patchset ?
(20:40:45) mattock: are we done with 2.4.4 release?
(20:41:06) mattock: do I recall correctly that ordex wanted to have a loo=
k at the VLAN patchset at some point?
(20:41:15) ordex: one last question: cron2 are you going to do the mtu/FA=
TAL change? or want m to propose a patch?
(20:41:22) ordex: mattock: yes, I expressed my interest in GH too
(20:41:28) mattock: ok
(20:41:32) ordex: I will check the patchset and help the guys to submit i=
t
(20:41:47) ordex: the problem is that it is quite a big chunk of changes =
=2E.. maybe we should flatten the ml a bit before injecting more features=

(20:42:38) ordex: but anyway, I'll help there
(20:42:49) dazo: great!
(20:43:26) ordex: cron2: another thing: there are few patches for route.c=
 pending on the ml which would be nice to merge before the hackathon so t=
hat we have a clean playground for any restyling we want to discuss :>
(20:43:38) dazo: +1
(20:43:43) cron2: right
(20:44:01) cron2: ordex: wrt mtu-disc/M_FATAL, I'll send a patch
(20:44:07) cron2: (wanted to do that last week already)
(20:44:07) ordex: cool, oky
(20:44:17) ordex: I'll review then :)
(20:45:11) cron2: wrt vlan patchset, this is a big one, and needs good un=
derstanding - and only master/ ("too intrusive"), so cleanup 2.4+master s=
tuff should go in first
(20:45:46) dazo: yeah, vlan is for 2.5/master only
(20:46:03) ordex: ah yeah, no doubt about that
(20:46:37) chipitsine: any schedule/roadmap for 2.5.0 ?
(20:46:50) mattock: not afaik
(20:47:33) ordex: that could be material for the hackathon ?
(20:47:34) mattock: I don't know how much "master"-specific stuff we have=
 now
(20:47:35) cron2: definitely no schedule, and no clear idea "what is goin=
g to be in there" either (at least me)
(20:47:43) cron2: mattock: not much
(20:47:47) mattock: ordex: that sounds like a good plan
(20:47:54) cron2: +1
(20:48:01) dazo: chipitsine: nope, not really .... we'll let 2.4 stabilis=
e properly and apply patches for master on rolling basis ... it have grow=
n big enough, we'll consider 2.5
(20:48:22) ordex: chipitsine: feature requests are welcome ;P
(20:49:44) ***chipitsine thinks that online crl update might be nice
(20:50:12) ordex: that's in already
(20:50:26) ordex: I think it made it for 2.4? I should check
(20:50:31) chipitsine: really? I missed that
(20:50:31) dazo: chipitsine: with online, you mean OCSP and similar?
(20:50:43) ordex: ah, I intended "at runtime"
(20:51:12) chipitsine: no, I mean "download CRL from CDP and cache it for=
 the ... next update from CDP"
(20:51:33) chipitsine: it is pre-OCSP stuff
(20:51:48) dazo: that should be supported in 2.4 already ... I think you =
can update the CRL on-the-fly without restarting openvpn now .... unless =
my memory is failing me completely
(20:52:15) ordex: right
(20:52:19) chipitsine: not updating manually, I mean downloading CRL from=
 where it is published
(20:52:32) ordex: downloading is not supported, but that a cronjob can do=
 it
(20:52:36) dazo: +1
(20:52:38) ordex: and openvpn will just reload it when needed
(20:53:00) ordex: before we sidetrack into that too much - anything else =
for the meeting?
(20:53:02) chipitsine: seem to be offtopic for today
(20:53:15) ordex: hehe yeah, but we can discuss later in #openvpn ;)
(20:53:38) dazo: should we try to do a few patch reviews?
(20:53:57) dazo: or is the brain capacity exhausted for today?
(20:54:12) ordex: it's 2am, I am just starting my day :D  I am fresh!
(20:54:16) mattock: I would need to split, plus we are approaching the ma=
gical 1 hour milestone :P
(20:54:19) dazo: :-P
(20:54:25) chipitsine: 22pm
(20:54:27) ordex: we still have 7 minutes
(20:54:46) ordex: oh
(20:54:46) dazo: lets do something very light ...
(20:54:48) ordex: one thing!
(20:54:51) ordex: patchwork
(20:54:52) dazo: shoot!
(20:54:55) dazo: yes!
(20:54:56) ordex: should we try to set it up=20
(20:54:57) cron2: yes!
(20:54:57) ordex: ?
(20:55:07) ordex: and try to get it running, without relying on it 100% r=
ight away?
(20:55:15) dazo: makes sense to me
(20:55:17) cron2: mattock was volunteered to do that, half a year ago :-)=

(20:55:24) ordex: after using it for a few weeks we might like it and rel=
y on it more
(20:55:29) ordex: ah! mattock !!
(20:55:31) dazo: ordex: have you done that before?
(20:55:33) ordex: do $something
(20:55:35) cron2: but I sense that other ... things... have major priorit=
y :-)
(20:55:36) ordex: dazo: only used :P
(20:55:39) dazo: okay
(20:56:17) dazo: we need more infra/ops guys in our community ... mattock=
 doesn't scale well enough alone! :-P
(20:56:32) mattock: definitely
(20:56:52) mattock: and now dazo is trying make openvpn tech enterprise-g=
rade, which robs more of my time :P
(20:56:58) cron2: we have ecrist, but he's always busy too...
(20:57:03) dazo: hehe
(20:57:15) cron2: enterprise-grade?  so that's with lots of processes, an=
d no work gets ever done?
(20:57:17) mattock: anyways, I can probably prioritize patchwork
(20:57:21) ordex: CRCinAU expressed interest in doing some sysadmin stuff=

(20:57:22) mattock: it probably is not too bad to setup
(20:57:23) dazo: to be fair, mattock .... I'm going to spend quite some t=
ime on that project too .... hope just francis won't be too much upset :-=
P
(20:57:53) chipitsine: I can participiate in some stuff
(20:58:57) dazo: cron2: we're going to deploy FreeIPA for user account an=
d access policy management .... and tie all our spread-out in-house and t=
hird party services into a single username/password ... with single-sign-=
on (including saml2)
(20:59:01) mattock: anyways, I will make a note that patchwork will be ex=
pedited
(20:59:23) cron2: dazo: woo, enterprise stuff! :-)
(20:59:28) mattock: I'll see if I could pull that off late next week
(20:59:37) ordex: my goodness dazo :D ETA?
(20:59:43) mattock: 4 hours
(20:59:44) mattock: :P
(20:59:48) ordex: yesterday!!
(20:59:49) dazo: ordex: october-ish :)
(20:59:55) ordex: dazo: 2020?
(21:00:01) ordex: like the kyoto protocol :P
(21:00:05) ***dazo whistles blowing in the wind
(21:00:08) ordex: hehe
(21:00:19) ordex: mattock: cool. patchwork is going to be very helpful im=
ho
(21:00:38) ordex: we can fingerpoint people more easily when they don't r=
eview :P
(21:00:44) dazo: ordex: I've done 3 FreeIPA setups already .... it's not =
that bad actually ... migration of existing hosts and accounts is the mos=
t challenging part
(21:00:49) mattock: definitely
(21:00:55) ***dazo even runs FreeIPA at home
(21:00:56) ordex: dazo: yeah, that was my concern
(21:00:58) ordex: lol
(21:01:02) ordex: what for?
(21:01:11) mattock: well there are no existing hosts, and we probably don=
't need to migrate the dozen or so users with fancy automation
(21:01:12) dazo: single-sign-on mostly :)
(21:02:04) ordex: dazo: for external services? I mean, stuff that are not=
 hosted at your home?
(21:02:09) dazo: ordex: zimbra, nextcloud, laptops, servers .... haven't =
managed to beat nextcloud into submission yet, but it's progressing
(21:02:19) ordex: ah ok
(21:02:36) mattock: anyways, this is getting off-topic
(21:02:39) dazo: :)
(21:02:45) dazo: really!??! :-P
(21:02:52) mattock: I made a note of patchwork in the summary
(21:02:59) mattock: :)
(21:03:09) cron2: since we're over time, we're not bound by topics :)
(21:03:15) ordex: btw we have a bunch of PRs on Github, what shall we do =
with them?
(21:03:24) dazo: got a flame thrower?
(21:03:30) mattock: ordex: there's actually an internal JIRA task about h=
aving a look
(21:03:39) cron2: jftr, I won't make next wednesday's meeting
(21:03:40) mattock: to see if there's any promising stuff in there
(21:03:44) mattock: cron2: ok
(21:03:48) ordex: internal JIRA? for openvpn2?
(21:04:00) mattock: community board
(21:04:07) ordex: ok
(21:04:13) dazo: My next wednesday is also at high risk
(21:04:45) mattock: I think we can still do a meeting (or just abort it) =
unless bad wednesdays become common
(21:04:53) mattock: rather than shuffle meeting time back and forth
(21:05:19) ordex: ok
(21:05:22) cron2: yes, keep wednesday, keep it short, and unless someone =
really can never make it, do not shuffle
(21:05:31) dazo: cron2++
(21:05:35) ordex: cron2++
(21:05:40) ordex: eval(cron2)
(21:05:42) mattock: ok, done for today? :P
(21:05:51) ordex: think so
(21:05:52) cron2: ordex: integer overflow
(21:05:57) ordex: eeeeh :D
(21:06:41) mattock: I will send the summary now - have to go buy discount=
ed products (60%!) from the local supermarket :P
(21:06:56) cron2: local supermarkets here closed 6 minutes ago
(21:07:23) mattock: ours are open for ~2 hours still
(21:07:30) chipitsine: I have 24hr working supermarket around
(21:07:55) mattock: that's luxury
(21:08:00) mattock: but anyways, good meeting!
(21:08:06) cron2: +1
(21:08:07) mattock: hopefully we can have one next week

--------------6C077A9E069120BA1519113F--

