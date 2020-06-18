From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <cde19afd-b6cb-3b99-b346-1cfcdcebbbe2@...515...>
Message-ID: <c6cefa72-c430-2545-5290-14c7822b55ad@...515...>
Date: Thu, 18 Jun 2020 22:11:51 +0300
MIME-Version: 1.0
In-Reply-To: <cde19afd-b6cb-3b99-b346-1cfcdcebbbe2@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OZ7qEERGfxq6Y4PaGJzhTTvIQgYXF1E9V"
Subject: [Openvpn-devel] Summary of the community meeting (18th June 2020)
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
--OZ7qEERGfxq6Y4PaGJzhTTvIQgYXF1E9V
Content-Type: multipart/mixed; boundary="iU1RDi4yz26oxOGynqhAuBBsqE0Xj6PS8"

--iU1RDi4yz26oxOGynqhAuBBsqE0Xj6PS8
Content-Type: multipart/mixed;
 boundary="------------B5D34F2167C6BB97DD028B4B"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------B5D34F2167C6BB97DD028B4B
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thu 18th June 2020
Time: 20:00 CEST (19:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-06-18>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

becm, cron2, dazo and mattock participated in this meeting.

---

Talked about the status of OpenVPN 2.5:

<https://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn25>

Cron2 will continue merging plaisthos' patches, then look at
tap-and-netmask-and-IPv6 issues on windows and then the VRF patch.

No progress was made on reviewing the man-page patches. Dazo has some
additions in the pipeline for it already.

Mattock was able to produce a tap-windows6 MSM (~installer) today, so he
will move forward by creating the OpenVPN MSI installers.

---

Talked about automating OpenVPN MSI builds. The current Vagrant setup
has a linux VM for producing the build artifacts (with openvpn-build).
Those artifacts are then shared via Samba on the Windows packaging host,
which then produces the MSI packages. So the automation difficulty
factor is bigger than with our current "cross-compile on Linux with
openvpn-build" approach.

Mattock will gauge the difficulty of automating the MSI build process
after he has a good grasp of the process.

---

Froze the feature set of OpenVPN 2.5. The ones on "must have" list now
will be delivered, everything else will be postponed:

<https://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn25>

---

Talked about pkcs11-helper patching and upgrade for Windows installers:

<https://github.com/OpenVPN/openvpn-build/pull/172>
<https://github.com/OpenVPN/openvpn-build/issues/168>

One option is to upgrade from 1.22 to 1.23 and use the latest Fedora
patch. We could also move directly to 1.26 - the patch does apply with
some offset warnings and building pkcs11-helper still works.

Dazo sent email to fedora-devel mailing list and ask why Fedora is still
using / is stuck on pkcs11-helper 1.22. Meanwhile mattock will produce
OpenVPN 2.5 Windows installers that bundle 1.26 with the latest Fedora
patch.

Also noted that we can release updated pkcs11-helper in a 2.4.x Windows
installer release if the new version looks solid.

--

Full chatlog attached

--------------B5D34F2167C6BB97DD028B4B
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-06-18.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-06-18.txt"

(21:07:36) mattock: did everyone fall asleep already? :)
(21:08:04) cron2: 2.5 first :-)
(21:08:10) dazo: Perhaps tie this with https://community.openvpn.net/open=
vpn/wiki/StatusOfOpenvpn25
(21:08:12) vpnHelper: Title: StatusOfOpenvpn25 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:08:20) mattock: I can start
(21:08:23) cron2: I've merged 3 of 5 from the plaisthos patchset, and the=
n got distracted by workers in the house (finisehd now)
(21:08:27) mattock: ok go ahead
(21:09:02) cron2: so, merge the remaining two, then go and look for tap-a=
nd-netmask-and-IPv6 issues on windows, and the VRF patch
(21:09:17) cron2: ordex is moving to a new flat this week, so, busy
(21:09:23) dazo: yeah
(21:09:41) cron2: lev__ is still missing
(21:09:45) dazo: cron2: did you have a chance to look at the man page stu=
ff?  Or should I just start to send patches to the ML?
(21:10:18) cron2: dazo: only the look from last week, no thorough review =
yet
(21:11:06) dazo: I see there might be some man page updates in the queue =
as well ... so this needs some careful coordination to ensure those addit=
ions doesn't get lost
(21:12:18) cron2: I won't merge any man-page related stuff
(21:14:08) cron2: anything from wiscii yet?
(21:14:15) dazo: nope
(21:14:48) dazo: Only that he forgot to checkout the right git branch ;-)=

(21:15:17) cron2: oh, and that gitlab kicked him, right :)
(21:16:56) cron2: so, mattock, how's 2.5 coming along?
(21:17:02) dazo: ahh, right ... for the pull-req ... well, I'm willing to=
 grab patches sent to the mailing list
(21:17:06) mattock: quick update from me: I was able to produce a tap-win=
dows6 MSM (~installer) today, so I will continue with the MSI installer
(21:17:35) cron2: can you - if it succeeds - integrate it into buildbot s=
o we can get msi snapshots of "master"?
(21:17:44) dazo: +1
(21:17:55) mattock: good luck with that
(21:18:09) mattock: might be possible, assuming the Microsoft signing ser=
vice has an API
(21:18:16) mattock: well
(21:18:20) mattock: for openvpn, maybe
(21:18:35) cron2: oh, .msi needs to be signed by microsoft?
(21:18:38) mattock: it will be tricky because MSI packaging will happen o=
n a Windows host
(21:18:52) ***cron2 trusts mattock's insane windows python scripting abil=
ities
(21:19:07) cron2: (talking about openvpn.msi, not tap6.msm, yes)
(21:19:12) dazo: hmmm pity
(21:19:17) mattock: I mean, I would love to automate it, but it will be e=
ven more challenging the openvpn-build/windows-nsis
(21:19:27) mattock: s/the/than
(21:19:48) cron2: I am full of trust that you will do this excellently!
(21:19:50) mattock: doable, but I would not hold my breath (i.e. sometime=
 before 2.5.0 _maybe_)
(21:19:50) dazo: okay, so occasional MSI/MSM builds is the best we can do=
 for now
(21:19:59) mattock: for now, yes
(21:20:04) cron2: that would be very good to give people stuff to test
(21:20:16) cron2: (without you having to build a new msi every few days)
(21:20:29) mattock: the vagrant setup has a linux VM for producing the bu=
ild artefacts which shares them via Samba on the Windows packaging host
(21:20:53) mattock: so, that could be replicated on more static instances=
, but yeah, not trivial to do
(21:21:03) dazo: cron2: when you've merged the last patches from plaistho=
s, I'll kick of another Fedora Copr build for Fedora/RHEL/CentOS ... the =
RPM packaged openvpn-git-master builds
(21:21:06) mattock: yeah, I also don't want to keep on building MSI packa=
ges every two days :D
(21:21:34) cron2: dazo: yep.  And ecrist can do a new freebsd snapshot :)=

(21:21:39) mattock: I'll try to get an idea of the complexity after I go =
through the process manually
(21:22:18) dazo: But regarding the list of items for 2.5 ... should we no=
w draw the line of what goes into 2.5 and move the rest to "a future rele=
ase", just so we know exactly what we will focus on?
(21:22:44) mattock: I think we have to
(21:23:07) cron2: I think the "must have" list is it - the "try to make i=
t happen" is too complex
(21:23:15) cron2: except maybe "update auth-user-pass docs" and "Linux VR=
F"
(21:23:35) dazo: yeah, that's what I was thinking as well
(21:23:54) cron2: I'll update
(21:23:57) dazo: thx!
(21:25:05) cron2: like this?
(21:26:44) dazo: I would also change the "we wanted" headline to "Postpon=
ed items" or something like that.  To really make it clear we're closing =
the dev cycle
(21:27:36) cron2: Postponed items (former "nice to have" items for 2.5)
(21:27:53) dazo: LGTM
(21:27:55) dazo: thx!
(21:29:16) mattock: good on 2.5?
(21:30:08) cron2: I have much work and little to say
(21:30:15) dazo: think so, yes
(21:30:24) mattock: pkcs11-helper + openvpn-build?
(21:30:26) cron2: dazo: can you poke lev__ to answer plaisthos' mail on t=
he compression patch?
(21:30:33) dazo: I'll do that
(21:31:18) dazo: (I responded a bit earlier today he was out driving at t=
his time)
(21:31:25) dazo: *He
(21:33:38) mattock: https://github.com/OpenVPN/openvpn-build/pull/172
(21:33:41) vpnHelper: Title: replace rfc7512 URI patch with latest versio=
n in Fedora by becm =C2=B7 Pull Request #172 =C2=B7 OpenVPN/openvpn-build=
 =C2=B7 GitHub (at github.com)
(21:33:58) mattock: that's the "pkcs11-helper" issue
(21:34:09) becm: (1st half)
(21:34:12) cron2: have we not discussed this before?
(21:34:33) mattock: "open question would be pkcs11-helper version bump (1=
=2E23+) to support tokens with EC-keys (issues/168)"
(21:34:57) mattock: https://github.com/OpenVPN/openvpn-build/issues/168
(21:34:59) vpnHelper: Title: included libpkcs11-helper-1.dll is compiled =
without Elliptic Curve support >=3D2.4.5 =C2=B7 Issue #168 =C2=B7 OpenVPN=
/openvpn-build =C2=B7 GitHub (at github.com)
(21:35:08) dazo: If the pkcs11-helper upgrade is just to upgrade the libr=
ary and rebuild openvpn, I see no harm
(21:35:32) dazo: but if we need to adopt our pkcs11-helper implementation=
, then it would need to wait
(21:36:26) becm: and the rfc7512 patch would no longer be identical to Fe=
dora
(21:37:03) mattock: does the fedora patch merge cleanly or cause merge co=
nflicts?
(21:37:12) mattock: in pkcs11-helper 1.23 that is
(21:37:17) dazo: eww
(21:37:20) becm: simple bugfix for issues/168 would be pkcs11-helper 1.23=
 (which nobody else uses)
(21:37:45) becm: mattock: off by 1 line
(21:37:58) dazo: I see that Fedora and EPEL-8 builds have moved to 1.22
(21:37:58) becm: copyright-notice changes
(21:38:05) mattock: ok but nothing major
(21:38:38) mattock: we were already speaking of using a static copy of th=
e patch "initially" (read: for several years if not forever)
(21:38:47) becm: other distributions use 1.25.1 (OpenSUSE, Debian stable)=

(21:38:47) uipko [~uipko@...2561...] =C3=A8 entrato nella s=
tanza.
(21:39:24) uipko ha abbandonato la stanza.
(21:39:27) dazo: Hmmm ... https://bodhi.fedoraproject.org/updates/?packag=
es=3Dpkcs11-helper
(21:39:31) uipko [~uipko@...2561...] =C3=A8 entrato nella s=
tanza.
(21:39:54) uipko =C3=A8 ora conosciuto come uip
(21:40:32) dazo: Hmmm ... https://packages.debian.org/buster/libpkcs11-he=
lper1  1.25 indeed
(21:40:34) vpnHelper: Title: Debian -- Details of package libpkcs11-helpe=
r1 in buster (at packages.debian.org)
(21:40:43) becm: Fedora/RH stayed on 1.22 for 2 years now
(21:41:48) becm: leading to the same token problem with EC-keys for OpenS=
SL 1.1.x
(21:42:27) becm: so, the question is, do we care and can anybody test reg=
ressions.
(21:42:41) dazo: right ... I see 1.26 got released in January, including =
a patch from Selva
(21:42:43) dazo: https://github.com/OpenSC/pkcs11-helper/releases
(21:42:45) vpnHelper: Title: Releases =C2=B7 OpenSC/pkcs11-helper =C2=B7 =
GitHub (at github.com)
(21:43:40) mattock: becm: I think we do care, but we can't really test
(21:44:04) mattock: but 2.5-beta would be a better place to break things =
than 2.5.x
(21:44:12) mattock: or some random windows installer release
(21:44:17) dazo: agreed
(21:44:37) mattock: so would 1.26 - in theory - solve all our problems?
(21:44:58) dazo: not the rfc7512 issue
(21:45:23) mattock: oh yes that is the "upstream does not consider it an =
issue" thing, right?
(21:46:01) dazo: yes
(21:46:32) mattock: anyways, I'm fine with upgrading pkcs11-helper and ap=
plying the new patch (assuming it applies cleanly to 1.26)
(21:46:36) mattock: fedora patch
(21:46:53) mattock: and would prefer to do that a.s.a.p. so that I can ge=
t it to the MSI installers soon
(21:46:55) becm: 1 line dif =3D=3D cleanly?
(21:47:15) mattock: I think misunderstood you
(21:47:22) mattock: did not actually try to apply it
(21:48:41) becm: Fedora patch -> clean for 1.22
(21:49:23) becm: everything newer, 4 warnings due to line offset (copyrig=
ht change)
(21:49:27) dazo: Just started a local testbuild based on the fedora rawhi=
de .spec, updating to 1.26 ... it the patch applied with "patch offset wa=
rnings" only
(21:50:07) becm: the upstream OpenSC/pkcs11-helper/pull/4 should apply cl=
eanly
(21:50:27) mattock: mm, the patch is actually quite big
(21:50:32) dazo: it is
(21:50:33) becm: dwmw2 does/did regular rebases
(21:51:24) dazo: dwmw2 is a good guy
(21:51:58) becm: maybe he knows why Fedora is stuck on 1.22?
(21:52:39) dazo: He definitely does ... we just need to reach out.  I can=
 send a mail to fedora-devel asking why Fedora is stuck on 1.22
(21:53:01) mattock: sounds good
(21:53:09) mattock: so we wait until we get a response?
(21:54:08) dazo: I think we can plan for 1.26 in the windows builds at le=
ast, once I've seen that my test build works fine ... The patching issues=
 I see are just these ones: https://termbin.com/l5gi
(21:54:27) mattock: same here, I also tested it
(21:54:41) becm: yep, looks familliar :)
(21:54:43) dazo: Otherwise it builds and packages fine for me
(21:56:00) mattock: so, do we want an answers to the "why is Fedora stuck=
 on 1.22" first or shall I just go ahead and upgrade libpkcs11-helper and=
 the patch?
(21:56:06) mattock: 1.26 + patch
(21:57:02) dazo: lets do it in parallel ... we start testing 1.26 for Win=
dows and ask in Fedora
(21:57:05) mattock: ok
(21:57:46) becm: is there a plan for 2.4.10? (would also be a target for =
updated patch)
(21:58:18) mattock: not afaik
(21:58:52) mattock: this could be released in a Windows installer release=
, but then again, something could break
(21:58:53) cron2: becm: well, that's more a "new windows installer of 2.4=
=2E9" if there is no actual openvpn change, just "packed libraries"
(21:59:11) cron2: but we could certainly do that if testing turns out tha=
t this is good
(21:59:21) dazo: yeah
(21:59:43) becm: if I remember correctly, the current state in Fedora in =
fedora is a "frankenpatch". Headers from current upstream, content from 1=
=2E22
(22:01:17) becm: (git commit IDs)
(22:02:29) mattock: anyhow, 2 minutes overtime, getting late and I think =
we have a plan
(22:02:30) mattock: agreed?
(22:03:59) cron2: yeah
(22:04:09) mattock: ok, let's end this thing
(22:04:15) mattock: I will send a summary in a few minutes

--------------B5D34F2167C6BB97DD028B4B--

--iU1RDi4yz26oxOGynqhAuBBsqE0Xj6PS8--

--OZ7qEERGfxq6Y4PaGJzhTTvIQgYXF1E9V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl7rvHcACgkQKVhNn0CG
RXiYrAf9GG1RVhY5rJByAbwAd1uJRsA+uQ3inwVOUy16DkIRyFxhk8/VirNCcwf6
rZibMssswsdgjBpKi0cfkGCgMvqxrhaOpchp5DhqQvh/zT8sNmhv/y+sOVmN7UIq
7zfC0isjIIYXaYELKDvhXpr3IquKmXR7Q5ZEKiY+e8jLxi3mH95Qv+9LOk7e+TX6
OM0noEKFwEt+jEuNu9Rjp6S6es9W/aRA69o/Y3YnxPChIbfhrNOJo85u0ajhGRjU
IuqSOUv4retgjrFTRladPaU13RO43AMCIQpQ47SQUjFS38R6VXhMcrA3xWmItefC
zvsJyIgGeAfIgQt53z5pMJUTZyPpyA==
=S9cV
-----END PGP SIGNATURE-----

--OZ7qEERGfxq6Y4PaGJzhTTvIQgYXF1E9V--

