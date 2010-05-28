Message-ID: <4BFFC302.9080700@...515...>
Date: Fri, 28 May 2010 16:20:02 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030101090500070300030309"
Subject: [Openvpn-devel] Summary of the IRC meeting (27th May 2010)
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
--------------030101090500070300030309
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 27th May 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-05-27>

Next meeting next week, same place, same time. Your local meeting time
is easy to check from services such as

<http://www.timeanddate.com/worldclock>

or with

$ date -u


SUMMARY

Discussed the final missing piece of our development process puzzle: how
to get code from "testing" into an official release. Agreed on the
following process:

1) Features to include will be selected from the "testing" tree
2) Features will be stabilized until they don't change much
3) A staging "stable candidate" branch will be created
4) Beta/rc releases will be published based on this staging branch (to
get people to _really_ test the code)
5) Bugs in the staging branch and beta/rc releases based on it will be
fixed as they are found
6) Once staging branch is deemed stable enough, an official release will
be made

The staging branch will be kept in James' SVN repository.

--

Discussed testing in some detail. Agreed that both manual (human) and
automated testing are important. There are plans for doing both. Samuli
will start building a build + release + publish server a.s.a.p. to
distribute "testing" snapshot packages. These snapshot packages will be
linked to from openvpn.net.

--

Discussed an existing project, Magic Tunnel Daemon (mtund), which we
could perhaps use as part of OpenVPN 3.0 core:

<http://wiki.freebsd.org/mtund>

---

Discussed the bridge section in the FAQ:

<http://openvpn.net/index.php/open-source/faq.html#bridge1>

Krzee suggested adding something like this: "Another bridge disadvantage
is that layer2 is insecure by design. Opening your layer2 exposes you to
arp poisoning and the like."

Agreed that pointing this out in the FAQ is a good idea, as this is not
widely understood (e.g. in OpenVPN IRC channel).

--

Discussed the bridge-start and bridge-stop scripts found from
sample-scripts directory (and openvpn.net):

<http://openvpn.net/index.php/open-source/documentation/miscellaneous/76-et=
hernet-bridging.html#linuxscript>

Agreed that the scripts are broken. Also agreed that making "universal"
scripts that just work on any/most OS'es is very difficult. Agreed that
the scripts should be intentionally disabled by default as well be more
heavily commented so that nobody uses them accidentally without
understanding bridging basics. Waldner volunteered to make these fixes
and send them for review.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------030101090500070300030309
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-05-27.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-05-27.txt"

(21:14:33) mattock: hi james!
(21:14:37) jamesyonan: hi guys
(21:14:41) CareBear\: hi James
(21:14:46) krzee: hey james
(21:14:48) dazo: hi!
(21:14:50) waldner: hi
(21:14:51) krzee: brb
(21:14:54) krzee ha abbandonato il canale (quit: Quit: Leaving).
(21:15:31) mattock: topics for today are here: https://community.openvpn.ne=
t/openvpn/wiki/Topics-2010-05-27
(21:15:36) vpnHelper: Title: Topics-2010-05-27 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN (at community.openvpn.net)
(21:15:52) mattock: we have big one today, as you can see
(21:16:37) mattock: which is... how do we get code from "testing" to releas=
e (possible via James' stable tree)
(21:16:38) mattock: ?
(21:17:30) mattock: james: any thoughts on this issue?
(21:18:37) cron2: mattock: the most important one, yes :-)
(21:19:25) mattock: so basically we have a "hole" in our development proces=
s... no path leads from testing to release yet
(21:19:34) mattock: at least no documented path
(21:20:09) cron2: exactly, and this needs to be defined - otherwise the "co=
mmunity tree" and the "openvpn tech tree" are in danger of really moving fu=
rther and further apart
(21:20:16) cron2: worst case, leading to a split
(21:20:26) jamesyonan: I'm completely swamped for at least the next month o=
r two -- we need to develop a process for merging that takes a minimum amou=
nt of my time
(21:20:42) dazo: From my point of view ... we have a couple of possibilitie=
s ... I do understand that testing the openvpn-testing code is important, b=
ut I'm seeing it from the perspective of that being fine (testing is good f=
or a stable tree)
(21:21:36) dazo: one approach is that jamesyonan indicates to me which feat=
ures / branches he is interested in ... I can produce a set of patches for =
him which he can apply to the SVN tree ....=20
(21:22:21) dazo: another approach is that James clones the git tree, and us=
es git to push the branches he is interested in into the SVN  tree via git-=
svn ... then he can do svn merging how he likes it
(21:22:23) cron2: that would certainly save lots of time
(21:22:31) cron2: (the former)
(21:22:32) jamesyonan: that could certainly work
(21:23:14) dazo: the disadvantage of the first one ... I'm afraid the openv=
pn-testing tree needs to be re-generated, as I'm not sure how well git will=
 detect duplicate patches this way
(21:23:50) dazo: the latter one, this one will make it easier to track thin=
gs for me with git-svn afterwards
(21:23:57) cron2: ack
(21:24:44) dazo: actually, there is a third option ... and that is that I g=
et write access to the svn tree ... and I could push the branches James wan=
ts there
(21:25:09) dazo: (but that requires some config/admin changes at openvpn)
(21:25:41) cron2: this might work in the long run, bugt I have the feeling =
that James will want to review all this "community" stuff closely beforehand
(21:25:55) dazo: cron2:  agreed
(21:26:13) dazo: and I didn't mean merge into BETA21 branch ... I meant pus=
h to a separate SVN branch=20
(21:26:17) mattock: also, I think we should discuss what to include in the =
next 2.x release together
(21:26:56) mattock: no matter what technique we use
(21:27:27) dazo: mattock:  yeah, that's appropriate ... but I'd say that's =
secondary to figure out how we get the stuff into James' tree
(21:27:39) mattock: dazo: true
(21:27:49) cron2: and on a tangent, how many releases do we want (-> how bi=
g the changes)
(21:28:32) krzee [~k@...1336.../krzee] =EF=BF=BD=EF=BF=BD entrato nel canal=
e.
(21:28:32) mattock: cron2: I think we should try to make relatively frequen=
t releases with small amount of new functionality
(21:29:37) dazo: I'd say we could have one which would contain stuff from b=
ugfix2.1, feat_misc and feat_eurephia .... another one which would be feat_=
ipv6_payload and feat_ipv6_transport=20
(21:29:41) cron2: we have a few quite big patches in there...  vlan, v6 pay=
load, v6 transport
(21:29:49) mattock: I think most people won't touch "testing" versions or S=
VN/Git code anyways
(21:30:51) dazo: feat_vlan is not completely accepted into allmerged yet ..=
.. missing better review and testing + it depends on feat_passtos which has=
 not been merged nor tested (and the developer seems to have disappeared fr=
om the radar)
(21:32:40) cron2: well, and I'm afraid neither feat_ipv6_* has seen *review=
*... - testing, yes, but no code review...
(21:32:54) mattock: so which approach should we take... number one: "anothe=
r approach is that James clones the git tree, and uses git to push the bran=
ches he is interested in into the SVN  tree via git-svn ... then he can do =
svn merging how he likes it"
(21:33:05) mattock: sorry, number two
(21:33:40) dazo: cron2:  but I'm comfortable with the ipv6 stuff ...basical=
ly because you are available and active in the community=20
(21:34:36) cron2: :)
(21:34:56) cron2: it has seen quite some testing, yes
(21:34:57) jamesyonan: I dazo's idea about creating a tree on svn.openvpn.n=
et that would be used as a staging branch for changes that should go into s=
table.
(21:36:18) mattock: jamesyonan: so would the staging branch be relatively s=
table, receiving only bug fixes?
(21:36:36) CareBear\: dazo : feat_vlan looks very good, I looked at it as c=
arefully as I could (I'm Peter Stuge) but I do not really know anything abo=
ut OpenVPN internals so I did not know what sensitive points to look partic=
ularly closely at
(21:37:20) mattock: ...and all work before creating a staging branch to SVN=
 would be done in "testing" tree?=20=20
(21:37:27) mattock: or did I misunderstand something?
(21:38:12) dazo: CareBear\:  that's sounds good!   I remember you did some =
review as well, but didn't get it as a clear ACK for merge :) ... cron2 wou=
ld you have a chance to look at the patches as well?
(21:38:35) dazo: mattock:  I would probably prepare a git branch which I wo=
uld push over to the SVN branch
(21:38:50) dazo: mattock:  and then James would merge them together
(21:39:03) mape2k ha abbandonato il canale (quit: Ping timeout: 276 seconds=
).
(21:39:07) jamesyonan: yes, I think the staging branch would only contain s=
tuff where there's general agreement that it should be merged with stable
(21:39:19) dazo: mattock:  the contents of that 'next' branch, would be tho=
se git branches we agree on in these meetings
(21:39:19) CareBear\: dazo : I didn't want to ack since I didn't know what =
(if anything) was critical
(21:39:35) dazo: CareBear\:  yeah, I understood ... and that's fair enough =
:)
(21:40:33) mattock: dazo: ok, sounds like a good idea... so the "next" bran=
ch would be a kind of non-released beta/rc=20
(21:40:48) mattock: a constantly evolving beta/rc, to be more exact
(21:41:30) dazo: mattock:  s/"next"/staging/  :)  ... yeah, the staging bra=
nch would contain what's prepared for James to merge into his release
(21:42:10) mattock: and your "staging/next" git branch already contains Jam=
es' stuff, right?
(21:42:19) mattock: from James' own SVN branch(es)
(21:42:23) cron2: yes
(21:42:39) mattock: great!
(21:42:40) dazo: yes
(21:42:53) dazo: well
(21:43:13) dazo: actually ... the staging branch could contain just the cha=
nges itself
(21:43:33) dazo: but it would be more challenging with bugfix2.1 and feat_m=
isc branches, as they are based differently
(21:44:02) dazo: ie.  not SVN changes from James
(21:44:27) mattock: ok
(21:45:04) dazo: jamesyonan:  it might be an idea for you to test out the b=
ranch merging in a separate branch - just to see how well the merge goes
(21:45:46) ***dazo suspects some merge conflicts in worst case
(21:47:18) mattock: so this would happen prior to a release... 1) features =
to include would be selected, 2) features would be "stabilized" until they =
are relatively stable (=3Ddon't change much), 3) a staging branch would be =
created, 4) beta/rc releases would be published based on the staging branch=
 (to get people to _really_ test the code), 5) once staging branch is deeme=
d stable enough, an official release could be made
(21:47:43) cron2: this sounds good to me
(21:47:48) dazo: +1
(21:47:50) mattock: and of course, bugs would be fixed in the staging branc=
h as they're found
(21:47:51) jamesyonan: agreed, we should create and test the result of the =
merge before it becomes the stable branch
(21:49:02) dazo: one detail question then: How do we get my staging branch =
into the SVN staging branch?
(21:50:56) jamesyonan: Isn't there a git -> svn connector?
(21:51:51) mattock: also, does it matter whether the staging branch is in S=
VN or Git repo?
(21:52:03) dazo: jamesyonan:  yes, I can push to SVN branches
(21:52:07) CareBear\: jamesyonan : there is git-svn
(21:52:20) CareBear\: ie. git natively supports interaction with svn repos
(21:52:48) CareBear\: albeit with limited functionality
(21:53:24) CareBear\: (because of differences between git and svn)
(21:54:12) dazo: jamesyonan:  or, of course, you can pull the git tree and =
push to SVN yourself ... if you prefer that instead :)
(21:54:47) ***dazo is open to do what it takes to make this work out
(21:56:17) jamesyonan: The thing that works best for me would be an svn bra=
nch that essentially represents a "stable candidate", where we can test it =
and then promote it to stable.
(21:56:35) dazo: that works for me
(21:56:58) mattock: jamesyonan: sounds good
(21:57:03) jamesyonan: cool
(21:57:06) cron2: cool :)
(21:57:20) dazo: and we avoid a potential challenging merge in SVN from the=
 staging branch to BETA21
(21:58:27) dazo: (basically, because I have merged in everything based on t=
he BETA21 already in git)
(21:59:18) mattock: ok, so who handles management of the "stable candidate =
/ staging" branch in SVN?
(22:00:01) ***krzee points at david and hides
(22:00:21) ***dazo throws a paper ball after krzee=20
(22:00:36) cron2: dazo seems to be the master of version control :-)
(22:00:43) mattock: cron2: +1
(22:01:04) dazo: geeee .... I've must have been a good actor! :-P
(22:01:05) CareBear\: that can be a fair bit of work, unless the source for=
 that branch is already kept clean as a matter of cooperation
(22:01:46) dazo: CareBear\:  it would basically be to merge svn-BETA21, and=
 the feature branches we want in the next release ... and then push it to S=
VN
(22:01:55) cron2: well, since dazo only accepts patches that are reviewed a=
nd follow style, it *is+ fairly clean
(22:02:12) dazo: CareBear\:  that's a rather trivial task for me in git :)
(22:02:33) CareBear\: as long as feature branches apply cleanly
(22:02:41) CareBear\: merge cleanly
(22:02:52) dazo: Be sure! :)
(22:03:04) CareBear\: if I were to add a feature - what would I start with?
(22:03:13) CareBear\: testing branch, or to-become-stable branch?
(22:03:18) CareBear\: all_testing, sorry
(22:03:18) cron2: feat_bugfix
(22:03:22) dazo: CareBear\:  the master branch ideally .... unless it's a b=
ugfix, then bugfix2.1
(22:03:53) dazo: actually, you can base it on bugfix2.1 for new features as=
 well
(22:03:59) dazo: cron2 is right
(22:04:07) mattock: dazo: has this been documented somewhere already?
(22:04:41) dazo: mattock:  somehow in the Developers docs ... but I've not =
reviewed it in quite a while, so it might be need that again
(22:04:44) CareBear\: dazo : so when to use all_testing ?
(22:05:19) CareBear\: or is that only for consumption, not for production?
(22:05:21) dazo: CareBear\:  the allmerged branch is all accepted branches,=
 which are merged together ... that's the real testing branch where you get=
 all the goodies at once
(22:05:22) cron2: if you want to implement something that needs a number of=
 feature branches as base...
(22:05:43) CareBear\: dazo : thanks, allmerged, sorry I messed up the name
(22:05:44) dazo: I am the only one who works on allmerged=20
(22:05:51) CareBear\: cron2 : yes, that's my point
(22:05:59) mattock: dazo, jamesyonan: can you handle the SVN staging branch=
 bureaucracy between yourselves?
(22:06:12) mattock: to get the ball rolling for next 2.x release
(22:06:28) jamesyonan: sure, if dazo's okay with it
(22:06:34) dazo: mattock:  jamesyonan: sure!
(22:06:37) mattock: great!
(22:06:41) krzee: ++
(22:06:45) CareBear\: cron2 : it means that it may take a lot longer to rea=
ch to-become-stable, but that makes good sense since the deps are required =
too
(22:07:11) cron2: CareBear: yes
(22:07:41) mattock: if I'm not mistaken, we've reached a consensus on how t=
o handle our development process :)
(22:07:46) mattock: the final stages, that is
(22:07:53) dazo: \o/
(22:08:02) krzee: ^5
(22:08:16) CareBear\: mattock : I think it's an important point to document=
 where to start contributions. Sure, not so hard to discover, but annoying =
if someone contributes to allmerged instead of feat_bugfix for no reason, t=
hus potentially delaying the integration of their work in stable.
(22:08:35) mattock: carebear: agreed
(22:08:49) krzee: yup, thats an important note for developer notes
(22:09:04) cron2: mattock: yes, I'm quite happy :-)
(22:09:22) mattock: do we need to discuss anything else regarding the devel=
opment process?
(22:09:46) cron2: testing?
(22:10:09) krzee: (reading the proposed 3.0 roadmap makes me smile!)
(22:10:12) cron2: "what are our criteria to decide whether it's stable"?
(22:10:25) mattock: cron2: that's important, agreed
(22:10:46) mattock: I think we first and foremost need more people to test =
"testing"
(22:11:13) dazo: or people to write test scripts which we can automate
(22:11:30) dazo: (but that does not exclude "human" testing in addition)
(22:11:31) mattock: dazo: people + automated testing
(22:11:52) ***dazo sensed mattock was about to say that :)
(22:12:14) mattock: dazo: am I so predicatable? ;)
(22:12:31) dazo: ;-)
(22:12:39) mattock: anyways, I think the next step (for me) is to setup a s=
erver to build + release + publish "testing" automatically
(22:12:54) krzee: i do have something to bring up... i talked to dazo about=
 it already... i showed the author of iodine (Yarrick) our beta roadmap for=
 3.0 and he showed me mtund (freebsd code from google summer of code '07) w=
hich seems to aim for some of what we're thinking, and is BSD licensed
(22:13:00) krzee: we can likely get some code from that
(22:13:12) dazo: indeed!
(22:13:13) mattock: and to link to those "testing" snapshots from openvpn.n=
et
(22:13:17) krzee: http://wiki.freebsd.org/mtund    http://p4web.freebsd.org=
/@md=3Dd&cd=3D//depot/projects/soc2007/mharvan-mtund/mtund.doc/&c=3DbtF@//d=
epot/projects/soc2007/mharvan-mtund/mtund.doc/design.txt
(22:13:18) vpnHelper: Title: mtund - FreeBSD Wiki (at wiki.freebsd.org)
(22:13:32) dazo: jamesyonan:  have a look at those links ... that's interes=
ting reading
(22:15:36) mattock: cron2: regarding what's stable... that's a tough one
(22:16:12) mattock: currently we don't know, as the new feature are not bei=
ng used widely or tested by automated tools
(22:16:12) cron2: mattock: oh, that's quite easy "every feature + every com=
bination of features does the right thing on every platform" :-) *duck*
(22:16:30) cron2: exactly
(22:16:39) mattock: cron2: "The software shall not contain any bugs"
(22:17:30) mattock: ... snippet from an unknown requirement specification
(22:18:21) mattock: anyways, I think we have solid plans for improving test=
ing - and better yet - time to actually do the work
(22:18:53) dazo: How I see it ... as long as we don't have community feedba=
ck, we do need to have some kind of automated testing which at least can te=
st most used configurations for us easily
(22:18:53) jamesyonan: mtund seems interesting -- they seem to be thinking =
along similar lines
(22:19:10) dazo: exactly
(22:19:29) krzee: yup, and bsd license, clean code!
(22:19:59) dazo: I've had a peek at the mtund code ... what I saw, that was=
 a slick to read
(22:20:13) krzee: heavily commented from what i saw
(22:21:40) jamesyonan: mtund doesn't seem to care very much about security =
-- it seems more concerned with being able to use many different kinds of t=
ransport layers
(22:21:59) mattock: dazo: we can get (more) community feedback by making us=
e of "testing" easy (snapshot binaries) and giving it visibility (linking f=
rom openvpn.net downloads)... also, there's little value in "testing" unles=
s people use it
(22:22:05) CareBear\: jamesyonan : maybe it's a good point to separate the =
security and the transport?
(22:22:07) mattock: that said, I agree that we need automated testing, too
(22:22:18) krzee: right, its not a replacement for openvpn 3.0, but rather =
something we could possibly take code for
(22:22:24) dazo: yes, that's what I saw as well ... it's lacking authentica=
tion and encryption ... except for that, it looks pretty much what we need
(22:22:25) mattock: I'd start with automating build & packaging first
(22:22:40) dazo: mattock:  great!
(22:22:46) krzee: and the security is a separate plugin hook in our 3.0 roa=
dmap
(22:22:47) waldner: that could be the transport part of OpenVPN 3.0, and wh=
at's before it will feed it encrypted data
(22:22:52) CareBear\: oh right - yes it certainly needs the vpn frontend
(22:22:55) CareBear\: waldner ++
(22:22:56) jamesyonan: certainly -- the 3.0 roadmap calls for a plugin arch=
itecture where plugins could operate at either the security (encapsulation)=
 or transport level
(22:23:05) CareBear\: *nod*
(22:23:36) jamesyonan: but mtund doesn't really talk about the crypto being=
 part of the plugin architecture
(22:23:54) krzee: i dont believe it does crypto, but that was on the todo l=
ist
(22:23:56) mattock: omg, freebsd uses Perforce repositories... that a big m=
inus :)
(22:24:09) krzee: "Authentication and encryption would likely not be addres=
sed. However, one can always set up IPSec on top of the tun interface."
(22:24:43) krzee: so we cant steal that part... but it looks like they did =
at least SOME of the work for us
(22:25:43) dazo: mtund is far from complete in OpenVPN 3.x point of view ..=
. but krzee is probably right, it provides quite some code which we can bas=
e OpenVPN 3.x upon ... no need to reinvent the wheel again
(22:25:48) mattock: and if the code is clean and well commented, it's a goo=
d place to start (or at least try to start)
(22:25:58) dazo: that's my thought
(22:26:08) krzee: exactly what i was thinking
(22:26:20) krzee: and the bsd license makes it easy
(22:26:22) waldner: my understanding is that there would be another plugin =
somewhere between the tun interface and the network that would encrypt/decr=
ypt the data to/from the transport plugin
(22:26:41) waldner: so the transport plugin wouldn't have to care about enc=
ryption
(22:26:44) dazo: waldner:  that's correct
(22:26:50) krzee: waldner, yup thats what our roadmap has in mind so far
(22:26:57) krzee: dazo, whats the roadmap link again?
(22:27:08) dazo: waldner:  or ... it could also go in front of as well=20
(22:27:14) ***dazo looks up the url
(22:27:27) dazo: https://community.openvpn.net/openvpn/wiki/RoadMap
(22:27:28) vpnHelper: Title: RoadMap =EF=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN (a=
t community.openvpn.net)
(22:27:31) waldner: well, it will probably depend on the exposed functional=
ity
(22:27:35) krzee: gracias =3D]
(22:27:52) dazo: waldner:  exactly
(22:28:04) waldner: they could even reside in different machines
(22:28:14) waldner: one machine encrypts, another just tunnels
(22:28:21) waldner: well maybe that's too ambitious
(22:28:23) waldner: :)
(22:28:24) krzee: waldner, and thats a + cause it allows for many different=
 transports as well as using things besides openssl for the crypto if soemo=
ne makes the plugin
(22:28:26) dazo: waldner:  theoretically yes .. :P
(22:28:46) dazo: but basically, it depends on the SSL plug-in
(22:28:48) waldner: krzee: agreed
(22:29:01) dazo: anyhow ... we're far away from the agenda now
(22:29:18) CareBear\: not too ambitious - I think that will allow pretty in=
teresting use cases
(22:29:20) mattock: dazo: good point, didn't want to stop you devs from dro=
oling over 3.0 plans :)
(22:29:30) waldner: CareBear\: true
(22:29:54) mattock: krzee: do you want to discuss the bridging issue?
(22:30:03) ***dazo has been evaluating hardware encryption - which does the=
 encryption as a network service
(22:30:14) krzee: sure, i had to reboot :( can you gimme the agenda again?
(22:30:22) mattock: yep: https://community.openvpn.net/openvpn/wiki/Topics-=
2010-05-27
(22:30:23) vpnHelper: Title: Topics-2010-05-27 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN (at community.openvpn.net)
(22:30:39) krzee: ok
(22:30:55) krzee: in http://openvpn.net/index.php/open-source/faq.html#brid=
ge1 it talks about advantages and disadvantages of bridge / routing
(22:30:56) vpnHelper: Title: FAQ (at openvpn.net)
(22:31:04) krzee: i believe another disadvantage should be mentioned for br=
idging
(22:31:12) krzee: "Another bridge disadvantage should be that layer2 is ins=
ecure by design, opening your layer2 exposes to arp poisoning and the like."
(22:31:45) cron2: this is true
(22:32:06) waldner: but it's true of any bridging, eg the local LAN as well
(22:32:30) cron2: yxes
(22:32:32) krzee: exactly
(22:32:32) cron2: argh
(22:32:37) krzee: and people dont understand that
(22:32:50) krzee: they create bridges for untrusted users because they dont=
 know better
(22:33:09) krzee: its definitely a disadvantage, and the user should be awa=
re of it before using bridge
(22:33:22) krzee: if they choose to after being aware, thats fine =3D]
(22:33:37) krzee: also, ive come across people (myself included years ago) =
that ran into the issue where default route isnt made when bridging, the fi=
x is to add route command at the end of sample-scripts/bridge-start
(22:33:39) waldner: well I'd say that if they don't trust the users, they s=
houldn't allow them VPN access in the first place
(22:33:44) ***dazo hope this will not include another startup warning in Op=
enVPN ....
(22:33:57) krzee: waldner, ie: VPN providers
(22:34:04) waldner: ok I see
(22:34:07) krzee: dazo, it definitely should not!
(22:34:10) cron2: waldner: it's a matter of trusting them to access the int=
ernal servers on well-defined interfaces, or whether they permit them to st=
eal traffic between other machines in the LAN...
(22:34:18) krzee: dazo, im just saying for inclusion in that portion of the=
 website
(22:34:48) dazo: krzee:  yeah :)  Just wanted to be sure your intention is =
understood correctly
(22:35:12) krzee: cool =3D]
(22:35:27) mattock: jamesyonan: shall I send krzee's FAQ modification to Fr=
ank?
(22:35:34) mattock: or who'll take care of it?
(22:35:44) mattock: (I assume we agreed the change makes sense)
(22:36:31) krzee: CareBear\, you said you often use bridge, can you comment=
 on whether or not bridge-start sample script should add gateway at the end?
(22:36:43) cron2: no
(22:36:51) cron2: it really depends on what you want to achieve
(22:37:00) CareBear\: krzee : I always use my own scripts
(22:37:06) krzee: maybe i (and the others who needed to do this) did someth=
ing wrong that required this
(22:37:20) CareBear\: krzee : I typically have a very small up script that =
adds the tap to the bridge
(22:37:25) CareBear\: (on the server)
(22:37:46) krzee: for me, running the bridge-start script would result in g=
ateway loss, and i had to request a remote reboot, adding a line to set gat=
eway at the bottom fixed it
(22:38:10) CareBear\: I usually have custom network config scripts too
(22:39:03) waldner: bridge-start, as it is now, may actually drop one's def=
ault gateway, if that happened to be via eth0
(22:39:33) waldner: because when br0 is reassigned eth0's IP, it only recre=
ates the connected route, not anoy other routes that were going via eth0
(22:39:34) CareBear\: if bridge-start comes with openvpn that's kinda bad
(22:39:55) CareBear\: (it's always bad, but something bad for "us" to fix)
(22:39:59) krzee: its in sample-scripts/
(22:40:02) CareBear\: ouch
(22:40:18) krzee: as well as posted at http://openvpn.net/index.php/open-so=
urce/documentation/miscellaneous/76-ethernet-bridging.html
(22:40:19) vpnHelper: Title: Ethernet Bridging (at openvpn.net)
(22:40:24) krzee: (bottom)
(22:40:32) CareBear\: then I'm in favor of one of two solutions;
(22:40:33) waldner: I haven't tried it to be honest, but looking at it now =
I wouldn't be surprised if that happened
(22:41:06) CareBear\: 1. fix the issue completely - this is very difficult =
because it means that that script needs to support bridging on lots of diff=
erent systems
(22:41:10) waldner: and also bridge-stop looke even more seriously flawed t=
o me
(22:41:30) CareBear\: 2. the check-OCSP approach; make the script safe, but=
 not fully functional
(22:41:31) waldner: it just deletes the bridge without doing *anything* wit=
h eth0
(22:41:35) jamesyonan: re: layer 2 security -- a lot of people really like =
layer 2 because of the broadcast propagation, and I think many of these peo=
ple are okay with a security model where every user has complete trust, and=
 where there is no secondary access control system that occurs after VPN au=
thentication
(22:41:46) krzee: CareBear\, if given working scripts for multiple OS ild b=
e happy to merge them
(22:42:04) CareBear\: jamesyonan : agree - I consider L2 an important featu=
re of any VPN solution!
(22:42:23) CareBear\: jamesyonan : there are certainly cases where L2 is no=
t desirable, but then it can be disabled
(22:42:45) krzee: jamesyonan, i fully agree, but i believe in that link in =
FAQ with advantages and disadvantages that opening up the ends to arp poiso=
ning should be listed as a disadvantage
(22:43:01) mattock: so what to do with bridge-start and bridge-stop?
(22:43:15) krzee: (which can be overcome, but in that case having windows f=
ilesharing cant be an 'advantage' because WINS overcomes that)
(22:43:18) jamesyonan: I think the point is that we should be clear that la=
yer 2 is only for people who don't care about secondary access control
(22:43:37) waldner: mattock: they can be changed, but it's difficult to wri=
te something that will "just work" for any possible scenario
(22:44:09) krzee: its a point that people in the help channel often dont kn=
ow about (the arp poisoning over layer2 bridge)
(22:44:18) waldner: certainly they should not be as they are now, imho
(22:44:20) CareBear\: it's even hard *within* openvpn to mess with default =
gateway
(22:44:23) cron2: ok, folks, need to leave now - bring $wife and $child to =
bed (and try to get enough sleepy myself).  Good meeting, though!
(22:44:31) mattock: waldner: agreed... could we do something easy that woul=
d make the scripts better?
(22:44:38) krzee: gnite cron2 !
(22:44:41) mattock: cron2: good night!
(22:44:42) waldner: good night
(22:44:43) CareBear\: that's C and has full access to state - in a shell sc=
ript it would just be painful
(22:44:45) CareBear\: bye cron2
(22:44:58) jamesyonan: bridging is tough to set up because of the way that =
it's generally implemented in the kernel, i.e. using a virtual bridge device
(22:45:19) dazo: cron2:  c'ya! :)
(22:45:23) CareBear\: hard =3D needs more than one single configuration dir=
ective on/off
(22:45:44) CareBear\: jamesyonan : maybe it could be implemented by calling=
 external tools..
(22:46:03) waldner: I've always done it the safe way, eg using a permanent =
br0, and my bridge-start only adds tap0 to the bridge
(22:46:06) krzee: im only suggesting a 1 line addition to the FAQ based on =
users not knowing (and sometimes caring) about it (and i believe it qualifi=
es as a disadvantage, which may or may not matter to the user)
(22:46:23) CareBear\: krzee : I also agree there should be action
(22:46:29) waldner: mattock: but yes, that could perhaps be discussed in a =
meeting.
(22:46:30) dazo: CareBear\:  would be an approach ... but difficult when we=
 need to support a lot of platforms too
(22:46:41) CareBear\: *nod*
(22:48:03) krzee: mattock, if its decided to make new bridge scripts for mu=
lti-OS, ild be happy to work on it if given scripts for OS's that currently=
 work (basically just merging them into 1 script for multiple OS)
(22:48:19) waldner: if users are going to copy and paste them, we'd need so=
mething that at least does not disrupt the existing setup
(22:48:25) krzee: it would be easy, but i know most in here have more impor=
tant stuff to do (things im unable to accomplish)
(22:49:24) dazo: krzee:  that's easy on *nix ... but scripting on Windows t=
hat'll require a completely different script
(22:49:36) krzee: does bridging in windows use a script!?
(22:49:37) mattock: krzee: what about basing the scripts against LSB (or wh=
at was it?) so that they should work on most platforms...
(22:50:00) dazo: krzee:  no, but you can most probably activate it via some=
 powershell scripts
(22:50:14) waldner: mattock: posix
(22:50:24) krzee: mattock, i know nothing bout that, but if you see www.doe=
shosting.com/code/NStun.sh you can see its very easy in bash
(22:50:25) dazo: waldner:  +1
(22:50:43) krzee: (same in sh)
(22:50:48) waldner: the problem is that even the script syntax is portable,=
 every OS has its own peculiarities regarding networksetup
(22:51:03) mattock: waldner: agreed (regarding peculiarities)
(22:51:14) krzee: waldner, right, you just case the uname in bourne shell
(22:51:23) waldner: so that's not to say it can't be done, but ertainly it =
isn't as easy as it would seem
(22:51:25) mattock: so should we keep the sample scripts what they are - sa=
mple scripts
(22:51:29) mattock: ?
(22:51:53) waldner: at the *very* least, bridge-stop badlyneeds fixing
(22:52:05) waldner: (yes, the space bar is striking today)
(22:52:17) mattock: ok, so what about this:
(22:52:40) CareBear\: mattock : I like the check-OCSP method
(22:52:52) CareBear\: make it safe but incomplete
(22:53:07) mattock: fix any obvious mistakes in the scripts and add a warni=
ng: "this script may or may not work on your platform - please edit it as n=
ecessary"
(22:53:09) waldner: CareBear\: yes, that forces people to customize it
(22:53:29) krzee: most users dont know where to start
(22:53:35) krzee: in customizing scripts
(22:53:43) waldner: maybe comments could help
(22:53:47) krzee: half the people ive seen using bridging know 0 about netw=
orking
(22:53:53) krzee: or scripting
(22:53:54) CareBear\: krzee : then they need to be educated, to close the g=
ap
(22:54:04) waldner: well, bridge-start*already* needs customizing
(22:54:09) CareBear\: the point is that the gap is too large for developers=
 to fill in the short term
(22:54:42) mattock: also, most distros / openvpn packages should have their=
 own scripts
(22:55:03) waldner: not for bridging, AFAICT
(22:55:12) mattock: waldner: really?
(22:55:34) waldner: none of the distros I've tried comes with decent (or an=
y, for that matter) bridge scripts
(22:55:37) dazo: krzee:  if people want to setup bridging and know nothing =
about it .... I'd say they either should learn it first or not do it :-P
(22:55:56) waldner: they do provide the standard OpenVPN bundled scripts, t=
hough
(22:56:20) waldner: but I'd be happy to be proven wrong
(22:56:29) CareBear\: dazo / krzee : at least until it can be made seamless=
 by outstanding vpn software ;)
(22:56:57) dazo: but in general ... providing a good commented script, whic=
h do not work "out-of-the-box" is probably a good approach, to also teach s=
omething about what they are about to do
(22:57:15) waldner: agreed
(22:57:41) mattock: so what if we fix obvious errors in the scripts, add wa=
rnings / comments... then look into long-term solutions (e.g. "generic" bri=
dge scripts that "just work")
(22:57:42) dazo: CareBear\:  true :)
(22:57:48) krzee: well yes i agree, please join in the IRC channel to help =
educate them :-p
(22:57:49) mattock: dazo: +1
(22:57:51) krzee: lol
(22:58:16) dazo: krzee:  heh ... you see where I'm most active nowadays :-P
(22:58:17) mattock: bridge scripts that "just don't work" don't help much :)
(22:58:38) CareBear\: yes, it's a great point to document in the script why=
 it is crippled - or it will look like developers are just holding back to =
be mean
(22:58:50) mattock: can we _finally_ end the meeting and this script discus=
sion? :D
(22:58:51) dazo: +1
(22:58:53) krzee: dazo, i was being a smartass, and certainly not talking t=
o you (you do educate many people in there now)
(22:58:57) mattock: carebear: +1
(22:59:06) krzee: (including myself ;] )
(22:59:08) waldner: well, it's impossible to have a bridging script thatwor=
ks without any kind of customization I'd say
(22:59:14) dazo: krzee:  not as often now as earlier ;-)
(22:59:24) krzee: CareBear\, thats a good point. +1
(22:59:32) ***dazo mostly lurks on ##openvpn nowadays
(23:00:35) waldner: also it should be decided if it should be run before st=
arting OpenVPN, or as a --up script, client/server, etc.etc.
(23:00:51) waldner: so it can probably be done, but needs some thought
(23:00:59) waldner: (ok, it's late)
(23:01:01) mattock: waldner: so users need to educate themselves with help =
from dazo and krzee... and then customize their bridge script accordingly :)
(23:01:28) ***dazo considers to throw a rock in mattock direction now
(23:01:28) waldner: we can help them with comments, and educate them on how=
 to customize
(23:01:39) mattock: let's fix the scripts and make sure people understand t=
hey need to modify them
(23:01:48) waldner: yes definitely
(23:02:25) krzee: mattock, actually im not very useful educating users on b=
ridging, mostly i show them why they dont need a bridge ;]
(23:02:32) mattock: ok, so script issues settled for now?
(23:02:35) krzee: (unless they actually do, which is rare)
(23:02:44) krzee: yes
(23:02:44) waldner: I can write a draft bridge-start and stop to be further=
 discussed
(23:02:53) mattock: waldner: that'd be great!
(23:02:53) krzee: waldner, would be great
(23:02:57) dazo: waldner:  that would be awesome!
(23:03:01) waldner: \o/
(23:03:05) waldner: ok ok :)
(23:03:10) dazo: heh :)
(23:03:23) mattock: waldner: do you notice how we hook people into committi=
ng themselves? ;)
(23:03:33) waldner: :)
(23:03:37) ***dazo appoints waldner as the educator for now :)
(23:03:54) mattock: ok, it's getting mighty late here, anything else anyone?
(23:03:57) krzee: yay waldner /o\ (thats a handstand)
(23:04:16) mattock: we've already covered _a lot_ and it's been a great mee=
ting!
(23:04:23) waldner: true
(23:04:26) dazo: thanks a lot everyone!
(23:04:33) krzee: yup, good meeting!
(23:04:35) dazo: it's been a good meeting, indeed
(23:04:37) waldner: thanks
(23:04:51) mattock: I'll try to summarize the meeting tomorrow evening or o=
n Saturday
(23:05:00) mattock: bye all, I'm off to bed!
(23:05:06) dazo: perfect! thx a lot, mattock=20
(23:05:14) mattock: you're welcome!
(23:05:22) krzee: gnite mattock=20
(23:05:28) waldner: good night
(23:05:29) CareBear\: bye mattock
(23:05:32) dazo: gnite all
(23:05:38) ***dazo heads off to bed as well

--------------030101090500070300030309--

