Message-ID: <4BF63BBE.4030603@...515...>
Date: Fri, 21 May 2010 10:52:30 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010308040508060404030504"
Subject: [Openvpn-devel] Summary of the IRC meeting (20th May 2010)
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
--------------010308040508060404030504
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 20th May 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-05-20>

Next meeting next week, same place, same time. Your local meeting time
is easy to check from services such as

<http://www.timeanddate.com/worldclock>

or with

$ date -u


SUMMARY

Discussed the possibility of users offering bounties for development
tasks (e.g. adding features or fixing bugs). Agreed that having a bounty
system would be a good idea. The ideas brought up in the IRC discussion
before and during the meeting are here:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-05-20#Developerboun=
ties>

Discussed building a continuous integration server. It would spot build
problems early on, allow testing the code for problems (e.g. with
Coverity) and allow automatic packaging and releasing of Openvpn-testing
 packages. Agreed that this is a good idea. More details here:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-05-20#Continuousint=
egrationserver>

Discussed creating a Beaker automated test framework for OpenVPN. It
would allow automated verification of OpenVPN's external behavior using
various OS/application configurations. This would in turn reduce manual
testing effort considerably and improve code quality. More details here:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-05-20?version=3D8#B=
eakertestframework>
<https://fedorahosted.org/beaker>

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------010308040508060404030504
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-05-20.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-05-20.txt"

(21:08:32) jamesyonan: hi
(21:08:38) ecrist: hello
(21:09:10) mattock: hi james!
(21:09:37) mattock: today's topics: https://community.openvpn.net/openvpn/w=
iki/Topics-2010-05-20
(21:09:39) vpnHelper: Title: Topics-2010-05-20 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN (at community.openvpn.net)
(21:09:51) mattock: no bugs or anything today as dazo is not here... and I =
guess it's been a quiet week
(21:10:19) mattock: anything else somebody would like to add to the topic l=
ist before we start?
(21:10:21) ecrist: jamesyonan: FYI, openvpn-devel port is going to be defau=
lt in pfSense 2.0
(21:10:46) jamesyonan: cool
(21:11:11) ecrist: talked with their lead developer over some beer last wee=
k.
(21:11:36) ecrist: as of friday last week, they were going to be using week=
 19 snapshot (last week)
(21:12:47) mattock: should we begin from the bottom this time :)? " Develop=
er bounties"
(21:14:21) mattock: I think the idea is covered pretty well in the descript=
ion... so what do you think about it? Props for this go to ecrist, btw
(21:16:18) mattock: the only issue I can think of is with features which ca=
n't be included to main source tree. But that affects the payments more tha=
n anything else
(21:16:56) mattock: ecrist: do you have ideas how the money transfer etc. w=
ould be implemented?
(21:17:00) mattock: the bureaucracy I mean
(21:17:39) waldner: are there prior examples of this in other open source p=
rojects? To get an idea of the effects it could have
(21:17:42) ecrist: what do you mean?
(21:17:58) ecrist: waldner: lots of them.  freeswitch has done it. pfSense =
does it
(21:18:04) waldner: ah thanks
(21:18:20) ecrist: some projects have it, on an unofficial level
(21:18:39) mattock: funambol also has quite a few of these, for example htt=
ps://phonesniper.forge.funambol.org/
(21:18:41) vpnHelper: Title: phonesniper: Home (at phonesniper.forge.funamb=
ol.org)
(21:19:04) mattock: so there is prior art
(21:19:12) waldner: thanks, I guess then it was just that I hadn't heard of=
 them
(21:19:33) mattock: I think this is a very good idea... do we all agree on =
that?
(21:20:06) jamesyonan: bounty seems like potentially a good idea, but would=
 need volunteers to manage it -- i.e. vetting of code, insuring that requir=
ements are met, etc.
(21:20:13) ecrist: mattock: as far as money transfer/handling
(21:20:41) mattock: jamesyonan: the idea is to integrate it to the developm=
ent process... so that all written features have to pass the normal develop=
ment process=20
(21:20:53) ecrist: I think the process could be as follows: user submits a =
bounty request, and deposits their money via paypal to a holding fund.
(21:20:56) mattock: so that no crap can get in
(21:21:23) ecrist: the holding fund helps to assure that 1) the money gets =
paid and 2) the developer does the work
(21:21:58) ecrist: the creator/subscriber can set a timeout, at which point=
 the funds are refunded and the bounty dropped.
(21:22:30) ecrist: the timeout would not apply to work in progress, given a=
 reasonable time
(21:22:59) mattock: is this all (e.g. timeouts) achievable using paypal or =
is it manual work?
(21:23:03) waldner: sounds reasonable
(21:23:15) ecrist: mattock: it could be accomplished automatically with cro=
n jobs
(21:23:25) ecrist: I
(21:23:31) mattock: ecrist: ok, sounds good
(21:23:42) ecrist: 've done development with Paypal's API, so I'm familiar =
with how to handle that system
(21:24:18) ecrist: I do think the fund needs to be a non-developer and non-=
openvpn technologies entity, however
(21:24:48) waldner: I have a question though
(21:25:03) jamesyonan: how is copyright handled by other open source projec=
ts that use bounties?  Does the developer hold the copyright or the bounty-=
payer?
(21:25:14) agi: hi all, sorry for being late
(21:25:17) waldner: wouldn't this system kind of "hold back" people from im=
plementing new features when there's no bounty?
(21:25:21) mattock: hi agi, no probs
(21:25:43) waldner: ie, features they want to add, but noone requested?
(21:26:26) mattock: waldner: I thought of that too... however, developers t=
end to do things are important to them. So if you, say, want ipv6 support, =
you'll work on it, bounty or no bounty...
(21:26:37) waldner: just asking, eh, I'm not against it in principle
(21:26:53) waldner: yes, I suppose that is at least partly true
(21:26:54) mattock: waldner: I didn't mean to be rude or anything :)
(21:26:55) ecrist: jamesyonan: good question. I would posit that we could f=
orce a BSD license upon the code generated during a bounty
(21:27:03) waldner: me neither :)
(21:27:17) mattock: ecrist: I think GPLv2 and BSD licenses are incompatible=
, or are they?
(21:27:35) ecrist: depends on the direction
(21:27:48) ecrist: you can include BSD licensed code in GPL, but not vice-v=
ersa
(21:28:54) agi: ecrist: not always
(21:29:18) agi: the original BSD license is not GPL compatible
(21:29:51) agi: 'cos it has and 'advertisement' clause
(21:29:59) mattock: I'd say requiring GPLv2 would make most sense, given Op=
enVPN is GPLv2 licensed anyways... or what benefit would we get by using a =
BSD license?
(21:30:19) ecrist: BSD is 'really' free, GPLv2 requires GPLv2+
(21:30:30) mattock: ok, now we get to religious issues :)
(21:30:53) mattock: GPL protects the code's freedom, whereas BSD license do=
es not :)
(21:30:58) ecrist: you can take BSD licensed code, as long as you mention t=
he original author, can relicense it as GPLv2 with your changes.
(21:30:59) mattock: but let us not go into this
(21:31:14) ecrist: you can't enfoce GPLv2 on the code you didn't write, as =
the original source still maintains BSD
(21:31:55) ecrist: the reason I recommend BSD for bounties, is either party=
 (payer or payee) can take the code and do with it as they please, with the=
 code remaining available to the project at large.
(21:32:26) jamesyonan: agreed -- I think BSD makes sense for bounties
(21:32:27) mattock: ecrist: ok, sounds reasonable
(21:33:13) mattock: ok, so for the OpenVPN project use we'd relicense the B=
SD-licensed code under GPLv2 and mention the author=20
(21:33:14) mattock: ?
(21:34:05) mattock: and the developer and payer could use the BSD-licensed =
version any way they please?
(21:34:13) ecrist: essentially
(21:34:22) mattock: ok, sounds good
(21:35:09) mattock: ecrist: are you thinking about volunteering for this jo=
b? :)
(21:35:18) ecrist: the thing to remember is the original source remains BSD=
 licensed, you can't enfoce another license upon code that's available alre=
ady
(21:35:24) ecrist: mattock: I could, sure.
(21:35:37) ecrist: I had me in mind, but wouldn't mind someone stepping up.
(21:35:53) mattock: what if we send mail to -users mailinglist about this
(21:36:12) mattock: to verify the licensing issues and to ask if somebody w=
ants to take part in this
(21:36:17) ecrist: before we get the community at large involved, I think w=
e need more legwork.
(21:36:26) mattock: how come?
(21:36:51) ecrist: for one, where there is money involved, there needs to b=
e some organization
(21:37:43) ecrist: I was thinking that we could create, ala FreeBSD, The Op=
enVPN Foundation, to hold the monies and potentially, in the future, benefi=
t further development in the future.
(21:38:17) ecrist: i.e. people donate money to open source projects, nobody=
 wants to donate money to an evil corporation (no offense OpenVPN Technolog=
ies, Inc)
(21:38:30) agi: we could also 'use' SPI
(21:38:33) ecrist: we could use that foundation to hold those donations, in=
 addition to the bounties.
(21:38:55) agi: if we want to save the hassle of creating a NPO
(21:39:02) ecrist: what is SPI?
(21:39:16) agi: http://www.spi-inc.org/
(21:39:18) vpnHelper: Title: Welcome to SPI Welcome to SPI (at www.spi-inc.=
org)
(21:39:32) agi: SPI is a non-profit organization which was founded to help =
organizations develop and distribute open hardware and software
(21:39:53) krzee: sorry im late
(21:40:06) mattock:  hi krzee!
(21:40:12) krzee: hey =3D]
(21:40:17) mattock: agi: so SPI takes care of the bureaucracy stuff?
(21:40:28) agi: right
(21:40:41) agi: http://www.spi-inc.org/projects
(21:40:42) vpnHelper: Title: Projects Welcome to SPI (at www.spi-inc.org)
(21:42:32) astrophy [~astrophy@...1372...] =EF=BF=BD=EF=BF=BD entrato nel c=
anale.
(21:42:55) agi: there's also 3rd party sites devoted to free software bount=
ies
(21:42:58) mattock: agi: is there a way to link a SPI donation to a specifi=
c feature?
(21:43:35) agi: yes, when donations are made, they can be marked for a proj=
ect
(21:43:51) krzee: how about for a feature for that project?
(21:44:07) krzee: like "ipv6 in openvpn"
(21:44:07) mattock: yep, that's what I meant
(21:44:14) agi: so I guess, it could be marked at 'feature level' too
(21:44:34) agi: but I guess contacting SPI for those details would be bette=
r than my word
(21:44:59) mattock: ok, I think we need to check out SPI and similar servic=
es... creating a foundation at this point is probably an overkill
(21:45:45) mattock: that is, if we don't have to do that...
(21:46:55) mattock: should we crowdsource this SPI/foundation/whatever thin=
g by sending mail to -users... we'd also see what kind of feedback this pla=
n would get
(21:47:00) astrophy ha abbandonato il canale (quit: Ping timeout: 252 secon=
ds).
(21:48:50) mattock: let me rephrase that... any objections against sending =
mail about this to -users mailinglist? ;)
(21:49:42) ecrist: no
(21:49:57) mattock: ok, anything else we'd need to discuss regarding bounti=
es?
(21:50:15) ecrist: until we resolve WHERE to keep the money, no.
(21:50:38) ecrist: so far, I've been keeping money donated to the community
(21:50:53) ecrist: http://www.secure-computing.net/wiki/index.php/OpenVPN/D=
onations
(21:50:54) vpnHelper: Title: OpenVPN/Donations - Secure Computing Wiki (at =
www.secure-computing.net)
(21:52:09) mattock: ok, shall we move to next topic: "Continuous integratio=
n server" (https://community.openvpn.net/openvpn/wiki/Topics-2010-05-20)
(21:52:11) vpnHelper: Title: Topics-2010-05-20 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN (at community.openvpn.net)
(21:53:20) mattock: ok, so in a nutshell the idea is to a) spot build probl=
ems a.s.a.p. b) create and publish openvpn-testing packages (source+binary)
(21:53:24) mattock: automagically
(21:54:06) ecrist: I'm guessing something with virtualization?
(21:54:15) mattock: it could also probably be used a centralized place to r=
eview the code with automated tools
(21:55:17) jamesyonan: I should also mention that the OpenVPN project has a=
n account with Coverity to use their commercial, compile-time bug-finding t=
ool
(21:55:52) mattock: ecrist: the idea with continuous integration is to chec=
k that no commits cause the build to break... but if this would be integrat=
ed with beaker then the build could be tested with multiple OS'es / setups
(21:57:04) mattock: jamesyonan: how does coverity work? is it a standalone =
app?
(21:58:14) jamesyonan: it's a web app -- you basically upload the source co=
de to the web app, run it, and it produces a list of source code warnings
(21:59:04) mattock: does it have an API that could be used? e.g. to launch =
the check automatically from the CI server?
(21:59:25) mattock: and mail the results to -devel
(22:00:09) ecrist: any non-javascript/java/flash site should be scriptable
(22:00:28) ecrist: and for the others, there are plugins for firefox to wor=
k around that
(22:00:44) mattock: a clean API would be nicer, though :)
(22:01:02) ecrist: HTTP POST *is* an API. ;)
(22:02:10) mattock: guess so, but the web pages are not guaranteed to remai=
n the same... anyways, this is worth checking out
(22:02:26) jamesyonan: not sure -- I haven't used it extensively
(22:02:51) mattock: ok, let's check if it's programmable... if not, we can =
/ should still use it periodically
(22:04:01) mattock: so do you think the whole idea with continuous integrat=
ion / openvpn-testing packaging+publishing server worth the effort?
(22:04:51) mattock: I think we need to publish openvpn-testing packages any=
ways, so the CI stuff is basically cream on top of that
(22:05:18) mattock: and it should be relatively trivial to setup
(22:06:50) ***ecrist on phone with Coverity
(22:06:56) ecrist: they have an API
(22:07:02) mattock: great!
(22:07:17) ecrist: jamesyonan: can you get me the login info?
(22:07:30) jamesyonan: sure
(22:07:53) krzee: [12:06]  <mattock> so do you think the whole idea with co=
ntinuous integration / openvpn-testing packaging+publishing server worth th=
e effort?
(22:07:54) krzee: i do
(22:08:03) krzee: takes a human step out of the process
(22:08:12) ecrist: I was told by sales that there is an API and it's covere=
d under the documentation within the account
(22:08:21) krzee: which makes it easier and therefor more likely for people=
 to test stuff in -testing
(22:08:53) ecrist: krzee: pfSense 2.0 is going to use my openvpn-devel free=
bsd port by default. :P
(22:08:58) krzee: besides, afaik ecrist has that most of the way done
(22:09:01) mattock: ok, then we could integrate coverity checks into the CI=
 server...=20=20
(22:09:03) krzee: ecrist, ya thats coolness!
(22:09:38) mattock: I'll start working on the CI stuff once I get my backlo=
g a little shorter :)
(22:09:38) ecrist: now if only I can con openvpn tech into paying my way to=
 BSDCan next year. muahaha
(22:10:51) mattock: shall we move on to "Beaker test framework"... this is =
originally dazo's idea which was discussed already in November/December I t=
hink=20
(22:11:41) mattock: so the basic idea with Beaker is to automatically test =
an application with various setups... for example, on different OS'es, with=
 different settings, etc.
(22:11:58) mattock: so that problems with the external functionality of the=
 application can be spotted early on
(22:12:40) mattock: the only downside here is that a) it requires quite a l=
ot of VM's, b) takes a while to setup so that it does something useful
(22:13:19) mattock: also, if we want to test OpenVPN in "extreme" condition=
s, we'd need VM's from community members with really crappy connections :)
(22:13:44) krzee: i have crappy connection
(22:13:52) ecrist: me too
(22:13:53) krzee: its normal MTU, but its shitty bw
(22:13:57) ecrist: :P
(22:13:59) krzee: ecrist, liar!
(22:14:07) mattock: in general, providing VM's for Beaker would be an easy =
way for community members to contribute to the project
(22:14:25) mattock: krzee, ecrist: do you have incredible packet loss perce=
ntage, too?
(22:14:26) krzee: interestingly enough i dont need to adjust MTU over a sat=
 link even
(22:14:42) krzee: nope, actually i dont have packet loss
(22:14:45) ecrist: mattock: I was kidding, I have a good connection.
(22:14:51) krzee: even over the aforementioned sat link
(22:14:59) mattock: ecrist: how can I believe anything you say anymore? :)
(22:15:13) jamesyonan: re: crappy connections -- OpenVPN has some code (loo=
k for "gremlin" in the source) to simulate crappy connections and packet co=
rruption.
(22:15:17) krzee: ecrist's link is so good i have a colo in his basement
(22:15:17) krzee: lol
(22:15:24) ecrist: recall the  wiki/forums and such currently reside on my =
connection.
(22:16:01) ecrist: I'm sure it wouldn't be too difficult to simulate some o=
f that within a series of vms and firewall foo
(22:16:18) ecrist: be a bit of work to setup, but once you have the test en=
vironment, it's easy to do the tests
(22:16:31) waldner: AFAIR with netem or dummynet it should be possible to e=
mulate arbitrary packet loss, latency, etc
(22:16:49) waldner: I have to refresh that, it was much time ago
(22:17:08) mattock: jamesyonan, waldner: interesting... so this packet loss=
 testing thingy has been taken care of already :)
(22:17:55) jamesyonan: the code is there to do the testing, but we don't ha=
ve an automated system in place to exercise it
(22:17:57) waldner: yes, it's a fairly common requirement for emulated netw=
orks...vde has facilities for that too
(22:18:19) mattock: jamesyonan: you mean the gremlin stuff?
(22:18:24) jamesyonan: yes
(22:19:29) mattock: perhaps we should take a good look into Beaker and what=
 it can do... as it can test connectivity between the tested VM's, it might=
 be able to test it with simulated packet loss, too
(22:20:57) mattock: so this Beaker stuff _may_ be possible to integrate wit=
h the CI stuff - as dazo put it - "with some creative scripting"=20
(22:21:55) mattock: does anyone have anything to add to this CI/Beaker mess=
? Or shall we call it a day and start working on these a.s.a.p.?
(22:23:05) mattock: anything else to discuss today?
(22:23:17) ecrist: not for me
(22:24:56) mattock: ok, I'll summarize the meeting tomorrow and send mail r=
egarding the bounty system to -users

--------------010308040508060404030504--

