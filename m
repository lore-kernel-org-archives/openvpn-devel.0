From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <796722c6-e08b-6de4-67aa-6f2ecc21623e@...515...>
Message-ID: <e789ffc4-334a-82b3-5bf3-28a2c3d1bbef@...515...>
Date: Fri, 10 May 2019 10:33:14 +0300
MIME-Version: 1.0
In-Reply-To: <796722c6-e08b-6de4-67aa-6f2ecc21623e@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fR0slUwO6ksDzpKAHnBHvU9vELi78cN37"
Subject: [Openvpn-devel] Summary of the community meeting (9th May 2019)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fR0slUwO6ksDzpKAHnBHvU9vELi78cN37
Content-Type: multipart/mixed; boundary="wO1cXu7lyY2E9cHXiw2o1QAa3tL9zwB5d";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <e789ffc4-334a-82b3-5bf3-28a2c3d1bbef@...515...>
Subject: Summary of the community meeting (9th May 2019)
References: <796722c6-e08b-6de4-67aa-6f2ecc21623e@...515...>
In-Reply-To: <796722c6-e08b-6de4-67aa-6f2ecc21623e@...515...>

--wO1cXu7lyY2E9cHXiw2o1QAa3tL9zwB5d
Content-Type: multipart/mixed;
 boundary="------------0F601FF08437A74BA7C9796F"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------0F601FF08437A74BA7C9796F
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thursday 9th May 2019
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-05-09>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

chipitsine, cron2, dazon, mattock and syzzer participated in this meeting.

--

Discussed the option of enabling Cirrus-CI for FreeBSD testing. Agreed
that it might benefit some users as it would allow FreeBSD testing of
PRs on GitHub. Nevertheless it was decided to not enable it as we have
much wider *BSD tests in Buildbot and we provide Vagrant *BSD VMs for
people to use for development and testing.

--

Discussed tap-windows6 HLK testing. Mattock made good headway on the
infrastructure today and believes that HLK test results should be ready
in <2 weeks. Jamallx on #openvpn-devel has ran tap-windows6 through all
the HLK tests in his environment, so tap-windows6 is definitely
HLK-compliant now and no big HLK issues are to be expected.

--

Decided to arrange the second OpenVPN 2.5 mini-hackathon this Friday
(=3Dtoday) "after lunch" (CEST). The idea is to have a mini-hackathon
every other Friday after Thursday's 20:00 (CEST) meeting if that suits
everyone. This way it is less likely that people forget about them.

--

Full chatlog attached.


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



--------------0F601FF08437A74BA7C9796F
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-05-09.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-05-09.txt"

(20:56:25) L'argomento di #openvpn-meeting =C3=A8: Next meeting on 13/Feb=
/2019 at 11:30CET. Agenda at https://community.openvpn.net/openvpn/wiki/T=
opics-2019-04-11
(20:56:25) L'argomento per #openvpn-meeting =C3=A8 stato impostato da daz=
o!~freenode@...1423.../corp/developer/dazo a 21:18:02 su 11/04/2019
(20:56:31) mattock: almost meeting time
(20:57:20) mattock: who do we have here?
(20:58:09) ***cron2 hides under the table
(21:01:59) ***syzzer present
(21:02:45) mattock: hi syzzer!
(21:02:55) syzzer: I made it to the meeting :')
(21:03:01) mattock: most excellent!
(21:03:04) syzzer: hi mattock1 :)
(21:03:38) chipitsine ha abbandonato la stanza (quit: Read error: Connect=
ion reset by peer).
(21:03:47) mattock: ok let's start
(21:03:50) chipitsine [~chipitsin@...2312...] =C3=A8 entrato nella st=
anza.
(21:03:56) mattock: chipitsine: here?
(21:04:04) chipitsine: yep
(21:05:14) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
9-05-09
(21:05:16) vpnHelper: Title: Topics-2019-05-09 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:05:24) mattock: so we actually have a few pre-created topics
(21:05:30) mattock: start from the top?
(21:05:30) cron2: hi syzzer!
(21:05:38) mattock: hi chipitsine!
(21:06:28) mattock: anyone opposed to "Enabling Cirrus-CI for FreeBSD tes=
ting in GitHub"?
(21:06:36) mattock: I am not
(21:06:58) chipitsine: I'd suggest to enable it and to see how it goes
(21:07:02) cron2: I am opposed to spending more and more CPU cycles on th=
ings that have little extra benefit
(21:07:17) mattock: that's somebody else's CPU
(21:07:23) mattock: :)
(21:07:24) cron2: we already have more FreeBSD testing than Cirrus-CI wou=
ld give us (full buildslaves from 7.x to 11.x, 12.x coming up)
(21:07:35) cron2: mattock1: still waste for little good
(21:08:12) syzzer: the only benefit I see for cirrus-ci is that it's easi=
er to use for non-core team members
(21:08:18) mattock: yep
(21:08:30) cron2: how so?
(21:08:43) mattock: they can create a PR and have that checked?
(21:08:52) cron2: we do not want PRs
(21:08:54) syzzer: they can just fork the openvpn repo, push to their for=
ked repo, and have the tests run
(21:09:15) cron2: syzzer: sure, but for that, *we* do not need to carry c=
irrus-ci
(21:09:20) syzzer: instead of posting to the mailinglist, waiting for rev=
iew, then waiting for the patch to be applied
(21:09:31) mattock: we would probably want the config file in our repo
(21:09:34) mattock: right?
(21:09:39) mattock: as with travis
(21:10:23) syzzer: cron2: (I'm mostly with you here, hence "the *only* be=
nefit") having a config in our repo does make it a lot easier for occasio=
nal committers to run the tests
(21:10:27) cron2: we could carry it but I do not think we should enable i=
t and I'm not overly keen to have to handle patches to it every now and t=
hen
(21:11:12) chipitsine: why not to enable it ?
(21:11:16) syzzer: nah, I say either carry it and run it (so we know when=
 it breaks) or not at all
(21:11:22) mattock: agree with syzzer
(21:11:39) cron2: chipitsine: it adds cost.  Someone has to pay for elect=
ricity for this.  It has no benefit.
(21:11:59) cron2: it adds maintenance costs (if little).  It has no benef=
it.
(21:12:12) syzzer: and cron2 or dazo have to spend time processing patche=
s for it, which they could also spend on real functionality
(21:12:17) chipitsine: I do not think it actually adds cost. servers run =
all the time, they do not have tasks to run
(21:12:34) cron2: chipitsine: this is not how modern clouds work
(21:12:35) syzzer: that's not how it works...
(21:13:18) mattock: I have to admit - I don't know how it works, so I wil=
l quickly check
(21:13:38) syzzer: basically "travis for freebsd"=20
(21:13:40) cron2: now... if we did PRs, it has an obvious benefits.  But =
the way we do process patches today, PRs are actually contraproductive, b=
ecause people will create PRs and then we get to chase them to submit pat=
ches
(21:14:28) cron2: I can see the benefit of "how do I do freebsd tests?" f=
or submitters not having access to the buildmaster repo
(21:14:28) mattock: is it as automatic as travis? do _we_ need to run som=
ething?
(21:14:47) chipitsine: it is automated
(21:14:49) mattock: or just enable some plugin in GitHub and have config =
file in the repo
(21:14:52) cron2: but then, we do have the vagrant boxes... and *most* pa=
tches are unlikely to break *BSDs
(21:14:55) chipitsine: I'm not sure how stable it is
(21:15:06) chipitsine: if it appears not to be stable, we'll drop it
(21:15:42) mattock: could we do it on a separate openvpn GitHub fork that=
 gets synced with the main one every now and then?
(21:15:51) mattock: I mean, like chipitsine's
(21:15:58) mattock: if it is not too much work
(21:16:08) cron2: anyone can do anything they want in their github fork :=
-)
(21:16:13) mattock: yeah
(21:16:53) mattock: and if it seems to work fine then consider activating=
 it for OpenVPN/openvpn
(21:17:09) cron2: there we go again.  "No benefit, adds costs"
(21:17:12) chipitsine: it works fine on my own repo
(21:17:16) mattock: ok
(21:17:17) cron2: even "consider" is too much effort
(21:17:21) chipitsine: it does not add costs to us
(21:17:34) mattock: except patch review time cost
(21:17:35) chipitsine: we do not have to worry for someone's electricity
(21:17:39) syzzer: chipitsine: that's a rather self-centric way to look a=
t it
(21:17:55) ***dazo is here
(21:17:58) mattock: hi dazo!
(21:18:40) mattock: so basically cron2 is not sold, but we agree there is=
 some small benefit for people who want to have their code tested on Free=
BSD
(21:18:59) cron2: "and can neither run vagrant nor have access to the bui=
ldmaster repo"
(21:19:04) mattock: if they first realize that Cirrus-CI is available, th=
en they could make a PR to trigger
(21:19:07) syzzer: so, trying to bring this to an end: I'm with cron2 on =
this one. We have travis and the windows-travis (what's it called again) =
already. Those catch most problems. For the real testing we have buildbot=
 running much more extensive tests. That should do it.
(21:19:12) syzzer: We need less work, not more.
(21:19:13) mattock: many people don't want to run Vagrant because of <n>
(21:19:23) mattock: syzzer: appveyor
(21:19:37) mattock: I don't have strong opinions
(21:19:39) dazo: I'm also not sold on the cirrus-ci stuff
(21:19:57) mattock: let's let it be then
(21:20:09) mattock: ok next topic
(21:20:30) cron2: that is fairly easy - I've seen the ACK but I had no ti=
me yet to give it an extra quick glance and then merge it
(21:20:37) mattock: https://patchwork.openvpn.net/patch/579/
(21:20:38) vpnHelper: Title: [Openvpn-devel,v2] Fix various compiler warn=
ings - Patchwork (at patchwork.openvpn.net)
(21:20:40) cron2: propably tomorrow
(21:21:04) cron2: s/pa/ba/
(21:21:28) mattock: next in line: https://patchwork.openvpn.net/patch/725=
/
(21:21:30) vpnHelper: Title: [Openvpn-devel] tests: remove dependency on =
base64 - Patchwork (at patchwork.openvpn.net)
(21:21:41) cron2: that gets a solid "superceded" :-)
(21:21:57) mattock: that was quick
(21:21:59) mattock: tap-windows6 updates=20
(21:22:05) cron2: https://patchwork.openvpn.net/patch/728/ is the new one=

(21:22:06) vpnHelper: Title: [Openvpn-devel,v2] tests: remove dependency =
on base64 - Patchwork (at patchwork.openvpn.net)
(21:22:10) mattock: noted
(21:22:16) dazo: I think I was fine with an earlier patch, just some mino=
r changes (kicking out some wrapper functions which looked superfluous)
(21:22:19) cron2: syzzer: I still think you should have gone with the rom=
an numbering :-)
(21:22:36) cron2: dazo: which one?
(21:22:50) syzzer: cron2: weren't you hiding under some table? :p
(21:23:03) dazo: cron2: "Fix various compiler warnings"
(21:23:55) cron2: dazo: that one got an ACK, I was just busy with other s=
tuff.  Nothing wrong with the patch (AFAICS :) ), it's the v2 with the fe=
edback incorporated anyway
(21:24:09) dazo: right
(21:24:46) dazo: (saw the ack now)
(21:26:20) dazo: patch 728 looks reasonable=20
(21:26:38) cron2: yep
(21:26:39) dazo: but should probably be tested on our buildbots=20
(21:27:45) syzzer: yeah, that.  I still need to re-figure out how to push=
 to mattocks repo that triggers builds :p
(21:28:08) dazo: syzzer: you got access to the community vpn?
(21:28:10) mattock: any particular challenges there?
(21:28:22) cron2: build is not in the community vpn
(21:28:27) syzzer: so if anyone with that working could push the patch th=
at way... O-)
(21:28:28) cron2: so it's just about account & keys
(21:28:29) syzzer: mattock1: time
(21:28:31) syzzer: I think
(21:28:44) dazo: cron2: oh, I'm not up-to-date then :)
(21:28:45) mattock: if I recall correctly you can push just fine without =
VPN
(21:28:54) mattock: I can check
(21:29:01) cron2: you can
(21:29:14) syzzer: ooh, that sounds easy enough
(21:29:15) cron2: my repo machine is not my desktop machine, and only the=
 desktop machine is in the community VPN
(21:29:34) cron2: (I think mattock changed this because I'm so lazy)
(21:29:45) dazo: hehe :)  okay, that'll work
(21:30:21) cron2: mattock: could you do a quick check if syzzer has an ac=
count & pubkey?
(21:30:31) mattock: yes, should be possible to push directly via SSH
(21:30:32) chipitsine: being lazy to use vpn when developing vpn :)
(21:30:50) mattock: :)
(21:30:55) mattock: VPNs are a PITA
(21:30:57) mattock: :P
(21:30:57) cron2: being lazy about "how many things do I need to start be=
fore I can go about pushing code changes"
(21:31:26) mattock: syzzer does have an account and an authorized key
(21:31:33) cron2: \o/
(21:32:36) mattock: all looks good
(21:32:38) syzzer: I even had it half-configured, with a wrong path
(21:32:40) syzzer: but works now
(21:32:41) cron2: my openbsd buildslave needs to have cmake installed, ot=
herwise the test won't excercise this code
(21:32:43) syzzer: thanks
(21:32:46) cron2: working on it...
(21:33:01) mattock: I need to split in 20 mins at latest
(21:33:09) mattock: done with this topic?
(21:33:11) cron2: so... tap-windows6?
(21:33:13) mattock: yes
(21:33:27) mattock: I've made good headway in HLK testing infrastructure =
- the openvpn setup is now ready but I need to clear all the firewalls in=
 between the "client(s)" and "server(s)"
(21:33:43) mattock: I'm going to test on virtualized Windows Server 2019 =
HLK clients, assuming that rozmansi's patch to make tap-windows6 advertis=
e=C2=A0itself as a virtual device does what it is supposed to
(21:33:51) cron2: nice
(21:33:54) mattock: in which case those EC2 Windows Server 2019 instances=
 "should be good"
(21:34:18) mattock: jamallx successfully passed the HLK tests for tap-win=
dows6 so I don't see any major issues ahead when the infrastructure is in=
 place
(21:35:00) mattock: plus according to wintun guys the combo of server 201=
9 + server 2019 core + windows 10 32-bit _should_ get us a "universal" Wi=
ndows 10 signature
(21:35:12) mattock: so only two signatures required with fairly modest HL=
K environment
(21:35:19) dazo: cool!
(21:35:37) mattock: I'd expect "real" results in <2 weeks
(21:35:50) mattock: as in: "some signature based on HLK testing from Micr=
osoft"
(21:36:23) dazo: so in <2 weeks we can spin new updates without too much =
hassle any more?  Just issue the new driver update through some blackbox =
and get the signature back and release?
(21:36:24) mattock: the infrastructure should be functional tomorrow I ho=
pe
(21:36:46) mattock: dazo: well there will still be lots of hassle
(21:36:54) mattock: but we can make _releases_ :)
(21:37:10) dazo: but not of the epic proportions it has required so far, =
right?
(21:37:10) mattock: right now one release takes about an hour
(21:37:28) mattock: depends on what "epic" means
(21:37:28) dazo: (not being able to have a release in x months or so)
(21:37:34) mattock: HLK will run for a _long_ while
(21:37:38) mattock: not that yes
(21:37:54) mattock: it will probably take at least 24 hours to get a rele=
ase out with all the tests running
(21:38:04) mattock: _unless_ rozmansi's patch makes a huge difference the=
re
(21:38:05) dazo: that's reasonable
(21:38:08) mattock: which could be the case
(21:38:10) cron2: so, cmake added to netbsd and openbsd buildslaves... le=
t's see what happens
(21:38:28) mattock: anyways, that's all I have on tap-windows6
(21:38:37) mattock: next topic?
(21:38:55) cron2: time for me to come up from under the table and frown i=
n everybody's direction!
(21:39:16) mattock: next mini-hackathon with more participant? :P
(21:39:18) mattock: participants
(21:39:34) mattock: did we schedule that, or is the schedule automatic?
(21:39:34) cron2: yes, that would be nice :-)=20
(21:39:53) cron2: we didn't schedule anything yet, last friday was the fi=
rst attempt at, well, get things going
(21:40:09) mattock: would "after Thursday meeting" work in general?
(21:40:13) cron2: (and it succeeded, though in surprising fashion - sgsta=
ir was there and we got all the tap driver improvements reviewed and merg=
ed)
(21:40:27) mattock: that way it would be less easy to forget about the ha=
ckathon
(21:40:28) dazo: that's good at least :)
(21:40:43) mattock: yeah we made huge progress thanks to cron2 and sgstai=
r
(21:40:45) dazo: I do promise to have it much higher on the agenda next t=
ime
(21:40:50) mattock: I was just working on HLK docs
(21:41:18) cron2: I'm at home tomorrow, but I have some chores to attend =
(like, cleaning up, and packing gifts for $kid's 9th birthday on Saturday=
)
(21:41:46) mattock: maybe have "something" tomorrow and start for real af=
ter two weeks
(21:41:50) cron2: so I won't be able to spend "a full day", but if people=
 show up and send me nice things, I can work on it
(21:41:51) mattock: a mini-mini thing
(21:42:32) cron2: in two weeks time, I'll be sitting in a plane for 4h on=
 friday afternoon :-) - but the point of having a community is that it's =
not all my tasks :-)
(21:42:32) dazo: cron2: which time of the day would you expect to be avai=
lable?  I will try to block half a day for community dev tomorrow
(21:42:41) cron2: dazo: afternoonish
(21:43:28) dazo: sounds good!  I'll allocate "after lunch" with 4-5 hours=
 community time
(21:43:30) cron2: syzzer: did you push?
(21:43:40) cron2: dazo: yeah, this sounds like we might get something don=
e
(21:43:42) syzzer: cron2: yes
(21:43:55) syzzer: I won't have much time tomorrow
(21:44:13) cron2: mmmh, buildmaster didn't pick it up yet, I think
(21:44:25) mattock: it takes a while, it is polling
(21:44:36) mattock: and there is the "will another commit come in" delay
(21:44:45) mattock: can't recall the exact time
(21:44:49) dazo: cron2: I have a meeting at 20:00 which approx 1 hour fro=
m the office .... and I'm not planning to travel home in between (as that=
 would easily add another 30-40 minutes)
(21:45:00) dazo: otherwise afternoon is open :)
(21:45:27) mattock: \o/
(21:45:29) cron2: let's give it a go :-) - I'll have family chores betwee=
n 4 and 5 and then again at 6...
(21:45:50) cron2: ok, remotes/origin/syzzer/base64-fix is there
(21:46:15) mattock: I will have to write the summary tomorrow, so if one =
of you could advertise this hackathon thing on some medium I'd appreciate=
 it
(21:46:26) mattock: are we done? I need to split before I miss the bus
(21:46:37) cron2: if you could advertise it on the internal chat...
(21:46:41) cron2: plaisthos, ordex...
(21:46:42) dazo: run, mattock, run!
(21:46:42) mattock: lol yes
(21:46:46) cron2: run, mattock, run :-)
(21:46:50) mattock: I have 11 mins
(21:46:55) dazo: cron2: I added it to our team calendar ;-)
(21:46:59) mattock: but I will mention this on #openvpn-devel and our int=
ernal chat
(21:47:06) cron2: I'm basically waiting for jjk, plaisthos, ordex, syzzer=
 to give reviews... :-)
(21:47:15) cron2: well, jjk wanted to send a patch for --genkey
(21:48:13) mattock: ok, splitting now
(21:48:16) syzzer: yeah, I think we had off-list consensus on the directi=
on to go with that
(21:48:22) mattock: "see" you tomorrow
(21:48:26) syzzer: run, mattock, run!
(21:48:26) cron2: *wave*
(21:48:29) mattock: bye!

--------------0F601FF08437A74BA7C9796F--

--wO1cXu7lyY2E9cHXiw2o1QAa3tL9zwB5d--

--fR0slUwO6ksDzpKAHnBHvU9vELi78cN37
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlzVKToACgkQKVhNn0CG
RXi9wQgAkBr/B0LsvL7y5sufMMMXywoCas54QCQu6qfGIKf4g69LRicoSr9vDLyO
KqbJhRcKoBhVLXBLI2f4yTHcmLjj3RfRTHUdBOBzpHcVkDntkbU2dIVDFxvLoGXt
7DbYf5UkGtXg6c8XP2SE4nPErapOHVc9HDrJ4/sCtTtB+4N1SOU8kPVXtSAgnArf
F6EVgobN1neIlP6xs9GfkztrB0IpcJ0fb2Wd1abYTn+4UWChHCsmaDJOBM9DzmIM
/Fn4Hz+nI9nX/KYZymRuwaS5sOa2nFXGQAH5t+p2ADXybuqalwmzD6Ab+TfNY4yo
0PjZ0EqrLr+8mdXW4LInus6l8tU6uw==
=lflU
-----END PGP SIGNATURE-----

--fR0slUwO6ksDzpKAHnBHvU9vELi78cN37--

