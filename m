From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <4d714839-b586-8b1c-df66-6ceb20a59fe3@...515...>
Message-ID: <97228b0e-5179-f7c4-3f57-5199d578b324@...515...>
Date: Thu, 10 Oct 2019 22:24:28 +0300
MIME-Version: 1.0
In-Reply-To: <4d714839-b586-8b1c-df66-6ceb20a59fe3@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NksUzfXxxcQzp3zH8JcQDfO4hmK0fEwys"
Subject: [Openvpn-devel] Summary of the community meeting (10th October 2019)
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
--NksUzfXxxcQzp3zH8JcQDfO4hmK0fEwys
Content-Type: multipart/mixed; boundary="covMc29Lnz5T5Kcscaj1th9F0AjNyDD1t";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <97228b0e-5179-f7c4-3f57-5199d578b324@...515...>
Subject: Summary of the community meeting (10th October 2019)
References: <4d714839-b586-8b1c-df66-6ceb20a59fe3@...515...>
In-Reply-To: <4d714839-b586-8b1c-df66-6ceb20a59fe3@...515...>

--covMc29Lnz5T5Kcscaj1th9F0AjNyDD1t
Content-Type: multipart/mixed;
 boundary="------------3211C15FD81D18136F22322E"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------3211C15FD81D18136F22322E
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thursday 10th October 2019
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-10-10>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, lev, mattock and ordex participated in this meeting.

---

Talked about the new buildslaves. Cron2 added OpenBSD 6.5 (recent
release), NetBSD 8.1 (recent release), OpenIndiana (Solaris fork, recent
release) buildslaves with working t_client tests yesterday. Cron2 will
attempt to bring back at least part of the buildslaves that got
destroyed earlier.

Mattock finished migrating Ubuntu 18.04 and Fedora 30 to Amazon EC2 as
well to allow others to go have a look at them when there are issues.

The Fedora 30 buildslave is failing t_net.sh tests. Ordex and cron2 are
debugging the problem which seems timing-related.

---

Noted that mattock now has a new, more beefy (but still unconfigured)
Windows instance that can be used to build _and_ sign tap-windows6. This
greatly simplifies and speeds up the tap-windows6 building and signing
process.

---

Mattock's plan forward with community work is this:

1) Finish internal OpenVPN work related to the buildslave setup (PRs)
2) Release tap-windows6 test installer
3) Setup the "builder" instance (~the old "Windows buildslave")
4) Setup a true Windows _buildbot_ buildslave for testing VS2019 builds

---

Noted that the VLAN patchset is slowly getting merged. The first patch
is already in.

--

Talked about the wintun patches from Lev and in particular the patch
that upgrades Visual Studio project files to VS2019 format. After a
lengthy discussion cron2 proposed the following:

- Have a Trac document that explains how to build with VS
- Merge the patch
- Get a VS buildslave (to help avoid breaking VS builds)

We did not reach a consensus on this yet.

--

Talked about OpenVPN apt repositories:

<https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos>

The topic was added by wiscii who was not present. It was not clear to
the meeting participants what the issue with the repositories is. We
will have to wait for more info.

--

Full chatlog attached.

--------------3211C15FD81D18136F22322E
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-10-10.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-10-10.txt"

(21:00:43) mattock: good evening
(21:02:06) cron2: aloah
(21:03:32) mattock: hi
(21:03:39) mattock: who else?
(21:05:47) mattock: hmm quiet
(21:06:22) dazo: you missed my message, mattock1 ;-)
(21:06:24) ***dazo will arrive a bit later today ...=20
(21:06:27) dazo: in the middle of getting kids into bed
(21:06:40) mattock: ok!
(21:06:59) mattock: ok let's begin
(21:07:45) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
9-10-10
(21:07:47) vpnHelper: Title: Topics-2019-10-10 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:08:12) mattock: fairly clean topic list
(21:08:14) mattock: I'd add one
(21:08:16) mattock: buildslaves
(21:08:42) mattock: I have not checked the latest status of my buildslave=
s so I'll do it now
(21:09:07) cron2: fedora still borked on t_net.sh tests.  The rest is all=
 green.
(21:09:23) mattock: yeah
(21:09:39) mattock: has there been any discussion as to why the t_net.sh =
tests fail?
(21:09:47) mattock: I did not have time to look into it
(21:09:50) cron2: this seems to be a timing issue
(21:10:00) lev__: guten abend
(21:10:06) dazo: chronyd not running?
(21:10:10) dazo: (or ntpd?)
(21:10:16) cron2: we had this on the arch linux one as well, and sprinkli=
ng sleep()s over the script helped
(21:10:42) mattock: dazo: I'll check - Fedora 30 is unlike anything else =
we run in our infrastructure
(21:11:04) cron2: dazo: nah, it's more like "some time after <mumble>, so=
mething happens with <thingsie>, so if your test is very fast, it will su=
cceed.  If the machine is slow enough, <thingsie> will not look "right", =
and the test fails
(21:11:19) cron2: the arch linux machine is slowwwwwwwwwwww, so triggered=
 this first.
(21:11:27) dazo: ahh, okay
(21:11:32) cron2: mattock1: is the fedora machine particularily slow?
(21:11:40) cron2: like, "we only bought the 50 MHz license"?
(21:11:48) mattock: clock is good
(21:12:10) cron2: it's a local race condition, between "ip" manipulating =
things and "sitnl code" doing the same, comparing the results
(21:12:27) mattock: it is t3.small so low-end, but so is the ubuntu 18.04=
 VM
(21:12:36) cron2: plus the kernel code deciding *after some time* to chan=
ge values printed by "ip link show" IIRC
(21:12:39) cron2: ordex knows
(21:13:40) dazo: "ip link show" is part of iproute2, so the output is dep=
ending on that package, not necessarily the kernel itself
(21:14:03) cron2: you run "ip link show", wait a second, run "ip link sho=
w" again, get a different result
(21:14:09) dazo: ahh
(21:14:14) dazo: that's interesting
(21:14:56) cron2: I forgot the specifics, which chain of commands trigger=
 this - but if you finish in "wait a second" time, all is good.  If you'r=
e too slow, you hit "different result" and that makes the t_net compariso=
n fail
(21:15:33) dazo: Maybe we need to implement our own "extract the info we =
need" utility based on sitnl for Linux tests :-P
(21:16:04) dazo: (which accounts for these details)
(21:16:06) cron2: this is why commit 8aa037161f37 exists :) but it seems =
this was not the true solution
(21:16:13) cron2: ah
(21:16:17) cron2:     t_net.sh: wait for NO-CARRIER bit to settle before =
starting test
(21:16:17) cron2:    =20
(21:16:17) cron2:     Interfaces of type tun are marked as NO-CARRIER whe=
n no process is
(21:16:17) cron2:     attached to them. However, this bit gets set with s=
ome delay after
(21:16:17) cron2:     creation.
(21:16:35) cron2: maybe a better fix would be to just ignore the NO-CARRI=
ER on comparison
(21:17:06) cron2: yeah, same thing again - from the buildbot output:
(21:17:11) cron2: after unit-test:
(21:17:12) cron2: dummy0: <POINTOPOINT,MULTICAST,NOARP,UP> mtu 1500 qdisc=
 fq_codel state UNKNOWN mode DEFAULT group default qlen 100
(21:17:15) dazo: yeah ... or to have a polling loop which continues once =
NO-CARRIER is gone
(21:17:15) cron2: after iproute command:
(21:17:16) cron2: dummy0: <NO-CARRIER,POINTOPOINT,MULTICAST,NOARP,UP> mtu=
 1500 qdisc fq_codel state DOWN mode DEFAULT group default qlen 100
(21:17:29) dazo: hmm
(21:17:39) cron2: (and the "state DOWN" goes along with "NO CARRIER")
(21:17:49) dazo: yeah
(21:18:17) dazo: alright ... lets not hold up the meeting for this debugg=
ing :)
(21:19:09) cron2: indeed :) ("ip link show | sed -e 's/NO-CARRIER,//' -e =
's/state DOWN/state UNKNOWN/'" *cough*
(21:20:06) cron2: aaanyway.  just for the record, I've added OpenBSD 6.5 =
(recent release), NetBSD 8.1 (recent release), OpenIndiana (Solaris fork,=
 recent release) with working t_client tests yesterday
(21:20:21) cron2: there is still hope I can get my "really old" boxes bac=
k
(21:20:36) cron2: and then I'll clean up the intermediate stuff that does=
 not really serve a useful function anymore
(21:21:00) cron2: ("if we have OpenBSD 4.9 and 6.5, we do not need to run=
 the tests on 6.0 every time")
(21:21:35) cron2: mattock1: anything else you had in mind?  like, windows=
/mingw buildbot, or MSVC builder?
(21:22:10) mattock: I'm still tying some loose ends on these Ubuntu 18.04=
 and Fedora 30 buildslaves - stuff not visible to you, but internal PRs a=
nd such
(21:22:29) mattock: I have a "Windows buildslave" as well, but is not ful=
ly configured
(21:22:48) mattock: so the plan is:
(21:22:48) mattock: - tie in loose ends with current buildslaves
(21:22:48) mattock: - tap-windows6 test release
(21:22:48) mattock: - builder
(21:22:56) mattock: builder being the "Windows buildslave"
(21:23:05) cron2: looks good
(21:23:29) mattock: we recently got a new tap-windows6 building computer =
that actually has the signing dongle in it
(21:23:37) mattock: which simplifies the build/sign process quite a bit
(21:23:42) lev__: mattock1: is Windows slave with cygwin or VS?
(21:23:56) ***lev__ hopes for VS
(21:23:59) mattock: lev: it does not have anything at the moment, but I w=
ill setup Visual Studio
(21:24:06) mattock: because it is for tap-windows6 building primarily
(21:24:36) mattock: we can do away with Ubuntu 18.04 + openvpn-build for =
OpenVPN Windows installer builds
(21:24:49) mattock: as a non-EV authenticode cert is sufficient
(21:25:23) mattock: oh, so
(21:25:29) mattock: the Windows "slave" will just run openvpn-build
(21:25:51) mattock: in theory we could run buildbot on Windows, but nobod=
y has tried it
(21:26:12) cron2: you're the master of python :)  (but most likely it ass=
umes too much about "how to run things")
(21:26:48) mattock: it seems possible: https://mariadb.com/kb/en/library/=
buildbot-setup-buildbot-setup-for-windows/
(21:26:51) vpnHelper: Title: Buildbot Setup for Windows - MariaDB Knowled=
ge Base (at mariadb.com)
(21:28:12) mattock: I'm not sure if it assumes that the commands run in p=
owershell or cmd.exe - I hope the former
(21:28:15) mattock: or maybe it is configurable
(21:28:30) mattock: I think I could work on this with Lev, our Visual Stu=
dio guy :P
(21:28:49) mattock: but I think that would be the fourth step in my list
(21:29:01) ordex: thanks for debugging my iproute2 weirdness
(21:29:01) ordex: :D
(21:29:27) cron2: ordex: we didn't actually debug anything, just assign t=
he blame half on you and half on the linux kernel :)
(21:29:39) ordex: :D
(21:32:54) mattock: ok so where to next?
(21:33:30) mattock: t_net.sh thing debugging will continue, buildslave st=
atus updated, buildslave setup plans revealed...
(21:33:35) mattock: anything on 2.5?
(21:34:36) cron2: vlan patches have been reviewed once, the (supposedly) =
reworked new branch has been posted to the list, and patch 1/9 has been m=
erged \o/
(21:34:48) cron2: argv patches have been rebased, reworked, posted
(21:35:20) cron2: OpenSolaris tap mode has been repaired ("someone" broke=
 it at refactoring tun.c)
(21:35:39) cron2: the visual studio / wintun patches could need a bit of =
review...
(21:36:32) lev__: it is mostly wintun, only first one (of 7) is about VS
(21:37:29) lev__: it would be nice if someone could run openvpn-gui insta=
ller with wintun 0.7, I have been using it for a while already
(21:37:32) mattock: lev: I created an internal ticket about the Windows _=
buildbot_ buildslave
(21:37:41) mattock: you should have received a notification (OSS project)=

(21:37:58) lev__: yeah got it
(21:38:57) lev__: we could / should use VS2019 Community (after merging t=
he first patch from wintun series, it just updates project files to VS201=
9)
(21:41:23) mattock: I'll make a note of that
(21:41:32) mattock: (for Windows buildslave)
(21:43:02) mattock: 18 mins left - anything else?
(21:43:16) cron2: lev__: so will it then no longer work with older versio=
ns?  Or what does it do?
(21:46:08) lev__: cron2: it updates project files to use newer build tool=
set, which is included into VS2019=20
(21:46:30) dazo: and VS2019 is available as a community/free (no cost) ve=
rsion
(21:46:33) cron2: lev__: so if you do that, it breaks compilation with VS=
2016?
(21:46:48) cron2: the commit message for patch 1/7 is a bit funny
(21:46:58) cron2: it explains the whole patch series and all the fairy ta=
les about wintun...
(21:47:28) cron2: https://patchwork.openvpn.net/patch/824/
(21:47:29) vpnHelper: Title: [Openvpn-devel,1/7] Visual Studio: upgrade p=
roject files to VS2019 - Patchwork (at patchwork.openvpn.net)
(21:47:33) lev__: cron2: if you mean VS2015/2017 then yes, unless you ins=
tall VS2019 build toolset
(21:47:47) cron2: so what is the benefit of this patch?
(21:47:49) dazo: yeah .... I've talready rolled lev__ internally about 'g=
it format-patch --cover-letter' ....
(21:47:53) lev__: cron2: I was not aware about --cover-letter option
(21:48:00) dazo: I've already trolled*
(21:48:20) lev__: yes blame dazo because he didn't tell it to me earlier
(21:48:27) dazo: :-D
(21:48:37) cron2: my git format-patch doesn't have that option
(21:49:26) dazo: double check with git format-patch --help .... I think i=
t's missing mentioning in the man page
(21:49:33) cron2: anyway: so what is the *benefit* of bumping the version=
 to VS2019, if it has the drawback of breaking people's compile if they u=
se VS2016 today?
(21:49:42) cron2: better optimization?  it does not work with 2016 anyway=
?
(21:49:45) lev__: in fact, the commit message to the first patch could ju=
st be "upgrade project files to VS2019"
(21:50:13) lev__: cron2: there is no VS2016, it is either 2015 or 2017
(21:50:36) dazo: well, but will it break any of those?
(21:50:42) cron2: whatever "some earlier versions"
(21:51:45) lev__: yes, but I don't see it as an issue, you cannot easily =
download earlier versions nowadays (you need to create an MS account firs=
t for that)
(21:52:57) dazo: I would suggest we try to pull in this patch (it affects=
 only a well defined set of users) ... and if people complain, then we ne=
ed to consider what should be the VS requirements for OpenVPN
(21:53:14) cron2: for someone who has a working build environment today, =
breaking this with no clear benefits is "an issue".
(21:53:39) cron2: if have yet to hear why this patch is an improvement...=

(21:53:53) cron2: sorry for being so complicated, but this should be an e=
asy answer
(21:54:05) dazo: True ... but if they don't chime in on the patches to th=
e mailing list ... that's a silent approval in my view point
(21:54:24) lev__: well, we use 2019 in openvpn3 and I see no reason to ha=
ve both installations on my laptop
(21:54:31) cron2: does it not build at all with 2019?  is the optimizatio=
n better?  compatibility with Win10 2020?
(21:54:40) cron2: lev__: this is not the point
(21:54:48) cron2: *why* *is* *this* *change* *needed*?
(21:54:58) lev__: also when you open vs2017 project in vs2019 the first t=
hing you see is a dialog "do you want to upgrade"
(21:54:59) cron2: dazo: it does not work that way
(21:55:11) mattock: also, can't you keep the old project file around?
(21:55:22) dazo: lev__: let's flip it around ... if we don't pull in this=
 change ... what happens in the VS2019 environment?
(21:55:34) cron2: dazo: most patches enticit no response, and we still do=
 not merge them "someone would complain otherwise!"
(21:55:57) dazo: cron2: we still do have the 2 weeks lazy-ack policy ;-)
(21:56:14) mattock: we've been quite lazy in lazy-ACK'ing
(21:56:25) cron2: which we very very rarely excercise, especially not for=
 patches with unclear benefits and side-effects
(21:56:35) dazo: that's true
(21:56:48) lev__: dazo: it won't work if you have only newer build toolse=
t from 2019 unless you upgrade project files locally
(21:57:41) cron2: lev__: so it will just fail to build?  like a makefile =
calling "gcc-5" unconditionally, no matter which version is there?
(21:57:41) dazo: okay, so this is essentially some MS mess .... upgrade f=
rom prior versions, and everything works as expected.  Install a fresh VS=
2019 and things break.  Update the project files and only VS2019 environm=
ents works correctly
(21:57:47) dazo: is that correct, lev__ ?
(21:58:57) lev__: cron2: VS build files have build toolset hardcoded, if =
you open old project files with a new VS it will prompt you either to upg=
rade project files or install previous build toolset version
(22:00:05) lev__: dazo: yes, it is a bit differrent from autotools, since=
 compiler version (build toolset) is essentially hardcoded
(22:00:42) dazo: Now I'm beginning to lean towards not touching the proje=
ct files .... unless there is an obvious benefit for the OpenVPN project =
to enforce a specific toolset version
(22:00:55) dazo: enforce a newer specific version, I mean
(22:01:01) lev__: some other kernel tunnel driver uses VS2019=20
(22:01:34) lev__: I am surpised you guys care so much about visual studio=
 versions
(22:01:38) mattock: :)
(22:01:47) mattock: they're just concerned about users
(22:01:56) mattock: even Windows users are humans
(22:02:01) dazo: well, breaking other developers environment is important=
 to avoid
(22:02:37) cron2: we can document "to build 2.5, you need VS2019" and I t=
hink that would be fine (since it's freely available)
(22:02:43) cron2: lev__: can you downgrade?
(22:02:48) lev__: you can flip it other way and wait for "openvpn doesn't=
 work with VS2019" complains
(22:02:52) dazo: just like we care about stuff functioning on ancient AIX=
 and Solaris distributions .... we even have RHEL-6 defined as the oldest=
 supported Linux distro
(22:03:15) mattock: lev: that sounds reasonable to me
(22:03:41) dazo: so far we have been lacking this kind of "what is requir=
ed for building OpenVPN with VS" specification
(22:03:45) mattock: I _guess_ you could have multiple visual studios side=
 by side, but that's kind of crapy
(22:03:48) mattock: crappy
(22:03:59) lev__: cron2: you can edit project files manually, or rather i=
nstall vs2019 build toolset and use vs2017 IDE, if you wish=20
(22:04:08) dazo: mattock1: it's more about the build toolset being instal=
led, which defines the compiler versions
(22:04:40) mattock: dazo: oh yes
(22:04:56) mattock: 4 minutes overtime
(22:05:05) mattock: can we reach a conclusion today?
(22:05:31) dazo: I propose we define a specification for VS requirements,=
 and we stick to that
(22:05:33) cron2: just for the record, I do understand the patch now, it'=
s a mess, but I'm not opposing it - if VS2019 can be had freely, and earl=
ier versions not, it's a good argument
(22:05:43) cron2: dazo: yes
(22:05:43) lev__: I think before arguing that upgrading VS will break oth=
er developers setup, it makes more sense to make sure our commits do not =
break VS build
(22:06:19) lev__: (which should be fixed by windows buildbot)
(22:06:22) cron2: lev__: that's a bit of a knee-jerk reaction :-) - we do=
n't do this intentionally, VS is just too backwards
(22:07:20) dazo: lev__: for all we know, there might be enterprise develo=
pers being required to use VS2017 as part of their job ... but if it's ea=
sily solved to just install the build toolset from VS2019, then it's less=
 of a problem from my perspective
(22:07:47) dazo: but that doesn't escape that we are essentially missing =
a specification for minimum VS requirements building openvpn
(22:08:07) cron2: do we have build instructions somewhere?
(22:08:15) lev__: how deep back in time we should go
(22:08:25) lev__: I started with VS 5.0
(22:08:39) lev__: cron2: no, I should probably fix that
(22:08:44) dazo: lev__: what is officially supported by Microsoft today?
(22:08:55) dazo: (within normal support contracts)
(22:08:58) lev__: at the moment you can just run build.bat from openvpn-b=
uild to build everything
(22:09:16) cron2: I think that would be a good outcome - we have a Trac d=
ocument that explains how to build with VS, we merge the patch, and we ge=
t a VS buildslave :-)
(22:09:24) lev__: but using VS for development requires some work, OTOH y=
ou just do it once
(22:09:38) lev__: sounds like a plan
(22:10:02) cron2: mattock1: on "3. do something about these repos" - I th=
ink that's all yours, innit?
(22:11:10) mattock: cron2: I did not understand a word
(22:11:13) mattock: please explain :)
(22:12:05) lev__: btw I think I understand your point about minimal versi=
on - in Linux you sometimes stuck with certain compiler version which is =
part of OS and bumping it without reason sounds wrong and will likely bre=
ak many setups
(22:12:09) cron2: mattock1: item "3" on the agenda
(22:12:40) dazo: lev__: yes, exactly
(22:12:50) lev__: but I don't think it applies in windows, you can just i=
nstall newest VS or just build toolset on (almost) any Windows version
(22:12:51) mattock: ah
(22:14:26) mattock: so "Update, or something, these repos" means what?
(22:14:35) mattock: I assume there is a problem there?
(22:14:36) dazo: lev__: the difference is essentially how packages/softwa=
re is distributed ... Linux distros, it's the distro who packages and dis=
tributes the software.  In Windows, there is no such thing as a "software=
 repository" (well, except Windows Store, or such like)
(22:14:39) cron2: update, hide, burn with fire :)
(22:14:58) cron2: mattock1: I did not put it on the agenda, but it implie=
s "these are stale".  Is that a possibility?
(22:15:30) mattock: they're not no more stale than our OpenVPN 2.x releas=
es
(22:15:59) dazo: It's wiscii/tincantech who added that topic ... don't se=
e him here though
(22:16:02) cron2: tincantec/wiscii added that
(22:16:04) cron2: yeah
(22:16:19) mattock: ok, no point in discussing this
(22:16:28) mattock: afaik they work perfectly and have the latest package=
s
(22:16:39) cron2: okay, item closed :)
(22:16:41) mattock: I have not received any complaints about them from an=
yone
(22:17:08) mattock: so do we go with cron2's suggestion, i.e.
(22:17:08) mattock: - Have a Trac document that explains how to build wit=
h VS
(22:17:08) mattock: - Merge the patch
(22:17:08) mattock: - Get a VS buildslave
(22:17:09) lev__: dazo: in fact windows has apt-like repo, chocolatey
(22:17:20) mattock: yes, I use that with Puppet
(22:17:20) ***lev__ drops the ball to mattock1 and runs
(22:17:22) mattock: and manually
(22:17:25) dazo: lev__: well, but the Windows OS isn't distributed via th=
at channel ;-)
(22:17:50) dazo: it's basically a "random" community repository
(22:18:22) cron2: I'm out... need to take a break, ahve a network change =
in 40 minutes... *wave*
(22:18:31) dazo: c'ya!
(22:18:33) mattock: yes, let's kill this meeting
(22:18:35) ***dazo need to go too
(22:18:41) mattock: yes, 22:18 here

--------------3211C15FD81D18136F22322E--

--covMc29Lnz5T5Kcscaj1th9F0AjNyDD1t--

--NksUzfXxxcQzp3zH8JcQDfO4hmK0fEwys
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl2fhWwACgkQKVhNn0CG
RXh0iwgApjX3FbKG1x0sfDgLzWr18pM/aXgFCz99OlTYOCFa6S4clFRzZ9IGp59J
HpzHJu7FCIQ7zPSvjJB2bV+ddIZ+5vNGxduzxCG25YV9RsZelc3ED6A5mJNoWnIn
Fzcq/+86Tft2AbJSxT+K7ySag13m2hB7JPRqsCzjXHHGtuKCRJUzqCkSMns/xhqp
X1Bb1HIzfPv7vfokSNtElzZyV979KZSbYWOFM6mgJ5D5optCSliWu/tK8DrXzzHZ
989ckSTgq53hQsSYLj8bylgj7/dOgw3G7NQrXrNyixXtkkzNoyQes9Jhx484zkWQ
JtH77Goaaa6972b9L60itOr5SjLw9w==
=Ely+
-----END PGP SIGNATURE-----

--NksUzfXxxcQzp3zH8JcQDfO4hmK0fEwys--

