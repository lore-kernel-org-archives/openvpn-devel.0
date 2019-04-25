References: <d1f51e3f-4fea-373d-f5e7-5acaedafbb8d@...515...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <85349721-fc54-0ab6-ac0c-7fda31052840@...515...>
Date: Thu, 25 Apr 2019 22:32:52 +0300
MIME-Version: 1.0
In-Reply-To: <d1f51e3f-4fea-373d-f5e7-5acaedafbb8d@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oW7G6nNT5d2SYstMuQnPiEJA3NQ51iauS"
Subject: [Openvpn-devel] Summary of the community meeting (25th April 2019)
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
--oW7G6nNT5d2SYstMuQnPiEJA3NQ51iauS
Content-Type: multipart/mixed; boundary="Hp9E6jK4djQnbxm3oEaSrSxovQfktxyO2";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <85349721-fc54-0ab6-ac0c-7fda31052840@...515...>
Subject: Summary of the community meeting (25th April 2019)
References: <d1f51e3f-4fea-373d-f5e7-5acaedafbb8d@...515...>
In-Reply-To: <d1f51e3f-4fea-373d-f5e7-5acaedafbb8d@...515...>

--Hp9E6jK4djQnbxm3oEaSrSxovQfktxyO2
Content-Type: multipart/mixed;
 boundary="------------72FA2D5D18610CB30B49A8DF"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------72FA2D5D18610CB30B49A8DF
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thursday 25th April 2019
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-04-25>

The next meeting is scheduled to Wednesday 1st May 11:30 CEST.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock, rozmansi and zx2c4 participated in this
meeting.

--

Noted that the tap-windows 9.23.3 release looks to be stable. Next in
line for mattock is HLK testing of tap-windows6.

That led into a detailed discussion about HLK and Windows driver signing
in general. Zx2c4 has worked on it in the Wintun project:

<https://www.wintun.net/>

According to zx2c4 experience it is possible to run the HLK test suite
on Windows Server 2019, yet get a signature for Windows Server 2019
_and_ 2016. It seems that Windows 10 is treated as one big "blob" as far
as HLK test submission / signature validity is concerned.

It was also noted that HLK can be setup from pre-built virtual machine
images:

https://www.microsoft.com/en-us/evalcenter/evaluate-virtual-hardware-lab-kit

Mattock has Puppet+DSC-based automation to configure HLK controllers and
clients. He will publish them, probably tomorrow, for zx2c4 and others
to see and use.

--

Noted that the OpenVPN 2.5 mini-hackathon is coming on Friday next week.

--

Full chatlog attached.


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------72FA2D5D18610CB30B49A8DF
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-04-25.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-04-25.txt"

(21:03:26) mattock: hi!
(21:03:30) rozmansi: hi
(21:03:35) cron2_: ho!
(21:03:37) mattock: good evening everyone!
(21:07:01) ***dazo is here too
(21:09:23) mattock: ok ops meeting over
(21:09:32) mattock: so let's check the agenda
(21:09:51) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
9-04-25
(21:09:52) vpnHelper: Title: Topics-2019-04-25 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:09:59) mattock: I can do #1 quickly
(21:10:10) mattock: tap-windows 9.23.3 looks to be stable
(21:10:17) dazo: \o(
(21:10:21) dazo: \o/
(21:10:28) mattock: so far only one issue in the installer release, and t=
hat was unrelated to tap-windows
(21:10:45) mattock: so my next big project is HLK testing + Windows Serve=
r 2016
(21:11:14) mattock: "just need to do it" basically
(21:11:20) mattock: and see if any pieces are missing
(21:11:33) zx2c4: why server 2016 and not server 2019?
(21:12:26) mattock: we need both, but we need to start from somewhere
(21:12:58) mattock: tap-windows6 needs to pass the HLK test suite on both=
, that is
(21:13:23) cron2_: really?  ewww
(21:13:24) rozmansi: @mattock1 you sure about that?
(21:13:24) mattock: otherwise MS will not hand us code signatures for the=
 driver, and the driver won't load
(21:13:39) ***cron2_ had hoped that one of the platforms + HLK would be g=
ood enough for both
(21:13:48) mattock: rozmansi: "sure" is a strong word, but I think so
(21:13:55) dazo: Or at least if it passes 2019, it will work on 2016
(21:14:01) zx2c4: mattock1: i dont think you're correct
(21:14:07) mattock: I hope I'm not
(21:14:16) zx2c4: are you assuming or do you have documentation that say =
so?
(21:14:23) mattock: do you have?
(21:14:39) zx2c4: im asking you: is your supposition based on something f=
actual you read, or are you just assuming
(21:14:52) mattock: I can't recall
(21:14:56) zx2c4: i have experience to the contrary, but maybe im relying=
 on a microsoft bug rather than intended behavior
(21:15:05) mattock: ok that is better than what I have
(21:15:14) zx2c4: namely, submitting results for 2019 results in a Server=
 RS5 certification, which works in 2016 and 2019
(21:15:25) rozmansi: I can confirm that
(21:15:26) mattock: oh microsoft documentation is so inadequate
(21:15:32) zx2c4: yes.
(21:15:38) rozmansi: totally. Lots of guessing involved.
(21:16:04) mattock: zx2c4: does passing the test suite on 2016 help with =
2019?
(21:16:10) mattock: or does it have to go the other way around
(21:16:15) zx2c4: not sure, havent tried that
(21:16:19) mattock: ok
(21:16:34) mattock: we can test and see then
(21:16:36) zx2c4: anyway, if dazo wants to generally repair relations and=
 such, i'm happy to exchange knowledge on this and work together. we just=
 succeeded today in getting sever signatures from microsoft
(21:16:45) zx2c4: server signatures*
(21:17:07) mattock: may I inquire who are we? :D
(21:17:11) cron2_: huh, what's that about "repair relations and such"?
(21:17:11) dazo: Since rozmansi and zx2c4 both have experience with getti=
ng needed signatures via 2019 which works on 2016 ... I'd say we run the =
same path
(21:17:33) mattock: dazo: I would agree, but I have Server 2016 _now_
(21:18:16) mattock: I mean, it is probably quite adequate for finishing u=
p the HLK test setup and testing stephen's changes
(21:18:27) mattock: that can happen while waiting for 2019 instance
(21:18:29) mattock: which might take a bit
(21:18:38) mattock: anyways, this was good info
(21:18:38) zx2c4: cron2_: dazo has written me a series of rude emails and=
 is intent on publishing misinformation on wireguard or something. i dont=
 know. i was super amped up to work on this with everyone but now i have =
a sour feeling about it. hence hoping dazo will take the initiative in re=
pairing relations.
(21:18:47) zx2c4: mattock1: check out the virtual images that microsoft p=
rovides
(21:18:52) zx2c4: you can get the whole thing in a pre-built VHD
(21:19:12) mattock: I have everything automated already
(21:19:19) mattock: HLK environment I mean
(21:19:31) zx2c4: https://www.microsoft.com/en-us/evalcenter/evaluate-vir=
tual-hardware-lab-kit
(21:19:35) vpnHelper: Title: Microsoft Evaluation Center (at www.microsof=
t.com)
(21:19:35) zx2c4: oh, cool
(21:20:02) mattock: that said, I would probably have used those images if=
 I knew they existed :D
(21:20:05) mattock: for initial testing at least
(21:20:46) zx2c4: of course with microsoft stuff, its always a matter of =
disk space and bandwidth for yet-more-vhds
(21:21:28) zx2c4: working now on getting the same signature to work with =
both windows < 10 and windows >=3D 10
(21:22:06) mattock: my understanding based on MS docs is that that is not=
 possible unless you submit both HCR and HLK test suites
(21:22:23) mattock: but if the logic is the same as with server 2016/2019=
 then that might actually be a viable option
(21:22:25) rozmansi: interesting
(21:22:57) zx2c4: mattock1: yea... that's what its looking like
(21:23:08) zx2c4: evidently its possible to merge HCK into an HLK result
(21:23:13) zx2c4: inside of studio
(21:23:13) mattock: yes
(21:23:49) zx2c4: OTOH, windows < 10 only requires an EV signature
(21:23:58) mattock: that is correct
(21:24:02) zx2c4: loosing windows update stuff would be a shame but
(21:24:13) zx2c4: it might be possible to merge signatures
(21:24:21) zx2c4: have you had any luck with tinkering with the .cat file=
?
(21:25:06) mattock: no, I tried having two signatures on the driver (cros=
s-signed + attestation) but Windows 7 was unhappy with it
(21:25:17) mattock: it seemed to only look at the first (attestation) sig=
nature and fail
(21:25:41) zx2c4: i've succeeded at using EV-signed .cat file with WHQL-s=
igned .sys file on windows 7
(21:25:47) mattock: attestation signing strips of any existing signatures=
 from the driver (but not executables such as tapinstall.exe)
(21:26:01) mattock: wow that sounds like a hack :D
(21:26:05) zx2c4: i haven't yet tried WHQL-signed .sys file with EV-signe=
d .cat file on windows 10
(21:26:23) mattock: if I recall correctly Windows does not even require a=
 signed sys file
(21:26:26) zx2c4: i was just starting to play with this as the meeting be=
gan
(21:26:46) zx2c4: right. the .cat stuff is supposed to be totally detache=
d. but interestingly, partner portal returns a dual-signed .sys.
(21:27:21) mattock: ok
(21:27:52) zx2c4: on a related topic, by the way, i understand you guys t=
o have wintun integration into openvpn in the pipeline?
(21:27:58) rozmansi: (@mattock1 why are you trying to attestation sign ta=
pinstall.exe?)
(21:28:10) mattock: rozmansi: I'm not trying, it comes as a bonus
(21:28:13) mattock: side-effect
(21:28:19) mattock: it does not seem to hurt
(21:28:22) zx2c4: oh because it's  part of the inf cab situation?
(21:28:25) mattock: yes
(21:28:42) zx2c4: i was thinking of hijacking that in order to distribute=
 all of wireguard4windows over windows update...
(21:28:53) mattock: but I guess you could have pretty much anything signe=
d if it is inside the cab
(21:29:09) mattock: by microsoft that is
(21:29:10) cron2_: zx2c4: "pipeline" is a big word.  We think it might be=
 a good fit and help with windows performance, but nobody had time to loo=
k into what code changes are needed.
(21:29:26) zx2c4: cron2_: some alpha test would indeed be quite useful
(21:29:37) zx2c4: to at least do a back-to-back comparison wit htap6 with=
 the same codebase
(21:30:38) cron2_: yep
(21:31:33) dazo: From the corp side, we will look into what's needed to i=
mplement wintun support in the OpenVPN 3 code base, as that has much clea=
rer code separation than openvpn 2 - so it will be simpler to implement .=
=2E.. and the reference client in the project will be used to provide som=
e performance numbers between tap-windows6 based builds and wintun based =
builds
(21:32:14) zx2c4: good to hear.
(21:32:15) dazo: and based on that OpenVPN 3 implementation we know bette=
r what's required to do a similar approach in OpenVPN 2
(21:32:35) cron2_: dazo: sounds good
(21:32:38) zx2c4: mattock1: confirmed - the .sys signature is ignored, so=
 my trick doesn't transfer cleanly to windows 10
(21:34:05) mattock: zx2c4: ok
(21:34:30) mattock: what I would love to know what platforms you actually=
 need to run HCR/HLK on to get a valid signature for all supported Window=
s versions
(21:34:38) zx2c4: yea
(21:34:50) mattock: 2016/2019 seem to be coupled somehow
(21:34:51) zx2c4: the minimum set of machines required for a maximum cert=
ification version of X
(21:35:10) rozmansi: HLK: Windows Server 2016 for controller(+studio), Wi=
ndows Server 2019 for test machine(s)
(21:35:10) mattock: are any of the desktop versions coupled like that?
(21:35:40) mattock: even microsoft guys don't seem to know the answer
(21:35:42) zx2c4: well i think when you say 2016/2019 are coupled
(21:35:46) zx2c4: what you really mean is=20
(21:35:47) rozmansi: mind there was a new HLK released a few days ago.
(21:35:48) zx2c4: "Windows 10 is one thing"
(21:36:00) zx2c4: right, and we havent yet tried the new 19h1 insider stu=
ff
(21:36:02) mattock: well that would be quite nice
(21:37:08) rozmansi: and you will need one Windows Server 2019 Core in yo=
ur test cluster, because one of the test is about being able to run on a =
GUI-less Windows Core.
(21:37:08) mattock: when I spoke with MS developer support about this in =
context of attestation signing the "requested signatures" part (e.g. "Win=
dows Client 19H1") does not have any effect on validity of the signature
(21:37:26) zx2c4: god. local system has access to a lot of win32k APIs. i=
 sort of think exploiting a kernel vuln from that position would be consi=
derably easier than all these hoops.
(21:37:30) mattock: rozmansi: GUI-less means really GUI-less?
(21:37:38) mattock: or the kind of GUI-less that Server 2016 core is?
(21:38:02) rozmansi: just the GUI stripped down to minimum and lot's of m=
issing DLLs in system32 folder Windows Core is missing.
(21:38:14) rozmansi: the kind of Windows Core is.
(21:38:37) mattock: I did setup the server 2016 core for HLK tests in the=
 past (in EC2), but no 2019 version yet
(21:38:51) mattock: due to the "core" test
(21:39:08) zx2c4: mattock1: btw what kind of automate dsetup stuff do you=
 have for this?
(21:39:17) zx2c4: some amazing EC2 autostart script?
(21:39:20) mattock: puppet with powershell dsc
(21:39:25) zx2c4: ooolala
(21:39:27) zx2c4: got a repo?
(21:39:43) mattock: well, I could convert it to a puppet module - it is i=
nternal right now, but there's really no particular reason for it
(21:39:53) zx2c4: please do release. that sounds useful
(21:39:58) mattock: ok I will
(21:41:41) mattock: tomorrow probably
(21:42:21) mattock: anyways, anything else on tap-windows6 or was this "t=
he tap-windows6 HCR/HLK meeting" :P
(21:42:54) mattock: (did not see this coming, but lots of good info and p=
lenty of anecdotes :)
(21:44:59) zx2c4: if you get bored of tap6 insanity, btw, and feel like t=
inkering with wintun, you might find it refreshing
(21:45:06) zx2c4: fairly clean queueing model
(21:45:54) mattock: lol yes :D
(21:46:23) mattock: remember I'm not a C/C++ developer
(21:46:35) mattock: Windows and tap-windows just ended up being my territ=
ory
(21:47:06) dazo: you're our automation janitor!  Picking up all the cruft=
 the non-Windows devs of us didn't dare touch :-P
(21:47:07) mattock: basically: there was nobody in the company or in the =
community that could pull this off
(21:47:24) mattock: cruft is a good word
(21:47:33) mattock: I mean, I do like writing powershell even if it is a =
bit ugly
(21:47:42) mattock: that makes Windows work quite bearable
(21:47:52) ***cron2_ is amazed and thankful for that
(21:47:54) mattock: in some cases you can even ssh in and do stuff
(21:47:56) dazo: then selva nair and rozmansi came along ... and that was=
 refreshing for us :)
(21:48:03) mattock: +1
(21:48:31) cron2_: I can read and fix driver source, if needed, but "usin=
g microsoft build tools" is not for me
(21:48:38) dazo: cron2++
(21:50:47) dazo: next topic?  Or did I just loose connectivity?
(21:50:57) cron2_: dazo: *you* would fall over dead the moment you look a=
t some of these driver sources :-)
(21:51:27) dazo: there's reason I want to stay away from Windows code as =
much as possible :-P
(21:51:28) cron2_: well, the next topics are "2.5" (nothing new from me, =
but "friday next week!" is still blocked in my calendar)
(21:51:31) zx2c4: cron2_: the wintun stuff builds entirely from the comma=
nd line (in addition to visual studio) for folks who hate that stuff
(21:51:37) cron2_: nice
(21:52:43) cron2_: (ISTR that the tap driver is also built by cli scripts=
, python-stuff... but I did not want to remember, really)
(21:53:40) zx2c4: https://git.zx2c4.com/wintun/about/#building-from-comma=
nd-line
(21:53:42) vpnHelper: Title: wintun - Layer 3 TUN Driver for Windows (at =
git.zx2c4.com)
(21:53:45) dazo: IIRC, I think mattock1 fixed that a long time ago
(21:54:36) rozmansi: I am waiting tof the dust around the tap-windows6 dr=
iver signatures to settle, before integrating it into MSI for 2.5.
(21:54:46) cron2_: dazo: the problem is, whatever mattock touches has mor=
e python later on :-) - and I'm allergic to python as well
(21:54:48) rozmansi: s'tof'for'
(21:55:37) dazo: cron2_: hehehe
(21:56:29) dazo: cron2_: I see I need to put together some nice Perl exam=
ples for the openvpn3-linux project then :-P
(21:58:52) mattock: got distracted by a phone call
(22:00:06) mattock: ok so nothing on 2.5 until Friday next week
(22:00:20) mattock: one hour mark reached
(22:00:23) mattock: call it a day?
(22:00:26) cron2_: good night :)
(22:00:34) rozmansi: good night everyone
(22:00:36) mattock: that sounds excellent to me!
(22:00:54) mattock: bye guys!
(22:05:17) dazo: g'night

--------------72FA2D5D18610CB30B49A8DF--

--Hp9E6jK4djQnbxm3oEaSrSxovQfktxyO2--

--oW7G6nNT5d2SYstMuQnPiEJA3NQ51iauS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlzCC2UACgkQKVhNn0CG
RXhRXgf/WcGIzHJda5X9mKwyhpqS1aZV7s2CvqEZUH+8dBYn6C9qY2zNZOcJmPiX
3/vju15Wy3IPBP5EpGpyVNeAsq7SzMjwsaW6xGQWSHrrC6aqr7QAsvebUjlVpx3m
M/RIVxgckT3Mj7WioZ3HV3nyidoc1L/hL1cqvLVOhKJgRsrfSbSC+Qe7IKgFFLw3
ZkQs5eAnyiorrPfAia3Q6DEGMikbHQF8be/n6r2qtruuBn+eBurLzWI5MJbHy72f
Ue2871yu5MiwXNZwSlQnHZaESjV5kpSh/IrieQUoMZcDyxTHAGf1C2bOeGBace6D
/iqPAijGoImOE1BULUF8k0KEcg0V/Q==
=Wk8Q
-----END PGP SIGNATURE-----

--oW7G6nNT5d2SYstMuQnPiEJA3NQ51iauS--

