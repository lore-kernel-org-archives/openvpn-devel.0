From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <796722c6-e08b-6de4-67aa-6f2ecc21623e@...515...>
Message-ID: <7fdc9e8e-488f-1b20-82f0-8b3168e82640@...515...>
Date: Fri, 24 May 2019 14:18:25 +0300
MIME-Version: 1.0
In-Reply-To: <796722c6-e08b-6de4-67aa-6f2ecc21623e@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bVdvQx5ndB57ADkCGWi000JeX898grRUq"
Subject: [Openvpn-devel] Summary of the community meeting (23rd May 2019)
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
--bVdvQx5ndB57ADkCGWi000JeX898grRUq
Content-Type: multipart/mixed; boundary="hsC5WSD0TA7GPCQJba4gkBCVxITpqgylR";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <7fdc9e8e-488f-1b20-82f0-8b3168e82640@...515...>
Subject: Summary of the community meeting (23rd May 2019)
References: <796722c6-e08b-6de4-67aa-6f2ecc21623e@...515...>
In-Reply-To: <796722c6-e08b-6de4-67aa-6f2ecc21623e@...515...>

--hsC5WSD0TA7GPCQJba4gkBCVxITpqgylR
Content-Type: multipart/mixed;
 boundary="------------1C2602881EDB457E4EF18FE2"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------1C2602881EDB457E4EF18FE2
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thursday 23rd May 2019
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-05-23>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, lev, mattock and ordex participated in this meeting.

---

Discussed tap-windows6. The two-machine tests are now working on a basic
level on EC2 Windows instances. Testing on physical computers is known
to work, so in the worst case somebody (mattock) will have to setup some
physical Windows Server 2019 (evaluation) instances and run HLK on bare
metal.

Post-meeting note: there is also the possibility that we could avoid the
HLK tests that target physical network adapters (NDISTest) by modifying
driver parameters (ifType, PhysicalMediaType):

<https://docs.microsoft.com/en-us/windows-hardware/drivers/network/keywords=
-not-displayed-in-the-user-interface>
<https://www.iana.org/assignments/ianaiftype-mib/ianaiftype-mib>

---

Discussed "constants.h: make driver not halt on suspend" PR:

<https://github.com/OpenVPN/tap-windows6/pull/86>

Agreed that the PR makes sense, but it needs proper testing before merge.

---

Full chatlog attached.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------1C2602881EDB457E4EF18FE2
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-05-23.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-05-23.txt"

(21:00:55) cron2: YES
(21:01:00) cron2: made it
(21:01:17) dazo: \o/ :)
(21:03:17) mattock: great!
(21:04:08) ordex: hi
(21:04:09) lev__: hello
(21:04:19) ordex: cron2: still in iceland? :)
(21:04:34) cron2: yep
(21:06:11) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
9-05-23
(21:06:13) vpnHelper: Title: Topics-2019-05-23 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:06:18) mattock: "the usual stuff" it seems
(21:06:44) mattock: tap-windows6: I was able to launch two-machine tests =
which did not fail immediately and miserably
(21:06:49) mattock: so things are moving forward
(21:07:12) cron2: good :-) - but didn't you want to have the tests finish=
ed last week already?
(21:08:00) mattock: "want" yes :D
(21:08:41) mattock: "could" no
(21:10:14) mattock: anyways, I will put the HLK client and support machin=
e to run through all the tests next
(21:10:17) dazo: But .... I'll admit I haven't paid too attention to the =
details in this testing .... but .... a) what is breaking now?  b) who wi=
ll fix what?  c) what else needs to be run to complete?
(21:10:54) mattock: on a basic level there should not be anything that ne=
eds fixing on HLK
(21:11:02) mattock: the issues may go away on a rerun
(21:11:06) cron2: a) hopefully nothing, b) either us or Stephen (dependin=
g on what broke)  c) after the test, you get a piece of data, and submit =
that to microsoft to get the keys to the kingdom
(21:11:35) mattock: worst case: I need to setup HLK on real computers (fo=
rtunately I now do have a boatload of laptops I can probably use for that=
)
(21:11:44) mattock: not my own, but probably available
(21:11:57) dazo: is the "two machine test" step the last thing we need to=
 complete to finally close this topic?
(21:11:58) mattock: "test on physical machines" is known to work
(21:12:12) mattock: yes I think so
(21:12:23) mattock: two-machine tests are working a basic level
(21:13:02) mattock: any issues that may arise could be related to virtual=
ization and/or rozmansi's "virtual tap-windows6 patch"
(21:13:02) dazo: have we updated our own docs on all the various steps et=
c?
(21:13:12) mattock: yes of course, there are too many steps to remember t=
hem
(21:13:18) mattock: HLKTesting in the wiki
(21:13:27) mattock: plus I have automated the HLK environment setup
(21:13:30) dazo: cool! thx!  I'll catch up on that later on :)
(21:13:39) mattock: you want to start HLK testing, eh? :D
(21:14:09) ordex: :D
(21:14:13) ordex: dazo always wanted to
(21:14:17) dazo: nope, just get an idea when we might close this topic :)=

(21:14:31) mattock: ah how I would love that :D
(21:14:33) dazo: and I've heard "next week" for half a year or so ;-)
(21:14:55) dazo: btw .... I believe lev__ might have a few bugfixes to ta=
p-windows6 too
(21:14:58) mattock: now, it seems likely that we (company) will get someb=
ody else to take the pain going forward (post-this-release)
(21:15:01) mattock: he sure does
(21:15:12) lev__: speaking of tap-windows6, are we OK to merge no_halt_on=
_suspend thing
(21:15:29) cron2: lev__: don't be so impatient
(21:15:37) cron2: if we're OK, I'll merge it
(21:16:11) mattock: also note that every change to tap-windows6 will requ=
ire me to run all the tests again :D
(21:16:22) mattock: so let's bundle them when the tests are passing
(21:16:47) dazo: backstory to that is that we want to ship an updated tap=
-windows6 driver with a coming OpenVPN Connect .... which currently doesn=
't handle suspend/resume too well.  We have a "workaround" in the OpenVPN=
 3 Core Lib .... but it isn't the proper fix
(21:17:42) dazo: mattock1: understood .... and that might be needed in no=
t too far future
(21:17:48) cron2: dazo: it might well be the right fix, but we need a bit=
 more exposure and testing
(21:17:57) dazo: agreed!
(21:18:13) mattock: dazo: for openvpn connect you don't need Windows Serv=
er 2016/2019 support, or do you?
(21:18:15) cron2: so I'm all for having a driver *with* that change out a=
nd tested, and I think Selva is also mostly fine
(21:18:37) dazo: mattock1: I doubt so for the few first releases
(21:19:27) mattock: dazo: then you just need cross-signed / attestation s=
igned
(21:19:31) mattock: but enough of tap-windows6?
(21:21:24) dazo: so openvpn 2.5?
(21:21:38) cron2: seems like it
(21:22:16) dazo: how good have we been at updating https://community.open=
vpn.net/openvpn/wiki/StatusOfOpenvpn25 ?
(21:22:18) vpnHelper: Title: StatusOfOpenvpn25 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:22:37) ordex: not so good
(21:22:39) cron2: well
(21:22:59) cron2: we didn't actually get anything major done in the last =
6 months, so the page was updated 2 months ago - that is better than the =
rest
(21:23:25) ordex: we made some progress on sitnl (hurray!!)
(21:23:34) cron2: yeah, the above was a bit unfair
(21:23:53) dazo: :)
(21:23:55) cron2: I was making progress with merging that but this week's=
 conference got in the way.  Will continue with merging & rambling over t=
he weekend
(21:24:45) dazo: cool!  I'm planning to allocate lots of hours tomorrow f=
or openvpn 2 coding and maybe even some review
(21:25:05) cron2: what is on your coding plate?
(21:27:09) dazo: fixing up the plugin examples (low prio) ... and I thoug=
ht the struct argv patches where applied, but seems there is still some m=
ore work here and review plaisthos' auth-token-hmac patches
(21:27:26) cron2: (I'll be travelling for ~7 hours tomorrow - bus, 4h pla=
ne, train - so won't get much done)
(21:27:40) dazo: no worries
(21:28:16) cron2: dazo: review is always welcome :-) - I was just wonderi=
ng which coding bits you had.  There's a bit of plugin stuff indeed, and =
argv...
(21:28:20) dazo: but if there's anything eminent I should dive into, let =
me
(21:28:21) dazo: know
(21:30:07) cron2: having plaisthos' patch set reviewed & ACKed would be g=
reat, and seems to fall squarely into your field of expertise
(21:30:22) dazo: yeah, I'm fine with reviewing that
(21:30:26) cron2: (and would sort out a number of open issues plus other =
no-longer-needed-then patches)
(21:31:16) cron2: ordex: what's keeping you busy these days?
(21:32:09) ordex: I was busy with all kind of offices here in ITaly in th=
e past two weeks and now I am catching up on my corp backlog
(21:32:16) ordex: it has all been a bit unfortunate :/
(21:32:28) ordex: but I am trying to get back to "get stuff done"
(21:32:54) ordex: I'll try to force myself to stop everything and so some=
 community work tomorrow too
(21:32:57) ordex: *do
(21:33:14) ordex: otherwise there will always be "this something else tha=
t needs to be done"
(21:33:16) ordex: :S
(21:33:22) dazo: hehe ... yeah
(21:33:46) dazo: but if you get a chance (you have the corp blessing) to =
do community work, that's all good!
(21:33:59) ordex: yap
(21:34:36) cron2: great :)
(21:34:46) cron2: now if we can revive syzzer...
(21:35:53) ordex: :D
(21:36:21) cron2: so... anything else on 2.5?  (I'm not going to do revie=
w today - leaving for a nice social evening soonish and have my head else=
where)
(21:37:00) ***dazo got another meeting in 25 min as well
(21:37:10) ordex: +1 for the social event ;P
(21:38:03) cron2: (as a side note, with kids around, december is already =
really stressful, with lots of "pre-christmas" activities - so this is wh=
y I can't do any december dates)
(21:39:03) mattock: ok call it day?
(21:39:13) ordex: yeah, I think most of us will be in that situation, but=
 I wanted to propose them for democracy sake :)
(21:39:52) cron2: +1 to both :)
(21:40:07) ***cron2 holds his thumbs for the HLK tests  ;)
(21:40:07) dazo: yeah, December is horrendous for anything but family
(21:40:16) ordex: and food
(21:40:17) ordex: :D
(21:40:51) cron2: so.  *wave*
(21:40:59) dazo: o/
(21:41:22) ordex: <o
(21:41:50) mattock: bye!

--------------1C2602881EDB457E4EF18FE2--

--hsC5WSD0TA7GPCQJba4gkBCVxITpqgylR--

--bVdvQx5ndB57ADkCGWi000JeX898grRUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlzn0wEACgkQKVhNn0CG
RXgzZQgAjcIq60W1vnGdZDraGGuhona7MCOrktR09yQ30fofdlc7AiOBF2K2zME5
6Kzl0X3wKX5X9zYmPFsLEHuky5tpY9+OEuAC9Pmm+YcOJkgARAslHCFj16bCOVsm
mITRANrh+UJyyaqwMGrorz2f2UkpDt33tUvCjZ+TnipJKdUKOCRowmewv2GKxn2x
tgfKdVd3Ulkwft+2N17K4Vg2IwVxEXHcnEyFfZqLGc97vtfBOZNdPvlTwV81TPSr
bfbjqTSUJfFRYGuX4nIlLKVmcsbwtzvstoQWRNtIo+BajZhJNyxnBVhPrwaVeeWn
Hasn7T+n5oVFjfojLpmf/eM2RvzwRQ==
=fu1+
-----END PGP SIGNATURE-----

--bVdvQx5ndB57ADkCGWi000JeX898grRUq--

