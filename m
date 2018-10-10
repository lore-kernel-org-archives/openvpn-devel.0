From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <c7533780-f74e-d6fa-9218-1a681255333c@...515...>
Message-ID: <f890db02-898d-e4d7-3c25-5a0f08375005@...515...>
Date: Wed, 10 Oct 2018 14:20:57 +0300
MIME-Version: 1.0
In-Reply-To: <c7533780-f74e-d6fa-9218-1a681255333c@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="d98cG2qCsRAi5NKOaybru0UorovHEz1Xg"
Subject: [Openvpn-devel] Summary of the community meeting (Wed,
 10th Oct 2018)
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
--d98cG2qCsRAi5NKOaybru0UorovHEz1Xg
Content-Type: multipart/mixed; boundary="xsb2T4NBArWnE7DhAOFwniyhtgFLTbUMj";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <f890db02-898d-e4d7-3c25-5a0f08375005@...515...>
Subject: Summary of the community meeting (Wed, 10th Oct 2018)
References: <c7533780-f74e-d6fa-9218-1a681255333c@...515...>
In-Reply-To: <c7533780-f74e-d6fa-9218-1a681255333c@...515...>

--xsb2T4NBArWnE7DhAOFwniyhtgFLTbUMj
Content-Type: multipart/mixed;
 boundary="------------B484861A2F3AA2B74835F206"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------B484861A2F3AA2B74835F206
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 10th October 2018
Time: 11:30 CEST (9:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2018-10-10>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock, ordex, plaisthos, rozmansi and syzzer participated
in this meeting.

--

Discussed tap-windows6 release and HLK testing. We have an experienced
Windows kernel developer fixing the remaining issues. Mattock asked the
WHQL/HLK testing company to put their testing on hold for the time being.

--

Discussed dropping OpenSSL 1.0.1 support in OpenVPN. It was agreed that
it makes sense. We also made our support policies regarding RedHat more
clear:

https://community.openvpn.net/openvpn/wiki/SupportedVersions

--

Discussed MSI installer for OpenVPN and tap-windows6 that rozmansi has
been working on:

https://community.openvpn.net/openvpn/wiki/OpenvpnMSIInstaller

Rozmansi is currently working on Makefiles for the tools and DLLs that
the MSI installer will make use of.

--

Full chatlog attached.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



--------------B484861A2F3AA2B74835F206
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2018-10-10.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2018-10-10.txt"

(12:32:15) cron2: yay
(12:32:15) mattock: hi
(12:33:43) syzzer: 'lo
(12:34:18) mattock: you guys have been busy
(12:34:39) mattock: so, any particular topics?
(12:34:55) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
8-10-10
(12:34:56) vpnHelper: Title: Topics-2018-10-10 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:34:57) cron2: RadixWeb
(12:35:04) mattock: that is quickly covered
(12:35:17) syzzer: re 2.5, I wanted to propose dropping support for opens=
sl 1.0.1
(12:35:19) cron2: you should send them a "please do not spend more time".=
=2E.
(12:35:23) mattock: cron2: I did
(12:35:32) cron2: oh, good.  Because I saw a mail this morning...
(12:35:45) mattock: yeah, their manager was having private discussion wit=
h me
(12:35:55) mattock: I will respond to Pratik as well
(12:37:15) mattock: sent
(12:37:30) dazo: syzzer: that's not gonna fly well, dropping 1.0.1 ... th=
en we lock Debian 9 and RHEL7 and older to OpenVPN 2.4
(12:38:12) mattock: or be forced to maintain more recent openssl in our o=
wn apt/yum repos
(12:38:18) mattock: which is not something we should do lightly
(12:38:39) syzzer: dazo: debian 9 is on 1.1.0
(12:38:39) cron2: mattock1: ok, RadixWeb sorted out.  I was just wonderin=
g.
(12:39:15) dazo: syzzer: nope ... https://packages.debian.org/jessie/open=
ssl
(12:39:20) vpnHelper: Title: Debian -- Details of package openssl in jess=
ie (at packages.debian.org)
(12:39:26) syzzer: jessie in 8 :)
(12:39:30) dazo: meh
(12:39:40) syzzer: and 8 is going EOL in june 2020, which sounds reasonab=
le to stick to 2.4
(12:39:41) cron2: dazo: what is RHEL's stance on openssl 1.1?
(12:40:05) cron2: (I wonder, since the official packages will stay at 2.4=
 anyway, getting 2.5 into "new-RHEL which also has openssl 1.1" should be=
 fine, no?)
(12:40:06) mattock: dazo: Debian 9 (=3Dmy laptop): 1.1.0f-3+deb9u2
(12:40:08) dazo: I just presume that's going into RHEL-8
(12:40:22) dazo: yeah, I mixed debian release names and release numbers .=
=2E..
(12:40:27) dazo: those always confused e
(12:40:31) dazo: *me
(12:40:50) mattock: debian 9 both 1.0.2 and 1.1 openssl available as stan=
dard packages
(12:40:57) ***ordex is here
(12:41:00) mattock: hi ordex!
(12:41:03) ***ordex was confused about departing time
(12:41:04) cron2: sitting in the plain?
(12:41:05) ordex: hi!
(12:41:09) ordex: not yet !
(12:41:31) syzzer: for debian 8 (jessie) 1.0.2 is available in jessie-bac=
kports
(12:41:32) dazo: RHEL7 goes EOL 2024
(12:41:45) syzzer: doesn't RHEL have something like -backports too?
(12:42:00) dazo: aah ... RHEL7 is 1.0.2
(12:42:30) dazo: RHEL6 is 1.0.1, which goes EOL 2020
(12:42:30) cron2: syzzer: you want to drop 1.0.1, but keep 1.0.2?
(12:42:37) syzzer: cron2: yes
(12:42:43) dazo: okay, I'm fine with that
(12:42:46) cron2: ok (just to make it explicit)
(12:42:49) syzzer: 1.0.1 has not been supported by the openssl team for a=
 long time
(12:43:26) dazo: for non-enterprise distros, that's an important detail
(12:44:15) syzzer: I know, but if you're staying with old enterprise open=
ssl, you can also stay with old enterprise openvpn, right/
(12:44:37) dazo: Yeah, I'm not concerned about RHEL6
(12:45:02) mattock: \o/
(12:45:06) mattock: agreement? :)
(12:45:27) dazo: Yes, openssl-1.0.2 can be the oldest one for openvpn-2.5=

(12:45:30) syzzer: I think so :0
(12:45:34) ordex: :D
(12:45:40) syzzer: ok, I'll send a patch later today
(12:45:54) mattock: sounds good
(12:46:27) dazo: but it means we'll need to support openvpn 2.4 until at =
least end of November 2020 :)
(12:46:43) mattock: at what level of support?
(12:46:48) plaisthos: hey, I did not expect a meeting today and will be g=
one in 20 minutes
(12:46:49) mattock: source-only?
(12:46:59) mattock: hi plaisthos!
(12:46:59) dazo: mattock1: security and bug fixes
(12:47:05) dazo: mattock1: nope, full release
(12:47:31) dazo: it's roughly two more years ... and we still haven't rel=
eased 2.5
(12:47:41) mattock: that is probably reasonable
(12:48:00) syzzer: we'll likely do that anyway, yes
(12:48:23) plaisthos: dazo: is ossl 1.1.0 available via the addon repos f=
or RHEL7?
(12:48:24) syzzer: though I think source-only could also suffice
(12:48:32) dazo: plaisthos: nope
(12:48:54) plaisthos: :(
(12:48:59) ordex: btw if a distro outlives an openvpn stable release...th=
ey can also backport patche son their own for those few more months...we =
are not really accountable for that
(12:49:21) syzzer: what ordex says - and the packages use our source rele=
ases anyway
(12:49:25) plaisthos: and they don't import new 2.4 releases anyway
(12:49:27) syzzer: *packagers
(12:49:45) plaisthos: so just have security fixes for those distros and i=
n our 2.4 should be enough
(12:50:07) plaisthos: since more isn't picked up by the distros and users=
 who compile themselves will use rather 2.5=20
(12:50:33) dazo: this is basically going against what we've decided earli=
er ... that the oldest distro we support is RHEL6, which we move to RHEL7=
 with v2.5 ... so as long as that distro is officially supported, we full=
y support openvpn
(12:50:50) plaisthos: hm okay
(12:51:00) syzzer: dazo: but that doesn't mean binary releases, right?
(12:51:05) syzzer: just source releases is fine
(12:51:12) dazo: tarball releases
(12:51:17) dazo: that's what the distros build on
(12:51:25) syzzer: exactly :)
(12:51:29) mattock: so source-only
(12:51:49) syzzer: I was trying to get mattock of the hook for having to =
do nsis-windows releases for two more years :p
(12:51:56) mattock: well yes
(12:52:05) mattock: that was my worry
(12:52:11) mattock: plus debian packages
(12:52:19) dazo: I interpreted source-only as git-tree only ... https://c=
ommunity.openvpn.net/openvpn/wiki/SupportedVersions but yeah "old stable"=
 is what v2.4 goes into
(12:52:20) vpnHelper: Title: SupportedVersions =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:52:38) syzzer: ok, cool, agreement again :)
(12:52:53) cron2: doing a tarball is not that much work
(12:53:01) dazo: nah, I'm not too happy about old-stable for RHEL6 to be =
honest
(12:53:24) dazo: "Full stable support" means: "Full security and bug fix =
support "
(12:53:35) dazo: "Old stable support" means: " Security and critical bug =
fix support "
(12:53:37) dazo: that's a difference
(12:54:39) mattock: but these support levels are for openvpn itself, not =
for any particular distro
(12:55:06) dazo: Full support tarball/source only release is fine
(12:56:10) syzzer: hm, but then we're inventing yet another release type.=
=2E.
(12:56:23) syzzer: why wouldn't old stable be good enough for RHEL6 ?
(12:56:27) syzzer: that stuff in ancient
(12:56:34) dazo: well, the option is to drop 1.0.1 support when RHEL6 is =
EOL
(12:56:35) mattock: ok we actually do drop windows installers in oldstabl=
e
(12:56:49) dazo: syzzer: it is widely deployed still
(12:56:54) syzzer: so?
(12:57:07) dazo: and I do know many uses openvpn on it as well ... and th=
ere's been questions about tls-crypt-v2
(12:57:21) syzzer: old stuff should be fine while is has security fixes a=
nd critical bugs fixed, right?
(12:57:52) ordex: i think so
(12:58:15) dazo: It goes really against what we decided on earlier in reg=
ards to official distro support and OpenVPN
(12:58:16) syzzer: this use case of "I want ancient OS with bleeding edge=
 openvpn" is just putting the burden on us
(12:59:16) syzzer: no?  support does not mean "always get the latest grea=
test", it means "you get security and bug fixes"
(12:59:19) dazo: Okay, either we support RHEL6 as a fully supported distr=
o or I'll retract my support to dropping 1.0.1
(12:59:45) ***ordex has to go now - don't fight too much. looking forward=
 to reading the backlog!
(13:00:24) cron2: dazo: what do you expect us to do, exactly, to "support=
" RHEL6?  Maybe we are in agreement but do not know it
(13:00:44) syzzer: what cron2 says :)
(13:00:58) mattock: also, we don't state that RedHat 6 is the oldest supp=
orted distro on https://community.openvpn.net/openvpn/wiki/SupportedVersi=
ons
(13:01:00) vpnHelper: Title: SupportedVersions =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(13:01:01) mattock: we should
(13:01:31) mattock: also, the "Full stable" and "Old stable" phases are n=
ot related to any particular OS, at least not clearly
(13:01:38) dazo: agreed ... but this was discussed last time when we move=
d to 1.0.1 as the oldest ssl release
(13:01:44) mattock: afaics they're tied to OpenVPN releases
(13:02:03) dazo: Fully supported openvpn 2.4 releases with all bug fixes =
is fine on RHEL-6
(13:02:56) syzzer: So we turn 'old stable' into 'Full security and bug fi=
x support', basically?
(13:03:06) cron2: so that would mean "all bugs that are found in master i=
n 2020 will have to be applied to release/2.5 and release/2.4"?
(13:03:08) dazo: yes
(13:03:12) syzzer: I can live with that, I don't really know what 'critic=
al bug fix support' means anyway :p
(13:03:49) cron2: there's "this message is lacking a comma" bugfixes, and=
 "openvpn will core dump is <this> happens" bugs
(13:04:28) dazo: because we have had a notion all back to the 2.2 release=
, where we had RHEL-4 support as the oldest, 2.3 moved to RHEL-5 and 2.4 =
moved to RHEL-6 ... but it has received full support during the distro li=
fetime ... the reason for RHEL defining the oldest distro release, is as =
it provided the oldest set of (distro) supported libraries and dependenci=
es
(13:06:27) cron2: we
(13:06:36) mattock: somebody explain to me how our RHEL support policy ti=
es into what OpenVPN versions we support, and at what level?
(13:06:44) mattock: it is not clear from our documentation above
(13:06:58) mattock: and we should make it so
(13:07:11) cron2: we're not going to merge anything that *breaks* RHEL-6,=
 it's more about "do they(!) really care about receiving all bugfixes" - =
they're not upgrading to newer 2.4.x versions, just backporting security =
fixes, no?
(13:07:53) dazo: mattock1: around the 2.2 release, it was actually a requ=
irement from James ... and we got acceptance to drop the RHEL-4 support
(13:09:56) mattock: cron2: RHEL6 itself is not upgrading to 2.4
(13:10:05) mattock: so this is about users being able to use 2.4 on RHEL6=

(13:10:05) dazo: it is on 2.4 already
(13:10:11) mattock: really?
(13:10:12) ***cron2 is confused
(13:10:16) mattock: I withdraw my point
(13:10:31) dazo: mattock1: I'm currently the package maintainer for Fedor=
a and Fedora EPEL
(13:10:57) mattock: dazo: in which repositories is openvpn available when=
 one is using RHEL6?
(13:11:02) mattock: EPEL only?
(13:11:21) dazo: yes
(13:11:23) rozmansi [d5fa16a0@...2315.../web/freenode/ip.213.250.22.160] =C3=
=A8 entrato nella stanza.
(13:11:48) mattock: and what is the relation of EPEL with the core reposi=
tories?
(13:12:05) dazo: But it might be it gets added to RHEL-8 again, that I do=
n't know yet ... all I know is that RH has deployed lots of OpenVPN stuff=
 internally since the RHEL-6 release (where it got removed)
(13:12:07) mattock: isn't EPEL stuff considered "unstable" compared to th=
e core repository packages?
(13:12:07) rozmansi: hi
(13:12:14) mattock: hi rozmansi!
(13:12:24) dazo: EPEL is stable community releases
(13:12:50) mattock: are EPEL packages supported by RedHat?
(13:12:56) dazo: By community
(13:13:09) mattock: ok
(13:13:40) dazo: but there is a high expectation of stability to EPEL pac=
kages .... people got angry with me when I moved to 2.4 from 2.3, because=
 of the option parser being much more picky
(13:14:06) mattock: I'm sure, especially because EPEL is the only (reason=
able) place to get OpenVPN packages from
(13:15:00) syzzer: dazo: but that only vouches to keep EPEL6 (or whatever=
 it's called) at 2.4, right?
(13:15:36) syzzer: and I still don't get what you are afraid for when 2.4=
 would become "old stable" before 2020
(13:16:11) dazo: Because, "old stable" support per our current definition=
 does not provide anything else than critical + security fixes
(13:16:24) dazo: that's too limited for a fully supported stable distro
(13:16:31) syzzer: how so?
(13:16:51) syzzer: does redhat backport more than critical or security bu=
g fixes to their own packages/
(13:16:56) dazo: because a fully supported distro do get minor bug fixes =
as well
(13:17:13) dazo: yes, on fully supported packages, they do
(13:17:52) mattock: do we do "long term compatibility changes" on oldstab=
le?
(13:18:00) cron2: no
(13:18:11) cron2: 2.4 gets bugfixes + long-term compatibility
(13:18:21) cron2: 2.3 gets bugfixes for "severe" bugs
(13:18:45) cron2: but not something like "this combination of options doe=
s not work on FreeBSD" (--dev tap --topology subnet, for example)
(13:19:12) dazo: RHEL 6 is currently in "Maintenance Support 2 phase" ...=
=2E "During the Maintenance Support 2 Phase, Critical impact Security Adv=
isories (RHSAs) and selected Urgent Priority Bug Fix Advisories (RHBAs) m=
ay be released as they become available. Other errata advisories may be d=
elivered as appropriate.[...]New functionality and new hardware enablemen=
t are not planned for availability in the Maintenance Support 2 Phase. Mi=
nor releases with=20
(13:19:12) dazo: updated installation images may be made available in thi=
s Phase."
(13:19:19) dazo: https://access.redhat.com/support/policy/updates/errata/=

(13:19:20) vpnHelper: Title: Red Hat Enterprise Linux Life Cycle - Red Ha=
t Customer Portal (at access.redhat.com)
(13:19:41) cron2: dazo: that sounds much like "oldstable" - critical bug =
fixes plus security.  What am I missing?
(13:19:41) syzzer: "Other errata advisories may be delivered as appropria=
te."  that sounds very reasonable for oldstable to me.
(13:20:17) dazo: because our current "old stable" is missing ^^^
(13:20:31) dazo: 2.3 is in old stable phase with us now
(13:20:47) dazo: we don't add long-term compatibility in 2.3
(13:20:56) syzzer: we now state "security and critical bug fix only", but=
 in practice we have done "Other errata advisories may be delivered as ap=
propriate." too.
(13:20:58) cron2: neither doese RHEL6...?
(13:21:45) dazo: and it is this "in practice" which lead us into this dis=
cussion ... it's not clearly defined
(13:21:57) mattock: let's define this clearly
(13:22:11) cron2: this is a volunteer project
(13:22:44) dazo: yes, but used in much more than volunteer projects
(13:22:47) syzzer: so, we add "Other bug fixes may be delivered as approp=
riate." to the old stable wording?  It describes what we currently do: if=
 we think it's worth it, we backport.
(13:23:07) mattock: +1
(13:23:09) dazo: okay, I can live with that
(13:23:13) cron2: +1
(13:23:48) syzzer: Anyone already editing the page?
(13:24:04) mattock: me
(13:24:08) syzzer: perfect
(13:24:14) syzzer: than I'll just wait :D
(13:24:59) mattock: done
(13:25:30) mattock: almost 1 hour in
(13:25:36) mattock: anything else?
(13:25:39) mattock: rozmansi?
(13:29:49) syzzer: I added a 'Suppported OpenSSL versions' section to the=
 SupportedVersions page too
(13:31:26) mattock: once you're done, I'll add a mention about RHEL 6 bei=
ng the latest supported distribution
(13:31:50) mattock: meaning, "we do not intentionally break things for RH=
EL6"
(13:32:24) dazo: for 2.4, we'll move that to RHEL-7 on 2.5
(13:32:35) mattock: yep
(13:33:00) mattock: so this is basically a think we decide for each relea=
se - the latest supported RHEL version
(13:34:36) syzzer: mattock1: oh, I was just adding that :p
(13:34:51) syzzer: it's now in the first table, but feel free to adjust a=
s you like
(13:35:41) syzzer: also, shouldn't we mention 2.3 as "old stable" there?
(13:36:05) mattock: oh, I'll check your chances
(13:36:08) syzzer: ah, no, we say is because old stable after the next re=
lease
(13:36:18) syzzer: *it becomes
(13:37:56) mattock: yes
(13:39:22) rozmansi: yes, mattock1?
(13:39:54) rozmansi: i'm back
(13:40:10) rozmansi: ah, never mind
(13:40:18) mattock: was just asking if you want to discuss something
(13:40:39) mattock: like "I now have a combined MSI installer ready for O=
penVPN + tap-windows6" :D
(13:40:42) rozmansi: I read more carefully after I posted. :)
(13:41:04) rozmansi: I have "fun" time with mingw
(13:41:13) mattock: did openvpn-build vagrant VM work ok?
(13:42:05) rozmansi: kind of... I ran it on my home Active Directory serv=
er and it wanted to install some VirtualBox interfaces.
(13:42:16) rozmansi: I shut it off and installed Ubuntu manually.
(13:42:34) rozmansi: openvpn-vagrant provided convenient "documentation" =
how to setup it. :O
(13:42:58) mattock: yeah, it is not difficult with the script
(13:43:42) mattock: vagrant+virtualbox is very convenient on a developmen=
t workstation/laptop, but I would not use it elsewhere
(13:43:48) rozmansi: So now I am trying to compile my utilities. The tapc=
tl.exe went fine. Being an ordinary .exe file I just copied the Makefile.=
am from openvpn/openvpnserv and adjusted it.
(13:44:35) rozmansi: The thing is, I don't have a working sample Makefile=
=2Eam in openvpn repo to learn how to compile a .dll
(13:45:13) rozmansi: I posted a question on openvpn-devel list about half=
 an hour ago. Waiting...
(13:48:41) mattock: rozmansi: openvpn-build does build openssl and lzo DL=
Ls
(13:48:56) mattock: and it fetches their source packages to a temporary d=
irectory
(13:49:04) mattock: are those of any help with DLL building?
(13:49:19) cron2: lzo might be simple enough to peek at it
(13:49:27) cron2: I wouldn't look into openssl building...
(13:49:42) rozmansi: hmm, I can look there if it is using same Makefile.a=
m layout.
(13:51:53) mattock: dazo I believe is our makefile expert
(13:52:13) mattock: but not a Windows expert :)
(13:52:34) dazo: rozmansi: what's your challenge=3D
(13:52:35) dazo: ?
(13:52:50) cron2: Subject: [Openvpn-devel] MinGW to build DLL not EXE
(13:52:53) cron2: on the list
(13:53:29) rozmansi: I'm trying to change https://github.com/rozmansi/ope=
nvpn/blob/feature/msi/src/openvpnmsica/Makefile.am to build Windows DLL, =
not EXE.
(13:53:30) vpnHelper: Title: openvpn/Makefile.am at feature/msi =C2=B7 ro=
zmansi/openvpn =C2=B7 GitHub (at github.com)
(13:55:16) dazo: rozmansi: not sure about windows, but the the 'sbin_' pr=
efix indicates that the expected output is an executable
(13:55:41) cron2: dazo: it's "mingw cross-building on linux", so all you =
know about configure is helpful
(13:56:08) dazo: I believe the proper prefix for libraries are 'lib_'
(13:56:15) ***dazo is double checking automake docs
(13:57:20) dazo: okay, the recommended way by automake, is to go via libt=
ools ... so, this is a starting point: https://www.gnu.org/software/autom=
ake/manual/html_node/Libtool-Libraries.html#Libtool-Libraries
(13:57:22) vpnHelper: Title: Libtool Libraries (automake) (at www.gnu.org=
)
(13:58:30) dazo: This is the main docs https://www.gnu.org/software/autom=
ake/manual/html_node/A-Shared-Library.html#A-Shared-Library
(13:58:32) vpnHelper: Title: A Shared Library (automake) (at www.gnu.org)=

(13:58:36) rozmansi: thank you... I shall study it.
(13:59:34) rozmansi: while I have you here... what's the quickest way to =
regenerate Makefile if I change Makefile.ac?
(13:59:54) dazo: ./configure recreates Makefile.am into Makefile
(14:00:09) dazo: autoreconf  does the configure.ac -> ./configure
(14:00:11) rozmansi: tnx
(14:00:36) dazo: but recent autotools will actually automatically detect =
what is needed to be done when you just run 'make'
(14:02:25) mattock: ok, continue on ml / next meeting?
(14:02:33) dazo: yeah
(14:02:41) mattock: let's conclude this one then!
(14:03:14) mattock: I'll send out the summary soon
(14:03:28) rozmansi: bye, thanks
(14:03:35) mattock: bye!
(14:03:49) mattock: feel free to bug the guys on #openvpn-devel though :)=


--------------B484861A2F3AA2B74835F206--

--xsb2T4NBArWnE7DhAOFwniyhtgFLTbUMj--

--d98cG2qCsRAi5NKOaybru0UorovHEz1Xg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlu94JkACgkQKVhNn0CG
RXiYLQf/cEJp4XzdJQBYEniiINZlJtiMl1kumGWeaHn7dEJjxY3FqFAeitESOHcn
MnNJh0Pqmcl5qtBEs3FwlEEsZt5h76G7K/YOsxWjJ/uCzoV5ZNYBhFrPAQT5qMfl
IinjUn47BkVh65Sxm+wd/BMjbABWfBuv1zYuvWzxEPUv3V0gqYT3jdruyWg/nGBW
kNGNLtSb8ns8uXXX5wrKiQp8jJFweVqTcfw8K4/Flijw16jCraYgzqZq/pJB141V
EhFtY5wov0cozZ0JmrdTicF+gxGiywBwS7XC3Xlsq4/Gb23JqgskhzcSEyRDmk3A
E7OXg/b34ke25icEAaNSR917JYfCRg==
=KOpB
-----END PGP SIGNATURE-----

--d98cG2qCsRAi5NKOaybru0UorovHEz1Xg--

