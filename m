Message-ID: <4C494B17.4010204@...515...>
Date: Fri, 23 Jul 2010 10:56:07 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030406010604070401090406"
Subject: [Openvpn-devel] Summary of the IRC meeting (22nd Jul 2010)
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
--------------030406010604070401090406
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 22nd Jul 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-07-22>

Next meeting next week, same place, same time. Your local meeting time
is easy to check from services such as

<http://www.timeanddate.com/worldclock>

or with

$ date -u


SUMMARY

Discussed the "push-reset should not reset topology and route-gateway
from global config" bug:

<https://community.openvpn.net/openvpn/ticket/29>

Dazo will summarize the issue, viewpoints and potential solutions and
send email to openvpn-devel list.

--

Discussed OpenVPN release management and release cycles. Agreed that a
relatively short release cycle (4-6 months) would be best as it'd reduce
the need for long beta/rc cycles and keep people using newest possible
versions. However, if necessary, the cycle could be as long as 12
months. We should know more after making the 2.2 release (beta due by
end of this month).

The current release process draft is available here:

<https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation#Makingar=
elease>

--

Discussed the "Merge conflict merging in last changes from SVN r6291" issue:

<http://thread.gmane.org/gmane.network.openvpn.devel/3845>

The issue arose from the fact that James had removed DNS randomization
in his tree, which caused a merge conflict in "testing" because that
feature was already on it's way out (in FRP pipeline). Agreed to solve
the conflict in favor of James. This lead to more general discussion
about the Feature Removal Process. It was decided to remove the "enabled
but outputs a runtime warning" phase from it. The updated FRP is
available here:

<https://community.openvpn.net/openvpn/wiki/FRP>

--

Discussed status of Buildbot, which built it's first OpenVPN "testing"
packages for Debian amd64 platform on Wednesday. However, these initial
packages still need work. Debian i386 and Ubuntu 9.10 i386 and 10.04
i386/amd64 packages are coming up next. Cron2 might also be able to
provide a NetBSD/Sparc64 server to use as Buildbot buildslave.

Agreed that running buildslaves on "funky" platforms (like
NetBSD/Sparc64) is a good idea, because it makes sure the code is really
portable.

Access to buildbot and buildbot web interface will be protected by
OpenVPN authenticating from LDAP. Some buildslaves would be provided by
the company, others by the community. Every community member who
provides a buildslave will be able to view the buildbot web interface
through the VPN connection.

--

Discussed new OpenVPN forums. In a nutshell, only theming is missing.
Migrating (fake) ovpnforum.com users into LDAP and mailing them new
passwords worked like a charm, as did phpbb LDAP auth. The launch date
for forums is set as August 13th.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock





--------------030406010604070401090406
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-07-22.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-07-22.txt"

(21:11:21) jamesyonan [~jamesyona@...1320...] =EF=BF=BD=EF=BF=BD entrato ne=
l canale.
(21:11:25) dazo: \o/
(21:11:29) jamesyonan: hi
(21:11:33) dazo: hi!
(21:11:41) mattock: hi james!
(21:11:58) mattock: ok everyone, topic list is available here: https://comm=
unity.openvpn.net/openvpn/wiki/Topics-2010-07-22
(21:11:59) vpnHelper: Title: Topics-2010-07-22 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN (at community.openvpn.net)
(21:12:26) mattock: we have a couple of potentially tough ones today...
(21:12:39) mattock: the SVN merge conflict: http://thread.gmane.org/gmane.n=
etwork.openvpn.devel/3845
(21:12:40) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:12:43) mattock: and release cycle stuff
(21:12:45) mattock: and one bug
(21:12:58) mattock: which first?
(21:13:12) ***dazo would like release cycle first
(21:13:23) mattock: ok, let's start with that
(21:13:23) chantra: as i might be around for not much long, i would propose=
 the bug first :)
(21:13:31) mattock: chantra: good point
(21:13:34) mattock: any objections?
(21:13:38) dazo: nope
(21:13:52) mattock: ok, this one first, then: https://community.openvpn.net=
/openvpn/ticket/29
(21:13:54) vpnHelper: Title: #29 (push-reset should not reset topology and =
route-gateway from global config) =EF=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN (at c=
ommunity.openvpn.net)
(21:14:29) mattock: so you guys (dazo, chantra) already discussed this in s=
ome length?
(21:14:40) chantra: yep
(21:14:52) dazo: jamesyonan:  is there a reason for topology and route-gate=
way also being cleared when using --push-reset in ccd configs?
(21:15:52) jamesyonan: push-reset clears the whole push list
(21:15:55) jamesyonan: it's not fine-grained
(21:16:05) dazo: that seems to be the culprit which breaks the tunnel, when=
 used together with topology subnet
(21:16:35) dazo: would it be an idea to "flag" topology and route-gateway f=
rom not being cleared on --push-reset?
(21:18:00) dazo: I kind of doubt the intention with --push-reset was to als=
o clear those .... but it's also possible to add a '--push-reset all' ... w=
hich also clears it completely, as now
(21:19:21) jamesyonan: Personally, I never use push-reset.  It's better to =
use a model where the global configuration contains settings common to all =
clients, and then each client takes the global configuration and adds its o=
wn client-specific settings.
(21:19:53) dazo: but ... will that work with ccd?
(21:20:37) dazo: I do see the cleanness in doing it the other way around, t=
hough
(21:20:44) chantra: but that would require to configure all clients
(21:20:58) jamesyonan: this is how it works now
(21:21:01) chantra: except of having a global conf and only a few clients w=
ith specific conf
(21:21:32) chantra: -except + instead
(21:21:43) jamesyonan: when a client connects, the server takes the global =
push list, copies it, then pushes client specific option to the copy, befor=
e the list gets sent to the client
(21:22:20) dazo: I see what you mean now, jamesyonan=20
(21:22:22) jamesyonan: in hindsight, I think push-reset was a bad idea beca=
use it breaks this model
(21:23:26) dazo: but the issue is that if you have a generic config which i=
s useful for 90% of your clients .... and have 10% which don't need/want/sh=
ould not have the generic stuff ... then a --push-reset might make it easie=
r to maintain for a sysadmin
(21:24:13) chantra: yeah :)
(21:24:25) chantra: i thought that was the idea behind push-reset
(21:24:57) dazo: but the contra argument then is that, then you can push to=
pology and route-gateway manually, as that is the exception
(21:25:12) chantra: because even though topology and route-gateway are "pus=
hed" to the clients, they are server specific, not client specific
(21:26:00) dazo: that's a good argument
(21:27:15) chantra: i think all it would take to sort this one out (and pos=
sible other options), is to have 2 list:
(21:27:21) chantra: server_push_options
(21:27:29) chantra: client_push_options
(21:27:36) dazo: jamesyonan:  the fact is that we do have --push-reset now,=
 people do use it ... so we probably should consider to poke into a fix her=
e ... as chantra says, --topology is server centric ... re: --route-gateway=
, that's more discussable, as that is client oriented
(21:27:40) chantra: only client_push_options would be reset
(21:28:15) jamesyonan: that makes sense -- if push-reset is to be supported=
, I agree it should probably be smarter in the sense of distinguishing betw=
een server-scoped and client-scoped settings
(21:28:33) chantra: my undertsanding is route gateway is needed to subnet t=
opology, the client specific one might be the redirect-gateway part
(21:29:56) chantra: dazo: http://openvpn.git.sourceforge.net/git/gitweb.cgi=
?p=3Dopenvpn/openvpn-testing.git;a=3Dblob;f=3Dhelper.c;h=3Da9d7fd9fa2936cf5=
de1318ac7065372a251732b6;hb=3Drefs/heads/bugfix2.1#l147
(21:29:57) vpnHelper: Title: SourceForge - openvpn/openvpn-testing.git/blob=
 - helper.c (at openvpn.git.sourceforge.net)
(21:30:17) chantra: "route-gateway is only pushed in this context:=20
(21:30:19) chantra: if tap OR (tun AND topology =3D=3D subnet)
(21:30:36) dazo: hmm ... I was looking for that description :)
(21:31:50) chantra: there might be other parameters that are server specifi=
c, but i dont knowe much of other setting than subnet or net30 with tun int=
erface
(21:32:15) chantra: but I would assume any of the parameters set in the des=
cription above should be server specific
(21:32:38) ***dazo is reading the code now
(21:33:34) mattock: I'm just rolling my eyes :)... should have read 30 minu=
tes worth of OpenVPN man pages and FAQ's to get the idea :)
(21:34:31) ***dazo begins to get a feeling of a fix
(21:34:50) chantra: dazo: i thought of maintening 2 list of options
(21:34:54) dazo: the question is more, what jamesyonan let open .... should=
 we support --push-reset at all?
(21:35:05) chantra: a immutable and a resetable
(21:35:06) dazo: chantra:  yeah, I'm thinking long those paths as well
(21:37:00) dazo: I'm wondering if all or just some of these options which a=
re pushed when parsing the server side should be immutable ... there are qu=
ite some push_option() calls here
(21:37:03) jamesyonan: maybe a better solution to push-reset would be a sor=
t of "unpush" directive where the client-specific config could selectively =
remove specific items from the global config before pushing to client
(21:38:19) jamesyonan: this solves the problem because then we don't need a=
n algorithm to determine which items push-reset should clear
(21:38:43) chantra: would not help my use case though :)
(21:38:58) dazo: mm ... but will this freedom increase the complexity for t=
hose configuring it?
(21:39:08) dazo: increase too much, I mean
(21:41:13) chantra: well, then adding a route to global config, need to be =
unpush-ed from each client that should not receive it
(21:41:16) dazo: and options are not in key/value pair as I can understand =
... so the option parsing when building up the push string could become les=
s trivial
(21:41:29) chantra: i personally dont mind poking into the http://openvpn.g=
it.sourceforge.net/git/gitweb.cgi?p=3Dopenvpn/openvpn-testing.git;a=3Dblob;=
f=3Dhelper.c;h=3Da9d7fd9fa2936cf5de1318ac7065372a251732b6;hb=3Drefs/heads/b=
ugfix2.1#l139 to see what is needed to have a working tunnel between client=
 and server=20
(21:41:29) vpnHelper: Title: SourceForge - openvpn/openvpn-testing.git/blob=
 - helper.c (at openvpn.git.sourceforge.net)
(21:42:45) chantra: well, i got to run now :s, will read up the logs tomorr=
ow
(21:43:15) chantra: and see what path can be taken
(21:43:29) dazo: I'm actually wondering if it would make sense to extend th=
e struct push_entry with a immutable flag
(21:43:45) mattock: chantra: bye!
(21:43:50) chantra: and as i said, i dont might working on that bit
(21:43:52) dazo: and then give the API a possibility to set this or not
(21:44:58) chantra: before i go :) I had 2 ideas in mind:
(21:45:22) dazo: when doing the copy ... --push-reset will only not copy ov=
er non-immutable entries .... but ... it do put the main "sorting" of what =
should be immutable or not on the implementation, so it's less free than an=
 "unpush"
(21:45:32) chantra: - flagging, but then that would require going through t=
he list and only removing unflagged entries
(21:45:54) dazo: you'll have a copy algorithm already present
(21:46:01) chantra: - maintaining 2 list, the resetable one can just be dro=
pped (which is the actual behaviour)
(21:46:23) dazo: it's more pointers to keep track of, and less generic
(21:47:22) mattock: perhaps we could discuss this further on the mailinglis=
t?
(21:47:24) dazo: you anyway need to copy push_entries over to a string ... =
so with two lists, you need to do such a copy twice ... while with a flag, =
you just ignore those non-immutable if --push-reset is defined
(21:47:47) dazo: mattock:  good idea
(21:47:49) dazo: jamesyonan:  what do you think right now?
(21:49:47) jamesyonan: If we keep push-reset, I would say that we fix it wi=
th the simplest implementation
(21:50:06) dazo: diplomatic answer ;-)
(21:50:24) mattock: I think summarizing the ideas presented here into an em=
ail and sending it -devel makes most sense=20
(21:50:44) dazo: mattock:  agreed
(21:51:20) mattock: dazo: could you write something up easily? it'd take me=
 quite a while summarize this topic
(21:51:31) dazo: mattock:  I can do!
(21:51:47) mattock: just the basic problem and the discussed, potential sol=
utions
(21:51:47) dazo: mattock:  I'll send you an e-mail
(21:51:57) mattock: or perhaps you could just send it to devel?
(21:52:02) mattock: in a separate mali
(21:52:04) mattock: mail
(21:52:08) mattock: ?
(21:52:18) mattock: what do you think?
(21:52:24) dazo: I can do that as well
(21:52:39) dazo: release cycle?
(21:53:00) mattock: yep
(21:53:27) mattock: currently the release cycle is undefined... or random, =
if you will :)
(21:53:59) dazo: it would be good to get some kind of idea how we will do t=
hese cycles
(21:54:03) mattock: I think we agreed a while back that having a (relativel=
y) fixed release cycle would make sense
(21:54:10) dazo: yes
(21:54:15) mattock: I'll try to find the earlier meeting summary...
(21:54:19) mattock: might take a few minutes
(21:54:36) dazo: I think we should keep that, and also these two cycles whi=
ch was in the 2.1 round .... a beta round and a RC round
(21:56:03) dazo: The beta round in my eyes will have most features for the =
release included, and it's basically a lot of bug testing - but new feature=
s can change as much as needed, old features can change if absolutely needed
(21:56:21) mattock: btw. the Feature Removal Process was discussed on 18th =
Feb 2010
(21:56:40) mattock: agreed
(21:56:57) dazo: the RC cycle is only stabilisation and bugfixes.  When hit=
ting the RC, that's when we know for sure which features should be included=
 ... where we only fix stuff .... worst case, we can take out a feature if =
it really is horrendous to stability
(21:57:42) dazo: so RC =3D=3D no feature changes .... unless extreme situat=
ions and we can't fix the feature without breaking/changing too much of the=
 code base
(21:59:35) mattock: ...fixing compiz or something :)
(22:00:08) dazo: heh ... compiz is probably not our preferred working model=
 :-P
(22:01:57) mattock: dazo: the plan sounds good... I'll go back to searching=
 the old release cycle discussion. Perhaps we had some pearls of wisdom then
(22:02:54) dazo: but we also should define some deadlines ... when starting=
 the beta cycle ... we should have a goal for a date for when to hit RC ...=
 and when being in RC we should have a goal date for when we're going gold
(22:03:30) mattock: ok, could not find anything :(
(22:04:06) mattock: dazo: do you have something in mind? beta -> rc in mont=
h? two months?
(22:04:13) mattock: rc -> release?
(22:04:44) dazo: rc =3D release candidate ..... gold =3D GA (General Availa=
bility) / official release
(22:04:52) mattock: btw. as buildbot is now creating Debian packages, we ca=
n soon start distributing the latest and greatest OpenVPN "testing" very ea=
sily to users
(22:05:12) mattock: which should cut down the release cycle length somewhat
(22:05:23) dazo: hopefully=20
(22:06:07) mattock: with the right advertisements on openvpn.net we should =
easily 2-5 the amount of -testing users
(22:06:10) dazo: re: time scope ... ideally, I would say beta->rc should be=
 2-4 months (depending on feature list) .... and rc->gold should be 2-3 mon=
ths=20
(22:06:39) mattock: and after a GA release how much time until the next bet=
a?
(22:06:45) mattock: =3Dtotal release cycle length
(22:06:53) mattock: is 6 months reasonable?
(22:07:02) mattock: I remember we talked about 12 months initially
(22:07:06) dazo: yeah, I'd say 4-6 months
(22:07:17) dazo: I think 12 months is too long, tbh
(22:07:25) mattock: jamesyonan: what do you think?
(22:07:45) mattock: I'd say 6 months, too... the less new features there ar=
e, the less need for extensive testing
(22:07:54) dazo: exactly
(22:08:05) mattock: the longer we postpone the releases, the more we have t=
o test in beta/rc phases
(22:08:29) jamesyonan: I agree with 4 to 6 months
(22:08:30) mattock: and I think we should try to keep a large subset of our=
 users using pretty up-to-date versions of the software
(22:09:23) mattock: I assume development will continue as usual during beta=
/rc phases? that is, outside the "to-be-stable" branches...
(22:09:25) dazo: At the #openvpn channel, we usually tell people to update =
to latest release before we're helping further
(22:10:15) dazo: development can continue in the appropriate branches indep=
endently .... but we won't merge in anything from those branches to the bet=
a or rc branches
(22:10:31) mattock: ok, so what about this cycle:
(22:10:42) dazo: (unless it really makes sense, and those fixes to those br=
anches are only fixes in the mean time)
(22:12:01) mattock: GA release -> 2 months adding new features -> 2 months =
in beta (and adding features to other branches) -> 1-2 months in rc (and ad=
ding features to other branches)=20
(22:12:21) mattock: or something like that
(22:12:31) dazo: that was a bit more speedier than I expected :)
(22:13:00) mattock: if we make too frequent releases we'll probably have tr=
ouble integrating big features (if any)
(22:13:10) mattock: at least Ubuntu had this problem... 6 months is not a l=
ot
(22:13:15) dazo: yeah, that's my concern
(22:13:41) dazo: I'm maintaining a couple of Fedora packages ... and you fe=
el you've just rebased until the next round is there
(22:13:44) mattock: but we could _try_ 6 months and see what happens
(22:13:56) mattock: so far there have not been any really big changes
(22:14:20) mattock: invasive changes, that is
(22:14:31) dazo: II would suggest:  GA -> 3 months devel -> 3 months beta -=
> 4 months RC -> GA
(22:14:49) dazo: the reason for 4 months RC, is that we need to be sure the=
 product is stable
(22:15:12) mattock: yep
(22:15:18) dazo: I know it's a lot, and it slows down the complete cycle, b=
ut I think we can have better control this way
(22:15:21) mattock: we could cut down beta/rc time if no issues seem to ari=
se
(22:15:50) dazo: yes, and in some cases we might want it longer  .... I can=
 imagine when adding the IPv6 stuff, we would want it a bit longer
(22:15:56) mattock: for example, if we know tons of people are using a beta=
 but no bug reports are filed in 2 months
(22:15:58) mattock: or something
(22:16:29) dazo: yeah, something like that .... but I would also include su=
pport issues on forums and on irc as well
(22:16:39) mattock: yep
(22:17:31) mattock: I think we should start collecting download statistics =
for the beta2.2 when it's released
(22:17:32) dazo: but we also do need to consider seasons as well ... July i=
s not a month which a lot of changes happens, likewise around December ... =
so these months needs to not be counted
(22:17:43) dazo: definitely
(22:18:19) mattock: and I can get nice statistics from Apache and apt/yum r=
epos on build.openvpn.net
(22:18:25) mattock: when I get so far
(22:18:31) dazo: perfect!
(22:18:49) mattock: I don't have any clue how many people use "-testing" bu=
t it can't be much
(22:18:56) mattock: mostly FreeBSD guys, I guess
(22:18:59) ecrist: mattock: are you pointing to my weekly builds now, or di=
rect to source?
(22:19:08) mattock: the weekly builds
(22:19:19) ecrist: mattock: I can tell you how many downloads have ocurred
(22:19:27) mattock: ecrist: please do :)
(22:19:28) ecrist: it's multiple hundreds, though
(22:19:40) ***dazo estimates ~100 +- 25
(22:19:50) dazo: for all weekly builds
(22:20:04) mattock: not much, but a good start
(22:20:24) mattock: when I get buildbot building the packages, I'll link to=
 them from openvpn.net
(22:20:28) mattock: that should do the trick
(22:20:38) dazo: but I think this is due to availability ... I think there'=
s quite some Linux and Windows users as well, who don't want to do the comp=
iling themselves
(22:21:03) mattock: I would not, unless I had to
(22:21:10) mattock: even though I have no trouble compiling stuff myself
(22:21:10) dazo: exactly :)
(22:21:46) mattock: ok, so is it ~12 months release cycle?
(22:22:11) mattock: unless the beta/rc releases seem to be very stable
(22:22:20) mattock: in which case perhaps a little less
(22:22:25) dazo: yes, I think actually that makes sense
(22:22:45) mattock: dazo: so beta2.2 will be out in a week?
(22:22:49) dazo: the beta2.2, I think can go quicker ... as the changes are=
 mostly bugfixes and minor enhancements
(22:23:06) cron2: re
(22:23:13) dazo: I'm ready to have a rebased the beta2.2 branch soon, so ne=
xt week would be doable
(22:23:21) ***cron2 just wants to say that "6 months" sounds like a workabl=
e compromise
(22:23:39) dazo: cron2:  from GA release to GA release?
(22:23:43) cron2: yes
(22:23:46) mattock: I'd say we see what happens with beta2.2
(22:23:51) mattock: and continue from there
(22:23:58) ecrist: http://pastebin.com/5TrurYXA
(22:23:58) mattock: we're all just guessing here :)
(22:24:07) dazo: yeah, I'm worried that may too quick
(22:24:10) ecrist: that's the numbers from the current ftp server
(22:24:13) cron2: mattock: yes
(22:24:24) ecrist: I don't have numbers available for the original ftp serv=
er handy
(22:24:38) dazo: it's better than I expected
(22:24:44) cron2: dazo: I'm worried that it's too slow :-)  (IPv4 run-out i=
n less than 12 months now).  So it sounds like a compromise - everbody unha=
ppy, but workable
(22:25:10) dazo: cron2:  fair enough ... but as I said, the beta2.2 can mos=
t probably roll much faster :)
(22:25:46) mattock: ecrist: so those downloads are through FreeBSD ports sy=
stem?
(22:25:56) dazo: beta2.3 with IPv6 ... it's not many who have tested it yet=
 ... even though I have a couple of private mails from people who promise t=
o test it after their holidays
(22:25:58) mattock: let's see how beta2.2 -> rc -> ga goes
(22:26:04) ecrist: add 23 downloads to weeks 7 and 12, and that's from the =
orig ftp server
(22:26:28) ecrist: mattock: those are freebsd ports downloads
(22:26:33) cron2: dazo: IPv6 payload is being tested by a number of univers=
ity OpenVPN servers over here, and no problem report so far
(22:26:35) mattock: ok, one of them is mine :)
(22:26:40) ecrist: and anyone who may have browsed my ftp servers to pick i=
t up
(22:26:54) cron2: no idea about IPv6 transport testing, though
(22:26:55) ***dazo has done that a couple of times
(22:27:11) mattock: ok, so let's aim for 6 months but be prepared for 12 mo=
nths?
(22:27:19) dazo: cron2:  I'm getting more and more ready to setup a IPv6 fo=
r transport ... so I'll be testing that
(22:27:25) cron2: good :)
(22:27:28) dazo: mattock:  oki, I can live with that
(22:27:30) berniv6: cron2: jjo's patches have served me well for years ... =
the interaction between transport and payload will be some hassle
(22:27:47) berniv6: if the route at the client includes the VPN server
(22:27:49) cron2: dazo: there you go, testers :-)
(22:27:59) dazo: cron2:  but we might have an issue with the transport patc=
hes ....=20
(22:28:18) cron2: berniv6: yes, this is a big chunk of work - "figure out w=
hat the current routing table looks like on platform X, adjust, and restore=
 later on"
(22:28:48) dazo: cron2:  possible IPv6 transport issue ... it might break -=
-multihome .... https://community.openvpn.net/openvpn/ticket/28
(22:28:49) vpnHelper: Title: #28 (Defect --multihome feature?) =EF=BF=BD=EF=
=BF=BD=EF=BF=BD OpenVPN (at community.openvpn.net)
(22:28:57) mattock: what if we move on to the SVN merge conflict?
(22:29:11) dazo: I've not completed my setup with a couple of virtboxes yet=
 ... so I'm looking into it
(22:29:18) cron2: dazo: I'd really love to see someone rewrite the whole "s=
erver side socket handling" soonish
(22:29:25) mattock: cron2: wasn't this issue reported to Debian BTS?
(22:29:29) mattock: they include the jjo patch
(22:29:39) dazo: yes, it's in debian bts
(22:29:41) cron2: dazo: add "multiple listening sockets" and fix the multih=
oming stuff
(22:29:58) dazo: hehe :)
(22:30:00) dazo: true!
(22:30:14) mattock: SVN merge conflict, anyone? ;)
(22:30:30) dazo: if jamesyonan is around to participate on that one, then y=
es :)
(22:30:37) cron2: UDP, TCP, IPv4, IPv6, multihome, listen on unspecified ad=
dress and respond with the correct address, etc. - that's a can of worms on=
 its own :-)
(22:30:51) cron2: (and all of this, system dependent like hell, of course)
(22:30:52) dazo: cron2:  sounds like OpenVPN :-P
(22:31:04) mattock: jamesyonan: have you read this: http://thread.gmane.org=
/gmane.network.openvpn.devel/3845
(22:31:05) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(22:31:15) cron2: dazo: indeed.  (But enough of this for today, let's go to=
 conflicts!)
(22:31:23) dazo: :)
(22:31:46) jamesyonan: yeah, re: merge conflict, my intention was to suppor=
t pushing routes involving DNS names that resolve to multiple entries
(22:32:28) jamesyonan: I also disabled DNS randomization
(22:32:41) dazo: yeah ... and that I do applaud :)  I've seen some question=
s/wishes for this a couple of places .... but I'm concerned about your conc=
erns you raised a while ago, re: random resolving which disappears in this =
patch
(22:34:21) dazo: jamesyonan:  if you have changed your opinion about the ra=
ndom resolv issues you pointed out around March, I have no issues to pull o=
ut the --disable-random-resolv patch I wrote and merge in your stuff
(22:34:30) dazo: that will solve this issue immediately
(22:34:38) mattock: and this is related to the FRP: https://community.openv=
pn.net/openvpn/wiki/DeveloperDocumentation#Featuredeprecation
(22:34:39) vpnHelper: Title: DeveloperDocumentation =EF=BF=BD=EF=BF=BD=EF=
=BF=BD OpenVPN (at community.openvpn.net)
(22:35:08) mattock: dazo: wasn't this random resolving already in the featu=
re deprecation pipe?
(22:35:15) dazo: mattock:  it is
(22:35:31) dazo: https://community.openvpn.net/openvpn/report/9
(22:35:33) vpnHelper: Title: Feature Removal Process =EF=BF=BD=EF=BF=BD=EF=
=BF=BD OpenVPN (at community.openvpn.net)
(22:35:44) jamesyonan: I did initially raise some issues about removing ran=
domization, however it seemed that the consensus was that the capability wa=
s obsolete because DNS servers could handle randomization if desired
(22:36:48) dazo: okay, so I vote for pulling out and closing the disable ra=
ndom patch in FRP ... it seems jamesyonan agrees to that too, with his bett=
er solution ... anyone against?
(22:37:20) cron2: dazo: +1, less optional code bits -> good :)
(22:37:45) mattock: can our users get hurt by this? if they depend on the r=
andom resolving stuff?
(22:37:56) mattock: if so, we should follow the FRP
(22:38:36) dazo: Yes, *if* someone uses the FRP ... then yes, they will not=
ice it .... however, I think very few, if any, really do depend on it
(22:38:56) mattock: you mean "uses the random resolving"? :)
(22:38:57) dazo: we've had some mails on -devel and -users about it ... and=
 nobody have really responded
(22:39:06) mattock: that's true
(22:39:10) krzie =EF=BF=BD=EF=BF=BD ora conosciuto come krzee
(22:39:15) dazo: responded =3D "yes we/I use it"
(22:39:40) mattock: do you think the FRP is too "heavy"?
(22:40:03) jamesyonan: people can always use multiple remote options + remo=
te-random to accomplish nearly the same thing
(22:40:26) dazo: I think we can consider to skip the "disable on request ph=
ase" ... and go straight to "disabled by default, enable on request" phase
(22:40:33) mattock: jamesyonan: ok
(22:40:57) mattock: ok, so this is the first step: "Make the feature disabl=
ed by default, but allow enabling it at compile-time"
(22:41:03) dazo: yes
(22:41:16) mattock: I agree... too complex processes tend not to be followed
(22:41:32) dazo: and that will smoke out those users who really do use it
(22:41:49) mattock: yep, I'm pretty sure nobody pays attention to runtime w=
arnings
(22:42:10) mattock: and the complaints only start after a feature is disabl=
ed by default
(22:42:27) dazo: not until they ask for help on #openvpn ... and people the=
re tells them to "fix those warnings and errors first, then come back!" :-P
(22:42:32) mattock: I'll update the FRP wiki page, it's somewhat outdated
(22:42:39) dazo: thx!
(22:43:30) mattock: ok, so shall we include James' patch and bypass FRP?
(22:43:54) dazo: yes, it seems there is consensus for that now
(22:44:04) cron2: +1
(22:44:14) dazo: in regards to random resolv, that is
(22:44:26) mattock: ok, let's do that then
(22:44:30) mattock: and simplify the FRP
(22:45:17) mattock: anything else?
(22:45:32) dazo: not from my side
(22:45:33) mattock: or shall I let you know about status of forums and buil=
dbot?
(22:45:39) mattock: ok
(22:45:47) dazo: I'll clean up the beta2.2 branch ... and prepare it for ne=
xt week
(22:45:52) dazo: buildbot status, please!!! :)
(22:46:23) mattock: ok... so yesterday I managed to make buildbot build Deb=
ian Lenny amd64 packages
(22:46:37) dazo: \o/
(22:46:43) mattock: I need to dig more into Debian packaging to make sure e=
verything works properly
(22:47:14) mattock: but as long as somebody has already created OpenVPN pac=
kages, rebuilding them with different (=3D"testing") sources is pretty triv=
ial
(22:47:20) mattock: regardless of the OS in question
(22:47:35) mattock: for debian it's just "dpkg-buildpackage" (or what was i=
t)
(22:47:48) mattock: and perhaps editing of a few files
(22:48:18) mattock: anyhow, I should get at least Debian Lenny i386 VM whic=
h I can use to build i386 packages
(22:48:26) mattock: and Ubuntu 10.04 VM's should be coming up soonish
(22:48:49) dazo: building rpms should be pretty straightforward if you have=
 rpmbuild ... I think that's available as well for Debian
(22:49:16) dazo: (but building on proper RHEL/CentOS or Fedora might be mor=
e beneficial)
(22:49:27) mattock: if we want the CI stuff, too, we should have RHEL/CentO=
S/Fedora VM's too
(22:49:36) dazo: yeah
(22:49:52) mattock: also, I'd rather not try building Fedora/CentOS _binari=
es_ on a Debian box :D=20
(22:49:57) mattock: it sounds like trouble
(22:50:05) dazo: I can look into (as a low prio task) a patch for Gentoo bu=
ilds as well
(22:50:17) cron2: mattock: yep, library versions, etc. "don't go there"
(22:50:22) dazo: mattock:  it can work, if the libraries are the same
(22:50:34) mattock: in any case it would be a big hassle
(22:50:41) ***dazo agrees with cron2 though :)
(22:51:11) mattock: anyhow, do you guys have any spare VM's lying around?
(22:51:30) mattock: it seems we (at the company) don't have unlimited resou=
rces as I believed :)
(22:51:34) dazo: heh :)
(22:51:58) mattock: not much resources are required... maybe 512MB mem max.=
.. and 2-4GB disk
(22:52:11) mattock: per platform, that is
(22:52:13) dazo: I might be able to dig up something .... I have access to =
a server, but I don't want to misuse my trust in that organisation
(22:52:30) mattock: dazo: please don't, this is not that important
(22:52:32) dazo: that would be for CentOS ... which would cover RHEL
(22:52:50) mattock: I can also ask in the -devel mailinglist
(22:53:05) mattock: I'm sure we'll get a bunch of VM's from the community i=
f we want to
(22:53:16) mattock: and also get the (user) community involved
(22:53:40) dazo: mattock:  for RHEL/CentOS and Fedora ... there's already k=
oji which is available for all Fedora packagers .... and you can do so call=
ed scratch builds, which will build for the given platform .... and you can=
 download the packages when done
(22:54:06) mattock: hmm, koji... heard of that
(22:54:42) mattock: ok, but koji is _just_ a buildsystem, right?
(22:54:43) dazo: mattock:  you basically do .... koji build --scratch --tar=
get dist-epel-EL5 <source rpm>
(22:54:56) mattock: oh, I see
(22:55:06) mattock: so I could have CentOS VM and build for several platfor=
ms?
(22:55:18) dazo: yeah, koji is just for building=20=20
(22:55:48) dazo: mattock:  you could even have whatever OS, you just need t=
o have the needed Python libs for the koji client ... and be able to produc=
e src.rpms
(22:56:00) mattock: I think we should have one VM/server for each platform/=
architecture... to get the full benefit of Continuous integration (=3Dbuild=
 failure notifications)
(22:56:42) dazo: mattock:  http://koji.fedoraproject.org/koji/packageinfo?p=
ackageID=3D10647 .... that's the build I did for eurephia
(22:56:43) cron2: well, for the most commonly used ones, yes
(22:56:44) vpnHelper: Title: eurephia | Package Info | Koji (at koji.fedora=
project.org)
(22:56:51) mattock: cron2: agreed
(22:56:56) cron2: I have my doubts that "NetBSD/Sparc32" is a mass market :)
(22:57:05) dazo: heh :)
(22:57:14) mattock: and the nice thing is that the community can provide bu=
ildslave VM's for those corner cases
(22:57:42) cron2: OTOH, NetBSD/Sparc64 is a fairly good test platform, as i=
t's "wrong endian" and 64 bit time_t !=3D 32 bit int, and other interesting=
 surprises to sloppy C programmers
(22:57:45) mattock: they only need to have buildbot running in "slave" mode=
 and have the password
(22:58:21) dazo: cron2:  would ppc64 be sufficient?  that's also a big-endi=
an platform
(22:58:27) mattock: of course, we have to trust the people running the slav=
es. Although commands only go from master -> slave, but still
(22:58:49) cron2: dazo: as far as I understand, it uncovers similar bugs, y=
es
(22:58:58) mattock: cron2: I think we should definitely get these funky pla=
tforms to make sure the code is portable
(22:59:12) dazo: mattock:  trust can be built by letting master and slaves =
communicate over VPN ;-)
(22:59:13) cron2: mattock: yes
(22:59:21) mattock: I'll send mail to -devel tomorrow
(22:59:31) dazo: and if they fail us ... remove access, and harm is reduced=
 immediately
(22:59:50) mattock: dazo: yep, good idea
(23:00:20) cron2: mattock: but those are not really VM friendly, so you nee=
d "real iron".  I think I can provide Sparc64/Solaris10 and Sparc64/NetBSD,=
 if someone tells me how to setup things
(23:00:37) mattock: cron2: that'd be great!
(23:00:45) mattock: although I have no idea how to set them up
(23:01:11) cron2: mattock: can you put into the wiki how to setup buildbot =
as a slave?
(23:01:22) mattock: it'd be best if we got the VM's / servers from somebody=
 who knows them inside out and can setup buildbot him/herself
(23:01:27) mattock: cron2: will do
(23:01:43) cron2: well, I know my machines, but have never done anything wi=
th buildbot :-)
(23:02:07) mattock: cron2: ok, good... buildbot is relatively easy to setup
(23:02:16) mattock: at least on Debian/Ubuntu
(23:02:27) mattock: probably on most other platforms, too
(23:02:44) mattock: I'm not sure how picky it's about server<->client softw=
are versions, though
(23:03:19) mattock: I'll setup buildbot on this laptop tomorrow and documen=
t the generic process to Trac
(23:03:23) mattock: and send mail to -devel after that
(23:03:34) cron2: cool
(23:03:51) mattock: omg, I got to setup OpenVPN with LDAP auth, too, first
(23:03:58) mattock: as agreed in earlier meeting
(23:04:04) mattock: much to do for tomorrow :)
(23:05:25) mattock: so in a nutshell, the buildbot setup would be as follow=
s:
(23:05:25) mattock: - access to buildbot and buildbot web interface would b=
e through OpenVPN
(23:05:25) mattock: - OpenVPN would authenticate against LDAP
(23:05:25) mattock: - some buildslaves would be provided by the company, ot=
hers by the community
(23:05:51) mattock: so, if you're contributing a buildslave, you could acce=
ss the buildbot web interface and see what's happening
(23:05:59) mattock: if you're not, then you don't have any access
(23:06:02) cron2: yep
(23:06:04) mattock: expect to the resulting packages
(23:06:29) mattock: ok, that's about it I guess
(23:06:35) mattock: a quick update on forums
(23:06:48) mattock: so everything's pretty much set... only theming is miss=
ing
(23:07:10) mattock: I tested migrating existing ovpnforum.com user into LDA=
P, sending them new random password in mail and it all worked great
(23:07:26) mattock: the launch date is set as Aug 13th
(23:07:48) mattock: so there's plenty of time left
(23:08:06) mattock: I guess that's all from me
(23:08:10) mattock: anything else?
(23:08:28) dazo: sounds good to me :)
(23:08:34) dazo: been a long and good meeting today :)
(23:08:55) mattock: correction: I tested migrating _fake_ ovpnforum.com use=
rs to LDAP :)=20
(23:09:01) mattock: yep, only 2 hours
(23:09:04) mattock: :D
(23:09:07) dazo: :)
(23:09:20) mattock: anyways, I'll summarize all of this tomorrow
(23:09:33) mattock: expect the first part
(23:09:34) mattock: :)
(23:09:44) mattock: see you guys later!
(23:09:46) mattock: good night!
(23:10:02) dazo: good night!
(23:10:08) cron2: good night!

--------------030406010604070401090406--

