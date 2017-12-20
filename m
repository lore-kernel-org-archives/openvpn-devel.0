From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <c01383c9-231a-a3c7-db92-b31fee0ce681@...515...>
Message-ID: <5869c2d3-ca4c-0ca6-dd98-cea0debab2ca@...515...>
Date: Wed, 20 Dec 2017 14:33:02 +0200
MIME-Version: 1.0
In-Reply-To: <c01383c9-231a-a3c7-db92-b31fee0ce681@...515...>
Content-Type: multipart/mixed; boundary="------------66273655DB476F53FCE87CAB"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (Wed,
 20th Dec 2017)
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
--------------66273655DB476F53FCE87CAB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 20th Dec 2017
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2017-12-20>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock, ordex and syzzer participated in this meeting.

--

Discussed the suggestion by Internet Bug Bounty to sponsor OpenVPN bug
bounties:

<https://internetbugbounty.org/>

IBB tries to avoid overlap, in our case with OSTIF.org. Mattock will
contact OSTIF.org (and IBB) to see if we can find a solution that
benefits all parties.

--

Discussed putting CloudFlare on front of community.openvpn.net and
forums.openvpn.net. It was agreed we should only do it if there benefits
to it. One benefit is that CloudFlare could stop certain types of
attacks before they reach those servers. Performance might improve
somewhat, but people generally haven't had performance issues with
either server. Mattock will make some inquiries to figure out what the
benefits are. We will revisit this topic after that.

--

Discussed control channel optimization worked on by gertvandijk and
syzzer. The approach they've found has the big downside is that it needs
a wire protocol change, but they have a concept to do that gracefully.
This work is still in pre-PoC phase.

--

Discussed the FIPS patches. It was agreed that we want them in as
they're very important for some users and they are not too invasive.
Somebody just needs to review the code.

--

Discussed dazo's new OpenVPN 3-based Linux client. Dazo will release it
later this week. It depends on DBus, which is available for Linux but
also for BSD operating systems. Right now the client is just a backend
service which front-ends (e.g. GUIs) can make use of. The backend
services is a sort of "OpenVPN Interactive Service for *NIX".

The back-end service will not have feature-parity with the OpenVPN 2, as
many things (in particular server-side support) are missing. Dazo will
add a "missing features" list to the Git repository so that people can
look into implementing them in the OpenVPN 3 core library.

--

Decided to skip the meeting next week (on 27th Dec) because too many
people will be on holiday then. Agreed that the next meeting will be
arranged on 3rd January 2018.

---

Full chatlog attached.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------66273655DB476F53FCE87CAB
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2017-12-20.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2017-12-20.txt"

(12:31:43) mattock: meeting time
(12:31:58) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
7-12-20
(12:32:00) vpnHelper: Title: Topics-2017-12-20 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:32:39) mattock: who do we have here today?
(12:33:40) cron2 [gert@...1423.../community/developer/cron2] =C3=A8 entrato =
nella stanza.
(12:33:45) cron2: good morning
(12:33:46) syzzer: me, and dazo just reported in
(12:34:16) mattock: hi guys!
(12:34:36) mattock: let's start then
(12:34:39) cron2 ha scelto come argomento: Agenda at https://community.op=
envpn.net/openvpn/wiki/Topics-2017-12-20
(12:34:50) mattock: #! IBB
(12:34:52) mattock: oops
(12:34:54) mattock: #1 IBB
(12:34:56) syzzer: FYI - I have until 12, because its Christmas lunch tod=
ay at the company, and I'd like to join my colleauges there
(12:35:07) mattock: let's keep this quick
(12:35:17) cron2: syzzer: snowboarding, slacking in asia, christmas lunch=
=2E.. you have good life!
(12:35:21) cron2: (but that is good for me)
(12:35:40) mattock: anything to discuss regarding IBB? or should we just =
wait what their board members say about our OSTIF connection?
(12:36:02) mattock: or should we try to coordinate this with OSTIF, so th=
at OSTIF would focus on "other things" in OpenVPN rather than bug bountie=
s?
(12:36:10) mattock: then IBB could handle the bug bounty part
(12:36:15) syzzer: I'm all for IBB, even though it probably means more wo=
rk for us
(12:36:24) mattock: yeah, me too
(12:36:38) cron2: I find this exciting, but have no clue on "how to do IB=
B vs OSTIF" in a way that causes little friction and much benefit
(12:36:39) syzzer: did sounds like we need to formalize our process a bit=
 more though
(12:36:44) cron2: yes
(12:37:26) mattock: I can reach out to Derek at OSTIF to see if we could =
have an arrangement where both IBB and OSTIF would support us but in diff=
erent ways
(12:38:07) mattock: OSTIF has several non-bug-bounty related goals for Op=
enVPN anyways
(12:38:22) dazo: yeah, makes sense.  I have no strong opinions here eithe=
r way.  Whatever encourages people to hack on our code and fix it is appr=
eciated.
(12:38:27) cron2: +1
(12:38:43) mattock: ok, I will do that and we can move on
(12:38:55) mattock: #2: Update on control channel optimization (cron2, sy=
zzer)=20
(12:39:13) cron2: that is 3, and the other gert
(12:39:23) syzzer: (I just updated the page)
(12:39:35) mattock: oh
(12:39:54) mattock: so #2: Putting CloudFlare on front of community.openv=
pn.net and forums.openvpn.net?=20
(12:40:06) mattock: raidz asked about this - we can do it if we want
(12:40:11) mattock: opinions?
(12:40:33) syzzer: I guess it means SSL termination by cloudflare?
(12:40:37) mattock: yes it does
(12:40:45) mattock: that was one of the original reasons why we didn't do=
 it
(12:41:03) mattock: we also disabled cloudflare on trac because it was fo=
rcing useless captchas on users
(12:41:04) cron2: so why do we want to do it now?
(12:41:15) mattock: we probably don't, but I promised to ask
(12:41:22) syzzer: not my favourite, but since basically all information =
is public anyway (and I don't reuse passwords ;) ) I don't have any objec=
tions
(12:41:33) cron2: (I have no idea about the load situation, costs, etc., =
so totally naive "what is the benefit, what are the costs?")
(12:41:57) mattock: I can ask about the benefits in our case
(12:42:06) mattock: some pages would load faster I guess
(12:42:17) mattock: not sure how cloudlare handles dynamic content like p=
hpbb or trac
(12:42:29) cron2: generally speaking unless there is benefit, I'm always =
sceptical about "change for change's sake" :) - but then, I do not use fo=
rums, and community has always been "fast enough" for me.
(12:42:35) mattock: I'll make some queries and we can come back to this
(12:42:36) mattock: agreed
(12:42:55) mattock: if there is no clear benefit we can continue not havi=
ng cloudflare
(12:43:04) syzzer: mattock: sounds good, I'm fine with whatever your deci=
de here.
(12:43:10) mattock: next topic: #3 Update on control channel optimization=
 (gertvandijk, syzzer)=20
(12:43:21) syzzer: yeah, short status update
(12:43:22) dazo: one benefit is that cloudflare could stop various attack=
s before hitting our servers directly
(12:43:27) cron2: #2 -> ok
(12:43:43) dazo: (but that's the only benefit I see .... moving on now)
(12:44:01) syzzer: as recommended by plaisthos, we (mostly gertvandijk) a=
re looking into implementing LEDBAT for the control channel
(12:44:20) cron2: that is one of the TCP congestion avoidance algorithms?=

(12:44:29) syzzer: cron2: yes, a simple one
(12:44:36) syzzer: it's used by bittorrent
(12:45:07) syzzer: I think the big downside is that it needs a wire proto=
col change, but we have a concept to do that gracefully
(12:45:12) dazo: and this can happen over the same socket as now?  or do =
we need a separate connection in parallel?
(12:45:46) syzzer: dazo: same socket, but adding microsecond timestamps (=
32 bit) to the packet IDs on the control channel
(12:46:07) dazo: okay ... that's reasonable
(12:46:10) cron2: protocol changes!  That will need an RFC update!
(12:46:15) dazo: :)
(12:46:18) cron2: (just making silly noises in the background)
(12:46:29) dazo: LEDBAT in practice :-P
(12:46:29) cron2: syzzer: changing opcodes?
(12:46:35) syzzer: since this is gerts first encounter with the multi, fo=
rward and all related stuff, it takes a bit of time to get a first protot=
ype
(12:46:42) syzzer: cron2: no, no opcode changes
(12:46:52) syzzer: we're aiming at fully backwards compatible
(12:46:57) cron2: so how's the plan to change the wire format without bre=
aking things?
(12:47:25) syzzer: add a 'flags' field after the P_CONTROL_HARD_RESET pac=
ket
(12:47:40) syzzer: current implementations ignore any data in those packe=
ts
(12:47:52) cron2: sounds good
(12:47:56) dazo: interesting ... that sounds like it could work
(12:48:23) dazo: syzzer: have you mentioned this with James?
(12:48:26) syzzer: looks like it is going to work
(12:48:46) cron2: (of course then we're back to tincantech's favourite "r=
eplace a 2.5 server with a 2.4 server, and clients won't notice and it wi=
ll not work")
(12:48:51) syzzer: dazo: no - only at the hackathong, when it was not cle=
ar yet how we would do this
(12:49:14) dazo: syzzer: okay ... would be good to give him a heads up an=
d check if he sees potentials issues here
(12:49:24) syzzer: cron2: yes, that is a scenario we need to think about
(12:49:35) dazo: if anyone can predict how it can explode things, James i=
s my best bet :)
(12:49:51) syzzer: dazo: yeah, but I think we should wait a little longer=
, until we have some numbers
(12:50:00) dazo: fair enough
(12:50:40) syzzer: I would still really like it if we can come up with a =
simple algorithm that doesn't need wire proto changes, but that might be =
not realistic.)
(12:50:58) syzzer: just wanted to share where we are right now :)
(12:51:22) dazo: thx! This does indeed sound promising .... while underst=
anding that this is pre-PoC phase :)
(12:51:30) syzzer: so unless there are more questions, that's it for this=
 topic as far as I'm concerned :)
(12:51:43) mattock: ok
(12:52:01) dazo: Perhaps I could just shoot in a few words on the OpenVPN=
 3 Linux client, before patchwork?
(12:52:09) mattock: I suggest we discuss FIPS briefly: the author just wa=
nted to verify that we are interested in the FIPS patches
(12:52:16) dazo: sure
(12:53:01) mattock: so are we? :)
(12:53:21) syzzer: yeah, as long as it's not intrusive (looks like it's n=
ot) I'm fine with patches for openssl-fips-mode support
(12:53:23) mattock: the author obviously did not want to produce more pat=
ches if FIPS-compliance is not important for us
(12:53:24) dazo: Yes, FIPS is definitely interesting ... even though the =
security parameters in FIPS can be somewhat questionable at times ... it =
can help gov adaptation as FIPS won't be a blocker
(12:53:40) dazo: and in those market segments FIPS compliance is crucial
(12:53:41) mattock: ok, so it's just about "lack of time to review" at th=
is point
(12:53:45) dazo: yes
(12:53:47) mattock: ok, good
(12:54:02) mattock: that's all I need to know - let's do the OpenVPN 3 li=
nux client next
(12:54:07) syzzer: mattock: yeah, It's on my radar, but not very high pri=
o
(12:54:17) ordex: argh=20
(12:54:25) ***ordex just woke up
(12:54:31) dazo: I'm going to release a brand new OpenVPN 3 Linux client =
for the community tomorrow or Friday
(12:54:32) syzzer: haha
(12:54:34) ordex: mbedTLS sucked all my energy until late night yesterday=

(12:54:40) cron2: wrt FIPS - I think that patch is fairly easy, though
(12:54:43) syzzer: dazo: cool!
(12:54:51) cron2: questionable is only the documentation
(12:54:54) dazo: It will be a very different client than openvpn2 ... so =
you're aware of that
(12:55:11) cron2: dazo: which is a good thing :)
(12:55:16) mattock: also note that while it is called "the linux client" =
it should run fine on FreeBSD at least
(12:55:25) mattock: the amount of dependencies is not that large
(12:55:25) ***cron2 has doubts about that
(12:55:39) dazo: Right now I'm finalizing an openvpn2 front-end which tri=
es to "look like" our known openvpn 2.x ... but with only support for cli=
ent options
(12:55:41) mattock: cron2: I have my doubts also for the _initial_ versio=
n
(12:55:42) cron2: but you have vagrant boxes to test... (no systemd, no d=
bus, ...)
(12:56:10) mattock: cron2: dbus is actually available for freebsd and doe=
s not pull in gnome or anything huge as dependencies
(12:56:15) mattock: I was surprised about that actually
(12:56:21) dazo: Currently this Linux client only depends on dbus (no sys=
temd requirements) ... which is available on most BSDs
(12:56:33) cron2: having a good and fully integrated *Linux* client in 3 =
sounds useful, and all other platforms can do 2.x just fine, I'd say...
(12:56:35) dazo: (but probably not installed, unless you have some more a=
dvanced desktop environments)
(12:56:36) mattock: yeah let's not bake in hard dependencies to systemd :=
P
(12:56:56) dazo: I do try to avoid a hard systemd dependency
(12:57:16) cron2: not sure anyone actually does GUI on FreeBSD, and would=
 appreciate a nice and shiny new client :) - but I might be wrong
(12:57:35) cron2: I see FreeBSD more on the server side of things
(12:58:03) dazo: The next challenge, which will be resolved next year is =
DNS configuration .... I've barely started looking into various D-Bus ser=
vices already present (NetworkManager, systemd's networkd) ... and will t=
ry to find a path which is flexible enough to not be hardcoded against a =
specific network config tool
(12:58:49) dazo: cron2: This client does not depend on GUI at all .... GU=
I is something we need to think about in a bit
(12:59:20) dazo: the design details is that there is a backend part (logg=
ing, configuration and session management as well as the VPN tunnels itse=
lf) ... all of that is managed over D-Bus
(12:59:45) dazo: and then front-ends, which the users interact with are e=
ssentially just D-Bus clients ... and can be written in any languages, co=
nsole or GUI or whatever
(13:00:22) dazo: the backends takes care of privilege separation and all =
that ... and D-Bus policies dictates whom can do what with the backend se=
rvices
(13:00:47) syzzer: dazo: sounds like "interactive service for *nix" ?
(13:01:55) dazo: syzzer: yeah, you could say that ... but just using stan=
dard communication libraries and APIs for client implementations
(13:02:37) dazo: now .... there are some challenges ahead with configurat=
ions though .... not all openvpn 2.x options are supported
(13:02:41) dazo: no static key tunnels
(13:02:53) dazo: no server support (yet)
(13:03:28) dazo: of over 260 options (approx) in OpenVPN 2 .... only appr=
ox 60 are supported by OpenVPN 3
(13:03:45) dazo: this is not strictly this Linux client implementations f=
ault, but more the OpenVPN 3 Core library
(13:04:08) syzzer: that could actually be a feature :p
(13:04:13) dazo: hehehe :-P
(13:04:16) dazo: yeah, true :)
(13:04:20) ordex: yeah :D
(13:04:33) syzzer: 3.x sounds like good milestone to deprecate/drop stuff=

(13:04:42) dazo: some options we need to consider .... like --fragment=20
(13:05:01) cron2: fragment is important, unfortunately
(13:05:07) dazo: yeah
(13:05:39) dazo: but ... this is a good starting point, I think .... and =
at least a functional client which people can start hacking on
(13:06:58) ordex: dazo: about the missing options: we could also have som=
e kind of todo list, so that people know what's missing and may start sen=
ding contributions to implement those of higher interest for them
(13:06:59) dazo: so, that's all from me now - to avoid taking too much ti=
me ... unless there are questions :)
(13:07:18) dazo: ordex: good point!  I'll add that to the git repo
(13:07:30) dazo: (or a wiki page)
(13:07:43) ordex: after all we are not "substituting" openvpn2, therefore=
 we don't need to reach feature completeness before other people get thei=
r hands on
(13:07:45) chipitsine: (or git issue tracker)
(13:07:45) syzzer: dazo: well, maybe maintainers.  will you be maintainin=
g the project on gh or so?
(13:08:05) dazo: I'll push this out to GitLab and GitHub
(13:08:17) dazo: and I'll be the main maintainer for now
(13:08:32) syzzer: make sure to add a README that describes how you accep=
t patches
(13:08:38) dazo: +1
(13:10:33) syzzer: okay, /me out for lunch then :)
(13:10:39) dazo: enjoy!
(13:10:42) syzzer: thanks
(13:10:49) cron2: enjoy
(13:11:01) mattock: have a good one!
(13:11:14) mattock: any patches in patchwork you want to tackle today?
(13:11:20) ***cron2 <- not
(13:11:55) dazo: I have enough on my plate with the ovpn3 client release =
for this week :)
(13:12:19) ordex: I promised I'd tackle the ipv6 patch + the patchset abo=
ut buffer
(13:12:20) ***cron2 has cristmas, end-of-year "we still have budget!!!" c=
ustomers, and family
(13:12:34) mattock: I think VLAN patches will remain on the topic list fo=
r a while, and there's no need to discuss them right now
(13:12:34) cron2: oh, and tax paperwork (finished today, yay)
(13:12:35) ordex: "throw the budget here!!"
(13:12:41) cron2: +1
(13:12:56) mattock: meeting concluded then
(13:12:58) dazo: agreed, VLAN patches can stay on the list
(13:13:00) dazo: yeah
(13:13:21) mattock: what about next meeting? should we skip it?
(13:13:25) mattock: 27th
(13:13:34) mattock: I have a bunch of stuff on that day
(13:14:03) dazo: I'll be on Christmas holiday officially from Dec 23rd un=
til early January=20
(13:14:49) dazo: (I might follow up on some things if they look interesti=
ng enough during those days, but no promises)
(13:14:51) mattock: I have to consider doing something similar, as the HQ=
 also has holidays around the same time
(13:15:01) mattock: I  vote "skip next week's meeting"
(13:15:18) ***ordex shuts up because he skipped this one too
(13:15:40) dazo: Let's aim for Jan 3rd or 10th
(13:15:44) mattock: ordex: not entirely
(13:15:47) mattock: 3rd is fine for me
(13:16:20) ordex: I am not personally sure about the 3rd because I might =
be out, but we can aim for that. I'll let you know later
(13:16:30) mattock: ordex: sounds good
(13:16:36) mattock: cron2: opinions about 3rd?
(13:16:43) cron2: phone
(13:16:53) dazo: I might not work that week, but can probably sneak away =
far an hour or so
(13:28:50) mattock: I will postpone sending the summary until cron2 respo=
nds -> lunch :)
(13:28:54) L'account =C3=A8 disconnesso e non sei pi=C3=B9 in questa chat=
=2E Sarai reinserito in questa chat alla riconnessione dell'account.
(14:31:07) L'argomento di #openvpn-meeting =C3=A8: Agenda at https://comm=
unity.openvpn.net/openvpn/wiki/Topics-2017-12-20
(14:31:07) L'argomento per #openvpn-meeting =C3=A8 stato impostato da cro=
n2 a 12:34:39 su 20/12/2017
(14:31:07) ***: Buffer Playback...
(14:31:07) ordex: [11:31:08] enjoy !
(14:31:07) cron2: [11:32:48] back
(14:31:07) cron2: [11:33:21] mattock: 3rd should work.  I might be boardi=
ng :)
(14:31:07) syzzer: [12:21:07] 3rd is good for me :)
(14:31:07) ***: Playback Complete.
(14:31:28) mattock: cron2, syzzer: noted, sending summary

--------------66273655DB476F53FCE87CAB--

