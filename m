Message-ID: <4CB80C49.8090102@...515...>
Date: Fri, 15 Oct 2010 11:09:45 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080508060006070503060206"
Subject: [Openvpn-devel] Summary of the IRC meeting (14th Oct 2010)
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
--------------080508060006070503060206
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 14th Oct 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-10-14>

Next meeting will be announced in advance, but will be on the same
weekday and at the same time. Your local meeting time is easy to check
from services such as

<http://www.timeanddate.com/worldclock>

or with

$ date -u


SUMMARY

Mattock gave a brief update on buildbot's current status. The idea was
that a mail to openvpn-commits list would trigger a build on all
buildslaves. Everything works fine, except that buildbot is
(surprisingly) lacking a Git commit email parser. Mattock will try to
write one based on existing ones and if that fails, he'll upgrade
buildbot and use the new GitPoller instead.

--

Mattock gave an update on status of the public test server. He received
the credentials and already installed some software on it. Further work
on it will be postponed until buildbot work is finished.

--

Discussed the OpenVPN 2.1.3 installer for Windows 2000. There have been
a few queries regarding it, and it's already available here:

<http://secure.openvpn.net/win>

It was decided earlier to support Win2k on OpenVPN 2.1.3 but not on
subsequent releases:

<http://thread.gmane.org/gmane.network.openvpn.devel/3927>

Mattock asked jamesyonan to sign the installer so that it can be added
to the official download page.

--

Discussed the "Support SOCKS plain text authentication" patch:

<https://community.openvpn.net/openvpn/ticket/62>

Decided to merge the patch into the git repository. However, later the
whole socks.c would require cleaning up, e.g. to replace the raw hex
message codes with macros.

--

Discussed the "HTTP/1.1 Host header" patch:

<http://thread.gmane.org/gmane.network.openvpn.devel/4039>

It has been ACK'd by several people and is on it's way to the git
repository.

--

Discussed the "dynamic-Iroute config option for automatic iroutes" patch:

<http://thread.gmane.org/gmane.network.openvpn.devel/4059>

There were a few concerns regarding this patch:

a) Possibility of routing loops, e.g. if there are two mesh networks
with a double-IP-used conflict, one could end up in endless "ip route
add" / "ip route del" switching.

b) The patch should be rebased against the bugfix2.1 branch

c) It should be possible to #ifdef out the core dynamic-iroute code

d) An extra argument is added to multi_get_instance_by_virtual_addr()

It was suggested that if a), b) and c) are sorted out, this patch could
go into it's own git branch and be tested there. Later it could be
merged into main development code.

Mattock agreed to contact the patch author about these issues.

--

Discussed integrating Coverity code analysis tool into buildbot.
Jamesyonan told that we have license to use their tools. Unlike many OSS
projects, our license _is not_ tied to their "Scan" project:

<http://scan.coverity.com/about.html>

Jamesyonan agreed to send mattock the necessary details so that Coverity
analysis can be integrated into the build process (or buildbot).

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------080508060006070503060206
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-10-14.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-10-14.txt"

(21:04:18) mattock: topic list is here: https://community.openvpn.net/openv=
pn/wiki/Topics-2010-10-14
(21:04:20) vpnHelper: Title: Topics-2010-10-14 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN Community (at community.openvpn.net)
(21:04:27) mattock: I'll mail james now
(21:06:31) mattock: ok, sent
(21:06:52) mattock: perhaps I'll give a brief update on buildbot and the pu=
blic test server
(21:06:53) mattock: ?
(21:07:10) dazo: +1
(21:07:34) krzee: pls do
(21:07:36) mattock: okey dokey
(21:07:58) mattock: so buildbot first... I was thinking that I could make e=
verything work smoothly by the end of this week
(21:08:10) krzee: even windows?
(21:08:25) mattock: the idea was that a mail to openvpn-commits would trigg=
er a build on all buildslaves
(21:08:38) cron2: +1 :)
(21:08:39) mattock: krzee: no :)
(21:09:07) mattock: so everything went fine, e.g. getting mail to the build=
master account in correct format
(21:09:20) mattock: then I noticed that there is no Git commit email parser=
 in buildbot
(21:09:43) mattock: modifying one of the existing ones (e.g. Bzr, launchpad=
) should be relatively easy
(21:09:57) mattock: so I'll probably do that... sent mail to buildbot-devel=
 about that
(21:10:12) mattock: if that fails, I can update buildbot and use the s.c. G=
itPoller which polls the repository for changes
(21:10:47) mattock: besides that, buildbot is ready for some real work
(21:11:21) mattock: and then the test server
(21:12:10) mattock: I got the credentials and started configuring it today.=
.. nothing fancy yet, just some software installs
(21:12:44) mattock: I'll try to get one thing finished at a time (buildbot =
first, then test server, then windows build)
(21:12:58) mattock: I guess that's all
(21:13:05) cron2: sounds good
(21:13:48) mattock: oh one thing... once the buildbot build triggers are co=
nfigured we can build debian packages for each commit (or set of related co=
mmits)
(21:13:58) mattock: and publish them automaticaly
(21:14:00) mattock: lly
(21:14:16) mattock: later perhaps push them to an apt repo all our enthuasi=
sts can use
(21:14:41) mattock: shall we move on to the patches?
(21:14:51) cron2: ah, I have something else for your TODO list...
(21:14:58) mattock: cron2: excellent! :D
(21:15:06) mattock: I was just running out of work, you know :)
(21:15:16) cron2: mattock: could you find a way to make 2.1.3-win2k appear =
on the community software download page?
(21:15:56) mattock: hmm... we could add a link to Trac... or I could ask Ja=
mes if it's ok to publish it on openvpn.net download page
(21:16:21) dazo: we should get that package signed as well
(21:16:49) cron2: well, since we are publishing 2.1.3-win there, and James =
did the extra work for the win2k package, it seems weird to no thave it the=
re
(21:17:14) dazo: I think the core reason for it missing is that his publish=
 script didn't tackle that
(21:17:17) mattock: cron2: have many people requested it? because only one =
guy (out of 2000) responded to my "Win2k support is being removed" mail
(21:17:26) mattock: dazo: I think so too
(21:17:41) dazo: (james got a script which does all the magic, including up=
dating download page)
(21:17:45) cron2: mattock: well, we have made it, it came up on the openvpn=
-devel list, and it seems=20
(21:17:50) cron2: argh
(21:18:05) cron2: we decided "we still support win2k in 2.1.x"
(21:18:27) dazo: we decided 2.1.3 will be the last win2k=20
(21:18:34) mattock: cron2: oh yes, then 2.1.3 for win2k should be in openvp=
n.net
(21:19:00) cron2: dazo: well, what I remembered is "if we do security updat=
es for 2.1, we will continue to support win2k, but not for 2.2 and further =
versions"
(21:19:12) mattock: I'll mail James right way... meanwhile perhaps discuss =
this: https://community.openvpn.net/openvpn/ticket/62
(21:19:14) vpnHelper: Title: #62 (Support SOCKS plain text authentication) =
=EF=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN Community (at community.openvpn.net)
(21:20:03) cron2: I've briefly looked at the code and it looks sane - so "s=
emi ACK" from me.  The whole socks code is filled with magic constants, tho=
ugh :-( (buf[0] =3D '\5' stuff)
(21:21:08) dazo: cron2: the ticket got updated some days ago, he claims to =
have fixed that
(21:21:27) dazo: delroth: you around ... I'm presuming the SOCKS patch is y=
ours ...
(21:21:48) cron2: dazo: well, that's mostly a problem of the already-existi=
ng code, so the patch is not to blaim for that
(21:21:48) ***dazo throws in a '?' in the sentence above
(21:22:04) cron2: "pre?suming" looks weird
(21:22:11) dazo: heh
(21:22:17) cron2: that's where it landed!!
(21:22:31) dazo: ;-)
(21:22:47) dazo: your terrain was different ;-)
(21:22:54) jamesyonan [~jamesyona@...1320...] =EF=BF=BD=EF=BF=BD entrato ne=
l canale.
(21:22:54) modalit=EF=BF=BD=EF=BF=BD (+o jamesyonan) da ChanServ
(21:23:44) CareBear\ [peter@...1287...] =EF=BF=BD=EF=BF=BD entrato nel cana=
le.
(21:23:54) CareBear\: too late to push for the Host: patch?
(21:24:00) dazo: CareBear\: nope
(21:24:02) CareBear\: :)
(21:24:11) mattock: ok, mail about win2k installer sent
(21:24:12) cron2: it's on the agenda anyway
(21:24:17) cron2: mattock: thanks
(21:24:23) dazo: CareBear\: we're on the SOCKS patch
(21:24:27) CareBear\: will stay quiet until you come to it. thanks!
(21:25:40) dazo: I'm willing to give the SOCKS patch an ACK if it goes clea=
nly into the git tree ... I need to go through it once more to check that i=
t don't do anything less obviously stupid ... but it looks sane to me as we=
ll
(21:25:54) mattock: hi james!
(21:25:58) jamesyonan: hi
(21:26:15) mattock: great that you made it!
(21:26:27) mattock: have you taken a look at the SOCKS patch: https://commu=
nity.openvpn.net/openvpn/ticket/62
(21:26:29) vpnHelper: Title: #62 (Support SOCKS plain text authentication) =
=EF=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN Community (at community.openvpn.net)
(21:26:56) mattock: it has one semi-ACK and "one ACK after a second review"
(21:27:15) mattock: you could trip it over to ACK :)
(21:27:39) mattock: the latest patch is here: http://delroth.net/openvpn-so=
cks-auth.patch
(21:28:27) dazo: I would like to see a follow-up patch to this one, cleanin=
g up all those \x05\x02\x00 stuff ... to use macros instead ... it would ma=
ke the less obvious codes more readable, and less prone for bugs later on=20
(21:28:48) cron2: +1
(21:29:54) mattock: is there anything else in the patch that needs to fixed?
(21:30:05) mattock: or is it ACK after those changes?
(21:30:28) dazo: I'm missing an error check on recv()
(21:30:45) dazo: in the new socks_username_password_auth() function
(21:31:14) dazo: I think I'd like to see that on the select() call as well
(21:31:26) cron2: huh?
(21:31:51) dazo: ahh ... select() had the error check later on ...=20
(21:31:51) ***cron2 sees an error check on both
(21:31:58) cron2: recv() also has
(21:31:59) dazo: huh?
(21:32:17) dazo: +      if (size !=3D 1)
(21:32:25) dazo: ahh
(21:32:27) dazo: I see it now
(21:32:46) mattock: ok, so only \0x05\x02\x00 stuff needs fixing, then
(21:32:48) cron2: it even says /* error? */ in the comment above that line =
:)
(21:33:10) dazo: gee ... I need to sleep soon :)
(21:33:57) mattock: cron2 or dazo: could you update the ticket #62 with the=
 changes that should be done
(21:34:56) dazo: mattock: the thing is that I'm struggling with enforcing i=
t now, due to the same coding style exists in the current code base ... so =
I'd rather see that as a clean-up patch, either before or after this one
(21:35:07) dazo: but I'd like to see both this patch and the clean-up
(21:35:11) cron2: mattock: ticket #62 is ok as it stands - but afterwards t=
he whole sock.c needs cleanup
(21:35:19) cron2: +1
(21:35:57) mattock: I say merge it then, and fix the entire socks.c later
(21:36:33) mattock: dazo: could you live with that? :)
(21:36:48) dazo: yeah ... but that clean-up task needs to be written down s=
omewhere :)
(21:36:54) dazo: Yeah, I can live with that
(21:37:03) cron2: let's put it on mattock's TODO list :-) *duck&run*
(21:37:06) mattock: Trac would be a good place
(21:37:19) dazo: yupp, but a new ticket
(21:37:19) mattock: cron2: I could do that, but wouldn't guarantee good res=
ults :)
(21:37:28) dazo: mattock: we will review it for you ;-)
(21:37:36) mattock: :)
(21:37:49) mattock: shall we move on to host headers?
(21:37:56) cron2: ok
(21:38:05) mattock: http://thread.gmane.org/gmane.network.openvpn.devel/4039
(21:38:07) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:38:09) dazo: CareBear\:=20
(21:38:27) mattock: this has got two ACKs I think (Peter Stuge + cron2?)
(21:38:31) cron2: ACK
(21:38:36) dazo: yeah
(21:38:48) dazo: that's slated for inclusion already
(21:39:02) mattock: ok, so it's almost there... just wanted to make sure it=
 was not forgotten
(21:39:18) mattock: anything else about that patch?
(21:39:31) dazo: mattock: can you make a Trac ticket out of it (if it's not=
 existing) ... and copy the patch over?
(21:39:36) dazo: then I won't forget it for sure
(21:39:40) mattock: dazo: ok
(21:39:51) dazo: thx!
(21:40:42) dazo: (I'm sorry for kicking such silly tasks to you ... it's ju=
st that I'm overloaded a lot nowadays, and I will forget things which is no=
t written down)
(21:41:26) dazo: I have nothing else in regards to that patch ... it looks =
good
(21:41:29) mattock: dazo: no problem
(21:41:42) mattock: ok, so next and final patch: http://thread.gmane.org/gm=
ane.network.openvpn.devel/4059
(21:41:44) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:41:45) dazo: are these two patches something we want to include into th=
e 2.2 branch?
(21:42:05) ***dazo postpones his question and changes 2 -> 3
(21:42:28) cron2: I wouldn't mind 2.2-beta4
(21:42:33) dazo: Can someone please tell me in a simple way what this patch=
 does?
(21:42:45) dazo: (dynamic-iroute)
(21:43:15) cron2: dazo: these mesh people usually don't know which address =
will show up where.  So the patch declares a network to be "this is dynamic=
 stuff"
(21:43:39) cron2: when openvpn/server sees an incoming packet from an IP ad=
dress out of that range, it will auto-iroute this address to the client whe=
re it was seen
(21:43:53) dazo: so, it's more like "if you don't know this route, you migh=
t find it in this tunnel" type of patch?
(21:44:07) mattock: dazo: https://community.openvpn.net/openvpn/ticket/63
(21:44:11) vpnHelper: Title: #63 (HTTP/1.1 Host header) =EF=BF=BD=EF=BF=BD=
=EF=BF=BD OpenVPN Community (at community.openvpn.net)
(21:44:25) dazo: mattock: thx!
(21:44:27) cron2: other way round: if you see yet-unknown addresses from a =
client, don't drop the packets, but *learn* the address from there
(21:44:42) cron2: it's triggered by reception of packets on a p2mp server
(21:44:52) dazo: cron2: aha!  okay, now I see it clearer ... thx!
(21:45:23) cron2: I'm not sure if I fully understand all implications on th=
e code, though
(21:46:06) dazo: but that anyway means that the tunnel is either bridged or=
 routed on the client side, or else it would never hit the tunnel ... but t=
hen again, this puts trust on the client side
(21:46:16) mattock: jamesyonan: any comments on this patch?
(21:46:28) cron2: dazo: on the client side, it's always either bridged or r=
outed :-)
(21:46:44) dazo: heh ... of course
(21:46:47) vpnHelper: RSS Update - tickets: #63: HTTP/1.1 Host header <http=
s://community.openvpn.net/openvpn/ticket/63>
(21:46:55) dazo: I'm not drunk ... just getting quite tired :)
(21:47:03) cron2: dazo: and yes, it's mesh networking "we don't know how th=
e topology is going to look like in the end, it depends on which nodes are =
up and can see each other"
(21:47:20) Busch ha abbandonato il canale (quit: Ping timeout: 265 seconds).
(21:47:32) dazo: cron2: thx a lot!  I now actually see the purpose of it :)
(21:47:55) jamesyonan: The host patch seems fairly reasonable -- if it's wh=
at a browser would do, then we should probably do it also.
(21:48:26) mattock: delroth: you patch upload to ticket #62 failed because =
akismet thought it was spam... it's given a few false positives already
(21:48:36) mattock: jamesyonan: what about the mesh patch?
(21:48:45) dazo: jamesyonan: the host patch is acked ... we're on the --dun=
amic-iroute patch .... http://thread.gmane.org/gmane.network.openvpn.devel/=
4059
(21:48:47) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:50:56) mattock: btw. I have a couple things after --dynamic-iroute patc=
h is taken care of
(21:51:52) dazo: cron2: I just noticed this line in the --dynamic-iroute pa=
tch ....
(21:51:53) dazo:    struct iroute_ipv6 *iroutes_ipv6;			/* IPv6 */
(21:51:59) jamesyonan: what about the concern about routing loops that's ex=
pressed in the patch
(21:51:59) dazo: is that coming from you?
(21:52:17) cron2: dazo: huh, let me check again
(21:52:42) jamesyonan: "Drawback: if there are e.g. two=20
(21:52:42) jamesyonan: mesh networks with a double-IP-used conflict, you wi=
ll end up in endless "ip=20
(21:52:42) jamesyonan: route add" / "ip route del" switching.
(21:52:44) cron2: ah, existing code.  looks as if that code is based on "al=
lmerged" or "feat_ipv6>_payload"
(21:53:02) dazo: cron2: oki, thx
(21:54:13) dazo: jamesyonan: yeah, that's concerning
(21:55:45) mattock: could the patch be modified to get around that? I was t=
hinking that perhaps this patch could get it's own "testing" git branch=20
(21:55:57) mattock: if we can't include it safely right way
(21:57:12) dazo: yeah, I'm willing to branch it out ... but I'd like to see=
  it a branch from bugfix2.1 ... and then we'll have it in the allmerged fo=
r a while ... this is more openvpn-2.3 stuff
(21:57:39) dazo: and I would like to see IPv6 support as well, if that make=
s sense ... cron2?
(21:57:57) dazo: but that can come later on, when the branch is established
(21:58:02) cron2: yep
(21:58:03) ecrist: what about an ifdef?
(21:58:16) ecrist: then it will make it to my dev snapshots
(21:58:21) dazo: ecrist: definitely!  thx for that reminder
(21:58:33) cron2: that code is not really suited for #ifdef
(21:58:42) mattock: cron2: is it "all over the place"?
(21:58:57) mattock: =3Dnot isolated neatly
(21:59:07) cron2: half of the patch is "adding an extra argument to multi_g=
et_instance_by_virtual_addr()"
(21:59:10) dazo: well, there are some established functions which are chang=
ed
(21:59:12) ecrist: perhaps we NACK it and metion that it should be ifdef'ab=
le
(21:59:43) dazo: it seems to need those API changes ... but the core dynami=
c-iroute code path is possible to if-def out
(21:59:43) cron2: ecrist: that does not make sense
(21:59:49) cron2: dazo: ack
(22:00:22) cron2: the change inside multi_get_instance_by_virtual_addr() pl=
us the options.c stuff
(22:00:30) ***ecrist wanders to another terminal
(22:00:53) dazo: yeah
(22:01:09) mattock: ok, so what if we ask the author to add ifdefs where ap=
plicable and publish it in a separate git branch
(22:01:23) cron2: sounds workable
(22:01:27) dazo: mattock: yeah, and make base it on bugfix2.1
(22:01:43) mattock: ok, who'll respond to the author's mail?
(22:02:16) mattock: volunteers? ;)
(22:02:23) dazo: cron2: do you have capacity to do that? ... I'm afraid I w=
on't be able to manage it in the very near future
(22:03:15) cron2: dazo: not in the near future, sorry.  (On thing, I'm deve=
loping a flu :(( - and we have workers in the house, remodellign the kitche=
n, so I'm short on time anyway
(22:03:20) cron2: Solaris/tap first
(22:03:35) dazo: cron2: fair enough :)
(22:04:02) mattock: carebear? :)
(22:04:09) dazo: mattock: I can do it, but it won't be before next meeting =
... I'm really filled up with stuff to do already
(22:04:21) dazo: too much stuff*
(22:04:40) mattock: I can respond to the author privately and tell him we'l=
l get back to him
(22:04:47) mattock: but I don't try to fill in the details
(22:04:57) cron2: mattock: you can point to the meeting logs
(22:05:02) dazo: yeah
(22:05:19) mattock: ok, let's do that then
(22:05:40) mattock: ok, I had few questions / notices
(22:06:10) mattock: so I setup TracNotifications (=3Demails when tickets ch=
ange)
(22:06:14) dazo: To sum it up ... great patch, rebase it on bugfix2.1 inste=
ad, add if-defs, what about IPv6 and what about avoiding routing-loops
(22:06:15) mattock: have they worked properly?
(22:06:40) mattock: do you get spam from Trac to your inbox?
(22:06:49) ***dazo haven't noticed anything at all ...
(22:07:28) cron2: mattock: I got a comment on #61, but the original reporte=
r is a bit slow in answering, so nothing more since :)
(22:08:00) mattock: ok, good enough... let's wait a little and recheck this
(22:08:34) mattock: then an update on the OpenBSD buildslave we talked abou=
t a while back... fkr promised to provide us with one, and even started con=
figuring it
(22:09:16) mattock: then about integrating code analysis tools into build p=
rocess / buildbot
(22:09:26) cron2: all for it! :)
(22:09:49) mattock: I checked out Coverity and they have this "Scan" projec=
t for OSS projects: http://scan.coverity.com/about.html
(22:09:51) vpnHelper: Title: :: scan.coverity.com : Accelerating Open Sourc=
e Quality :: (at scan.coverity.com)
(22:10:26) mattock: in a nutshell, the commercial aspect of the project (=
=3DAccess Server) _might_ be a problem if we need to join "Scan"
(22:10:54) cron2: we don't talk about AS on IRC *duck*
(22:11:05) dazo: :)
(22:11:20) cron2: well.  why not just try it and see what happens?
(22:11:57) mattock: cron2: I thought about that, but I'm a sneaky bastard..=
. wanted to verify if we have a license or something already (coming from p=
re-AS days)
(22:12:10) mattock: so did not want to alarm them unnecessarily :D
(22:12:16) cron2: and...?
(22:12:29) mattock: jamesyonan: do we have access to some coverity software=
 besides their "Scan" project?
(22:12:41) mattock: cron2: james has all the knowledge about this
(22:12:46) cron2: ah
(22:13:43) jamesyonan: yeah, we do have an account-type with coverity that =
they grant to many other open source projects -- not sure if the capability=
 goes beyond scan
(22:14:40) mattock: ok, so how do I use it? any links?
(22:15:02) jamesyonan: sorry, I'm multitasking with another meeting as well
(22:15:07) mattock: no probs
(22:15:30) mattock: jamesyonan: could you mail me the details?
(22:15:34) jamesyonan: sure
(22:15:38) mattock: excellent!
(22:15:53) mattock: ok, I think I'm all out of topics
(22:15:57) mattock: and so is the topic list
(22:16:03) mattock: end of meeting already?
(22:16:04) dazo: \o/
(22:16:15) dazo: yes please .... I feel I need to sleep soon :)
(22:16:57) mattock: ok, it was fun having a meeting again!
(22:17:04) dazo: indeed :)
(22:17:11) cron2: good night
(22:17:12) mattock: unless somebody else has anything, let's call this a day
(22:17:31) mattock: I'll write the summary tomorrow and send Sven-Ola mail =
about his patch
(22:17:43) dazo: g'night ... and thx!
(22:17:45) mattock: see you guys later!
(22:17:51) mattock: dazo: good night

--------------080508060006070503060206--

