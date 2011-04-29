Message-ID: <4DBA6D8D.1070900@...515...>
Date: Fri, 29 Apr 2011 10:49:33 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050200080409000000010305"
Subject: [Openvpn-devel] Summary of the IRC meeting (28th Apr 2011)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------050200080409000000010305
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 28th Apr 2011
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2011-04-28>

Next meeting will be announced in advance, but will be on the same
weekday and at the same time. Your local meeting time is easy to check
from services such as

<http://www.timeanddate.com/world clock>

or with

$ date -u


SUMMARY

cron2, dazo, ecrist, jamesyonan, krzee and mattock were present in this
meeting.

--

Discussed "make check" (t_client.sh) test failures most buildslaves are
experiencing. This is caused by buildslaves doing their tests in
parallel with the same (sample) certificates and same configuration
files. Mattock will fix this by making each buildslave unique, so that
the server can handle all of them simultaneously.

--

Discussed which build configurations should be tested with buildbot.
Agreed that we can only choose a few or each commit will trigger a
ridiculously large number of builds.

Cron2 suggested trying to identify --enable/--disable combinations that
touch completely unrelated bits of code which can still be combined.
Jamesyonan suggested focusing on the major build features, such as

- <no configure flags>
--disable-crypto
--disable-ssl
--disable-lzo
--disable-management

Mattock will make buildbot configuration more automated, thus allowing
adding of builders for each combination of these, as well as for other
combinations deemed useful.

--

Discussed the purpose of openvpn-testing.git and openvpn.git repos. Dazo
outlined his current thoughts:

- openvpn-testing.git
  - would contain feature branches
  - would be a "sandbox" for testing potentially unstable features

- openvpn.git
  - would contain release/maintenance branches (e.g. 2.1, 2.2)
  - would contain pre-release branches (e.g. 2.3 alpha, beta and rc)

The "master" branch on both would be kept in sync. Agreed that this
setup makes sense.

--

Discussed the future of "allmerged" branch. Found two useful purposes
for it's existance:

- can serve as a stabilisation branch for separate feature branches
- allows a single binary snapshot release (Windows, deb, rpm) to cover
  many new features, instead of just one (e.g. IPv6, VLAN tagging)

Decided to maintain this branch, but change it's name to "experimental"
for clarity.

--

Discussed providing snapshot builds for Windows. With current Git
activity a monthly snapshots seem frequent enough:

<ftp://ftp2.secure-computing.net/pub/openvpn/revision.log>

Mattock will start providing monthly snapshot builds based on the Git
"master" branch at the end of the month, starting today/tomorrow.

--

Discussed the 2.2.1 release schedule. Currently there are two fixes that
will certainly go into it:

<http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=3Dopenvpn/openvpn.git;=
a=3Dcommit;h=3D60fdd9b01deab10f9a62ee9235ad9ec16873b5d5>
<http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=3Dopenvpn/openvpn.git;=
a=3Dcommit;h=3D4d453a1792b04f01a8c313157402ce0501ae809c>

Agreed to make the 2.2.1 release in 4-6 weeks.

--

Discussed merge conflicts when pulling code from SVN to Git. Jamesyonan
promised to use the openvpn.8 (=3Dthe biggest offender) from current Git
"master" branch in his SVN repo to minimize future conflicts.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



--------------050200080409000000010305
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2011-04-28.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2011-04-28.txt"

(21:01:25) cron2: meeting!
(21:02:22) mattock: meeting time indeed
(21:02:24) am3 [~irc@...1456...] =EF=BF=BD=EF=BF=BD entrato nel canale.
(21:03:12) mattock: topic list here: https://community.openvpn.net/openvpn/=
wiki/Topics-2011-04-28
(21:03:14) vpnHelper: Title: Topics-2011-04-28 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN Community (at community.openvpn.net)
(21:04:19) mattock: cron2: what if we begin with the automated test failure=
s while waiting for dazo?
(21:04:35) cron2: I can't access the URLs
(21:04:42) mattock: lemme copy-and-paste them
(21:04:48) cron2: no VPN setup right now, you're pointing to inside address=
es
(21:05:09) am3 ha abbandonato il canale.
(21:05:11) dazo_afk =EF=BF=BD=EF=BF=BD ora conosciuto come dazo
(21:05:17) cron2: \o/
(21:06:54) mattock: http://build.openvpn.net/success.html
(21:06:56) vpnHelper: Title: Log File contents (at build.openvpn.net)
(21:07:01) mattock: http://build.openvpn.net/failure.html
(21:07:03) vpnHelper: Title: Log File contents (at build.openvpn.net)
(21:07:39) mattock: anyways, I noticed the tests fail rather regularly
(21:07:58) mattock: I was wondering which parameters I could adjust to redu=
ce false positives (=3Dfailures)
(21:08:15) cron2: are these builds and tests run in parallel?
(21:08:26) cron2: if two clients connect to the server at the same time, al=
l hell breaks loose
(21:09:17) mattock: oh, that explains it then
(21:10:14) cron2: it could be made to work in parallel by a) giving every b=
uildslave its *own* OpenVPN certificate, and b) its own fixed IPv4+IPv6 add=
resse on the server, and c) its own t_client.rc that checks for *these* add=
resses in "ifconfig" output
(21:11:09) mattock: hmm, I think I need to do that
(21:11:09) ecrist: mattock: I'll look into that
(21:11:28) ***dazo votes for c) ... seems more reliable
(21:11:40) cron2: dazo: well, you need to do a)+b)+c) :-)
(21:11:47) cron2: it's not "or"
(21:11:53) dazo: ahh
(21:12:18) mattock: doesn't openvpn support static keys, too?
(21:12:31) cron2: it's either "serialize the tests, so that only one client=
 tests at a given time", or "make all clients completely independent, with =
a static config and static addresses"
(21:12:37) cron2: mattock: it does, but only in p2p mode
(21:12:54) dazo: I see a) + c) ... but why b)?  couldn't it just parse the =
openvpn log and see which IP addr being assigned there?
(21:13:12) cron2: dazo: in theory, it could, but as of today, it doesn't
(21:13:25) dazo: mm
(21:13:29) cron2: it could also use trickery with the script/plugin interfa=
ce
(21:13:33) mattock: cron2: I'll make the buildslave openvpn configurations =
independent, it's not a big deal
(21:14:19) cron2: dazo: the current design of the script is "I know in adva=
nce that I want to see in the output, and I want to verify that it's showin=
g up *exactly* *this* way"
(21:14:35) ***dazo wonders if mattock will still say "it's not a big deal" =
when we add another 100 buildslaves :-P
(21:14:45) dazo: cron2: gotcha
(21:14:47) cron2: but indeed, one could do a) only, and adapt the script
(21:15:12) mattock: dazo: do not underestimate the power of the puppet side=
! :)
(21:15:21) cron2: hail the puppetmaster
(21:15:29) dazo: heh :)
(21:15:32) mattock: actually, we don't need that many buildslaves, only bui=
ld configurations
(21:15:59) dazo: true :)
(21:16:20) ***dazo still dreams about a windows buildslave ... but that's a=
 completely different topic
(21:16:22) mattock: mozilla got 1000 builds triggered on every commit, so w=
e still got a long way to go
(21:16:33) mattock: dazo: that's me?
(21:16:38) cron2: heh :)
(21:16:52) dazo: heh :)
(21:17:01) dazo: mattock: you or not ... dunno :)
(21:17:06) mattock: ok, back to topic?
(21:17:08) mattock: ;)
(21:17:19) cron2: mattock: do you have a log file showing test 2 fail?
(21:17:26) mattock: cron2: just a sec
(21:17:49) cron2: that's basically the same test as "test 1", just "tcp not=
 udp" - so if test 1 succeeds, test 2 should do as well (unless it's a race=
 condition)
(21:18:46) dazo: it could be a race condition between two build slaves ... =
just that one was quicker and managed to complete test 1 and start test2 wh=
en the other one started testing
(21:18:47) mattock: http://build.openvpn.net/test2_failure.html
(21:18:48) vpnHelper: Title: Log File contents (at build.openvpn.net)
(21:19:04) cron2: dazo: yeah
(21:19:39) cron2: mmmh
(21:19:39) cron2: FAIL: no differences between ifconfig/route before OpenVP=
N start and now.
(21:20:02) cron2: one would need to look at 2:openvpn.log to see what reall=
y happened under the hood
(21:20:20) mattock: hmm, we need to fix this: "Please report to openvpn-use=
rs@lists.sourceforge.net"
(21:20:46) dazo: what's wrong with that one?
(21:20:54) mattock: openvpn-devel?
(21:21:08) dazo: ahh
(21:21:19) mattock: I'll make a patch
(21:22:20) mattock: cron2: I'll try to locate 2:openvpn.log for you
(21:23:01) cron2: it's in the build dir in a subdirectory time-stamped
(21:23:03) mattock: meanwhile, perhaps you could figure out which configure=
 flags we want to test?
(21:23:18) dazo: ./configure
(21:23:22) dazo: ./configure --enable-small
(21:23:32) dazo: ./configure --disable-lzo
(21:23:37) mattock: I need to do major buildbot configuration fixes anyways=
=20
(21:23:41) dazo: ./configure --disable-crypto --disable-ssl
(21:23:50) dazo: ./configure --disable-crypto --disable-ssl --disable-lzo
(21:23:58) cron2: which branch is this?  "master" or "2.2"?
(21:23:59) dazo: ./configure --disable-crypto --disable-ssl --enable-small
(21:24:14) dazo: probably 2.2
(21:26:01) cron2: --disable-multi
(21:26:14) mattock: we can run those on multiple branches with very little =
extra effort
(21:26:16) dazo: ahh good!
(21:26:27) cron2: for linux: --enable-iproute2 and "classic" (ifconfig)
(21:26:44) mattock: soon every commit will trigger 150 builds :)
(21:27:40) cron2: wah
(21:27:58) cron2: master has "README.ipv6", "README.IPv6", "TODO.ipv6", "TO=
DO.IPv6"
(21:28:03) dazo: --disable-server as well
(21:28:04) cron2: half of them are mine, half are jjo's
(21:28:37) dazo: maybe you two should consider to merge them? ;-)
(21:28:50) cron2: yeah, definitely
(21:29:25) cron2: mattock:  --enable-ipv6  (which turns on jjo's patch) in =
"master" branch
(21:29:50) dazo: hmmm ... I wonder if we should flip that one
(21:29:57) dazo: (enabled by default)
(21:29:58) mattock: btw. any idea why build would somewhat consistently hal=
t at this point:
(21:29:58) mattock: x86_64-linux-gnu-gcc -DHAVE_CONFIG_H -I.   -I.   -g -O2=
 -MT options.o -MD -MP -MF .deps/options.Tpo -c -o options.o options.c
(21:30:19) cron2: dazo: that would be in line with what other packages (lik=
e openssh) do
(21:30:20) mattock: I had some issues building Debian 5 amd64 packages for =
2.2.0
(21:30:39) cron2: mattock: any error messages?
(21:30:50) mattock: nope, it just stalls
(21:30:50) dazo: cron2: considering the status of IPv4 addresses in the wor=
ld ... not having IPv6 by default sounds wrong to me now
(21:31:02) cron2: dazo: I'm agreeing with you :)
(21:31:03) dazo: mattock: that's odd
(21:31:25) mattock: yep, I finally managed to build it
(21:31:40) mattock: only that specific configuration was affected, so it ma=
y have been a temporary glitch
(21:31:41) cron2: --enable-lzo-stub
(21:32:02) dazo: uhh, that's one of the new ones
(21:32:08) mattock: let me try to collect all of those
(21:32:09) dazo: definitely
(21:32:38) cron2: so we have 3 lzo variants (nothing, --disable-lzo, --enab=
le-lzo-stub).  3 crypto variants (?).  3 variants with and without server/c=
lient code.
(21:32:43) cron2: --small
(21:32:50) cron2: --ipv6
(21:32:55) cron2: --port-share
(21:32:56) dazo: mm
(21:33:23) dazo: --enable-iproute2
(21:33:39) cron2: if we want a full matrix that would be 432 variants
(21:33:58) dazo: If we can script that ... I don't see why not
(21:34:16) dazo: it could catch interesting odd combinations which otherwis=
e would slip through
(21:34:22) cron2: one ton of co2 for every commit?
(21:34:24) dazo: *could slip
(21:34:45) dazo: not every commit, but for every push I do
(21:35:03) dazo: which is not that often :)
(21:35:18) cron2: yeah, but anyway, this is a lot compiles, and some of the=
m will then fail t_client.sh (--disable-multi)
(21:35:25) cron2: a lot of compiles
(21:35:54) dazo: it sure is
(21:35:55) mattock: 432 builds for every commit... quite a few
(21:35:57) cron2: maybe we can identify --enable/--disable combinations tha=
t touch completely unrelated bits of code, and can combine
(21:36:10) cron2: mattock: 432 multiplied by number of different OSes we ha=
ve
(21:36:15) mattock: and branches?
(21:36:25) cron2: not all branches have all options
(21:36:37) cron2: 2.2 doesn't have --enable-ipv6 or --enable-lzo-stub
(21:36:37) mattock: I think we need to figure out the most essential
(21:36:38) dazo: remember, in our case it is really not per commit ... it i=
s per push I do to the public repo
(21:36:51) mattock: otherwise my server with (currently) 4 buildslaves won'=
t do anything else except build openvpn :)
(21:37:10) mattock: I do have some other users for it ;)
(21:37:18) dazo: heh :)
(21:37:59) mattock: can you guys try to identify the essential combinations?
(21:38:13) mattock: then I can setup buildslaves to build those
(21:38:36) dazo: sure ... it will take a while before I have time to really=
 do that, but yeah, I'll have it on my todo list
(21:38:51) mattock: no problem, I need to clean up buildbot configuration f=
irst anyways
(21:38:55) cron2: cool (I'll be away for the next two weeks)
(21:39:11) mattock: jamesyonan: there?
(21:39:16) cron2: cool.  next topic?
(21:39:29) mattock: cron2: yep, unless james has something to add
(21:39:33) mattock: (quickly) :)
(21:39:58) mattock: code repositories? dazo?
(21:40:07) dazo: cron2: after may 16, I have it more easy ... so if we coul=
d have a look then
(21:40:12) dazo: mattock: sure!
(21:40:35) dazo: I've been thinking about the openvpn.git and openvpn-testi=
ng.git trees
(21:41:00) dazo: and I see one good purpose of having both ... where openvp=
n.git is only what we have released or are about to release
(21:41:32) dazo: that way stability focused people can pick one clean tree =
without being confused about feature branches which may or may not be inclu=
ded
(21:41:41) mattock: release preparation and maintenance branch...
(21:41:50) dazo: yeah
(21:42:04) dazo: openvpn-testing.git will have feature branches and will be=
 the "sandbox" where we can do a lot of testing
(21:42:08) cron2: sounds workable
(21:42:12) mattock: yep
(21:42:43) mattock: dazo: does it make your life with Git more difficult in=
 any way?
(21:42:55) mattock: e.g. rebases, merges and such
(21:43:06) dazo: I would then keep both master branches in synch ... and in=
 fact ... it's just for anyone to just do: git remote add stable git://....=
./openvpn.git  in a clone of openvpn-testing.git .., and they get that stuff
(21:43:10) dazo: mattock: not at all, that's the good thing
(21:43:25) cron2: why would I want that, add "stable"?
(21:43:28) dazo: I have both repos now in one directory ... and I just say =
"push master to remote xxx"
(21:43:52) dazo: I'm considering to remove the release/ branches from openv=
pn-testing
(21:44:02) cron2: ah
(21:44:10) dazo: but you're right, the other way around is probably more us=
eful
(21:44:11) cron2: indeed, then you need both :)
(21:44:30) ***cron2 will do everything git-master dazo says
(21:44:36) dazo: :)
(21:44:37) mattock: +1
(21:44:44) dazo: so that's the easy part
(21:44:48) dazo: then there is allmerged
(21:44:57) dazo: right now ... allmerged is basically =3D=3D master
(21:45:11) cron2: what did you do with the orphaned feature branches?
(21:45:13) dazo: because we have merged all approved feature branches=20
(21:45:33) cron2: ic, "nonmerged"
(21:45:39) dazo: then we have feat_vlan_tagging and feat_pass_tos which are=
 "in the middle of nowhere
(21:45:53) dazo: notmerged ... hmmm
(21:46:27) mattock: dazo: is there still the problem with commit history be=
ing messed up in "allmerged"?
(21:46:33) mattock: duplicate commits, that is
(21:46:42) mattock: with different commit ids
(21:46:50) dazo: first of all ... both of them do carry important stuff ...=
. however, the developers of these branches are not much active
(21:47:19) dazo: mattock: most likely ... but the allmerged branch should n=
ot be used for anything "usefull" other than to test all branches at once
(21:47:21) mattock: and the only problem with them being lack of testing, i=
f I recall correctly
(21:47:31) dazo: yeah
(21:47:39) dazo: that too
(21:48:43) dazo: "today's" allmerged needs to be rebuilt from scratch ... o=
r else I'll have to sort out a lot of conflicts against master + feat_ipv6_=
* + what is already in allmerged
(21:49:03) dazo: so each time we merge a new feature branch into master, we=
 basically need to rebuilt allmerged
(21:50:02) ***dazo wonders if this sounds understandable or is too detailed=
 ...
(21:50:03) mattock: do we really want/need allmerged?
(21:50:15) dazo: that's kind of what I've been wondering about as well
(21:50:27) mattock: I would guess people who want a specific feature, use a=
 feature branch
(21:50:47) mattock: but if there's some benefit in having all features in o=
n package...
(21:51:11) dazo: it did serve a purpose when we went through all the old pa=
tches from mailing list  and sf.net trackers ... and we kind of were establ=
ishing the 2.2 code base
(21:51:13) mattock: of course, we wouldn't have to, say, build Windows pack=
ages for 10 different feature branches to have them tested
(21:51:34) mattock: ...if we have something like "allmerged"
(21:51:47) dazo: exactly
(21:51:48) mattock: same with binary packages (deb/rpm)
(21:51:54) dazo: when we have more feature branches which are actively bein=
g developed, then allmerged makes sense
(21:52:12) dazo: and I know that the polarssl patches will come at some poi=
nt=20
(21:52:29) dazo: that I'd like to put into a feature branch, just as the ip=
v6 stuff=20
(21:52:56) dazo: then a allmerged branch could serve as a stabilisation bra=
nch before hitting master
(21:53:20) mattock: dazo: has it been painful to maintain "allmerged"?
(21:53:49) dazo: some times, yes ... but not lately .... and if I rebuilt i=
t again now, it should be good
(21:53:49) mattock: I think it serves a purpose, if it's got all the cuttin=
g-edge features we want to get tested (especially in snapshot builds)=20
(21:54:09) dazo: and I see allmerged as a possible way how to test those fe=
at_vlan* and feat_passtos branches now
(21:54:31) mattock: is everything in those branches ACKd?
(21:54:37) dazo: they are not "accepted", but could now go into allmerged +=
 master, to see if they do work
(21:54:38) dazo: nope
(21:55:08) dazo: 'allmerged' is probably the wrong name for such a branch t=
hough .... 'experimental' is probably better
(21:55:22) mattock: yep, that's better
(21:55:27) mattock: less confusing
(21:55:31) dazo: agreed
(21:55:58) mattock: I say let's have this "experimental" branch, at least f=
or snapshot build's sake
(21:56:45) dazo: okay, then I'll drop the allmerged branch ... and then we'=
ll move over to experimental for un-acked branches
(21:56:57) mattock: dazo: which branch would you suggest for Windows snapsh=
ot packages?
(21:57:16) dazo: hmmm ... right now, I'd say 'master'
(21:57:42) mattock: later perhaps "experimental" also/instead?
(21:57:44) dazo: unless Windows based _developers_ shows up and says "what =
about us?"
(21:58:19) dazo: experimental for Windows can probably be okay if we get a =
buildslave to do the building
(21:58:47) dazo: but in the moment we need to do it manually, then it makes=
 sense to just do master from time to tim
(21:58:48) dazo: e
(21:58:59) mattock: http://trac.buildbot.net/wiki/RunningBuildbotOnWindows
(21:59:03) vpnHelper: Title: RunningBuildbotOnWindows =EF=BF=BD=EF=BF=BD=EF=
=BF=BD Buildbot (at trac.buildbot.net)
(21:59:06) mattock: I won't say "it's no biggie"
(21:59:34) mattock: how often should we publish snapshots?
(21:59:47) dazo: it *looks* easy ... but building OpenVPN on Windows was al=
so supposed to be easy :-P
(22:00:06) mattock: yep :)
(22:00:28) mattock: actually, I think I said "it was more difficult than I =
thought it to be"
(22:00:37) dazo: :)
(22:00:46) mattock: anyways, biweekly snapshots?
(22:00:54) dazo: well, monthly snapshots is probably not a bad time frame=20
(22:01:05) dazo: we do a lot in a short period, and then it silent for a wh=
ile
(22:01:07) mattock: ok, those might actually have some changes in them
(22:01:15) dazo: yeah
(22:01:17) mattock: monthly snapshots it is then
(22:01:45) dazo: ftp://ftp2.secure-computing.net/pub/openvpn/revision.log
(22:01:46) mattock: next topic?
(22:01:48) dazo: this gives an indication
(22:02:15) dazo: next, sure :)
(22:02:51) ecrist: mattock: before you leave for the day, can you work with=
 me on my ldap issue?
(22:03:06) dazo: A 2.2.1 release?
(22:03:07) mattock: ecrist: yep
(22:03:20) mattock: dazo: yep
(22:03:59) cron2: dazo: unavoidable :)
(22:04:24) dazo: I would say that the issue found is no hurry ... it's a co=
mpile time issue when  --enable-small --disable-crypto --disable-ssl are us=
ed together
(22:04:26) mattock: the release process is still quite heavy, probably take=
s me ~4 hours to setup everything
(22:04:36) dazo: which is a rather odd combination for a VPN (no encryption)
(22:05:09) dazo: however, what *might* push us a little bit is a bugfix jam=
es pointed out (r7125)=20
(22:05:14) mattock: so due to ^^^ I'd rather not make releases every week ;)
(22:05:23) cron2: dazo: what is that?
(22:05:31) dazo: mattock: nope :)  I don't have time for that either :)
(22:05:35) ***dazo looks up the commit
(22:05:58) mattock: maybe we should align our bug fixes with "patch Tuesday=
"? :P
(22:06:27) dazo: http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=3Dopen=
vpn/openvpn.git;a=3Dcommit;h=3D4d453a1792b04f01a8c313157402ce0501ae809c
(22:06:29) vpnHelper: Title: SourceForge - openvpn/openvpn.git/commit (at o=
penvpn.git.sourceforge.net)
(22:06:46) dazo: mattock: that might be a good idea ... even though, that i=
s next week I believe :-P
(22:07:46) dazo: but if we plan for having a 2.2.1 in ~4-6 weeks, that's pr=
obably reasonable
(22:07:51) cron2: ah, that one - didn't we merge that already?  I seem to r=
emember that it showed up a few weeks ago already
(22:08:12) dazo: that was r7127, which was a one-liner
(22:08:22) dazo: management =3D NULL;
(22:08:28) mattock: 4-6 weeks sounds good
(22:08:34) cron2: ah, and in that context, I think I also checked 7125 becu=
ase James mentioned it was important
(22:08:36) mattock: end of May, perhaps
(22:08:38) dazo: this one requires a bigger backport of more infrastructure
(22:08:54) cron2: why?
(22:09:24) dazo: it depends on more packet_id information stuff, which come=
s in an earlier commit
(22:09:25) mattock: functions getting lots of new parameters?
(22:09:31) cron2: oh
(22:09:39) dazo: I've found at least 2 more commits to make this one compile
(22:09:39) cron2: more exciting stuff in 2.1 that never made 2.2
(22:09:56) dazo: oh yeah ...=20
(22:09:56) cron2: this is not exactly a "backport" but more a "cross"port...
(22:10:06) cron2: this is not helpful
(22:10:21) dazo: well, it's a backport considering 'master' is ahead of rel=
ease/2.2 right now ;-)
(22:10:43) dazo: I have merged in the latest changes from james' SVN tree t=
o master
(22:10:50) cron2: oh, ok, all of 2.1 SVN is in "master" but not in 2.2
(22:11:00) dazo: exactly
(22:12:19) dazo: And I'm using a compile of master on my work laptop, where=
 I send IPv6 traffic features as well as IPv4 traffic ... and that works ve=
ry well
(22:12:35) dazo: compiles without any warnings even :)
(22:12:52) cron2: cool
(22:13:10) cron2: btw, pfsense 2.0 will be based on OpenVPN 2.2 + both ipv6=
 branches
(22:13:19) cron2: so we'll get test coverage there :)
(22:13:25) dazo: cool!
(22:13:40) mattock: dazo: what about "Minimizing merge conflicts between SV=
N and Git"
(22:13:59) mattock: you mentioned openvpn.8 being a pain
(22:14:02) dazo: well, that requires probably jamesyonan attention a little=
 bit :)
(22:14:10) mattock: jamesyonan: art thou there?
(22:14:14) dazo: yeah, openvpn.8 is annoying=20
(22:15:03) dazo: james' tree uses --option .... while a patch from the debi=
an guys changed that to \-\-option ... as -- should be escaped for some rea=
son
(22:15:07) jamesyonan: hi, I'm here
(22:15:19) dazo: (and debian build tools do complain about that otherwise)
(22:15:21) cron2: dazo: I'll fix that for the ipv6 options
(22:15:27) dazo: cron2: thx!
(22:16:28) mattock: jamesyonan: earlier we discussed which configure flag c=
ombination we should test (with buildbot)
(22:16:34) dazo: so you can guess all the fun merge conflicts I then get ..=
. when we have documentation patches adding more stuff (with \-\-) and then=
 the SVN tree comes with -- ... it's a lot of cut'n'paste=20
(22:16:55) mattock: we can't test for every possible combination or the num=
ber of builds triggered by every commit explodes into our hands
(22:17:17) mattock: if you have any especially important combinations that =
should be tested, let us know
(22:17:29) dazo: jamesyonan: would it be possible for you to take the lates=
t openvpn.8 file and apply that one to your svn tree?  And make sure that y=
ou escape -- as \-\- when you add more documentation?
(22:18:09) jamesyonan: yeah I could certainly do that
(22:19:05) dazo: that'd be great ... it might be a few options which are no=
t relevant for your branch yet ... not sure if you would let that pass for =
now (considering you'll hopefully get over to git at some point)
(22:19:55) jamesyonan: dazo: thanks a lot for merging changes from my tree
(22:20:23) dazo: my pleasure :)
(22:20:28) jamesyonan: I'm at=20
(22:20:30) dazo: (except the merge conflicts :-P)
(22:20:32) jamesyonan: 2.1.3w now
(22:20:53) dazo: that's where the master branch is now as well
(22:21:00) dazo: plus some more fixes
(22:21:05) jamesyonan: great
(22:21:57) dazo: we discussed a bit earlier the r7215 commit you wanted int=
o 2. ... I'm working on a backport for 2.2.1
(22:22:28) dazo: right now, there's some compile complaints about redefinit=
ion of log levels ... but I'll figure out that
(22:22:54) mattock: jamesyonan: just wondering... how simple/complex your S=
VN workflow is? Is it mostly just "svn commit"?
(22:23:13) mattock: svn add, svn commit
(22:23:46) jamesyonan: yeah, svn add, commit, status, log, etc.
(22:24:09) dazo: and you have some build scripts which pulls the svn tree, =
I presume?
(22:24:21) mattock: excellent! from experience I can tell that Git won't ch=
ange that much=20
(22:25:13) dazo: (the change you will notice is that each of those actions =
will go a lot faster :))
(22:25:42) jamesyonan: yes, we have a bunch of different build scripts that=
 interact with svn
(22:26:25) jamesyonan: you don't have to sell me on git -- I'm looking forw=
ard to migrating to it
(22:26:31) dazo: :)
(22:26:56) mattock: I was thinking along the lines "see how easy it will be=
" :P
(22:27:12) mattock: anyways, do we have any other topics to cover?
(22:27:19) mattock: none on the list
(22:28:20) dazo: goodie :)
(22:28:44) dazo: I'll play with the 'experimental' branch during weekend th=
en, and give another update on the mailing list
(22:29:08) mattock: sounds good!
(22:29:24) mattock: meanwhile I'll write the summary and reprioritize my ta=
sks
(22:29:29) dazo: jamesyonan: one question ... how critical is the fix you h=
ave in r7125?
(22:29:44) jamesyonan: mattock: regarding testing build permutations, I wou=
ld just focus on the big ones like --disable-crypto, --disable-ssl, --disab=
le-lzo, disable-management
(22:30:05) dazo: just wondering if a release 4-6 weeks is reasonable time f=
rame for that one
(22:30:10) mattock: jamesyonan: ok
(22:30:40) jamesyonan: dazo: not sure how many people use adaptive mode in =
the client, where both UDP and TCP endpoints are defined
(22:31:17) jamesyonan: the access server uses it though
(22:31:28) jamesyonan: this issue only affects adaptive mode
(22:32:02) dazo: ahh, okay ... well, from time to time it comes up question=
s about such configurations ... so there are definitely users for it
(22:32:17) dazo: (however, few manages to get it right immediately)
(22:34:01) mattock: ok, let's call this a day
(22:34:07) dazo: agreed :)
(22:34:27) cron2: dazo: shall we discuss the feat_ipv6_* weirdness tomorrow=
, then?
(22:34:28) dazo: mattock: I think r7125 can wait for the time frame we've s=
et ... it's not a regression from 2.1.x
(22:34:36) dazo: cron2: ahh=20
(22:34:40) dazo: we can do that now
(22:34:46) mattock: agreed, and not a security issue, either
(22:34:51) dazo: nope
(22:34:58) mattock: ecrist: shall we continue with LDAP?
(22:35:05) ecrist: aye
(22:35:21) mattock: pm?
(22:35:25) ***dazo looks at cron2's logs again
(22:36:16) ecrist: sure
(22:36:29) dazo: cron2: it seems that your feat_*_2.2 and feat_*_2.3 branch=
es have quite different roots ... and this is the issue
(22:37:01) cron2: _2.3 is a branch from _2.2 and rebase to master
(22:37:16) jamesyonan: mattock: BTW, I have an old script for testing build=
 permutations: http://secure.openvpn.net/tmp/build-permut
(22:37:18) dazo: right
(22:38:13) mattock: jamesyonan: ok, I'll check that out
(22:39:07) cron2: dazo: wouldn't it be the easiest approach to completely d=
rop feat_ipv6_payload?
(22:39:09) jamesyonan: mattock: it references another script called "fresh-=
test" that I've also put in the same folder

--------------050200080409000000010305--

