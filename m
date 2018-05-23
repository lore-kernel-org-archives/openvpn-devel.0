From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <cc8868d4-2b4a-4f95-f0f4-085421f0f241@...515...>
Message-ID: <91d08d73-1c88-2aeb-f3a5-ccc63c37444f@...515...>
Date: Wed, 23 May 2018 14:18:07 +0300
MIME-Version: 1.0
In-Reply-To: <cc8868d4-2b4a-4f95-f0f4-085421f0f241@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xwkfO983lgklpqKUvbqNCx2bC26AZEbcg"
Subject: [Openvpn-devel] Summary of the community meeting (Wed,
 23rd May 2018)
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
--xwkfO983lgklpqKUvbqNCx2bC26AZEbcg
Content-Type: multipart/mixed; boundary="odHMrSNayhUegVRi5ClLuubfu1iahrJvP";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <91d08d73-1c88-2aeb-f3a5-ccc63c37444f@...515...>
Subject: Summary of the community meeting (Wed, 23rd May 2018)
References: <cc8868d4-2b4a-4f95-f0f4-085421f0f241@...515...>
In-Reply-To: <cc8868d4-2b4a-4f95-f0f4-085421f0f241@...515...>

--odHMrSNayhUegVRi5ClLuubfu1iahrJvP
Content-Type: multipart/mixed;
 boundary="------------2632159CA12F5419CFAC333F"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------2632159CA12F5419CFAC333F
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.
---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 23rd May 2018
Time: 11:30 CET (9:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2018-05-23>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock, ordex and syzzer participated in this meeting.

--

Discussed status of tap-windows6 builds, signing and the latest security
fix. The guys at OpenVPN, Inc. office are setting up Windows 10
mini-pc's for testing the driver signatures. Actual testing can be
performed by an internal team. It was agreed, though, that automating as
much of the testing as possible should be the goal.

Related to that mattock is almost done with automating OpenVPN Inc's
basic Windows configurations using Puppet, and will extend that
automation to the Win10 testing mini-pc's and the tapbuilder VM. Once
that's done he will publish a Vagrant VM that anyone can use to build
tap-windows6 drivers.

Cron2 had contacted Cisco about the latest problem in tap-windows6
driver, but after the initial response ("we hear you") there has not
been any further progress.

We also discussed the option of having a semi-private "vendors" list
where we could share basic vulnerability info (e.g. severity) before the
release date. This would help vendors release fixed versions
synchronously with us. The idea was to have a protected ("only admins
can edit") Trac page with basic vendor info. Vendors would have to
contact security@...515... to get added there. Other approaches like
having semi-private mailing lists were also discussed.

--

Discussed the obfuscation patchset by the Operator Foundation. Ordex
forwarded our freeback to them and they're making changes based on it.

--

Had a discussion of the networking API (netlink patchset) which lives in
ordex's GitHub fork:

<https://github.com/ordex/openvpn/commits/sitnl>

The current API is here:

<https://github.com/ordex/openvpn/commit/59ef41b8c42897060fe546917fb421bc6f=
ea21c9>

It also comes with unit tests in form of t_net.sh:

<https://github.com/ordex/openvpn/commit/78c579d9591ced096175238e00377733fc=
b047a4>

The unit tests looked reasonable and it was agreed that extending them
to *BSD would be doable. Similar tests could be implemented on Windows
using Powershell, cmd.exe or Cygwin.

--

Discussed tls-crypt-v2. Ordex will try to allocate some time to review
syzzer's patches. If the patches get an ACK cron2 has no issues merging
them. It was agreed that we should have post-review meeting to ensure
that the patches don't end up in "forgotten state" again.

--

Discussed protocol extensions briefly, as tls-crypt-v2 is essentially a
low-level protocol extension. It was agreed that this is a good topic
for the upcoming hackathon.

--

Full chatlog attached.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------2632159CA12F5419CFAC333F
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2018-05-23.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2018-05-23.txt"

(12:29:43) mattock: hi
(12:29:52) cron2: ho
(12:30:00) mattock: how do we have here today
(12:30:05) mattock: who
(12:30:10) cron2: meow
(12:30:11) ordex: you
(12:30:22) cron2: ordex-man! :-)
(12:30:23) dazo: hey
(12:30:27) ordex: :D
(12:30:37) ordex: and dazo-san
(12:31:10) dazo: heh
(12:31:12) mattock: a fair crowd already
(12:31:34) cron2: so crowded toda?
(12:32:10) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
8-05-23
(12:32:12) vpnHelper: Title: Topics-2018-05-23 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:32:44) syzzer: morning :)
(12:32:47) ordex: hi syzzer !
(12:32:55) mattock: hi!
(12:33:05) mattock: start from the top?
(12:33:15) mattock: any other topics?
(12:33:41) syzzer: maybe tls-crypt-v2 ?
(12:33:50) syzzer: I'd like to see if we can get that ball rolling again
(12:33:58) ordex: yeah
(12:33:59) mattock: fine by me
(12:34:02) syzzer: (like, flushing my queue a bit)
(12:34:28) mattock: added to topic list
(12:34:38) ordex: thanks
(12:34:58) dazo: syzzer: you're not alone with a long queue these days=20
(12:35:25) mattock: 1. Tap-windows6 patches and updates
(12:35:34) syzzer: yeah, guessed so, it's awfully quiet on the list
(12:35:54) mattock: I can give my update on 1.
(12:36:00) ordex: ok
(12:36:04) syzzer: sounds good :)
(12:36:18) mattock: no progress as far as signing goes, but the guys at t=
he office are setting up a bunch of Win10 mini-pc's for testing
(12:36:33) mattock: and we can outsource and/or automate much of the test=
ing part
(12:36:59) mattock: so the whole process might not be entirely horrendous=
 on my part
(12:37:30) mattock: I'm almost at the point where I can setup a new tap-w=
indows6 build rig for jkunkee's refactored tap-windows6 build system
(12:37:36) mattock: i.e. newer DDK and all
(12:37:48) mattock: I got distracted by tangentially related large infras=
tructure tasks
(12:37:59) mattock: that all
(12:38:10) dazo: mattock: this topic was briefly touched last week in Lvi=
v too ... but I believe we pointed people into your direction as well
(12:38:38) mattock: yep, so the idea I believe was to have Lviv team do t=
he testing
(12:38:52) mattock: although depending on what kind of testing MS wants i=
t might pay off to automate some of it
(12:38:56) dazo: And I presume it might come up again when discussing rel=
ease management with Elfredy in Lviv in July again
(12:38:57) dazo: ahh, right
(12:39:16) dazo: yeah, we need to automate as much as possible
(12:39:42) dazo: I doubt MS insists on us hiring monkeys to do the testin=
g .... monkeys have higher failure rate than proper automation, regardles=
s of how you do things
(12:40:08) dazo: (and I do NOT mean the guys in Lviv are monkeys!)
(12:40:47) mattock: good correction
(12:41:18) mattock: anyways, the automation part is something I could pro=
bably do fairly easily with Powershell remoting for example
(12:41:24) cron2: I have established contact with the cisco guys wrt the =
new TAP security thing - no response so far except "we have heard you".  =
So I'll might come with a request for a CVE later...
(12:41:26) mattock: but it remains to be seen what it takes
(12:41:59) dazo: mattock: play along with the Lviv guys ... you might be =
able to offload some of the automation work if you co-operate with them .=
=2E. tossing everything to them might take a bit longer again, though
(12:42:14) syzzer: mattock: any chance we can get the tap-windows 6 build=
s to be reproducible?
(12:42:30) dazo: speaking of CVEs ... we have a few wiki pages needing at=
tention here ... and to release and update some MITRE entries
(12:42:38) mattock: dazo: I will bring this up with Mykola and Justin
(12:42:45) dazo: good!
(12:42:56) dazo: syzzer++ on reproducible builds
(12:43:16) syzzer: if you think that's doable, I'm willing to invest some=
 time into it
(12:43:18) cron2: reproducible builds =3D "I can follow this recipe, buil=
d this on my machine, and get the same outcome"?
(12:43:36) syzzer: yes, as in binaries with exact same sha256 hash
(12:43:50) mattock: syzzer: I have no clue
(12:44:09) cron2: not sure if that is doable, but "have a recipe which th=
ings to do exactly in which order to get a working driver binary in the e=
nd" would be a useful goal already
(12:44:11) dazo: or at least the core executable code of the binary has a=
n identical hash (depending on build approaches)
(12:44:17) mattock: what I can possibly do is create a Vagrant VM where y=
ou can build tap-windows6 without any tinkering
(12:44:19) cron2: what dazo says...
(12:44:27) cron2: mattock: that would be SOOO cool :-)
(12:44:40) dazo: agreed :)
(12:44:43) ordex: yeah, I think that would make everybody happy
(12:45:10) mattock: I've put our Windows-based VMs to Puppet already, so =
unless there are some really funky configurations that resist automation =
that's doable
(12:45:22) syzzer: ah, too bad.  Me neither, but I'm willing to invest so=
me time into that if it's somewhat doable.  Because that way I could just=
 use your signed installer, *and* be able to prove for myself (and our cu=
stomers) exactly what code we're shipping :)
(12:45:25) mattock: I can move the same Puppet code to Vagrant easily
(12:45:36) dazo: Vagrant is a good first step ... and then tweaking the c=
ompiler to do the reproducible builds as the next step
(12:45:55) syzzer: Yeah, that sounds like a solid plan
(12:46:25) cron2: +1
(12:46:29) mattock: I'm missing only a small piece in the Windows base pr=
ofile and will move to tap-windows6-specifics enxt
(12:46:31) mattock: next
(12:46:55) mattock: I may be able to get that done next week unless somet=
hing urgent pops up
(12:48:05) dazo: but .... something urgent will always pop up ;-)  .... b=
ut we need to ensure you can get these things moving forward as well, but=
 that's more a corp-priority thing though
(12:48:40) mattock: I've managed to avoid urgent stuff for last three wee=
ks or so
(12:48:44) mattock: so I'm good at it :p
(12:48:52) ordex: :p
(12:49:55) cron2: speaking of TAP driver plans - I'll give "cross-compile=
 the tap BSOD exploit code on mingw" a try and see if I can reproduce the=
 (new) crash, and then produce a patch that mattock can build me into a p=
roper driver :-)
(12:50:18) cron2: ... and then we need to agree on release strategy (bina=
ry driver first, source only when Cisco is ready, ...)
(12:50:26) cron2: this is a bit annoying
(12:50:44) ordex: if we wait for cisco, are we expected to wait also for =
other vendors?
(12:51:23) cron2: my stance on this is: if we know that their product has=
 the same problem, and we're endangering their users by doing "full discl=
osure right away", it is prudent to coordinate
(12:51:52) cron2: so, the other two VPN vendors listed need a heads up - =
I just needed to start somewhere
(12:52:18) dazo: I'm torn here .... neither of them, to our knowledge, is=
 active in the community .... if they'd been active here, they would have=
 known this information more quickly
(12:52:19) cron2: so - does one of you have working contacts at NordVPN o=
r VyprVPN?
(12:52:45) dazo: if they're just being "parasites" taking our code and no=
t interacting with us in an open way .... their loss
(12:52:46) syzzer: I didn't know they existed until the mail came in...
(12:52:48) ordex: I guess normally downstream users are just expected to =
pick up the new "security release" and integrate it in their products as =
soon as its out - warning everybody does not sounds like something that c=
an scale - unless they are active and eventually join the security list
(12:53:02) dazo: exactly, syzzer=20
(12:53:12) cron2: ordex: well, I think Cisco is not actually using our dr=
iver, just made the same programming mistake
(12:53:28) syzzer: well, I agree with cron2 that we should think a bit ab=
out their users too
(12:54:19) syzzer: but it sucks that this means more work for us, while t=
he vendors profit
(12:54:23) ordex: yeah in this case it makes sense to "help" them, but if=
 it's a different product, I guess the reporter should have reported the =
issue to them
(12:54:23) cron2: for the other two, I'd say "check what they are bundlin=
g" - if it's just tap0901.sys, we can send them a "hey, there will be a r=
elease in two weeks, you *WANT* this!".  If they build their own drivers,=
 they need a bit more time
(12:54:46) cron2: the reporter did it nice and easy - "look what I found!=
 and you get to sort out the mess now!"
(12:54:54) ordex: :D yeah
(12:55:14) cron2: ok, I see if I can find any contacts and/or any informa=
tion what is in there...
(12:55:23) dazo: I think we need to just communicate that clearly .... if=
 you want to know what happens in regards to security .... get in touch w=
ith us first to establish communication lines.  We can't scale to alert e=
ach VPN solution who just takes our code and runs with it
(12:55:35) cron2: yep
(12:57:03) mattock: what about having a semi-private mailing list where v=
endors can join to get notified?
(12:57:09) dazo: Being an open source community means you'll have to cont=
ribute to get the real benefit of the community ... otherwise, you're jus=
t being an open source parasite
(12:57:25) dazo: They need to care enough to get in touch with us ... not=
 the other way around
(12:57:34) cron2: right.  Let's talk to them and see if we can get someth=
ing going
(12:57:40) dazo: but yeah, having a vendors list might be a good way forw=
ard
(12:58:06) mattock: I think we could share basic vulnerability info (seve=
rity etc.) and release dates, nothing more
(12:58:16) mattock: just to give them a bit of heads up
(12:58:18) cron2: Viscosity worked nicely last time, they just never had =
any need to talk :)
(12:58:21) dazo: yeah
(12:58:36) ordex: should this list be public?
(12:58:41) mattock: although
(12:58:54) dazo: nope, I'd say closed list
(12:58:58) mattock: our Rackspace mailing lists suck (four "external" use=
rs)
(12:58:59) cron2: ordex: semi-public, so not "just subscribe" but subscri=
ption should be vetted
(12:59:03) mattock: SF.net is public
(12:59:11) cron2: and no archive
(12:59:13) mattock: so we need something else
(12:59:21) mattock: e.g. mailmanlists or other solution
(12:59:30) ordex: yap
(12:59:42) cron2: right (which we wanted to investigate for the main list=
s anyway)
(12:59:49) dazo: lets twist it .... do that list need to just be a distri=
bution list, or a full fledged mailing list with archive?
(13:00:11) cron2: no archive.  distribution list should be fine for the f=
irst 10 vendors or so...
(13:00:24) dazo: I agree with cron2
(13:00:30) ordex: me too
(13:00:56) syzzer: maybe list a list of "tap-windows vendors" on the wiki=
, where people/projects can be added, with their security email contact
(13:01:03) syzzer: that we can send notifications to those on that list
(13:01:11) cron2: *like*
(13:01:23) mattock: that would have to be a protected page I guess
(13:01:35) syzzer: put the ball at the vendor's end to 'register' their p=
roject
(13:02:01) mattock: do we care about the possibility of "random" people j=
oining that list disguising as "vendor"
(13:02:10) syzzer: why?  they whould be able to be open about the fact th=
at they use our (GPL) code, and what their security contact is
(13:02:32) ordex: I think protected in the sense that not everyody should=
 be able to edit
(13:02:35) dazo: Yes, we should be careful about who joins such a list
(13:02:48) syzzer: ah, edit-restrictions.  yes, that makes sense.
(13:02:50) cron2: what dazo and ordex say
(13:03:30) mattock: given Trac's permission scheme the page would have to=
 be "Protected" (=3Donly admins can edit)
(13:03:32) dazo: They can make us update the that public page, as part of=
 the registration
(13:03:44) mattock: yes, we would have to edit the page once they've cont=
acted us
(13:03:54) cron2: mattock: I think that should work
(13:03:56) syzzer: should be good enough :)
(13:03:58) ordex: yap
(13:04:08) dazo: and subscription can happen via security@...2400...
(13:04:09) mattock: ok agreement!
(13:04:13) mattock: +1
(13:04:47) mattock: next topic?
(13:04:55) syzzer: go
(13:05:00) mattock: 2. obfuscation for Jigsaw project: quick status updat=
e=20
(13:05:01) dazo: 2 is probably quick, ordex?
(13:05:06) ordex: yup
(13:05:11) ordex: 2. obfuscation for Jigsaw project: quick status update =

(13:05:13) ordex: very quick
(13:05:30) ordex: I just forwarded our comments about the way this new ob=
fuscation plugin should be configured
(13:05:52) ordex: I told them this is the main blocker at the moment, aft=
er solving this, they can probably send the patchset to the ml
(13:05:57) ordex: and they are now working on it :)
(13:06:03) ordex: nothing came back yet other than "ACK"
(13:06:13) ordex: they probably will have a meeting this week to decide h=
ow to move forward
(13:06:34) ordex: if they have any counter-proposal or comment I'll rely =
the message here
(13:06:40) ordex: relay
(13:06:50) cron2: thanks
(13:06:59) ordex: np :)
(13:07:21) ordex: this is all for 2.
(13:07:33) cron2: so, 3. is you again, I think :)
(13:07:41) mattock: 3. obfuscation for Jigsaw project: quick status updat=
e=20
(13:07:53) cron2: that was 2.
(13:08:01) dazo: 3. networking API patch: status update=20
(13:08:07) dazo: netlink :)
(13:08:12) ordex: do we want to do 4. first? as it has been in the queue =
a bit longer? and may need some time?
(13:09:11) syzzer: let's just follow the agenda :)
(13:09:26) ordex: oky
(13:09:53) ordex: so last time we discussed the new API and we agreed on =
making some changes, especially about introducing a "context" object to b=
e passed to every API call
(13:10:09) ordex: so the latest code is available on the sitnl branch in =
my repo on github, but the interesting patch is: https://github.com/ordex=
/openvpn/commit/59ef41b8c42897060fe546917fb421bc6fea21c9
(13:10:11) vpnHelper: Title: implement platform generic networking API =C2=
=B7 ordex/openvpn@...2401... =C2=B7 GitHub (at github.com)
(13:10:14) ordex: this is just the API
(13:10:53) ordex: so basically now we have this "openvpn_net_ctx_t *ctx" =
thing initialized once within the "struct context" object and is then pas=
sed around
(13:11:06) ordex: (branch is here: https://github.com/ordex/openvpn/commi=
ts/sitnl)
(13:11:07) vpnHelper: Title: Commits =C2=B7 ordex/openvpn =C2=B7 GitHub (=
at github.com)
(13:11:21) cron2: I do not have brains to look at it and give a meaningfu=
l comment right now, sorry
(13:11:42) cron2: (corp network hubbub around me, people coming with ques=
tions every 3 minutes...)
(13:11:52) ***cron2 takes a note and looks soonish
(13:11:58) ordex: hehe no prob.
(13:12:14) syzzer: without understanding the networking intricacies invol=
ved, this look like a clean API design
(13:12:45) cron2: the "ctx" bit is needed to handle windows, but with tha=
t, it should work - but I'll do a more brainful review
(13:13:08) ordex: it is actually also useful for iproute2 as ctx is used =
to pass "es" (env_set) around
(13:13:20) ordex: while with netlink it is just void*
(13:13:45) cron2: nice :)
(13:14:13) ordex: after having enojyed the code, there is another point t=
o discuss: unit test
(13:14:21) ordex: it is implemented here: https://github.com/ordex/openvp=
n/commit/78c579d9591ced096175238e00377733fcb047a4
(13:14:23) vpnHelper: Title: unit tests: implement test for sitnl =C2=B7 =
ordex/openvpn@...2402... =C2=B7 GitHub (at github.com)
(13:14:28) ordex: and the commit message tries to explain how it works
(13:14:51) ordex: but in a nutshell: it basically consists of a t_net.sh =
script and a test_networking.c object
(13:14:59) dazo: I've quickly looked at that last week when ordex showed =
it to me .... I think that approach for unit testing is clever
(13:15:30) dazo: when extending the unit tests in this area, it is only n=
eeded to be done in a single place
(13:15:54) dazo: though, Windows testing via this approach might be somew=
hat tricky ... but for Linux this should work very well
(13:16:24) dazo: (*BSD should be possible as well, if we want to extend i=
t here too)
(13:16:28) ordex: the t_net.sh script executes the test_networking object=
 which performs some netlink operations and prints to stdout the matching=
 iproute2 command. the script then takes a snapshot, cleans up the state =
and runs these iproute2 commands. if the final state matches the snapshot=
 taken earlier, everything is fine
(13:16:32) ordex: yeah
(13:17:13) ordex: I think it needs to be changed quite a bit for windows =
as it needs to interact with the windows powershell and ip/route configur=
ation (/me has no real clue about that)
(13:17:32) dazo: well, there's always cygwin=20
(13:17:45) dazo: but iproute2 is probably not feasible via cygwin ;-)
(13:17:56) ordex: yeah :)
(13:18:24) ordex: anyway, for now the patchset is all about linux, so thi=
s unit test should give us enough confidence in this area
(13:18:32) dazo: ack!
(13:18:35) cron2: ack
(13:18:45) syzzer: approach looks sane
(13:18:49) mattock: +1
(13:19:00) mattock: somebody can rewrite the script for Windows in Powers=
hell
(13:19:05) syzzer: though you might want to run the tests in a network na=
mespace
(13:19:15) cron2: if one of us feels bored, we can have a test script tha=
t does "the same" with route.exe/net.exe on windows
(13:19:22) syzzer: that gives you a clean environment, and you need sudo =
rights anyway
(13:20:11) syzzer: oh, and currently it seems that the dummy0 interface i=
s not cleaned up at the end of the script?
(13:20:19) dazo: now it uses a dummy0 interface ... so shouldn't collide =
with anything else on the system .... but yeah, a separate network NS isn=
't a bad idea
(13:20:30) ordex: syzzer: yeah that's also an option. the problem is that=
 the netlink API at the moment does not support net namespaces because we=
 don't use them in openvpn
(13:20:51) syzzer: you can just run the entire script in a network namesp=
ace, should work :)
(13:21:09) cron2: which actually brings up the interesting question: if w=
e want to support network namespaces, will the new API get in the way?
(13:21:10) syzzer: ip netns exec openvpn_test_1324 t_net.sh
(13:21:38) ordex: yeah that should work
(13:22:15) ordex: cron2: it depends how we want to handle it. it may just=
 be a new attribute of the "ctx" object
(13:22:27) ordex: so it will be passed all around the place without touch=
ing the API
(13:22:31) dazo: yeah, my thoughts exactly
(13:22:33) syzzer: (or run all separate command in the script in the name=
space, may be a bit more elegant, and allows you to add a trap to remove =
the namespace on exit)
(13:22:39) ordex: as I expect it to be one for the entire openvpn process=

(13:22:52) cron2: ordex: the problem with that is: we'll have the "tun" n=
etns, and the "outside" netns
(13:22:54) ordex: syzzer: yeah might be better that way
(13:23:15) syzzer: anyway, approach looks good :)
(13:23:19) cron2: mmmh
(13:23:22) cron2: actually no
(13:23:43) cron2: if we do "tun routes" in a separate netns, we do not *n=
eed* to install "outside" routes anymore (for recursion bypass)
(13:23:58) ordex: right
(13:24:04) ordex: because they do not interfere anyway
(13:24:24) dazo: ordex:  return net__iface_mtu_set(1281);  ..... should w=
e test more MTU values?  Like 300, 9000, 65535 and 90000?
(13:24:32) dazo: or even -1
(13:24:35) cron2: (so our code needs to be aware that this is no longer n=
eeded and do not muck with external /128 routes... but that's actually a =
good thing :) ) - and I agree with "stuff it in the ctx, done"
(13:24:56) ordex: dazo: we can, but then that becomes a MTU test, not an =
API test anymore :P we can do that separately if you like
(13:25:30) ordex: cron2: yeah, I think to introduce full netnamespace sup=
port we need to look and change more things
(13:25:39) dazo: well, yeah ... I do see it somewhat related to the API t=
hough ... it tests the error handling paths in the sitnl code=20
(13:26:00) ordex: dazo: ah in that sense, yeah
(13:26:38) cron2: dazo: error what?
(13:26:44) dazo: same with IP addresses .... testing with 0.0.0.0/0 and 2=
55.255.255.255/255.255.255.255 .... as well as 391.239.403.304
(13:26:57) dazo: and invalide IPv6 addresses
(13:27:01) ordex: I think he refers to "invalid" mtu values - they should=
 trigger an error
(13:27:21) dazo: and we should handle that error gracefully
(13:27:23) ordex: dazo: but not sure we want to test that in the t_net.sh=
 script, which is in charge of doing the matching with iproute2
(13:27:44) dazo: ahh, true ... you're right, this is actually a different=
 test from iproute2 matching
(13:27:46) cron2: handling of invalids can nicely go to a cmocka test
(13:27:50) ordex: yap
(13:27:59) mattock: "handling of invalids"=20
(13:28:16) mattock: in Finnish a disabled person is called "invalidi"
(13:28:16) dazo: invalid handling?
(13:28:23) mattock: :P
(13:28:25) ordex: :D
(13:28:39) mattock: anyways, sorry for the distraction
(13:28:41) mattock: :)
(13:28:59) cron2: so... two more minutes... tls-crypt v2?
(13:29:05) ordex: yap
(13:29:06) mattock: +1
(13:30:08) ordex: would review and ack help to move this forward? I am st=
ill the owner of tls-crypt-v2 on ovpn3 therefore I have tests and brain (=
somewhat) fresh on that
(13:30:24) dazo: that would help a lot!
(13:30:28) syzzer: yeah, I think review is the most important right now
(13:31:49) ordex: ok, will try to allocate more time for that
(13:32:16) ordex: and once review is done, should we try to organize a me=
eting focused on this only so we can get everybody's attention and try to=
 get it merged?
(13:32:23) cron2: +1
(13:32:26) dazo: +1
(13:32:43) ordex: otherwise I fear it will just go back to "forgotten" st=
ate, even after the review, because it's big and might be complex to be p=
icked up by a single person
(13:32:59) ordex: ok
(13:33:04) syzzer: yeah, sounds good!
(13:33:04) cron2: if it has ACKs, I can merge it just fine :)
(13:33:41) ordex: ok, then let's see what I can review and let's discuss =
the rest in a meeting :)=20
(13:33:48) syzzer: one thing to consider (separate from this review) is h=
ow to deal with protocol extensions
(13:34:05) ordex: in terms of backwards compatibility?
(13:34:24) syzzer: I'll cook up a mail to get that discussion started on =
the list
(13:34:34) syzzer: and future extensions
(13:34:52) syzzer: basically, "should we reserve some bytes?"
(13:35:33) syzzer: but I'll make that more clear on a mail
(13:35:57) syzzer: and we can discuss it further during a future meeting
(13:35:58) dazo: We should be careful about protocol extensions .... and =
such changes needs to be vetted by James.  They need to also be handled w=
ell in OpenVPN 3 too, to ensure it is performing well against openvpn 2.x=

(13:36:12) cron2: we understand that :)
(13:36:15) dazo: sounds like a topic for the Hackathon to be honest :)
(13:36:32) syzzer: dazo: that would block tls-crypt-v2 until the hackatho=
n
(13:36:45) syzzer: because tls-crypt-v2 is a protocol extention on the lo=
west level
(13:36:57) cron2: we should start on the list
(13:37:07) dazo: ahh, okay ... we'll get James attention on this too inte=
rnally
(13:37:22) syzzer: yeah, I'll cook up the mail, so we all have the inform=
ation and can efficiently discuss it
(13:37:24) dazo: perhaps even explicitly Cc James
(13:37:25) cron2: and depending on the result of this, we can continue @ =
Hackathon to flesh out details
(13:37:26) ordex: yeah let's get it started on the list
(13:37:35) dazo: agreed
(13:38:18) cron2: wife food now!  see you later :-)
(13:38:24) syzzer: I don't think this will impact the patch set much, but=
 we do need to consider this before applying final patches.
(13:38:39) syzzer: yes, me hungry too!
(13:38:49) mattock: laters!
(13:38:52) mattock: summary coming up
(13:38:57) ordex: enjoy!
(13:39:00) ordex: thanks mattock=20

--------------2632159CA12F5419CFAC333F--

--odHMrSNayhUegVRi5ClLuubfu1iahrJvP--

--xwkfO983lgklpqKUvbqNCx2bC26AZEbcg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlsFTe8ACgkQKVhNn0CG
RXhwxgf/W14d8IawZxcsFOdDTrkg6X1YHwKgXS10WYLCid7OsQdx00/sPbWAlJG8
CaoEzGQrfAhNjC8Ss3LJJwvZ6oYoRtX1m1DTkwRWii2VeKONSO7zLpRWezmHazFu
r00TkbP5gUDXktQJRPX1xYm+Jhs1w+UrPPdwWS0TPxS/MXIe7nRhVx6qUpqkkK9d
ODUWv8lNuubwdgvuM/bvOqyX4C2v+CqyJkkc7iahabhKsMJfUxhwt68aaHYjUqoh
utJMfyySN9YeplBY+q23cg6D8G3wpqOCjC7YxgDo+TT8CZwU/ZVyJn+PJO5RHx2d
LpNkQtqi1y8n6GBkZRFtuSU6IRkNRA==
=XQwB
-----END PGP SIGNATURE-----

--xwkfO983lgklpqKUvbqNCx2bC26AZEbcg--

