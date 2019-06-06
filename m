From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <e55f098a-1ba1-02d7-5f50-b12e4eec054a@...515...>
Message-ID: <0dc16d10-ee4a-0171-853b-f3c0d538a1e8@...515...>
Date: Thu, 6 Jun 2019 22:10:51 +0300
MIME-Version: 1.0
In-Reply-To: <e55f098a-1ba1-02d7-5f50-b12e4eec054a@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gsDq6T0tJ2Ii4DOfYuZTKigHvWQ2zPQfH"
Subject: [Openvpn-devel] Summary of the community meeting (6th June 2019)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gsDq6T0tJ2Ii4DOfYuZTKigHvWQ2zPQfH
Content-Type: multipart/mixed; boundary="AXjiqHytWQIjAWYDC2RgqMODJf9hm5Xmo";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <0dc16d10-ee4a-0171-853b-f3c0d538a1e8@...515...>
Subject: Summary of the community meeting (6th June 2019)
References: <e55f098a-1ba1-02d7-5f50-b12e4eec054a@...515...>
In-Reply-To: <e55f098a-1ba1-02d7-5f50-b12e4eec054a@...515...>

--AXjiqHytWQIjAWYDC2RgqMODJf9hm5Xmo
Content-Type: multipart/mixed;
 boundary="------------DA3AA018D07CD2BBB0CDB3CA"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------DA3AA018D07CD2BBB0CDB3CA
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thursday 6th June 2019
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-06-06>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, ecrist, lev, mattock and ordex participated in this meeting.

---

Noted that the next OpenVPN hackathon will be arranged in Trento, Italy
on weekend of 8th November 2019. We will need many cakes, and a
particularly big HLK cake (assuming all HLK tests have passed by then).

---

Discussed tap-windows6 HLK testing. HLK tests are running in mattock's
physical HLK environment, but they take a huge amount of time. It may
actually be possible to make a release for Windows Server 2016/2019 next
week.

---

Discussed lev's patch to tap-windows6:

<https://github.com/OpenVPN/tap-windows6/pull/86>

OpenVPN 3 developers have some reports that it works but not with
hibernate/resume (which worked before). The error is different, though,
but it claimed that the problem surfaced with this change. Investigation
is ongoing.

---

Talked about wintun. Lev would like to get somebody to test his wintun
support in OpenVPN 2.

---

Discussed the DoS attack on forums. It was narrowed down to a single IP.
Based on historical data this kind of DoS is very rare on forums so no
action is needed at the moment.

Mattock will ensure that alert emails from forums, community (trac) and
community LDAP go to erist as well.

---

Discussed our Patchwork installation. It was agreed that an upgrade
would be useful. Mattock was fine with upgrading it after the HLK thing
is done.

---

Noted that OpenVPN 2.5 is progressing in various areas.

Next mini-hackathon will be arranged tomorrow (7th June) starting in
European morning. As usual, it will focus on OpenVPN 2.5 work.

---

Full chatlog attached.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock




--------------DA3AA018D07CD2BBB0CDB3CA
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-06-06.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-06-06.txt"

(21:00:38) mattock: good evening people!
(21:00:46) mattock: or morning, or whatever
(21:00:47) mattock: :)
(21:02:01) ordex: everything !
(21:02:26) ***cron2 feels sleepy, so it could be morning or evening or af=
ternoon
(21:03:31) mattock: ecrist: there?
(21:05:00) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
9-06-06
(21:05:01) vpnHelper: Title: Topics-2019-06-06 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:05:06) mattock: #1 "hackathon planning"
(21:07:03) ordex: yeah
(21:07:13) ordex: so, today I have sent an email saying that Nov 8th is c=
onfirmed
(21:07:15) lev__: hello
(21:07:24) ***dazo is here
(21:07:39) cron2: which was about the reason why I put the topic on the a=
genda - have the date fixed so we can all start planning
(21:07:43) ordex: not sure there is much more to do on your side - I will=
 provide some details about accommodations in the area
(21:07:46) ***cron2 intends to take the train to trento
(21:07:55) mattock: hi!
(21:08:05) cron2: maybe bring $wife along if grandparents can take the ki=
ds...
(21:09:12) ordex: not a bad idea :)
(21:10:07) cron2: and we need to agree on the number of cakes to bring al=
ong :-)
(21:10:13) ordex: :D
(21:10:19) cron2: mattock needs to bring a MONSTROUSLY HUGE HLK cake
(21:10:22) ordex: I don't think there is any overflow risk
(21:11:31) mattock: maybe we should order the cake(s) on-site
(21:12:06) ordex: or cook onsite :D
(21:12:10) mattock: yeah
(21:12:53) cron2: this sounds like fun :-) - not sure it will make the ha=
ckathon turn out more code, but fun, definitely
(21:13:06) ordex: hehe
(21:13:15) ordex: if it's successful we can do v2 shortly after ;P
(21:13:24) mattock: so, shall we move forward from hackathon cakes?
(21:13:25) mattock: :P
(21:13:30) ordex: yeah
(21:13:42) mattock: maybe buildslave updates off the topic list
(21:13:52) mattock: so I just managed to have a quick look at some of the=
 failures
(21:14:00) cron2: ohyeah :)
(21:14:21) mattock: this may have been discussed earlier but I'll ask: is=
 there a known fix for the cmocka issue?
(21:14:30) cron2: what is "the cmocka issue"?
(21:14:41) mattock: ok, let's discuss this tomorrow in the hackathon then=
 :)
(21:14:42) ***cron2 is not sure
(21:15:19) cron2: I have fixed my cmocka issues by breaking "git submodul=
e", so it won't do the submodule init and the older buildslaves are happy=

(21:15:36) mattock: I'll have to investigate my particular issue then
(21:15:39) mattock: anyways
(21:15:57) mattock: tap-windows6 updates: most of the HLK tests have run,=
 there have been quite a few non-deterministic failures
(21:16:06) mattock: reruns generally succeed
(21:16:25) cron2: is this sufficient?  "try long enough until everything =
has succeeded once"?
(21:16:30) mattock: there is one configuration on the HLK client/support =
I have to fix, which might help make those problems go away
(21:16:35) mattock: yeah, it should be enough
(21:16:45) mattock: I have not even bothered with the tests that require =
special configuration
(21:16:54) mattock: just wanted to get most of them look green
(21:17:04) mattock: then debug and fix whatever remains
(21:17:04) cron2: so what nexxt?
(21:17:16) mattock: babysit the tests (they take a huge amount of time an=
d occasionally hang)
(21:17:35) cron2: is this "master" or "with rozmansi's changes wrt virtua=
l ethernet"?
(21:17:45) cron2: and with or without lev__'s change?
(21:18:07) mattock: rozmansi patch caused issues with some tests as jamal=
lx mentioned
(21:18:26) mattock: I believe (would have to check) that this is plain "m=
aster"
(21:18:54) cron2: mmmh.  We need more active communication on this... roz=
mansi's patch should make issues disappear, not new ones appear...
(21:19:43) mattock: I talked to rozmansi last week and he said he'd try t=
o have a look at the various settings in the inf file to see if those mak=
e difference in _what_ tests need to run
(21:19:58) mattock: I had a look at his settings + MS docs and his guess =
seemed the "correct" one
(21:20:34) lev__: it would be nice if rozmansi could have a look at openv=
pn2 wintun patch=20
(21:20:47) mattock: rozmansi is very, very busy
(21:20:56) mattock: that is the challenge
(21:21:37) mattock: but anyways, HLK is getting there and I have rather h=
igh hopes that we will be able to actually do a release (next week)
(21:21:51) lev__: I got 27% better performance with wintun comparison to =
wintap in recent tests
(21:22:12) cron2: lev__: how do you talk to wintun from ovpn3?
(21:22:57) dazo: in regards to lev__'s patch to tap-windows6 ... if it's =
the sleep/resume issue ... we have some reports it works but not with hib=
ernate/resume (which worked before).  Different error, though, but claims=
 is they surfaced with this change .... lev__ might have more details
(21:23:10) lev__: cron2: same as in openvpn2 - createfile to open device,=
 ipconfig to set up routing
(21:23:33) dazo: lev__: thos 27% ... is that with mbedtls or openssl?
(21:23:43) cron2: lev__: so openvpn3 runs as admin?
(21:23:55) lev__: dazo: with openssl
(21:24:02) lev__: cron2: yep
(21:24:39) dazo: lev__: nice! ... iirc, prior tests the diff was less wit=
h openssl
(21:24:41) cron2: mmmh.  I had hoped you have a "does not need to run as =
admin" solution there, like "use the service to open the driver"
(21:24:48) lev__: there is a report that Connect client doesn't reconnect=
 after "deep sleep", but I wasn't able to reproduce it so far
(21:25:13) lev__: cron2: that's a flag in wintun, they decided to limit i=
t to admins and localsystem
(21:25:45) lev__: "Indeed we're keeping it"
(21:25:45) lev__: locked down to SYSTEM for the time being. As we gain a =
better
(21:25:45) lev__: understanding of the attack surface, maybe we'll reduce=
 that to
(21:25:47) lev__: built-in administrators.
(21:25:47) cron2: lev__: I understand that part :-) - you can't setup rou=
ting without admin privs, but we still do
(21:26:17) cron2: so, maybe is "use the service to open the driver and pa=
ss a file handle back to openvpn"...
(21:26:25) cron2: a possible approach
(21:26:42) dazo: that restriction makes somewhat sense ... but I think a =
similar approach to what Android does, passing the tun/wintun fd to an un=
privileged openvpn process makes sense ... iservice might be the entrance=
 here
(21:26:54) dazo: what cron2 says :-P
(21:27:18) lev__: dazo: there is no difference in wintun/tap performance =
with openvpn3 + openssl=20
(21:27:30) cron2: reprasing my question... Connect on windows has its own=
 service today.  Does ovpn3 use said service, or the iservice, or no serv=
ice at all today?
(21:27:47) dazo: lev__: ahh, right ... I'm mixing things
(21:28:16) cron2: lev__: this is curious, because it hints "the performan=
ce issue is not in tap6"
(21:28:28) lev__: cron2: the "classic" connect which has been around for =
years uses service
(21:28:30) dazo: cron2: what lev__ is using now, is cli.exe - a reference=
 client shipped in openvpn3 project ....
(21:28:50) dazo: cron2: and Connect uses the service ... but we don't hav=
ea Connect client with wintun yet
(21:28:57) cron2: so there is no "Connect based on ovpn3" yet?
(21:29:08) dazo: current Connect uses service + ovpn3
(21:29:17) dazo: (with tap-windows6)
(21:30:02) lev__: the new "universal connect?" (or whaever it is called) =
uses "agent" process which runs as a service to set up routing, but it op=
ens device under unprivileged process=20
(21:30:32) cron2: dazo: so "agent" is the "new iservice" for Connect?
(21:30:36) dazo: this "agent" is somewhat similar to iservice, yes
(21:30:38) cron2: (we need to get terminology right here)
(21:30:43) lev__: yep
(21:30:54) dazo: (very different approach, but serves the same purpose)
(21:31:23) ***cron2 looks forward to an architecture description in Trent=
o :-)
(21:31:32) ecrist: sorry, I'm here
(21:31:36) dazo: heh
(21:31:39) ecrist: I know I'm late
(21:31:54) dazo: no worries
(21:32:46) mattock: hi ecrist!
(21:33:07) ecrist: hello!
(21:33:27) lev__: also I am not quite sure about buffer size for wintun, =
in worst case it could be 256*0xF000 and there is no scatter / gather IO =
support
(21:33:53) lev__: I use somethng like 1500 * 256 which tends to work
(21:34:10) dazo: so there seems to be room for improvements in the wintun=
 api, but it's a good starting point
(21:35:00) lev__: I would appreciate if someone besides me could give win=
tun patch a try
(21:37:07) mattock: and then came silence
(21:37:30) dazo: :)
(21:37:36) lev__: I think everyone are busy building openvpn2 with wintun=

(21:37:43) mattock: I'm sure :)
(21:37:54) ***cron2 knows this particular silence
(21:38:34) mattock: shall we move on and just accept that nobody will com=
ment on lev's proposal? :P
(21:39:00) mattock: we still have a couple of topics to cover, especially=
 now that ecrist is here
(21:39:13) cron2: yeah
(21:39:40) mattock: ok so the possible DoS attack on forums a while back
(21:39:47) mattock: ecrist: any further info on that one?
(21:40:21) ecrist: we narrowed it down to a single customer of a large pr=
ovider
(21:40:24) ecrist: it's stopped since
(21:40:35) cron2: not even distributed...
(21:41:16) ecrist: based on the feedback I recevied in the past about clo=
udflare, I don't think we should, or really need, to put it in front of t=
he forum
(21:41:44) cron2: not sure how well cloudflare works for more interactive=
 content
(21:42:36) mattock: we do have it in front of everything "commercial", bu=
t I agree that if this kind of thing only happens every 5 years let's not=
 put CloudFlare in front
(21:42:42) mattock: of forums
(21:43:09) ecrist: since the forums were founded in '08, I can count on o=
ne hand the number of times we've had issues.
(21:43:10) mattock: we had it in front of Trac for a while, but it caused=
 annoying CAPTCHA issues
(21:44:00) ecrist: if there are issues that crop up, *I* don't expect the=
 corp guys to have to deal with it, just send me a text and I'll fix it
(21:44:19) cron2: where is the forum hosted today?
(21:44:22) mattock: EC2
(21:44:38) mattock: by OpenVPN Inc.
(21:44:46) mattock: ecrist is the effective maintainer though
(21:45:02) mattock: I generally touch it when I work on some puppet stuff=
 which might affect FreeBSD
(21:46:09) mattock: at the moment we don't have SMS alerts in general
(21:46:21) ecrist: just so it's out there, I'm perfectly fine taking comm=
unity stuff out of corp hands if it's a problem
(21:46:59) mattock: the corp guys just dislike seeing the alerts if they =
are unable to do anything about them :)
(21:47:16) cron2: you can document the "doing" bit -> "send mail to ecris=
t"
(21:47:21) cron2: so they know they can do something
(21:47:22) cron2: solved
(21:47:36) dazo: If the corp side cut be somewhat more hands-on when issu=
es crop-up, that would be beneficial ... I am NOT saying corp side should=
 take over the responsibility, but kind of know what's happening and can =
take immediate actions while ecrist is sleeping or unavailable ... to kin=
d of spread the maintenance load - and also include the corp side more on=
 the community side as well
(21:47:40) mattock: even better, if we configured SMS alerts we could hav=
e forums alerts go directly ecrist
(21:48:44) mattock: the "normal" solution on the corp side is to use Clou=
dFlare everywhere, which is the reason why that was to first medicine her=
e as well
(21:49:08) mattock: ecrist: do you actually get email alerts from forums?=

(21:49:09) mattock: can't recall
(21:49:30) mattock: that could be done fairly easily
(21:49:36) ecrist: no
(21:49:38) ecrist: I don't
(21:49:42) mattock: ok, want me to fix that?
(21:50:30) ecrist: sure
(21:51:12) mattock: forums only?
(21:51:19) mattock: ldap, community, patchwork?
(21:51:46) ecrist: not patchwork, but ldap, community, forums
(21:51:55) mattock: ok
(21:52:00) mattock: noting that in my ticket
(21:52:09) ecrist: and, I *did* send instructions last time we had a prob=
lem, even specific commands that could be used
(21:52:29) mattock: last time =3D this time, or way back when?
(21:52:36) ecrist: January
(21:52:38) ecrist: iirc
(21:53:21) mattock: ok, not sure if the guys remembered that
(21:54:15) ecrist: I'm guessing not. :)
(21:54:27) dazo: speaking of patchwork ... how up-to-date is it?
(21:57:13) cron2: I have not yet ticket off the sitnl patchset
(21:57:27) cron2: (because I want to write a summary and want to discuss =
next steps with ordex)
(21:57:31) cron2: besides this, should be accurate
(21:58:05) dazo: oh, I meant the patchwork software ... not our usage of =
it :)
(21:58:09) mattock: ah
(21:58:13) cron2: ah :-)
(21:58:23) mattock: it has not been updated since install
(21:58:29) mattock: does that answer your question?
(21:58:31) mattock: :)
(21:58:51) mattock: I'm more than happy to upgrade it post-HLK
(21:58:58) dazo: yes, can we look at an upgrade here?  I wonder if that w=
ould help making 'git pw' integrate better
(22:00:56) mattock: I guess I answered that as well
(22:00:58) mattock: I will create a ticket
(22:01:14) mattock: any other topics
(22:01:19) mattock: 1 hour 1 minute already
(22:01:22) dazo: yeah, just timing and network latency confusing us :)
(22:01:46) cron2: 64 bytes from 195.30.0.2: icmp_seq=3D1870 ttl=3D55 time=
=3D6939 ms
(22:01:52) cron2: this is latency...
(22:02:01) cron2: anyway, short update on 2.5
(22:02:05) dazo: I've started for real looking into plaisthos auth-token-=
hmac patches ... found an issue with 'make check', so I believe we will s=
ee some updates ... but generally diving through the patches
(22:02:40) cron2: sitnl mostly merged, except for a showstupper in 5/7
(22:03:54) cron2: and there is cleanup work to do (uncrustify, make check=
 fails, ...)
(22:04:10) cron2: then, small patches (syzzer stuff) next, then ipv6-only=

(22:04:45) dazo: you can throw autoconf/automake stuff my way ... I begin=
 to get a fairly good grasp on that these days
(22:05:49) mattock: regarding openvpn 2.5 - who can make it to mini-hacka=
thon tomorrow?
(22:05:53) cron2: this is good - opened a trac ticket (on the config.h st=
uff) just yesterday
(22:06:20) cron2: wrt tomorrow: I need to urgently show up in the datacen=
ter tomorrow to get stuff finished that was due last week.  But I will be=
 around afternoonish
(22:06:23) mattock: my focus will be "fix buildslaves", "babysit HLK" (th=
e latter being the norm these days)
(22:06:24) dazo: I am planning on it tomorrow .... and I hope ordex, lev_=
_ and plaisthos will join too :)
(22:06:34) cron2: cool
(22:06:44) mattock: maybe lev can force you guys to test wintun
(22:06:46) mattock: :P
(22:06:55) dazo: cron2: if I seem to be missing ... send me a grumpy mail=
! ;-)
(22:07:06) cron2: dazo: you bet!
(22:07:27) mattock: meeting concluded?
(22:07:34) cron2: (I'll just push a commit removing Dazo's name from all =
files... :-) )
(22:07:45) cron2: mattock1: good night
(22:07:50) cron2: see you tomorrow
(22:07:59) mattock: bye guys!
(22:08:06) ecrist: l8r folks

--------------DA3AA018D07CD2BBB0CDB3CA--

--AXjiqHytWQIjAWYDC2RgqMODJf9hm5Xmo--

--gsDq6T0tJ2Ii4DOfYuZTKigHvWQ2zPQfH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlz5ZTsACgkQKVhNn0CG
RXjhPAf/UBSI00xzfjqAxSItrWtoKDldAbVjJHgLNCCE7wMTkoJ0bXxgQ7J1oQO1
YQZ5fh2hiQa1bbU7DOteGlsgQaPjhmVHFcrn7jeN1ZZF1BU9Opd4ZMHao9m0n/cs
zkMLyM+KqVKGOy0UPghjsBsu9qKpGEerAqAFvX+Lxwi569EDibgotW13Peq3esXR
GGx+2OfkXPHvBq+H78SSxgs4hKVYqRk7JSSxTvYHSSxrt13CuNcbHHnedmOTMfN0
oASNAWffP2twjhtif6JxXcz+peIJhe6qA0mUiCVoRA3kvzuIcoNo5WVRfGZab0i2
MuOwxLnY8oCXZnhCfsQEM0eSrqw7ig==
=9I5D
-----END PGP SIGNATURE-----

--gsDq6T0tJ2Ii4DOfYuZTKigHvWQ2zPQfH--

