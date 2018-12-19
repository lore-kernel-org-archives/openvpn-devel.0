References: <16ef0449-3047-cc48-02a2-94153f2ffdf9@...515...>
 <97211515-19cf-fdc7-e133-57700ecfd8c3@...515...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <226a462c-906c-436d-cbef-ad756b556632@...515...>
Date: Wed, 19 Dec 2018 13:11:29 +0200
MIME-Version: 1.0
In-Reply-To: <97211515-19cf-fdc7-e133-57700ecfd8c3@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2ctQv9UDUpczXTRmCUfCXNFnZpOmKOPF9"
Subject: Re: [Openvpn-devel] Summary of the community meeting (Wed,
 12th Dec 2018)
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
--2ctQv9UDUpczXTRmCUfCXNFnZpOmKOPF9
Content-Type: multipart/mixed; boundary="KWV5DxjJnUkqDvKM09se5HZ9NIaa38Lsw";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <226a462c-906c-436d-cbef-ad756b556632@...515...>
Subject: Re: Summary of the community meeting (Wed, 12th Dec 2018)
References: <16ef0449-3047-cc48-02a2-94153f2ffdf9@...515...>
 <97211515-19cf-fdc7-e133-57700ecfd8c3@...515...>
In-Reply-To: <97211515-19cf-fdc7-e133-57700ecfd8c3@...515...>

--KWV5DxjJnUkqDvKM09se5HZ9NIaa38Lsw
Content-Type: multipart/mixed;
 boundary="------------CF843A7E69BDF0191ECD1CA1"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------CF843A7E69BDF0191ECD1CA1
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

As SF.net may have eaten the summary from last week here it comes again.
I'm attaching the chatlog as well.

Samuli

Il 12/12/18 13:50, Samuli Sepp=E4nen ha scritto:
> Hi,
>=20
> Here's the summary of the IRC meeting.
>=20
> ---
>=20
> COMMUNITY MEETING
>=20
> Place: #openvpn-meeting on irc.freenode.net
> Date: Wednesday 12th December 2018
> Time: 11:30 CET (10:30 UTC)
>=20
> Planned meeting topics for this meeting were here:
>=20
> <https://community.openvpn.net/openvpn/wiki/Topics-2018-12-12>
>=20
> The next meeting has not been scheduled yet.
>=20
> Your local meeting time is easy to check from services such as
>=20
> <http://www.timeanddate.com/worldclock>
>=20
> SUMMARY
>=20
> cron2, dazo, mattock, ordex and rozmansi participated in this meeting.
>=20
> --
>=20
> Discussed MSI packaging. Agreed that openvpnserv2 should be made an
> optional feature. This is to avoid auto-starting it unless user has
> explicitly taken steps to enable it. Doing that was considered a bad
> packaging practice. Unlike with NSI it would be challenging in MSI to
> detect the state of openvpnserv2 service and restore that state after
> install.
>=20
> That said it was agreed to ask selva's opinion, as he done extensive
> review on rozmansi's work.
>=20
> --
>=20
> Discussed tap-windows6 HLK testing / WHQL certification. Stephen aims at
> finishing the job this week. He also found out that some company that
> does Windows development bragged on some forums about having
> WHQL-certified tap-windows6 already. He asked them if they would hand us
> their changes.
>=20
> --
>=20
> Talked about the uncrustify patches:
>=20
>   https://patchwork.openvpn.net/patch/624
>   https://patchwork.openvpn.net/patch/625
>   https://patchwork.openvpn.net/patch/626
>=20
> Dazo ACKed the 624 and 625 and will have a look at 626 after the meeting.
>=20
> --
>=20
> Talked about using an automatic pre-commit-hook to uncrustify code for
> the core developers automatically. This would avoid the "4 week delay,
> then 'nah, this is ugly looking' hell again". Agreed to try to create
> the hook in Friday's hacking session.
>=20
> --
>=20
> Talked about rate-limiting unauthenticated packets. Currently OpenVPN
> servers (that don't use tls-auth, for example) can be misused for a
> reflection attack by sending them unauthenticated packets with spoofed
> IPs. The server will send response packets to those IPs, which are not
> the origin IPs but IPs of the target hosts. Also, it may be possible to
> exhaust OpenVPN server's memory or disk (log files) by sending lots of
> these packets with as tons of different source IPs.
>=20
> There are two patches in the queue which help reduce the impact of this
> problem:
>=20
>   https://patchwork.openvpn.net/patch/631/
>   https://patchwork.openvpn.net/patch/636/
>=20
> The former is ready for review (minor style issue found), but the latter
> would need a "concept review" first.
>=20
> Agreed that we should warn people if they're not using
> tls-auth/tls-crypt/tls-cryptv2. Also agreed that all our official
> documentation and sample configs should enable one of these options, and
> that we should send out a security bulleting about this problem in the
> near future.
>=20
> If using proper fixes such as tls-auth is not possible, using
> --connect-freq helps somewhat.
>=20
> --
>=20
> Full chatlog attached.
>=20


--------------CF843A7E69BDF0191ECD1CA1
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2018-12-12.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2018-12-12.txt"

(12:36:12) cron2: more mattocks :)
(12:36:15) dazo: at least two!
(12:36:24) mattock: yeah, one mobile and one less mobile
(12:36:26) mattock: :)
(12:36:37) mattock: I'm on my laptop now, was walking to the office
(12:36:49) cron2: it's not good for your laptop if you sit on it
(12:37:04) mattock: this is Carbon X1 so it is military-grade
(12:37:06) mattock: I can sit on it
(12:37:08) dazo ha scelto come argomento: Next meeting on 24/Oct/2018 at =
11:30CEST. Agenda at https://community.openvpn.net/openvpn/wiki/Topics-20=
18-12-12
(12:37:12) mattock: though I have not tried
(12:37:25) mattock: anyways, we have cron2, dazo and rozmansi - shall we =
start or?
(12:37:53) dazo: let me ping ordex
(12:38:06) cron2: he just wrote in #openvpn-devel that he's out for dinne=
r... :-/
(12:38:14) dazo: oh
(12:38:41) dazo: okay
(12:38:57) cron2: let's start...
(12:39:01) dazo: yeah
(12:39:13) dazo: since rozmansi and mattock1 is here ... MSI
(12:39:18) cron2: yep!
(12:39:18) rozmansi: ok
(12:40:06) rozmansi: The packaging is mostly complete.
(12:40:38) rozmansi: I just want to run uncrusfity first before submittin=
g the last patch set to openvpn repo.
(12:41:17) rozmansi: And I intend to add x86 NSIS leftover cleaning to 64=
-bit installations.
(12:41:23) cron2: nice
(12:41:59) dazo: \o/
(12:42:06) rozmansi: mattock reminded me there are installations with x64=
 driver and x86 userspace binaries.
(12:42:22) dazo: eww .... do we really need to support that?
(12:42:56) rozmansi: It's not that much of a hassle.
(12:43:04) cron2: not for new installations, I'd say, but you can do that=
 today - install a 32bit openvpn on a 64bit windows and it will just work=

(12:43:11) cron2: so when upgrading, you might run into this
(12:43:11) dazo: okay, but ... what's the use case?
(12:43:18) dazo: ahh, okay
(12:43:47) rozmansi: For those not following the progress... The openvpns=
erv2.exe is now set to auto-start by default.
(12:44:00) cron2: huh, why?
(12:44:16) rozmansi: The reason behind this was the MSI packages don't su=
pport variable service configuration.
(12:44:42) rozmansi: I can't put a variable in the "Service start type" f=
ield. :(
(12:45:02) rozmansi: Selva modified openvpnserv2.exe to look into a diffe=
rent config folder now.
(12:45:03) cron2: can it be done by custom dll?
(12:45:18) mattock: the idea is to have "config-auto" for auto-starting c=
onfig files
(12:45:38) cron2: I'm not much in favour of a service that is started by =
default on everything but only a very small group actually needs it
(12:46:05) dazo: what does "auto-start" really mean?  I interpreted it as=
 "it starts automatically when needed"
(12:46:12) cron2: "it starts on bootup"
(12:46:13) mattock: starts automatically on boot
(12:46:15) mattock: but
(12:46:19) rozmansi: It could be done in a custom dll, however, it's rein=
venting the wheel. A complete service management would need to be introdu=
ced to libopenvpnmsi.dll - any volunteers to review some more code?
(12:46:38) mattock: the user/admin needs to explicitly copy config files =
to config-auto folder
(12:46:54) cron2: sure, but having a process hang around that is not need=
ed is still not a good idea
(12:47:18) rozmansi: Actually, the config files are moved on update autom=
atically now IF the installer detect that user was actually using openvpn=
serv2.exe
(12:47:24) mattock: yes exactly
(12:47:32) mattock: meaning that all configs _were_ autostarted already
(12:48:18) cron2: none of my windows users uses the service, so I have no=
 idea what percentage of windows users really use openvpnvserv2 - 0% of m=
ine... but others might see a different ratio
(12:48:45) mattock: you might have some point of sale systems or such whi=
ch have it running all the time
(12:48:50) rozmansi: That's why the service is an optional feature.
(12:48:51) mattock: or openvpn servers
(12:49:24) cron2: right, but I'm a firm believer that services should be =
activated-when-needed, not "just run after installation"
(12:49:32) cron2: (like, open portmappers on debian...)
(12:50:07) cron2: what about splitting openvpnserv2 into an extra .msi th=
at can be activated or not?
(12:50:12) cron2: (just thinking out loud)
(12:50:15) dazo: like openvpn3-linux :-P
(12:51:00) rozmansi: msi has different rationale: the computer state shou=
ld always be predictable after setup is complete (based on feature select=
ion)
(12:51:46) mattock: what about disabling openvpnserv2 feature by default?=

(12:51:54) mattock: too surprising to users?
(12:52:52) mattock2 ha abbandonato la stanza (quit: Quit: IRC for Sailfis=
h 0.9).
(12:53:01) rozmansi: the thought has crossed my mind.
(12:53:14) mattock: this is 2.5 only so maybe it would be ok
(12:53:19) rozmansi: Selva preferred to install it by default.
(12:54:01) dazo: just need to recall some details ... what kind of servic=
e does openvpnserv2 provide?
(12:54:29) mattock: same as traditional (=3Dnon-systemd) openvpn service =
on Linux
(12:54:29) rozmansi: it's a daemon to start all config files in C:\Progra=
m Files\OpenVPN\config-auto on boot.
(12:54:39) mattock: very simplistic
(12:54:41) cron2: dazo: the autostart openvpn instances at boot
(12:55:33) rozmansi: or it simply doesn't start anything if there are no =
config files in config-auto (mind the new directory introduced a week ago=
)
(12:55:38) dazo: okay ... then I agree it should be disabled by default, =
or to have it as a separate MSI package which can have it auto-enabled
(12:55:54) mattock: I think former is better
(12:55:56) rozmansi: let me check it's memory consumption
(12:56:31) dazo: this is a behavioural change from prior versions ... and=
 sysadmins who depend on this feature knows how to enable it
(12:56:53) rozmansi: ups, hard to find a computer running one
(12:56:58) mattock: :)
(12:57:40) mattock: cron2: does memory consumption have any effect on you=
r stance on this? :P
(12:57:50) dazo: and as a side note ... if all openvpnserv2 provides is a=
uto-start of config profiles .... perhaps it should be renamed to openvpn=
-autostart ;-)
(12:57:52) cron2: not really
(12:58:05) cron2: (memory consumption)
(12:58:06) dazo: I agree with cron2=20
(12:58:20) mattock: I say we make it a opt-in feature
(12:58:46) mattock: but ask selva's opinion as well
(12:58:48) rozmansi: I agree with mattock. Introducing another MSI packag=
e set is complex.
(12:59:11) mattock: rozmansi: the interactive MSI install will clearly sh=
ow the features, right?
(12:59:15) cron2: maybe not another .msi - if we can have the msi have a =
switch /installsrv2:yes that would be fine
(12:59:38) cron2: not sure what options we have at all and which options =
make sense
(12:59:41) dazo: In RPM-land, which I'm influenced by ... enabling servic=
es/daemons at boot is considered bad packaging and primarily allowed for =
really system/boot critical services
(13:00:16) mattock: cron2: I believe that is how enabling features in MSI=
 would work
(13:00:24) cron2: that's BSD thinking as well - "packages must be install=
ed and then explicitely activated".  Now Debian is in the "if you install=
 it, you must want to have it, so we can start it!" land...
(13:00:42) mattock: naughty Debian
(13:00:58) cron2: I'm in the "if I do not need it I do not want to have i=
t running" - how we can do this (install it but not turn it on, or just n=
ot install it) I do not mind very much
(13:01:20) mattock: so we seem to have an agreement: make openvpnserv2 op=
t-in feature in the MSI installer
(13:01:34) cron2: and "ask selva" :)
(13:01:34) rozmansi: openvpnserv2.exe consumes less than 4MB of RAM (on 6=
4-bit Windows 8)
(13:01:36) mattock: yes
(13:01:47) mattock: rozmansi: quite a bit for a service doing nothing
(13:02:09) mattock: shall we move on?
(13:03:53) cron2: yep
(13:03:58) mattock: #2 tap-windows6 HLK testing: status update=20
(13:04:08) mattock: we got one from Stephen yesterday
(13:04:16) mattock: he aims to finish the job this week
(13:04:43) mattock: then he found out that a joe random had managed to ma=
ke tap-windows6 pass HLK testing (for Windows desktop editions if I recal=
l correctly)
(13:04:47) ***cron2 sees a couple of patches coming up for review...
(13:04:50) mattock: so he asked if that person would hand over the code
(13:04:58) mattock: no updates on that front though
(13:05:10) cron2: that "joe random" actually seems to be a company that d=
oes windows development... I find it annoying that they are not just talk=
ing to us ("bragging rights!")
(13:05:18) mattock: yeah, me too
(13:05:58) mattock: anything else to report on that front cron2?
(13:06:21) cron2: no, I read the same mails :-) - I'll see that I can get=
 the stuff reviewed & merged when it comes in
(13:07:03) mattock: great!
(13:07:07) mattock: so moving on
(13:07:24) mattock: did we cover network API patchset?
(13:07:38) cron2: nothing to report... ordex and plaisthos are not talkin=
g
(13:08:26) dazo: I'll follow up on them internally
(13:08:52) cron2: thanks.  Next :-)
(13:09:04) cron2: maybe do the uncrustify patches first
(13:09:16) dazo: yeah
(13:09:25) cron2: patches 624, 625, 626
(13:09:41) dazo: ACK on 624
(13:09:51) cron2: that was easy :)
(13:10:21) dazo: ACK on 625
(13:10:45) dazo: 626 is "a bit" longer :)
(13:11:06) cron2: 626 is longer and has a few changes that I find a bit s=
illy, but I decided to "just go for it" to have a clean code base with no=
 exceptions
(13:11:17) dazo: yeah, agreed
(13:11:17) cron2: s/clean/conforming-to-uncrustify-rules/
(13:11:42) dazo: I'll spend some time digging into that one after the mee=
ting
(13:11:56) dazo: quick glance looks good, though
(13:12:04) cron2: thanks.  I'll change the reviewer to you in patchwork
(13:12:12) dazo: yeah, please do
(13:12:28) cron2: cool.
(13:12:41) ***ordex is just checking
(13:12:42) ordex: -gc_addspecial(void=C2=B7*addr,=C2=B7void(free_function=
)(void=C2=B7*),=C2=B7struct=C2=B7gc_arena=C2=B7*a)=20
(13:12:42) ordex: +gc_addspecial(void=C2=B7*addr,=C2=B7void=C2=B7(free_fu=
nction)(void=C2=B7*),=C2=B7struct=C2=B7gc_arena=C2=B7*a)=20
(13:12:43) cron2: so, just to repeat for the minutes :-)
(13:12:46) ordex: is this what we want?
(13:12:59) ordex: ah it's adding a space - yes, we want that
(13:13:01) ***ordex hides again
(13:13:08) dazo: (openvpn3-linux beta is out the door ... so my workload =
has finally calmed down for a bit)
(13:13:17) cron2: what I wanted to say
(13:13:18) ordex: sorry, but I barely slept in the past few days, so no t=
ime to review those 3 after the auth-token
(13:13:52) cron2: the goal is: to be able to run uncrustify as a pre-comm=
it-hook for "regular developers" so *new* patches will not get stuck in t=
he "4 week delay, then 'nah, this is ugly looking' hell again"
(13:14:07) ordex: yap
(13:14:42) cron2: ordex: go to sleep, then :-)
(13:14:46) ordex: :D
(13:15:10) ***cron2 assigns https://patchwork.openvpn.net/patch/637/ to d=
azo as well
(13:15:11) vpnHelper: Title: [Openvpn-devel] Release of OpenVPN 3 Linux v=
1 (Beta) - Patchwork (at patchwork.openvpn.net)
(13:15:28) dazo: hahaha ... oh that appeared in pw?
(13:15:32) dazo: ahh ... the patch
(13:15:36) cron2: yes, because it has a patch :-)
(13:16:01) cron2: (tagged as "not applicable", since this patchwork is on=
ly for OpenVPN 2 patches :-))
(13:16:35) cron2: so, anything else on uncrustfy?  I'm fine :)
(13:17:08) dazo: yeah, that's fine
(13:17:28) dazo: I'll complete the review after the meeting ... and it is=
 most likely going to get an ACK soon after
(13:19:02) cron2: I will be fairly busy today and tomorrow - so I won't b=
e able to merge before Friday.  If you feel like merging right away, go f=
or it, then I'll re-sync on Friday
(13:19:22) dazo: sure, I'll see if I dare that :)
(13:19:41) mattock: who will create the pre-commit-hook?
(13:19:49) mattock: I suppose it won't be too difficult
(13:20:08) cron2: plaisthos found something on the web, which we just nee=
d to adjust for our envrionment - but that should be fairly easy
(13:20:16) mattock: ok
(13:20:24) mattock: maybe that would be a worthy goal for Friday?
(13:20:32) mattock: assuming we have a session then
(13:20:56) cron2: I'll be at home, and I intend to spend time on OpenVPN,=
 so yes (at least a few hours)
(13:21:08) mattock: ok I'll note that in the summray
(13:21:09) mattock: summary
(13:21:13) cron2: ok
(13:21:22) cron2: so, rate-limiting
(13:21:31) cron2: let me briefly summarize what we've been seeing
(13:22:14) cron2: people are targeting OpenVPN servers as reflectors, tha=
t is, send lots of packets to UDP/1194 with a spoofed source address, and=
 OpenVPN dutifully replies to the "origin" which is some victim address
(13:22:38) mattock: and the rate can be fairly high, right?
(13:22:53) cron2: we are not seeing high packet rate, so as of today, may=
be 2-5 packets/sec worst case - which is really like "nothing" compared t=
o the NTP attacks we see (~5000 pps)
(13:23:17) cron2: the rate *could* be arbitrarily high since we do not ra=
te-limit responses to RESET packets today
(13:23:26) cron2: we see two different sort of attacks
(13:23:26) dazo: but ... this what we might see might be people testing t=
his out
(13:23:41) dazo: before it pans out to a full blown attack
(13:23:56) cron2:  - lots of different source ports --> every packet crea=
tes a new "multi_instance" inside OpenVPN -> resource exhaustion in the s=
erver is possible
(13:24:12) dazo: hmm, yeah
(13:24:24) cron2:  - many packets from the same source port --> only a si=
ngle multi_instance -> not much resource usage on the server
(13:24:43) cron2: in both cases, the server logs get filled, and as dazo =
said, this might be "testing the waters" for higher-volume attacks later =
on
(13:25:14) cron2: syzzer is right that "tls-auth/tls-crypt" is the way to=
 go, because that way, the server will not send a single reply packet -> =
uninteresting to exploit
(13:25:37) Pippin_ [~pippin@...2481...] =C3=A8 entrato nella stanza.=

(13:25:40) cron2: *but* we still create a new multi_instance for every in=
coming distinct source port, so the state exhaustion and log file filling=
 attack still works(!)
(13:25:58) cron2: (unless I've misread mudp.c)
(13:26:23) cron2: ssl.c checks tls-auth inside an existing multi_instance=
s, which mudp.c creates
(13:26:49) cron2: ah, no
(13:26:54) cron2: with tls-auth, we're good
(13:27:13) cron2: because we check tls_auth before creating instances
(13:27:22) cron2:             if (!m->top.c2.tls_auth_standalone
(13:27:26) cron2:                 || tls_pre_decrypt_lite(m->top.c2.tls_a=
uth_standalone, &m->top.c
(13:27:29) cron2: ...
(13:27:31) cron2:                     mi =3D multi_create_instance(m, &re=
al);
(13:27:42) cron2: multi_get_create_instance_udp() in mudp.c
(13:27:43) dazo: where is this?
(13:27:45) dazo: ahh
(13:27:47) cron2: so
(13:28:03) cron2: with tls-auth, we're good, always.  This is very good, =
and our recommendation should be "just use tls-auth"
(13:28:21) ordex: yap
(13:28:33) cron2: unfortunately, we permit configs without tls-auth, and =
depending on which howto you used, you end up with a config without tls-a=
uth
(13:28:38) ***cron2 looks into the mirror and frowns
(13:29:03) cron2: (and tls-auth won't help people operating many-user VPN=
 services against a malicious user that has the right key)
(13:29:28) cron2: so I've come up with these two patches which I hoped to=
 interest syzzer in, but he's busy...
(13:29:43) mattock: ok so even if we reduce the rate with which we send r=
esponse packets there's still the possibility to exhaust openvpn server's=
 memory and/or disk if the spoofed source IP is different for (all) the i=
ncoming packets?=20
(13:29:51) mattock: but tls-auth prevents even that attack
(13:29:52) mattock: ?
(13:29:53) cron2: 631 is "inside a single instance (=3D same source port)=
, just ignore RESET packets that come in more often than one per 10 secon=
ds"
(13:30:08) cron2: mattock1: yes, tls-auth or --connect-freq can help with=
 that
(13:30:20) mattock: ok, noting that in the summary
(13:30:36) cron2: 636 is "from the same source IP, do not accept new inst=
ances if we have more than <n> instances that currently in TLS handshake =
phase"
(13:31:13) mattock: 1 minute over our allocated time slot :)
(13:31:19) cron2: this very nicely stops the many-source-ports attacks he=
re, but incurs extra cost on creating an instance - because it needs to w=
alk all currently assigned multi_instances
(13:31:40) cron2: many-source-addresses are not something we have seen as=
 that's not interesting for reflective attacks
(13:31:52) cron2: --connect-freq helps with that, but can drown out legit=
imate connections
(13:32:01) mattock: wouldn't 636 also make DoS possible?
(13:32:15) mattock: flood the server with packets so that legit users can=
't connect (reliably)
(13:32:32) mattock: oh, from the same source IP?
(13:32:36) cron2: mattock1: to some extent.  If you know someone is going=
 to connect from IP A, and you keep sending garbage packet with spoofed s=
ource A, you'll disturb that client
(13:32:39) cron2: yes
(13:32:49) mattock: ok
(13:32:50) cron2: this is the problem with --connect-freq (an already exi=
sting option, if I may say :-) )
(13:33:02) cron2: --connect-freq is "at maximum, <n> new connections in <=
t> seconds" limiter
(13:33:22) mattock: I need to split for lunch - can we wrap this up, or w=
ill you guys continue this topic?
(13:33:30) cron2: and if the bad guy just sends enough packets with new s=
ource address/port (=3D new instance), it will kill legitimate connection=
s
(13:33:51) cron2: well, my summary is basically done - if you give me 3 m=
ore minutes?
(13:33:55) mattock: I shall
(13:33:57) mattock: :)
(13:33:59) cron2: thanks :-)
(13:34:26) cron2: what I hope for is a review on 631 (that patch should b=
e ready to go), a concept review on 636 (that patch is ugly and has way t=
oo much debug output)
(13:34:40) cron2: and I'm not sure if we should have a CVE to be able to =
*document* the issue
(13:34:56) mattock: we can make a security announcement without a CVE
(13:34:58) cron2: "this is what happening, this is what you do to protect=
 your systems" - and if we ever commit something, the commit can referenc=
e the CVE
(13:35:05) ordex: 631 has broken style xD
(13:35:26) mattock: ordex: it's not been on the list for 4 weeks yet
(13:35:29) mattock: you're early
(13:35:31) mattock: :P
(13:35:32) ordex: righ
(13:35:34) ordex: sorry :D
(13:35:54) ***cron2 sends ordex back to sleep  (but I found the aligning =
of the text strings much more readable that way)
(13:35:56) mattock: more reason to get uncrustify done a.s.a.p.
(13:36:14) mattock: any takers on 631 and/or 636?
(13:36:15) cron2: ah, too many blanks in if()
(13:36:20) ordex: yes
(13:36:37) cron2: mattock1: let's see if syzzer shows up after reading th=
e summary :-)
(13:36:42) mattock: sounds good
(13:36:43) ordex: about the string: personally I'd not break them, even i=
f long, because that helps grepping through the code when searching a par=
ticular message
(13:36:43) cron2: dazo: any thoughts on the CVE?
(13:36:48) dazo: I'm pondering on it
(13:36:51) ordex: anyway
(13:37:08) ordex: is this really worth a CVE? when we already have a solu=
tion for it? (tls-auth)
(13:37:21) cron2: ordex: yeah, right, I could wrap after D_MULTI_ERRORS a=
nd then have a single string...
(13:37:27) dazo: It most likely fits the requirements of a CVE ... but I'=
m not sure if it's critical enough to be worth the additional process ste=
ps
(13:37:55) cron2: ordex: it's something of a "have a single thing to goog=
le for" - but I am not really decided, otherwise I wouldn't ask :-)
(13:37:56) ordex: yap
(13:38:08) cron2: but we can cut it here, and ponder on it until Friday..=
=2E
(13:38:12) ordex: yeah
(13:38:12) ordex: ok
(13:38:22) dazo: but what ordex says, --tls-auth/crypt is recommended by =
us which makes it more a "configuration issue"
(13:38:54) dazo: we could probably make docs even clearer and ensure all =
sample configs have at least --tls-auth/crypt enabled by default
(13:39:00) cron2: (we might even introduce an extra patch that warns if a=
 config is not using tls-auth/crypt, and refer to that CVE...)
(13:39:12) mattock: cron2: +1
(13:39:17) dazo: with a "# You really want this, do $this to create the n=
eeded key"
(13:39:52) dazo: cron2++ ... yup, having a log warning on configs without=
 --tls-auth/crypt is also appropriate
(13:40:17) cron2: I'll do a patch..
(13:40:31) cron2: (Friday)
(13:40:39) dazo: Our "Getting Started" guide does indeed mention using --=
tls-auth/crypt  https://community.openvpn.net/openvpn/wiki/GettingStarted=
withOVPN#Configuringauthentication
(13:40:40) vpnHelper: Title: GettingStartedwithOVPN =E2=80=93 OpenVPN Com=
munity (at community.openvpn.net)
(13:41:16) mattock: ok let's continue on Friday
(13:41:16) cron2: so do our sample-configs ("nowadays", no idea whether t=
his was "recently" introduced, like "in the last 5+ years")
(13:41:31) mattock: we did update our sample configs not too long ago
(13:41:37) mattock: afaicr
(13:42:05) mattock: anyways, heading out now
(13:42:07) mattock: good meeting!
(13:42:23) dazo: I'd say we can rather post a "security bulletin" in the =
near future recommending people to verify --tls-auth/crypt is being enabl=
ed=20
(13:42:34) dazo: and instead drop the CVE for now
(13:42:39) cron2: k
(13:43:26) dazo: from git blame:
(13:43:28) dazo: 513eef488 sample/sample-config-files/server.conf (Steffa=
n Karger      2015-02-22 15:11:08 +0100 244) tls-auth ta.key 0 # This fil=
e is secret
(13:43:36) cron2: good syzzer :)
(13:43:41) dazo: :)

--------------CF843A7E69BDF0191ECD1CA1--

--KWV5DxjJnUkqDvKM09se5HZ9NIaa38Lsw--

--2ctQv9UDUpczXTRmCUfCXNFnZpOmKOPF9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlwaJ2EACgkQKVhNn0CG
RXibqgf/dzgaZerN9GoaMMUxOgI2jzSydJzJ6Txl2nbe5eRzJATbL1WWvpV3V/Ml
GIatb4J9VX9IKS45DY2MLbMVEuyRk32FkBWyuliKRBJRjJAVfa1D7228ZpvqeJBd
pFEC2XqZZ/6UTk7N8DOhuOd6ypCId2FS1MsmuYE45lP9kVR3J1NwYqGDLM0p2j4u
bJJvkIK9Z9PlETgjgyVfByQaW/RvYokCsYkIW1cqr9GlHXqs/+SiaZwTJloYf8nF
YkX3EBckeE9RwdxIIkC9s14eaHVjIKv5Yn+6+WagjopnGRPD6doMpJgJHL2iaXc7
UXF6Pt3L/mlS/swx4Mz9QsdiZkypjg==
=doiC
-----END PGP SIGNATURE-----

--2ctQv9UDUpczXTRmCUfCXNFnZpOmKOPF9--

