From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <e3e0bf19-c810-002a-a4fc-1e7d6b4c798a@...515...>
Message-ID: <a497cdf9-b7e6-dc91-e807-823732049bfb@...515...>
Date: Thu, 27 Aug 2020 22:06:14 +0300
MIME-Version: 1.0
In-Reply-To: <e3e0bf19-c810-002a-a4fc-1e7d6b4c798a@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="blD3fGqB3ZvTqGy5Vw3WUi1G0QQ3ASoI0"
Subject: [Openvpn-devel] Summary of the community meeting (27th August 2020)
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
--blD3fGqB3ZvTqGy5Vw3WUi1G0QQ3ASoI0
Content-Type: multipart/mixed; boundary="QAXWLMjyAnAgfI3RaHSSQV53EsvWmUyhH"

--QAXWLMjyAnAgfI3RaHSSQV53EsvWmUyhH
Content-Type: multipart/mixed;
 boundary="------------5B647EC5693C0AA2D49AAC46"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------5B647EC5693C0AA2D49AAC46
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thu 27th August 2020
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-08-27>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

becm, cron2, dazo, lev and mattock participated in this meeting.

---

Discussed libpkcs11-helper bundled with the current 2.5-beta1 Windows
installers. The updated patch that was supposedly included in 2.5-beta1
was actually not included at all as file renaming broke patch
auto-detection logic. That is now fixed in the (upcoming) 2.5-beta2
installers.

It was agreed to upgrade pkcs11-helper from version 1.22 to 1.26.0 while
we're at it.

--

OpenVPN 2.5-beta2 was tagged in Git yesterday. Mattock has been working
mostly on tap-windows6 build improvements today, and will wrap up the
OpenVPN 2.5-beta2 release tomorrow. There have been two issues so far:

- Windows MSI EXE wrapper build fails for reasons (yet) unknown
- Ubuntu 20.04 32-bit packages fail to build due to Ubuntu repo issues

Mattock will try to get these resolved, but they're not strictly release
blockers.

--

Noted that the MSI installers have received several improvements since
beta1. Unfortunately it is still possible to mount a sort of local,
unprivileged DoS using "msiexec /fu", even with the recent fixes.

--

Dazo will push out 2.5-beta2 to Fedora Copr as soon as mattock has the
GPG signatures on build.openvpn.net.

--

Agreed that advertising pkcs11-helper fixes/features makes sense to get
wider testing. There have been improvements in several areas such as RSA
padding, RFC7512 fixesand Elliptic Curve support.

--

Discussed enabling IPv6 on community. Noted that part of the hesitation
from the OpenVPN Inc. ops team is related to the fact that Cloudflare
does not allow turning off IPv6 if you turn it on, and the switch is
always domain-wide (openvpn.net).

That said, the ops team will contact Cloudflare and ask if they would
allow testing IPv6 support safely, that is, grant us a backpedaling
option if things go awfully bad.

While waiting Cloudflare has been turned off on community.openvpn.net.

--

Talked about discontinuing 32-bit Windows installer support. Decided to
get some download numbers for our installers to figure out if that is
realistic.

--

Full chatlog attached

--------------5B647EC5693C0AA2D49AAC46
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-08-27.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-08-27.txt"

(20:58:25) mattock: hello
(20:58:33) cron2: hiya
(21:00:21) lev__: guten aben
(21:00:22) dazo: hey!
(21:00:59) becm: 'n abend
(21:01:42) cron2: do we have an agenda?
(21:02:03) mattock: I have one topic
(21:02:11) cron2 ha scelto come argomento: Agenda at https://community.op=
envpn.net/openvpn/wiki/Topics-2020-08-27
(21:02:35) mattock: libpkcs11-helper -> 1.22.6 upgrade is fine to all?
(21:02:41) mattock: sorry
(21:02:44) mattock: 1.26.0
(21:02:44) cron2: wfm
(21:02:51) mattock: in windows installers
(21:03:02) mattock: 1.22 -> 1.26.0
(21:04:39) becm: can do tests if a binary is available (sample size: 1 to=
ken)
(21:04:52) dazo: I don't see anything worrying, as long as the patch we n=
eed applies
(21:05:29) cron2: becm: test reports of beta2 with that change would be v=
ery much appreciated (as soon as the installer is out)
(21:06:12) becm: mattock: was the "patch fix" the revert of the patch ren=
ame?
(21:06:45) mattock: yes
(21:06:52) mattock: the patch applied with some offset
(21:07:02) becm: as expected.
(21:08:00) becm: only way to avoid this would be to use the current pull =
request in pkcs11-helper
(21:09:18) becm: or wait until Fedora gets 1.26 into "official" state (ht=
tps://bugzilla.redhat.com/show_bug.cgi?id=3D1849259)
(21:09:19) vpnHelper: Title: 1849259 pkcs11-helper-1.26 is available (at =
bugzilla.redhat.com)
(21:10:41) dazo: I expect it might take a little time before 1.26 is upgr=
aded in Fedora; I suspect that to first go into the next major release (u=
nless the upgrade does not break ABI) ... and there's lots of focus on F3=
3 currently, it got branched out some weeks ago
(21:13:08) mattock: ok so what is the conclusion?
(21:13:14) mattock: I do have MSIs with 1.26.0
(21:13:24) mattock: I can rebuild them with 1.22 if we wish so
(21:13:26) cron2: not sure what Fedora has to do with windows release
(21:13:32) cron2: go for 1.26 :)
(21:13:39) mattock: I guess "some extra testing"
(21:13:42) mattock: fine by me
(21:13:47) mattock: this is a beta release anyways
(21:13:55) mattock: :D
(21:14:02) cron2: yep.  get this out to testers, and then we can see
(21:14:05) dazo: cron2: we pick a patch fixing some pkcs11-helper issues =
from Fedora (it's not strictly Fedora related) which we patch for the Win=
dows build
(21:14:32) cron2: o-kay
(21:14:43) dazo: cron2: there's some resistance from the pkcs11-helper to=
 add that particular fix, but no alternative has been applied
(21:16:53) mattock: mkay
(21:16:56) mattock: 1.26 it is
(21:17:17) mattock: I was trying out the EXE wrapper but managed to mangl=
e my RDP session somehow
(21:18:02) mattock: I improved/fixed quite a few things in tap-windows6 d=
ocs and release scripts, which took many hours, so 2.5-beta2 will go out =
tomorrow
(21:18:09) cron2: PR merged
(21:18:14) mattock: thanks!
(21:18:34) cron2: I wish I had better Internet here... then I could work =
a bit on upgrading the vagrant boxes
(21:18:38) mattock: debian packages are done, except for Ubuntu 20.04 32-=
bit (apt repo issue at ubuntu side)
(21:19:02) mattock: so tomorrow it will be some smoketesting but hopefull=
y no rebuilding
(21:19:16) dazo: mattock: Do we have many 32-bit users at all?
(21:19:26) mattock: I do not know
(21:19:33) mattock: we could get the (download) logs though
(21:19:41) mattock: Windows 32-bit is probably a dying breed
(21:20:10) mattock: right now things suck particularly bad (for me) becau=
se we have NSIS, MSI, Win7 signing, Win10 signing, OpenVPN 2.4.x and Open=
VPN 2.5.x
(21:20:18) mattock: too many combinations to keep things neat and organiz=
ed
(21:20:25) dazo: yeah, probably a good idea ... I was thinking about Ubu/=
Deb too .... Fedora kicked out 32bit a while back
(21:20:43) mattock: I don't think many would scream, but I'll ask who can=
 give us the numbers
(21:21:11) dazo: would be good to check the S3 download numbers indeed
(21:21:20) cron2: mattock: you had a nice and long vacation while I fough=
t plaisthos' refactoring spree... :-)
(21:21:24) mattock: asked
(21:21:35) mattock: cron2: yes, it was a refreshing vacation
(21:21:42) mattock: now I'm happily back in the meat grinder :D
(21:21:48) cron2: :-)
(21:22:05) mattock: anyways, what other topics for today?
(21:22:15) dazo: btw ... of the Fedora Copr repository, EPEL-7 seems to b=
e the most popular one
(21:22:24) mattock: only insane people like me use Fedora
(21:22:38) mattock: that said, I've liked Fedora
(21:22:51) dazo: EPEL-7, then EPEL-8 and third one is Fedora 32
(21:23:08) cron2: I have nothing particular.  FTR "beta2 was signed and p=
ushed yesterday" :-)
(21:23:27) dazo: oh great!  I'll update the Copr -beta repo then
(21:23:52) mattock: yep, we can start pushing out stuff now
(21:24:07) mattock: I typically release debian/ubuntu packages beforehand=

(21:24:20) mattock: the update of the webpage is the final step before of=
ficial announcements
(21:25:12) mattock: ok but if there is nothing else we can maybe end earl=
y?
(21:25:19) cron2: the diffs beta1->beta2 are not very large.  Documentati=
on fixes (good!), a NCP fix for a corner case, a strlen/sizeof bug (with =
no ill effect), and repairing "wintun under SYSTEM"
(21:25:29) cron2: so overall beta1 got testing, and wasn't too broken :-)=

(21:26:01) mattock: +1
(21:26:17) lev__: also small MSI installer fix (login as different user b=
reaks active VPN connection)
(21:26:22) mattock: a fun word of wisdom from cscript.wsf: "The file libp=
kcs11_helper_1.dll is not a Font,"
(21:26:39) mattock: lev: yeah, a few fixes actually
(21:27:00) mattock: disabling the wonky repair mode that could be used as=
 a kind of local DoS attack by local users
(21:27:07) lev__: it would be nice to fix msiexec /fu problem before fina=
l release
(21:27:13) mattock: though there is a backdoor called msiexec /fu
(21:27:20) mattock: yeah, if there is a way
(21:27:20) lev__: but I dont have enought MSI knowledge for that
(21:27:25) mattock: I have even less
(21:27:25) dazo: beta2 build started :-P   https://copr.fedorainfracloud.=
org/coprs/dsommers/openvpn-beta/build/1637302/
(21:27:27) vpnHelper: Title: Build 1637302 in dsommers/openvpn-beta (at c=
opr.fedorainfracloud.org)
(21:27:28) cron2: I have no overview on what goodness you brought to the =
windows installers :-)
(21:28:13) mattock: it seems there is some problem with building the exe =
wrapper for the msis
(21:28:18) dazo: hmmm mattock, Cloudflare/AWS needs a cache flush ...
(21:28:19) dazo: stderr: warning: Downloading https://build.openvpn.net/d=
ownloads/releases/openvpn-2.5_beta2.tar.xz to /tmp/copr-rpmbuild-kbts2bng=
/openvpn-2.5_beta2.tar.xz
(21:28:20) dazo: warning: Downloading https://build.openvpn.net/downloads=
/releases/openvpn-2.5_beta2.tar.xz.asc to /tmp/copr-rpmbuild-kbts2bng/ope=
nvpn-2.5_beta2.tar.xz.asc
(21:28:20) dazo: curl: (22) The requested URL returned error: 404 Not Fou=
nd
(21:28:45) mattock: there is no cloudflare in front of build.openvpn.net
(21:28:51) mattock: I'll check if the file is actually there
(21:29:03) dazo: okay, that might explain
(21:29:11) mattock: ah, the signature
(21:29:16) mattock: there are no signatures yet
(21:29:21) mattock: there will be soon
(21:29:42) mattock: if you can wait until tomorrow morning-ish I will hav=
e all the files in there
(21:29:57) dazo: sure, it's just a click on my side to retry the build
(21:30:07) cron2: the directory listing says it's there
(21:30:21) cron2: ah, no, the .asc not
(21:30:25) dazo: right ;-)
(21:31:13) dazo: I think mattock keeps back the .asc file to be sure that=
 Fedora builds aren't done before his Debian/Ubuntu builds </conspiracy_t=
hought> :-P
(21:31:19) mattock: lol!
(21:31:34) mattock: I just try to limit the number of extra steps in the =
already step-full process
(21:31:39) mattock: it gets confusing easily
(21:32:26) mattock: anyhow, all done?
(21:32:47) dazo: I've said it before, but I really would like to see Debi=
an/Ubuntu have something like the Copr service for communities ... it's j=
ust pushing the .spec file (in Deb it would be the debian/ directory) to =
a git tree and the rest goes by itself
(21:33:37) cron2: that sounds very convenient indeed
(21:33:40) dazo: Should we set a target date the rc1 release and final re=
lease?
(21:33:48) cron2: we have :)
(21:33:54) mattock: yeah, afaik there is nothing like it really, just Lau=
nchpad (for random repos from guy <n>)
(21:33:54) cron2: (not for rc1 but for final release)
(21:33:56) dazo: oh, I missed that :-P
(21:34:14) cron2: it's in the status page - I think something like Sep 17=

(21:34:39) becm: should we "advertise" the pkcs11-helper update to (seemi=
ngly) related issues?
(21:34:40) cron2: (we originally intended this to be Sep 10, but since we=
 delayed beta1 by a week, I pushed that one too)
(21:34:41) dazo: ahh, I just saw no date on rc1 :-P
(21:35:18) mattock: becm: you mean tickets?
(21:35:57) cron2: I would suggest we wait until next week to see what rep=
orts we get on beta2 - if everyone is happy, we might be able to save mat=
tock the effort on rc1
(21:36:14) cron2: (it is very easy for me "update ChangeLog, version.m4, =
git tag, push") but much work
(21:36:24) cron2: for mattock
(21:36:27) mattock: +1
(21:36:41) mattock: unfortunately 2.5 has required lots of changes in the=
 build environment
(21:36:48) mattock: fixes, documentation, scripting, etc
(21:37:01) cron2: maybe we need a beta2.1 beta2.2 beta2.3 windows version=
=2E..
(21:37:06) mattock: most of that is in the past, but it is still a signif=
icant effort, much of which can't be easily automated
(21:37:11) cron2: "even less work for me" *duck*
(21:37:19) becm: issues (EC-support), ticket (16-byte serial), mailing-li=
st (PSS, TLS1.2/1.3 issue)
(21:37:36) mattock: windows installer releases have always been pretty be=
cause they can be just released without lots of noise
(21:38:13) becm: mainly dangling a carrot to "trick" some people into tes=
ting the beta release :)
(21:39:04) mattock: I'm fine with that - we can have that in the changelo=
g in Trac, the release notes and also put that to the related tickets
(21:39:36) mattock: perhaps they could somehow fit in here: https://commu=
nity.openvpn.net/openvpn/wiki/ChangesInOpenvpn25
(21:39:38) vpnHelper: Title: ChangesInOpenvpn25 =E2=80=93 OpenVPN Communi=
ty (at community.openvpn.net)
(21:40:54) mattock: btw. I know who to ask about 32-bit vs. 64-bit downlo=
ads now
(21:40:58) mattock: we can get exact numbers
(21:41:01) mattock: then make a call
(21:41:23) mattock: also, regarding IPv6 on community - I talked about th=
at in the ops meeting which ended about 35 minutes ago
(21:41:24) dazo: sounds good!
(21:41:53) mattock: so part of the problem was/is that Cloudflare does no=
t let (e.g. via press of a button) to turn off IPv6 _if_ there are proble=
ms
(21:42:08) mattock: so, we decided to reach out to Cloudflare and ask if =
they could allow reverting if things explode badly
(21:42:14) mattock: then we could actually try out and see what happens
(21:42:42) mattock: for now Cloudflare is not turned on community.openvpn=
=2Enet (until the next DoS happens)
(21:42:59) mattock: but there is hope that we can actually get the IPv6 s=
ituation sorted out for good
(21:43:20) mattock: I'm sure we're not only Cloudflare customers with the=
 same worries
(21:44:24) cron2: community.openvpn.net has IPv6 address 2600:1f1c:702:ae=
00:a0dd:6cbf:950d:3130
(21:44:27) cron2: hah
(21:44:30) cron2: my ticket closes
(21:44:32) cron2: thanks
(21:45:15) mattock: for now yes, I hope we can get away from this back an=
d forth game soon
(21:45:54) mattock: anything else?
(21:46:19) cron2: nothing important from my side
(21:46:32) cron2: LTE in Italy sucks this year
(21:53:18) mattock: even though tourist count has plummeted...
(21:53:35) mattock: becm: if you want to craft an advertisement for pkcs1=
1-helper I can publish it
(21:54:21) cron2: mattock: over here, it's "less tourists than usual" but=
 not "extremely so" - I would estimat like 90% utilization on the camping=
 site, which is normally 100% in August
(21:54:31) mattock: ok
(21:54:42) mattock: well, Italy is not that bad COVID-19-vise right now I=
 guess
(21:55:12) cron2: from what I hear, it's fairly good.  people are discipl=
ined, and not so many stupid german tourists here (like on Mallorca)
(21:55:31) cron2: "it's only a vacation if I can go to a crowded club eve=
ry night and drink with strangers"
(21:56:11) mattock: sounds fun :)
(21:56:20) cron2: stupid idiots
(21:56:34) cron2: (these are the ones that brought Covid-19 back home fro=
m Ischgl)
(21:57:30) dazo: heh .... Norway recently moved Germany to a "Red country=
" while Italy is still "yellow"  (there are no "green countries", at leas=
t not in Europe)
(21:59:17) becm: mattock: I'd mainly mention the affected areas (RSA padd=
ing, RFC7512 fixes, actual Elliptic Curve support) and eventually leave a=
 note in the relevant places on github/trac.
(22:01:04) cron2: dazo: yes, we were a bit afraid that travelling DE->AT-=
>IT one of the countries would not let us *in*
(22:01:15) mattock: becm: ok, noted
(22:01:18) cron2: but we left DE before numbers in bavaria really got up

--------------5B647EC5693C0AA2D49AAC46--

--QAXWLMjyAnAgfI3RaHSSQV53EsvWmUyhH--

--blD3fGqB3ZvTqGy5Vw3WUi1G0QQ3ASoI0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl9IBCYACgkQKVhNn0CG
RXitgQf+JWUM8zYE9wn8w9GbOGIg56x81qA7ygaRF9cIKUbc2cOhUQsWXpYbdbJI
Kdst8t3E9t+jUeRea7L8/766CJiJCfM8g81WZ4SP648MCaODECaZ3cNdO8u3evhd
92cHs/5rUw+QTdlphKSpMuwa/6WC1OXCkgDCXADwomUg39hzbJ/wR0NFqvz08rfG
6CHy2ndnYWO6cetFF5yM9MdeDTZBfppGJxDacyrlsJxZdtXBSQ2XB2C8sLPg3NuY
XDPWU0ZzkrJ9ziqGYhbfM0YrR+jPPPvLtFeW8tbCcMhj1aeowqeSUqCgX6NpJOXi
ei5QWp6VSLeovDG9dvDV4IpqmSTtQw==
=s/TG
-----END PGP SIGNATURE-----

--blD3fGqB3ZvTqGy5Vw3WUi1G0QQ3ASoI0--

