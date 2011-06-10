Message-ID: <4DF27BA2.6040002@...515...>
Date: Fri, 10 Jun 2011 23:16:34 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000902020001020108030307"
Subject: [Openvpn-devel] Summary of the IRC meeting (9th June 2011)
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
--------------000902020001020108030307
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 9th June 2011
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2011-06-09>

Next meeting will be announced in advance, but will be on the same
weekday and at the same time. Your local meeting time is easy to check
from services such as

<http://www.timeanddate.com/world clock>

or with

$ date -u


SUMMARY

cron2, dazo, ecrist and mattock were present in this meeting.

--

Discussed branching out beta/2.3. There are a few patches that are
required first:

* PolarSSL and Doxygen patches from andj
* Visual Studio 2008 build fixes now in "winbuildtmp" branch
* Cron2 needs to make "tap" work with "push route-ipv6"
* https://community.openvpn.net/openvpn/ticket/128 (if reproducible)
* https://community.openvpn.net/openvpn/ticket/140
* https://community.openvpn.net/openvpn/ticket/125
* Some open tickets from 2.2.0

--

Discussed 2.2.0 release. Will try to get it out in two weeks. There's at
least a few patches missing:

* James segfault fix from SVN (left out from 2.2.0)
* https://community.openvpn.net/openvpn/ticket/125

--

Discussed the possibility of placing non-invasive ads to OpenVPN Windows
installers, e.g. links to commercials product in Start menu or to the
README file. Idea met with lukewarm response, because the community has
effectively ran the project for the last ~18 months. The fact that
OpenVPN (OSS) is hard to find from all commercial content in openvpn.net
also raised critique.

For the above reasons agreed that splitting openvpn.net (commercial
site) and openvpn.org (community site) would make sense. Both sites
would be linked together tightly. Agreed that having a joint community /
company meeting focusing on this issue makes sense. At least Samuli,
Francis and James would need to attend (from the company) along with
most active  community members.

Also agreed that the company needs to mentally "let openvpn go" and
focus on working with the project and build products on top of it
like everyone else. If a fork ever happened, getting distributors (*NIX
distros) and later users to migrate to it should not pose a big problem.
OpenOffice.org/LibreOffice is a good analogy: most/all major *NIX
distros migrated to LibreOffice in their first post-fork release.

--

Discussed the possibility of arranging a "real" face-to-face meeting
between the company and community people, for example in New York. Costs
are an issue, but this might happen eventually.

--

Discussed the problem with Access Server's OpenVPN version, which is
effectively a fork (based on 2,1 release). This means AS is atm lacking
features which OpenVPN has. This divergence has already caused some
nasty merge conflicts.

--

Discussed Russell's questions posted to the mailinglist:

<http://thread.gmane.org/gmane.network.openvpn.devel/4715>

Management interface does come up before connection, but it's only used
for passing the username and password to OpenVPN daemon.

Adding more granular exit codes to OpenVPN would be possible, but it
would not be trivial without a (needed) overhaul of err.[ch].

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------000902020001020108030307
Content-Type: text/plain;
 name="openvpn_irc_meeting_chatlog_2011-06-09.txt"
Content-Disposition: attachment;
	filename="openvpn_irc_meeting_chatlog_2011-06-09.txt"
Content-Transfer-Encoding: quoted-printable

cron2 21:01:19
meeting
let's go about it and be quick, I'm up since 04:30 and it's now 20:00 ove=
r here - and I'm tired 21:01:34
=20
dazo 21:03:54

agreed 21:04:01
=20
mattock 21:04:22
meeting time
https://community.openvpn.net/openvpn/wiki/Topics-2011-06-09 21:05:23
=20
vpnHelper 21:05:24
Title: Topics-2011-06-09 =E2=80=93 OpenVPN Community (at community.openvp=
n.net)=09

mattock 21:05:32
2.2.1 patch queue?
what's missing? 21:05:34
dazo? 21:06:06
=20
dazo 21:06:08
tbh, I don't know=09

cron2 21:06:09
dazo?=09

mattock 21:06:37
are the VS2008 build fixes already in "master"?=09

dazo 21:06:38
I remember having merged in quite some patches ...
most of them, yes ... I think there was some more cleanup from jjo which =
I'm not sure of 21:06:56
=20
mattock 21:07:10
we can take a look later
I think we should set a release date today 21:07:29
=20
dazo 21:07:36
sure can do!=09

cron2 21:08:30
dazo: did you merge to master? I thought it's all in the winbuild-test br=
anch?=09

mattock 21:08:34
it's been nearly 6 weeks since 2.2.0... is next Friday (not tomorrow) doa=
ble?=09

cron2 21:08:38
haven't seen any mails otherwise=09

dazo 21:08:40
but lets also agree on what we want to have cleaned up ... in the moment =
we branch out the beta/2.3 branch, I'd say we should have agreed on all n=
ew additional features
I'm waiting for andj to come up with the PolarSSL and doxygen patches, wh=
ich we want into 2.3 21:09:14
that's the only "missing" pieces 21:09:24
=20
mattock 21:09:39
have we seen any pieces yet?=09

dazo 21:09:40
there are also quite a few Trac tickets to look at as well
a preview around 2.2 beta, and he got some feedback back then, iirc 21:10=
:02
=20
mattock 21:10:11
oh yes, that's right=09

cron2 21:10:11
there's some ipv6 fixes pending to make "tap" work with "push route-ipv6"=
=09

dazo 21:10:32
cron2: are that something which is waiting on me or you?=09

cron2 21:10:43
dazo: waiting for me to implement it =09

dazo 21:10:48
okay =09

cron2 21:10:57
(or for another volunteer, but I have my doubts that one would show up co=
nveniently)=09

dazo 21:11:12
just wanted to be sure I hadn't forgotten to pull more of your stuff =09

cron2 21:11:25
nah, nothing to pull right now=09

mattock 21:11:48
dazo, cron2: what about 2.2.1 release date? is next week's Friday too ear=
ly?
two weeks? 21:11:53
=20
dazo 21:12:01
I'd say we could branch out beta/2.3 as soon as we got the PolarSSL stuff=
=09

mattock 21:12:22
sounds good=09

cron2 21:12:24
mattock: I have no idea. We have a few bugfixes, but I have not kept trac=
k and don't know whether dazo has committed everything=09

dazo 21:12:26
I believe those patches was promised in a bout a week or so=09

mattock 21:12:36
oh, that soon, great!=09

cron2 21:12:39
dazo: he said he would need more time due to other work projects=09

dazo 21:12:58
2.2.1 release ... we might want to double check Trac=09

cron2 21:12:59
I said that's fine because we won't release anything before "autumnish" a=
nyway=09

mattock 21:13:18
yep, except Windows snapshots
looking forward to those 21:13:29
should improve IPv6 testing situation noticeably 21:13:47
=20
cron2 21:14:11
so any volunteers to go through trac and mailing list to see if some 2.2.=
1 fixes are missing? My next two weeks will be very busy - I'm out=09

mattock 21:14:39
I can take a look to see if there's something obvious
I believe we decided on which patches to include in a previous meeting 21=
:15:10
=20
dazo 21:15:20
ticket #125, #128 and #143 are targeted 2.2.1 ... plus we have some open =
ones from 2.2.0=09

mattock 21:15:39
hmm, let's see...=09

dazo 21:16:26
#123, #124 and #140 are all on 2.2.0
two first ones are easy, documentation stuff 21:16:37
=20
mattock 21:16:57
#125 is trivial and for me=09

dazo 21:17:23
the comp-lzo stuff is much more tricky
(#128) 21:17:29
=20
mattock 21:17:53
#140 needs more info I think=09

dazo 21:18:06
agreed=09

mattock 21:18:19
could be "works for me" stuff=09

dazo 21:18:29
yeah=09

mattock 21:18:35
what about James' security fixes?=09

dazo 21:19:02
dang .... that one has slipped my mind ...
that was a big one as well 21:19:10
=20
mattock 21:19:22
nasty merge conflicts if I recall correctly=09

dazo 21:19:25
well, security and security fix ... it was more a potential segfault
I'll try look at these things next week 21:19:49
=20
mattock 21:19:53
ok, nice=09

cron2 21:20:00
cool=09

mattock 21:20:04
let's _try_ to get 2.2.1 out in two weeks, shall we?=09

dazo 21:20:07
James' fixes plus one or two more things
we can try 21:20:14
=20
mattock 21:20:30
let's take another look next week=09

dazo 21:20:35
yeah=09

mattock 21:20:39
next topic?=09

cron2 21:20:46
winbuild-branch
dazo: what's the state of that? 21:20:50
you have been suspiciously quiet on that when the discussion started... 2=
1:21:10
=20
dazo 21:21:18
that's the stuff I thought we were discussing earlier today =09

cron2 21:21:38
when? So I can scroll back and read it up=09

dazo 21:21:39
yeah, I've been overloaded with a release at work the last two weeks, so =
I haven't had too much time to look at winbuild
20:08 21:21:52
=20
cron2 21:22:02
nah, that was distractions =09

dazo 21:22:10
=09

cron2 21:22:21
you were talking beta/2.3, I'm talking master and tmp/winbuild=09

dazo 21:22:26
=09

cron2 21:22:32
which needs to be sorted out before even thinking 2.3=09

dazo 21:22:38
agreed=09

mattock 21:22:45
+1=09

dazo 21:22:57
mattock: what is the HEAD of your winbuild stuff? do you remember what yo=
u tried last there?=09

mattock 21:23:06
dazo: nope, no clue
it's a mess, basically 21:23:13
I think 21:23:20
=20
dazo 21:23:22
JJO's USE_PF_INET6 by default for v2.3, is my HEAD=09

cron2 21:23:22
what mattock checked out was missing a fix to tun.c (which I'm not sure w=
here it went)=09

mattock 21:23:27
lemme check=09

dazo 21:23:36
yeah
that I vaguely remember 21:23:43
=20
cron2 21:25:16
there's two fixes to tun.c, one went to the ticket attachments and the ot=
her one didn't=20
but it's in mattock's repo now 21:25:22
=20
mattock 21:25:31
it seems my HEAD is at "Fix a visual Studio 2008 build issue in socket.c"=
=09

dazo 21:25:48
mattock: okay, you're behind=20
unless you've applied more uncommitted stuff 21:25:59
=20
mattock 21:27:05
I got to check my repos later, it's been a while=09

dazo 21:27:13
yeah, it has=09

mattock 21:27:14
tomorrow maybe=09

dazo 21:27:18
for me too =09

mattock 21:27:25
next topic?
which would be... everybody's favorite... ads 21:27:53
=20
dazo 21:28:08
=09

mattock 21:28:27
I've discussed this with ecrist and dazo already in some length=09

cron2 21:28:29
I thought about it, and I don't think that this is a good thing=09

dazo 21:28:30
I'm basically fine with something not too aggressive in the README=09

cron2 21:28:57
it's bad enough that www.openvpn.net is basically hiding the existance of=
 the free version quite successfully now=09

dazo 21:28:58
however, nowadays, it is mainly the community which drives the developmen=
t
cron2 got a point 21:29:13
=20
mattock 21:29:26
yep, that's true
there's no denying it 21:29:33
=20
cron2 21:29:56
I would be fine with something like "if you want commercial support, this=
 can be bought *here*"=09

dazo 21:30:16
yeah=09

mattock 21:30:18
yeah, something like that=09

cron2 21:30:48
that's something users and opensource community understands - "the softwa=
re is free, but there is people to help me if I want to pay somebody" and=
 that's generally accepted=09

mattock 21:30:53
except that we (the company) don't sell support, so we'd have to say some=
thing like "If you want a commercially supported version of OpenVPN, take=
 a look here"
or something like that 21:31:07
=20
dazo 21:31:11
but I also miss a clearer distinction between OpenVPN Community Edition a=
nd OpenVPN Commercial Edition - aka OpenVPN AS=09

cron2 21:31:13
why would I want to install a commercial product that has no v6 support?=09

mattock 21:31:53
cron2: good point
I'll mention that to Francis so we can get our priorities right 21:32:08
=20
dazo 21:32:51
right now, the reality is that OpenVPN AS is a fork ... which is kind of =
a paradox
it is lagging behind OpenVPN 2.2 on quite some parts ... and OpenVPN 2.2 =
does not have everything OpenVPN AS got 21:33:23
=20
mattock 21:33:24
true, that needs to be fixed a.s.a.p.=09

cron2 21:33:37
it's not unusual to have sort of a "free entry level product" and a "comm=
ercial product with additional features" - but indeed, there's the parado=
x, regarding features =09

dazo 21:33:44
OpenVPN 2.3 will have everything OpenVPN AS got + IPv6=09

cron2 21:33:50
\o/
sorry, couldn't resist 21:33:54
=20
dazo 21:33:57

cron2: _you_ are allowed to do that 21:34:13
(2.3 =3D=3D 2.2 + OpenVPN AS + IPv6, to be exact) 21:34:35
=20
mattock 21:34:36
I think the guys at the company are running like hell to improve OpenVPN =
AS when they should stop for a while=09

cron2 21:34:55
mattock: just to be clear about it - the IPv6 code is donated to the proj=
ect, it's GPLed, so if OpenVPN Tech wants to add it to the AS code base, =
I would be honoured=09

mattock 21:34:57
and do some plumbing work
cron2: I'm sure it will be added 21:35:08
=20
cron2 21:35:23
(and it would make sense because it increases the user base, and creates =
different test cases that exposes different bugs...)=09

mattock 21:35:25
it's just that James and others are swamped, so they can't stop to change=
 the shoes=09

cron2 21:35:43
something is wrong in OpenVPN Tech development's model=09

mattock 21:35:47
that said, I'm visiting the company headquarters between 2nd and 17th Jul=
y=09

dazo 21:35:57
cool!=09

mattock 21:35:57
cron2: I agree
I hope I can figure out what the problem is and make a change 21:36:13
current development model won't work for long 21:36:28
=20
cron2 21:36:30
btw, what did ecrist say regarding advertising? I could imagine ecrist an=
d krzee being lots more sceptical than I am, due to "bad experience with =
the company/community fall-out in the past"=09

mattock 21:37:00
cron2: ecrist was sceptical, and I can't blame him
he's got every right for that 21:37:08
he had a very good ideas about managing AS support, which will be impleme=
nted 21:37:51
=20
cron2 21:38:02
cool=09

mattock 21:38:04
essentially allow AS users to support themselves
on forums and IRC 21:38:08
=20
dazo 21:38:17
I am probably more sceptical than I do say ... I do feel my stomach move =
when thinking about it, tbh ... but I also respect where this code base c=
omes from and the work James have put into it ... but I'm not going to ac=
cept a one-way road forever=09

cron2 21:39:07
it's a delicate line that must not be crossed (and we don't know exactly =
where that line *is* )=09

dazo 21:39:50
exactly ... but we're damn close to some border=09

mattock 21:39:52
that's why I'm asking you guys =09

cron2 21:40:03
so let's rephrase my position: I can see some use in pointing users to a =
commercial solution, but it needs to be discreet - and balanced. So if th=
ere's advertising in the free product, there needs to be somewhat more pr=
ominent advertising for the free product on the commercial website
"one-way road thingie" 21:40:17
=20
ecrist 21:41:40
there may be a compromise, though.=09
cron2 listens 21:41=09

ecrist 21:42:32
what if the community took donations for advertising, or sorts. OpenVPN T=
echnologies could get a 'credit' to that end for providing the hosting.
I would only be willing to accept that, though, if we were to ever move f=
orward with the domain name changes that have been discussed 21:42:55
=20
mattock 21:43:15
ecrist: you mean the .com/.org split?=09

ecrist 21:43:23
openvpn.org/.net=09

mattock 21:43:30
oh yes, .com is stolen =09

ecrist 21:43:35
mattock - I didn't thnk you had .com=09

mattock 21:43:46
we don't, some company in Las Vegas does =09

ecrist 21:43:48
it appears to be registered to a marketing company=09

dazo 21:44:15
I think a .org/.net split is quite appropriate=09

mattock 21:44:46
it would make sense, yes=09

ecrist 21:44:56
if we did the split, and had control of the .org domain=09

mattock 21:44:58
especially with such a community-driven development model as ours=09

cron2 21:45:01
openvpn.com looks like "parked and for sale"=09

ecrist 21:45:12
heh, the base price is $50,000
:\ 21:45:15
=20
mattock 21:45:25
they're trying to milk us=09

cron2 21:45:37
bastards=09

dazo 21:45:40
aren't there laws against such domain pirates for .com?=09

mattock 21:45:51
dazo: don't know=09

ecrist 21:45:57
probably, but the legal process costs money, too=09

cron2 21:46:01
if you have the trademark, you could sue them for damaging your good repu=
tation, etc.=09

dazo 21:46:15
exactly=09

cron2 21:46:21
but anyway, this is the bottom feeders of the Internet =09

mattock 21:47:08
slightly off-topic, but do you have suggestions on how to maintain traffi=
c to openvpn.net (commercial site) if the site is split?=09

cron2 21:47:30
have clearly visible links on openvpn.org=09

mattock 21:47:41
I would assume that 90% of traffic in openvpn.net comes there because of =
OpenVPN (not our products)=09
cron2 has no issues with pointing to "the other half of the code base" 21=
:47=09

ecrist 21:47:43
back on-topic, I'm not opposed to advertising of corp products, but I thi=
nk we (the community) need to be given autonomy, first.=09

dazo 21:47:51
On the community site: "Hosted by OpenVPN Technologies" and a *little* ad=
 banner/link=09

cron2 21:48:04
yeah, maybe that as well=09

ecrist 21:48:37
"Project hosting and hardware provided by OpenVPN Technologies" <banner_a=
d>=09

dazo 21:48:51
exactly=09

mattock 21:49:20
sounds reasonable, given current circumstances
I'll bring this up with Francis... 21:49:54
the domain split issue... 21:50:10
dazo: regarding "crossing borders"... anything else besides the (potentia=
l) ads that would cross the line? 21:51:00
=20
dazo 21:51:30
well, kind of "hiding" the community work, is moving it quite close to th=
e border as wel=09

mattock 21:51:49
I agree with that, it's unreasonable=09

dazo 21:52:00
making only the commercial version the first thing you see on the web pag=
es today, as an example=09

mattock 21:52:01
any particular issue?
ok 21:52:18
so, the website is too heavily "commercial", right? 21:52:48
=20
dazo 21:52:59
as it is today, for me, yes indeed=09

mattock 21:53:00
hence split would make sense?=09

dazo 21:53:13
exactly=09

mattock 21:53:18
makes sense=09

ecrist 21:53:20
there is a big problem where people download AS, thinking they're downloa=
ding the community version=09

mattock 21:53:45
ecrist: even though is says "Access Server _Product_"?=09

ecrist 21:53:51
yup=09

dazo 21:53:52
and I'd probably like to change "Community project" to "Open Source [proj=
ect]" ... to really highlight that=09

mattock 21:54:07
dazo: that'd be better=09

ecrist 21:54:09
I'd rather we just split things=09

mattock 21:54:40
that would make things simpler=09

ecrist 21:54:47
with a cross-link from either, "For the [commercial|open source] version,=
 click HERE"=09

dazo 21:55:05
yeah, for me a split where we can have full control on the community side=
, respectful links from both sides to each other - without need to overly=
 emphasis it, that's a good move for me=09
dazo don't need to say more ... he agrees with ecrist 21:55=09

ecrist 21:55:37
=09

cron2 21:55:43
+2=09

ecrist 21:55:49
<-- just just a pretty face
21:55:51
=20
mattock 21:56:31
dazo and I looked at examples of "split" sites and only came up with a fe=
w...
cron2, ecrist: anything you could share? 21:56:48
=20
dazo 21:56:53
I'm still waiting for Jan Wildeboer to answer me=09

mattock 21:57:00
dazo: ok=09

ecrist 21:57:22
nope. I think we may be suited to cut our own path=09

cron2 21:57:22
mattock: none off the top of my head but I'm too tired to think right now=
=09

mattock 21:57:33
how would you feel about discussing this split in a joint meeting with th=
e company guys? (not just me)=09

dazo 21:57:40
btw, with a split ... I also think that all the stuff in the "Community E=
dition" menu should be moved over to our Trac/wiki=09

ecrist 21:57:47
there are far too many failed corp/open-source splits out there to take b=
ad examples from=09

mattock 21:58:03
ecrist: care to elaborate?=09

ecrist 21:58:09
MySQL
'nuff said 21:58:13
21:58:14
OpenSolaris 21:58:25
=20
mattock 21:58:35
split being what in MySQL/OpenSolaris context?=09

cron2 21:58:41
MySQL actually worked out well, until Orrible came along=09

dazo 21:58:47
agreed=09

cron2 21:59:10
mattock: well, there you have "the same product, but the commercial offer=
ing is 'with fully commercial support'"=09

dazo 21:59:15
Sun actually began to understand quite some of what F/OSS is about=09

cron2 21:59:55
mmmh=09

dazo 21:59:56
mattock: basically, you can download Red Hat Enterprise Linux and install=
 it and use it ... but you won't get automatic updates and support unless=
 you pay for it
this model is the same for (Novell) SuSE Linux as well 22:00:32
(even though, who knows what happens with SuSE Linux with Attachmate behi=
nd the wheels) 22:00:57
=20
mattock 22:01:22
I think there's a need for us (the company) to "let openvpn go" mentally.=
.. and focus on working with the project and build products on top of it
like everyone else 22:01:30
=20
ecrist 22:01:46
I agree 100% with that=09

dazo 22:01:48
yes, exactly=09

ecrist 22:01:55
and, to be honest, is where I have been trying to steer things=09

mattock 22:01:56
that's going to be tough, but necessary sooner or later
I have no illusions about the current situation... it's very challenging =
for me, being in the middle 22:02:20
although I like challenges 22:02:31
=20
dazo 22:02:55
to give a harsh comment ... the later it happens, the more likely a fork =
might come ... then OpenVPN suddenly needs to change their path if the co=
mmunity manages to move their users to the fork=09

mattock 22:03:08
now, how about the joint company/community meeting?=09

dazo 22:03:32
I'm in ... but I'd like to have ecrist and/or krzee involved as well=09

mattock 22:03:42
dazo: libreoffice is a good analogy... all(?) *NIX distros moved to it in=
 ~6 months after the fork=09

ecrist 22:03:46
dazo: I don't think there would be a problem getting users to follow the =
fork, as openvpn would essentially stop getting developed.=09

dazo 22:04:00
ecrist: exactly =09

mattock 22:04:04
ecrist: true, given how things are now=09

dazo 22:04:10
mattock: yes, that's a very good example=09

cron2 22:04:18
meeting sounds cool, but can't promise anything yet, depends on location,=
 timing, pricing, family, customer projects...=09

ecrist 22:04:24
that, and most of the hard-core users know the dev community, now=09

mattock 22:04:26
and openvpn _is_ very dependant on it's distribution channels=09

ecrist 22:04:53
really easy to point the freebsd ports tree to forkVPN. =09

mattock 22:05:01
I've made all this very clear in my discussions with Francis... James und=
erstands this better
cron2: I'm thinking about virtual meeting, although a "real" meeting woul=
d be very nice 22:05:30
=20
ecrist 22:05:46
fly us all to Miama or Tampa, Florida
22:05:48
=20
mattock 22:05:53
not sure if we (the company) could cover the costs, though =09

ecrist 22:05:54
I'll buy beer=09

dazo 22:06:19
well, cover 50% on best price tickets =09

mattock 22:06:23
how about New York?=09

dazo 22:06:39
NYC is affordable from Europe=09

cron2 22:06:43
well, we have a virtual meeting every (second) week  - so I'm not sure wh=
at you were suggesting=09

mattock 22:06:49
my thoughts exactly
cron2: every third week, to be exact 22:06:56
=20
cron2 22:07:09
I wouldn't expect the company to cover the costs, not something a smallis=
h shop could easily do=09

mattock 22:07:31
cron2: if we could put ads to the Windows installer we sure could!  just =
kidding=09

cron2 22:07:53

anyway. Just a few comments on the next item, then I go to bed 22:08:08
=20
mattock 22:08:12
anyways, I was thinking about a meeting with at least Francis and James a=
ttending
ok, let's move on 22:08:24
=20
cron2 22:08:34
a) "I have no idea what the management interface does", would need to ask=
 d21fk or James about that.
b) right now, there's well-defined exit codes for "OK!" and "FAIL!" but n=
othing more differenciated - it could be done, but given that it all exit=
s via a common function (msg()) it's not trivially changed 22:09:13
=20
dazo 22:09:26
Actually, the management interface is available on the clients before con=
necting ... to pass username/passwords to the daemon before connecting
b) is doable to change though, even though, it would require (a needed) o=
verhaul of the whole msg()/err.[ch] stuff 22:10:16
=20
cron2 22:10:37
it's doable, agreed, but it's not like "change a few exit() statements he=
re and there"=09

dazo 22:10:46
yup=09

cron2 22:11:42
ok -> off to bed now, will be back tomorrow *yawn* 'twas a good meeting, =
even though the topics were really dangerous today =09

dazo 22:11:53
=09

mattock 22:11:54
I'll ask Russell what management functionality he'd need and why=09

dazo 22:12:03
sounds good=09

mattock 22:12:11
cron2: "no risk, no fun"... wise words from my previous boss=20
let's call it day, it's very late 22:13:12
=20
dazo 22:14:36
yeah, sounds good=20
thx a lot everyone! 22:14:40


--------------000902020001020108030307--

