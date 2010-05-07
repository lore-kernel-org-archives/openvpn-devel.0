Message-ID: <4BE41ABA.4010006@...515...>
Date: Fri, 07 May 2010 16:50:50 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070506070702060707020807"
Subject: [Openvpn-devel] OpenVPN roadmap
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
--------------070506070702060707020807
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi all,

Yesterday we discussed OpenVPN roadmap issues in the IRC. Full chatlog
of the session is attached to this email. Although no consensus on
future direction was yet reached, I and Dazo managed to put something
hopefully useful together. Note that this Wiki page is setup purely for
communication purposes, not to dictate the direction of OpenVPN:

<https://community.openvpn.net/openvpn/wiki/RoadMap>

The underlying issues affecting the design (see "Development issues")
are still unsolved. If we want to  go forward with the current 3.0
design (see  "Design and implementation"), large parts of OpenVPN will
have to be written from scratch. However, some parts of 2.1 can be
modified to work with 3.0 and some of the modules of 3.0 can be
implemented beforehand in 2.x series.

Do you think that OpenVPN 3.0 in it's planned form is worth the trouble?
Should we just focus on incrementally improving 2.x series? What
problems and possibilities do you see in current plans? Have we missed
something important? In short: any thoughts about all of this?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------070506070702060707020807
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-05-06.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-05-06.txt"

(21:00:28) reg9009: hey tehre...
(21:01:53) mattock: hi
(21:01:59) jamesyonan [~jamesyona@...1320...] =EF=BF=BD=EF=BF=BD entrato ne=
l canale.
(21:02:06) jamesyonan: hi
(21:02:10) mattock: hi james!
(21:02:17) cron2: hi mattock, james, reg9009
(21:02:39) jamesyonan: I wrote up some ideas/notes on OpenVPN 3: http://sec=
ure.openvpn.net/doc/ovpn3.txt
(21:02:54) jamesyonan: I haven't had a chance to put it on the wiki yet.
(21:03:56) mattock: jamesyonan: I can put it to the wiki
(21:04:05) jamesyonan: great
(21:04:21) reg9009: from a first look it sounds good...
(21:04:23) mattock: our Trac got spammed a little by a chinese spambot earl=
ier, so I firewalled pwm until Trac has a few spam prevention plugins
(21:04:38) mattock: "a little" meaning it's fixed and only main page was to=
uched
(21:07:58) mattock: jamesyonan: looks good
(21:08:59) mattock: do you have any idea if other people would be intereste=
d in this "userspace network stack"? I mean for non-VPN functionality...
(21:09:22) cron2: there's some attempts to do so in the "routing" space (cl=
ick)
(21:09:24) mattock: because if they were, our community could become much b=
igger
(21:09:43) cron2: but I have never heard anybody outside the research commu=
nity use that...
(21:10:05) jamesyonan: a lot of applications use user-space network stacks =
-- for example all the VM-containers like VMWare, Xen, etc.
(21:10:35) cron2: there are dangers to "make everything modular and super-f=
lexible" - if not done carefully, it goes hand in hand with "super-complica=
ted and too difficult to use for the normal user"
(21:11:08) jamesyonan: the modularity is mostly visible to the developer
(21:11:14) cron2: Linux users might remember u-isdn (super-flexible) vs. is=
dn4linux (fairly limited, but did all the necessary things) - and i4l won...
(21:11:52) jamesyonan: network stacks are fairly well understand -- all the=
 OSes have them
(21:12:12) reg9009: it may help to "separate" functionality, depending on t=
he OS OpenVPN runs.
(21:12:18) jamesyonan: I don't think the network stack would need the full =
functionality of a "real" kernel-level stack
(21:12:21) cron2: if the end user does not have to know how to plug "networ=
k module", "SSL module" and "UDP module" together to make OpenVPN work, I w=
on't have worries
(21:12:36) reg9009: Basic functionality every OS shares, and "special" addi=
tions which only run on certain OSes
(21:13:10) mattock: jamesyonan: so how big part of a "normal" OS network st=
ack would we implement?
(21:13:23) mattock: for _our_ purposes (VPN) I mean
(21:15:31) jamesyonan: I'm thinking we should build the user-space network =
stack abstraction with minimal functionality initially -- just enough to do=
 the major protocols (IPv4, IPv6), the major connectors (tun/tap), the majo=
r routing agents (IP routing), and enough flexibility to do cloud-based ful=
l-mesh routing.
(21:15:52) fabiank [~fabian.kn@...1366...] =EF=BF=BD=EF=BF=BD entrato nel c=
anale.
(21:16:09) reg9009: This is a good topic, jamesyonan.
(21:16:16) fabiank: Hi everyone
(21:16:36) reg9009: Talking about full-mesh routing
(21:16:38) reg9009: Hi
(21:17:06) mattock: hi fabiank
(21:17:18) reg9009: I've found a developer which is actually looking at thi=
s..
(21:17:49) reg9009: The plan is to listen for route changes via net socket
(21:18:32) cron2: reg9009: what you could do (what a colleague of mine does=
) is to use tap mode and then run quagga (or the routing daemon of choice) =
on the tap interfaces
(21:18:40) cron2: that way, openvpn doesn't need to see the routing changes
(21:18:42) reg9009: if route is changed and gateway is one of the OpenVPN c=
lients, add network behind to OpenVPNs iroute table
(21:18:54) mattock: ok, roadmap ideas in the wiki: https://community.openvp=
n.net/openvpn/wiki/RoadMap
(21:18:56) vpnHelper: Title: RoadMap =EF=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN (a=
t community.openvpn.net)
(21:20:00) reg9009: cron2: As I understood, tap interface is layer2
(21:20:25) reg9009: We need layer3 only interface...
(21:20:33) cron2: reg9009: yes, so you do not need iroutes in OpenVPN.  You=
 just set up a "transfer network" and route transparently across it.  Just =
as if you had an ethernet connecting the boxes
(21:21:12) cron2: the main drawback of tap is that you have the extra overh=
ead of ethernet headers and ARPing
(21:21:14) jamesyonan: I'd also like to see OpenVPN handle IP multicast bet=
ter, and the user-space network stack concept lends itself well to that
(21:21:16) ribasushi: auto-meshing openvpn would be bloody awesome
(21:22:10) reg9009: it doesn't look to hard to implement.
(21:22:15) janjust [~janjust@...1367...] =EF=BF=BD=EF=BF=BD entrato nel can=
ale.
(21:22:16) mattock: so we could use external software to replace some of th=
e functionality, right?
(21:22:21) cron2: reg9009: but I'd actually like to see a similar thing - "=
route" commands in ccd/ (so that a route is only pulled towards OpenVPN if =
the client in question connects)
(21:22:26) janjust: evening all , sorry for being late
(21:22:32) cron2: hi jjk
(21:22:33) mattock: hi janjust!
(21:22:41) reg9009: mattock: yes and no
(21:23:06) fabiank: Hi janjust :)
(21:23:19) janjust: route commands inside ccd files? how do you want to avo=
id deadlocks then?
(21:23:19) reg9009: enable third party software (like quagga or others) to =
(at least partly) manipulate OpenVPN
(21:23:31) cron2: janjust: where's the deadlock?
(21:23:56) janjust: well you need to make absolutely sure that no 2 ccd fil=
es have the same route+iroute combination
(21:24:34) cron2: janjust: well, when adding the second one, you'd get an e=
rror message, of course.
(21:24:40) janjust: it's not really a deadlock I guess, more of a "how do y=
ou know where subnet X is going to?"
(21:24:59) reg9009: or add functionality, like new chryptographic mechanism=
, etc.
(21:25:06) cron2: janjust: well, this is actually more of an ccd/iroute pro=
blem, and you can have iroute-in-ccd/ today :-)
(21:25:17) janjust: that is true cron2
(21:25:26) janjust: what *are* the plans for 3.0 :)
(21:25:31) mattock: https://community.openvpn.net/openvpn/wiki/RoadMap
(21:25:37) vpnHelper: Title: RoadMap =EF=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN (a=
t community.openvpn.net)
(21:25:40) cron2: janjust: the usual rules apply: more-specific prefix wins=
 - and if you have two prefixes of same size, you need to define a tie-brea=
ker
(21:26:14) reg9009: a good example of plugin possibilities is dovecot...
(21:26:30) reg9009: core functionality in dovecot, but easily extendable
(21:26:44) janjust: oooh I like the roadmap - lots of ideas that I would li=
ke to see implemented
(21:26:54) janjust: esp the separating of the core and the userspace app
(21:27:20) cron2: I like many of the ideas, but I'm worried that we won't s=
ee IPv6 or multiple-listen-socket before 3.0 then...
(21:27:40) janjust: is ipv6 (tun-ipv6) still broken?=20
(21:27:41) reg9009: B.t.w., no one really does dynamic routing over VPN, ye=
t.
(21:27:49) mattock: oh, dovecot is from Finland (originally)
(21:28:09) reg9009: Only sepacial (and expensive) solutions which are tied =
to same vendors on the two ends...
(21:28:10) cron2: janjust: there's a feature branch in dazo's "testing" tre=
e which works-for-me
(21:28:24) cron2: (feat_payload_ipv6, IIRC)
(21:28:49) janjust: ok thx cron2, I really need to start playing with the g=
it trees
(21:28:54) janjust: as soon as I finish my book :)
(21:28:55) cron2: reg9009: you can use dynamic routing over L2TP setups
(21:29:28) cron2: janjust: it's also in "allmerged", so if you have that, y=
ou have the most important bits for IPv6 payload and IPv6 transport
(21:30:08) cron2: reg9009: but yes, having this in OpenVPN sounds useful
(21:30:39) reg9009: people are going away from L2TP (at least companies I k=
now of).
(21:31:08) janjust: ipsec+l2tp is here to stay for quite some time
(21:31:16) janjust: until ipv6 becomes more mainstream
(21:31:21) reg9009: :)
(21:31:41) cron2: l2tp without IPSEC is the fundation for most DSL provider=
 setups (on the inside) :-) - *and* you can do IPv6 with L2TP just fine...
(21:31:59) janjust: yep cron2 but most windows users currently still need L=
2TP
(21:32:25) janjust: don't know about smartphones , but AFAIK they also rely=
 on either PPTP or L2TP
(21:32:28) cron2: yes, in the windows world, ipsec+l2tp or pptp is what you=
 have
(21:32:40) reg9009: and OpenVPN ;)
(21:33:06) janjust: not on non-jailbroken iphones, reg9009=20
(21:33:19) janjust: that is why the core/userspace separation is so interes=
ting
(21:33:39) janjust: if one can replace the part that talks to a network int=
erface with something else then openvpn becomes much more portable
(21:33:51) mattock: jamesyonan: any ideas how much work is involved in reac=
hing 3.0 as it is?
(21:34:43) mattock: I'm a little worried that 3.0 has to be very sexy and/o=
r reachable by small increments to attract enough developers=20
(21:34:57) jamesyonan: maybe 4 to 6 months of work to reach an alpha
(21:34:58) reg9009: cron2: from a dialin perspective, yes. But others tend =
to use MPLS, more flexible, etc.
(21:35:25) cron2: reg9009: MPLS in the core, L2TP to transport individual D=
SL sessions
(21:35:37) mattock: we'd need to get it to point where it's useful a.s.a.p.
(21:35:41) reg9009: cron2: yep.
(21:36:09) jamesyonan: the nice thing about the user-space stack model is t=
hat once the fundamental objects of the stack are defined, multiple develop=
ers can then set to work on the various modules
(21:36:33) mattock: jamesyonan: good point
(21:36:42) reg9009: What about dividing the development in some smaller ste=
ps.
(21:37:03) reg9009: OpenVPN 2.5, 3.0, e.g.
(21:37:19) mattock: reg9009: we've discussed that earlier and it's our goal=
... however, some things need to be written from scratch
(21:37:48) reg9009: ok.
(21:39:09) mattock: ok, so do we agree that 3.0 (as planned) is what we sho=
uld try to achieve?
(21:39:27) cron2: well, "we" is an interesting group
(21:39:38) cron2: for me, I am a bit more interested in short-term goals
(21:40:00) cron2: but I don't see anything wrong with having this as "long-=
term goal"
(21:40:17) mattock: yes, I meant long-term
(21:40:30) krzee: 4 - 6 months for an alpha, to be honest, is a lot less ti=
me than i expected
(21:40:42) mattock: krzee: me too
(21:41:11) cron2: it's a matter of focussing energies: shall we focus on "i=
n 4-6 months, there is an alpha of 3.0" or focus on "get the features from =
dazo's tree integrated in OpenVPN 2.5?"
(21:41:18) janjust: what would this alpha entail? openvpn running as 2 sepa=
rate processes, one for the user space part and one for the kernel-space pa=
rt (i.e. access to the tun/tap driver) ?
(21:41:32) reg9009: If we could achieve this, I could imagine more develope=
rs are attracted (e.g. iPhone VPN alternatives).
(21:41:42) krzee: would 3.0 be threaded?
(21:41:52) cron2: it's on the roadmap
(21:41:58) jamesyonan: realistically, I think that 2.x and 3.0 development =
would need to happen in parallel
(21:42:12) mattock: cron2: I think we should plan 3.0 and then focus on rea=
ching our short-term goals with 3.0 goals in mind
(21:42:16) janjust: jamesyonan, I agree
(21:42:26) krzee: jamesyonan, +1
(21:42:29) cron2: jamesyonan: +1
(21:42:30) mattock: +1
(21:43:02) janjust: there are far too many useful patches in the 2.x tree r=
ight now
(21:43:15) mattock: should we review the current codebase to see where we c=
ould move towards 3.0 incrementally and where not?
(21:43:29) mattock: to get a better idea of amount of work involved
(21:43:31) cron2: janjust: this is why I was worrying about efforts
(21:43:43) reg9009: +1
(21:47:18) fabiank: My fear is that OpenVPN 3.0 might end up being a great =
basic (rewritten) framework, without enough functionality to encourage "dri=
ve-by" developers that actively use it for their projects.  )(I've seen thi=
s happen to a bunch of opensource projects before.)
(21:48:07) cron2: fabiank: well, this is where OpenVPN-the-company needs to=
 push until int's interesting enough for "you and me"
(21:48:09) fabiank: So too much parallel development might hurt 3.0's succe=
ss
(21:48:40) fabiank: cron2: OK, true.  A company involved is something new. =
:)
(21:48:55) fabiank: (regarding my past experiences)
(21:49:09) cron2: mattock: how exactly is the company called?  I need to le=
arn how to name it right
(21:49:17) mattock: cron2: agreed, most developers just want to scratch an =
itch, so they need something that's usable
(21:49:24) cron2: +1
(21:49:30) mattock: cron2: I guess it's "OpenVPN Technologies, Inc"
(21:49:38) janjust: mattock: lol
(21:49:40) cron2: *note*
(21:50:01) cron2: mattock: yes, that's how I ended up here - "we use OpenVP=
N, it works, but it's lacking <x>"
(21:50:02) mattock: yep, I'm not sure if there's a dot after it (Inc.)
(21:51:03) jamesyonan: I see OpenVPN 3.0 as evolving in parallel with 2.x, =
with most of the migration only occurring when it becomes a drop-in replace=
ment for 2.x.=20=20
(21:51:47) mattock: jamesyonan: how much effort can the company put behind =
3.0? and when?
(21:52:21) krzee: jamesyonan, when i release my config generator (let me kn=
ow if you dont know what im talking about) can i give the copyright on it t=
o OpenVPN technologies?  (i dont use my real name and cant copyright as 'kr=
zee')
(21:52:27) jamesyonan: realistically, probably not very much this year
(21:53:30) mattock: krzee: could you just release it to public domain?
(21:54:29) krzee: sure, im very much good with that too
(21:54:34) mattock: :)
(21:55:12) reg9009: should we do a poll for "important" functionality which=
 should go into 2.x, and all other for 3.x?
(21:56:27) jamesyonan: agreed, public domain would be fine for contribution=
s that don't directly touch the openvpn source code
(21:56:50) mattock: reg9009: you mean the other way around?
(21:57:50) reg9009: it depends where the preference is set.
(21:58:52) mattock: reg9009: I think something like Debian's "popularity co=
ntest" would be nice to see what people are really using
(21:59:20) mattock: it would also give us pointers where to head first in 3=
.0
(21:59:34) reg9009: Is 2.x seen as "maintenance" release with no or little =
new functionality?
(22:00:10) mattock: reg9009: I think there's a lot of stuff in the pipe for=
 2.x
(22:00:38) mattock: all of the stuff that was previously hosted separately =
plus much more
(22:00:44) reg9009: Ok. I wasn't clear what 3.x means in terms of functiona=
lity and rewriting...
(22:01:16) reg9009: So 2.x will inherit new functionality, but structure is=
 kept as is.
(22:01:18) cron2: mattock: where would we ask? -users + -developers list?
(22:01:43) rob0 [~rob0@...1323...] =EF=BF=BD=EF=BF=BD entrato nel canale.
(22:01:45) mattock: cron2: that's at least a good start... something automa=
ted (opt-in) in OpenVPN itself would be better, though
(22:01:52) reg9009: And 3.x will be something inlcuding rewriting of base a=
nd/or architecture...?
(22:01:59) mattock: reg9009: that's correct
(22:02:20) reg9009: got it, thx.
(22:02:30) reg9009: I would start in -users.
(22:02:41) mattock: I think the main issue is: do we want to go all the way=
 towards a general purpose network stack... or just modularize + cleanup op=
envpn better while keeping focus on VPN=20
(22:03:12) janjust: mattock: I'd be in favour of the second
(22:03:13) cron2: mattock: yes!
(22:03:24) reg9009: me, too, 2nd.
(22:03:47) cron2: I think one can do the second on the road to the first, s=
o "2nd"
(22:04:01) jamesyonan: I would certainly agree -- I don't think we should h=
old up development on 2.x just because of 3.0
(22:04:07) janjust: or perhaps I misread "general purpose network stack" :)=
=20
(22:04:38) mattock: cron2: agreed, the options are not really mutually excl=
usive...
(22:04:53) janjust: cron2 +1
(22:05:27) rob0: Sorry I missed the meeting, was curious/interested if full=
 mesh was under consideration for 3.0?
(22:06:09) reg9009: even for 2.x ;)
(22:06:18) krzee: thats already doable with RIP
(22:06:29) krzee: [12:09]  <vpnHelper> krzee: "rip" is http://www.secure-co=
mputing.net/wiki/index.php/OpenVPN/RIPRouting for a writeup on using RIP in=
 openvpn
(22:06:30) vpnHelper: Title: OpenVPN/RIPRouting - Secure Computing Wiki (at=
 www.secure-computing.net)
(22:07:14) reg9009: but RIP isn't suitable for bigger setups...
(22:07:44) mattock: so could we proceed something like this: review the sor=
e points in current codebase -> modularize / modernize everything we can in=
crementally -> rewrite the rest...
(22:07:53) mattock: the result being 3.0
(22:07:55) cron2: krzee: your IPv6 is broken
(22:08:05) krzee: thats ecrist's
(22:08:17) cron2: mmmh, he's not here
(22:08:38) reg9009: matoock: that's a good way of doing it
(22:08:39) cron2: mattock: sounds like a plan
(22:09:47) mattock: I think we need more information to make good choices r=
egarding 2.x and 3.0
(22:10:52) reg9009: Maybe a good side-effect of asking -users list is that =
more people get noticed about new development and *maybe* more developers g=
et attracted? :)
(22:11:15) mattock: jamesyonan: could you work on some of the sore points y=
ourself? for example, work on the event system and such.
(22:12:01) jamesyonan: I would like to work on it -- but I'm quite swamped =
with other stuff right now
(22:13:34) mattock: I'm just worried (perhaps unnecessarily) that usually c=
ommunity developers are interested in specific issues (e.g. ipv6 support) r=
ather than planned development tasks (e.g. rewrite event system)=20
(22:13:39) mattock: I may be wrong, though
(22:14:07) mattock: having somebody lead the way / bootstrap the developmen=
t would help a lot
(22:14:41) janjust: I tend to agree, mattock : community developers normall=
y don't think about the "global" stuff but just the part that is interestin=
g to them
(22:14:52) cron2: ack
(22:15:11) krzee: rst
(22:15:13) krzee: heheh
(22:16:59) fabiank: A Google Sommer of Code student would be nice. :)
(22:17:45) mattock: regarding community developers... we could probably get=
 a lot more of them by linking from openvpn.net to community.openvpn.net
(22:17:55) mattock: =3Dgetting visibility for our new development model
(22:18:06) krzee: +1
(22:18:10) mattock: that'd DDOS trac, of course :)
(22:18:52) mattock: actually, two concurrent users using "Browse source" wo=
uld DDOS it, so...
(22:19:42) mattock: git-plugin -> gitweb + gitweb integration in Trac might=
 do the trick
(22:20:29) reg9009: +1
(22:21:58) mattock: shall we review 2.x next? then focus on fixing the issu=
es that annoy people most (as well as move us towards 3.0)
(22:22:21) krzee: [12:22]  <mattock> actually, two concurrent users using "=
Browse source" would DDOS it, so...
(22:22:24) krzee: thats a serious problem
(22:22:34) mattock: krzee: agreed, git-plugin has to go
(22:22:41) mattock: at least the browse source stuff
(22:24:16) dazo_afk ha abbandonato il canale (quit: Read error: Connection =
reset by peer).
(22:24:39) mattock: robo, mesh is on the list (https://community.openvpn.ne=
t/openvpn/wiki/RoadMap)
(22:24:42) vpnHelper: Title: RoadMap =EF=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN (a=
t community.openvpn.net)
(22:25:33) ***janjust signing off
(22:25:41) krzee: later jan
(22:25:45) janjust: later all
(22:25:52) mattock: janjust: bye!
(22:25:52) cron2: bye
(22:25:55) janjust ha abbandonato il canale (quit: Quit: Leaving).
(22:26:05) dazol [~dazo@...1368.../redhat/x-ptfackcljdhimteg] =EF=BF=BD=EF=
=BF=BD entrato nel canale.
(22:26:56) mattock: dazo to the rescue? :)
(22:29:27) jamesyonan ha abbandonato il canale (quit: Quit: jamesyonan).
(22:29:36) krzee: awww james left :(
(22:29:38) mattock: hmm... seems this is more difficult issue than an avera=
ge patch ;)
(22:30:18) janjust [~janjust@...1367...] =EF=BF=BD=EF=BF=BD entrato nel can=
ale.
(22:30:54) janjust ha abbandonato il canale (quit: Client Quit).
(22:32:25) mattock: did we reach an agreement on something? about review of=
 the current codebase, perhaps?
(22:32:40) krzee: we agreed it should be done
(22:32:59) krzee: not who or how, but that its a good idea ;]
(22:33:23) krzee: and that 2.x and 3.x should be worked on in parallel
(22:33:43) mattock: if the company can't bootstrap 3.0 development, I don't=
 think we can expect the (current) community to do that
(22:34:10) krzee: didnt james say an alpha should take 4-6mo?
(22:34:14) mattock: yep, he did
(22:34:30) krzee: sounded to me like he was gunna work on that, maybe i mis=
understood tho
(22:34:37) rob0: mattock, thanks. I have some thoughts on how that might wo=
rk, which I suppose I will write up for the -devel list.
(22:34:47) mattock: rob0: that's a good idea
(22:35:01) mattock: I think we get better results on the concrete issues on=
 the mailing list
(22:35:11) rob0: ("that"=3D=3D"full mesh")
(22:35:18) mattock: oh ye
(22:35:20) mattock: yes
(22:35:31) ecrist: my IPv6 is broken?
(22:35:33) ecrist: probably
(22:35:49) mattock: krzee: I asked James how much effort the company could =
put into 3.0 devel and he said "realistically not much this year"
(22:35:58) krzee: oh ok
(22:36:17) mattock: so focusing on 2.x is probably best we can do
(22:36:58) krzee: mattock, mind if i bring up a new subject? (from wishlist)
(22:37:19) mattock: krzee: please do
(22:37:23) krzee: http://www.ovpnforum.com/viewtopic.php?f=3D10&t=3D141
(22:37:25) vpnHelper: Title: OpenVPN Forum View topic - Idea for direct con=
nections (at www.ovpnforum.com)
(22:37:50) krzee: i think some of rob0's mesh code would be usable in that
(22:38:08) krzee: i think they'ld go somewhat hand-in-hand... maybe im mist=
aken since im not a coder
(22:38:28) krzee: ok its not "code" yet, but his idea ;]
(22:38:53) rob0: It sounds similar to what I was thinking, yes
(22:39:10) rob0: and we'll have to call it your idea, since that was in '09=
 :)
(22:39:11) cron2: nice idea.  use the central server for authentication and=
 then "auto-mesh" clients
(22:39:30) ecrist: would save a lot on bandwidth for the server.
(22:39:48) krzee: yes, potentially a LOT
(22:40:03) krzee: it would enable openvpn to be used in situations where it=
 currently cant
(22:40:51) mattock: as James is (really) gone I think we continue the "Road=
map" discussion on the -devel mailing list
(22:41:47) cron2: +1
(22:41:56) krzee: +1
(22:42:50) mattock: I hope James participates in that discussion
(22:43:34) mattock: also, we could start migrating the wishlist items to Tr=
ac and start building our short-term roadmap with some of those in it
(22:43:40) mattock: those tasks, I mean
(22:44:02) cron2: +1 :)
(22:44:17) krzee: and heres an easy one
(22:44:51) krzee: http://www.ovpnforum.com/viewtopic.php?f=3D10&t=3D141
(22:44:52) vpnHelper: Title: OpenVPN Forum View topic - Idea for direct con=
nections (at www.ovpnforum.com)
(22:44:56) krzee: erm
(22:45:00) krzee: wrong link, 1sec
(22:45:40) krzee: http://www.ovpnforum.com/viewtopic.php?f=3D10&t=3D383
(22:45:42) vpnHelper: Title: OpenVPN Forum View topic - bind to multiple po=
rts (at www.ovpnforum.com)
(22:46:05) cron2: ohyes.  want to have that!
(22:46:48) mattock: ok, so this is the kind of stuff people want :)
(22:46:49) cron2: just got a colleague at work asking for this last monday
(22:47:19) cron2: this is actually in James' "event handling" block (multip=
le listener ports), so I'm a bit worried that this might be more difficult =
than I thought
(22:47:35) reg9009: I have to leave...
(22:47:40) mattock: reg9009: bye!
(22:47:45) ***cron2 waves
(22:47:51) krzee: adios reg9009=20
(22:47:55) reg9009: Was a pleasure to listen and contribute. Looking forwar=
d into the future...
(22:48:08) mattock: reg9009: good you could attend!
(22:48:14) reg9009 ha abbandonato il canale.
(22:48:31) krzee: cron2, well worst case, it could break the subnet in half=
 and run 2 instances of openvpn
(22:48:42) krzee: as a hack for the time being
(22:48:59) krzee: (which people now do manually)
(22:49:54) cron2: krzee: yes, we could, but this would actually be a bit co=
mplicated in our corporate setup - and for other setups, it won't be more c=
omplicated (mobile clients that could connect on either port but need to ha=
ve the same address)
(22:50:21) cron2: s/won't/will even/
(22:50:26) ***cron2 <- tired
(22:50:47) mattock: cron2: we should probably end the meeting... I have the=
 same issue :)
(22:50:58) cron2: ccd/, iroute, ifconfig-push and "two processes" don't mat=
ch well
(22:51:06) krzee: cron2, very true
(22:51:36) cron2: also I can't really see why this should be so complicated=
.  if you have TCP clients, you have multiple sockets to tend anyway - so i=
f it's 1 listen socket or 2, why should this be so bad...
(22:51:49) cron2: (but I'm afraid that the socket listing code is not for t=
he faint of heart)
(22:52:35) mattock: end of meeting? please? :)
(22:52:46) cron2: well, consider me interested in reviewing + testing this =
:-) - no time for actually hacking myself this month
(22:53:04) cron2: mattock: ok from my side
(22:53:06) mattock: more roadmap discussion starting tomorrow on the mailin=
glist
(22:53:16) cron2: good night, everbody
(22:53:20) mattock: bye cron2!
(22:53:25) krzee: goodnight!
(22:53:39) krzee: good timing, i get off work in minutes
(22:53:53) krzee: and with 3 hrs of sleep last night, im more than ready to=
 leave
(22:54:46) mattock: I'll send the "Roadmap" mail tomorrow morning (~12 hour=
s) - let's see where it leads
(22:54:56) mattock: bye!
(22:55:50) mattock: I'll also try to outline the different viewpoints/pros/=
cons in the Trac Wiki

--------------070506070702060707020807--

