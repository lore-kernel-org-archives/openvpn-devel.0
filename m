From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <20151228100404.176a540305d85a7d3e2a2107@...515...>
Message-ID: <5731B557.4070100@...515...>
Date: Tue, 10 May 2016 13:17:59 +0300
MIME-Version: 1.0
In-Reply-To: <20151228100404.176a540305d85a7d3e2a2107@...515...>
Content-Type: multipart/mixed; boundary="------------090301050307070105050102"
Subject: [Openvpn-devel] Summary of the IRC meeting on 9th May 2016
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090301050307070105050102
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of today's IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Monday 9th May 2016
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2016-05-09>

The next meeting (patch review sprint) has been scheduled to two weeks=20
from now.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, lev, mattock and syzzer participated in this meeting.

---

Discussed OpenVPN 2.3.11 release. Resolved a few tickets in Trac and=20
moved those which could not be quickly fixed to milestone 2.3.12, then=20
tagged the release. (Mattock made the release the day after the meeting)

--

Discussed the upcoming OpenVPN developer hackthon. The current plan is=20
to organize it in Helsinki (Finland) in late September. Lev will get=20
confirmation for this within a week or so.

--

Discussed the OpenVPN 2.4-alpha1 release. There are currently only two=20
blockers:

- registerdns-in-the-iservice (patch on list, needs review)
- pushable ciphers (syzzer is working on this)

--

Full chatlog has been attached to this email.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------090301050307070105050102
Content-Type: text/plain; charset=UTF-8;
	name="openvpn_irc_meeting_chatlog_2016-05-09.txt"
Content-Disposition: attachment;
	filename="openvpn_irc_meeting_chatlog_2016-05-09.txt"
Content-Transfer-Encoding: quoted-printable

(21:01:58) syzzer: good evening :)
(21:02:16) mattock: meeting time
(21:02:19) mattock: hi syzzer!
(21:04:14) syzzer: wow, 1st of Feb was the previous meeting
(21:04:28) mattock: yeah, a _long_ while ago
(21:05:45) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
6-05-09
(21:05:47) vpnHelper: Title: Topics-2016-05-09 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:06:47) mattock: I tried to direct-poke lev about the hackathon
(21:09:15) cron2: so, what did he say?
(21:09:37) mattock: nothing, he has not answered yet
(21:09:44) mattock: anyways, we can start with the other stuff
(21:09:52) mattock: so 2.3.11
(21:10:12) mattock: what goes in?
(21:10:38) syzzer: yes, that is the question :)
(21:10:48) mattock: opinions? :P
(21:11:09) syzzer: James' --port-share patches
(21:11:34) cron2: this is the most important one, and then timely release
(21:12:23) cron2: what about port-share-max?
(21:12:25) syzzer: but I think those need someone with a Mac to create a =
'deprecate ancient OSX' patch
(21:13:04) syzzer: if we do the above, I don't think we don't actually ne=
ed --port-share-max
(21:13:11) syzzer: -don't
(21:13:12) cron2: the patch itself will be fine, but it will keep using t=
he select() branch on MacOS - which, if you do not intend to provide a he=
avy-duty server, is not a big issue
(21:13:16) mattock: git shortlog v2.3.10...HEAD gives quite a few small p=
atches
(21:13:46) mattock: (when branch is release/2.3)
(21:14:01) syzzer: I think we should just stop using select() on OSX too
(21:14:14) cron2: syzzer: with your FD_SET hardening, the worst thing tha=
t could happen on MacOS is "assert in fd_set", which is annoying, but bet=
ter than now
(21:14:26) syzzer: cron2: yes, definitely
(21:14:36) syzzer: so we could even postpone polishing
(21:14:50) cron2: I agree with "stop using select()", I just wanted to po=
int out that while important, it's a somewhat independent issue
(21:15:22) lev__ [~lev@...2135...] =C3=A8 entrato nella stanza.
(21:15:32) lev__: hi there
(21:15:35) cron2: ho!
(21:15:46) syzzer: yes, you're right.  so let's check trac and decide if =
we can do a release :)\
(21:15:48) syzzer: hi lev :)
(21:16:02) mattock: hi lev!
(21:18:27) lev__: about hackathon - I got preliminary approval from my co=
mpany to have it in our premises, but no exact dates yet
(21:19:07) mattock: excellent!
(21:19:10) cron2: cool
(21:19:10) mattock: so Helsinki, right?
(21:19:59) syzzer: yes, nice!
(21:20:17) lev__: if you are willing to fly to Oulu it would be much easi=
er :) we could have larger premises and sauna
(21:20:37) ***syzzer checks flights
(21:20:40) cron2: where is Oulu?
(21:20:46) lev__: it is 55min flight from Hki
(21:21:29) cron2: but no direct flights from anywhere else, right?
(21:21:32) lev__: and accomocation is cheaper. Oulu is 600km to the north=
 from Hki
(21:22:03) lev__: there are seasonal flights to/from Antalya
(21:22:08) lev__: but no pressure
(21:22:44) cron2: just thinking about options... MUC->OUL is about 4:40 w=
ith 1:15 stopover in HEL, but options are limited (like, once per day)
(21:23:38) cron2: oh, no, that's jsut the affordable one... there is a Lu=
fthansa+Finnair combination that google tells me costs 2317 EUR...
(21:23:53) cron2: (arbitrary fri<->sun in September, just to get an idea)
(21:24:41) mattock: yeah, Oulu is definitely harder to reach
(21:24:47) cron2: ok, for me, MUC<->HEL is at least 200 EUR cheaper than =
MUC<->HEL<->OUL, so that can go into accomodation extras
(21:25:12) cron2: and it makes travelling more flexible (like, 3 flights =
a day for 139 EUR)
(21:26:17) lev__: yep, let's aim to Hki. Would September be ok ?
(21:26:23) cron2: since I've never been to either place, both are excitin=
g to visit, though :-)
(21:26:37) mattock: I think September is good
(21:26:43) mattock: it might even be warm then
(21:26:45) syzzer: yes, Helsinki is quite a bit more convenient for me to=
o
(21:27:45) cron2: September is good, but not first weekend (3./4.Sep) - s=
till on vacation, and 10/11.Sep. is not too convenient either ($kid[0] ha=
s her first day in school on Sep 12)
(21:28:25) lev__: so, 17-18
(21:28:39) syzzer: would work for me
(21:29:12) cron2: blocked in calendar
(21:29:31) syzzer: (24-25 is not convenient for me)
(21:30:30) lev__: ok, let me get a final confirmation till, say, end of n=
ext week
(21:31:06) cron2: cool
(21:31:47) mattock: nice!
(21:31:55) mattock: lev: does this mean we can't have a sauna?
(21:32:28) lev__: mattock: I'll try to arrange
(21:32:44) mattock: that would be nice for the tourists amongst us in par=
ticular
(21:33:03) mattock: ok, so hackathon covered for now?
(21:33:26) mattock: (I'm looking at https://community.openvpn.net/openvpn=
/report/3)
(21:33:29) vpnHelper: Title: {3} Active Tickets by Milestone =E2=80=93 Op=
enVPN Community (at community.openvpn.net)
(21:33:35) mattock: milestones 2.3.10 and 2.3.11
(21:34:57) cron2: as embarrassing as it is, I do not think there is anyth=
ing in 2.3.8, 2.3.9, 2.3.10 and 2.3.11 that couldn't be bumped to 2.3.12 =
- except for #648, which actually is fixed
(21:35:19) mattock: I noticed somebody had assigned me a minor documentat=
ion patch
(21:35:23) mattock: #590
(21:35:32) mattock: I can definitely provide a patch for that
(21:35:38) cron2: #567 could actually be fixed with the new gui that you =
committed today :)
(21:38:05) mattock: hmm, lemme see
(21:38:22) mattock: yeah, I think so yes
(21:41:05) cron2: syzzer: so how do we deal with James' patch?  It's not =
public, so I can't use the usual rules
(21:41:45) syzzer: I can do a reply-to-list ACK, with the patch fully inc=
luded
(21:43:00) mattock: yeah, I think #567 can be closed
(21:43:48) cron2: syzzer: that sounds good
(21:43:59) cron2: mattock: when can you do 2.3.11 release?
(21:44:21) mattock: whenever basically
(21:45:03) syzzer: cron2: ok, will do
(21:45:04) cron2: ok, I'm ready :)
(21:45:58) syzzer: hmpf, except that my private mail wasn't on the list w=
hen the patch was sent, and I didn't take my work laptop home...
(21:46:00) mattock: any opinions on how we should credit people that are =
just usernames in Trac?
(21:46:13) mattock: Git wants "username <email>" as the author
(21:46:46) mattock: I _can_ get the user's email from LDAP, but the user =
might not want that
(21:46:48) syzzer: I usually just put 'patch supplied by <user> in trac #=
<id>'
(21:46:50) cron2: syzzer: where shall I bounce it to?
(21:46:54) syzzer: steffan@...1856...
(21:47:08) cron2: bounced
(21:47:13) syzzer: thanks :)
(21:47:56) cron2: mattock: I think if you have no full patch (with e-mail=
 header), just use your own, and put a comment in like syzzer suggested
(21:48:08) cron2: we could ask users in trac, but half of them are not re=
sponsive
(21:51:21) mattock: yeah
(21:51:34) mattock: I'm sending patch for #590 in a few minutes
(21:54:14) ***cron2 waits
(21:55:00) syzzer: mail sent
(21:55:52) mattock: sent
(21:56:12) cron2: brr, quoted patch
(21:57:02) mattock: quoted?
(21:57:04) syzzer: you have the original ;)
(21:57:28) cron2: yeah, but I'll need to go fiddling with message ids now=
, to make the script reference your mail, while feeding it james'
(21:57:39) syzzer: ah
(21:58:05) syzzer: I was looking at #586 just now, but enabling dmalloc w=
on't even compile...
(21:58:26) syzzer: so should we fix dmalloc, or just purge it
(21:58:56) cron2: I think we should fix dmalloc - I used it once to trace=
 some weird mem leak, and it worked - ~2 years ago
(21:59:18) mattock: I'll close https://community.openvpn.net/openvpn/tick=
et/567 if nobody objects
(21:59:20) vpnHelper: Title: #567 (OpenVPN fails with no log output when =
config file is empty or (sometimes) has a non-whitespace syntax error) =E2=
=80=93 OpenVPN Community (at community.openvpn.net)
(21:59:27) mattock: I think the fixes from Selva are reasonable
(21:59:52) mattock: I tested them and they work, and the surprise factor =
of, say, and empty openvpn config files has been reduced dramatically
(22:00:22) cron2: mattock: right.  Do you think this could be made to wor=
k with a 2.3 based windows installer?  Or should we just point to 2.4, an=
d see that we can get that out eventually...?
(22:01:10) mattock: I think we should just get 2.4 out
(22:01:28) mattock: Interactive service is in, and the openvpn-gui suppor=
ts it quite nicely now
(22:01:38) mattock: we've solved a bunch of Windows-specific issues there
(22:02:00) mattock: plus got rid of the openvpn-gui nsi installer (=3Dcom=
plexity) as a side-effect
(22:02:43) mattock: this is slightly off-topic, but what is blocking 2.4-=
alpha1 currently?
(22:02:43) cron2: so let's just document the fact in the ticket, then, an=
d close it "can't be fixed in 2.3 due to too complex installer/gui change=
s, use git snapshots / 2.4 when available"
(22:03:06) cron2: registerdns-in-the-iservice
(22:03:19) cron2: and possibly pushable ciphers
(22:03:43) mattock: who is working on these?
(22:03:49) mattock: or could work on these?
(22:03:58) cron2: registerdns is on the list (Selva), needs ACK + merge
(22:04:14) cron2: pushable ciphers is syzzer's baby - james, plaisthos, p=
ossibly
(22:05:19) cron2: mattock: is the #590 patch for master or 2.3?
(22:05:21) cron2: or both?
(22:05:52) syzzer: jjk has recently been sending patches for pushable cip=
hers :)
(22:06:02) syzzer: but yes, that is still on my list
(22:06:13) cron2: ah, indeed, but as I remember, they did not work comple=
tely yet
(22:06:26) syzzer: no, he actually ran into the same problems I did
(22:07:02) mattock: cron2: master, but I suppose it would merge into INST=
ALL in 2.3 too
(22:07:45) mattock: plus the contents of #590 patch make sense in 2.3 oo
(22:07:47) mattock: too
(22:07:47) cron2: looking at it, I think I'll do 2.3-only, and INSTALL ne=
eds a more massive rework for master
(22:08:00) cron2: (INSTALL talks about PolarSSL 1.1 or higher...)
(22:08:11) mattock: indeed
(22:10:09) cron2: so, anything else before I do version.mv, ChangeLog and=
 tag?
(22:12:04) mattock: #590 and #567 closed
(22:14:09) mattock: so shall we move tickets from the older 2.3.x milesto=
nes to 2.3.12?
(22:14:20) cron2: yes
(22:14:28) cron2: and then go about actually fixing :)
(22:14:51) mattock: yeah, although I'd prioritize the last remaining 2.4 =
blockers
(22:14:55) cron2: (hrmph, no single fix from me in 2.3.11?  wtf?)
(22:15:04) cron2: slacker
(22:15:07) mattock: have you been lazy? :P
(22:15:31) mollox [~mollox@...2136...=
t] =C3=A8 entrato nella stanza.
(22:15:39) syzzer: if you want, I can send a patch for #586 (and fix dmal=
loc while at it)
(22:16:04) cron2: that would be nice, but unless you insist, it's not goi=
ng to make 2.3.11
(22:16:16) syzzer: just need to  write a commit msg and do a quick tst
(22:16:24) syzzer: fine with me :)
(22:17:10) mattock: I see syzzer and cron discussing this patch: https://=
community.openvpn.net/openvpn/ticket/587
(22:17:12) vpnHelper: Title: #587 (Add sanity checks, replace deprecated =
calls in OpenVPN 2.3.x) =E2=80=93 OpenVPN Community (at community.openvpn=
.net)
(22:17:34) cron2: some of it is useful addition, some of it is not needed=
 (if I remember correctly)
(22:17:52) mattock: quoting syzzer: "I just sent a patch containing a fix=
 for the missing ssl_polarssl.c check to the mailing list."
(22:18:00) mattock: I wonder if that is enough to close the ticket
(22:18:09) cron2: did that patch go in?
(22:18:20) mattock: I have absolutely no clue
(22:18:38) cron2: OpenVPN 2.3.11 x86_64-unknown-linux-gnu [SSL (OpenSSL)]=
 [LZO] [EPOLL] [MH] [IPv6] built on May  9 2016
(22:18:41) cron2: exclusive preview!
(22:20:24) syzzer: no, that patch needs review first
(22:20:51) cron2: OpenVPN 2.3.11 amd64-unknown-freebsd10.1 [SSL (OpenSSL)=
] [MH] [IPv6] built on May  9 2016
(22:21:26) mattock: syzzer: do you have a link/title for the patch?
(22:23:34) syzzer: mattock: http://thread.gmane.org/gmane.network.openvpn=
.devel/11274
(22:23:35) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(22:25:16) cron2:  * [new tag]         v2.3.11 -> v2.3.11
(22:28:38) cron2: oh, that one (11274)
(22:29:06) cron2: that needs more brains than I have left today
(22:29:19) syzzer: ok, so if I enable dmalloc, openvpn now compiles but w=
on't start :')
(22:30:04) syzzer: strace seems to indicate the process is still busy loa=
ding libs when it dies
(22:30:51) cron2: interesting
(22:31:59) mattock: fixed and closed #323
(22:39:06) cron2: ok, I'm calling it a day for today - 2.3.11 on my linux=
 is happy
(22:39:08) cron2: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
(22:39:09) cron2: All 3 tests passed
(22:39:09) cron2: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
(22:39:18) cron2: ... and I'm dead tired... no brains left.
(22:40:19) mattock: looks like https://sourceforge.net/p/openvpn/mailman/=
message/34542459/ is not merged, and that would solve #328
(22:40:20) vpnHelper: Title: OpenVPN / Mailing Lists (at sourceforge.net)
(22:40:27) mattock: yeah, I'm lacking brains also
(22:41:06) cron2: oh, yeah, that patch also needs to go into 2.4_alpha
(22:42:14) syzzer: oof, the timeout patch
(22:43:30) syzzer: not much brains left here either, time to call it a da=
y
(22:45:18) syzzer: mattock: whoops, I sent you the wrong link
(22:45:30) syzzer: I thought this was about something different
(22:50:12) mattock: syzzer: what is the correct link then?
(22:50:23) syzzer: I'm looking for it
(22:50:31) mattock: I moved tickets to 2.3.12 milestone, closing a few in=
 the process
(22:50:36) mattock: (which were fixed)
(22:51:23) mattock: syzzer: actually I typoed the ticket number
(22:51:27) mattock: let's see the correct one
(22:51:58) mattock: oh, I did not, too few braincycles remaining
(22:52:07) mattock: so I was talking about https://community.openvpn.net/=
openvpn/ticket/587
(22:52:09) vpnHelper: Title: #587 (Add sanity checks, replace deprecated =
calls in OpenVPN 2.3.x) =E2=80=93 OpenVPN Community (at community.openvpn=
.net)
(22:52:19) mattock: and you sent a link to http://thread.gmane.org/gmane.=
network.openvpn.devel/11274
(22:52:21) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(22:52:40) mattock: anyways, I need to get my beauty sleep - 2.3.12 relea=
se tomorrow
(22:53:12) cron2: 2.3.12?  what did I miss?
(22:53:24) syzzer: mattock: http://article.gmane.org/gmane.network.openvp=
n.devel/10176
(22:53:25) vpnHelper: Title: Gmane -- Re: PATCH Add missing strdup return=
 value checks (at article.gmane.org)
(22:53:26) mattock: sorry 2.3.11
(22:53:30) mattock: or what was it :P
(22:54:05) syzzer: (which was applied)
(22:55:14) mattock: ok, updated the ticket in question
(22:55:17) mattock: now sleep
(22:55:40) mattock: bye!

--------------090301050307070105050102--

