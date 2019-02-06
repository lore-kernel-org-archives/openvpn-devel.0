From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <c9728861-11ec-fd98-a48e-c79c82fbaa08@...515...>
Date: Wed, 6 Feb 2019 13:45:17 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sonBYHUzn937ukuLU6tUNFwuBClHZZcMs"
Subject: [Openvpn-devel] Summary of the informal meeting on 6th Feb 2019
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
--sonBYHUzn937ukuLU6tUNFwuBClHZZcMs
Content-Type: multipart/mixed; boundary="OKFxo9C2NCBM1bEYVNzyeI99IL8MglHeM";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <c9728861-11ec-fd98-a48e-c79c82fbaa08@...515...>
Subject: Summary of the informal meeting on 6th Feb 2019

--OKFxo9C2NCBM1bEYVNzyeI99IL8MglHeM
Content-Type: multipart/mixed;
 boundary="------------89AE2406FC7E352F7F719DB7"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------89AE2406FC7E352F7F719DB7
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi all,

We had an informal "regrouping meeting" today on #openvpn-meeting.
Here's a similarly informal summary of it.

OpenVPN T-shirts
----------------

Mattock will start sending out the T-shirts to the people who were asked
about them and expressed interest in them. If you want to expedite the
arrival of your T-shirt please send email to mattock with your postal
address in it.


OpenVPN 2.5
-----------

Mattock will resume testing MSI building - it was almost working when he
worked on it the last time (late Dec 2018). Hopefully this will put the
MSI wheels into motion again, so that we get the functionality fully
merged into openvpn and openvpn-build.

Developers have various 2.5-related stuff on their plates which they
promised to pick up. Only one or two miracles are needed to get 2.5 out
of the door.


Tap-windows6 HLK testing
------------------------

Sgstair is nearing completing in his quest for fixing HLK testing of
tap-windows6. The three pieces that are missing are:

1) Windows wants priorities

These are now passed via 802.1q/802.1p headers, but this creates
incompatibilities with "normal" tap peers, so we need an ioctl() to turn
this on for HLK test and off for production use

2) HLK test wants a link status change

In other words: "unplug the network cable now, so I can see that the
link status changes to down"

3) 802.3 ethernet frames not passing linux bridging

The HLK test driver sends 802.3 ethernet frames at some point, which do
not pass linux bridging for whatever reason. Cron2 sent some ideas to
sgstair about these earlier today.

The test setup is "tap clients -> tap p2p server -> linux bridge -> tap
p2p server2 -> tap client 2". For some reason "something in our tap p2mp
code" did not work right so we went for a linux bridge, which worked
better - except for the 802.3 packets which "just disappear"

---

Once these three issues are fixed we can get a WHQL certification for
tap-windows6, which enables us to build it for Windows Server 2016/2019
and make a new tap-windows6 release in three different variants:

- Windows 8.1 and earlier (cross-signed)
- Windows 10 (attestation-signed)
- Windows Server 2016/2019 (WHQL-certified)

NSI installers (OpenVPN 2.4.x) will not be updated to support these
different driver/signature variants - instead, three different variants
will be offered. MSI installers can already install the correct
driver/signature variant.

OpenVPN 2.4.7 release
---------------------

Agreed that we should release OpenVPN 2.4.7. There's plenty of small
stuff in it, and 2.4.6 was released almost a year ago. It was agreed
that 2.4 is quite mature as we haven't had any really compelling reason
to do a new point release in a year. Release date was set to Tuesday
19th Feb.

Samuli

--------------89AE2406FC7E352F7F719DB7
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-02-06.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-02-06.txt"


(12:32:56) mattock: howdy
(12:33:02) cron2: mattockman!
(12:33:35) mattock: first meeting in a while
(12:33:39) mattock: \o/
(12:33:48) ordex: yeah
(12:33:54) ordex: shame on us !
(12:34:22) mattock: what to discuss? state of the union?
(12:34:25) mattock: i.e. 2.5
(12:34:59) ordex: yeah
(12:35:04) ordex: maybe
(12:35:14) cron2: what about a quick round of updates what everyone is cu=
rrently working on and what are the next things to tackle?
(12:35:16) ordex: dazo will be a bit late
(12:36:01) ordex: I am fine with the round of update
(12:36:57) mattock: I can start
(12:37:11) ordex: k
(12:37:17) mattock: I got the new MSI packaging thingy mostly working in =
vagrant
(12:37:30) mattock: so you have "openvpn-build" VM which builds the execu=
tables, libraries, etc
(12:37:35) mattock: it then shares those with Samba
(12:37:42) mattock: which the "msibuilder" VM can then consume
(12:38:04) cron2: afk for a minute... bbl
(12:38:14) mattock: I ran into some issues with the MSI build requiring s=
ome old binaries (zip version?) but rozmansi fixed those afaik
(12:38:21) mattock: didn't not have time to test his fixed version
(12:38:53) mattock: the vagrant-based setup works fine until we need/want=
 to start producing installer per-commit (like we did in the past with NS=
IS)
(12:39:37) plaisthos: I get picked up for lunch in half an hour.
(12:39:44) mattock: that's pretty much it - cron2 can describe the situat=
ion with tap-windows6
(12:39:44) plaisthos: So don't have much time
(12:39:47) ordex: let's try to be quick then :)
(12:39:52) mattock: plaisthos: that's a good deadline for all of us :P
(12:40:28) mattock: on a high-level tap-windows6 is "almost done" with on=
ly a few gotchas to resolve - cron2 gave sgstair a bunch of hints he coul=
d try to get the final HLK tests pass
(12:40:54) ordex: so we're still in "some HLK tests are not passing and n=
eed to fix them? "
(12:41:00) ordex: from an high level perspective
(12:41:12) mattock: yes
(12:41:18) mattock: one or two I believe
(12:41:54) mattock: we may need to make some fixes in our bridging code
(12:42:03) mattock: just enough to make HLK tests pass
(12:42:43) ordex: ok. is all his work still within the amount of hours th=
at were estimated?
(12:42:46) mattock: cron2 has more details / understanding
(12:42:50) ordex: or is he now hired by openvpn inc basically? :D
(12:43:04) mattock: I have no clue, but we agreed on a price limit
(12:43:12) mattock: so we're safe in that way
(12:43:31) ***dazo is here
(12:43:36) ordex: alright
(12:43:49) mattock: but HLK testing is mostly about "run a test, wait, fa=
ils, try to fix, run a test, wait, fails..."
(12:43:58) mattock: the whole testsuite takes 10+ hours
(12:44:03) ordex: oh ok
(12:44:21) mattock: slow process to say the least
(12:44:25) cron2: re
(12:44:41) mattock: cron2: anything to add to the HLK thingy
(12:44:42) mattock: ?
(12:45:20) cron2: so, HLK.  If I am not missing anything, there's basical=
ly three things left to work out
(12:46:00) cron2: - windows wants priorities, which are now passed via 80=
2.1q/802.1p headers, but this creates incompatibilities with "normal" tap=
 peers, so we need an ioctl() to turn this on for HLK test and off for pr=
oduction use.  (Bah)
(12:46:19) ordex: ?!
(12:46:20) cron2: - HLK test wants a "unplug the network cable now, so I =
can see that the link status changes to down" now
(12:47:04) cron2: - the HLK test driver sends 802.3 ethernet frames at so=
me point, which do not pass linux bridging for whatever reason - this is =
the major stopgap right now, and I was too busy to work on this - but pic=
ked up the ball today again
(12:47:22) cron2: (the setup is "tap clients -> tap p2p server -> linux b=
ridge -> tap p2p server2 -> tap client 2)
(12:47:47) cron2: "something in our tap p2mp code" did not work right so =
we went for a linux bridge, which worked better - except for the 802.3 pa=
ckets which "just disappear"
(12:48:07) ordex: hm interesting
(12:49:03) cron2: but Steven generally sounds optimistic about the driver=
 and testing itself :)
(12:50:51) cron2: my personal work plan still has "everything you ACK" pl=
us "ipv6-only patch set" on it...
(12:51:29) ordex: "everything you ACK" << is this the beginning of a song=
? :-P
(12:51:31) dazo: I have the auth-token-hmac review on my plan as an high =
priority task
(12:51:46) cron2: cool
(12:51:49) mattock: ordex: that could be the case
(12:53:26) ordex: on my side I have 1) continue reviewing client-connect =
patchset 2) address changs from Arne for transport-api patchset 3) vlan p=
atches
(12:53:38) ordex: sitnl should still be waiting for more review - IIRC
(12:54:01) plaisthos: Yeah, I plan to pick up some of patches
(12:54:05) cron2: ordex: you're in .HK or in .AU these days?  Or in Italy=
?
(12:54:12) ordex: cron2: Australia right now
(12:54:21) ordex: I'll be back in Italy at the end of the month
(12:54:23) plaisthos: there are also patches that are in a limbo state of=
=20
(12:54:23) cron2: what time is it over there?
(12:54:28) ordex: almost 9pm
(12:54:38) cron2: workable
(12:54:41) plaisthos: -> feature sounds good, but needs some work, but no=
 followup from submiter
(12:54:44) ordex: yeah
(12:55:00) cron2: there's a heap of TLS1.3 related patches as well...
(12:55:04) ordex: plaisthos: maybe we can send a ping to those patches?
(12:55:53) dazo: If there's anything you think I really should dive into,=
 please let me know ... my plate is fairly full these days, so I might ov=
erlook stuff ... And I'll try to re-prioritize my todo list accordingly
(12:56:42) cron2: we might want to send some cookies to fox-it to get syz=
zer interested again :)
(12:57:04) dazo: lets arrange the next hackathon there ... so they don't =
forget about us! :-P
(12:57:14) ordex: ahah
(12:57:19) mattock: cron2: maybe the T-shirt will help? :P
(12:57:25) cron2: sounds good
(12:57:27) mattock: +1
(12:57:53) dazo: mattock1: make sure there's t-shirts to syzzer_'s manage=
rs as well ;-)
(12:58:11) mattock: dazo: for that I need to order a few extras :)
(12:58:25) mattock: I did get three extras just in case, but the sizes mi=
ght not be good
(12:58:32) dazo: :)
(12:58:57) mattock: unless there's a medium manager and a xl manager at f=
ox-it by accident :P
(12:59:21) mattock: ok so plaisthos has to leave soon
(12:59:34) mattock: are we done with this brief get-together / status upd=
ate?
(13:00:09) mattock: oh
(13:00:10) mattock: one thing
(13:00:36) mattock: I'm planning on sending the T-shirts to the ovpn3 tea=
m via lev - the team will meet in Lviv in March/April
(13:00:45) mattock: saves effort and postage fees
(13:01:01) mattock: others will receive individual packages
(13:01:14) ordex: <3
(13:01:15) mattock: you can expedite my T-shirt sending process by sendin=
g your mail addresses via email
(13:01:24) dazo: makes sense, thx!
(13:02:11) mattock: I will be a unique snowflake as I will have a T-shirt=
 that is perfect except that the "e" in Karlsruhe is slightly clipped - y=
our shirts will be just perfect
(13:02:21) mattock: mine is the sample T-shirt
(13:02:41) mattock: ok that's all from my end
(13:02:55) mattock: except that somebody might want to have a look at the=
 PRs in openvpn-vagrant
(13:03:02) mattock: msibuilder and all that
(13:03:31) cron2: where is the MSI stuff? openvpn-build?
(13:03:38) mattock: yes
(13:03:48) mattock: no
(13:03:51) mattock: openvpn-vagrant
(13:04:03) mattock: https://github.com/OpenVPN/openvpn-vagrant/pulls
(13:04:04) vpnHelper: Title: Pull Requests =C2=B7 OpenVPN/openvpn-vagrant=
 =C2=B7 GitHub (at github.com)
(13:04:16) mattock: Debian packager + MSI packager VMs, each in their sep=
arate PRs
(13:04:22) cron2: well, that is the VM, but the actual msi build scripts?=

(13:04:37) mattock: let me check
(13:04:49) mattock: the vagrant provisioning script shows it, can't recal=
l the location
(13:05:02) mattock: rozmansi/openvpn-build should have it in some branch
(13:05:21) cron2: ah.  So we need to get that part PRed into openvpn-buil=
d eventually...
(13:05:32) mattock: here: https://github.com/rozmansi/openvpn-build/tree/=
feature/windows-msi
(13:05:33) vpnHelper: Title: GitHub - rozmansi/openvpn-build at feature/w=
indows-msi (at github.com)
(13:05:52) mattock: this one needs to go in: https://github.com/OpenVPN/o=
penvpn-build/pull/141
(13:05:54) vpnHelper: Title: Windows MSI Packaging by rozmansi =C2=B7 Pul=
l Request #141 =C2=B7 OpenVPN/openvpn-build =C2=B7 GitHub (at github.com)=

(13:06:23) mattock: I'll take another stab at using the msibuilder
(13:06:29) cron2: for whatever reason github is not sending me mails for =
-build PRs... *scratch head*
(13:06:30) mattock: if that works, I think we should just merge that PR
(13:06:43) mattock: selva gave the PR lots of review already
(13:07:00) mattock: so if it works, I think it is good enough
(13:07:17) mattock: plus it does not affect any existing build logic afai=
cr
(13:07:56) cron2: fine with that
(13:08:10) cron2: I did all the openvpnmsica patches... :)
(13:08:16) mattock: \o/
(13:08:25) mattock: are all of simon's openvpn patches in?
(13:08:29) cron2: (Simon wanted to send more updates on those, but has be=
en fairly quiet since then)
(13:08:30) mattock: he sent a bunch
(13:08:39) cron2: yeah, like 12 or so... :)
(13:09:00) cron2: Simon Rozman (16):
(13:09:06) mattock: I think things will start rolling when we start movin=
g again
(13:09:31) cron2: but i had complaints about a few of those, so he promis=
ed more goodness :-) - like "tapctl" only showing actual *tap* devices an=
d not "just all network adapters in the system"
(13:09:41) mattock: I recall that, yes
(13:09:50) cron2: tincantech did quite a bit of testing on the MSI packag=
es, and things are looking nice
(13:10:19) mattock: yeah, this is not a trivial update and needs good tes=
ting
(13:10:30) dazo: btw ... there's been a lot of windows related discussion=
 ... is that what is holding back the 2.4.7 release now?
(13:10:40) mattock: although we should recommend "uninstall with NSIS uni=
nstaller first, then install the MSI package"
(13:11:07) mattock: I don't think so, unless we count tap-windows6
(13:11:17) mattock: which would be very nice to get updated
(13:11:21) dazo: yeah, I count tap-windows6 too
(13:11:22) cron2: dazo: well, we can do 2.4.7 with the old tap driver - w=
hich will bring openvpn updates, but not tap driver update
(13:11:39) cron2: I have forgotten what our plan was for 2.4.7... and if =
patches are missing still?
(13:11:47) dazo: the 2.4.6 release arrived April 19 .... soon a year ago.=
  And I know we postponed 2.4.7 due to tap-windows6 fixes being in the pi=
pe and ready "soonish"
(13:12:05) mattock: yeah, that was probably half a year ago :P
(13:12:13) mattock: before we really knew the mess that HLK testing was
(13:12:28) dazo: I think we should run a 2.4.7 release .... this is what'=
s in the pipe for that release now: http://termbin.com/9b8u
(13:12:52) mattock: that's plenty
(13:13:15) dazo: it is ... lots of minor bug fixes, but also some other i=
mportant ones as well
(13:13:51) cron2: timeline?  Feb 19?
(13:14:11) dazo: we can sure try that
(13:14:12) mattock: sounds reasonable if there's not much / anything miss=
ing
(13:14:33) cron2: ISTR that there are gui patches floating around related=
 to --script-security
(13:14:40) mattock: even if we manage to get tap-windows6 WQHL-certified,=
 we can always update the Windows installers
(13:14:43) mattock: after 2.4.7
(13:14:46) cron2: yes
(13:14:54) dazo: exactly
(13:15:13) mattock: for NSIS we'd have separate installers for various ta=
p-windows6 signing schemas
(13:15:41) mattock: cross-signed (Win 8.1 and below), attestation-signed =
(Win 10), WHQL-certified (win server 2016+)
(13:16:04) mattock: which is a bit messy, but personally I would not spen=
d time making this less crappy in nsis
(13:16:12) mattock: msi is something else
(13:16:44) mattock: I believe the msi installer already has logic for use=
 the correct driver (=3Dsignature) depending on the OS
(13:17:30) cron2: yes
(13:19:01) mattock: so, do we all know what to do to get 2.4.7 and 2.5 ou=
t now?
(13:19:22) mattock: "do we now know" would be more appropriate :P
(13:19:41) cron2: one or two minor miracles, not too bad
(13:19:44) ordex: :D
(13:19:47) mattock: :D
(13:20:03) mattock: we'll get the piece by piece
(13:20:07) mattock: or in pieces
(13:20:11) cron2: well said :)
(13:20:48) mattock: I'll pick up the msi building thingy, which includes =
openvpnserv2 update as well
(13:20:59) mattock: I'd expect rozmansi to wake up with that
(13:22:30) mattock: anything else?
(13:23:19) ordex: not on my side
(13:26:55) dazo: just one last remark in regards to the v2.4.6/2.4.7 ....=
 it is quite a good signal that we've not needed to do any urgent updates=
 in almost a year ... so as of v2.4.6, it is now definitely stable (even =
though there are some minor issues we're fixing in 2.4.7)
(13:27:57) ordex: definitely stable .... with some issues!!
(13:28:01) ordex: ;)
(13:28:09) ordex: but I agree overall
(13:28:20) mattock: mature software is good software
(13:28:43) mattock: meeting next week btw?
(13:28:51) dazo: yeah, lets do that
(13:29:01) ordex: oky
(13:29:17) mattock: I will send an uninformal summary of this discussion =
to openvpn-devel

--------------89AE2406FC7E352F7F719DB7--

--OKFxo9C2NCBM1bEYVNzyeI99IL8MglHeM--

--sonBYHUzn937ukuLU6tUNFwuBClHZZcMs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlxayM0ACgkQKVhNn0CG
RXh1SQf/RIvPNPXynAjZDNYqOYUjgtxbg+JTJusJ6tTEJW7bd4qPMimjJAVXfNE+
PbCdHHyae9igSS4lYNmSIglVkHOZm061zVDHxyUtxjn4DU0ydWmjwohr8Rv3zVf8
tNblZIAHHYBLeMMcYKxMWT8Wi9OwswwvSWEkb0V682rAA8wxQqlYsi1787lWwczQ
iiMJAeVLSFcnRO+ZuFUec79wolUMmybJ1iR1/HnndbgqY97ecjx18OXcE58JVCU2
Xt/ed74pG7HFdnCtVk2EghRMBZcB7UFmjeHc6gcBeFUVkVZdNRUruE5ABYTU/Rb1
216cxnfyOPzBH0t60CTmckarhMu0hw==
=lz6u
-----END PGP SIGNATURE-----

--sonBYHUzn937ukuLU6tUNFwuBClHZZcMs--

