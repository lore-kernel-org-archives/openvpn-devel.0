From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <8ac38ebd-23b0-9024-adcd-75f11c344398@...515...>
Message-ID: <07da3806-2aad-c64c-6850-0dd081ea828b@...515...>
Date: Wed, 18 Sep 2019 13:53:00 +0300
MIME-Version: 1.0
In-Reply-To: <8ac38ebd-23b0-9024-adcd-75f11c344398@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RKWPU83etiYAqDu1s2eako73RPcq2cZyS"
Subject: [Openvpn-devel] Summary of the community meeting (18th September
 2019)
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
--RKWPU83etiYAqDu1s2eako73RPcq2cZyS
Content-Type: multipart/mixed; boundary="pfdmtfIcOEYmQ7rgGKBLa9uB0x9GOl6LE";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <07da3806-2aad-c64c-6850-0dd081ea828b@...515...>
Subject: Summary of the community meeting (18th September 2019)
References: <8ac38ebd-23b0-9024-adcd-75f11c344398@...515...>
In-Reply-To: <8ac38ebd-23b0-9024-adcd-75f11c344398@...515...>

--pfdmtfIcOEYmQ7rgGKBLa9uB0x9GOl6LE
Content-Type: multipart/mixed;
 boundary="------------BD1D7FC525E9322587781417"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------BD1D7FC525E9322587781417
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 18th September 2019
Time: 11:30 CEST (9:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-09-18>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, lev, mattock, ordex, plaisthos and rozmansi participated in
this meeting.

---

Discussed performance test results provided by Lev:

<https://patchwork.openvpn.net/patch/824/>

Based on this data we should start compiling OpenVPN and its
dependencies on Windows with Visual Studio: this provides a ~25%
performance improvement compared to MinGW builds.

Mattock will take a stab at generating NSIS installer from msvc
artefacts for the OpenVPN 2.4.8 release.

--

Discussed tap-windows6 pull requests:

<https://github.com/OpenVPN/tap-windows6/pulls>

Mattock will produce a test installer which comes with these fixes. Lev
will run it through some tests. If testing goes well and Selva gives his
ACK on

<https://github.com/OpenVPN/tap-windows6/pull/86>

we will include the new driver in the OpenVPN 2.4.8 installer.

--

Talked about the VLAN patches which ordex massaged into shape:

https://gitlab.com/ordex986/openvpn/commits/vlan

This has not moved forward because of unrelated challenges with Buildbot.

--

Talked about the build issues on the buildslaves. Fedora 29 and Ubuntu
18.04 are consistently failing the first t_client test. There are also
build issues on the Arch Linux builder. These need to be fixed.

--

Talked about the --disable-server option in OpenVPN 2.x. Nobody seems to
be (really) using it, and the "smaller executable size" argument is not
as important as it was in the distant past. Based on practical tests by
plaistos the stripped binary size with --disable-server is 562k and
without it 668k (~19% larger).

Mattock sent email to our mailing lists asking if somebody still needs
--disable-server. If not, we will kick it out in OpenVPN 2.5.

--

Full chatlog attached.

--------------BD1D7FC525E9322587781417
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-09-18.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-09-18.txt"

(12:29:59) mattock: hello
(12:30:05) cron2: just in time!
(12:30:11) cron2: and good morning :-)
(12:30:25) mattock: that as well :)
(12:31:25) lev__: guten morgen
(12:31:58) mattock: hyv=C3=A4=C3=A4 huomenta
(12:32:27) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
9-09-18
(12:32:28) vpnHelper: Title: Topics-2019-09-18 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:32:38) mattock: hmm we can probably consider removing topic #1 now
(12:32:49) cron2: bah, non-7bit letters in IRC, that ruins the efefct
(12:33:24) mattock: then we can do either "hyvaa huomenta" or "hyvaeae hu=
omenta"
(12:33:31) mattock: anyways
(12:33:45) mattock: no tap-windows6 updates as the HLK requirement disapp=
eared overnight
(12:34:06) dazo: morning!
(12:34:16) cron2: #1 - well, not really yet.  We have a few PRs, if I rem=
ember right, and we need to agree on a release (like, "which bits go in",=
 "which version number", "togehter with 2.4.x")
(12:34:33) cron2: it will be much less painful, tho
(12:35:33) ordex: !!
(12:35:36) mattock: yes, tap-windows6 was tied with 2.4.x release
(12:35:55) lev__: for the next Windows release we need to build with VS, =
since it produces code which is 25% faster comparison to mingw when using=
 tap-windows6 (425Mbit/s vs 340Mbit/s)
(12:36:19) mattock: interesting
(12:36:32) lev__: (see my mail)
(12:37:17) mattock: it may have been lost through the cracks
(12:37:25) mattock: is it a public or private email?
(12:37:33) dazo: public
(12:37:36) lev__: https://patchwork.openvpn.net/patch/824/
(12:37:37) vpnHelper: Title: [Openvpn-devel,1/7] Visual Studio: upgrade p=
roject files to VS2019 - Patchwork (at patchwork.openvpn.net)
(12:37:38) ordex: what a difference
(12:38:49) mattock: quite significant
(12:38:55) dazo: lev__: have you looked into compiler optimization flags =
and differences there?
(12:38:59) mattock: I was about to ask
(12:39:46) ordex: I guess they are completely different compilers, no? or=
 do they use the same software under te hood ?
(12:39:48) ordex: *the
(12:39:53) cron2: yeah, I find this highly amazing and wonder what makes =
such a huge difference
(12:40:01) cron2: ordex: mingw is gcc, MSVC is MSVC
(12:40:07) ordex: oh gcc
(12:40:08) ordex: ok
(12:40:23) dazo: it's different compiler ... but an optimized VC and an u=
noptimized GCC will also cause more extreme differences
(12:40:26) ordex: this said: the difference may not be exposed by some co=
mpiler flags, as the two compilers may just make different decisions
(12:40:29) lev__: dazo: not really, I used "release" configuration in VS =
and ./build-complete script in windows-nsis directory
(12:40:54) cron2: gcc is not like 30% worse in general, so it might be mi=
ngw runtime, adding *latency*, or possibly something in OpenSSL assembly =
which doesn't work out when cross compiled, or whatnot
(12:41:06) ordex: yap
(12:41:28) ordex: I'd dare to say that compiling with a real windows comp=
iler is not a bad idea ;p
(12:41:38) cron2: dazo: even if unoptimized we don't actually *do* very m=
uch inside the OpenVPN packet loop
(12:42:27) dazo: I haven't looked into the CFLAGS for our build script ..=
=2E but if do builds without -O flags and adds various debug helpers, tha=
t may have an impact
(12:42:42) cron2: dazo: it doesn't
(12:44:45) cron2: so while I'm curious why this is happening, I suspect i=
t's somewhat outside our control (mingw runtime, OpenSSL cross-build).
(12:45:01) cron2: lev__: is this cpu bound, as in "while the test runs, O=
penVPN is using 100% of one core"?
(12:45:01) ordex: yap, likely
(12:45:38) lev__: cron2: I haven't looked at CPU usage, just checked iper=
f stats
(12:45:39) cron2: if it's CPU bound, compiler optimization / openssl asse=
mbly / ... would be my guess.  If not, it's more like "something is addin=
g latency, and TCP performance tests tend to be very sensitve to that"
(12:46:16) dazo: yeah, it's not openvpn code ... this is compiler and bui=
ld optimization related
(12:46:16) cron2: it would be interesting to know ("differences in latenc=
y" and "CPU usage while iperf is running")
(12:46:49) cron2: dazo: yes, but my gut feeling is "nothing inside OpenVP=
N can be optimized in a way that makes such a difference".  OpenSSL, yes =
:-)
(12:47:33) cron2: our packet loop is small and doesn't really do much, ex=
cept "call out to SSL library" plus a few if() statements here and there.=
=2E. (on the client)
(12:48:03) cron2: plus driver/socket read()/write(), which do not lend th=
emselves to compiler optimization
(12:48:31) cron2: but anyway... mattock1: what do you say wrt "using MSVC=
 to do release building"?
(12:48:44) dazo: lev__: which openssl library build did you use with your=
 msvc build?
(12:48:45) cron2: we discussed this anyway for the .msi installers
(12:49:21) mattock: well
(12:49:45) mattock: does it help to build just openvpn with msvc, or woul=
d we have to build all the dependencies with msvc as well?
(12:49:55) mattock: also, does openvpn-build/msvc work nowadays?
(12:51:39) lev__: dazo: 1.0.2p built with Visual Studio
(12:51:46) lev__: mattock1: yes it does
(12:52:34) lev__: mattock1: it builds openssl etc, we use it in appveyor
(12:53:09) mattock: ok
(12:53:16) mattock: what about NSI?
(12:53:59) mattock: we're not ready for MSI for 2.4.x, so integrating ope=
nvpn-build/msvc and openvpn-build/windows-nsis may require some surgery
(12:54:43) lev__: mattock1: it just builds openvpn binary and dependencie=
s
(12:55:02) dazo: I'd say we have focus getting 2.4.x out asasp ... so if =
msvc isn't fixed quickly, we build with mingw for this first release and =
improve for the next one
(12:55:11) mattock: I tend to agree
(12:55:32) dazo: we could also do a separate windows update release switc=
hing to msvc .... just increasing the build number instead of version
(12:55:41) mattock: adding some semi-ad-hoc stuff to package build artefa=
cts from msvc build may be doable
(12:55:44) lev__: mattock1: I can look into MSI support, if it could be d=
one with mingw it could surely be done with VS
(12:56:19) lev__: would be nice if someone could verify my performance re=
sults
(12:56:21) cron2: I'd go for "stick to nsis installer for the next 2.4.x =
release, and then see if msi works for the next (or for 2.5)"
(12:56:22) mattock: lev__: rozmansi has MSI installer code for OpenVPN, b=
ut the tap-windows6 installation part requires refactoring
(12:56:24) dazo: lev__: rozmansi and mattock1 has been working on MSI stu=
ff already ... but there's still some missing pieces, I believe
(12:56:40) cron2: having new installers, new build system, new tap driver=
 at the same time sounds like "support effort"
(12:57:07) dazo: yeah, lets take this in a few separate steps=20
(12:57:26) mattock: +1
(12:57:44) rozmansi: @lev__: MSI support was done with Visual Studio then=
 potred to mingw.
(12:57:47) mattock: now, is there any easy way to test if adjusting mingw=
 parameters could produce significant improvements in performance
(12:57:51) lev__: I don't have a strong opinion on installer we use, but =
I care about performance gain provided by VS
(12:57:54) rozmansi: hi everyone
(12:57:57) mattock: hi rozmansi!
(12:58:08) dazo: sorry to wake you up, rozmansi! :-P
(12:58:31) cron2: mattock1: wrt "adjusting mingw parameters", that depend=
s a bit on "is it CPU bound or latency"
(12:58:48) rozmansi: dazo: I really should put those meeting appointments=
 to my calendar. I have missed all September ones. Thanks for bumping me.=

(12:58:57) dazo: ;-)
(13:01:13) mattock: anyways, I'll check how easy/difficult it would be to=
 produce an NSIS installer from the build artefacts of the msvc build
(13:01:44) mattock: NSIS does run on Windows so there would be no need to=
 hop between Linux and Windows during the build
(13:02:03) rozmansi: mattock1: if you put all the binaries in the same fo=
lder layout as produced by openvpn-build and copy them in the right place=
, nsis builder should work fine.
(13:02:16) mattock: if the names match, yeah
(13:02:44) mattock: windows-nsis assumes that it is doing the build itsel=
f, so the NSIS step would probably have to be separated
(13:02:46) rozmansi: btw, doesn't VS build use different SSL library (ssl=
eay)?
(13:03:29) dazo: is ssleay still alive?
(13:03:32) cron2: ssleay sounds like the 0.5 name of openssl
(13:04:09) mattock: yeah
(13:04:34) lev__: rozmansi: it produces libeasy32.dll and ssleay32.dll wh=
ich are openssl
(13:05:07) rozmansi: exactly, that's what I had in mind... File names are=
 different, so this will be a problem for NSIS packager.
(13:05:41) rozmansi: but they're just different files to copy. Nothing fa=
ncy they'd require.
(13:06:16) mattock: yep, it is definitely doable
(13:07:21) mattock: lev: we currently bundle openssl 1.1.0 in our windows=
 installers
(13:07:27) mattock: can msvc build build openssl 1.1.0?
(13:08:54) lev__: mattock1: I think so, just have to set OPENSSL_VERSION =
env var
(13:09:37) lev__: assuming openssl hasn't changed their nmake build scrip=
ts
(13:11:21) mattock: there's one glitch I had when moving from openssl 1.0=
=2E2 to 1.1.0 in windows-nsis, but that might not be present in msvc buil=
ds=20
(13:11:23) mattock: anyways
(13:12:37) mattock: I will take a stab at generating NSIS installer from =
msvc artefacts
(13:12:50) mattock: for the next 2.4.x release
(13:13:53) mattock: so we have two tap-windows6 PRs: https://github.com/O=
penVPN/tap-windows6/pulls
(13:13:55) vpnHelper: Title: Pull Requests =C2=B7 OpenVPN/tap-windows6 =C2=
=B7 GitHub (at github.com)
(13:16:04) mattock: do we need a test tap-windows6 installer of those pri=
or to next 2.4.x?
(13:16:48) dazo: depends on how brave you are ;-)
(13:19:07) mattock: I'm very brave if I can avoid one round of  building =
and signing tap-windows6 :)
(13:19:27) mattock: that said, if we are fine with just attestation signe=
d (=3DWindows 10) test version then its not too bad=20
(13:20:13) mattock: I suspect that even if we have test installers availa=
ble on 1-2 people will actually test them
(13:20:26) mattock: one of them being me :)
(13:20:57) lev__: mattock1: I can surely test it
(13:21:03) mattock: ok good
(13:21:34) mattock: then I shall produce tap-windows6 which includes thos=
e two PRs - or does https://github.com/OpenVPN/tap-windows6/pull/86 requi=
re further work/discussion?
(13:21:36) vpnHelper: Title: constants.h: make driver not halt on suspend=
 by lstipakov =C2=B7 Pull Request #86 =C2=B7 OpenVPN/tap-windows6 =C2=B7 =
GitHub (at github.com)
(13:23:05) lev__: wintun doesn't halt on suspend, so I was thinking maybe=
 tap-windows6 shouldn't too
(13:24:50) mattock: should I read selva's comment "If halt on suspend is =
not needed let's get rid of it." as an ACK?
(13:24:55) mattock: the last comment
(13:25:50) cron2: mattock1: well, let's have the test driver out, and ask=
 Selva explicitly for "can you test and ack"
(13:26:06) mattock: +1
(13:26:23) cron2: the comment is a conditional ACK on the condition on "w=
e agreed that we do not need halt-on-suspend", but I'm confused on whethe=
r we agree :)
(13:26:34) mattock: :)
(13:26:37) mattock: yeah
(13:26:51) mattock: 4 minutes left
(13:27:06) mattock: topic #2 quickly?
(13:27:26) cron2: #2 is easy - "we got distracted by buildbot failures"..=
=2E
(13:27:59) mattock: ok good
(13:28:19) dazo: #3 would be nice to have some discussion around ... --di=
sable-server
(13:28:22) cron2: so, no progress on the vlan patchset itself, and limite=
d progress on the buildbots - we still have arch, fedora-29 and ubuntu-18=
 consitently(!) fail t_client test 1 - for every single run since incepti=
on (ubuntu-18) and for every single run since June 06 (fedora-29 and arch=
), so this is something that needs fixing
(13:28:23) dazo: plaisthos: you around?
(13:29:09) cron2: ordex and I have tried to reproduce on ubuntu 18.04 lts=
 and 19.04, but couldn't, so it's not "just this particular distro" (rece=
nt kernels, whatnot) but also "something else"
(13:30:26) cron2: tincantech has offered access to the arch buildslave, s=
o maybe we can figure out why "TCP + net30" is failing there
(13:30:27) plaisthos: oops completely missed the community meeting sorry =
:(
(13:30:56) plaisthos: yeah
(13:31:01) cron2: plaisthos: well, now you're here :-) - maybe we can qui=
ckly discuss #3
(13:31:04) mattock: plaisthos: you will be mentioned in the summary
(13:31:52) plaisthos: I spend way to long to fix auth-token for disable-s=
erver and found out that even with --disable-server a lot of stuff of ser=
ver is pulled in
(13:31:54) cron2: I have no strong opinion on --disable-server.  Ordex ch=
ecked OpenWRT: they do not(!) build with --disable-server, so "these embe=
dded folks" wouldn't all be impacted
(13:32:18) plaisthos: and apart from my client I don't know of anything t=
hat actually uses disable-server
(13:32:39) cron2: ah, it would break Android!  So we cannot do it!  *duck=
*
(13:32:50) plaisthos: and since we are already short on time etc, support=
ing this feature that basically no one uses seems to be a bit much
(13:33:01) dazo: I also believe the argument of "reduced binary code size=
" is not as relevant now as it was 15 years ago, esp. for embedded device=
s
(13:33:17) plaisthos: and the embedded devices we talk about don't seem t=
o exist
(13:33:19) cron2: mattock1: can you ask on the openvpn-users + openvpn-de=
vel lists?  If nobody answers, kick it out for 2.5...
(13:33:22) ordex: well, few hundred KB makes a difference though
(13:33:37) dazo: is it such a big difference?
(13:33:37) ordex: I build for systems with 4MB of flash :p
(13:33:48) cron2: ordex: do you build with --disable-server?
(13:33:52) ordex: no
(13:33:56) ordex: only --enable-small
(13:33:56) cron2: dazo: ~150kbyte
(13:33:59) plaisthos: in the mac build it is 685k vs 815k
(13:34:09) cron2: ordex: so it doesn't really make enough of a difference=
 :-) - point made!
(13:34:52) mattock: cron2: yep, I will
(13:34:53) dazo: so roughly 15-18% code reduction
(13:35:42) cron2: I'm surprised it's so much difference in size... plaist=
hos: code or data size?
(13:36:17) cron2: quot a few options strings, option-combination warning =
messages and --help output and such will go, though
(13:36:20) cron2: quite
(13:36:25) dazo: the difference plaisthos references is 130kb :-P
(13:36:53) plaisthos: binary size
(13:37:08) plaisthos: as in ls -lh src/openvpn/openvpn
(13:37:10) cron2: plaisthos: "size $binary"...?
(13:37:17) cron2: maybe 100kbyte of it is "debug information"
(13:37:23) dazo: yeah, I think OpenVPN 2.5 is a reasonable release to kic=
k it out .... 2.4 will still be supported for some time forward after the=
 2.5 release ... so users with scarce space can use a reduced 2.4 build; =
and we hope those smaller devices gets more space before the the 2.4 supp=
ort runs out
(13:37:57) mattock: email about --disable-server sent
(13:38:01) dazo: plaisthos: can you try to do a build with --enable-small=
 and strip it .... and compare a build with --enable-small --disable-serv=
er which is also stripped?
(13:39:54) plaisthos: data/text: 634880 12288, stripped binary 673k
(13:40:41) plaisthos: damn the last patch in the series was not disble-se=
rver clean
(13:40:45) plaisthos: *bites into desktop*
(13:41:04) plaisthos: okay again with master
(13:42:16) plaisthos: 524288/12288, stripped binary: 562k
(13:44:10) mattock: 14 minutes overtime
(13:44:13) plaisthos: 630784/12288, stripped binary: 668k
(13:44:37) plaisthos: mattock1: got to run?
(13:44:46) mattock: no, but we don't do overtime :D
(13:45:03) mattock: or try not to
(13:45:55) mattock: I say we end the official part here
(13:45:57) mattock: any objections?
(13:46:00) cron2: mmmh, unix "size" splits this up more nicely into "code=
" and "data" size (so you can see how much of it is "less strings" and "l=
ess code").  but anyway.  Looks like this is not truly worth the contorti=
ons
(13:46:33) cron2: well
(13:46:35) cron2: used to
(13:46:49) cron2: nowadays strings seem to be all in "text"... *scratch h=
ead*
(13:47:10) plaisthos: yeah
(13:47:23) plaisthos: basically text is readonly and data is readwrite
(13:47:27) plaisthos: globals etc
(13:47:41) cron2: yep
(13:48:05) dazo: so roughly 100kb saved with --disable-server .... that d=
oesn't really sound like it's worth our effort and troubles
(13:48:09) ***cron2 needs to feed wife and kid now, so "official end"

--------------BD1D7FC525E9322587781417--

--pfdmtfIcOEYmQ7rgGKBLa9uB0x9GOl6LE--

--RKWPU83etiYAqDu1s2eako73RPcq2cZyS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl2CDIwACgkQKVhNn0CG
RXhkWwgAq9xwCsszgimreK9f6rKSkoG7KQd/iYAjOawXg3GACdXjMBIUytDNdDs4
hLUSUezQYka/ilYVdCdIw6FtR1vwRxGgZlRLJeFDBwv6AXHImlCnLPwY498DWACv
AJxvECo/usnE8Sstei9VC7KUnqZZO4Y2F6Ux/2tJPxLhDc5XDxmhmrJUfdprBgfV
zQj+TwK98FQAoGCeT9A/EzBgdFifqSwhtnhrLDN0wrre7DBIh1ac9TU+F/2mi1YY
3DyL7IYc0iem3fAd5O+Yqbc7bqItBz/k55Dj+CEzeU6Cz3fAfFMFj3cZoje6Gu2x
CfhcsJmYGDHwAA7/4duIIDFczA22gg==
=Q3RB
-----END PGP SIGNATURE-----

--RKWPU83etiYAqDu1s2eako73RPcq2cZyS--

