From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <2f63122a-e9b6-85d6-c81c-a28bf32b83be@...515...>
Message-ID: <408306f8-6100-9e42-a353-67647ee43abb@...515...>
Date: Wed, 1 Nov 2017 14:55:41 +0200
MIME-Version: 1.0
In-Reply-To: <2f63122a-e9b6-85d6-c81c-a28bf32b83be@...515...>
Content-Type: multipart/mixed; boundary="------------4279914A5D6BF533B3997241"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (Wed, 1st Nov 2017)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------4279914A5D6BF533B3997241
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable



Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 1st Nov 2017
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2017-11-01>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock, ordex, plaisthos and syzzer participated in this
meeting.

--

Discussed how to make testing of unmerged patches easier. While pushing
the patches through buildbot would be optimal, buildslaves run with root
privileges. Hence this approach would be limited to trusted developers.

It was thus decided to tackle this problem with Vagrant, which has base
boxes for all/most operating systems we have in buildbot:

<https://app.vagrantup.com/boxes/search>

The benefit with Vagrant is that anyone, including untrusted developers,
will be able to use it for testing their patches on other, possibly
esoteric, platforms.

We will start by providing a proof-of-concept Vagrantfile that sets up
OpenVPN build environments on a couple of operating systems, then build
on top of that work. Mattock will try to have the PoC ready by the
hackathon (i.e. late next week).

At this point it also makes sense to take a second look at the existing
Vagrant pull request in here:

<https://github.com/OpenVPN/openvpn/pull/45>

It got stuck primarily due to a few bashisms.

--

Discussed our "oldstable" support policy. It was agreed that we do _not_
want to support "oldstable" and "stable" until "stable+1" is released.
Or, in other words, support two stable releases at all times.

We will work on defining an EOL policy for future releases on this page:

<https://community.openvpn.net/openvpn/wiki/SupportedVersions>

It was agreed that 2.3.19 will be the last 2.3 release for which we will
build Windows installers and Debian packages. Subsequent releases of 2.3
will be source-only, and at some point support for 2.3 will be dropped
altogether. Source-only release means that we will provide signed
tarballs but no installers/packages.

That said, if particularly nasty security issues arise we will consider
providing updated installers and packages even for source-only releases.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



--------------4279914A5D6BF533B3997241
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2017-11-01.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2017-11-01.txt"

(12:28:07) mattock: meeting in 2 minutes
(12:28:17) dazo: good morning :)
(12:28:27) mattock: afternoon :)
(12:28:33) ordex: :D
(12:28:33) mattock: literally
(12:28:39) cron2: mattock: which time zone are you in, right now?
(12:28:43) cron2: UTC+2?
(12:30:30) syzzer: morning :)
(12:30:56) cron2: train connections from munich to karlsruhe suck
(12:31:21) mattock: let's begin
(12:31:36) ordex: sure
(12:31:45) cron2: go!
(12:32:13) dazo ha scelto come argomento: Meeting 2017-11-01 11:30 CET: A=
genda at https://community.openvpn.net/openvpn/wiki/Topics-2017-11-01
(12:32:26) mattock: ah, good
(12:32:33) mattock: topic #1
(12:32:58) mattock: "Test branches on github, targeting buildslaves"
(12:33:09) cron2: here's a recap of the problem statement: "someone who i=
s not me is working on something that might break strange platforms, how =
to test for it?"
(12:33:34) syzzer: yes plz!
(12:33:35) cron2: (I can just log into my buildslaves and test :-) - but =
maybe we can use buildbot to do it)
(12:33:35) mattock: buildbot is definitely the best candidate
(12:33:35) dazo: just thinking aloud ... is it possible to have a host a =
tarball can be pushed to, which gets configured and built by the buildsla=
ves?
(12:34:00) mattock: dazo: possibly
(12:34:13) mattock: another option would an "experimental" branch where w=
e would just rewrite history as we please
(12:34:19) cron2: another idea that came to me just now is "I could open =
up the buildslaves to trusted users" (because in the end it does not matt=
er if I give you build access, or buildbot can run things as root that yo=
u put into a tarball)
(12:34:20) dazo: that would probably be easier to manage than "everyone" =
can push to this git repo
(12:34:34) ordex: pushing a tarball or a branch sounds similar. the quest=
ion is: how often can we do this? and can everybody do that unconditional=
ly?
(12:34:57) ordex: or we want to limit one person to be able to push the t=
arball ?
(12:34:58) cron2: ordex: most definitely not "everybody"
(12:35:03) mattock: ordex: only those we trust, because otherwise people =
could make buildbot do pretty much anything
(12:35:16) dazo: I was thinking along the lines of ssh/sftp ... where onl=
y trusted and vetted users gets access
(12:35:25) dazo: (typically us core developers)
(12:35:34) ordex: yep that is reasonable. that can be done on git hub, no=
? maybe with a new repo where only few people have access
(12:35:37) cron2: since the t_client tests run the freshly built openvpn =
executable with sudo, this is full system compromise :-)
(12:35:45) ordex: eheh
(12:35:54) syzzer: how flexible is buildbot? Isn't it better to just e.g.=
 let is build the "buildbot" branch of maintainer's private gh repos?
(12:36:07) ordex: +1
(12:36:13) mattock: it is very flexible
(12:36:14) syzzer: that would not clutter the core repo
(12:36:18) ordex: maybe once a day is there is something new
(12:36:19) dazo: agreed
(12:36:23) ordex: *if
(12:36:39) mattock: as long as these special builds are triggered manuall=
y having additional repositories configured should be fine=20
(12:36:40) cron2: once per day is too slow if you've just found out that =
you broke NetBSD, FreeBSD *and* OpenBSD, and want to test fixes
(12:36:47) dazo: +1
(12:36:57) cron2: mattock: ah, good.  I thought you are limited to "one r=
epo, but can select branches"
(12:37:06) ordex: cron2: how long does a full run take?
(12:37:19) mattock: no, I don't think so, buildbot is just Python so we c=
an do pretty much anything we want
(12:37:19) cron2: ~20 minutes if you build all variants
(12:37:30) mattock: in the worst case setup a second buildmaster instance=
 to a different port
(12:37:30) ordex: if it takes not too long..then we could do it upon ever=
y push, like travis
(12:37:37) cron2: ordex: if you just want the "default options, t_client"=
 test, maybe 5 minutes
(12:37:51) ordex: ah quite fast
(12:37:53) dazo: ordex: that's what we do now ... but only cron2 and I ha=
ve commit/push privileges
(12:38:07) ordex: dazo: yup, and extending that with syzzer's idea seems =
quite good already, no?
(12:38:16) cron2: ordex: CPU *does* cost money, though...  so on a develo=
pment repo which gets hacked on a lot, maybe not automatic on every push
(12:38:49) ordex: cron2: knowing that branch X is only for buildbot it's =
up to the dev responsibility to not abuse, I think (?)
(12:39:09) mattock: ordex: +1
(12:39:12) cron2: ordex: if you do it by branch, that would be similar to=
 "manual start", right
(12:39:33) ordex: cron2: otherwise a hourly cronjob can check and build t=
he special branches .. if this is better than "upon every push"
(12:39:51) ordex: but i think build on push is ok as soon as this is done=
 responsibly
(12:40:25) cron2: right (if I get a heavy bill, I'll forward this on...) =
:-)
(12:40:31) ordex: eheh
(12:40:33) dazo: but that branch can be quite ugly .... merge conflicts e=
tc, etc=20
(12:40:50) dazo: (if it is a shared branch, that is)
(12:40:51) ordex: dazo: it's your own private branch, you can just reset/=
rebase it every time
(12:40:55) cron2: my mental picture has a throwaway branch per user
(12:40:58) dazo: ahh, okay
(12:41:12) ordex: dazo: syzzer's idea was to have 1 branch per dev, in ou=
r own openvpn fork
(12:41:22) cron2: so either "github.com/dazo/openvpn" with branch "buildt=
est", or "github.com/openvpn" with branch "dazo-buildtest", or whatever
(12:41:28) ordex: right
(12:41:40) cron2: single-user branches
(12:41:46) cron2: (effectively)
(12:41:49) ordex: either one would work. probably the private fork is eas=
ier to handle from the permission perspective
(12:41:52) plaisthos: or add a private extra repo for that
(12:42:03) plaisthos: that only a special group in github is allowed to p=
ush to
(12:42:10) dazo: alright ... that can work .... I think assigning our pri=
vate/user repos is better than a shared branch in the main openvpn repo t=
hough
(12:42:20) mattock: as a sidenote: we're going to be setting up an OpenVP=
N test server environment internally similar to t_client, and it will use=
 Vagrant as well as a more long-running test instance
(12:42:20) ordex: yeah that too. but we have to tell buildbot each branch=
 to build, so I guess telling it where the private branches are is easier=

(12:42:27) cron2: however it can be done without too much friction...
(12:42:29) dazo: less chance of clutter if github explodes in badness
(12:42:34) ordex: yeah
(12:42:36) ordex: :D
(12:42:46) mattock: I did a quick check on which (virtualbox) boxes Vagra=
nt has and there are plenty: https://app.vagrantup.com/boxes/search
(12:42:47) vpnHelper: Title: Discover Vagrant Boxes - Vagrant Cloud (at a=
pp.vagrantup.com)
(12:42:59) mattock: freebsd, openbsd, solaris and probably all linuxes yo=
u can imagine
(12:43:25) mattock: the benefit with a Vagrant-based approach is that we =
don't have to trust any developer at all
(12:43:32) cron2: interesting
(12:43:37) dazo: oh ... on the test server side .... I've recently gotten=
 allocated (for free) 2 VMs with Power8 running latest Fedora ... one in =
little-endian mode and the other one in big-endian
(12:43:43) mattock: giving anyone the possibility to test their code, not=
 just us core devs
(12:43:59) mattock: ...on "funky" platforms I mean
(12:44:15) cron2: mattock: true.  Could you get us feedback how the deplo=
yment works, and how expensive it is, per "make test" run?
(12:44:23) dazo: mattock: nah, even with vagrant you expose network and C=
PU to "unknown" users
(12:44:35) cron2: dazo: well, the point is that "the unknown user" runs v=
agrant *himself*
(12:44:46) mattock: dazo: I'm talking about the unknown users running the=
 tests themselves
(12:44:50) mattock: exactly
(12:44:57) dazo: ahh, right ... okay, that's safer :)
(12:45:00) cron2: like, ordex wants to test on FreeBSD, so he fires up va=
grant instances...
(12:45:02) mattock: we're not exposing anything to unknown people :)
(12:45:10) dazo: good! :)
(12:45:29) cron2: what worries me a bit is that this will create quite a =
bit of support overhead ("what do I need to do to a FreeBSD build to make=
 openvpn build and run t_client?")
(12:45:46) mattock: the cost would mostly be memory and CPU at their end,=
 if they want to run a full test suite similar to buildbot
(12:45:47) cron2: so, happy to hear about your experiences, mattock :)
(12:46:10) mattock: that won't be a problem
(12:46:14) mattock: so this is how Vagrant works
(12:46:26) mattock: it takes a base box (e.g. debian, openbsd)
(12:46:39) mattock: it creates a virtual machine based on that box (=3Dvm=
 image)
(12:46:58) mattock: it then "provisions" the box using scripts, ansible, =
puppet or whatnot
(12:47:01) mattock: generally scripts
(12:47:14) mattock: so the provisioning part would be used to ensure that=
 OpenVPN builds on that particular box
(12:47:36) cron2: so, guess who gets to maintain these provisioning scrip=
ts for FreeBSD, NetBSD, OpenBSD, OpenSolaris, AIX, ...? :-)
(12:47:52) mattock: from user perspective the process would be
(12:47:52) mattock: - vagrant up openbsd-<something>
(12:47:52) mattock: - vagrant ssh openvpn-<something>
(12:47:57) mattock: then just build for that platform
(12:48:14) mattock: cron2: cron2?
(12:48:18) mattock: :P
(12:48:24) ordex: cron=C2=B2
(12:48:33) cron2: which brings me back to "what worries me a bit is that =
this will create quite a bit of support overhead" :-)
(12:49:07) mattock: we do have a t_client + vagrant PR open on GitHub whi=
ch has been lying there
(12:49:15) cron2: but it's certainly worth having a close look, also to s=
ee how fast the spinup/spindown of these VMs is - like, can you afford th=
is for a general "make test" run?
(12:49:18) mattock: primarily due to it having bashisms
(12:49:41) mattock: cron2: you can provision the VMs once and then just s=
hut them down
(12:49:48) mattock: bringing them up again cheap
(12:49:54) ordex: mattock: but we can assume vagrant will run on a refere=
nce linux platform
(12:49:59) mattock: although the full cycle is not very heavy
(12:50:14) mattock: a couple of minutes of VM setup
(12:50:18) mattock: per VM
(12:50:25) cron2: sounds good
(12:50:33) cron2: so... which way do we want to go?
(12:50:38) mattock: I think that from scratch one could run the full test=
 suite in <30 minutes
(12:50:57) ordex: mattock: why 2 minutes to setup? it installs everything=
 from scratch every time? there are no tVM snapshots?
(12:51:30) mattock: no, the base box is a VM image, but there's some over=
head when creating the VM into e.g. virtualbox
(12:51:35) mattock: plus running the provisioning steps
(12:51:41) ordex: mh ok
(12:51:52) mattock: base box is assumed to be usable as-is
(12:52:00) ordex: usually kvm takes 3 to 5 seconds to boot from bootloade=
r to login
(12:52:02) mattock: but the provisioning step is what makes it special
(12:52:07) ordex: I see
(12:52:08) mattock: yeah, to boot
(12:52:18) mattock: but this is about creating the VMs from a base VM ima=
ge
(12:52:28) plaisthos: basically private travis :)
(12:52:28) mattock: but you don't need to destroy the Vagrant-created VM =
unless you want to
(12:52:36) syzzer: heh, some colleague just walked by towards lunch, noti=
ced the Vagrant web page on my screen and started ranting :')
(12:52:36) ordex: understood
(12:52:43) ordex: lol
(12:53:11) syzzer: have to poke him later to figure out why he doesn't li=
ke it
(12:53:19) dazo: ordex: for recent Linux distros (often systemd based) 3-=
5 seconds are right .... older and sys-v based approaches generally takes=
 far longer
(12:53:26) mattock: syzzer: I could also rant about it, but for this purp=
ose it would probably be a good solution
(12:53:26) ordex: by the way, I think we should plan a short-term and a l=
ong term solution at this point?
(12:53:28) syzzer: he's a docker guy though, so is likely to call "just u=
se docker!"
(12:53:29) ***cron2 needs a bigger disk, more RAM, and more CPU :-)
(12:53:34) ordex: :D
(12:53:38) ordex: cron=C2=B3
(12:53:43) mattock: syzzer: how would we docker openbsd and solaris? :P
(12:54:13) plaisthos: solaris has zones and whatever for ages
(12:54:16) syzzer: I dunno, I try to avoid the whole container mess :-p
(12:54:19) plaisthos: but linux reinvted the wheel
(12:54:22) mattock: anyways, I think we should do a PoC of Vagrant
(12:54:25) dazo: syzzer: docker works fine if you're just going to do bui=
lds on the same OS you're running locally .... but can't "boot" *bsd in a=
 docker container on Linux :)
(12:54:26) cron2: +1
(12:54:38) plaisthos: also jails on bsd
(12:54:41) mattock: do we want just compile tests right now?
(12:54:54) dazo: I think compile tests is a good starting point
(12:55:02) cron2: well, compile test and local "make check" is a good sta=
rting point for general explosions
(12:55:05) cron2: then, t_client
(12:55:10) syzzer: yeah, that, "baby steps"
(12:55:30) cron2: (which obviously need some sort of defined process how =
you get t_client credentials and what to do or not to do with them)
(12:55:32) dazo: but ... mattock, correct me if I'm wrong .... with vagra=
nt we can spin up more VMs at the same time?  one could be a VPN server?
(12:55:35) mattock: do we want the compile tests to be automatic when the=
 VMs are brought up/provisioned?
(12:55:41) mattock: dazo: yes
(12:55:46) mattock: the PR on GitHub actually does that
(12:55:54) cron2: dazo: indeed, good point
(12:56:13) mattock: so we could start by setting up the "t_client clients=
" without the server
(12:56:15) mattock: for compile tests
(12:56:27) cron2: nevertheless, let's start small -> compile, local test.=
  Then refine for network tests.
(12:56:29) mattock: then later create t_client server(s) as separate VMs
(12:57:08) dazo: so ... first, get a vagrant setup to automatically compi=
le a tarball or git checkout or whatever .... then spin off another vm an=
d run connectivity tests.  That "another vm" can be the smallest image of=
 any distro possible with a pre-installed VPN server binary
(12:57:30) dazo: or it can be the same base image, with the built binary =
copied over
(12:57:57) dazo: (both cases are relevant ... depending on what code path=
s you changed ... hard to debug issues if both sides changes)
(12:58:03) ordex: shouldn't we test the server on different platforms too=
? :S
(12:58:04) cron2: remind me to add a 2.3 server to my mix :)
(12:58:32) mattock: ordex: we should, but that would get complex quite fa=
st :)
(12:58:33) cron2: ordex: if it compiles and local "make check" passes, us=
ually server side is good as well
(12:58:36) dazo: ordex: well, true .... but server/client is essentially =
just a matter of "use this config" :)
(12:58:46) ordex: eheh okok
(12:59:09) cron2: there's a few tricky things with tap and installing rou=
tes and that, so when you start breaking all this, you want servers on al=
l platforms, right
(12:59:13) ordex: was wondering about codepaths that are crossed only in =
server mode and that might be platform dependent. but this can be the ver=
y last concern
(12:59:44) dazo: yeah
(12:59:56) dazo: first .... compile/build images :)
(13:00:03) ordex: so, we skip the buildbot-branch idea at all and wait fo=
r vagrant directly?
(13:00:08) mattock: I think so
(13:00:20) syzzer: cron2: just created a reminder for you ;-)
(13:00:25) ordex: ok
(13:00:34) cron2: syzzer: what, where?
(13:00:38) syzzer: https://community.openvpn.net/openvpn/ticket/954
(13:00:41) cron2: ah
(13:00:43) vpnHelper: Title: #954 (Add a 2.3 server to the t_client test =
setup) =E2=80=93 OpenVPN Community (at community.openvpn.net)
(13:00:54) cron2: thanks :)
(13:01:16) dazo: yeah, makes sense
(13:01:32) cron2: anyway, if one of you urgently wants to test something =
on one of the more strange platforms, feel free to send me a ssh pubkey a=
nd a source ip (range) where you connect from, and I'll get accounts done=
 on my *BSD zoo
(13:01:34) syzzer: ok, so I think we have a plan for the coming week(s) ?=

(13:01:36) ordex: ok, so topic #1 is addressed with vagrant
(13:01:39) cron2: yep
(13:01:47) mattock: yes
(13:01:58) mattock: #2 Revisit our support policy for "oldstable"
(13:02:02) ordex: mattock: this will take ~2 weeks ?
(13:02:05) ordex: just to have a rough idea
(13:02:07) cron2: plaisthos: can you bring an image of your MacOS X build=
bot with you to Karlsruhe?
(13:02:09) ordex: also for the Inc side
(13:02:27) mattock: I think I can get a PoC done by hackathon
(13:02:35) ordex: cool
(13:02:49) mattock: I use Vagrant quite a bit, so it's mostly about "what=
 has the priority"
(13:02:57) ordex: goed
(13:03:23) ordex: on the Inc side we really need to get the dev-test box =
started because we are throwing untested builds to users
(13:03:25) mattock: so #2: do we always want to support two releases ("ol=
dstable" and "stable") at the same time
(13:03:30) ordex: scratch that from the log
(13:03:31) ordex: :D
(13:03:33) cron2: orex: *roll eyes*
(13:03:35) plaisthos: cron2: could do but it is not really a good image t=
o start with nowadays since there is too much other stuff on the box
(13:04:02) ordex: not untested, but not as tested as I'd like them to be
(13:04:23) cron2: plaisthos: mmmh.  I wonder how to make a nice OSX test =
VM...  (without running vmware on $wife's mac mini)
(13:04:44) cron2: mattock: easy answer - "no", only for a limited time
(13:04:46) plaisthos: cron2: what is your virtualisation tech?
(13:04:48) cron2: as we did with 2.2 + 2.3
(13:04:53) syzzer: re #2: let's create a wiki page where we announce what=
 we support and until when
(13:05:04) cron2: plaisthos: ESX, but I need to make an exception for OSX=
 :)
(13:05:08) syzzer: dates are easier than "4 dot-releases"
(13:05:13) mattock: cron2: at what point did we stop supporting 2.2? what=
 2.3.x release was that?
(13:05:30) mattock: I'm just wondering because we're at 2.3.18 now :P
(13:05:30) plaisthos: cron2: you can patch esx to allow os x but that is =
probably not your pick of poison
(13:05:39) mattock: and 2.4.4
(13:05:40) cron2: mattock: it was sort of "we never officially stopped su=
pporting it, we just didn't feel the need to do more releases"
(13:05:43) plaisthos: cron2: I can also give you a shell on my machine
(13:05:54) cron2: like, if there are no features and no bug fixes, why do=
 a release?
(13:06:03) cron2: plaisthos: that would be nice
(13:06:06) plaisthos: cron2: if you have a *Intel* KVM machine os x is re=
latively to setup
(13:06:22) dazo: ordex: mattock: can we look into getting a public osx im=
age accessible for the community?=20
(13:06:45) ordex: dazo: mhhh accessible in what sense ?
(13:06:57) dazo: like a buildslave=20
(13:07:11) ordex: ah like the one we use for jenkins
(13:07:14) ordex: well, it's just a vm
(13:07:15) dazo: yeah
(13:07:19) ordex: we run it on ESXI
(13:07:20) syzzer: dazo: travis does osx builds (but not tests)
(13:07:20) dazo: something which cron2 can poke at :-P
(13:07:42) syzzer: but, focus, oldstable support
(13:07:44) cron2: ordex: OSX on ESXI?  How?
(13:07:51) dazo: syzzer: right, I think it's the t_client.sh which is rel=
evant in this round :)
(13:07:53) cron2: syzzer: so boring
(13:07:57) syzzer: :p
(13:08:08) ordex: cron2: dunno. as far as I know that's the only VM tech =
supported by apple
(13:08:12) ordex: it's a VMWare thing
(13:08:17) ordex: but I don't know much more than that
(13:08:19) ordex: I did not set it up
(13:08:22) cron2: orex: actually it's *not* supported
(13:08:33) cron2: ESX refuses to boot OSX unless you modify *ESX*
(13:08:47) cron2: now, vmware *on apple hardware* (or maybe ESX *on apple=
 hardware*) is fully supported...
(13:08:59) mattock: syzzer: I don't see focus
(13:09:00) mattock: :P
(13:09:05) mattock: except on MacOS X
(13:09:09) syzzer: mattock: no, I tried...
(13:09:09) dazo: all I know is that we said: "Andrew, we need an osx jenk=
ins slave, can you fix it?" ... and got "here it is!"
(13:09:11) ordex: cron2: no clue honestly. I should check where we run es=
xi
(13:09:24) cron2: wrt oldstable: my gut feeling is "at some point, we'll =
see no security-relevant updates anymore, so there is no real *need* to d=
o releases anymore"
(13:09:38) mattock: so a follow-up question
(13:09:40) dazo: compare it to v2.2
(13:10:00) mattock: could we just decide that at some point we move to "s=
ource-only" releases for "oldstable"
(13:10:12) dazo: But we've slowed down v2.3 stuff to basically a minimum =
nowdays, haven't we?
(13:10:15) cron2: dazo: that's what I did :-) - we never made a conscious=
 decision to "this is now unsupported", we just stopped making releases (=
and a year later, decided "source-only is good enough")
(13:10:24) cron2: (that comment was about 2.2)
(13:10:32) dazo: yeah :)
(13:10:45) mattock: it seems that we're getting security fixes quite freq=
uently nowadays, unlike during 2.2/2.3 phase
(13:10:46) cron2: well, 2.3 has been a bit unusual this year because peop=
le kept finding nasty security relevant bugs
(13:10:51) mattock: yeah
(13:10:51) cron2: this
(13:11:22) dazo: yeah, we've not had any year ever before with this amoun=
t of CVEs flowing in ... so this have been a spectacular year
(13:11:50) cron2: so, anyway, this is my suggestion - unless something co=
mes up that "we think we need a release", just put it into maintenance mo=
de and that's it
(13:11:50) dazo: and in that context, what we've done with v2.3 have been=
 relevant ... as there are still users depending on that for various reas=
ons
(13:11:58) dazo: cron2++
(13:11:58) syzzer: so, can we settle on something like "once a stable bec=
omes oldstable, it will receive at least 6 months of full releases and 18=
 months of source releases" ?
(13:12:22) plaisthos: for critical bugs/security fixes
(13:12:24) plaisthos: only
(13:12:24) ***cron2 doesn't feel good about making strict timelines when =
we have no idea how 2.4/2.5 will look like
(13:12:26) mattock: source-only would primarily affect Windows users and =
our apt repo users (who would have to move to "stable" or rebuild "oldsta=
ble" with the fixes)
(13:12:51) dazo: cron2++ (again)
(13:13:01) plaisthos: source only means "not for general use" anyway
(13:13:10) cron2: but yeah, if we want to make a statement, I could live =
with what syzzer suggested - "that's what we already did anyway" :)
(13:13:25) dazo: if those time lines are relative to the latest stable re=
lease (like a future v2.5), these time lines are reasonable
(13:13:43) mattock: plaisthos: agreed, except that package maintainers wo=
uld not feel any difference
(13:14:02) mattock: dazo: that was my idea
(13:14:19) dazo: due to our not too frequent major releases, I think it s=
hould be 12/24 months ... but that's just my opinion
(13:14:20) mattock: so "after 2.5.0 we will provide <n> months of 2.4.x r=
eleases"
(13:14:25) syzzer: it's why I say "at least" in the statement; we promise=
 to do that and might decide to do more.  At least it gives users an idea=
 about the timelines for their upgrade paths
(13:14:32) plaisthos: most package mainter will also not stick to old ver=
sions that long
(13:14:40) dazo: ahh, good point syzzer=20
(13:14:42) cron2: syzzer: yeah, I think that is workable
(13:14:48) cron2: (I was a bit confused initially)
(13:15:07) plaisthos: source only is like "we patch it for you so you don=
't screw up when trying to backport the patch yourself"
(13:15:16) dazo: yeah
(13:15:29) dazo: but source-only .... do we provide tarballs (but no bina=
ries) ... or git only?
(13:15:44) mattock: dazo: good question
(13:15:48) ordex: mah github provides tarball as well..we can stick to gi=
t
(13:16:00) cron2: if we do a *release*, with a number, a git tag, etc., w=
e should provide tarballs
(13:16:00) mattock: I tend to agree
(13:16:15) dazo: yeah, I'm leaning towards what cron2 says
(13:16:23) mattock: I'm not opposed to tarballs because releasing those i=
s trivial
(13:16:30) syzzer: cron2++, running 'make dist' is an acceptible amount o=
f work, right/
(13:16:33) ordex: but github provides the tarballs for each release too, =
no? without the need for us to do anything other than signing commits and=
 tags
(13:16:46) ordex: unless our tarball provides something more
(13:16:51) syzzer: (at leat for -NL, most of the release work is in the d=
istro repos and windows installers)
(13:16:52) plaisthos: ordex: it does
(13:16:57) dazo: ordex: signed tarballs ;-)
(13:16:58) plaisthos: ordex: e.g. a configure script
(13:17:02) mattock: syzzer: same at my end
(13:17:09) ordex: oky
(13:17:43) mattock: 2.3 has quite a bit of "legacy" stuff in it so moving=
 it to "source-only" mode would be nice
(13:17:45) dazo: but yeah, 'make dist' is bootstrapped tarballs
(13:17:50) syzzer: ordex: 'make dist' generates tne configure script, so =
users don't need autoconf to build the release
(13:17:55) mattock: old openvpnserv.exe, WinXP (i.e. tap-windows), etc.
(13:17:59) ordex: oky
(13:18:43) ordex: so 'make dist' sounds like a good compromise ?
(13:18:46) dazo: Shall we agree that the next v2.3 release (whenever that=
 happens) will be the very last binary release?
(13:18:53) mattock: I sure can :P
(13:18:59) ordex: :D
(13:19:07) syzzer: dazo: that was what I was about to say
(13:19:12) dazo: and we just do tarball releases for 2.3 following that=20
(13:19:12) ordex: sounds good
(13:19:17) ordex: let's just announce that clearly
(13:19:28) dazo: yeah
(13:19:40) cron2: I would tie that to "... unless a major security issue =
pops up", but I think we've had our share of that... source code reviews,=
 fuzzer, ...
(13:20:20) ordex: yeah, but i don't think we need to write that in the an=
nouncement (?). if that happens, we just release the binary and say it wa=
s exceptional
(13:20:34) ordex: exceptionally buggy :P
(13:20:35) mattock: one of the problems with providing (windows) binaries=
 is that we also need to keep dependencies (e.g. openssl) updated
(13:20:36) dazo: cron2: hence "after the next release" ... at some point =
we need to stop caring that much .... v2.4 have been out for about 11 mon=
ths or so now
(13:20:56) mattock: so if we move 2.3 to source-only, we no longer have t=
o worry about OpenSSL vulnarabilities in 2.3 installers
(13:21:12) dazo: oh, true
(13:21:20) dazo: the bundled dependency hell
(13:21:23) mattock: yeah
(13:21:42) mattock: oh, and NSIS also
(13:22:47) ordex: ok. so one more and then source (except excptions)?
(13:22:57) ordex: $somebody will write an email?
(13:22:57) mattock: yes
(13:22:58) dazo: regarding NSIS ... do we have a plan to move towards MSI=
 installers?  any planned eta on that?
(13:23:06) mattock: dazo: we have a plan, but no resources
(13:23:23) mattock: I think I would have to at least bootstrap that proje=
ct, but as you know, "stuff keeps coming up"
(13:23:34) mattock: so prioritization, prioritization...
(13:23:43) dazo: yeah, and we probably could need more community help too=

(13:23:51) mattock: if we get a reasonable MSI installer out we can proba=
bly expect contributions
(13:24:06) mattock: or rather, quite likely
(13:24:24) mattock: chipitsine would help, and the chocolatey package mai=
ntainer actually brought the MSI thing up in the first place
(13:24:28) mattock: before the NSIS security issue
(13:25:07) mattock: it will probably be a couple of days of work to creat=
e an installer that works
(13:25:46) mattock: do we want to define a "end of life" policy for oldst=
able now?
(13:26:03) dazo: I'm all for tossing that challenge to someone who's not =
so heavily involved ... and we'll see what happens and review that
(13:26:25) mattock: dazo: we can try definitely
(13:28:01) mattock: I can start probing for potential MSI guys
(13:28:08) dazo: I can start a wiki page with a proposal for the life cyc=
le policy ... and then we can discuss that next meeting
(13:28:17) mattock: sounds good
(13:28:28) mattock: maybe send email to openvpn-devel once the initial pa=
ge is up?
(13:28:30) syzzer: dazo: just made a start here: https://community.openvp=
n.net/openvpn/wiki/SupportedVersions
(13:28:31) vpnHelper: Title: SupportedVersions =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(13:29:00) syzzer: very course, tried to write down what I think is our c=
urrent support status
(13:29:02) dazo: syzzer: thx!  I can work a bit more on that, this is a g=
ood starting point
(13:30:01) syzzer: MSI is supposed to be very easy (according to $colleag=
ue)
(13:30:04) dazo: so we're hitting the 1 hour mark now :)
(13:30:18) syzzer: and because I'll need to get -NL over too, I'm willing=
 to help out a bit there too
(13:30:23) dazo: cool!
(13:30:25) mattock: syzzer: he's probably right, especially if one knows =
MSI beforehand :P
(13:30:38) mattock: syzzer: \o/
(13:30:42) syzzer: anyway, time for lunch?
(13:30:47) mattock: sounds good to me
(13:30:50) dazo: +1
(13:31:07) mattock: I will write the summary post-lunch
(13:31:08) syzzer: perfect, ttyl then!
(13:31:13) mattock: bye!
(13:31:14) ***syzzer hungy :p
(13:31:16) ordex: :D
(13:31:24) ***ordex prepares dinner
(13:31:33) ordex: bye!

--------------4279914A5D6BF533B3997241--

