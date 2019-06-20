From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <e55f098a-1ba1-02d7-5f50-b12e4eec054a@...515...>
Message-ID: <ef6133bb-cb4a-d70a-c0b4-1b9466fc19fd@...515...>
Date: Thu, 20 Jun 2019 22:14:45 +0300
MIME-Version: 1.0
In-Reply-To: <e55f098a-1ba1-02d7-5f50-b12e4eec054a@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4jHjSc4c2CBgI4kdBGMGGVt1Smw5HDwRE"
Subject: [Openvpn-devel] Summary of the community meeting (20th June 2019)
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
--4jHjSc4c2CBgI4kdBGMGGVt1Smw5HDwRE
Content-Type: multipart/mixed; boundary="walV6wfmHIeBQT3AP01nVHEDplxr5Q6mb";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <ef6133bb-cb4a-d70a-c0b4-1b9466fc19fd@...515...>
Subject: Summary of the community meeting (20th June 2019)
References: <e55f098a-1ba1-02d7-5f50-b12e4eec054a@...515...>
In-Reply-To: <e55f098a-1ba1-02d7-5f50-b12e4eec054a@...515...>

--walV6wfmHIeBQT3AP01nVHEDplxr5Q6mb
Content-Type: multipart/mixed;
 boundary="------------03E133795F97DFBC74AB62CA"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------03E133795F97DFBC74AB62CA
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thursday 20th June 2019
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-06-20>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock, ordex and zx2c4 participated in this meeting.

---

Mattock gave an update on tap-windows6 HLK testing. All but two tests
are now passing. Those two tests, namely "Operate in Server Core" and
"Static Tools Logo Test", have known solutions. If nothing jumps out of
the Pandora's box at the last minute, mattock is 90% confident he can
push out a release late next week. He will have to build a new version
of tap-windows6 and run through the whole test suite again, which takes
some days.

It was agreed to HLK-test and release Git "master" version of
tap-windows6. Version number will be 9.24.1.

It was also agreed to build a special version of tap-windows6 with Lev's
patch and sign it for Windows 10 (attestation signature):

<https://github.com/OpenVPN/tap-windows6/pull/86>

Once that build has seen enough testing Lev's patch can be merged and
released in an official installer.

---

Had a heated discussion about public portrayal of OpenVPN on the
Wireguard website, and vice versa. No resolution was reached.

---

Talked about dropping the cmocka git submodule from the OpenVPN
repository. It was useful in the past when cmocka was not so easily
available in the distributions. Now it has become a source of problems.

It was agreed to switch to using system-wide cmocka. Cron2 will do the
make/configure work and promised to pester dazo in the process.

Cmocka will be installed system-wide on all the buildslaves. Pretty much
any version of cmocka should do.

---

Talked about the missing Windows "buildslave". The old one has been gone
for about a year. It was agreed that reviving it makes sense. Mattock
agreed to do it "after HLK".

Also noted that it is possible to make Travis-CI send emails of build
failures by logging into there with one's personal GitHub credentials
and changing the settings. It would also be possible to repurpose
Travis-CI to build, with openvpn-build, on every commit to OpenVPN's Git
repository.

---

Noted that mattock and cron2 will be rather unavailable in tomorrow's
mini-hackathon due to vacations/public holidays.

---

Noted that the ARM64 Windows laptops have not arrived yet. Mattock poked
Microsoft about them during the meeting.

--

Full chatlog attached.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------03E133795F97DFBC74AB62CA
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-06-20.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-06-20.txt"

(21:00:37) mattock: good evening
(21:01:24) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
9-06-20
(21:01:25) vpnHelper: Title: Topics-2019-06-20 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:02:11) dazo: Hey!
(21:02:54) mattock: I assume my latest tap-windows6 update ended up on th=
e mailing list?
(21:02:56) dazo ha scelto come argomento: Next meeting 26/June/2019 at 11=
:30 CEST.  Agenda at https://community.openvpn.net/openvpn/wiki/Topics-20=
19-06-20
(21:03:04) dazo: mattock2: yes
(21:03:05) ordex: hi!
(21:03:14) mattock: so only two tests remaining, and both have known solu=
tions
(21:03:24) mattock: which take some time to resolve, but it is only work
(21:03:39) cron2: I am here!
(21:03:42) mattock: hi!
(21:03:51) dazo: o/
(21:04:13) dazo: mattock2: so, what else can jump out of pandora's box on=
ce these issues are resolved?
(21:04:24) mattock: your guess is as good as mine :)
(21:04:41) mattock: but I don't expect any new issues at this point
(21:04:58) mattock: assuming Microsoft's systems are happy with the test =
submission package, that is
(21:05:12) mattock: they _should_ be, but we have not tested submitting a=
nything yes
(21:05:24) mattock: yet
(21:05:32) mattock: so I am hopeful
(21:07:09) mattock: worst case scenario is that I have to reinstall the H=
LK client as Windows Server 2019 core _if_ Microsoft is not happy with th=
e "Operate in Server Core" having been run on a virtual machine, or on so=
me old i5 laptop which does not have the required 4 physical processor co=
res
(21:07:23) mattock: but this is all very anecdotal and nobody knows what =
happens except by trying things out
(21:07:57) mattock: if there are none of these issues I'm 90% confident I=
 can push out a release late next week
(21:08:58) mattock: I will need to double-check what exact variant of tap=
-windows6 I was testing again though
(21:09:19) dazo: please make sure it's the latest and greatest with Lev's=
 fixes ;-)
(21:10:33) mattock: I'm fine with that
(21:10:48) cron2: we've briefly discussed this this afternoon, and since =
we do not know exactly what side effects Lev's fixes have (good or bad) w=
e want to do "master without" and then a test build with Lev's fix and Wi=
n10 signature (attestation), so it can get proper testing
(21:10:50) mattock: then there's the PR from Simon which should resolve t=
he Static Tools Logo Test
(21:11:00) cron2: *yawn* that has been merged ages ago
(21:11:10) cron2: like, 2 minutes :)
(21:11:17) mattock: oh :)
(21:11:17) dazo: :-P
(21:11:21) mattock: I'm so slow
(21:11:39) cron2: that's because you're only mattock2... mattock1 is much=
 quicker :-)
(21:11:46) ordex: lol
(21:12:20) mattock: I should be mattock or mattock1, but whatever :)
(21:12:32) mattock: so "HLK test latest Git master"
(21:12:39) cron2: I would welcome back the old mattock! :-)
(21:13:00) cron2: mattock2: plus a version.m4 bump
(21:13:13) mattock: "build latest master with lev's patch (PR#86) and sig=
n for Windows 10"
(21:13:16) mattock: and that yes
(21:13:19) cron2: yes
(21:13:20) mattock: 9.24.1
(21:13:38) ***cron2 anticipates an enormous HLK happiness cake
(21:13:49) mattock: tomorrow is midsummer eve so I won't be working much
(21:14:00) mattock: so expect stuff to happen starting next week
(21:14:42) mattock: I also finally ate our own dogfood and installer Open=
VPN on the virtual host running the HLK controller so that I can access t=
he HLK controller and clients remotely, which speeds the testing up quite=
 a bit
(21:14:50) cron2: \o/
(21:15:04) mattock: it took like 10 minutes :)
(21:15:09) mattock: not sure why I had avoided it
(21:15:14) cron2: you could use wireguard... I'm told by people all the t=
ime that it's so much faster!! and easier to set up!!!!
(21:15:27) cron2: (and has better crypto as well)
(21:15:44) mattock: well I did have a CA, existing server, existing confi=
g, etc. :)
(21:15:50) mattock: anyways, enough of tap-windows6!
(21:15:52) cron2: :)
(21:15:53) zx2c4: is that the kind of sarcastic antagonism you really wan=
t to display in public cron2?
(21:16:04) mattock: I've worked for 9 hours in a row in HLK today
(21:16:24) cron2: zx2c4: this is what people keep telling me, and everyon=
e else. It's even on the wireguard website.
(21:17:11) mattock: maybe when I'm done with HLK I can finally do some in=
teresting things, including testing Wireguard
(21:17:17) mattock: and let's not get derailed, shall we
(21:17:20) zx2c4: note that we've worked for months and months on making =
wintun good, and on making it standalone so that you guys can get perform=
ance benefits. to date, i've mostly only received antagonistic corporate =
puff pieces ( https://openvpn.net/vpn-myths-wireguard-vs-openvpn/ ) and o=
ther hostilities from you all
(21:17:53) zx2c4: meanwhile i continue to assist with making openvpn fast=
er. i've even contributed patches to you all to add features to it's cert=
ificate fingerprint mechanism
(21:18:13) zx2c4: so i kindly ask that you put away your antagonism, put =
aside the sarcasm, and show us the respect we're owed
(21:18:26) zx2c4: probably that should begin with dazo taking down that r=
idiculous article
(21:18:28) cron2: zx2c4: you are very gracious.  Did you notice that the =
wireguard web site still is full of negative remarks about OpenVPN?
(21:18:55) dazo: zx2c4: and lots of those negative OpenVPN remarks aren't=
 even correct
(21:19:18) zx2c4: ahhh so you want to compare in a "tit-for-tat" basis. i=
 see. in that case, it seems you do indeed want some sort of PR war?
(21:19:21) zx2c4: good luck guys!
(21:19:44) zx2c4: way to antagonize somebody wanting to work with you
(21:19:45) cron2: zx2c4: I'm not the one who needs to justify their own p=
roduct by telling everyone how bad the *other* products are.  You started=
 that.
(21:20:00) cron2: zx2c4: *you* put up the wireguard.net webpage.  That wa=
sn't us.
(21:20:09) ordex: zx2c4: you should know that cron2 has no clue what "PR =
war" you're talking about
(21:20:13) cron2: so don't talk about "antagonizing someone"
(21:20:23) zx2c4: um... im pretty sure i didnt put the 0days in openvpn
(21:20:32) zx2c4: anyway, good luck
(21:20:37) zx2c4: it's going to be interesting...
(21:20:50) mattock: this discussion is so not going to get anywhere
(21:20:51) cron2: I'm not saying openvpn is good code, or bug-free.  Or t=
hat it is *not* bloated.
(21:21:18) zx2c4: justifying your further antagonism will only make all o=
f your projects worse, let me assure you
(21:21:34) cron2: but it's something else if you say that about your own =
responsibilities (even if only inherited), instead of about someone else
(21:21:58) zx2c4: if you'd like to approach me with an aim at reconciliat=
ion, by all means, please do so. otherwise i'll continue preparing for th=
e war path you're trotting=20
(21:22:00) cron2: zx2c4: so, maybe YOU should just stop it.  Look on wire=
guard.net what it says about OpenVPN.  Nothing of this needs to be there.=
  This is not nice.
(21:22:20) dazo: zx2c4: and FTR ... the blog post URL you pointed at is n=
o longer correct; the correct one (which it also redirect to now) is: htt=
ps://openvpn.net/what-is-cloudflare-vpn/
(21:22:29) cron2: zx2c4: oh, please.  We're not the ones who started this=
 badmouthing.
(21:22:47) zx2c4: dazo: still flawed and antagonistic as prior
(21:23:05) cron2: zx2c4: have you looked at wireguard.net today?  Start w=
ith your own side.
(21:23:08) zx2c4: anyway cron2 here has confirmed to me the openvpn inc p=
osition: that you really are engaged in a tit-for-tat dynamic, contrary t=
o dazo's tone before
(21:23:13) cron2: I AM NOT OPENVPN INC
(21:23:14) ordex: can we continue the meeting? there are 10 minutes left =
=2E.
(21:23:20) cron2: get your facts straight, please
(21:23:33) zx2c4: a representative of the openvpn project then?
(21:23:42) ordex: zx2c4: I said this above - he has no clue what war you'=
re talking about - he is totally unrelated to the inc.
(21:23:44) zx2c4: you all seem to share the same koolaid it appears
(21:24:08) cron2: zx2c4: yes.  A volunteer mainting openvpn 2.x code base=
 to the best of my abilities, and we are not deserving the bad mouthing y=
ou spread on your website
(21:24:23) zx2c4: ordex: i see. well, it'd be in the inc's interest, then=
, to lower it's antagonism, so that this kind of thing doesn't spill over=
 to goodfolk like cron2 then?
(21:24:39) ordex: zx2c4: dunno - talk to openvpn inc. for that
(21:24:42) dazo: let's get back on the agenda
(21:24:48) ordex: can we continue the meeting now ? we don't much free ti=
me  ...
(21:24:49) zx2c4: dazo's in here now, mostly ignoring things
(21:24:50) cron2: zx2c4: it would be in wireguard's interest to stop the =
badmouthing of other projects, so the antagonism doesn't spill
(21:24:56) cron2: ordex: we have 36 minutes left :-)
(21:25:01) ordex: zx2c4: becuse this was meant to be a FOSS meeting
(21:25:05) ordex: cron2: oh right :D sorry
(21:25:19) mattock: +1 on stopping this discussion
(21:25:21) mattock: and moving on
(21:25:23) zx2c4: ordex: well, i hang out here so that i can *help* with =
the foss aspects
(21:25:32) zx2c4: then i log in and i see antgaonistic words
(21:25:34) cron2: ordex: but you are certainly right, it is not on the ag=
enda, so I'm not going to speak nice words about wireguard anymore :-)
(21:25:50) ordex: zx2c4: sure, but now you hijacked 15 minutes of our fre=
e time just because you assumed cron2 was making sarcasm
(21:25:53) zx2c4: so let's put it this way: do you want wintun to work fo=
r you all, or not?
(21:26:11) ordex: not sure what that question means (?) maybe it's me
(21:26:15) zx2c4: if you want cooperation, show some respect.
(21:26:18) mattock: please, let us stop here
(21:26:23) ordex: yeah
(21:26:24) mattock: this is not going anywhere
(21:26:41) zx2c4: so, time to show respect then?
(21:26:41) mattock: #2 can we drop the cmocka sub-module
(21:26:59) ordex: mattock2: yeah, we should update all the build slaves t=
o have it installed system wide
(21:27:14) ordex: right now centos6 is for sure one needing it
(21:27:17) cron2: well, the short summary for the sake of the archive is:=

(21:27:31) cron2: we have the git submodule for cmocka because "back then=
" distributions did not have it
(21:27:45) ordex: right and centos is still among them (it seems)
(21:27:47) cron2: with the current way cmocka works, t_net.sh fails becau=
se LD_LIBRARY_PATH
(21:28:07) cron2: getting this fixed with sudo etc. across distributions =
is lots of work
(21:28:10) mattock: did we check which of the current buildslaves operati=
ng systems have cmocka available as a package? or do we plan to install i=
t from source?
(21:28:17) cron2: my proposal is:
(21:28:22) dazo: I see libcmocka available in Fedora EPEL for RHEL/CentOS=

(21:28:26) cron2:  - document how to get cmocka from git & install it
(21:28:27) dazo: even RHEL6
(21:28:35) cron2:  - get rid of all our build logic for cmocka
(21:28:37) dazo: not sure about Debian though
(21:28:44) ordex: dazo: I think centos6 does not have it, does it ?
(21:28:53) cron2:  - instead have configure check for its existance (as i=
t deos for cmake today) and "if there, run unit tests, if not, not"
(21:29:12) ordex: +1
(21:29:27) dazo: ordex: It is in EPEL 6 repos too
(21:29:27) cron2: even on those systems that do not have cmocka, installi=
ng it by means of "git clone & make & make install" is easier than contin=
uously working around the submodule issues
(21:29:28) mattock: sounds very reasonable
(21:29:39) ordex: yap
(21:30:45) mattock: who does the makefile/configure magic?
(21:30:53) cron2: I'm sure I'm going to regret this... but I'm going to t=
ake this - change configure.ac accordingly and figure out how to make it =
behave
(21:31:08) cron2: and pester dazo with questions :)
(21:31:54) mattock: sounds like a plan!
(21:32:00) dazo: works for me :)
(21:32:27) cron2: the cmocka installation instructiosn would then go to I=
NSTALL, next to the "make check" section?
(21:33:49) ordex: but didn't we say that configure.ac already checks for =
cmocka ?
(21:33:55) ordex: or it does not check for the system-wide lib ?
(21:34:01) dazo: cron2: something like that
(21:34:17) dazo: ordex: it only checks for the local git submodule, iirc
(21:34:19) cron2: ordex: right now it checks for cmake, and if cmake is f=
ound *and* the git submodule is initted, it will build cmocka
(21:34:50) cron2: I have the feelign the logic is going to get easier :)
(21:34:57) ordex: right, but if no cmocka submobule is there, but it is f=
ound on the system, unit-tests are still built, I think ?
(21:35:03) cron2: no
(21:35:10) cron2: right now we totally ignore system-wide cmocka
(21:35:18) cron2: (except that it happens to make t_net.sh work by chance=
)
(21:35:19) ordex: oh ok
(21:35:27) dazo: what cron2 say
(21:35:28) dazo: s
(21:36:16) cron2: commit 45f6e7991cfa3bb8a44f981b6cf1e794d617d51e
(21:36:17) cron2: Author: David Sommerseth <dazo@...2511...=
m>
(21:36:21) cron2:     Only build and run cmocka unit tests if its submodu=
le is initialized
(21:36:27) cron2: so, again, it's all dazo's fault :-)
(21:36:37) ordex: :D
(21:36:41) cron2: (we need vpn-helper in here... :) )
(21:37:03) cron2: so - I think cmocka is covered, I have work to do.  May=
be this weekend, still on vacation with the kids
(21:37:10) cron2: 3. windows buildslave...
(21:37:19) dazo: but!  We should double check if that's clever or not btw=
 .... I implemented googletest in openvpn3-linux for unit-testing, and ba=
sed it on system wide libraries in the beginning; but googletest project =
recommends *not* doing that, as compiler flags and optimization may make =
debugging harder - as some code paths may be optimized differently - caus=
ing things to explode in a debugger or so
(21:37:50) dazo: (it was a fairly descriptive information about this issu=
e on some googletest pages)
(21:38:18) dazo: *but* that may be due to how C++ compilers work; not sur=
e if the same issues happens with C compilers
(21:38:44) cron2: well... I have seen that samba relies on system-wide cm=
ocka... and they usually know why they bundle things and not-bundle other=
s
(21:38:50) dazo: however, I do know that openvpn3-linux is hard to debug =
on Ubuntu if the -O compiler flag is different from what the system libra=
ry uses
(21:38:51) cron2: (this is how cmocka ended up on my gentoo system)
(21:39:20) dazo: yeah, but on Gentoo, the compiler flags are usually iden=
tical when you pull things in via emerge, no?
(21:39:22) cron2: dazo: this sounds very much like a C++ issue and I do n=
ot want to even think about these complications :-)
(21:39:32) dazo: hehehe
(21:39:45) cron2: dazo: well, optimization flags, not sure.  -m$arch, yes=

(21:41:21) cron2: I'm not sure cmocka really does that much interesting s=
tuff for C programs, though :-)
(21:41:28) dazo: anyway, lets try ... and we'll see what happens.  Worst =
thing which happens is that we rollback again
(21:41:37) cron2: "build, link, run test, spare lots of work in setting t=
hese all up"
(21:41:37) ordex: yap
(21:41:42) cron2: yeah
(21:42:16) dazo: cmocka stuff isn't production critical at all, so it doe=
sn't need to hold back any releases
(21:42:40) cron2: this would only go to master anyway - 2.4 works nicely =
as it is, the t_net problems are only in master
(21:42:55) dazo: yeah, but we have a hopefully coming 2.5 release ;-)
(21:42:59) cron2: if we decide that this is really much nicer, it can be =
backported, of course
(21:43:20) dazo: yeah
(21:43:32) cron2: dazo: well, it is actually annoying enough that I do no=
t want to push anything else before this is fixed :-) - like, 20 buildbot=
 fails on every push
(21:43:57) ordex: yeah
(21:44:02) dazo: that's understandable, indeed :)
(21:44:18) ordex: my latets patch for t_net.sh assumes this will be fixed=
 and it does not try to address the issue anymore
(21:44:22) ordex: *latest
(21:45:23) dazo: I actually started reviewing that patch though
(21:46:32) ordex: yap - it can be merged, but then we have the Nth wave o=
f mails from buildbot
(21:46:51) dazo: :)
(21:47:09) cron2: we can install cmocka on all affected buildbots in the =
meantime, though :-)
(21:47:22) cron2: ordex: do you have a list?  I threw away all the mails =
in annoyance :)
(21:47:24) mattock: how picky is cmocka about versions?
(21:47:35) mattock: "almost any version is good"?
(21:47:40) cron2: seems "not at all", all of them have a libcmocka.so.0
(21:47:45) cron2: and that seems to work nicely
(21:47:48) mattock: ok
(21:47:49) mattock: good
(21:47:54) ordex: cron2: same here, but I could build my branch again :D
(21:48:13) cron2: I'll just merge your patch and push
(21:48:48) cron2: dazo: I've reviewed v1 already, which was mostly the sa=
me except "plus LD_LIBRARY_PATH", so I can just ack+push
(21:48:50) ordex: ok
(21:48:56) ordex: yap
(21:49:04) cron2: or maybe not, see #openvpn-devel
(21:49:38) mattock: 11 minutes left, two more topics
(21:49:41) mattock: hint hint
(21:49:44) mattock: :)
(21:49:54) cron2: well, I thought we were at "3" already anyway :-)
(21:50:05) mattock: that's quick
(21:50:08) cron2: there used to be a windows buildslave which sends me ma=
il if I break windows compilation
(21:50:17) mattock: "yes, it has been gone for a year, and nobody cared o=
r noticed"
(21:50:19) cron2: and which used to put up snapshot installers...
(21:50:31) cron2: I did care, and I think I remarked a few times...
(21:50:58) mattock: yeah, I agree, but it is interesting that nobody (afa=
ik) complained about the installers
(21:51:01) cron2: I had forgotten again, but when I broke windows like 10=
 commits ago, nobody noticed which is sad
(21:51:06) mattock: yeah
(21:51:14) cron2: so - is it easy to revive it?
(21:51:26) mattock: I wonder if we could repurpose travis to build the in=
stallers - openvpn-build repo already does it
(21:51:45) ordex: cron2: we have travis (and I have gitlab-ci) that build=
 for windows and create binaries
(21:52:11) ordex: mattock2: to build the installers you need openvpn-buil=
d, no? from openvpn you ca nonly build the binary I guess
(21:52:12) ordex: ?
(21:52:22) cron2: well, travis does send mails now, but they are much les=
s good than mattock's build mails
(21:52:32) mattock: I take that as a complement
(21:52:34) mattock: :)
(21:52:41) cron2: ("it fails, please go and click on $URL to see why")
(21:52:57) cron2: mattock2: I like one-stop problem reports.  "It failed,=
 and here is the output: <blah>"
(21:53:00) mattock: well, assuming nothing has broken in the meanwhile re=
viving the buildslave should not be that big a deal=20
(21:53:14) mattock: and if we're content with the functionality it used t=
o have
(21:53:15) cron2: pretty please? ;-)
(21:53:23) mattock: "after HLK" :)
(21:53:31) cron2: *I* found it very useful
(21:53:49) mattock: noted :)
(21:54:06) mattock: so travis-ci: is there a way to receive email reports=
?
(21:54:14) cron2: so - after HLK is perfectly fine.  Until then, I need t=
o review more carefully and if it looks like dangerous, run my own tests
(21:54:32) ordex: mattock2: yap, cron2 enabled that recently for himself
(21:54:54) cron2: travis-ci: we found that it can send mails - if you log=
in with your github credentials to travis-ci, you can set in your *person=
al* profile that you want to receive build failure mails
(21:55:01) cron2: not in the project settings
(21:55:29) cron2: and not much to customize - so you get a mail "it faile=
d! see $URL for why!", but it's better than "not noticing"
(21:55:51) cron2: this much for the archives - question for the group: is=
 there more options?  Who understands travis-ci?
(21:56:27) ordex: what do you mean with "more options?" I have played wit=
h it a bit, I may be able to answer some questions
(21:56:52) cron2: like, more fine grained control on e-mail - when does i=
t send a mail, what is in there
(21:57:54) ordex: ah  - no :) that I never found how to customize
(21:58:02) ordex: it's just a failure and then you are redirected to the =
job page
(21:58:33) cron2: well, good enough for today
(21:58:42) cron2: 2.5 update/planning
(21:59:04) mattock: +1
(21:59:18) cron2: mini-hackathon tomorrow?  I cannot make it (last day on=
 the vacation resort, we have to checkout at 10 but can stay until aftern=
oon, so laptop will be in the car and I will be at the pool...)
(21:59:56) dazo: sounds like the proper priority ;-)
(22:00:00) cron2: but you do not need me for review & ACK & new versions =
of some patches... I can pick up the stuff from there
(22:00:08) ordex: yap
(22:00:19) cron2: yeah, work has been... special this year, so family nee=
ded priority for a week
(22:00:40) mattock: I will be quite unavailable tomorrow due to the midsu=
mmer eve thingy
(22:00:56) ordex: mattock2: what is that about ?
(22:01:15) mattock: generally speaking people drink too much, go to sauna=
, go swimming and drown
(22:01:19) mattock: :)
(22:01:24) cron2: ordex: something like "dancing naked in the woods" or s=
o
(22:01:29) ordex: LOL
(22:01:29) mattock: and that occasionally
(22:01:41) ordex: mattock2: so if you drink tomorrow you die ?
(22:01:45) ordex: :D
(22:01:47) mattock: there's the yearly dead by drowning count which peopl=
e try to guess
(22:01:49) ordex: what a chain of events !!
(22:01:49) mattock: I won't
(22:01:58) ordex: on this day ?
(22:02:01) cron2: mattock2: ouch
(22:02:09) mattock: usually it extends to the weekend
(22:02:18) mattock: but the mayhem starts tomorrow
(22:02:37) mattock: I will be on small family trip, so I'm good
(22:02:58) mattock: :D
(22:03:18) mattock: are we good for today?
(22:03:20) cron2: I wish you a nice day full of family enjoyment, naked o=
r drunk, or neither :)
(22:03:26) mattock: thank you!
(22:03:26) cron2: but please do not drown
(22:03:36) mattock: yeah, we still need to HLK test result packages!
(22:03:53) mattock: otherwise some poor sould (which is probably dazo) wi=
ll take over that task
(22:03:55) mattock: :D
(22:04:03) cron2: and document the whole chore :-) - after that, you're f=
ree...
(22:04:15) mattock: it is almost completely documented: https://community=
=2Eopenvpn.net/openvpn/wiki/HLKTesting
(22:04:17) vpnHelper: Title: HLKTesting =E2=80=93 OpenVPN Community (at c=
ommunity.openvpn.net)
(22:04:28) mattock: some anecdotes are missing
(22:05:11) mattock: ok, let's conclude this, I have the summayr ready
(22:05:21) dazo: leave the sad ones, only add the fun ones :-P
(22:05:42) cron2: there is fun in WLK testing?  well, the cake, obviously=
=2E..
(22:05:48) cron2: (have the arm64 laptops arrived?)
(22:05:53) cron2: ((where is plaisthos anyway??))
(22:06:05) mattock: no, I have not seen any arm64 laptops
(22:06:09) cron2: (((and what about this new patch set...?)))
(22:06:10) mattock: I may need to poke them again
(22:06:34) dazo: cron2: on holiday, north in DE, hopefully surviving wate=
r kiting and sun
(22:06:59) cron2: dazo: ah... so hopefully, v4 of his token patchset surv=
ives your scrutiny now...
(22:07:20) dazo: hopefully :)  I'll try to get the rest reviewed tomorrow=
 so we can get everything at once
(22:09:33) mattock: I poked them about the ARM64 device
(22:10:28) mattock: I'll send the summary now and then head home

--------------03E133795F97DFBC74AB62CA--

--walV6wfmHIeBQT3AP01nVHEDplxr5Q6mb--

--4jHjSc4c2CBgI4kdBGMGGVt1Smw5HDwRE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl0L2yUACgkQKVhNn0CG
RXiNGwgAuxw8PtqNjBrjIN41zWzJ5YedpVf1QL5tatpnIicCx+8oYCeRZWWi7+U9
mcQnb4AaFhAQslJ/HBYVylhdUqjZuUBuSJfWyWRhW+K6OKuWBIbgpi2K30VAKHa1
PuWSjN5IrPODYitT80Kv7flXaIwEmKclvEBtUrdI4RSNejG2e35galVvdJxLW30f
fvhbWbeGs7a6LAXt3GwrePx2rxh3vIQPlj4kxd8zS+ndfd8rmETuxYpobGoKWLeR
CSkfPEovlhDDyTAIt55FKLtNwARXnYbMi1Lz6adE0LNrIm6AHss8YADvJpVLHoQx
aHs/GZCC0bMKP28aqH5dZ8+Qou9a8Q==
=SIEE
-----END PGP SIGNATURE-----

--4jHjSc4c2CBgI4kdBGMGGVt1Smw5HDwRE--

