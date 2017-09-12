From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <b775444a-aaf6-4e93-5f9c-338ec105eaee@...515...>
 <88a33ea9-ef60-0378-b39e-ffb5c945e4ae@...515...>
Message-ID: <2aa343af-c8bb-ce25-82bf-b092c8cd8556@...515...>
Date: Tue, 12 Sep 2017 22:50:05 +0300
MIME-Version: 1.0
In-Reply-To: <88a33ea9-ef60-0378-b39e-ffb5c945e4ae@...515...>
Content-Type: multipart/mixed; boundary="------------DD5D81F4E5637F8DBB61BBAF"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of today's (Wed,
 12th Sep 2017) community meeting
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
--------------DD5D81F4E5637F8DBB61BBAF
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of today's IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 12th Sep 2017
Time: 20:00 CET (19:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2017-09-12>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

chipitsine, cron2, dazo, mattock ordex and syzzer participated in this
meeting.

Discussed tls-crypt-v2. Ordex has implemented this on the OpenVPN 3
side. Syzzer is still working on it on the OpenVPN 2 side.

--

Discussed having a regular meeting schedule again. Agreed that having a
one-hour meeting every Wednesday at 19:00 CEST makes sense. We will
start the meetings next week (20th September).

--

Discussed the upcoming 2.4.4 release. We have enough commits for a
maintenance release, but there is one security fix in the pipeline, as
well as a fix to the NSI installer. It was agreed that the security fix
should have a CVE. The release date was set to 25th September.

Some features will be deprecated in the upcoming release. Because of
this dazo and mattock will work with OpenVPN Tech PR to make an official
press release in addition to warning about the deprecation in the
release mails and Trac:

<https://community.openvpn.net/openvpn/wiki/DeprecatedOptions>

Also discussed the release process. It was agreed that things could be
made simpler and more community-friendly. There are only a few steps
that really need to be done by an OpenVPN Tech employee. We will start
improving the situation after 2.4.4 is out.

Also noted that the Windows installers no longer modify system PATH.
This change breaks easy-rsa, but that is being worked around. It was
agreed that putting a notice to INSTALL-win32.txt (which pops up after
install) makes sense. Having a "Changes" screen in the installer would
also be useful.

--

Briefly discussed dazo's lz4 v2 patch. Cron2 promised to review it in
the next few days.

--

Buildmaster did not work, although it seemed to be alive. Mattock
restarted it and it looks ok now. Mattock will grant dazo access to the
buildmaster server for the purpose of kicking buildmaster in the butt as
necessary.

--=20

Discussed having more fine-grained signalling from OpenVPN to OpenVPN
GUI. The lack of clear signals from OpenVPN to OpenVPN GUI has been a
rather common problem:

<https://github.com/OpenVPN/openvpn-gui/issues/168#issuecomment-305243166>
<https://github.com/OpenVPN/openvpn-gui/issues/9>
<https://github.com/OpenVPN/openvpn-gui/issues/183>

This problem is probably not limited to OpenVPN GUI (Windows), but also
affects other GUI's like NetworkManager. It was agreed that the best
approach is that Selva, mattock and others involved on the Windows side
come up with a PoC or "RFC" of how this issue could be tackled ...
OpenVPN core will then be modified if necessary.

---

Full chatlog has been attached to this email.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



--------------DD5D81F4E5637F8DBB61BBAF
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2017-09-12.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2017-09-12.txt"

(21:02:02) L'argomento di #openvpn-meeting =C3=A8: Meeting 2017-01-04 190=
0 UTC: Agenda at https://community.openvpn.net/openvpn/wiki/Topics-2017-0=
1-04
(21:02:02) L'argomento per #openvpn-meeting =C3=A8 stato impostato da dan=
hunsaker!sid145261@...1423.../corp/danhunsaker a 21:20:15 su 04/01/2017
(21:02:10) mattock: good evening
(21:02:45) mattock: I believe it is meeting time, except that dazo and cr=
on2_ will join in late
(21:07:47) ordex: I thought we agreed on postponing to 20:30 ?
(21:07:58) ordex: because I think also syzzer wonted to join later as wel=
l
(21:08:40) mattock: yeah, I came in early in case there were "non-standar=
d" people here :P
(21:09:45) ordex: :D
(21:09:50) ordex: am I non-standard?
(21:09:53) ordex: I appreciate that :P
(21:10:20) ordex: the topic it's quite old i think
(21:10:22) ordex: but not important
(21:10:35) ordex: btw, how was this done in the past? since I joined we o=
nly had random meeting here and there
(21:10:38) mattock: no, you're standard
(21:10:42) ordex: did you normally have one per week?
(21:10:44) ordex: :P
(21:10:47) mattock: yes, at some point
(21:10:57) mattock: that was a reasonable arrangement, because everyone k=
new the time and weekday
(21:11:19) mattock: every two weeks is worse, as then you have to remembe=
r "was there a meeting last week"?
(21:11:38) ordex: right
(21:11:52) ordex: and the time was normally 7pm CET ?
(21:11:53) mattock: it is also easy to slip into not having meetings at a=
ll
(21:12:00) mattock: yes, I think so
(21:12:28) ***syzzer present too
(21:12:29) mattock: all the previous meetings are listed here: https://co=
mmunity.openvpn.net/openvpn/wiki/IrcMeetings
(21:12:31) vpnHelper: Title: IrcMeetings =E2=80=93 OpenVPN Community (at =
community.openvpn.net)
(21:12:32) syzzer: though sleepy...
(21:12:40) ordex: :)
(21:12:54) mattock: 2010 and 2011 were meeting-heavy
(21:13:00) syzzer: meeting was usally at "20:00 in Norway/Germany/Netherl=
ands"
(21:13:05) mattock: but that was when we integrated lots of community stu=
ff into OpenVPN
(21:13:16) ordex: I see
(21:13:24) mattock: 2015 and 2016 we also had quite a few
(21:13:30) ordex: well, having some fixed time where we know we all have =
each other attention is not bad
(21:13:30) mattock: probably related to OpenVPN 2.4
(21:13:35) ordex: I see
(21:13:35) mattock: definitely
(21:15:01) ordex: syzzer: since you are here, maybe you could quickly men=
tion what is the current status of tls-crypt-v2? unless we want to wait f=
or the others before starting anything
(21:15:49) syzzer: ordex: yeah
(21:16:28) syzzer: past few weeks were crazy busy.  this week is too.
(21:16:44) syzzer: let me see what's in my git
(21:16:49) ordex: hehe
(21:21:16) syzzer: ah, right.  I wanted to do a couple of things.  First,=
 review my own code, check if it still makes sense.  I already did a pass=
 of that, but recall there were still some minor things I wasn't happy ab=
out.  And secondly, the patches that clean up a lot of what's in misc.c n=
eed a bit more love and thinking about location and naming.
(21:22:04) ordex: goed
(21:22:32) ordex: about the proposed changes, those have been addressed? =
(I can't remember what they were actually other than option naming and si=
milar)
(21:22:42) syzzer: I did manage to churn out my pkcs11 refactoring, which=
 I have also been dragging with because I wasn't really happy with it for=
 a while
(21:23:08) syzzer: ordex: yeah - I added the 'type' field in the metadata=
, and changed the server key format
(21:23:26) syzzer: I can push my current branch if that helps you
(21:23:34) ordex: cool
(21:23:38) ordex: yeah that'll be nice
(21:23:38) syzzer: at least the external interfaces should be right
(21:23:48) ordex: my second question actually was: if and how I can help
(21:24:04) ***dazo is here .... at least somewhat physically :)
(21:24:11) ordex: yeah I can give it a run and test against my implementa=
tion on ovpn3 (which needs some tweaking too now)
(21:24:16) ordex: aloha :)
(21:24:34) dazo: hey :)
(21:25:01) dazo: ordex: [OT] I've just seen your PMs ... I'll respond to =
them after the meeting
(21:25:19) ordex: dazo: thanks! :)
(21:25:41) mattock: hi guys!
(21:25:53) mattock: cron2_: not here yet though
(21:26:02) ordex ha scelto come argomento: Meeting 2017-09-12 18:00 UTC: =
Agenda at https://community.openvpn.net/openvpn/wiki/Topics-2017-09-12
(21:26:40) syzzer: ordex: https://github.com/syzzer/openvpn/tree/tls-cryp=
t-v2-preview3
(21:26:41) vpnHelper: Title: GitHub - syzzer/openvpn at tls-crypt-v2-prev=
iew3 (at github.com)
(21:27:02) cron2_: here!
(21:27:10) dazo: syzzer: James, Samuli, Francis and I discussed TLS crypt=
 a couple of weeks ago ... To quickly recap: James was not too keen on ex=
posing tls-crypt-v1 very much, as he sees it v2 is what tls-crypt should =
be - while understanding that v1 have some advantages in small scale envi=
ronments
(21:27:12) ordex: syzzer: thanks!
(21:28:17) syzzer: dazo: well openvpn3 is still quite the domain of the c=
ompany, so I'll leave that upto you guys :)
(21:28:20) dazo: syzzer: ordex have done quite some work to implement bot=
h v1 and v2 into openvpn3 ... but what will be exposed to end users is no=
t really clear yet
(21:29:20) dazo: but it is important that openvpn 2.x and openvpn3 are co=
mpatible .... and in the short term perspective, there's lots of focus ge=
tting the openvpn3 clients out first, then getting the server code ready =
for the community
(21:29:36) syzzer: yeah, ordex has also really helped me with moving my i=
mplemenation forward
(21:29:55) dazo: so the community will primarily use openvpn 2.x on the s=
erver side in the beginning
(21:29:56) ordex: we just need to get through the last mile :)
(21:30:05) syzzer: dazo: well tls-crypt v1 is already in 2.4
(21:30:48) syzzer: or have I lost track completely...?
(21:31:04) dazo: yeah, that's what I also highlighted to james ... and he=
 wasn't overly thrilled about it, but that's how it is ... so now we need=
 to ensure that we get something which will be good for both versions
(21:31:24) dazo: nope, tls-crypt-v1 is one of the big things in 2.4.0
(21:31:56) mattock: I believe one of the 2.4.0 audits found a problem in =
the implementation
(21:31:59) dazo: but we need to think things through in regards to option=
s
(21:32:06) syzzer: (I do like v1, because it's a drop-in replacement for =
tls-auth.)
(21:32:08) dazo: mattock: "problem", to be more exact
(21:32:41) mattock: yeah
(21:33:32) syzzer: but, now that we have everyone, let's start with the s=
hort-term stuff
(21:33:39) dazo: +1
(21:33:41) ordex: yap
(21:33:50) syzzer: like deciding on what to release and when
(21:34:35) mattock: I'll dig up the agenda
(21:34:41) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
7-09-12
(21:34:42) vpnHelper: Title: Topics-2017-09-12 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:35:01) mattock: 1. Restore a somewhat reliable meeting schedule=20
(21:35:05) mattock: agreed
(21:35:08) dazo: we have one patch on sec-list which needs to be reviewed=
 ... do we need a CVE for it?  If we do (I'm leaning towards yes), it wil=
l be a low impact, low urgency one
(21:35:09) cron2_: brr, who put complicated stuff there (3.)
(21:35:33) mattock: cron2_: that has come up several times in the openvpn=
-gui project
(21:35:41) mattock: but we don't have to reach a conclusion today
(21:36:18) mattock: do we start from "next 2.4.x release" or "meeting sch=
edule"?
(21:36:33) cron2_: 1. schedule, that can be fairly quick, I think
(21:36:45) mattock: sounds good
(21:36:46) dazo: mattock: to be honest .... I think that's something whic=
h can be best solved among the windows people ... unless something needs =
to be clarified or enhanced in the "core" openvpn
(21:36:46) ordex: yap, point 1.
(21:36:59) cron2_: syzzer and I can almost never do daytime, so we're stu=
ck at "european evening"
(21:37:03) syzzer: for usual weeks, Mon/Tue is tricky for me.  Wed/Thu/Fr=
i is better
(21:37:08) mattock: dazo: I will comment on your comment in topic #2 :)
(21:37:16) dazo: :)
(21:37:16) cron2_: dazo: it is, because "core" does not tell" gui" what i=
s happening, I think  (and that's #4, btw)
(21:37:32) mattock: topic #3
(21:37:42) cron2_: mattock: reload :)
(21:37:53) mattock: I definitely need to, but now I can't :P
(21:37:57) ordex: I'd avoid Fri
(21:38:03) dazo: +1
(21:38:06) ***cron2_ can make every evening, though tuesday only late-ish=
 (like today, 20:30 local time)
(21:38:08) ordex: just because that's my Friday night :D
(21:38:18) ordex: (deep night)
(21:38:32) cron2_: ordex: so you're right back from partying, isn't that =
perfect?
(21:38:44) ordex: :D it depends if you want to hear my stories or not :P
(21:38:49) cron2_: dazo, mattock, which days work for you?
(21:38:58) cron2_: (evenings)
(21:38:59) mattock: what about Wed? We have another internal meeting with=
 James at 18:00-19:00 CEST on Wednesdays
(21:39:12) mattock: we could probably lure him to join the community meet=
ing more easily after that
(21:39:23) syzzer: this sounds useful
(21:39:27) ordex: yap
(21:39:53) mattock: we're not entirely sure if that James meeting will be=
 weekly, because for ordex the time is not very convenient (midnight), bu=
t that's what we have now
(21:39:53) dazo: tue, wed and thu can work for me with some planning ....=
 but our family schedule is unpredictable until end of December (we're ac=
tually moving temporarily to Czech Republic - full family - for three mon=
ths in a couple of weeks)
(21:40:38) cron2_: wednesday evening is good for me.  19:00 CEST is a bit=
 early (I'll have to leave for a few minutes at 19:45 to say goodnight to=
 the kids :) ) but it will work out
(21:40:55) dazo: +1
(21:41:00) dazo: same situation here too :)
(21:41:12) ordex: we could start with that and see how it goes
(21:41:18) mattock: CEST 20:00?
(21:41:36) ordex: didn't we say right after james' meeting?
(21:41:41) ordex: so 19:00 CEST
(21:41:41) syzzer: earlier is probably better for ordex
(21:41:41) cron2_: 19:00 is good-for-james, I understood
(21:41:50) cron2_: I can make it work, so 19:00 is good
(21:41:56) cron2_: syzzer: ?
(21:41:56) mattock: ok, that's better for me
(21:42:04) mattock: and for getting James onboard when necessary
(21:42:10) ordex: mattock: can are we sure we can make james' meeting las=
t 1h only ?
(21:42:18) ordex: -can
(21:42:31) ordex: other than this concern, I think 19:00 is good
(21:42:35) mattock: ordex: initially that may be challenging, but if we h=
ave a meeting every week I think 1 hour is reasonable
(21:42:36) cron2_: we can make the community meeting start "at 1900 or wh=
en the other one is done" - we're not that many folks
(21:42:38) ordex: (and yes, a bit earlier is better for me :P)
(21:42:39) syzzer: cron2_: 19:00 instead of 20:00 means one hour earlier =
sleeping for ordex I think
(21:42:56) syzzer: 19:00 is okay for me
(21:42:56) ordex: yeah
(21:42:58) ordex: :D
(21:42:59) cron2_: good
(21:43:03) dazo: With weekly meetings capped at 1 hour, we can allow ours=
elves to draw the line and continue next week
(21:43:04) cron2_: weekly or bi-weekly?
(21:43:13) mattock: I would say weekly
(21:43:13) ordex: dazo: right
(21:43:15) dazo: (as long as the list doesn't grow faster)
(21:43:20) ordex: yeah weekly sounds good
(21:43:22) mattock: but keep it to 1 hour
(21:43:28) ordex: yap
(21:43:31) cron2_: ok
(21:43:40) mattock: there will probably be weeks when we're done in 30 mi=
ns if we keep up doing weekly
(21:43:48) syzzer: ok, let's try that.  makes it also less a problem to o=
ccasionally have to mis sone
(21:43:53) ***cron2_ is amazed at mattock's optimism :-)
(21:44:01) mattock: yeah, I was born like this :P
(21:44:11) ordex: :D
(21:44:14) cron2_: meeting schedules have the habit of growing stuff like=
 "can we do the VLAN patches today?" :-)
(21:44:16) mattock: we have had at least _one_ meeting that was 30-40 min=
s
(21:44:20) mattock: so it _is_ doable :P
(21:44:24) dazo: cron2_: mattock didn't give an estimate _when_ that coul=
d happen ;-)
(21:44:26) cron2_: mattock: was that the one where nobody showed up?
(21:44:33) dazo: lol
(21:44:43) mattock: cron2_: we had people then, but we were quick for wha=
tever reason
(21:45:00) mattock: anyways, next topic?
(21:45:05) cron2_: good, so "weekly, wednesday, 19:00 CEST / 20:00 EEST" =
is it
(21:45:11) mattock: +1
(21:45:18) mattock: 2. Next 2.4.x release=20
(21:45:22) cron2_: (and we start not tomorrow but next week :) )
(21:45:37) ordex: hehe
(21:45:44) dazo: heh
(21:45:59) ordex: personally I think we have enough patches piled up for =
a new maint release?
(21:46:11) ordex: one question is if we want to include the latest securi=
ty fix from syzzer=20
(21:46:46) cron2_: we need to merge your proto_af fix (ACK but not in), a=
nd syzzer's fix
(21:46:49) dazo: I think we should add that one ... and it would be good =
to agree on at least killing the lz4 compile warning (patch is on list al=
ready)
(21:46:57) mattock: we should also merge the installer fix
(21:46:59) cron2_: and we need to *test* that stuff (which brings us to #=
3)
(21:47:02) cron2_: yes
(21:47:15) syzzer: I think we should include the secuirty fix.  I don't l=
ike sitting on that stuff, even if it's rather minor.
(21:47:15) dazo: yeah, installer-fix++
(21:47:32) dazo: should I start the CVE process for it?
(21:47:44) dazo: it's a low-impact, low-urgency one though
(21:47:45) syzzer: dazo: you have my vote
(21:47:54) cron2_: dazo: I was about to say "CVE sounds reasonable" - spe=
cific circumstances, but *then* it is bad -> so, yes please
(21:48:09) dazo: okay, I'll do that later today
(21:48:24) cron2_: shall we aim for thursday, sep 28 with the release?
(21:48:49) cron2_: (arbitrary date which gives a bit of time to do the ho=
usekeeping missing - CVE, buildmaster, ...)
(21:49:00) dazo: I don't know how much I will be available after the 27th=
, but I can ensure the git trees are in shape
(21:49:22) cron2_: I'm around until end of October :)
(21:49:24) dazo: (27th sept to 1 oct is really unpredictable)
(21:49:26) chipitsine: during several recent releases there was a mess wi=
th signing
(21:49:46) mattock: cron2_: ah yes the buildmaster - something came up an=
d I forgot, but have a look after the meeting
(21:49:52) chipitsine: should we try some test release just for test that=
 ?
(21:50:07) syzzer: I'm almost absent between Sep 27 and Oct 21
(21:50:15) mattock: chipitsine: you're referring to the GPG signatures?
(21:50:19) cron2_: chipitsine: I think we found out where we went wrong -=
 dazo and I will not sign the stuff, just pass a proper git tree to matto=
ck
(21:50:25) mattock: +1
(21:50:28) dazo: chipitsine: we actually have done that, via private chan=
nels .... but it's the cloudflare caching and uploading of wrong files wh=
ich have caused havoc
(21:50:35) cron2_: the confusion came because we did signed tarballs, and=
 mattock's script did *another* set
(21:51:07) dazo: we need to simplify and have a single release script cro=
n2_, mattock and I can rotate on running though
(21:51:14) cron2_: so we had two "valid" set of tarballs, with valid sign=
atures, but *different* - and then we had caching annoyance
(21:51:25) ordex: dazo: +!
(21:51:26) ordex: +1
(21:51:28) dazo: it's silly that mattock needs to unpack and re-pack ever=
ything for a proper release
(21:51:34) cron2_: dazo: yes and no - this won't happen any time soon, as=
 I have no access to the download servers
(21:51:47) cron2_: mattock isn't *unpacking* anything, he has scripts tha=
t build from git
(21:51:53) cron2_: (including signed tarballs)
(21:52:05) dazo: cron2_: that's part of the "simplify" step ;-)
(21:52:12) mattock: dazo: you're pretty much the only one who could go th=
rough the full release process
(21:52:22) mattock: it involves plenty of steps (check internal JIRA tick=
et)
(21:52:35) cron2_: so, FWIW, for the time being I'm happy to hand over a =
signed git tag to github/gitlab/sf, and let mattock (or dazo) take it fro=
m there
(21:53:02) mattock: yeah, that works
(21:53:11) dazo: for this release, that is definitely the plan ... but we=
 _do_ need to move towards a more community friendly release process
(21:53:15) mattock: dazo and I need to go through the internal release pr=
ocess so that I'm not the only one who can do it
(21:53:22) dazo: +1
(21:53:23) cron2_: if we can simplify the "put .tar.gz + sig online" we c=
an include it in the release building script then I *could* do it (... ri=
ght)
(21:53:47) ordex: we should also think a day when some tasks have to be h=
anded over. the simpler the better
(21:53:47) cron2_: so, Sep 27 or earlier?  if yes, when?
(21:54:20) ***ordex is not involved in the release process - your call
(21:54:51) mattock: we could definite have a release script which does mo=
st of the release tasks, with the exception of putting files to servers a=
nd editing www.openvpn.net webpages
(21:54:54) dazo: either that ... or that we have something which does thi=
ngs automatically by doing "something" which contains a PGP signed git ta=
g, which does the rest automatically ("something" - send an e-mail, log i=
nto a specific web service, whatever)
(21:55:11) syzzer: mattock: you're crucial in this process.  what works f=
or you?
(21:55:14) chipitsine: ci ?
(21:55:24) dazo: CI is not suitable for release management
(21:55:45) mattock: we already produce "releases" using the windows build=
slave (~CI)
(21:55:54) mattock: and we should extend that at some point to Debian pac=
kages
(21:56:03) mattock: but it's a slightly different topic
(21:56:08) dazo: yeah
(21:56:19) syzzer: focus.  dates!  :-p
(21:56:22) mattock: syzzer: right now I would just like to have a Git tag=

(21:56:35) cron2_: good enough
(21:56:36) mattock: as for dates: I don't have any preferences
(21:56:40) ***cron2_ can do that :-)
(21:56:52) ***dazo too :)
(21:56:56) cron2_: mattock: any particular day that's convenient or not f=
or you?
(21:57:07) dazo: I suggest have the git tree tagged latest Sept 25
(21:57:12) dazo: but!
(21:57:23) mattock: 25th would be fine
(21:57:35) dazo: we want to have the OpenVPN Tech PR machinery involved t=
his time .... as we're going to announce deprecation of features
(21:57:42) dazo: (we have a wiki page for which)
(21:57:58) dazo: and we should have about 1 week time for the PR machiner=
y to roll too
(21:58:11) mattock: yeah, PR wheels turn slowly
(21:58:22) dazo: https://community.openvpn.net/openvpn/wiki/DeprecatedOpt=
ions
(21:58:25) vpnHelper: Title: DeprecatedOptions =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:58:40) dazo: We need to get some attention that we're doing some opti=
on house cleaning :)
(21:59:41) syzzer: yeah.  explicitly mention it in the release mails, and=
 mail package maintainers?
(22:00:01) dazo: syzzer: that too ... but we're actually trying to reach =
even broader too
(22:00:24) dazo: mattock: we can alert Nineveh already with the date ... =
and we'll need to start thinking about the wording asap
(22:00:37) dazo: someone from the community side who wants to be involved=
 in that process?
(22:00:57) syzzer: (I'm in ordex' timezone Sep 24-28, so response might b=
e unpredictable)
(22:01:29) mattock: dazo: yep
(22:01:50) mattock: syzzer: ok, should not be an issue I think
(22:01:55) cron2_: syzzer: snowboarding again?  :)
(22:02:06) syzzer: dazo: I can try to review, but my schedule is very tig=
ht
(22:02:17) syzzer: cron2_: https://ches.iacr.org/2017/
(22:02:19) vpnHelper: Title: CHES 2017 (at ches.iacr.org)
(22:02:36) ordex: oh cool
(22:02:39) dazo: syzzer: We'll send you an e-mail with details ... we nee=
d to have this ready by end of next week
(22:02:53) ordex: how much is the burden syzzer ?
(22:02:56) syzzer: okay, next week I should be able to find some hours
(22:03:41) dazo: yeah, we need to be fast on this process, to ensure Nine=
veh have time to get the PR machinery rolling
(22:04:08) syzzer: ordex: just a lot of work stuff that must be finished =
before the conference and my vacation
(22:04:50) ordex: syzzer: I was talking about the ticket price :P but see=
ms to be too deep into cryptography for non-expert
(22:05:16) syzzer: ordex: ah. yeah, ches is not very cheap and quite spec=
ialized
(22:06:21) dazo: " GIFT: A Small Present" <<< smells like a new flaw bein=
g announced
(22:08:06) dazo: The paper from djb and his "team" also sounds dangerous
(22:08:15) dazo: "Sliding Right into Disaster: Left-to-Right Sliding Wind=
ows Leak"
(22:08:51) mattock: oh one thing: openvpn installers no longer modify the=
 PATH on Windows
(22:09:00) mattock: this might be worth of a deprecation notice or someth=
ing
(22:09:06) mattock: I'm sure a subset of people depend on this
(22:09:13) mattock: plus it breaks easy-rsa, which is being fixed
(22:09:36) dazo: mattock: does the windows installer have a Changes.rst e=
quivalent?
(22:09:50) mattock: INSTALL-win32.txt which comes up right after install
(22:10:03) mattock: so that's a good place to put the notice (where nobod=
y will read it)
(22:10:11) mattock: although upgrades are not affected
(22:10:16) mattock: only new installs
(22:10:24) mattock: I mean: installs on a fresh Windows PC
(22:10:30) dazo: yeah
(22:10:55) mattock: the PATH thing was the only reason why we had to use =
patched NSIS
(22:11:22) dazo: I  think that's worthy a notice on the Windows side ....=
 perhaps you should have a condensed list of "surprising new behaviours" =
inside the installer ... which will tempt people to open the readme?
(22:12:32) mattock: hmm, maybe a "Changes" screen or something
(22:12:40) mattock: would be fairly easy to implement
(22:12:44) dazo: yeah
(22:12:49) mattock: I will make a note of this
(22:12:59) mattock: not sure if it'll make it to 2.4.4 though, but we'll =
see
(22:13:05) dazo: if people don't read it, that's not our problem ... as l=
ong as it at some point "was in their face" :)
(22:14:20) mattock: +1
(22:14:25) mattock: are we done with 2.4.4?
(22:15:13) cron2_: have we agreed on dates?  tag on sep 25, release machi=
nery started right after?
(22:15:14) dazo: cron2_: any comments on my lz4 v2 patch, checking lz4 ve=
rsions .... instead of the #ifdef wrapper function?
(22:15:21) cron2_: dazo: no
(22:15:56) cron2_: (because that's not on the agenda and I am too tired t=
o go reading and thinking about it now :-) - but I'll see that you get an=
 answer in the next days)
(22:15:59) dazo: ordex had one comment on a silly whitespace, which is ea=
sy to fix at commit time
(22:16:20) dazo: thx! that's a good one to get in ... as then we're basic=
ally clean on most warnings
(22:16:27) dazo: (compiler warnings)
(22:16:42) ordex: fire in da hole!
(22:16:43) ordex: :)
(22:16:53) cron2_: which reminds me that I wanted to build an NTLM proxy =
test bed... meh
(22:17:00) ordex: hehe
(22:17:06) dazo: there might be a few in the unit tests ... but that's to=
 be resolved later on
(22:17:08) ordex: "meh" is the right answer to NTLM
(22:17:13) dazo: lol
(22:17:36) cron2_: "either we support it, then we need to be able to test=
 it, or we drop it"
(22:18:00) cron2_: (and then people wonder why I'm not overwhelmed when t=
hey bring up super-special niche patch sets... :) )
(22:18:09) dazo: :)
(22:18:16) syzzer: cron2_: https://www.mail-archive.com/openvpn-devel@...1484...=
ts.sourceforge.net/msg14066.html O-)
(22:18:17) vpnHelper: Title: [Openvpn-devel] [PATCH v2] Allow changing ci=
pher from a ccd file (at www.mail-archive.com)
(22:18:39) cron2_: syzzer: dang.  ("not on the agenda!")
(22:18:48) ordex: what's the next thing on the agenda?
(22:18:50) dazo: that was a surprisingly little patch
(22:18:52) ordex: so cron2_ can spend some time on it :D
(22:19:13) mattock: ordex: +1 for next topic
(22:19:19) mattock: "More fine-grained signalling from OpenVPN to OpenVPN=
 GUI"
(22:19:27) mattock: which is probably too difficult this late in the even=
ing
(22:19:36) ordex: mattock: how does the UI talk to the core? management i=
nterface ?
(22:19:40) mattock: yes
(22:19:40) cron2_: the patch is small, but with all these per-client conf=
ig-changes-on-the-go, there's nasty interactions between operating modes =
(pull clients, non-pull clients, ...)
(22:19:43) dazo: what's the TL;DR summary of what is wrong?
(22:19:45) cron2_: mattock: #3 is "buildmaster" :)
(22:19:57) mattock: ah, somebody edited the agenda
(22:20:02) dazo: #3 is FAR more important
(22:20:14) mattock: let me explain #4 and then go fix #3 :)
(22:20:31) ***cron2_ is all ears :)
(22:20:38) mattock: so the problem is that openvpn-gui can't always deter=
mine if the everything the connection needs succeeded
(22:20:50) mattock: for example route addition may have failed and openvp=
n-gui has no way of knowing
(22:20:58) mattock: except by some hacky log parsing, of course
(22:21:24) mattock: it would be nice to if the gui would have more fine-g=
rained knowledge from openvpn
(22:21:43) mattock: this comes up quite often actually, in various contex=
ts
(22:22:00) mattock: any suggestions would be welcome while I fix the buil=
dmaster
(22:22:25) ordex: sounds like instead of just logging we should send some=
thing back too?
(22:22:27) cron2_: that's actually a multifaceted nastiness
(22:22:44) cron2_: one thing is that "ipv4 route installation fails" is n=
ot considered an error (while it is for ipv6)
(22:23:19) chipitsine: under certain curcamstances it is an error
(22:23:27) cron2_: and then it's not clear what we want it to be - like "=
server pushes 8 routes, 7 can be installed and 1 fails - is that a 'succe=
ss' or 'fail'"?
(22:23:28) dazo: mattock: I don't recall the interactive service integrat=
ion, but IIRC, that's the piece of code which does the route stuff  .... =
 so that service should be able to detect if the route was "installed" or=
 not ... and IIRC, there is a link between the GUI and that service
(22:23:29) chipitsine: we are hit by that error pretty often
(22:23:48) chipitsine: typical way is
(22:24:06) cron2_: dazo: *openvpn* knows whether route succeeds or not, b=
ut does not consider ipv4 route installation failure to be "an error"
(22:24:06) chipitsine: 1) interactive service is stopped (for some strang=
e reason)
(22:24:20) chipitsine: 2) openvpn-gui starts openvpn directly
(22:24:30) chipitsine: 3) no UAC, no routes
(22:24:35) cron2_: (which makes sense, to some extent, as people might ha=
ve conflicting local routes so not all pushed routes can beinstalled)
(22:24:37) ordex: cron2_: can't we communicate that the single route fail=
ed? rather than "reporting a real error"
(22:25:09) cron2_: ordex: we could, if we decided so and change the manag=
ement interface protocol to convey more information
(22:25:13) dazo: yeah, I agree with cron2_ .... openvpn cannot know if a =
missing route is a minor failure or a critical failure .... that's a knob=
 which the GUI needs to take care of
(22:25:20) chipitsine: as for conflicting routes, there's a better way wi=
th routes priority
(22:25:33) ordex: dazo: right, but we need to ship the fine grained infor=
mation out first
(22:25:40) ordex: cron2_: yup, that's the point I think
(22:25:47) cron2_: the GUI cannot *know* either - like, you are pushing 1=
92.168.1.0/24 to your clients, and one client happens to be *in* 192.168.=
1.0/24, because that wifi is using the same network...
(22:26:05) dazo: ordex: yeah, the failure with details of what failed
(22:26:13) cron2_: it might be a failure if you really really need to rea=
ch *that* remote network - or not, if it's something not interesting to y=
ou right now
(22:26:20) syzzer: even just a message "Some routes could not be added, s=
ee the log for details." would really help I guess.
(22:26:21) mattock: I believe buildmaster now works
(22:26:25) cron2_: (like, the server pushes 20 routes, and you're interes=
ted in something else)
(22:26:40) mattock: syzzer: +1
(22:26:43) ordex: cron2_: I'd avoid to try understanding if it is somethi=
ng bad or not. I'd rather just pass the info up to the UI
(22:26:57) dazo: ordex++
(22:26:59) cron2_: ordex: this is not now user interface stuff works
(22:27:20) ordex: cron2_: the UI has to decide what to do with that, but =
not the core, I guess?
(22:27:35) cron2_: either you present something that is not "it worked! a=
ll green!" or you don't - users do not really distinguish between "some w=
arning" or "major warning" or "error".  They see a popup, and call suppor=
t...
(22:28:18) cron2_: orex: sure, but since "we" maintain the openvpn gui as=
 well, it's not as easy as just pushing it over to "the gui folks have to=
 make that decision" :)
(22:28:25) ordex: well, a "warning" (i.e. yellow light) might pop up sayi=
ng "something did not work well, you might experience issues"
(22:28:31) ordex: :D hehe
(22:28:33) ordex: right!
(22:28:46) mattock: what if we as "we" (that is, Selva) what he thinks
(22:28:47) mattock: ?
(22:28:52) cron2_: I, personally, want all information I can get, with as=
 much useful detail is possible :-)
(22:29:09) mattock: but route addition is just one of the issues
(22:29:15) cron2_: but for my users, the filtering needs to be really dow=
n to "what you are trying to do is going to work, or not" :-/
(22:29:16) syzzer: cron2_: you always run at --verb 10? :-p
(22:29:23) cron2_: "useful"
(22:29:28) syzzer: :')
(22:29:36) mattock: I can talk about this in more detail with Selva to fi=
gure out what info the gui would benefit most from
(22:29:42) cron2_: syzzer: --verb 10 is just this crypto noise, who needs=
 that :)
(22:29:50) ordex: cron2_: mh, that would really need the core or the UI t=
o understand the semantic of the encountered problem
(22:29:52) cron2_: but yeah, I run my client with --verb 4...
(22:30:02) ordex: that'll be nice, but ..
(22:30:03) ordex: :P
(22:30:29) cron2_: ordex: yeah.  First steps first: make sure we actually=
 notice problems (and not silently ignore them), and then communicate the=
m back.
(22:30:44) ordex: cron2_: agreed
(22:30:51) dazo: mattock: I think perhaps the best approach is that Selva=
, you and others involved on the Windows side come up with a PoC or "RFC"=
 of how this issue could be tackled ... and if that involves the "core" (=
basically most of us here) can then see if we see better ways to do it fr=
om from the core side
(22:30:52) ordex: then some logic can be built later on top of the export=
ed info
(22:31:01) syzzer: so how does the gui now determine "green lights on!"?
(22:31:08) dazo: if "routing" is just one possible issue, it is hard, at =
least for me, to imagine the other issues
(22:31:29) mattock: dazo: sounds reasonable
(22:31:33) ordex: by the way: this problem is probably there with *EVERY*=
 UI we have that interacts via management interface. even NM
(22:31:36) chipitsine: from the gui point of view, it might be done via s=
ome variable
(22:31:46) chipitsine: for example, we have "setenv CLIENT_CERT 0" in con=
figs
(22:31:58) chipitsine: that tells ios to ignore some things
(22:32:06) cron2_: dazo: from what I see, routing is the worst offender
(22:32:19) chipitsine: so, we can pass or not to pass variables to gui ho=
w to treat route errors
(22:32:23) mattock: we can figure out the technical solution once we know=
 what info we need
(22:32:55) dazo: cron2_: agreed ... but, as I said, I'm hearing "this bla=
ck box doesn't work" ... and one scenario ... I don't have full understan=
ding of that black box to imagine what else might need to be improved
(22:32:59) syzzer: ok, "mattock will fix it" works for me :-p
(22:33:10) ordex: :D
(22:33:24) dazo: so if a PoC/"RFC" can enlighten us ... we can work towar=
ds something which is useful on more platforms
(22:33:34) mattock: +
(22:33:35) mattock: 1
(22:33:46) dazo: ordex is right, NetworkManager and Tunnelblick can also =
benefit from this ... if done right
(22:33:48) cron2_: dazo: not sure if there is much else that can be "look=
s like success but actually is fail".  Compression mismatch might be one
(22:33:53) cron2_: dazo: +1
(22:34:13) ordex: cron2_: right. we get this funny message in the log but=
 the connection continue
(22:34:14) ordex: s
(22:34:45) ordex: we also have options mismatching that is reported in th=
e log, but probably not signaled (is it really useful?)
(22:34:59) dazo: "Does OpenVPN configus need an -Werror equivalent" ;-)
(22:35:40) ordex: hehe
(22:35:42) cron2_: option mismatching "if you want to see it" is visible =
with --opt-verify
(22:35:53) ordex: ok
(22:36:05) cron2_: but for typical *gui* environments, this is really mor=
e "client-to-server, and server pushes things anyway"
(22:36:12) ordex: ok
(22:36:16) mattock: ok, but let us move forward
(22:36:17) cron2_: so --opt-verify gets more in the way
(22:36:42) chipitsine: what is opt-verify ?
(22:36:47) dazo: !man
(22:37:06) mattock: "Clients that connect with options that are incompati=
ble with those of the server will be disconnected."
(22:37:18) ordex: wow we got the man here
(22:37:27) ordex: so next steps for this? asking Selva?
(22:37:27) mattock: almost automatic I might add
(22:37:31) mattock: yes
(22:37:32) cron2_: won't work here :) - but yeah, "it's an option documen=
ted in the man page" :-) - which uses OCC to check option compatibility o=
n both sides of the connection, and disconnect if it is considered "incom=
patible"
(22:38:24) ordex: could be useful to detect and disconnect upon mismatchi=
ng compression
(22:38:45) cron2_: ordex: we have peer-info IV_ stuff and pushable compre=
ssion for that nwowadays
(22:39:01) chipitsine: recently we encountered compression mismatch
(22:39:22) ordex: cron2_: sur,e but if explicitly configured differently,=
 it can still mismatch no?
(22:39:23) cron2_: mattock: #4 covered, I forced a build and things look =
better now
(22:39:25) chipitsine: I think, client should obey pushed compression fro=
m server rather than local config
(22:39:27) ordex: anyway, no need to discuss compresison now
(22:39:35) mattock: +1
(22:39:42) mattock: we're about 1 hour 10 minutes in already
(22:39:45) chipitsine: yeah, it's not in agenda
(22:39:55) cron2_: ordex: it can, and you can use --opt-verify to catch t=
hat, but it will interfere with "I could push the right config"
(22:40:12) ordex: mh ok. will check that better
(22:40:14) cron2_: chipitsine: it does, for everything that *is* pushable=

(22:40:25) cron2_: (and if the server pushes, and the client asks, which =
is both optional)
(22:40:53) syzzer: mattock: I think we're done with the agenda - ordex an=
d I already did a tls-crypt-v2 status update (TL;DR: syzzer needs to fini=
sh his sh*t)
(22:41:02) mattock: syzzer: yeah, I was about to ask
(22:41:02) chipitsine: we had "comp-lzo yes" on one side and "comp-lzo no=
" on the other side
(22:41:19) chipitsine: nothing worked actually
(22:41:33) chipitsine: it _looked_ like working, but ....
(22:41:54) cron2_: chipitsine: it will log the config mismatch, even if i=
t does not abort (unless one side is run with --disable-occ)
(22:42:01) dazo: yeah, that's an artefact of --compress mismatch
(22:42:09) cron2_: mattock: what was the problem with the buildmaster?
(22:42:16) dazo: chipitsine: btw ... get --compress into your fingers, --=
comp-lzo is deprecated ;-)
(22:42:23) mattock: no idea - it was running, but in a limbo
(22:42:24) ordex: syzzer: to reiterate my previous question: anything I c=
an help with at the moment on tls-crypt-v2 ?
(22:42:30) mattock: restarting the service fixed it
(22:42:47) mattock: the buildmaster application itself probably tripped o=
n its feet
(22:42:47) chipitsine: I'm going to replace it with lz4 soon
(22:43:00) cron2_: funny.  anyway, what's the best way to reach you these=
 days, if I see it hanging again?
(22:43:23) syzzer: ordex: the commits that start with "tls-crypt-v2:" sho=
uld be as good as final, so any comments are welcome
(22:43:29) mattock: cron2: email
(22:43:36) cron2_: ok
(22:43:46) syzzer: ordex: but what would also be very much appreciated is=
 review of the pkcs11 patch set
(22:43:48) mattock: unfortunately monit did not catch this buildmaster pr=
oblem as the service was up
(22:44:00) ordex: syzzer: okok :)
(22:44:11) dazo: mattock: is the buildmaster on the community or corp vpn=
?
(22:44:13) ordex: syzzer: that is a bit out of my scope, but it's a good =
excuse to learn more about that part of the code
(22:44:17) mattock: community VPN
(22:44:19) cron2_: dazo: community
(22:44:25) mattock: although we could make it accessible through both
(22:44:44) cron2_: so I can see if it seems to be doing something, but ca=
n't kick it if needed (not that I had any idea *how* to reasonably kick i=
t :) )
(22:44:55) syzzer: ordex: yeah, pkcs11 is not very popular to review :-p
(22:45:02) dazo: mattock: that'd be good (but a pure convenience for me) =
=2E.. but if I can get login access and know which buttons to hit, I can =
do that job too .... let's share that workload
(22:45:12) syzzer: but it *should* become easier after this patch set
(22:45:37) mattock: dazo: sounds reasonable - we can setup a user on that=
 server for you
(22:45:44) ordex: syzzer: I am sure[tm]
(22:45:44) dazo: mattock: thx!
(22:45:47) ordex: ;)
(22:45:48) mattock: then you can give it the boot
(22:45:54) mattock: "systemctl restart buildmaster"
(22:46:11) syzzer: dazo, cron2_: btw, any objections to the concept of th=
e pkcs11 patch I sent yesterday?
(22:46:13) dazo: syzzer: how does the mbed TLS handle PKCS#11 operations?=
  a set of callback functions?
(22:46:27) ***dazo have just noticed the patches, not had time to really =
look at it
(22:46:43) cron2_: syzzer: I have no idea what this is about
(22:46:48) syzzer: dazo: yes.  you need to give mbed a function pointer t=
o something it can call to create an RSA sig
(22:46:52) dazo: mattock: ahh, cool .... systemctl have become a close fr=
iend of mine ;-)
(22:47:08) dazo: syzzer: cool ... can we manage something similar for ope=
nssl too? ;-)
(22:47:14) mattock: dazo: tbh it is just a thin wrapper around old init s=
cripts in buildmaster's case
(22:47:33) mattock: anyways, I'd need to split now - can we call it a day=
?
(22:47:39) ***dazo smells debian :)
(22:47:40) mattock: we have another meeting next week anyways
(22:47:42) syzzer: cron2_: tl;dr:  I sent a patch set to make us no longe=
r depend on the mbed TLS pkcs11 module
(22:47:44) mattock: indeed, debian
(22:47:46) dazo: yeah, I think we're done with the official part
(22:47:51) cron2_: mattock: good night
(22:47:55) mattock: good night guys!
(22:48:01) syzzer: good night!
(22:48:02) mattock: I will send the summary immediately

--------------DD5D81F4E5637F8DBB61BBAF--

