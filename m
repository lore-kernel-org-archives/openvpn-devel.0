Message-ID: <555A3F8C.9000405@...515...>
Date: Mon, 18 May 2015 22:37:48 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <55599C34.4040300@...515...>
In-Reply-To: <55599C34.4040300@...515...>
Content-Type: multipart/mixed; boundary="------------040809050108020606010205"
Subject: Re: [Openvpn-devel] Topics for today's (Monday,
 18th May 2015) community meeting
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
--------------040809050108020606010205
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of today's IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Monday 18th May 2015
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2015-05-18>

The next meeting is scheduled to two weeks from this meeting:

<https://community.openvpn.net/openvpn/wiki/Topics-2015-06-01>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, krzee, jamesyonan, mattock and syzzer participated in this meeting

---

Discussed the option of creating a honeypot email address to lessen the=20
amount of (clueless) support requests on the security mailing list. All=20
were in favor

---

Discussed OpenVPN argument parsing:

<http://thread.gmane.org/gmane.network.openvpn.devel/9599>

Decided to make the config parser fail if erroneous extra options are=20
encountered.

---

Discussed the status of OpenVPN 2.3.7 release. The status of the release=20
will be reviewed in next meeting in two weeks from now. We'll also try=20
to push out the release later that week. If some tickets can't be=20
tackled, they will be moved to 2.3.8.

---

Discussed the status of OpenVPN 2.4 release. The main missing components=20
are AEAD, IPv6 (fixes) and the interactive service.

Syzzer will make the interactive service patchset less intrusive by=20
providing the "move things into struct tt" patch. After this the code=20
can be moved into a separate Git branch from which mattock can start=20
building snapshot installers. As the patch is already in wide use=20
according to its author (d12fk), basic verification of functionality=20
should be good enough for moving it to Git master.

The IPv6-related changes require a few days of focused effort on cron2's=20
part.

The AEAD patches need review and testing first and foremost. Syzzer will=20
provide updated patches based on the feedback.

We will continue work on 2.4 after the 2.3.7 release is out.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------040809050108020606010205
Content-Type: text/plain; charset=UTF-8;
	name="openvpn_irc_meeting_chatlog_2015-05-18.txt"
Content-Disposition: attachment;
	filename="openvpn_irc_meeting_chatlog_2015-05-18.txt"
Content-Transfer-Encoding: quoted-printable

(21:00:07) mattock: meeting time
(21:00:52) mattock: who do we have here?
(21:01:41) krzee: o/
(21:01:42) syzzer: well, me, obviously :p
(21:03:13) cron2: \ob/
(21:03:48) mattock: hi!
(21:03:57) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
5-05-18
(21:03:59) vpnHelper: Title: Topics-2015-05-18 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:04:01) mattock: anything to add to the agenda?
(21:04:07) syzzer: will james be joining tonight?
(21:04:19) mattock: I have not explicitly asked him
(21:04:26) mattock: I can send him an email if you think we'd need him
(21:04:45) mattock: any topics in particular for James?
(21:04:46) syzzer: he usually has an opinion on config file discussions
(21:04:58) mattock: ok, I'll mention that
(21:06:18) mattock: mail sent
(21:08:08) mattock: maybe we could start from topic #2, "Support requests=
 sent to the security list"
(21:08:32) mattock: any thoughts on creating a honeypot email address for=
 clueless people?
(21:08:41) cron2: +1
(21:09:14) jamesyonan [~jamesyona@...2036...] =C3=
=A8 entrato nella stanza.
(21:09:14) modalit=C3=A0 (+o jamesyonan) da ChanServ
(21:09:34) krzee: +1
(21:09:37) syzzer: if I get less mail from clueless people, I'm all for i=
t :p
(21:09:40) mattock: great!
(21:09:49) krzee: we have support places
(21:09:52) mattock: I'll get it done or fail trying then
(21:09:56) krzee: no reason for them to spam you guys
(21:10:02) mattock: krzee: yeah, exactly
(21:10:05) mattock: hi james!
(21:10:12) mattock: I think we can move to topic #1 now
(21:10:19) mattock: http://thread.gmane.org/gmane.network.openvpn.devel/9=
599
(21:10:20) syzzer: perfect timing
(21:10:21) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:10:29) krzee: hey james =3D]
(21:10:38) jamesyonan: hi guys
(21:10:46) cron2: hi Jams
(21:10:56) cron2: argh, typing impaired
(21:11:48) krzee: did anyone show james that page that said usa people we=
re banned from contributing?  lol
(21:12:32) jamesyonan: that sounds like something out of the 90s
(21:13:16) mattock: krzee: what page?
(21:14:58) syzzer: ostif.org I believe, but I never managed to actually f=
ind the claim on the site
(21:15:24) krzee: i saw it before, trying to find again
(21:16:00) mattock: so config parsing?
(21:16:10) mattock: syzzer, cron2: you had some discussion about this on =
the ml
(21:16:48) krzee: ive seen people put funny options to redirect-gateway t=
hat were not fatal and would have helped the user to find their own probl=
em if they were
(21:16:54) syzzer: yes, I voiced my opinion. I think it is a bit harsh fo=
r 2.3, but we should not silently ignore extra parameters and I would be =
fine with rejecting such configs in 2.4
(21:17:23) cron2: it's a bit too intrusive for 2.3, I'd say, but I agree =
on 2.4
(21:17:31) mattock: sounds reasonable
(21:17:31) cron2: we just need to decide whether to make it a warning or =
a fatal
(21:17:34) mattock: jamesyonan: thoughts?
(21:17:43) mattock: also, what does openvpn 3.x do?
(21:17:54) krzee: could be a warning in 2.3 and fatal in 2.4
(21:18:05) mattock: krzee: good point
(21:18:12) cron2: krzee: no, as it's a high amount of to-be-changed code
(21:18:20) krzee: ahh
(21:18:31) jamesyonan: I'm fine with this for 2.4, but I'm wondering if c=
onfigs might break that depend on the relaxed approach towards extra args
(21:18:31) cron2: (basically, every single option statement)
(21:18:58) mattock: do we need a relaxed option parser to ensure future c=
ompatibility?
(21:19:16) krzee: are there options where old versions took other flags?
(21:19:27) cron2: jamesyonan: do you have specific cases in mind, or just=
 "some configs that have never done anything are now going to error"?
(21:19:49) jamesyonan: no specific cases in mind at this point
(21:19:55) cron2: this was, I think, what started the discussion - config=
 errors like --opta foo bar optb=20
(21:20:17) cron2: where "--optb" should have been would have been silentl=
y ignored, but the user actually *wanted* --optb here...
(21:20:47) syzzer: I'm pretty sure configs will break, but I tend to thin=
k that is acceptable for 2.3 -> 2.4, and actually a good thing
(21:21:13) syzzer: ^^ what cron2 said
(21:21:49) jamesyonan: should we have an options that controls it with er=
ror, warning, ignore settings?
(21:22:35) syzzer: i would not be in favour of that. if people have to ch=
ange their configs, lets make them fix the config, instead on continue us=
ing a broken one
(21:28:45) mattock: any other thoughts?
(21:30:46) cron2: I'm with syzzer here - if we break it, break it :-) - I=
 have considered having an option, but what would be the benefit?  I *wan=
t* to keep this broken config *stamp foot*!  (To make it truly useful, it=
 would have to be added as a checkbox to all the guis "ignore broken opti=
ons in the profile your VPN provider gave you!" or so)
(21:32:34) krzee: having a bad config option is fatal worthy to me, i agr=
ee theres no benefit to an option that says "let me have a messed up conf=
ig"
(21:32:46) cron2: ... and since we have a volunteer who proposed that, th=
is topic will be back for code-ACKing anyway...
(21:33:23) mattock: does this apply to all options, or just those that ta=
ke extra parameters?
(21:33:43) cron2: all of that, what good is "--client foo"?
(21:34:00) cron2: this could be a misplaced "--client --foo", or garbage,=
 or what do we know...
(21:36:01) mattock: so we basically agree on this?
(21:36:07) mattock: "make sense"
(21:37:52) syzzer: think so. who sends a mail to the list/
(21:37:56) jamesyonan: I would tend to agree with this.  Since the change=
 will need to patch handling code for every option individually, it gives=
 us room to tweak the logic down the road if the new strictness breaks re=
asonable configs.
(21:39:13) mattock: we might even find hidden features (break) in OpenVPN=
 :)
(21:39:20) cron2: what james says :)
(21:39:21) mattock: next topic?
(21:39:28) cron2: yep
(21:39:47) mattock: #3 "Status of OpenVPN 2.3.7"
(21:39:50) cron2: well
(21:39:53) cron2: "coming..."
(21:40:03) mattock: does that cover 2.4 also? :P
(21:40:34) cron2: I've received feedback on #480 ("patch works!"), but wa=
s away two weeks, so nothing has happened yet
(21:40:37) cron2: merge soon
(21:40:49) cron2: on #481, I'm still waiting for feedback
(21:41:58) mattock: oh, sorry for this minor interruption... jamesyonan: =
there's a "OpenVPN Techonologies, Inc. products" query on Trac: https://c=
ommunity.openvpn.net/openvpn/report/18
(21:41:59) cron2: ditto on #523 (merge the first part of the patch on laz=
y-ack, poke plaisthos to think about the second part)
(21:42:00) vpnHelper: Title: OpenVPN Technologies, Inc products =E2=80=93=
 OpenVPN Community (at community.openvpn.net)
(21:42:47) syzzer: #512 was merged, right?
(21:42:51) mattock: yes
(21:43:26) cron2: yep, both 2.3 and master
(21:44:07) mattock: I'll close #512
(21:44:19) cron2: on 2.3, I'd say "let me work two weeks on what I can ma=
nage, and decide next meeting whether we want anything else, or whether t=
his is good enough and the rest goes to 2.3.8".
(21:44:29) ***syzzer rediscovers he volunteered for #225...
(21:44:54) ***cron2 sort of inherited a pile of ... things
(21:45:42) cron2: last week at the RIPE meeting, at least *three* persons=
 approached me that ipv6-transport and ipv6-payload interact in "incomple=
te ways" when the vpn server is *inside* the network block pushed via "pu=
sh route-ipv6"... :-( - but that is 2.4 material
(21:46:29) krzee: 3 people hit you up at the meeting but nobody bothered =
to file a ticket prior?
(21:46:34) krzee: :/
(21:46:50) krzee: or was there tickets already?
(21:46:54) cron2: it's a long-standing issue... there might even *be* a t=
icket - there is LOTS of stuff with "milestone 2.4"
(21:47:42) mattock: it seems I've volunteered on a few tickets myself
(21:48:06) cron2: (and I sort of tempted them, by walking around one day =
with the OpenVPN t-shirt... made contact with one of the dd-wrt developer=
s [I hear dazo screaming...], and he's actually quite a nice guy... he ha=
s a few itches to scratch, and proposed to pay one of his programmers to =
do a patch if we agree on the general direction... still waiting for deta=
ils, though)
(21:48:28) cron2: well, not "dd-wrt developers" but "heads behind the dd-=
wrt company"
(21:49:02) cron2: but that's sidetracking - agreement on 2.3.7 direction?
(21:49:35) mattock: direction =3D~ "fix whatever we can in two weeks and =
postpone the rest to 2.3.8?"
(21:49:49) syzzer: jamesyonan: have you seen this one: https://community.=
openvpn.net/openvpn/ticket/553
(21:49:51) vpnHelper: Title: #553 (Password validation broken in openvpn =
client) =E2=80=93 OpenVPN Community (at community.openvpn.net)
(21:52:52) cron2: mattock1: yes, to close this topic for today :)
(21:53:45) syzzer: yes, not much more to say
(21:53:55) jamesyonan: re: 553, what is running on the server side?  Acce=
ss Server?
(21:54:48) mattock: it seems I only _thought_ about fixing #373 instead o=
f actually fixing it :P
(21:54:54) mattock: I'll provide a patch then
(21:55:35) syzzer: jamesyonan: no clue, I just noticed it. would not surp=
rise me if it was the users own crappy script.
(21:56:44) mattock: so on to topic 4, "OpenVPN 2.4"
(21:57:16) mattock: I assume interactive service is still a bit work in p=
rogress
(21:58:25) syzzer: how do we get more progress there? I have can do the "=
move things into struct tt"-patch, if that helps
(21:58:37) cron2: I think we have three major topics here: AEAD, IPv6 (me=
ntioned above), iService
(21:58:57) cron2: syzzer: indeed that would help - I planned to do it, bu=
t (excuses)
(21:59:26) syzzer: I'll do that
(21:59:30) mattock: great!
(21:59:52) syzzer: is that enough to get into -master ?
(22:00:09) cron2: no :)
(22:00:23) cron2: but it's enough to go into a branch in the main repo wh=
ere mattock can build installers from it
(22:00:36) mattock: there are still a few Windows installer-related fixes=
 I need to tackle, but all of them might not be necessary for the first a=
lphas
(22:00:47) cron2: (that was sort of the plan we had - make it less intrus=
ive [struct tt], get it tested on its own, then merge)
(22:01:00) syzzer: ok
(22:03:58) mattock: what about AEAD and IPv6? anything blocking those exc=
ept lack of time/motivation?
(22:04:26) cron2: IPv6: lack of time - I think I need about 3-4 days of "=
quiet", and squeezing this into "30 minutes in the evening" isn't working=
 out
(22:04:43) cron2: AEAD: syzzer should push us harder, I think :)
(22:04:47) mattock: things rarely squeeze into 30 mnutes
(22:05:02) syzzer: AEAD - needs more review and I need to tidy up and sen=
t more patches
(22:05:35) mattock: syzzer: did you and james agree to do some testing/re=
view on AEAD?
(22:05:43) cron2: mattock1: well, some of these trac tickets do, once I m=
otivate myself to actually go looking :)  "too many tickets" is not overl=
y motivating, though, and "bah, I've looked at this ticket 20 times now, =
it can wait more!" neither :)
(22:05:54) syzzer: I think we agreed, but we did not do any since the las=
t time we discussed
(22:06:10) mattock: cron2: agreed
(22:07:18) mattock: I'd say that given our current resource we should pro=
bably focus on 2.3.7 things first, then forget about 2.3.8 and work on 2.=
4.x=20
(22:07:51) mattock: I mean try to focus on one release at a time
(22:08:52) mattock: 2.3.7 release in slightly over 2 weeks?
(22:08:59) cron2: "aim for that"
(22:10:30) mattock: I will force myself to do my part before that
(22:10:51) syzzer: ok. focus on 2.3 for the coming two weeks.
(22:12:14) mattock: regarding interactive service testing
(22:12:27) mattock: when do we deem the code ready to go to master?
(22:12:41) mattock: typically people don't use anything but stable releas=
es
(22:13:07) mattock: are we content with scattered "works for me" type rep=
orts?
(22:14:01) cron2: well, d12fk says it works for their customer base, so i=
t already got some testing
(22:14:05) cron2: (quite!)
(22:14:18) mattock: I doubt there will be any horrible issues
(22:14:49) mattock: I'd just like to avoid the situation where 2.4 is blo=
cked only by the interactive service because it's been forgotten in some =
Git branch
(22:15:03) mattock: so "scattered reports" is probably good enough
(22:15:26) mattock: the basic functionality is easy to test I believe ("r=
un openvpn as non-admin")
(22:15:55) cron2: yes, and then the stuff that iservive brings - v4 ifcon=
fig, v6 ifconfig, v4/v6 routes, cleanup on exit
(22:18:48) mattock: let's document a set of tests after the iService-enab=
led installers are available
(22:18:56) mattock: anything else for today?
(22:19:29) cron2: not from me...
(22:19:30) mattock: I think I'll continue my ticket review from tickets a=
ssigned to milestones 2.3.7 and 2.4
(22:19:52) mattock: I've covered less tickets that I had liked, maybe 20 =
or so
(22:19:57) mattock: I'll focus a bit
(22:20:04) mattock: meeting in two weeks? 1st June
(22:20:26) mattock: and try to push out 2.3.7 later that week
(22:20:28) cron2: +1
(22:20:58) mattock: hmm, I will be in Crete at that time, but I should ha=
ve some sort of internet connectivity
(22:21:01) mattock: enough for IRC at least
(22:21:28) syzzer: there, a patch on the list to close #127 \o/
(22:21:36) mattock: syzzer: excellent!
(22:21:47) syzzer: focus on 2.4 failed already :')
(22:21:51) syzzer: uh, 2.3
(22:22:20) cron2: bug fixed is bug fixed :)
(22:22:53) syzzer: man-page update, with a supplied patch, since 2011...
(22:22:55) cron2: and that one actually should go to 2.3 as well, documen=
tation si godo
(22:25:03) mattock: I think I dare ACK that patch
(22:25:06) syzzer: cron2: git send-email seems to have eaten the original=
 authors name from the patch, could you reinstate that before applying?
(22:25:19) cron2: mattock: too late, already ACKed :-)
(22:26:13) cron2: commit --amend --author=3D... done
(22:26:19) mattock: cron2: ok
(22:26:19) cron2: now wrangling with 2.3
(22:28:14) mattock: cron2: can you merge the --port patch immediately, so=
 that we can close #127?
(22:28:31) mattock: um, I wonder if it merges cleanly with 2.3...
(22:28:33) cron2: working!
(22:28:39) mattock: great!
(22:28:41) cron2: (no, because of --bind [ipv6only] two lines below)
(22:29:14) mattock: btw. I received some generic information mail from Co=
verity today
(22:29:31) mattock: it seems that we could automatically upload new sourc=
es to Coverity somehow
(22:30:21) mattock: that would make Coverity a bit more useful=20
(22:30:36) cron2: and someone should actually look at the results every n=
ow and then :)
(22:30:47) mattock: yes, that would help even more :P
(22:31:11) mattock: I'll send the summary soon and then I have to split
(22:31:18) mattock: early wake up tomorrow

--------------040809050108020606010205--

