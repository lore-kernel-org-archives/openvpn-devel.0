Message-ID: <556D7F87.600@...515...>
Date: Tue, 02 Jun 2015 13:03:51 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <5566FE83.7030206@...515...>
In-Reply-To: <5566FE83.7030206@...515...>
Content-Type: multipart/mixed; boundary="------------030901030109010402010103"
Subject: Re: [Openvpn-devel] Topics for next Monday's (1st Jun 2015)
 community meeting
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
--------------030901030109010402010103
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of today's IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Monday 1st Jun 2015
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2015-06-01>

The next meeting is scheduled to two weeks from this meeting:

<https://community.openvpn.net/openvpn/wiki/Topics-2015-06-15>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock and syzzer participated in this meeting

---

Discussed the way Trac ticket fields should be used. The proposal made by m=
attock was accepted as-is:

<https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation#Managing=
Tractickets>

--

Discussed the "Make check doesn't play nicely with automake 1.12 and up" is=
sue:

<https://community.openvpn.net/openvpn/ticket/427>

It was agreed to use the configure.ac hack from libguestfs instead of patch=
ing the buildslaves only. This way our users won't have to be so careful ab=
out their automake versions.

--

Discussed the OpenVPN 2.3.7 release. Some tickets which had no easy resolut=
ion in sight were moved to the 2.3.8 milestone. The remaining issues have b=
een or can be fixed. We will try to push out the 2.3.7 release later this w=
eek.

--

Discussed the OpenVPN 2.4 release. We will try to get a pre-alpha version w=
ith the interactive service out very soon. The primary reason is to allow t=
esting on the Windows platform.

--

Full chatlog is included as an attachment.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------030901030109010402010103
Content-Type: text/plain; charset=UTF-8;
	name="openvpn_irc_meeting_chatlog_2015-06-01.txt"
Content-Disposition: attachment;
	filename="openvpn_irc_meeting_chatlog_2015-06-01.txt"
Content-Transfer-Encoding: quoted-printable

(20:56:12) cron2: mattock1: well, it would need "git master + patch from =
list" - I do not want to commit it if it won't work...
(20:56:16) cron2: besides, I'm here :)
(20:57:21) mattock: cron2: which patch?
(20:57:33) mattock: I can trigger a manual Windows build now
(20:57:47) cron2: http://article.gmane.org/gmane.network.openvpn.devel/97=
68
(20:57:50) vpnHelper: Title: Gmane -- PATCH Use EAI AGAIN instead of EAI =
SYSTEM for openvpn getaddrinfo . (at article.gmane.org)
(20:57:55) cron2: this one :)
(20:59:11) mattock: ok
(21:04:36) mattock: I wonder if everyone else forgot the meeting
(21:04:40) syzzer: I'm here too
(21:04:52) mattock: ah hi!
(21:05:01) mattock: I was about to throw in the towel :P
(21:05:22) syzzer: heh, so I was just in time ;)
(21:05:32) mattock: yep
(21:05:34) cron2: syzzer: welcome back :)
(21:06:06) mattock: so here's the topic list: https://community.openvpn.n=
et/openvpn/wiki/Topics-2015-06-01
(21:06:07) vpnHelper: Title: Topics-2015-06-01 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:06:23) syzzer: let me try a windows build locally
(21:06:28) mattock: I need to split in about an hour
(21:06:41) mattock: syzzer: feel free, though I was about to do it
(21:06:51) syzzer: also fine - less work for me ;)
(21:06:56) mattock: ok
(21:07:57) cron2: anyway, topic #1 - trac fields. I think what you wrote =
up works
(21:08:31) mattock: ok, great!
(21:08:49) mattock: I'll remove the text about proposals etc.
(21:09:03) mattock: topic #2: https://community.openvpn.net/openvpn/ticke=
t/427
(21:09:05) cron2: the judgement of "it can be reasonably be resolved" mig=
ht differ between people who look at tickets .-) (I feel confident hackin=
g socket issues, but won't resolve windows stuff) but with these as gener=
al guidelines, we should be good
(21:09:07) vpnHelper: Title: #427 (make check doesn't play nicely with au=
tomake 1.12 and up) =E2=80=93 OpenVPN Community (at community.openvpn.net=
)
(21:09:32) cron2: *sigh* (did I mention I hate automake?)
(21:09:32) mattock: cron2: yeah, what I meant is "can be expected to get =
resolved"
(21:10:10) cron2: "whatever" :) - it is good enough as an orientation, an=
d we can always refine it
(21:10:16) mattock: yep
(21:10:30) mattock: so automake
(21:10:33) ***syzzer looks
(21:10:50) mattock: cron2: have you tried the automake hack from libguest=
fs?
(21:11:10) cron2: haven't tried, but I'm reasonably sure that it works
(21:11:25) cron2: if we decide to go there, I'd test it on my most recent=
 (1.15) and oldest (1.10) box
(21:11:31) syzzer: I don't understand why that works, but tbh I don't wan=
t to know :p
(21:11:46) cron2: syzzer: configure.ac can pass automake options, and the=
y can be m4 macros...
(21:11:59) cron2: and yes, I share that sentiment :)
(21:12:35) cron2: basically, we have two alternatives - "stick to what we=
 have" (and work around it by a buildbot script) or "go for the configure=
.ac hack"...
(21:12:47) ***syzzer votes hack
(21:13:10) mattock: I think the configure hack is less painful, and break=
s less often
(21:13:33) mattock: we might want to pretest it to ensure all buildslaves=
 accept it
(21:13:49) mattock: maybe push the changes to a temporary branch and manu=
ally force a build on all buildslaves?
(21:14:01) cron2: that's what I meant - if it works on freebsd 9.0 and op=
ensolars (automake 1.15 <-> 1.10) should give a good indication
(21:14:04) cron2: or that
(21:14:06) cron2: let me test that :)
(21:16:01) ***dazo passing by quickly
(21:16:09) dazo: I can run some tests on a CentOS5 box
(21:16:30) mattock: dazo: hi, that would be great!
(21:16:37) cron2: dazo: I think for testing, using the buildslave army wi=
th a temporary branch is good enough - but what do you *think*?
(21:17:07) dazo: if you want to be sure it works on our oldest distro bef=
ore pushing anything out, I'm keen on testing it
(21:17:17) cron2: please test :)
(21:17:34) dazo: I think the configure.ac script hack is the best approac=
h, if we want to not annoy users with "your automake is too old"
(21:17:41) dazo: s/users/developers/
(21:17:49) cron2: but I have a git question for you :)
(21:17:53) dazo: shoot!
(21:17:57) mattock: dazo: very good point
(21:18:22) ***cron2 has created a local branch "experimental" - this is e=
asy. Which repo shall we use for that, and how do I push it there? I use =
the "git push-all" setup you told me to use...
(21:18:38) dazo: right ... git push $REPO $BRANCH
(21:19:02) dazo: to list all configured repos: git remote -v
(21:19:03) cron2: well, that's the basic part (and I understand)
(21:19:13) cron2: which of the openvpn repos we want to use for this?
(21:19:15) mattock: this is now official: https://community.openvpn.net/o=
penvpn/wiki/DeveloperDocumentation#ManagingTractickets
(21:19:18) vpnHelper: Title: DeveloperDocumentation =E2=80=93 OpenVPN Com=
munity (at community.openvpn.net)
(21:19:27) cron2: we have sf/openvpn-testing, sf/openvpn, and github/open=
vpn
(21:19:46) dazo: IIRC, buildbot pulls the github repos .... unless I'm co=
mpletely mistaken .... mattock1?
(21:19:56) mattock: actually it pulls from SF.net currently
(21:20:02) mattock: but that's trivial to change
(21:20:05) cron2: which sf repo?
(21:20:10) mattock: lemme check again
(21:20:36) dazo: that's the right question :)
(21:20:43) cron2: we have testing/experimental already... stick at "45c9e=
79 Prepare the OpenVPN v2.3_alpha2 release"...
(21:20:54) mattock: openvpn-testing
(21:20:55) dazo: please use that branch
(21:21:16) dazo: we've not had anything in particular which was /that/ ri=
sky since we started the 2.2 dev cycle
(21:22:41) cron2: ok, please walk me through it :-) - my "experimental" b=
ranch is based off master now
(21:23:06) cron2: I have a remote "testing" defined that points to git://=
git.code.sf.net/p/openvpn/openvpn-testing
(21:23:08) dazo: cron2: you might want to check out the experimental bran=
ch ... and just do: git reset --hard master .... and then do a git push w=
ith --force
(21:23:12) cron2: (and ssh://...)
(21:23:57) cron2: so, my local branch goes to "git push testing experimen=
tal"?
(21:24:10) dazo: people pulling down the testing repo will get a warning =
that that branch was forcefully updated if you used --force ... but that'=
s of no concern, at least not with the meeting minutes today
(21:24:24) cron2: why would it need --force?
(21:24:26) dazo: git checkout testing/experimental
(21:24:33) dazo: git reset --hard master
(21:24:45) dazo: git push [--force] testing experimental
(21:24:51) cron2: I'm not sure I understand what that will do
(21:25:17) cron2: or: why can I not push my local "experimental" branch t=
o "testing experimental"? Or will it do the same thing under the hood?
(21:25:19) dazo: the reset will completely ignore which branch the experi=
mental branch was forked from
(21:25:51) cron2: but wouldn't that push "master" to testing/experimental=
?
(21:25:56) dazo: ahh, right ... it's basically the same thing ... as you =
just completely disregard the old stuff in that branch
(21:26:11) cron2: lets see
(21:26:23) dazo: yes, it will ... so git reset *is* risky ... and with --=
hard, it does delete history
(21:26:29) dazo: (in that branch)
(21:26:35) ***cron2 just pushed and git was happy :-)
(21:26:41) cron2: 45c9e79..62d555c experimental -> experimental
(21:26:41) dazo: \o/
(21:26:51) ***dazo pulls
(21:26:52) cron2: commit 62d555c4e781c0f7f659b2660410452636030d39
(21:26:57) cron2: Use configure.ac hack to apply serial_test AM option on=
ly if possible.
(21:27:38) cron2: indeed, git is even smarter than I thought - it has nic=
ely rebased testing/experimental to master+configure.ac :)
(21:27:43) dazo: we have a surprisingly clean repo these days ... because=
 this was basically a rebase from a 2.2_alpha release to latest master wi=
thout any conflicts
(21:28:12) ***dazo finds his CentOS 5 box
(21:29:07) cron2: dazo: I'm carefully only doing what you told me to :-) =
(*and* I'm quite careful with my local "master" repo, unlike the massacre=
s I do to all the other copies flying around)
(21:29:21) dazo: :)
(21:29:24) cron2: mattock: can you build 62d555c4e781c0f7f659b26604104526=
36030d39?
(21:29:45) dazo: autoreconf -vi ran successfully
(21:29:45) mattock: tip of experimental branch?
(21:29:50) cron2: yep
(21:30:11) mattock: I'll see what happens
(21:30:22) mattock: haven't actually ever tried to build a different bran=
ch :)
(21:31:13) mattock: cron2: any good candidate for breakage?
(21:31:19) syzzer: (in the mean time, I'm trying to revive my windows bui=
lds, and the EAI_SYSTEM -> EAI_AGAIN change makes it compile for me)
(21:31:23) dazo: mattock1: I believe if you give a commitish via the webu=
i, it'll do the right thing
(21:31:43) mattock: dazo: having a look
(21:31:49) cron2: mattock1: well, the old patch broke opensolaris, freebs=
d7, debian-7
(21:31:52) syzzer: but the mingw-linker is a bit lost it seems
(21:31:59) cron2: syzzer: what is it missing?
(21:32:09) dazo: (branches are commitishes on steroids)
(21:32:17) syzzer: seems to try to link to an older version of polarssl
(21:32:27) cron2: oh well, *that* is not my doing :)
(21:32:35) syzzer: no, different issue
(21:32:54) syzzer: i suspect the polarssl -> mbedtls naming...
(21:32:58) dazo: cron2: I don't have t_client.rc on my centos 5 box ... b=
ut it's compiling the experimental branch now ... I believe that's furthe=
r than last time
(21:33:02) dazo: testing on RHEL7 now
(21:33:36) mattock: it started building 62d555c4e781c0f7f659b266041045263=
6030d39 on debian 7
(21:33:46) mattock: I'll try to trigger the windows build now
(21:33:50) syzzer: aargh "libmbedtls.a"
(21:33:54) cron2: dazo: well, on centos 5, if it compiles, you won't see =
the difference anyway :-) - but even without t_client.rc, "make check" wi=
ll run the two other tests and nicely show their output, as opposed to "h=
ide it, print nothing for 3-4 minutes, then summary"
(21:34:26) cron2: mattock1: that "should" be "just linux autotools", but =
let's see :)
(21:34:27) dazo: and that happens ... on both CentOS 5 and RHEL 7
(21:34:48) cron2: dazo: which "that" in particular?
(21:35:07) dazo: cron2: "make check" will run the two other tests and nic=
ely show their output
(21:35:20) cron2: *that* "that" is good :)
(21:35:27) dazo: :)
(21:35:40) dazo: my RHEL box got t_client.rc ... which also runs
(21:35:44) cron2: the other that ("hide") wouldn't be welcome :) - what a=
utomake version has RHEL7?
(21:36:04) dazo: automake (GNU automake) 1.13.4
(21:36:41) dazo: CentOS 5: automake (GNU automake) 1.9.6
(21:36:45) cron2: ok, that has parallel tests - so if that works, the pat=
ch does the job. Good :)
(21:36:49) cron2: (1.13 that is)
(21:36:53) dazo: yeah
(21:36:59) cron2: 1.9 is ooold. Not breaking that is also very welcome.
(21:37:06) dazo: :)
(21:39:33) cron2: debian-7 buildbot failed, but that smelled more like co=
nnectivity issues to sf.net
(21:39:50) mattock: cron2: the branch was still set to master
(21:39:56) mattock: hence it could not find the commit id
(21:40:06) mattock: now it builds top of "experimental"
(21:40:12) cron2: mattock1: did the buildmaster just hickup
(21:40:13) cron2: ?
(21:40:46) mattock: the debian 7 build from experimental worked as expect=
ed, branch "experimental"
(21:40:53) mattock: cron2: buildmaster should be ok
(21:41:27) cron2: can't get to http://10.177.36.101:8010/builders
(21:41:29) dazo: make check successfully completed on CentOS 5 and RHEL 7=
 ... Spinning up a Fedora 22 VM ... just for sanity
(21:41:50) cron2: ah, sorry
(21:41:51) mattock: cron2: I'm surfing the buildbot webui right now
(21:41:52) cron2: local error
(21:42:11) ***cron2 has a socks proxy into corporate network that can be =
turned on and off by a button in chrome, and it was "on"
(21:43:36) mattock: windows build with the patch ongoing
(21:44:00) mattock: shall we move to topic #3 (OpenVPN 2.3.7) next?
(21:44:00) cron2: mmmh, fsbd90 was offline, openvpn client died... what s=
ort of crappy product is this
(21:44:36) cron2: yep, and return to this when we have results :)
(21:45:05) mattock: so let's see what Trac says and then see what the rea=
l status is
(21:45:20) cron2: let's decide on release date first - this week, or "eve=
ntually"?
(21:46:05) syzzer: "this week"
(21:46:22) syzzer: there a lot of good stuff in release/2.3
(21:46:24) mattock: sounds good
(21:46:41) mattock: cron2: shall I trigger a build of "experimental" on a=
ll builders?
(21:46:42) cron2: ok, in that case I suggest leaving #427, #481, #523 on =
2.3.7, and move the rest to 2.3.8
(21:46:50) cron2: mattock1: please :)
(21:46:59) mattock: started
(21:47:06) cron2: fbsd90 just reconnected
(21:47:15) mattock: checking the tickets...
(21:47:23) cron2: I have patches out for #472, #481 and #523, I just need=
 a few ACKs
(21:47:29) cron2: 427
(21:48:15) floppym ha abbandonato la stanza (quit: Ping timeout: 248 seco=
nds).
(21:48:28) cron2: #521 and #180 are quite similar, and need a bit of "sta=
re in the code and think", but that's an area I'm not so familiar with, s=
o I didn't start yet
(21:48:50) cron2: #395 could use a bit of documentation :)
(21:49:04) syzzer: I guess #481 is "lazy ACK" ?
(21:49:31) cron2: I had hoped to hear back from the original reporter (ma=
ndree has included it as optional patch in the freebsd port), but they ar=
e all in holiday or so
(21:49:33) mattock: cron2: re: 395: I provided a suggestion for the docs
(21:50:11) cron2: mattock1: works for me
(21:50:21) cron2: the </connection> should go into a separate ticket
(21:50:28) mattock: ok, then I'll send a patch and create that ticket
(21:50:47) cron2: which is something for plaisthos to frown upon :)
(21:52:35) cron2: mattock1: so how do you trigger an "all slaves" build w=
ith a specific branch/commitish?
(21:53:16) cron2: ah, just on the end of /builders
(21:53:23) mattock: click "builders", scroll to the bottom to the "Force =
all builds" section and set branch to "experimental"
(21:53:24) mattock: yeah
(21:53:42) mattock: windows build worked, I'll double check it used a pat=
ch Git "master"
(21:54:14) syzzer: whee, it links \o/
(21:54:24) cron2: cool. Can I have an ACK, please? ;-)
(21:54:24) mattock: yeah, it was using the new patch
(21:54:28) mattock: ack
(21:54:48) cron2: but I'll make more use of experimental in the future, t=
his is very welcome
(21:55:15) cron2: is it difficult to make the windows builder watch "expe=
rimental" and build from there?
(21:55:18) mattock: I think experimental is very useful especially when b=
uild breakages could be expected
(21:55:21) mattock: less backpedaling
(21:55:42) mattock: cron2: could you move tickets from 2.3.7 to 2.3.8?
(21:56:06) cron2: #141 is actually "we might want to discuss this in a fu=
ture meeting"
(21:56:28) mattock: I think we should not postpone 2.3.7 too much, we can=
 always make 2.3.8 release in quick succession
(21:57:07) cron2: misunderstanding. What we want to do about #141 (how to=
 fix it) needs a bit of discussion, it's not a straightforward answer
(21:57:52) mattock: yeah, that one
(21:58:53) cron2: we might want a release 2.3.9 milestone :) (and get rid=
 of the 2.3.0-2.3.6 ones)
(21:58:59) mattock: I'll move tickets around a bit
(21:58:59) cron2: mmmh
(21:59:01) cron2: keep them
(21:59:16) cron2: in case someone wants to see "what did we solve for 2.3=
.5" or so
(21:59:18) mattock: I don't think we can really remove the old milestones
(21:59:23) mattock: maybe from the dropdown list, not sure
(22:01:00) mattock: I believe tickets for 2.3.7 are now in order
(22:01:15) cron2: ok, 4 left, 3 have patches on the list, 1 has patches i=
n queue - good :)
(22:01:21) mattock: yep
(22:01:47) cron2: oh, #261 will also go in :)
(22:02:24) mattock: ah, the patch submission
(22:02:40) cron2: I found time to understand both the feature and the iss=
ue :)
(22:03:12) mattock: ok so 2.3.7 is covered?
(22:03:55) cron2: yep
(22:03:58) cron2: release on wednesday?
(22:04:15) dazo: cron2: autotools update ... just did a test on Fedora 22=
 with automake 1.15 and gcc 5.1.1 ... success there too
(22:04:25) cron2: dazo: cool :)
(22:04:27) mattock: wed or thu
(22:04:52) mattock: I'm on a semi-vacation in Crete so I have about 3-4 h=
ours each day at morning of working time
(22:05:01) cron2: nice :)
(22:05:06) ***cron2 has time in the afternoon and evening
(22:05:13) dazo: mattock1: release late thurday, mumble something about s=
ecurity ... and watch the panic unfold ;-)
(22:05:27) mattock: so if I have sources in the evening I might just be a=
ble to squeeze out a release the next day
(22:05:35) mattock: dazo: lol :)
(22:05:39) cron2: kindergarten is on (semi-)strike, so I have to be at ho=
me at 3pm, but kids mostly play together now
(22:05:43) mattock: I've used that card several times already, though
(22:05:46) dazo: I'd vote for Wednesday
(22:05:54) dazo: if possible to achieve
(22:06:19) cron2: if I can get everything ACKed, I can tag and push tuesd=
ay evening
(22:06:45) dazo: cron2: I'll grant the autotools patch an ACK
(22:06:48) cron2: \o/
(22:06:59) cron2: (it's on the list since about 30 seconds or so)
(22:07:06) syzzer: few days earlier or later wouldn't matter too much, ri=
ght?
(22:07:22) cron2: not seriously, why?
(22:07:37) syzzer: I mean, if its trouble for mattock1 to manage
(22:08:22) cron2: ah - I understood "it's ok", but if it does not work ou=
t, we release next week or so
(22:08:33) syzzer: I could manage him enjoying the sun on Crete, instead =
of doing a release ;)
(22:08:34) mattock: I've allocated the morning for work
(22:09:10) mattock: so I will "do my best"(tm) but can't promise anything
(22:09:26) syzzer: perfect, I'll shut up then ;)
(22:09:28) dazo: cron2: ACK sent to ML
(22:09:31) mattock: the good thing is that I hate (just) laying down in t=
he sun for more than 30 minutes or so :D
(22:09:33) cron2: freebsd-7.4 failed building, but that was one of the sp=
urious t_client fails - sometimes it just does that, I think there's a ra=
ce with the high RTT to the test server... need to improve openvpn handsh=
aking anyway
(22:09:42) cron2: mattock1: good :)
(22:10:05) mattock: hmm, it seems the hotel wifi router's DNS server stop=
ped working again
(22:10:18) mattock: I was about to send a man-page patch but I suspect th=
at won't work out
(22:10:24) mattock: tomorrow then
(22:10:34) cron2: mattock1: you need to leave?
(22:10:58) dazo: mattock1: I'm always running my own personal caching nam=
e server on my laptop ... to avoid such mess .... or you can leak your DN=
S lookups to google using 8.8.8.8
(22:11:00) mattock: not due to DNS, but for sleeping reasons very soon
(22:11:14) mattock: yeah, I had to do that earlier today
(22:11:22) cron2: shall we quickly cover 2.4 and postpone 8.1?
(22:11:57) mattock: I was about to suggest that we skip 2.4 until after 2=
.3.7 release, because there's so much stuff under that milestone :)
(22:12:00) mattock: or are they all valid?
(22:12:42) mattock: oh, DNS is back
(22:12:44) cron2: oh, you wanted to actually look at all the tickets - th=
at is stuff for a number of meetings I think
(22:13:00) mattock: yeah, exactly
(22:13:08) cron2: I just wanted to agree that "these milestones make sens=
e" and quickly sync with syzzer on "where are we"?
(22:13:17) mattock: let's do your version
(22:13:26) cron2: "these milestones make sense" :)
(22:13:28) dazo: I'd like to see that we're getting the user-input rewrit=
e patches I re-sent to the ML reviewed and included ... Next RHEL7 minor =
release will support the --no-echo argument, which makes systemd integrat=
ion work more nicely
(22:14:00) cron2: dazo: definitely
(22:14:11) mattock: dazo: do we have a trac ticket for those ptaches?
(22:14:12) mattock: patches
(22:14:14) syzzer: dazo: yes
(22:14:27) cron2: we do have the patches on the list as well :)
(22:14:51) mattock: yeah, and tickets are good for aiding memory :P
(22:15:01) mattock: even if they just point to a mailing list thread or s=
omething
(22:15:01) syzzer: from now my focus will shift to 2.4 (and hopefully the=
 stress levels at $dayjob will drop a bit...)
(22:15:04) dazo: mattock1: I haven't made a trac ticket .. but if that's =
a requirement, I can do that
(22:15:27) mattock: dazo: I think it would be good idea to ensure the pat=
ches are not forgotten about by mistake
(22:15:41) dazo: mattock1: I won't forget my patches ;-)
(22:15:53) dazo: I'll just start nagging more and more often ;-)
(22:16:03) syzzer: hehe, poking works too indeed ;)
(22:16:03) mattock: if that is what you prefer I'm fine with it :D
(22:16:07) cron2: syzzer: yeah, I'm still somewhat in bug fix mode, but o=
ne of them (#261) actually touched the redirect gateway stuff sufficientl=
y to get me started on that block (redirect for ipv6) :)
(22:16:31) syzzer: re 2.4 milestones: yes, makes sense
(22:16:34) cron2: mattock1: I think for the regulars, trac tickets are le=
ss important that for occasional visitors :)
(22:16:53) dazo: mattock1: it's not really a bug ... it's an improvement =
over the current state ... so it would be an RFE ticket, not a bug ticket=
 ... and I think we have enough in trac
(22:17:15) mattock: we would not even need them _if_ we could resolve all=
 issues very quickly
(22:17:27) dazo: yupp!
(22:17:54) cron2: yeah, 5+ extra developers that are happy to wade throug=
h 15 year old code that is half magic and half insane, that would be real=
ly cool :-)
(22:17:57) mattock: I'm not insisting on adding tickets for their own sak=
e, but if the alternative is to forget, then I prefer a ticket
(22:18:26) mattock: cron2: sounds a lot like H.P. Lovecraft short stories
(22:18:38) dazo: mattock1: agreed
(22:18:49) mattock: ok, so 2.4 "covered"?
(22:19:16) syzzer: who adds the milestones/
(22:19:40) mattock: oh milestones... do we want 2.3.9 already at this poi=
nt?
(22:19:59) cron2: mattock1: yes
(22:20:00) mattock: I'll check what we have as far as 2.4 is concerned
(22:20:11) syzzer: ok, good :)
(22:20:29) mattock: takes some time, slow Internet
(22:21:02) syzzer: I think we might even want to do an 2.4-alpha1 release=
 soon
(22:21:08) mattock: agreed 100%
(22:21:13) cron2: I'm so closing #427 now
(22:21:17) cron2: syzzer: nah
(22:21:22) mattock: I'd say right after the interactive service is merged
(22:21:40) cron2: if we add big functionality (AEAD) after alpha1...
(22:21:51) mattock: what's the status of that one?
(22:22:03) cron2: but yeah, we might want "what we have so far + iservice=
" to get that one out to windows users...
(22:22:11) ***cron2 points to syzzer
(22:22:15) syzzer: waiting for review, and waiting for syzzer to tidy up =
and send to ml
(22:22:53) mattock: this was the "jamesyonan and syzzer will do some test=
ing together" thing, right?
(22:23:02) cron2: and then it gets stuffed to "experimental" for the firs=
t tests :)
(22:23:05) cron2: that was AEAD
(22:23:07) syzzer: yes, that
(22:23:11) mattock: ok
(22:23:22) cron2: well, both iservice and AEAD are waiting for syzzer :)
(22:23:28) mattock: could we arrange an official meeting with jamesyonan?
(22:23:29) syzzer: uhuh
(22:23:29) vpnHelper: RSS Update - gitrepo: Use configure.ac hack to appl=
y serial_test AM option only if supported. <https://github.com/OpenVPN/op=
envpn/commit/c615835aa93701c764c23fc2579d97757c1a9970>
(22:23:57) cron2: regarding official meeting: should we start planning th=
e den haag hackathon?
(22:24:23) mattock: soonish
(22:24:34) syzzer: delft (or amsterdam), but yeah :)
(22:24:37) cron2: mattock1: what would be "an official meeting"?
(22:24:47) syzzer: I have confirmation that you guys are welcome :)
(22:24:48) mattock: like an IRC meeting with james
(22:24:51) cron2: syzzer: oh, delft, indeed (amsterdam?)
(22:24:57) syzzer: jjk offered to host too
(22:25:19) cron2: I've been to nihkef, about 100 years ago :) - but never=
 to delft
(22:26:04) cron2: (and I'm in Amsterdam about once a year, so I would muc=
h prefer to see Delft - but Amsterdam would work out for me, too, so that=
's not a show-stopper)
(22:26:29) mattock: smaller cities are nice
(22:26:48) mattock: anyhow, regarding the Windows 8.1 thing on the topic =
list
(22:26:56) syzzer: I'll send a doodle around somewhere in the coming week=
s :)
(22:27:06) cron2: syzzer: cool
(22:27:08) mattock: sounds good
(22:27:22) mattock: ... maybe we could postpone it
(22:27:25) mattock: I need to hit the sack
(22:27:39) syzzer: fine by me :)
(22:27:42) cron2: can I get an ACK on the EAI_AGAIN patch?
(22:27:46) syzzer: next meeting in two weeks?
(22:27:51) cron2: mattock1: good night, enjoy your half-vacation
(22:27:52) mattock: syzzer: would work for me
(22:28:14) mattock: cron2: ACK as it unbreaks things
(22:28:15) cron2: I might be a bit late, but let's aim for it
(22:28:18) syzzer: cron2: yes, I'll ack
(22:28:38) cron2: (family celebration and traveling back on monday - but =
then, kids need sleep)
(22:28:43) cron2: thanks
(22:29:03) mattock: summary will follow tomorrow, only halfway done
(22:29:13) syzzer: (I'll send my ACK on the list too, fits the usual proc=
ess better)
(22:29:15) cron2: g'night :)
(22:29:21) mattock: good night guys!
(22:29:26) dazo: c'ya
(22:29:28) syzzer: good night!

--------------030901030109010402010103--

