References: <ca74abaa-6dd7-a535-ff6d-ba4f6155bb08@...515...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <b0e2692c-85a4-acde-37ff-df30470ac85b@...515...>
Date: Wed, 23 Nov 2016 22:52:01 +0200
MIME-Version: 1.0
In-Reply-To: <ca74abaa-6dd7-a535-ff6d-ba4f6155bb08@...515...>
Content-Type: multipart/mixed; boundary="------------1ACB101913021A4427529BE3"
Subject: [Openvpn-devel] Summary of the today's (Wednesday,
	23rd Nov 2016) community meeting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------1ACB101913021A4427529BE3
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of today's IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 23rd November 2016
Time: 20:00 CET (19:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2016-11-23>

The next meeting has been scheduled to a week from now (Wed 30th=20
November), at the same time as today.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron, dazo, mattock, plaisthos, snair and syzzer participated in this=20
meeting.

---

Discussed the OpenVPN 2.4_beta2 release:

<https://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn24>

Snair produced a new PR with squashed commits for the openvpnserv2=20
exit-event fix:

<https://github.com/OpenVPN/openvpnserv2/pull/6>

After a few minor fixes to the commit message mattock will be able to=20
merge it.

Agreed to try to have all current openvpn-gui PRs merged before OpenVPN=20
2.4_rc1 release. Mattock will provide a test installer with as many of=20
the PRs as possible to facilitate testing.

Agreed that any "minor" items that don't make it into 2.4_beta2 will be=20
moved to 2.5.

Agreed to try to have all 2.4_beta2 patches ready by tomorrow evening=20
(CET). Mattock then has a chance to make the release on Friday or=20
Saturday morning at latest.

---

Discussed the OpenVPN 2.3.14 release. Agreed that 2.4_beta2 has=20
priority, so 2.3.14 will need to be postponed to the upcoming week.

--

Full chatlog has been attached to this email.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock







--------------1ACB101913021A4427529BE3
Content-Type: text/plain; charset=UTF-8;
	name="openvpn_irc_meeting_chatlog_2016-11-23.txt"
Content-Disposition: attachment;
	filename="openvpn_irc_meeting_chatlog_2016-11-23.txt"
Content-Transfer-Encoding: quoted-printable

(21:02:05) mattock: meeting time?
(21:02:15) cron2: yo
(21:02:32) snair: hi guys..
(21:02:41) mattock: hi!
(21:02:47) cron2: hi!
(21:03:29) syzzer: hi!
(21:04:08) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
6-11-23
(21:04:10) vpnHelper: Title: Topics-2016-11-23 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:04:32) mattock: topic page still looks basically the same as last wee=
k
(21:05:28) dazo: ahh!
(21:05:38) cron2: we've done quite a bit, but the "must have" is missing =
one important bit :-) - I think the "poor man's NCP" should be a "we real=
ly want this" (to ease migration away from BF for 2.3 users)
(21:05:41) mattock2 ha abbandonato la stanza (quit: Quit: IRC for Sailfis=
h 0.9).
(21:05:59) cron2: supposedly a v5 in lean and nice is coming up...
(21:07:03) mattock: ok, let this mark the official beginning of this meet=
ing
(21:07:09) syzzer: working on that, yes...
(21:07:23) mattock: and we are discussing 2.3.14 now?
(21:07:38) syzzer: no, 2.4
(21:07:39) dazo: yeah, I've dived quite far down my mail archive .... and=
 I don't think I see anything which should have attention being ignored
(21:07:57) dazo: the only minor thing lingering now is a simple man-page =
update .... http://www.mail-archive.com/openvpn-devel@...1223...=
et/msg12506.html
(21:07:58) vpnHelper: Title: [Openvpn-devel] [PATCHv2] Document the --aut=
h-token option (at www.mail-archive.com)
(21:08:17) dazo: (that is --auth-token, not the new --auth-gen-token whic=
h is documented)
(21:08:33) cron2: mattock: we're following your agenda, thus, 2.4 first :=
)
(21:08:39) mattock: ok, ic
(21:09:06) mattock: I just had the impression that "poor man's" anything =
can't be related to 2.4 :D
(21:09:34) cron2: mattock: it's pure brilliance - "make a 2.3 client spea=
k to a 2.4 server AND negotiate AES, even though 2.3 can't do that"
(21:10:02) cron2: dazo: the man page patch is 2.4 and 2.3, right?
(21:10:10) dazo: cron2: yepp
(21:10:43) mattock: cron2: ok
(21:10:59) dazo: I might have found a corner case when using 2.4 server w=
ith NCP enabled and 2.3.13 client kicked off via NetworkManager .... have=
n't had time to dig into that, but it complains mismatching ciphers
(21:11:23) dazo: starting the "same" connection from the command line wor=
ks just fine
(21:11:46) dazo: starting the exact same connection via NetworkManager us=
ing 2.4_beta1 works fine too
(21:11:50) cron2: my usual answer to this is "log files or it did not hap=
pen" :)))
(21:12:49) dazo: I'm going to dig into it .... and get more details .... =
NetworkManager puts most of the config on the command line, so I'll get a=
 clue
(21:13:11) cron2: ps axwwwwwwwwwu :)
(21:13:28) dazo: (default log level is too low when going via NM)
(21:13:36) mattock: dazo: does network-manager use the config file direct=
ly?
(21:13:37) dazo: hehehe
(21:13:40) dazo: nope
(21:14:11) dazo: it imports the config file into some dconf stuff and rec=
reates the config as openvpn command line arguments
(21:14:26) mattock: so things can break in that translation
(21:15:47) dazo: yeah, that's what I need to figure out ... where it fail=
s ... I've spotted a few things where it sets some options to what it bel=
ieves openvpn uses as default values .... like setting --reneg-sec to 0 w=
hen not being activated via the GUI, such stupid things=20
(21:16:30) dazo: will look into all of this NM stuff the coming days and =
co-ordinate with NM developers
(21:17:30) dazo: (we need to ensure 2.4 will be a success when also using=
 NM)
(21:20:52) cron2: I'll tend to postpone beta2 to Friday (official schedul=
e says "today is the day")
(21:21:04) cron2: s/I'll/I'd/
(21:22:48) dazo: I'd like to get the NCP stuff into beta2 ... so either l=
ate tomorrow or not too late on Friday
(21:23:22) syzzer: I'll make sure to send the updated patch today
(21:23:33) cron2: dazo: that's why :)
(21:23:52) syzzer: I think we already agreed on moved Wed->Thu
(21:23:52) dazo: But I think beta1 has been fairly good so far
(21:24:12) syzzer: because the meetings are on Wed now
(21:24:15) cron2: syzzer: we have, but nobody updated the release schedul=
e.  Will do now.
(21:24:38) dazo: well, we never "formalized" it ... but we don't to be th=
at rigid if we have a few days moving window schedule
(21:24:48) mattock: I can't promise full delivery of 2.4_beta2 on Friday
(21:24:53) dazo: don't need to be
(21:25:02) dazo: mattock: when do you have time?
(21:25:16) snair: I've written a patch for DNS6 by service -- could submi=
t by tonight.. would that be too late for 2.4-beta2?=20
(21:25:16) mattock: tomorrow or monday would work
(21:25:28) cron2: snair: you keep amazing me :)
(21:25:34) mattock: possibly Friday, but I have lots of other stuff on th=
at day
(21:26:02) dazo: snair: if cron2 (or someone else) gets it reviewed, it m=
ight pretty much make it .... unless it's too invasive (I don't believe s=
o, though)
(21:26:09) snair: hehe -- I had a draft written a while ago, but ran into=
 some trouble.. and busy at work..
(21:26:17) dazo: :)
(21:26:18) mattock: I _think_ all the release machinery _should_ just wor=
k(tm), so the release should take <3 hours, but there can always be surpr=
ises
(21:26:19) cron2: snair: send it as soon as its ready, I'll see I can hav=
e a look
(21:26:47) cron2: (I have busy day coming up tomorrow, but should be able=
 to sneak in an hour or so)
(21:27:53) snair: cron2: thanks, will do asap (this evening)
(21:30:19) mattock: regarding "must haves" for 2.4.0: "t_client-style "te=
st all windows specific options" testbed on windows"
(21:30:58) mattock: is the powershell test suite "good enough", or do we =
want to add some windows-specific t_client tests?
(21:31:42) dazo: mattock: do we have some overview of which features/conf=
ig setups we test with those powershell scripts?
(21:33:25) mattock: dazo: I run basic ping tests against t_client.sh serv=
ers, plus several (8?) other OpenVPN connections, some against OpenVPN 3 =
servers, some 2.2-based and some 2.3 based
(21:33:25) cron2: mattock: I think we're now testing windows much better =
than we ever did before, so I'd call this "good enough" as far as 2.4 goe=
s - eventually, we might reach the point of automatically testing builds =
on windows as well, which would be even greater :-)
(21:33:30) dazo: (udp/tcp, tun/tap, p2p/p2mp modes, static/pki)
(21:33:37) cron2: but for the time being, I'm happy with what you have ac=
hieved
(21:33:44) cron2: (and I want an OpenVPN 3 server...!)
(21:33:54) mattock: yeah, me too, it saves tons of time and extends the t=
est coverage greatly
(21:34:12) mattock: as opposed to "try on win7 64-bit manually and hope t=
hat it does not break elsewhere"
(21:34:31) cron2: what about the exit-events?  have you merged that alrea=
dy?  lost track of service/gui PRs
(21:34:34) mattock: as for other must haves: openvpnserv2 exit-events is =
basically ready for merge: https://github.com/OpenVPN/openvpnserv2/pull/2
(21:34:36) vpnHelper: Title: Exit event v2 (Using C# calls) by xkjyeah =C2=
=B7 Pull Request #2 =C2=B7 OpenVPN/openvpnserv2 =C2=B7 GitHub (at github.=
com)
(21:34:37) mattock: ah :)
(21:34:42) cron2: lol
(21:34:54) mattock: the only missing piece is squashing a few commits
(21:35:51) dazo: have we documented all our testing in a text matrix?  So=
 we know what we test where? .... we should probably start thinking about=
 some more formalized testing, classify them as Tier 1, 2 or 3
(21:36:19) mattock: we could publish t_client test server setups maybe?
(21:36:41) cron2: ... and enhance them to add challenge-response stuff...
(21:37:09) dazo: I think that cron2's and mine t_client.rc differs a bit =
too ... so that's why we should have some common ground on these things, =
and yeah document what we test :)
(21:37:44) mattock: yeah, my t_client.rc was also different/obsolete for =
quite a while (ran only tests 1 and 2)
(21:37:51) dazo: agreed, challenge-response is an important thing to test=
 .... not commonly used by our users, but still important
(21:38:55) dazo: is this something we could (ab)use Travis to do for us a=
s well?  Run tests on a regular basis and report back to some nice test m=
atrix table?
(21:39:11) mattock: snair: regarding C# events... as xkjyeah has went hid=
ing, perhaps you could create a new PR with the commits squashed?
(21:39:53) mattock: right now Travis only reacts to GitHub events
(21:40:08) mattock: I assume it builds PRs and commits?
(21:40:37) snair: mattock: ok, I'll issue a P with my branch where its al=
ready squashed -- just take a look at how authorship is credited as it no=
w involves one commit with two authors.=20
(21:40:51) snair: P->PR
(21:41:09) dazo: It would be good to have some Tier 1 tests being run on =
github events, then on once or twice a week running a Tier 2 test case (a=
dding more extensive tests not covered in Tier 1) and for releases have e=
ven more odd tests in a Tier 3 setup
(21:42:38) snair: Is there a windows test setup which one could use to te=
st patches before submission ? I develop on Linux so its a pain transferr=
ing the exec to multiple machines (vista/win7/win10) and test.=20
(21:42:52) dazo: (and then cron2 and I could have our mixed blend of "Tie=
r 0" tests running on git-push as today)
(21:44:44) cron2: snair: this is what I do... build on ubuntu 14.04, then=
 copy to my win7 VM for testing.  We want to make this more automated but=
 have not done anything yet (at least, not that I'm aware of).  We discus=
sed using wpkg or chocolatey for "automated software -> win" distribution=
...
(21:45:15) cron2: mattock: did you find time to look into this?
(21:46:41) mattock: cron2: not yet, too busy as snair and chipitsine have=
 been improving openvpnserv2, openvpn-gui and openvpn-build, and with all=
 this 2.4 nonsense :P
(21:47:07) snair: mattock: sorry for too many PRs :)
(21:47:11) mattock: :D
(21:47:46) mattock: well I actually have trouble keeping up with you guys=
 - no way to develop anything of my own, just have to review stuff and bu=
ild test installers
(21:47:51) mattock: but that is good, of course
(21:47:58) mattock: and run various tests
(21:48:15) mattock: I updated the 2.4 release status page: https://commun=
ity.openvpn.net/openvpn/wiki/StatusOfOpenvpn24
(21:48:17) vpnHelper: Title: StatusOfOpenvpn24 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:49:42) mattock: ok so basically we're missing only "poor man's NCP" +=
 "reindent" in the "must have" category, after snair has provided the squ=
ashed PR for openvpnserv2
(21:50:37) mattock: so 2.4_beta2 would contain the "must haves" (except i=
ndenting), and 2.4_rc1 would have as much of the "minor" things as possib=
le?
(21:51:09) dazo: mattock: 2.4_rc1 will primarily be bugfixes ... no new f=
eatures
(21:51:29) dazo: what doesn't get applied from "minor list" will go to 2.=
5
(21:52:36) cron2: what about this one
(21:52:40) cron2: https://community.openvpn.net/openvpn/ticket/719
(21:52:42) vpnHelper: Title: #719 (replace ctime with POSIX time format) =
=E2=80=93 OpenVPN Community (at community.openvpn.net)
(21:52:59) ***cron2 just went throught the "release/2.4" tracs, bumped a =
few to release/2.5
(21:54:17) dazo: cron2: I'd say it's a bit too late to get that one into =
2.4, just due to the risk of breaking setups .... but asap after 2.4 is b=
ranched out, so we get it into the post-2.4 master is good
(21:57:10) mattock: we have quite a few openvpn-gui PRs open, but they do=
n't necessarily need to go hand-in-hand with OpenVPN releases
(21:57:19) mattock: as in "only bugfixes after 2.4_beta2"
(21:58:25) dazo: if we have a beta3 (which we really should avoid), we ca=
n add minor features .... but once we release rc, it should only be fixin=
g what is broken
(21:59:17) mattock: #311 needs to be restarted
(21:59:27) snair: mattock: I think we should get dynamic CR and pkcs11 to=
ken pin into the GUI for 2.4 even if it cant make _beta2?=20
(21:59:38) plaisthos [~arne@...1423.../community/developer/plaisthos] =C3=A8=
 entrato nella stanza.
(21:59:40) plaisthos: oh
(21:59:47) plaisthos: well I am 2h late
(21:59:48) cron2: dazo: for "openvpn" I agree, but GUI releases are somew=
hat independent
(21:59:48) mattock: snair: yes, that was what I was thinking
(21:59:54) mattock: plaisthos: 1h
(21:59:56) cron2: plaisthos: 59 minutes only
(22:00:30) dazo: cron2: Agreed ... I'm primarily focused on OpenVPN ("cor=
e")
(22:01:00) cron2: snair, mattock: so if you can make 2.4 release and the =
changes do not break stuff too badly :-) that should be fine
(22:02:16) mattock: I can probably produce an openvpn-gui.exe that includ=
es all the important openvpn-gui PRs to facilitate testing
(22:02:21) mattock: unless there are merge conflicts
(22:03:08) mattock: three from selva, one from valdikss
(22:03:16) syzzer: *finally*  poor-mans NCP v5 on the list
(22:03:43) mattock: snair: I'd say let's aim to have all the current open=
vpn-gui PRs in 2.4_rc1
(22:03:58) cron2: syzzer: good.  do you have a quick summary for me?
(22:04:25) cron2: ah
(22:04:26) syzzer: I think the "v5" note in the patch itself is a good su=
mmary
(22:04:28) snair: vladikss's patch needs a few fixes before ready for bet=
a...
(22:04:54) syzzer: "move code to where I should have placed it in the fir=
st place"
(22:05:09) cron2: hrhr
(22:05:52) syzzer: and I split off the refactoring, which is now no longe=
r needed for the patch itself (but still worthwhile)
(22:06:07) snair: mattock: yes all current GUI PRs in _rc1 should be work=
able..
(22:06:15) cron2: 2/2 is straightforward (since I reviewed *that* for v4 =
in great detail)
(22:06:26) cron2: wondering about 1/2 now
(22:06:45) syzzer: Hm, 1 newline too in options.h :(
(22:06:49) syzzer: too much
(22:07:08) mattock: mailing list ping pong
(22:07:09) cron2: and I think the prototype in options.h is inside #ifdef=
 ENABLE_OCC
(22:07:32) cron2: (while the function is now *outside*)
(22:07:33) syzzer: cron2: damn, indeed :/  I did fix it in options.c thou=
gh :p
(22:08:14) syzzer: as a side note, shouldn't we just get rid of 'ENABLE_O=
CC' ?
(22:08:55) syzzer: I know plaisthos has a thing for ripping out #ifdefs ;=
)
(22:09:49) cron2: I'm not convinced this is going to work... v5 unconditi=
onally postpones key generation until after PUSH_REQUEST has been receive=
d, but that requires a client to actually do so
(22:10:05) cron2: I think this breaks tls-server<->tls-client p2p setups
(22:10:36) cron2: s/breaks/might break/ - there's a reason we did it that=
 way for the original NCP
(22:10:36) syzzer: that might be true :/
(22:11:24) cron2: the original NCP logic was "if a client sends IV_NCP, i=
t is required to also send a PUSH_REQUEST"
(22:11:29) syzzer: indeed
(22:11:36) syzzer: (was just typing that)
(22:12:35) cron2: but without IV_NCP, users could be doing anything - lik=
e, statically configured clients talking to a p2mp server and not relying=
 on PUSH (thus, not using --client or --pull)
(22:14:06) syzzer: that use case is highly annoying...  but let's see wha=
t I can do.
(22:14:32) cron2: unfortunately that use calls falls squarely into "2.x t=
o 2.4 migration and not breaking people's stuff" :-(
(22:15:01) cron2: btw...
(22:15:04) cron2:        /* Do not regenerate keys if server sends an ext=
ra push request */
(22:15:26) cron2: this comment needs work :-) - the server will never *se=
nd* a push *request*
(22:16:03) cron2: I'm not sure right now if this is server or client side=
 code, but anyway, either "server -> reply" or "client -> request" :)
(22:16:44) syzzer: noted
(22:18:38) cron2: mmmh.
(22:18:48) cron2: now, we're looking at the client options there...
(22:19:00) cron2: multi->remote_has_pull_option_set
(22:19:35) cron2: and then "if IV_NCP or remote_has_pull_option -> postpo=
ne key gen"
(22:19:38) cron2: what about this?
(22:20:19) cron2: (it will break your options_string_extract_option() cod=
e, I think, as that will not catch boolean ones - and I'm not sure if "pu=
ll" is in that list anyway)
(22:21:34) syzzer: no, "pull" is not in the list :(
(22:21:44) cron2: *sigh*
(22:22:06) mattock: still one more round?
(22:22:23) cron2: mattock: we definitely need a v6...
(22:22:48) mattock: ok, what if we try to conclude the meeting before goi=
ng any deeper?
(22:22:54) cron2: syzzer: in that case we could use "if IV_NCP *or* (we n=
eed to do poorman)" instead?
(22:23:14) syzzer: cron2: yes, that's what I was thinking
(22:23:15) cron2: mattock: syzzer and I can move over to -devel for this
(22:23:26) mattock: as in: do we have anything else 2.4_beta2 related tha=
t discuss?
(22:23:28) syzzer: that it only won't work if it wouldn't have worked any=
way
(22:23:56) syzzer: wrt meeting, should we discuss anything about The Grea=
t Refactoring/
(22:24:01) syzzer: uh, Reformatting :p
(22:24:05) mattock: :P
(22:24:20) mattock: maybe that can wait until 2.4_rc1 has been released?
(22:24:28) mattock: if the goal is to reformat before 2.4.0
(22:24:41) dazo:     December 1st - 2.4_rc1 Only really needed and critic=
al bug fixes allowed. This is also the time where we change to a unified =
coding style across the whole source code.=20
(22:24:50) cron2: I agree - let's postpone that to next wednesday
(22:25:24) mattock: ah, there is conflicting info on the status page
(22:26:06) cron2: dazo is da boss
(22:26:07) mattock: conflicting info gone now
(22:26:47) mattock: has the schedule been adjusted for the delays we've h=
ad / will have?
(22:27:01) mattock: or do we think Dec 1st is still reasonable?
(22:27:21) mattock: as a _goal_
(22:27:42) dazo: We should really try to not delay much after Dec 1st for=
 rc1
(22:27:44) cron2: aim for that, at least.  We'll know next wednesday (Nov=
 30)
(22:27:49) dazo: agreed
(22:28:35) dazo: if it slips to Dec 2nd, that's okay ... but that's a fri=
day, which really should be the latest (unless we put in some work hours =
during the weekend)
(22:30:38) snair: weekend is my only work hours :)
(22:31:20) mattock: guys: any suggestions on how to handle multiple autho=
rs in Git commit messages? In particular here: https://github.com/OpenVPN=
/openvpnserv2/pull/6/commits/5af338478caa8f5542a82b8fc42a8c58884806e7
(22:31:22) vpnHelper: Title: Exit event v2 by selvanair =C2=B7 Pull Reque=
st #6 =C2=B7 OpenVPN/openvpnserv2 =C2=B7 GitHub (at github.com)
(22:31:23) cron2: my work ours are "when the kids sleep" or "just ignore =
my customers" :)
(22:32:33) cron2: so - anything else on 2.4?
(22:32:37) mattock: I expect dazo to have a clear and correct answer to t=
he question above?
(22:32:52) mattock: cron2: not afaics, except for the minor detail I aske=
d about a few lines above
(22:33:01) mattock: once that is solved, exit-event will get merged
(22:33:06) cron2: the multiple authors thing?  no idea
(22:33:37) mattock: I don't really mind much if the commit message remain=
s as it is, even though it is a bit messy to look at :P
(22:33:51) cron2: the commits I had that "evolved" over time with multipl=
e people working on them had one author, and the other author(s) listed i=
n the commit text
(22:33:54) dazo: mattock: decide whom will have the --author tag ... and =
credit the other one with "Authored-By: ", "Co-Authored-By:", "Origin-Aut=
hor:" or something similar in the commit message
(22:34:21) cron2: dazo: so there any be only one --author, period?
(22:34:27) mattock: Co-Authored-By sounds reasonable
(22:34:29) dazo: correct
(22:34:44) ***cron2 makes note to use Co-Authored-By in future
(22:35:15) mattock: snair: does "Co-Authored-By" sound good to you?=20
(22:35:36) dazo: the commit message "tag" (Co-Authored-by) isn't a strict=
 regime, just something which describes the intention of the secondary me=
ta-data
(22:35:55) snair: mattock: I couldn't finda way to get two --author into =
one commit. So added the date: and Author: for second asa part of the com=
mit message and two signed-off authors.
(22:36:20) mattock: I'd set --author to the one who has written most of t=
he code in the squashed commit, and mention the other author with "Co-Aut=
hored-By", and strip away xkjyeah's original commit message=20
(22:36:35) dazo: on that note ... We could improve how we tag our Trac ti=
ckets .... I've tried to use: Trac: $NUM  .... or Trac: #$NUM  right befo=
re the Signed-Of-By ... but in the same "block"
(22:36:49) dazo: (makes it easier to parse by script later on if we want =
to do that)
(22:37:03) dazo: mattock: sounds reasonable
(22:37:16) mattock: I can make a suggestion in the PR
(22:37:40) mattock: so 2.3.14 quickly: postpone to post-2.4_beta2 release=
 time I assume?
(22:37:42) dazo: mattock: you're the master of that project ... you can d=
ecide this on the go, no need to be too explicit :)
(22:38:24) dazo: $ git shortlog v2.3.13..gitlab/release/2.3
(22:38:24) dazo: David Sommerseth (1):
(22:38:25) dazo:       Document the --auth-token option
(22:38:25) dazo: Gert Doering (2):
(22:38:25) dazo:       Repair topology subnet on FreeBSD 11
(22:38:26) dazo:       Repair topology subnet on OpenBSD
(22:38:27) dazo: Lev Stipakov (1):
(22:38:29) dazo:       Drop recursively routed packets
(22:38:31) dazo: Selva Nair (1):
(22:38:33) dazo:       Support --block-outside-dns on multiple tunnels
(22:38:36) dazo: anything else we want to see in 2.3.14?
(22:39:16) cron2: there's a number of bugs with milestone 2.3.14, so we c=
ould try to get a few done :)
(22:39:34) dazo: fair enough, then it will be after 2.4_beta2, I'd say
(22:39:37) cron2: or just release 2.3.14 and bump all these to 2.3.15
(22:39:38) cron2: yes
(22:40:00) dazo: From the shortlog, I don't see anything which can't wait=
 a little bit longer
(22:40:14) mattock: snair: I made a suggestion for the commit message her=
e: https://github.com/OpenVPN/openvpnserv2/pull/6
(22:40:16) vpnHelper: Title: Exit event v2 by selvanair =C2=B7 Pull Reque=
st #6 =C2=B7 OpenVPN/openvpnserv2 =C2=B7 GitHub (at github.com)
(22:41:05) ***cron2 doesn't feel like "do anything openvpn-related but NC=
Pv6 and DNS6" tomorrow (lack of time)... and friday won't see me do anyth=
ing openvpn-related before mattock disappears for the weekend - so 2.3.14=
 won't happen this week
(22:41:06) dazo: mattock: if you can manage to get a full name, that'd be=
 even better=20
(22:41:22) mattock: next week
(22:41:28) dazo: ack!
(22:41:48) snair: mattock: OK will fix the PR.=20
(22:41:57) mattock: and the 2.4_beta2 patches will be ready tomorrow even=
ing maybe?
(22:42:02) mattock: snair: excellent, thanks!
(22:42:09) cron2: mattock: that's what I'm aiming for
(22:42:25) dazo: I can roll beta2 as soon as cron2 is happy with NCP and =
DNS6 :)
(22:42:41) mattock: if all is ready by tomorrow evening, I may just be ab=
le to push out 2.4_beta2 on Friday, or Saturday morning at latest
(22:42:54) dazo: sounds good to me
(22:43:41) mattock: ok, so we're done for today then?
(22:43:48) cron2: good
(22:43:50) cron2: yes
(22:43:51) dazo: Tomorrow I'll be "offline" between 15:00-20:00-ish ... b=
ut before and after I'll be ready to jump on it
(22:43:55) mattock: we need our beauty sleep to be able to hack tomorrow
(22:44:07) cron2: I'll go watch TV news new, and then return to have a lo=
ok if patches came in
(22:44:20) dazo: :)
(22:44:45) cron2: who and where constructs the occ option string...!?
(22:45:09) dazo: occ is still a mystery to me
(22:45:24) syzzer: there's a function options_string(), iirc
(22:45:55) mattock: ok, I need to head out too
(22:46:02) mattock: good night guys!
(22:46:27) syzzer: good night!
(22:46:56) mattock: ok, next meeting next wednesday?
(22:47:06) cron2: yep
(22:47:12) mattock: ok, noting that in the summary
(22:47:30) dazo: goodie, c'ya!
(22:47:38) ***dazo need to dive into some code again
(22:48:40) snair: g'nite.

--------------1ACB101913021A4427529BE3--

