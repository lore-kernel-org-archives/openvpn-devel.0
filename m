From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <420f8ab2-24ed-e57d-cc83-1c3b4beaea92@...515...>
Message-ID: <93e22e5a-51c0-f15a-f4e1-822ac6797ef1@...515...>
Date: Wed, 4 Aug 2021 16:12:09 +0300
MIME-Version: 1.0
In-Reply-To: <420f8ab2-24ed-e57d-cc83-1c3b4beaea92@...515...>
Content-Type: multipart/mixed; boundary="------------06684ECBCF522183E6F24456"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (4th August 2021)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------06684ECBCF522183E6F24456
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on libera.chat
Date: Wed 4th August 2021
Time: 14:00 CET (12:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2021-08-04>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, d12fk, mattock, MaxF, ordex and plaisthos participated in 
this meeting.

---

Plaisthos and ordex want to pick up DCO again and work on it again to 
have it integrated soon.

---

Talked about the OpenVPN 2021 hackathon:

<https://community.openvpn.net/openvpn/wiki/Hackathon2021>

The company hosting the meeting wanted to publish a blog post about the 
hackathon, which sounded very acceptable, especially if we can have a 
say on the content of the blog post before it gets published. Mattock 
will compile an executive summary of the hackathon for the CEO of 
OpenVPN Inc. to see if it all looks good.

---

Talked about the pluggable transport patchset that was funded by Google 
and implemented by Operator Foundation. Ordex has been talking to the 
Google PM responsible for it and it is unclear if the patchset will have 
a maintainer should we decide to merge it. The patchset is fairly 
intertwined with the rest of codebase, so we do not want to merge it 
without somebody taking responsibility over it. As far as we know the 
patches are not used by anyone (outside of Google).

Ordex will make more inquiries to gauge the interest in the patchset 
from Google / Operator Foundation.

---

Talked about the new buildbot setup. It is already a drop-in replacement 
for the old one. The only not fully implemented yet is building of MSIs. 
As cron2's FreeBSD buildslaves are unupgradeable because of Buildbot 
0.7/0.8's dependency on Python 2, it was decided to expedite moving the 
new buildbot to production.

-- 

Full chatlog attached

--------------06684ECBCF522183E6F24456
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2021-08-04.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2021-08-04.txt"

(14:57:47) mattock_: hello
(14:58:23) MaxF: hello!
(14:59:31) plaisthos: moin
(15:00:15) lev___: hello
(15:00:18) cron2_: oi
(15:00:19) dazo: hey!
(15:01:44) mattock_: we have dazo here as well! \o/
(15:02:49) dazo: well, somewhat physically at least :-P
(15:03:34) ***cron2_ looks
(15:03:39) cron2_: no, just virtual dazo
(15:03:40) mattock_: as long as your brain and fingers work a bit that's =
enough :)
(15:03:50) dazo: lets see! :-D
(15:04:20) cron2_ ha scelto come argomento: https://community.openvpn.net=
/openvpn/wiki/Topics-2021-08-04
(15:05:12) mattock_: let's start, five minutes past
(15:06:23) plaisthos: ordex and I want to pick up DCO again and work on i=
t again to have it integrated soon
(15:06:40) d12fk: has the hackathon (venue) been discussed last week alre=
ady?
(15:06:41) mattock_: I recall most of the prerequisites are in now
(15:06:54) plaisthos: I still have to finish a few other tasks this week =
but will be working DCO again next week
(15:07:15) ordex: hi there!
(15:07:26) mattock_: hi ordex!
(15:07:45) ordex: what plaisthos says
(15:08:33) cron2_: d12fk: no, because dazo was missing, and my appointmen=
t with qaware was only thursday
(15:08:42) cron2_: so, let's get the hackathon done :-)
(15:09:20) dazo: the qaware site looks really nice, and a really generous=
 offer from them
(15:09:24) cron2_: I spoke with qaware last week, explained about "corp" =
and "community", and they are all happy.  The room is huge (ordex shared =
the pictures internally, I hope) and even with corona we can fit 20 perso=
ns in
(15:09:29) d12fk: I've updated the wiki with the best (imho) Hotel option=

(15:10:02) ordex: well, it seems we converged on to qaware already :)
(15:10:08) cron2_: they noticed that they actually do use openvpn for the=
ir corp VPN :-) - so the boss is totally happy now, and some of the tech =
geeks that saw me with the OpenVPN T-Shirt were like "oh, openvpn, cool!"=

(15:10:48) cron2_: what they want is to do a bit of PR with us ("look, qa=
ware is a totally great place to work, we do all these nice things togeth=
er with the open source community") and I think this is a good thing
(15:11:04) ordex: agreed
(15:11:05) mattock_: +1
(15:11:11) dazo: sounds reasonable
(15:11:17) ordex: they can feature the hackathon on any pr material they =
should do?
(15:11:18) cron2_: they actually do a lot of open source integration work=
, organize meetups here in munich, etc.
(15:11:28) ordex: cool
(15:11:34) cron2_: ordex: yep
(15:11:34) ordex: sounds like a very good fit :)
(15:12:01) cron2_: they also seem to have a few people interested in look=
ing into openvpn - I said "Fri-Sun they are very welcome"
(15:12:08) dazo: +1
(15:13:02) mattock_: +1
(15:13:15) cron2_: the only drawback I could find is that there are not t=
oo many exciting-looking restaurants in very close distance, so for lunch=
 it might end up "going to their cantina" (we'd have to pay for this ours=
elves :-) ) or "order something"
(15:14:24) dazo: I don't see that as an issue
(15:14:28) mattock_: is it close enough to good restaurants that food can=
 still be delivered?
(15:14:32) mattock_: not "in the woods"
(15:14:48) cron2_: it's in the middle of the city, so yes :)
(15:14:53) ordex: I presume the closest good restaurant is across the bor=
der?
(15:14:54) ordex: :p
(15:14:55) d12fk: plus supermarket across the street
(15:15:05) cron2_: yeah, supermarket is easy
(15:15:06) mattock_: we can buy two dozen frozen pizzas
(15:15:15) d12fk: check
(15:15:16) mattock_: and wait 3 hours to have all of them cooked
(15:15:26) ordex: do they have a pantry we can use somehow?
(15:15:41) ordex: (not important though, just to set expectation on what =
we can arrange)
(15:15:50) cron2_: there is a kitchen with coffee machine, fridge, beer f=
ridge :-) - but I have not checked for cooking facilities
(15:15:58) ordex: alright
(15:16:00) d12fk: i have one in my room, will deliver for a small fee =3D=
)
(15:16:11) cron2_: d12fk: a frozen pizza?
(15:16:19) d12fk: l=C3=B6l
(15:17:53) d12fk: i am really happy about the place, think it is way bett=
er than a hotel conference room
(15:17:53) cron2_: 596 shows two kitchen installations that look like "ov=
en" or "big microwave"
(15:18:21) cron2_: and the glossy space behind the orange/apple juce look=
s like a cooking field
(15:18:22) mattock_: yeah the meeting room thing was looking pretty grim =
untli now
(15:19:00) cron2_: they have tea :-) - and a hot water tap that is hot en=
ough for tea
(15:19:15) cron2_: and a cold water tap with sparking water :-)
(15:19:44) cron2_: (I *did* mention the piano, did I?  If I were looking =
for a new job, this would be really tempting :-) )
(15:19:56) mattock_: :)
(15:19:57) dazo: mattock_: you want to run this first via Francis, or doe=
s this sound good enough to just say "yay!" and we start planning travel/=
hotel?
(15:20:24) mattock_: so what is the cost?
(15:20:28) dazo: 0
(15:20:37) mattock_: well I doubt Francis will complain about that
(15:20:39) mattock_: :)
(15:21:02) dazo: well, the cost is that they might do some PR stunts with=
 us
(15:21:19) mattock_: I guess we'd have to figure out what "some PR stunts=
" means exactly
(15:21:32) mattock_: who can get that info?
(15:21:59) cron2_: I have agreed to "a blog post" on their corporate web =
site, with "people who are willing to be photographed"
(15:22:05) cron2_: which is explicitly voluntary
(15:22:24) d12fk: least they can ask imho
(15:22:32) mattock_: ok, if there's no "OpenVPN Inc / OpenVPN project lov=
es us and wants to tell everyone our place is the greatest" then I think =
it is ok
(15:22:34) cron2_: so this is not like "TV and radio interview for half t=
he time" :-)
(15:22:40) mattock_: we should just ask to review the blog post before pu=
blishing
(15:22:54) cron2_: mattock_: I think we agreed on that
(15:22:56) mattock_: ok
(15:23:21) mattock_: we can maybe have a corresponding blog post of our (=
Inc) own
(15:23:27) cron2_: the planned twist is more "qaware profits so much from=
 open source software, and one of them is OpenVPN.  Because we're nice gu=
ys, we sponsored the yearly Hackathon in qaware's meeting facilities"
(15:23:46) mattock_: yeah, sounds very reasonable
(15:23:54) d12fk: legit
(15:24:03) dazo: +1
(15:24:22) mattock_: I think what we can do is draft a plan of the hackat=
hon for Francis with the details he needs to know
(15:24:26) cron2_: I met with the CEO in person last Thursday, and have a=
 no doubts on a personal level
(15:24:28) mattock_: short executive summary
(15:24:39) cron2_: like "I doubt their motives" or so :)
(15:24:51) cron2_: (and the recommendation came in via a mutual friend)
(15:25:41) mattock_: seems like they're nice guys
(15:26:30) mattock_: ok, all good hackathon-vise?
(15:26:35) cron2_: their web site claims an "great place to work" award 2=
015-2021 :-)
(15:26:37) cron2_: yes
(15:26:55) mattock_: anything more on DCO/2.6?
(15:26:56) cron2_: (as d12fk has noticed, I've started a wiki page.  It d=
oes not have much stuff on it yet)
(15:27:13) mattock_: link?
(15:27:35) cron2_: https://community.openvpn.net/openvpn/wiki/Hackathon20=
21
(15:28:00) mattock_: thanks!
(15:28:06) ordex: regarding 2.6 there is the question whether we wanted t=
o attempt including the transport-api
(15:28:08) cron2_: d12fk: 80 EUR for 3 nights?  Is that a typo?
(15:29:06) d12fk: yeah that is for one night
(15:29:24) mattock_: still very affordable
(15:29:27) mattock_: covid-19 price I suppose
(15:29:39) ordex: yeah
(15:29:42) d12fk: romm only is ~62 if you'r enot into breakfast
(15:30:18) cron2_: mattock_: Munich is expensive, so 80 EUR including bre=
akfast is actually a good deal
(15:30:48) cron2_: I'll change the table header from "1p, 3nights" to 1p,=
 1night" :-)
(15:31:01) mattock_: cron2: I recommend doing that
(15:31:26) cron2_: how is the plan for the corp part?  Do you generally f=
ly in on monday evening, or arrive "tuesday morning-ish"?
(15:31:49) plaisthos: with my booking Genius I get 10% off
(15:31:53) cron2_: I told them I'll be there on Tuesday to do introductio=
ns, and then leave the site to you
(15:32:43) ordex: normally we arrive on tuesday
(15:32:47) ordex: morningish
(15:32:54) d12fk: think the US guys will be there Monday latest. the rest=
 depends I guess
(15:32:59) ordex: somebody may arrive the day before, but it's on his own=

(15:33:24) plaisthos: I might arrive on Friday and visit a friend over th=
e weekend
(15:33:57) cron2_: ok, good... so we can start with some people on Tuesda=
y morning, I do the handover, and then the rest can arrive during the day=

(15:35:36) cron2_: so -> 2.6/DCO: sounds good to me, let's see we can get=
 back some traction there
(15:36:21) ordex: yap
(15:36:28) cron2_: public service announcement: it's school holidays in M=
unich since this week, so roughly the next 4 weeks I will be family-chall=
enged and can't dedicate "full days" to openvpn
(15:36:46) cron2_: but I'll definitely be around and do merging and testi=
ng duty :)
(15:36:54) ordex: ok, thanks for the headsup
(15:37:01) ordex: regarding the transport-api
(15:37:24) ordex: I have talked to the guys who worked on it and I have n=
ot been able to understand if anybody is willing to further contribute to=
 this code should we have bugs or challenges
(15:37:38) ordex: it seems there is no real installation out there being =
maintained by some community/company
(15:37:45) ordex: so my fear is that this code will all become debt to us=

(15:37:58) mattock_: how intertwined is it to the rest of the codebase?
(15:38:04) ordex: therefore the question is: does anybody feel interested=
 enough into this code to so strong about having it merged?
(15:38:22) ordex: mattock_: quite a lot, rebasing is not easy and touches=
 a big chucnk of the socket handling code
(15:38:29) ordex: *chunk
(15:38:35) ordex: so it's not "just some isolated code"
(15:39:15) mattock_: ok
(15:39:20) cron2_: tbh, I found their interaction a bit weird all the tim=
e... like, not being part of the regular list, but channeling everything =
through you
(15:39:20) ordex: now I am waiting for another reply for the devs to see =
what their plan is. but it seems there is not much "community interest" s=
o far
(15:39:35) ordex: cron2_: that's because this was basically a funded proj=
ect
(15:39:44) ordex: somebody put money on the table to have a foundation do=
 the coding
(15:39:49) ordex: they are done -> please merge
(15:39:51) ordex: project done
(15:40:01) cron2_: if you want your funded project to go into upstream, e=
ngage properly with upstream...
(15:40:07) ordex: [this is a very high level explanation]
(15:40:21) cron2_: (or throw funds at upstream to do the work)
(15:40:24) ordex: well, they posted the patches..there was $some feedback=
, but nothing more came in
(15:40:35) mattock_: it was funded by Google I recall
(15:40:40) ordex: cron2_: I can ask if they want to throw funds upstream,=
 but does it solve the underlying problem?
(15:40:46) mattock_: dazo and I went to visit the Google guy in Stockholm=

(15:41:00) ordex: we will have a big chunk of code that not many people a=
re interested in
(15:41:15) plaisthos: and might not even have real world usage
(15:41:27) ordex: I think the idea is that "they did the development effo=
rt", now "community handle it"
(15:41:37) cron2_: well
(15:41:38) mattock_: I think we should ask the original funder and if the=
y have any doubts then just scrap it
(15:41:39) ordex: which might be good if we were after this feature
(15:41:46) ordex: but we are not (I think)
(15:42:02) ordex: mattock_: any doubts?
(15:42:03) cron2_: if there are no users to it, who would use, test, and =
report issues with it, we shouldn't merge it
(15:42:13) ordex: cron2_: agreed - this is what I Asked
(15:42:28) ordex: also simply for testing, I was hoping to get a test ser=
ver or something, ran by some users
(15:42:31) mattock_: the project was funded for reason <x> which I can't =
fully remember anymore
(15:42:32) cron2_: or maybe go for something simpler ("only packet mangli=
ng, not actually interfering with the sockets")
(15:42:33) ordex: but it seems there is none so far
(15:42:49) ordex: well, they already have an "out-of-openvpn" solution
(15:42:49) mattock_: if the reason is not gone, then the funder might be =
interested in maintaining the patchset
(15:43:08) mattock_: I can try to find the contact details for the funder=

(15:43:17) mattock_: I assume nobody contacted him already?
(15:43:30) ordex: mattock_: the funder may maintain the patch set could m=
ean "pay random person to answer questions on the ml or fix bugs", but I =
dare to say this is not a problem to be solved with money :D
(15:44:10) ordex: mattock_: wh should be the funder? Google?
(15:44:12) ordex: *who
(15:44:13) mattock_: google yes
(15:44:23) mattock_: they hired operator foundation to develop the code
(15:44:26) ordex: I am in touch with the PM - it was him who brought the =
topic back up
(15:44:29) ordex: right
(15:44:30) mattock_: I assume, but could be wrong, that google still uses=
 this
(15:44:39) mattock_: ordex: ok
(15:44:47) ordex: I asked the guy is anybody is using this stuff, he aske=
d the operator foundation
(15:44:49) ordex: *if
(15:44:57) mattock_: if the project manager at google is not sure, then w=
e should just scrap the patches imho
(15:45:20) ordex: ok, I will try to clarify who uses this code and if the=
 original motivation is still there then
(15:45:25) mattock_: I recall the patched openvpn was on a digital ocean =
droplet
(15:45:32) mattock_: some google side project
(15:45:42) ordex: my feeling is: they want it merged as it's part of the =
roadmap
(15:45:46) ordex: mattock_: ok
(15:45:54) ordex: will double check then
(15:45:56) mattock_: ok
(15:46:09) ordex: however, can we agree that the feeling is "if this is n=
ot used by people for real, we shouldn't merge it" ?
(15:46:21) mattock_: I think that is reasonable
(15:46:34) ordex: ok
(15:46:35) mattock_: even if it is used, but there's no maintainer, then =
not merge it?
(15:46:43) dazo: yes, and that's basically the matra we try to follow reg=
ardless of patches/projects
(15:46:49) ordex: yap
(15:46:54) ordex: I think it's just open source style :)
(15:47:01) dazo: yeah
(15:47:03) mattock_: ok, let's outline our policy and let them decide how=
 they want to handle it
(15:47:13) ordex: will try to dig out some more info then, to clarify the=
 situation
(15:47:18) mattock_: great!
(15:47:29) ordex: goed, thanks for the input
(15:47:34) mattock_: I need to get $child from kindergarten in about 7 mi=
nutes
(15:47:49) mattock_: anything else we should discuss today?
(15:48:02) ordex: probably not..
(15:48:19) cron2_: python 2.7
(15:48:50) mattock_: in relation to what? our various buildsystems?
(15:48:57) cron2_: yes, buildbot upgrades
(15:49:08) mattock_: ah, that's easy
(15:49:20) cron2_: my freebsds have become un-upgradeable because we stil=
l need python 2.7 for the old build* stuff
(15:49:27) mattock_: ok
(15:49:36) mattock_: I can expedite bring of the new buildbot into produc=
tion
(15:49:46) mattock_: it is already a replacement, but just in openvpn-vag=
rant now
(15:50:00) cron2_: since that was due like 3 months ago, and expedition w=
ould be very welcome :-)
(15:50:04) cron2_: an
(15:50:07) mattock_: yeah
(15:50:17) mattock_: I did not see any compelling reason to rush
(15:50:21) mattock_: but this is a good reason
(15:50:43) mattock_: so it will be able to do everything the old one can,=
 plus build Windows things with MSVC
(15:50:48) mattock_: MSIs not yet, but it's not far
(15:51:00) mattock_: changes are needed in the MSI installer source code =
to make it work
(15:51:03) cron2_: cool
(15:51:20) mattock_: so, I will clean up the horrible git commit history =
and issue a PR in openvpn-vagrant
(15:51:28) mattock_: simultaneously I can deploy it in EC2
(15:52:11) mattock_: anything else?
(15:52:53) cron2_: not from me :-)
(15:55:49) mattock_: ok meeting concluded!
(15:56:08) d12fk: adios then
(15:57:18) ordex: byee

--------------06684ECBCF522183E6F24456--

