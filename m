From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <e3e0bf19-c810-002a-a4fc-1e7d6b4c798a@...515...>
Message-ID: <6c5dfe4a-6350-dcc4-eced-4279dfbd7af7@...515...>
Date: Thu, 13 Aug 2020 22:52:30 +0300
MIME-Version: 1.0
In-Reply-To: <e3e0bf19-c810-002a-a4fc-1e7d6b4c798a@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mfoZWVJj0rETbKSj1sZ0VwowcI1M5lwt2"
Subject: [Openvpn-devel] Summary of the community meeting (13th August 2020)
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
--mfoZWVJj0rETbKSj1sZ0VwowcI1M5lwt2
Content-Type: multipart/mixed; boundary="1BbQ5h9yzOTirGcqPYg2YQAA6t2rfhv07"

--1BbQ5h9yzOTirGcqPYg2YQAA6t2rfhv07
Content-Type: multipart/mixed;
 boundary="------------9E863255EACCB9C60FCD2BD6"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------9E863255EACCB9C60FCD2BD6
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thu 13th August 2020
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-08-13>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock and wiscii participated in this meeting.

---

Talked about OpenVPN 2.5-beta1.

Mattock is inching the release forward. Debian and Ubuntu packages have
already been built and they're in the apt repos.

Agreed that the pkcs11-helper Fedora patch should go in into the Windows
installers:

<https://github.com/OpenVPN/openvpn-build/pull/172>
<https://src.fedoraproject.org/rpms/pkcs11-helper/raw/master/f/pkcs11-helpe=
r-rfc7512.patch>

Mattock will make a static copy of it (to avoid refactoring openvpn-build).

Tentative OpenVPN 2.5-beta1 release time (for tarballs and Windows
installers) is tomorrow (Friday) around lunch time.

---

Noted that we now have Ubuntu 20.04 packages of OpenVPN 2.5-beta1
available. Also noted that we will no longer provide OpenVPN packages
for Ubuntu 14.04 and Debian 8 due to OpenSSL incompatibility. The former
is EOL and the latter does not have mainstream support anymore.

---

Talked about buildslaves. Noted that the Ubuntu 14.04 buildslave was
taken out (EOL). Also agreed that we can drop the CentOS 6 buildslave as
its EOL is only a few months away and supporting it in Buildbot would be
quite hard for a number of reasons.

Agreed that we should (soon) start building three branches in Buildbot:

- release/2.4 (present already)
- release/2.5 (not present yet)
- master (present already)

Agreed to drop "release/2.4" builds once 2.4 is "unsupported", which is
about 18 months from the time of 2.5.0 release. If there are major
issues in keeping "release/2.4" builds going then we can reconsider that
choice.

--

Full chatlog attached

--------------9E863255EACCB9C60FCD2BD6
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-08-13.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-08-13.txt"

(21:00:22) cron2: yay, meeting
(21:02:30) mattock: hello!
(21:04:26) wiscii [~tct@...1336.../slypknot] =C3=A8 entrato nella stanz=
a.
(21:05:56) mattock: anyone else?
(21:06:03) dazo: hey!
(21:06:06) cron2: ho!
(21:06:27) mattock: hi!
(21:06:42) wiscii: hi
(21:07:41) mattock: let me give a quick update on 2.5-beta1 release statu=
s
(21:07:49) mattock: so, I'm inching the release forward
(21:07:49) cron2: wohoo, 2.5!
(21:08:23) mattock: "inching" because $child is home because she has had =
running nose since last Thursday -> no kindergarten -> childcare shifts -=
> ~3 hours of effective working time per day
(21:08:34) mattock: Debian / Ubuntu packages are done and in the repo
(21:08:47) mattock: Windows installers are work in progress
(21:08:55) mattock: but the process was tested earlier, so it "should wor=
k"
(21:09:03) mattock: meaning "release tomorrow before lunch" is reasonable=

(21:11:01) dazo: I can spin up a new beta RPM/YUM/DNF repo tonight/tomorr=
ow for beta releases
(21:11:42) mattock: oh, minor update: we also have Ubuntu 20.04 packages =
now which wiscii kindly tested
(21:12:04) wiscii: also works on 2010 groovy gorilla !
(21:13:02) cron2: sounds good
(21:13:36) mattock: \o/
(21:14:26) mattock: one related note
(21:14:38) mattock: I dropped Debian 8 and Ubuntu 14.04 packages (OpenSSL=
 issues)
(21:15:00) cron2: is debian 8 still supported?
(21:15:09) mattock: to some degree possibly
(21:15:39) mattock: but if the target machine does not have openssl 1.0.2=
 (unlikely) then having an openvpn package for would possibly be pointles=
s
(21:15:41) cron2: The Debian Long Term Support (LTS) Team hereby announce=
s that Debian 8 jessie support has reached its end-of-life on June 30, 20=
20, five years after its initial release on April 26, 2015.
(21:15:42) mattock: we're at debian 10 now
(21:15:52) wiscii: my deb8 VM won't work right under vbox so i hoofed it =
out
(21:16:04) wiscii: yep deb10 is good
(21:17:03) dazo: Debian 8 is in extended LTS .... which is a commercial o=
ffering only
(21:17:06) dazo: https://wiki.debian.org/LTS/Extended
(21:17:07) vpnHelper: Title: LTS/Extended - Debian Wiki (at wiki.debian.o=
rg)
(21:17:30) mattock: yep I saw something along those lines
(21:17:45) dazo: I'd say we can drop Debian 8 ... The standard EOL was re=
ached in June
(21:17:53) mattock: +1
(21:18:11) mattock: and people who really need openvpn on debian 8 can st=
ill compile it
(21:18:20) mattock: it should not be too horrible to do
(21:18:24) mattock: though I could be wrong :)
(21:19:05) dazo: Ubuntu 16.04 is supported, until April next year; I'd sa=
y that can be on 2.4 ... 14.04 is EOL
(21:19:41) dazo: For RHEL, we have put EL-6 on the 2.4 only; 2.5 will be =
for EL-7 and EL-8
(21:20:01) dazo: (EL-6 goes EOL in November this year)
(21:21:05) dazo: mattock: well, for Debian 8 ... it might be challenging =
if the openssl library is too old
(21:21:26) mattock: if it is anything like ubuntu 14.04 then I agree :D
(21:21:28) mattock: such a pita
(21:21:45) mattock: while we're discussing support
(21:21:51) cron2: 2.4 is not a bad release - still maintained, and secure=
=2E
(21:21:54) mattock: what about CentOS 6 + buildslave
(21:22:33) cron2: for 2.5, it seems to be non-useful
(21:22:38) mattock: yep
(21:23:10) dazo: yeah, I'd say we can wind CentOS 6 down with 2.5 release=
d
(21:23:16) cron2: dazo: are there 1.1.1 openssl packages in some "experim=
ental repo"?
(21:23:16) mattock: the problem with it is:
(21:23:16) mattock: - getting openssl 1.0.2 or 1.1.1 to compile is PITA
(21:23:16) mattock: - getting buildbot to just build 2.4 on it is a PITA
(21:23:27) dazo: cron2: nope, not afaik
(21:24:12) dazo: mattock: If we need to tackle CentOS-6 builds for 2.4, I=
 have the fedora build infrastructure up and running
(21:24:42) dazo: but it won't be automated with buildbot or so ... but fo=
r security/bug releases in 2.4, I can make sure we have what's needed
(21:25:41) mattock: our buildbot config is full of exceptions so I'd like=
 to limit new exceptions to the ones we absolutely must have
(21:25:48) dazo: I mean, EL-6 is only relevant for the next 3 months, it =
goes EOL at that point
(21:25:56) mattock: so
(21:26:02) dazo: drop it :)
(21:26:13) mattock: I sure can :)
(21:26:31) mattock: that saves me several hours of work
(21:26:38) dazo: good :)
(21:26:39) mattock: plus lots of pain=20
(21:26:40) mattock: :P
(21:27:26) mattock: ok, so what about building 2.4/2.5/master in buildbot=
?
(21:27:55) mattock: 2.5 and master, yes
(21:27:58) dazo: How is the setup in regards to the release/2.? branches?=

(21:28:11) dazo: do we have anything for release/2.3 ?
(21:28:14) mattock: we build release/2.4 and master now
(21:28:17) mattock: no, we don't
(21:28:29) mattock: we used to just build the "master", then we (I) added=
 "release/2.4" to the mix
(21:28:47) mattock: it is trivial to add new branches to monitor
(21:28:48) dazo: ahh, okay ... lets keep what works, and that's it
(21:29:56) dazo: so adding release/2.5 ... and then we're good to go, bas=
ically?
(21:30:04) mattock: yeah
(21:30:12) mattock: then we just decide when to drop release/2.4 from bui=
ldbot
(21:30:16) plai_webclient [59f77e38@...2571...] =C3=A8 entrato=
 nella stanza.
(21:30:22) wiscii: (FYI: openssl on debian 8 is too old to build master a=
nd there is no replacement unless you try it yourself)
(21:30:36) mattock: "when it starts creating issues" or "6 months after 2=
=2E5.0" or so
(21:30:38) wiscii: build it yourself*
(21:30:45) dazo: yeah, I'd say we drop it when we consider it unsupported=
 ... according to https://community.openvpn.net/openvpn/wiki/SupportedVer=
sions
(21:33:17) mattock: I'm fine with that as long as "release/2.4" building =
does not become too problematic for whatever reason :)
(21:33:25) dazo: agreed
(21:33:43) dazo: but we should have it as long as we have it labelled as =
supported too
(21:34:06) dazo: so when 2.4 goes unsupported, we don't need to worry abo=
ut release/2.4
(21:34:14) mattock: +1
(21:34:38) dazo: which effectively means minimum 18 months after 2.5.0 is=
 released
(21:35:38) dazo: (oh, I see it could be interpreted as minimum 12 months =
=2E.. well, that's a different discussion)
(21:35:40) mattock: does not sound too bad, 18 months goes fast
(21:35:47) dazo: agreed
(21:36:26) mattock: shall we move on to "what is our stance on null/no en=
cryption"?
(21:36:35) dazo: sure
(21:36:49) cron2: without syzzer and plaisthos this is a bit hard to find=
 "our" stance
(21:37:12) cron2: the question about "what new buildbots do we need/want"=
 is also open :)
(21:37:40) mattock: yep that one
(21:38:06) cron2: I'll see that I can add a FreeBSD 12 buildslave - which=
 is "just doing".  The client-side of the t_server tests is run off a fbs=
d12 box anyway, so no surprises expected
(21:38:07) mattock: Ubuntu 20.04 for sure
(21:38:08) dazo: true ... I see that it is not a good thing from a securi=
ty point of view .... but from a debug/testing point of view it can make =
things simpler when inspecting packets on the wire ... so it's kinda a qu=
estion how far down we want to go on the "debug tool" road for openvpn
(21:38:23) mattock: CentOS 8 (we don't have one I believe)
(21:39:21) dazo: mattock: what kind of "slave backends" does buildbot sup=
port?  ... can it do more than just buildbot slaves?
(21:39:38) dazo: (like Jenkins have possibility to use EC2)
(21:39:58) mattock: are you speaking of slaves that are created on-demand=
?
(21:40:06) dazo: yeah
(21:40:15) mattock: there is "latent buildslave" support
(21:40:20) cron2: I think we need to postpone the cipher null discussion =
:-/  (I am not overly focused as $kid is demanding attention, and syzzer =
and plaisthos are missing)
(21:40:24) dazo: or ... other types of infrastructure, like Fedora Koji/C=
opr ... etc
(21:40:24) mattock: but in any case I'd upgrade the buildmaster first
(21:41:05) mattock: and check what is available out of the box
(21:41:22) mattock: that said, what is not present out of the box can be =
still implemented - buildbot config is just Python code
(21:41:29) mattock: there is not "server configuration" like in Jenkins
(21:41:50) dazo: before upgrading buildmaster ... perhaps also look at ot=
her alternatives too, which gives more automation and less maintenance bu=
t the same kind of "output" we're looking for
(21:42:30) mattock: hmm, yeah, as long as the alternative is not Jenkins =
lol :)
(21:42:48) dazo: well, it's nice that buildbot is extensible .... but som=
ebody then has to develop it and maintain it ... so if the same features =
exists elsewhere already, why reinvent the wheel?
(21:42:56) mattock: I mean, I do like the fact that with Buildbot you jus=
t have a Python file you manage and you have all the power of Python to m=
ake it to your liking
(21:43:23) mattock: I'm not sure what features we want so I don't know if=
 we need to reinvent any wheels
(21:43:30) mattock: practical examples would help figure that out
(21:43:52) dazo: yeah, I can understand that ... at the same time, we're =
quite happy with Jenkins in Core team for the OpenVPN 3 projects ... as l=
ong as nobody messes with the server setup :-P
(21:44:22) mattock: I bet the Jenkins setup does not have as many excepti=
ons as our buildbot setup
(21:44:23) mattock: :P
(21:44:49) dazo: yeah ... which sounds like we're adding more pain than w=
e should ;-)
(21:44:50) mattock: anyways, there are a gazillion of CI systems availabl=
e
(21:44:54) dazo: it is
(21:45:06) dazo: so, soon after 2.5, perhaps do an evaluation there?
(21:45:25) mattock: much of the complexity arises for the wide range of o=
perating systems we build on
(21:45:56) mattock: also every "policy" we set ("build branch <n> only on=
 platforms <x>, <y> and <z>") increases complexity
(21:46:20) dazo: yupp
(21:46:39) mattock: the maintenance effort of buildbot configs (which is =
not too bad)  is directly related to the complexity of our choices/needs
(21:47:44) mattock: so we should definitely check if we can cut down some=
 of it
(21:48:19) cron2: as a buildslave operator, buildbot is really painless -=
 once set up, it mostly runs for itself and needs no tending
(21:48:23) mattock: but in my opinion, buildbot is quite low maintanance =
- definitely less maintenance than Jenkins (which I've unfortunately also=
 had to maintain to some degree)
(21:48:45) mattock: Jenkins may look quite nice for somebody using it, fo=
r an admin it is one of the worst software ever built
(21:49:32) dazo: fair enough ... I've only seen the develop-side from bot=
h of them ... and from that perspective, I do prefer Jenkins nowadays :)
(21:49:37) mattock: we've never restored any EC2 instances using our snap=
shot backup software, except Jenkins
(21:50:00) mattock: it has a tendency to explode from under you
(21:50:04) mattock: anyways
(21:50:21) mattock: did we cover all the buildbot topics?
(21:50:55) plai_webclient ha abbandonato la stanza (quit: Remote host clo=
sed the connection).
(21:50:56) cron2: yeah
(21:52:34) mattock: but in general, Buildbot is a framework for building =
your own CI system, so it has less out of the box support for fancy stuff=
 (which Jenkins has)
(21:53:46) mattock: you may have to do a bit more work yourself with Buil=
dbot - depending on what you're trying to achieve - but on the other hand=
 it is fully in your control (being just Python code)
(21:54:05) mattock: now, any other extra topics? 6 minutes left?
(21:54:07) cron2: what language is Jenkins in?
(21:54:12) mattock: Java
(21:54:26) mattock: unfortunately the "enterprise grade" kind of Java
(21:54:50) mattock: there are rather horrible omissions all over the plac=
e (again, primarily from admin perspective)
(21:55:05) mattock: automating (as in: infrastructure as code) is next to=
 impossible
(21:55:38) mattock: unfortunately _not_ the enterprise grade java I meant=
 to say
(21:55:44) cron2: anything in a reasonable language (aka "perl")? :-)
(21:56:12) mattock: I'm sure there is a PerlCI
(21:56:13) mattock: :)
(21:56:18) cron2: well, in network land, "carrier grade" is a synonym for=
 "what, that bad?" :-) - so "enterprise grade" could mean anything...
(21:56:20) mattock: I mean, we could review our options
(21:56:26) mattock: I know
(21:56:30) mattock: carrier grade also
(21:56:44) cron2: I'm not particularily keen on re-doing my slave zoo
(21:57:05) mattock: yeah, me neither, nor resolving the problems that hav=
e been solved already
(21:57:16) mattock: unless there is a really good reason for it
(21:57:45) mattock: the main weak point in buildbot is the (current) web =
interface
(21:57:49) mattock: it is not very nice
(21:57:53) mattock: but we're running an old version
(21:58:06) mattock: dazo's complaints about the webui are legit
(21:58:14) cron2: let's upgrade this and see if the new version is shiny =
:)
(21:58:18) mattock: I agree
(21:58:30) mattock: I will also try to get krzee involved there
(21:58:33) mattock: so that it's not just me
(21:59:06) mattock: anyhow, are we ok for today?
(21:59:11) cron2: yeup
(21:59:18) cron2: I just closed a few patches in patchwork
(21:59:28) mattock: oh one more thing
(21:59:41) mattock: I cannot remember anymore what we decided to do about=
 the pkcs11 fedora patch thing
(21:59:50) mattock: that could go to 2.5.0 or so
(21:59:59) mattock: or do we want it in 2.5-beta1
(22:00:00) mattock: or not at all
(22:00:10) cron2: I think we planned to include it, as it fixes a real bu=
g.  Or so.
(22:00:13) dazo: wasn't that a pkcs11-helper patch?  Not an openvpn patch=
?
(22:00:25) mattock: yeah, but it will go into the windows installers
(22:00:26) dazo: or you mean go into the windows builds?
(22:00:27) cron2: dazo: it is, so it is relevant for our windows installe=
r
(22:00:28) dazo: ahh
(22:00:31) dazo: right
(22:00:50) mattock: there is still time to get it in to 2.5-beta1
(22:00:56) mattock: I have not really build the installers yet
(22:01:01) dazo: I'd say we should pull it in
(22:01:22) mattock: let me find the url...
(22:01:29) cron2: what installers will we get?  .msi only?
(22:01:51) dazo: There's quite some fedora users install pkcs11-helper fo=
r various reasons .... and some of them would have complained if it broke=
 things
(22:01:56) mattock: https://github.com/OpenVPN/openvpn-build/pull/172
(22:01:58) vpnHelper: Title: replace rfc7512 URI patch with latest versio=
n in Fedora by becm =C2=B7 Pull Request #172 =C2=B7 OpenVPN/openvpn-build=
 =C2=B7 GitHub (at github.com)
(22:02:38) mattock: "As a intermediate step (and to match the result of t=
he 2020-04-23 meeting) we could for now just replace the local copy with =
the pristine Fedora patch (git header included). "
(22:03:00) mattock: the patch being this: https://src.fedoraproject.org/r=
pms/pkcs11-helper/raw/master/f/pkcs11-helper-rfc7512.patch
(22:03:06) mattock: nobody opposed that
(22:03:07) mattock: so
(22:03:18) mattock: I shall update the current patch with that one
(22:03:35) mattock: if it builds ok on Windows then it will go in
(22:04:10) dazo: makes sense
(22:04:28) mattock: I mean builds fine on mingw :)
(22:06:00) mattock: ok I'll write the summary

--------------9E863255EACCB9C60FCD2BD6--

--1BbQ5h9yzOTirGcqPYg2YQAA6t2rfhv07--

--mfoZWVJj0rETbKSj1sZ0VwowcI1M5lwt2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl81mf4ACgkQKVhNn0CG
RXhF/QgAnUuXAf7kLjNBT8cad5pf4HTkpyD+S+B3omrLi84wdZFjBrS3zqm1PdJi
pLd+ayzoTyS1jZnEx85ru97CuRgMHvSjmegZIP65NRz8R78HyuXKzkY+5foR+vOB
faCHSE77t/rEaphPMxKb8tOUt+3EtVQqkKm43jpc/nqiRRs13uIc3n3FMDLWKuba
pxAtYHql+CYCngfkQTncad1ze9za+fjU88yW/FPwa5gi8fDYn9whRM3yN/cQODMb
VqYVpzWYDLeMS0HWuhUImH68vMnDmzbuk2uPFERjHbygnxgUL8bMetK5AgHe/8hF
gO28H356IS4AzYhkPcdABj+BhuAZzQ==
=LMT8
-----END PGP SIGNATURE-----

--mfoZWVJj0rETbKSj1sZ0VwowcI1M5lwt2--

