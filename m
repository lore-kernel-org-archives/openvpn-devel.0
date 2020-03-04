From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <f9786676-a7ad-8b0d-708a-ff724d27376c@...515...>
Message-ID: <bd413699-7cf8-cb68-8236-531f1b64d8f8@...515...>
Date: Wed, 4 Mar 2020 13:31:44 +0200
MIME-Version: 1.0
In-Reply-To: <f9786676-a7ad-8b0d-708a-ff724d27376c@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="28zc5RZsNCHh4UYeD3nbh6laEdvyc1bXq"
Subject: [Openvpn-devel] Summary of the community meeting (4th March 2020)
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
--28zc5RZsNCHh4UYeD3nbh6laEdvyc1bXq
Content-Type: multipart/mixed; boundary="0k258p0zwJwQjtgZUdxY0wypcw43hQiOU"

--0k258p0zwJwQjtgZUdxY0wypcw43hQiOU
Content-Type: multipart/mixed;
 boundary="------------36130AC0A4F3B87C302E47F2"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------36130AC0A4F3B87C302E47F2
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 4th March 2020
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-03-04>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock, plaisthos and rozmansi participated in this meeting.

---

Talked about the OpenVPN MSI installer. Rozmansi took a week off from
work to wrap up the OpenVPN MSI installer. The original driver
installation approach that used WiX diffx extension had issues, so
rozmansi chose to reuse wintun's reliable and proven MSM (Merge module)
code, packing both wintun and tap-windows6 in it. This was desirable to
reinventing the wheel, and there was no license incompatibility either.
If any changes to the installer code are required we do want to get them
merged upstream in the wintun project.

--

Noted that the following things still need work before we can release 2.5:

<https://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn25>

The "must have" things that still need some work:

- Purge NSIS installers
- Implement asymmetric compression
- async client-connect support
- man page formatting change

On top of that we should

- go through what we have on the list / in patchwork
- go through trac and see what's broken (a few tickets are important)

--

Agreed that dazo should spend some time getting a Fedora Copr repo
running with openpvn git master to give Fedora and EPEL users
(RHEL/CentOS) a chance to test it out.

--

Agreed that it would be good if ecrist would update freebsd's
openvpn-current on a weekly basis until the release.

--

Mattock will work on the auth-user-pass documentation thing (see status
page above) which he had forgotten about.

--

Rozmansi has some more openvpn/src/tap.c windows-specific commits
pending and but he's hoping to get the existing patches through first.

--

Cron2 will review networking/routing related things before they are merged.

--

Noted that lzo 2.10 breaks comp-lzo when built with GCC 10. This may
become a problem on operating systems that ship both (e.g. Fedora 32).

Agreed that this is not our battle. Either operating system vendors
build with the workaround (-fno-strict-aliasing) or lzo project fixes
their software. We already quit with a good error message ("Cannot
initialize LZO compression library").

--

Discussed the release schedule for OpenVPN 2.5. Agreed that moving the
tentative deadline for 2.5_beta1 to late March is actually doable given
our current resources.

---

Full chatlog attached


--------------36130AC0A4F3B87C302E47F2
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-03-04.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-03-04.txt"

(12:34:20) rozmansi: hi
(12:34:20) cron2: ho!
(12:34:20) dazo: hey!
(12:34:20) dazo: mattock: We need to get better at updating /topic ....
(12:34:20) cron2: not sure if mattock had enough coffee yet
(12:34:20) ***: Playback Complete.
(12:34:26) mattock: hi
(12:34:37) mattock: I do not drink anything with caffeine except on Thurs=
days
(12:35:40) dazo: heh
(12:36:44) cron2: what is special about thursday?
(12:37:03) dazo: So shall we take a look at https://community.openvpn.net=
/openvpn/wiki/StatusOfOpenvpn25 and try to get a path forward again?
(12:37:04) vpnHelper: Title: StatusOfOpenvpn25 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:38:17) mattock: nothing special about Thursday, except that I'm at th=
e office on Thursdays so I want to drink some cola then :)
(12:38:47) cron2: dazo: yes.  From my end of things, March looks much bri=
ghter now - as in: my DC move is nearly done
(12:38:49) mattock: when I got a 24 hour headache when going to Trento (p=
lane was delayed, no coffee or tea to drink) I decided to stop caffeine m=
isuse
(12:38:51) cron2: one more "midnight"
(12:39:04) mattock: let's have a look at the status
(12:39:15) mattock: rozmansi has been working on the MSI installer recent=
ly
(12:39:24) mattock: any news on that front?
(12:39:53) rozmansi: i made a tap-windows6.msm
(12:40:33) cron2: what I wanted to say was "I have more time for things a=
fter tomorrow", so we can get stuff tested and ACKed
(12:40:37) cron2: merged
(12:40:38) rozmansi: as discussed a lot of times: wix's diffx extension t=
o install drivers has issues... so I decided to reuse the wintun reliable=
 and tested approach.
(12:41:04) cron2: sounds good
(12:41:07) dazo: +1
(12:41:25) rozmansi: I am updating MSI packaging now to use it. Actually,=
 it'll pack both wintun.msm and tap-windows6.msm.
(12:41:34) mattock: \o/
(12:42:07) rozmansi: I have taken a week off at work, so I can finally de=
vote to openvpn msi packaging
(12:43:08) dazo: that's generous and awesome!
(12:43:22) rozmansi: dazo: thanks
(12:43:38) mattock: +1
(12:43:52) cron2: +1
(12:43:58) rozmansi: I may reuse existing wintun msm installer in tap-win=
dows6, right? It is GPL v2.
(12:44:09) mattock: tap-windows6 is GPLv2 as well
(12:45:24) rozmansi: just double checking, since the copyright holder is =
not on very good terms with openvpn.
(12:46:09) rozmansi: but his driver installer is rock-solid. real-world p=
rooven and reliable.
(12:46:25) rozmansi: really have no time to reinvent the wheel here.
(12:46:47) mattock: is the installer code a separate project or in the wi=
ntun repository?
(12:46:54) rozmansi: in wintun repo
(12:46:56) mattock: ok
(12:47:25) mattock: we'd definitely want to contribute to it if that is e=
ver needed
(12:48:01) mattock: anyhow, the MSI plan looks solid
(12:48:15) mattock: anything else about MSI or shall we move forward with=
 other missing pieces?
(12:48:37) rozmansi: that's about it from my side
(12:48:54) dazo: thx a lot, rozmansi!
(12:49:10) rozmansi: np
(12:50:25) mattock: what else is still wip in 2.5?
(12:50:42) dazo: the 3 other "must have" in the status page :-P
(12:51:13) cron2: plus "go through trac and see what's broken"
(12:51:23) cron2: plus "what we have on the list / in patchwork"
(12:51:31) cron2: but that's normaly routine work anyway, or it should be=
 :)
(12:51:38) dazo: mattock: I was wondering about the "update auth-user-pas=
s docs" task attached to you
(12:52:44) dazo: Perhaps I should spend some time getting a Fedora Copr r=
epo running with openpvn git master ... that gives Fedora and EPEL users =
(RHEL/CentOS) a chance to test it out
(12:53:03) cron2: +1
(12:53:28) mattock: oh, I have a task
(12:53:31) mattock: let me check
(12:53:38) cron2: and we should ask ecrist to update freebsd's openvpn-cu=
rrent weekly now until release, or so
(12:54:07) dazo: right, that'd be good too
(12:54:25) mattock: ok, I completely forgot about that auth-user-pass thi=
ng=20
(12:54:35) mattock: I'll check if I have a ticket about it
(12:55:04) rozmansi: cron2: some of my patches in the patchwork are acked=
 by lev__ , but are still not merged. any particular reason?
(12:55:51) dazo: rozmansi: I vaguely remember someone wanted to do some e=
xtra tests .... but my memory is blurry now
(12:56:59) cron2: rozmansi: no particular reason except "I was totally ov=
erloaded in February" (like, days with 15 hours billed to customer...) an=
d then I was snowboarding
(12:57:29) cron2: I will take up the slack end of this week :-) - today i=
s the last "very late evening" day for me on this project
(12:57:47) cron2: (sorry for that, this DC move was supposed to be finish=
ed by end of January...)
(12:58:42) rozmansi: ah, ok. same here. yust remembered thou, as I have s=
ome more openvpn/src/tap.c windows-specific commits pending and was hopin=
g to get the existing patches thru first.
(12:58:51) dazo: no need to be sorry, that's life ... paid work unfortuna=
tely need to have a higher priority
(12:59:01) cron2: dazo: I want to do some extra tests and review on every=
thing network/routing related, so I asked you to not charge ahead and com=
mit everything :-)=20
(12:59:11) dazo: right, that was it :)
(12:59:21) cron2: but this is more in the "if lev says it's good, fine wi=
th me" field
(12:59:42) cron2: anyway: rozmansi: I'll do these all thursday evening (t=
omorrow).
(13:00:08) plaisthos: sorry for being late=20
(13:00:28) mattock: hi plaisthos!
(13:00:45) cron2: howdy
(13:00:47) mattock: plaisthos: how is the go through trac tickets thing g=
oing? I recall you were on it?
(13:01:00) plaisthos: no
(13:01:06) plaisthos: I was going throught the patch queue
(13:01:08) mattock: ok
(13:01:09) mattock: sorry
(13:01:25) mattock: perhaps I optimistically misheard/misread something :=
D
(13:03:19) dazo: I'd say patchwork > trac :-P
(13:03:26) cron2: yes
(13:03:52) cron2: but there's a few things in trac that also need attenti=
on
(13:04:02) cron2: shall we try to agree on a new timeline?
(13:04:27) cron2: like, "move all tentative milestones by +2 months"?
(13:06:00) dazo: Btw ... just an issue which appeared quite recently on F=
edora 32 (Rawhide, iirc - not yet released) ... lzo has been updated to 2=
=2E10, which breaks things - but it seems to break a lot more than just o=
penvpn; and the gcc folks were not impressed by some stuff happening in l=
zo (calling it broken) ... rebuilding lzo without -fno-strict-aliasing (i=
irc), fixes the issue - which is an ugly fix ... so that may blow up in o=
ur face unless=20
(13:06:01) dazo: lzo fixes this fairly soon
(13:06:14) dazo: cron2: sounds like a good idea
(13:07:23) cron2: dazo: huh.  FreeBSD is on lzo_2.10 since ages, but I ha=
ve no idea whether they've done something special to make it not-explode.=
=2E.
(13:08:09) cron2: as is gentoo
(13:08:16) dazo: cron2: yeah, F32 will ship with GCC10 ... I'll look at t=
he compile logs there and see if there are more warnings we should look i=
nto
(13:08:37) plaisthos: there is a new lzo version?
(13:08:49) dazo: lzo-2.10
(13:08:51) dazo: iirc
(13:08:59) ***dazo digs up the bz
(13:09:40) cron2: dazo: ah, maybe it's just the gcc version being more st=
rict about "if it's undefined, we mean it!"
(13:09:55) cron2: freebsd has llvm/clang, gentoo has gcc 9.2
(13:10:02) plaisthos: if everything fails we can brorrow openvpn3's lzo i=
mplementation :P
(13:10:20) cron2: you've done your own?
(13:10:40) plaisthos: for some reason James write his own decompress only=
 lzo implementation
(13:10:49) plaisthos: s/write/wrote/
(13:11:01) cron2: less external dependencies, more nicely integrated... I=
 can see the benefits
(13:11:02) dazo: OpenVPN bz: https://bugzilla.redhat.com/show_bug.cgi?id=3D=
1802299 ... lzo bz: https://bugzilla.redhat.com/show_bug.cgi?id=3D1807737=
  ... gcc bz: https://bugzilla.redhat.com/show_bug.cgi?id=3D1808821
(13:11:03) vpnHelper: Title: 1802299 openvpn cannot seem to load updated =
lzo (at bugzilla.redhat.com)
(13:12:03) plaisthos: lzo 2.10 does not seem that new
(13:12:07) plaisthos: my app also uses it
(13:12:34) plaisthos: since end of 2017
(13:12:37) plaisthos: or longer
(13:13:12) dazo: yeah, it seems to be related to GCC being stricter with =
aliasing=20
(13:13:38) plaisthos: hm but looking a the openvpn bug report, we quit wi=
th a sensible error message
(13:13:41) plaisthos: so that is good :)
(13:13:42) mattock: interestingly we seem to be using lzo 2.10 in openvpn=
-build as the default
(13:13:49) mattock: https://github.com/OpenVPN/openvpn-build/blob/master/=
generic/build.vars
(13:13:50) vpnHelper: Title: openvpn-build/build.vars at master =C2=B7 Op=
enVPN/openvpn-build =C2=B7 GitHub (at github.com)
(13:14:04) dazo: mattock: it builds fine ... it explodes when using a con=
fig with --comp-lzo
(13:14:24) mattock: yes, but the results of openvpn-build are used by all=
 our windows users basically
(13:14:25) dazo: remove that option, and it works fine again
(13:14:36) mattock: perhaps people don't use --comp-lzo that much
(13:14:43) dazo: mattock: but which compiler version do you use ;-)
(13:14:50) mattock: ah ok
(13:14:50) dazo: this is related to GCC 10 too
(13:14:54) mattock: noted
(13:15:05) mattock: something much older I presume (mingw_w64 that comes =
with ubuntu 18.04)
(13:15:30) cron2: "It appears disabling make check was not the way to go =
after all"
(13:15:36) cron2: *snicker*
(13:16:07) dazo: :-P
(13:17:36) mattock: so what to do with lzo 2.10 + gcc 10? just wait until=
 lzo fixes their s*it?
(13:17:53) plaisthos: yeah
(13:17:59) plaisthos: This sounds not like our battle
(13:18:10) plaisthos: We quit with a good error message
(13:18:11) cron2: I read these as "we do not have to do anything, the dis=
tribution needs to compile with -fno-strict-aliasing and/or lzo needs to =
fix their code"
(13:18:53) cron2: and it's not our code that needs to be recompiled but t=
he lzo lib
(13:19:28) mattock: so "quit with a good error message" as suggested by p=
laisthos?
(13:19:33) plaisthos: although James lzo code had similar issues
(13:19:36) plaisthos: mattock: we already do that
(13:19:39) mattock: ok good
(13:19:42) dazo: yeah, I concur
(13:19:43) mattock: so no work on our part
(13:19:51) mattock: that's always the best outcome :D
(13:19:53) plaisthos: mattock: Cannot initialize LZO compression library
(13:20:12) mattock: good enough
(13:20:18) mattock: points to the correct direction
(13:20:51) mattock: so cron2 suggested setting a release schedule
(13:20:59) mattock: let's do that
(13:21:37) mattock: suggestions are welcome
(13:22:14) mattock: we still have 8 minutes left
(13:22:18) dazo: <cron2> like, "move all tentative milestones by +2 month=
s"?
(13:22:22) dazo: ^^^ I agree
(13:23:00) plaisthos: mattock: 8 minutes are bit close of a milestone
(13:23:06) mattock: lol!
(13:23:39) mattock: so "2.5_beta1 (late March)"
(13:23:59) mattock: if we can make that I'd be very happy
(13:24:19) mattock: except at the very time I have to start signing windo=
ws stuff again :P
(13:24:20) cron2: let's aim for it
(13:24:23) mattock: +1
(13:24:36) cron2: since we have commitment from corp to give us time...
(13:25:10) mattock: yep
(13:25:22) mattock: anything else for today?
(13:28:07) ***cron2 needs to go and cook noodles now
(13:28:16) cron2: so, no :-)
(13:28:30) mattock: ok, good meeting, next one next Thursday
(13:28:33) mattock: summary ready
(13:28:41) mattock: shall I update the dates on the status page as well?
(13:28:50) cron2: please
(13:28:53) mattock: ok
(13:29:58) mattock: done

--------------36130AC0A4F3B87C302E47F2--

--0k258p0zwJwQjtgZUdxY0wypcw43hQiOU--

--28zc5RZsNCHh4UYeD3nbh6laEdvyc1bXq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl5fkaEACgkQKVhNn0CG
RXiRkAf+Kl/WTz4ttPONfchAjtDCelYsujXoQQBuI0TYmWGIjtOI80/RkFCUVG+Q
n+yUYjQiGyar48yq9lRZCn+xkS4eWunnE6QWiA7jz7V8mMVPyH8h1yd9gNdEszFS
CP7432FUlC/U6FgsjTB2g+UM3lQfFN8kQD72mHqCXCa/1BJBy5P4KXAbPAF2Xpo5
r2PJRXjrIvPcRCbjKZ6iRdckCAfKP19NPZYtgxIxAn9q3ULyxC78HfN368BPY8S1
0oGW1QxgVx5c6etRGni6B8dtWm/6MCz367LyoGwvYiZ89JZhdr8K79rs5DPfbJ5j
SObMYH9y5RzZPpxMz+hm03sLaXGnVg==
=sy3S
-----END PGP SIGNATURE-----

--28zc5RZsNCHh4UYeD3nbh6laEdvyc1bXq--

