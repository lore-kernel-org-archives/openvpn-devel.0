References: <574BF4FF.9090502@...515...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <f70c6738-cfeb-7c1a-bfe3-ae8b745b4ef5@...515...>
Date: Mon, 30 May 2016 23:00:53 +0300
MIME-Version: 1.0
In-Reply-To: <574BF4FF.9090502@...515...>
Content-Type: multipart/mixed; boundary="------------26717991BD8859A8511F99FE"
Subject: [Openvpn-devel] Summary of the IRC meeting on 30th May 2016
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
--------------26717991BD8859A8511F99FE
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of today's IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Monday 30th May 2016
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2016-05-30>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock and syzzer participated in this meeting.

---

Discussed the OpenVPN 2.4 release. Created a wiki page with a high-level=20
overview of its status:

<https://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn24>

--=20

Discussed the "Protect the client from accepting arbitrary options=20
pushed by the server" feature request, for which there is now a PR in=20
GitHub:

<https://community.openvpn.net/openvpn/ticket/682>
<https://github.com/OpenVPN/openvpn/pull/50/>

The general approach of the PR made sense to all, and cron2 gave the=20
patch ACK, so that the author can send it to the mailing list.

--

Went through most of the other GitHub pull requests, closing those that=20
are fixed and figuring out who should work on which. Some patches based=20
on GitHub PRs were also sent to the mailing list during the meeting.

--

Full chatlog has been attached to this email.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



--------------26717991BD8859A8511F99FE
Content-Type: text/plain; charset=UTF-8;
	name="openvpn_irc_meeting_chatlog_2016-05-30.txt"
Content-Disposition: attachment;
	filename="openvpn_irc_meeting_chatlog_2016-05-30.txt"
Content-Transfer-Encoding: quoted-printable

(21:01:34) L'argomento di #openvpn-meeting =C3=A8: Meeting 2015-12-15 190=
0 UTC: Agenda at https://community.openvpn.net/openvpn/wiki/Topics-2015-1=
2-14
(21:01:34) Topic for #openvpn-meeting set by ecrist!~ecrist@...2144.../contr=
ibutor/openvpn.ecrist at 20:40:43 on 14/12/2015
(21:01:41) cron2_: uh, yes :)
(21:02:00) mattock: hi all!
(21:02:35) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
6-05-30
(21:02:37) vpnHelper: Title: Topics-2016-05-30 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:03:54) cron2_ =C3=A8 ora conosciuto come cron2
(21:05:10) cron2: lev__: are you here?
(21:07:14) mattock: is syzzer here today?
(21:07:15) cron2: shall we wait for dazo?
(21:07:23) mattock: we can wait a bit yes
(21:07:30) cron2: 19:58  * syzzer goes and find a beer
(21:07:36) mattock: hmm :P
(21:11:29) syzzer: yes, I'm here
(21:11:39) cron2: how's the beer
(21:12:00) syzzer: did not find a beer though, the news with images of th=
e floods in germany caught my attention
(21:13:01) dazo [~dazo@...1423.../community/developer/dazo] =C3=A8 entrato n=
ella stanza.
(21:13:13) syzzer: ah, dazo moved over here :)
(21:13:15) dazo: oh, so we're back to a meeting channel
(21:13:28) cron2: syzzer: bit shitstorm is coming up... weather analysts =
warned in advance, and media did not bother to relay that (so people *cou=
ld* have been somewhat prepared)
(21:13:40) cron2: good, let's start :)
(21:14:17) mattock: hi
(21:14:24) cron2: dazo: one of the meetings earlier this year was heavily=
 disturbed by "user traffic" in -devel...=20
(21:14:49) mattock: so lev does not seem to be here right now
(21:14:58) mattock: perhaps we can postpone the hackathon discussion a bi=
t?
(21:15:53) cron2: yeah, not that much to discuss, mostly updating informa=
tion - but without lev, the point is a bit moot
(21:16:01) dazo: +1
(21:16:13) cron2: 2.4, then
(21:17:38) mattock: yes
(21:17:45) syzzer: yes, so, I hope to spend some time on cipher negotiati=
on next week
(21:17:45) mattock: "what is left"
(21:18:02) cron2: timeout patch, cipher negotiation, bugs (trac)
(21:18:09) dazo: I do really want the query-user stuff to hit 2.4=20
(21:18:21) mattock: interactive service + openvpn-gui is pretty much comp=
lete, even though Selva is constantly improving things
(21:18:26) dazo: I'm in the middle of completing patchset v4
(21:18:30) cron2: dazo: right, that one as well
(21:18:34) mattock: I need to integrate ovpnserv2 into the installer
(21:19:04) cron2: maybe we need to put up a list somewhere, so we can act=
ually check regularily (and update) instead of making the list again and =
again...?
(21:19:08) syzzer: and if I can get it done in time, I'd like 'tls-crypt'=
 to go in, but that's not a blocker
(21:19:49) syzzer: cron2: that sounds a lot more efficient
(21:20:37) cron2: mattock: can you create a page?  I'm notoriously bad in=
 finding proper places where to put stuff
(21:21:20) mattock: yeah, let's add a page
(21:21:29) mattock: or maybe we can just create tickets to trac
(21:21:37) mattock: and link existing ones to milestone 2.4
(21:21:42) mattock: 2.4-alpha1 or whatever
(21:21:54) cron2: there is way too much in trac...
(21:22:07) cron2: let's have the big ones (and who is working on it) in a=
 extra page
(21:22:11) mattock: ok
(21:23:51) mattock: it will be here: https://community.openvpn.net/openvp=
n/wiki/StatusOfOpenvpn24
(21:24:19) cron2: are you busy creating it?
(21:26:37) mattock: yes
(21:27:32) ***cron2 goes add the few points we have noted above
(21:28:37) mattock: ok, here https://community.openvpn.net/openvpn/wiki/S=
tatusOfOpenvpn24
(21:28:39) vpnHelper: Title: StatusOfOpenvpn24 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:30:28) cron2: meh, conflict
(21:31:01) mattock: yeah, just copy and paste your stuff to a safe place =
and readd them
(21:31:05) mattock: I've stopped editing
(21:33:42) cron2: done
(21:34:10) mattock: ah, nice, I was about to suggest adding "big stuff al=
ready done" section
(21:34:17) mattock: to show we _have_ had some progress
(21:34:52) syzzer: shouldn't 'dual stack' be in there too?
(21:35:27) cron2: done
(21:35:40) cron2: anything else I've missed?
(21:36:13) syzzer: maybe https://community.openvpn.net/openvpn/ticket/675
(21:36:14) vpnHelper: Title: #675 (tls_digest alternative with stronger h=
ash) =E2=80=93 OpenVPN Community (at community.openvpn.net)
(21:36:14) mattock: I made a small edit (+openvpn-gui integration)
(21:37:42) cron2: syzzer: I think this is general trac work... but not a =
show stopper
(21:37:57) cron2: if you think it's a must have, please put it into the l=
ist
(21:38:07) ***cron2 is not editing right now
(21:38:54) mattock: I'd try to minimize bloating the 2.4-alpha1 release
(21:39:03) mattock: we can fix stuff in the later alpha releases if neces=
sary
(21:39:09) mattock: as long as all the big stuff is in there
(21:39:31) cron2: so anything *big* missing?
(21:39:34) syzzer: no, the digest stuff is not a showstopper
(21:40:09) syzzer: don't think so
(21:40:19) mattock: am I correct in that we've actually already done ever=
ything we originally planned for 2.4?
(21:40:29) mattock: originally being "a few years back"
(21:40:51) cron2: AEAD cipher always was in the list, and it needs the pe=
r-client cipher stuff to be truly useful
(21:41:03) cron2: but besides that, 2.4 is indeed getting close
(21:41:14) cron2: \o/
(21:41:35) mattock: yeah, let's just get the thing out of the door so tha=
t people don't have to use the Git version
(21:42:10) cron2: so... next bikeshed :-) - trac #682 / PR 50
(21:42:42) mattock: moving from 2.4 to other topics?
(21:43:09) cron2: yep
(21:44:37) cron2: this is a feature request that came via openvpn-users -=
 I think it makes sense (but there are lots of different ways to go about=
 it), debbie10t is flaming me because "useless bloat"...
(21:44:40) mattock: ah, a colourful discussion in #682 (https://community=
.openvpn.net/openvpn/ticket/682)
(21:44:42) vpnHelper: Title: #682 (Protect the client from accepting arbi=
trary options pushed by the server) =E2=80=93 OpenVPN Community (at commu=
nity.openvpn.net)
(21:44:52) cron2: ... and Selva just went and implemented it :-) (in PR50=
)
(21:45:28) mattock: https://github.com/OpenVPN/openvpn/pull/50
(21:45:30) vpnHelper: Title: Add an option to filter options received fro=
m server by selvanair =C2=B7 Pull Request #50 =C2=B7 OpenVPN/openvpn =C2=B7=
 GitHub (at github.com)
(21:45:38) cron2: right
(21:46:27) mattock: I recall there being two patches (pull and push)
(21:46:29) mattock: right?
(21:46:34) cron2: my idea was to use an external script to do the filteri=
ng (=3D maximum flexibility, but won't work for android client for exampl=
e), selva builds an internal filter list (push-accept accept/refuse)
(21:47:00) cron2: mattock: this is independent stuff - the push-remove is=
 "I run the server and I know that one client cannot take a given option,=
 so I remove it"
(21:47:22) mattock: ah, so for ccds?
(21:47:39) cron2: #682/PR50 is "I run a client, and the server is run by =
someone else, and to avoid a malicious server sending me ifconfig/route s=
tuff I cannot accept, the client needs to filter"
(21:47:45) cron2: mattock: yes, push-remove is ccd/ stuff
(21:47:50) mattock: yeah, I see
(21:47:50) cron2: (and already merged)
(21:48:12) mattock: anything controversion in PR#50?
(21:48:16) mattock: controversial
(21:48:30) mattock: except debbie10t's apparent misunderstanding of the u=
se-case
(21:48:47) cron2: well, he's done this in a totally different way than I =
thought :-) - so I wonder what you are thinking?
(21:49:02) mattock: I think the basic idea makes sense
(21:49:21) cron2: script or internal filter?
(21:49:36) mattock: if you have a server or a desktop connected to tons o=
f OpenVPN connections then filtering is quite useful
(21:49:48) mattock: so scripts exclude android and ios?
(21:49:54) cron2: yes
(21:50:08) dazo: I think this approach is far more feasible than scriptin=
g, as it is supported out of the box on all platforms ... and the syntax =
would be identical on all of them
(21:50:52) dazo: scripting can far more flexible, though ... but this use=
 case, I think this is as far as we can and should go for now
(21:50:54) cron2: I agree with that - just pointing out the counter argum=
ent again, script is more powerful (it could do math, or remember stuff)
(21:51:24) dazo: agreed
(21:51:39) ***cron2 has no really strong opinion, so we can go forward wi=
th reviewing Selva's patch in PR50 then, and go for "built-in filter"
(21:51:43) syzzer: why would scripts not work on android?  can't openvpn =
execute scripts there?
(21:52:18) cron2: I'm not sure there is a shell environment, or file syst=
em, etc. you could easily access - but maybe ask plaisthos whether I'm wr=
ong
(21:52:23) dazo: depends on how the script hook is implemented .... if th=
e script hook is expected to do 'ip/ifconfig/route' stuff, it won't fly
(21:52:33) syzzer: (anyone up for inline scipts in config files? ;) )
(21:53:01) dazo: ...... oh dear ;-)
(21:53:02) cron2: nah, I was thinking about "openvpn feeds push options o=
ne-by-one on stdin to the script, and the script outputs the result to a =
temp file"
(21:53:16) dazo: syzzer: inline script pushed by server ;-)
(21:53:33) cron2: so options that are removed are just not echoed, option=
s that needs modification get modified, and inacceptable options get exit=
(1)'ed
(21:53:42) syzzer: hm, it's been a while since I did Android development,=
 but I recall being able to execute scripts
(21:55:11) cron2: so, what do we want?  we should not do both (*that* wou=
ld truly be code bloat)
(21:56:00) dazo: only half joking now ... but what about LUA support for =
more advanced config support?=20
(21:56:18) syzzer: I think PR50 suffices, and the patch looks simple and =
contained enough
(21:56:20) mattock: do you think the internal filter implementation is of=
 acceptable size?
(21:56:35) mattock: I guess the performance impact is pretty minimal
(21:57:02) ***cron2 did not look at the code at all yet, but it shouldn't=
 be big - smaller than LUA, and most likely similar to script (if not sma=
ller)
(21:57:22) mattock: plus an internal filter would be way more convinient =
for users than a script-based approach
(21:57:28) cron2: performance should be neglible - run a few strcmp() on =
pushed options, but nothing in the packet path
(21:57:33) mattock: plus the patch does not add #ifdefs :P
(21:57:38) cron2: good
(21:57:47) cron2: let's go and review PR#50 then :)
(21:57:54) mattock: +1
(21:58:19) dazo: From a quick glance, it looks fairly small and nice ... =
of course, it's limited to 64 filter rules, but that should probably be s=
ufficient enough
(21:58:30) ***cron2 points out that he doesn't get to do *any* coding any=
more, if people just steal his tickets...!
(21:58:47) cron2: dazo: if people need more than 64 filter lines, they ar=
e doing funny things :)
(21:58:55) dazo: But it needs to be tested what happens once you exceed t=
hat limit
(21:59:32) cron2: right -> review needed (without having looked at the co=
de, I'd assume that Selva-code would log a warning and go ahead, not doin=
g anyhting bad)
(21:59:50) dazo: cron2: true ... but there have been some complaints alre=
ady that the push limitations for routes is already too low for some Chin=
ese anti-gfw VPN solutions :)
(22:00:17) cron2: dazo: d12fk fixed that by making it truly dynamic :)
(22:00:17) dazo: (point is: people do funny things already)
(22:00:31) dazo: ahh, haven't caught that ;)
(22:00:44) dazo: (or just forgotten)
(22:00:58) cron2: well, let's move forward with this, and it is really no=
t sufficient, we can make it dynamic
(22:01:08) dazo: +1
(22:02:32) mattock: can someone give an ACK and mention that on the PR?
(22:03:20) ***cron2 does
(22:04:14) dazo: I can take care of PR#28/Trac#581
(22:04:19) dazo: (systemd stuff)
(22:04:50) mattock: great!
(22:05:10) cron2: done
(22:06:01) cron2: mattock: you're already on #51, right?
(22:06:18) mattock: yes
(22:06:26) cron2: #49 is (naturally) mine, but right now waiting for Stef=
an to send a new version
(22:06:31) mattock: let's see if the PR author fixes it, or whether I hav=
e to
(22:07:04) cron2: #46 is what is holding up 2.3.12, to point that out aga=
in... (plus the lack of responses to syzzer's crypto warn patch set)
(22:07:25) cron2: so how can we progress with #46?
(22:08:43) mattock: looking at #46
(22:09:04) cron2: it's a partial revert of a James-patch, and I have no i=
dea what that is doing
(22:09:38) ***dazo closed PR#9
(22:09:53) cron2: hah, cool :)
(22:10:05) cron2: dazo: I think you implemented this, right? :)
(22:10:33) cron2: #1 is part of plaisthos' timeout jumbo patch
(22:11:35) cron2: #11 is done
(22:13:33) dazo: yeah, PR#9 is actually the same discussion we had on -de=
vel ml ... where I swapped system() -> execve()
(22:14:15) mattock: oh, that old
(22:14:40) cron2: #13 is mine... I commented on it in September, was igno=
red.
(22:15:22) cron2: commenting again, will take on this topic for 2.5 ("dif=
ferent routing tables inside/outside, etc.") - fairly complex topic, and =
highly system dependent
(22:15:54) dazo: to bad it is a useful feature ;-)
(22:16:13) cron2: it is, but the patch in #13 was not doing it right
(22:16:33) syzzer: cron2: #14 is yours too - you already applied the fix
(22:16:37) cron2: I think it's actually a topic for the hackathon...
(22:17:10) cron2: syzzer: whee, so I can just close #14 :)
(22:17:45) mattock: how about closing #13?
(22:18:10) mattock: the author is unresponsive and there are merge confli=
cts
(22:18:21) cron2: mattock: nah, leave it open as reminder that this is a =
needed feature
(22:18:42) mattock: we can revisit this strategy when we have 500 reminde=
rs in GitHub :P
(22:19:10) cron2: but now we're down to 17, of which the top 7 or so are =
actively being worked at
(22:19:38) mattock: yeah, not a big deal right now
(22:20:09) cron2: #34 - has that been acked yet?
(22:21:10) cron2: ah, no... http://article.gmane.org/gmane.network.openvp=
n.devel/11682
(22:21:11) vpnHelper: Title: Gmane -- PATCH Update contrib pull resolv co=
nf client.up for no DOMAIN (at article.gmane.org)
(22:21:23) mattock: hmm, was this sent to the list: https://github.com/Op=
enVPN/openvpn/pull/25
(22:21:23) cron2: syzzer: looking at you :)
(22:21:24) vpnHelper: Title: Add link to bug tracker by leonklingele =C2=B7=
 Pull Request #25 =C2=B7 OpenVPN/openvpn =C2=B7 GitHub (at github.com)
(22:21:39) mattock: if not, I'll send a patch right away
(22:22:00) cron2: please
(22:22:16) syzzer: mattock: I was about to comment that, but I'll leave i=
t to you :)
(22:22:40) mattock: ok
(22:23:54) ***cron2 has a few more things to merge that already got an AC=
K
(22:25:29) dazo: Just quickly looked at #34 ... are we sure that one does=
 the right thing?  1) $((i + 1)), isn't that bashism?  script is /bin/sh =
 .... 2)  you either get 'domain' or 'search' in /etc/resolv.conf ... are=
n't those two different things?
(22:26:29) cron2: I've been told that $((i + 1)) is POSIX, but let me tes=
t
(22:27:18) cron2: it works with FreeBSD's /bin/sh, which claims to be "PO=
SIX with very few extentions"
(22:27:37) cron2: (and with ksh)
(22:27:47) dazo: okay, then my memory was wrong on that part :)
(22:28:03) ***dazo can take PR#22 as well (systemd again)
(22:28:05) cron2: as far as domain/search - they are independent, in theo=
ry...
(22:28:19) cron2: cool :)
(22:28:35) cron2: well, #34 - need to look at the patch again
(22:28:54) cron2: (and see if the domain/search stuff is being worsened, =
or "as before")
(22:30:16) cron2: dazo: at least from the comment, the domain/search bit =
was there already before
(22:30:23) cron2: >  # if we get one DOMAIN, that becomes "domain" in res=
olv.conf
(22:30:23) cron2: >  # if we get multiple DOMAINS, those become "search" =
lines in resolv.conf
(22:30:26) cron2: > +# if we get no DOMAINS, then don't use either domain=
 or search.
(22:31:03) cron2: so we could argue the point of not setting domain if th=
ere is more than one, but it's outside the scope of #34
(22:31:23) dazo: ahh, right!
(22:31:45) syzzer: yes, that :)  I had to look at it again, but I recall =
that this change made perfect sense
(22:33:44) cron2: I tend to call it a day for today (I'm tired and we've =
made good progress so far)
(22:33:56) cron2: lots of resulting work in merging the stuff for me in t=
he next few days :)
(22:34:07) dazo: agreed ... cron2 have you done anything with the pending=
 ACKs on the ML?
(22:34:39) cron2: dazo: everything in my tree has already been pushed, so=
 "nothing pending"
(22:34:54) cron2: if you merge stuff, do not forget 2.3 :-)
(22:35:13) dazo: okay, I can take a quick scan through the ML to see what=
's lingering there and apply some of it this evening
(22:35:21) ***dazo will try to remember 2.3 :)
(22:35:42) cron2: sounds good
(22:35:48) syzzer: please also don't forget the discussion on security@
(22:36:05) cron2: syzzer: yeah, this is 2.3.12 material and I'm unhappy t=
hat there is no response
(22:36:54) mattock: has the WPAD patch been reviewed yet?
(22:37:03) mattock: merging that might mitigate the WPAD issue a bit
(22:37:37) cron2: I'm not sure it helps - you'd need to know what to push=
 so it actually overrides a malicious WPAD, but does not create a non-wor=
king browser
(22:38:11) cron2: the patch itself should see a review, right :-)
(22:38:23) mattock: hmm, README is using tabs instead of spaces
(22:38:26) mattock: is that intentional?
(22:38:37) cron2: mmmh
(22:38:45) mattock: e.g. "./configure" line
(22:39:07) mattock: in fact all the build lines and the http://openvpn.ne=
t line
(22:39:08) vpnHelper: Title: OpenVPN - Open Source VPN (at openvpn.net)
(22:39:11) cron2: I might be able to poke a few contacts to figure out wh=
ether there is a way to turn off wpad while openvpn runs
(22:40:15) syzzer: mattock: re the tarball link, maybe use https://openvp=
n.net/index.php/download/community-downloads.html
(22:40:17) vpnHelper: Title: Community Downloads (at openvpn.net)
(22:40:25) syzzer: people still get lost if they need to go through openv=
pn.net...
(22:40:35) dazo: for a potential WPAD fix, we should probably get a CVE
(22:41:24) mattock: syzzer: that is probably going to change sooner than =
later
(22:41:31) syzzer: ah, ok
(22:41:38) cron2: dazo: we could, but I still maintain that this is not *=
our* problem, but total windows brokenness
(22:42:06) mattock: do you know what happens if you point the WPAD URL to=
 a fake place?
(22:42:14) cron2: but if we find a way to turn off WPAD handling while op=
envpn is active (and we do not set our own WPAD option), it would indeed =
be better
(22:42:16) mattock: does Windows go looking for other addresses or stop t=
here?
(22:42:21) cron2: no idea
(22:42:24) syzzer: I guess there should be a CVE for it, just not ours.  =
It would make sense to reference that though.
(22:42:35) cron2: syzzer: +1
(22:42:46) mattock: do the guys who reported it have a CVE?
(22:43:43) mattock: oops, I apparently used my personal email for the sig=
ned-of-by... but I guess that's fine for patches this trivial
(22:44:33) mattock: maybe I'll fix that regardless
(22:45:15) cron2: so... tried a few contacts, let's see if they find some=
one at microsoft...
(22:50:15) mattock: uh, what incantation is used to get [PATCHv2] to the =
subject line?
(22:50:23) mattock: I recall doing that a few times
(22:50:30) cron2: --annotate
(22:51:30) mattock: ah
(22:55:06) mattock: ok, sent
(22:55:13) mattock: shall we call this a day?
(22:55:20) mattock: too late here to think straight
(22:55:31) cron2: +1
(22:55:34) cron2: goodnight :)
(22:55:38) mattock: good night!
(22:55:45) mattock: (and the vlan patchset was postponed again)

--------------26717991BD8859A8511F99FE--

