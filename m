Message-ID: <4C0CE52E.3040108@...515...>
Date: Mon, 07 Jun 2010 15:25:18 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090408030804070001020100"
Subject: [Openvpn-devel] Summary of the IRC meeting (3rd Jun 2010)
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
--------------090408030804070001020100
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 3rd Jun 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-06-03>

Next meeting next week, same place, same time. Your local meeting time
is easy to check from services such as

<http://www.timeanddate.com/worldclock>

or with

$ date -u

Full chatlogs for all IRC channel discussion are available here:

<http://www.secure-computing.net/logs/openvpn-devel.txt>


SUMMARY

Discussed the "Openvpn-devel openvpn-2.1.0-r1: easy-rsa tools creates
broken client CERTs unusable for TLS" issue:

<http://thread.gmane.org/gmane.network.openvpn.devel/3703>

Agreed that we don't understand the issue fully and need to ask the bug
author for more information. NOTE: this portion of the chatlog got lost
in space and time.

Discussed "Dynamic iroute behaviour":

<http://thread.gmane.org/gmane.network.openvpn.devel/3691>
<http://thread.gmane.org/gmane.network.openvpn.devel/3722>

There is a Linux-only patch already available. Agreed that this feature
makes sense, but wider (*BSD) support is needed eventually. Also agreed
that the current code should be placed into a separate feature branch as
soon as possible, with configurable runtime option.

Discussed the possibility of having state/instance synchronization
between OpenVPN instances. This would enable transparent failover
configuration, similar to what OpenBSD has with IPSec. Reached the
conclusion that there's nothing stopping us from implementing this
(securely). However, more research is needed to determine whether 2.x
series is up for the job, or if we should implement this for OpenVPN
3.0. Reg9009 volunteered to do some research.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



--------------090408030804070001020100
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-06-03.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-06-03.txt"

NOTE: first 10 minutes lost in space and time... during this time we discus=
sed this issue:

"Openvpn-devel openvpn-2.1.0-r1: easy-rsa tools creates broken client CERTs=
 unusable for TLS"

---

20:26 <@mattock> so next would be "Dynamic iroute behaviour"
20:26 <@cron2> +1
20:26 <@mattock> http://thread.gmane.org/gmane.network.openvpn.devel/3691
20:26 < vpnHelper> Title: Gmane Loom (at thread.gmane.org)
20:26 <@mattock> http://thread.gmane.org/gmane.network.openvpn.devel/3722
20:26 < vpnHelper> Title: Gmane Loom (at thread.gmane.org)
20:27 <@mattock> quoting dazo: "Do we want this feature and if yes, should =
it also be a configurable runtime option and not just compile time config o=
ption?"
20:29 <@mattock> I can't comment on this, dynamic routing is not one of my =
strong points  :)=20
20:29 <@cron2> it's a fairly special-case use, and it could be solved in ot=
her ways (using TAP)
20:29 <@cron2> but then, we have other special-case code...
20:30  * cron2 is somewhat neutral on this
20:30 <@mattock> the alpha patch seem to add quite a lot of stuff, but not =
change much of the existing code
20:31 <@cron2> (*if* we have it, it should be a run-time option)
20:31 < jamesyonan> interesting patch -- so the basic idea is to have the i=
nternal iroute table mirror the kernel routing table
20:31 <@cron2> jamesyonan: yes
20:32 <@mattock> so did I understand correctly that this patch does not aff=
ect the rest of the codebase?
20:32 <@mattock> meaning it's not very invasive...
20:33 < jamesyonan> what are the performance implications?  How often are t=
he routes synched to the iroute table?=20=20
20:33 <@cron2> haven't looked at the code in detail yet
20:34 < krzee> how can it just mirror the routing table when it needs to po=
int to clients and the routing table knows nothing bout clients
20:35 <@cron2> krzee: dynamic routing would setup routes to the client-tun-=
IP
20:35 <@cron2> krzee: they use this in mesh networks where openvpn-client a=
nd openvpn-server speak some sort of routing protocol
20:36 -!- reg9009 [~chatzilla@...1370...] has joined #openvpn-devel
20:36 < reg9009> hi guys
20:36 < krzee> ahh, route to the client ip instead of just the tun device
20:36 < krzee> pretty slick
20:36 < reg9009> sorry, I'm a bit late...
20:36 <@mattock> reg9009: hi! we were just discussing this one: http://thre=
ad.gmane.org/gmane.network.openvpn.devel/3722
20:36 < vpnHelper> Title: Gmane Loom (at thread.gmane.org)
20:36 <@mattock> originating from you, I assume
20:36 < jamesyonan> "We filter for zebra routing messages" -- does this mea=
n that the code is dependent on zebra/Quagga?
20:36 < reg9009>  :)=20
20:37 < reg9009> jamesyonan: not really. We filter out routing messages fro=
m kernel
20:37 <@mattock> btw. rest of the topics are here: https://community.openvp=
n.net/openvpn/wiki/Topics-2010-06-03
20:37 < vpnHelper> Title: Topics-2010-06-03 - OpenVPN (at community.openvpn=
.net)
20:37 < reg9009> If you take out the filter, you get any routes which are s=
et via kernel
20:37 < reg9009> (basically, an if clause)
20:38 < chantra> i find this feature nice... allows to do OSPF/BGP over ope=
nvpn AFAIU
20:38 < krzee> without needing a ton of ptp setups
20:38 < reg9009> chantra: exactly, that was our purpose.=20
20:38 < chantra> client-server speak routing protocols, this updates kernel=
 table. If the ip of gw is a client, opevpn will route to client
20:38 < chantra> as it got aware of the new route
20:39  * chantra never used iroutes though :p
20:39 < reg9009> our problem was that every time a new network is setup som=
ewhere on the network, we would have to modify ccd file iroute entry and re=
start=20
                 clients
20:39 < reg9009> you need it to route networks which are behind clients tha=
t dial into openvpn serve
20:40 < jamesyonan> I think it's a good idea -- of course, we will need it =
thoroughly
20:40 <@mattock> ok, so chantra and james gave thumbs up and cron2 was neut=
ral  :)=20
20:40 < chantra> and openvpn needs that so it passes packet to client, othe=
rwise it wont pass a packet that does not go to a p2p to another client, ri=
ght
20:40 < reg9009> the code depends on linux, as we don't have bsd kernel exp=
ertise on hand...
20:41 <@mattock> and I guess reg9009 gives thumbs up, too
20:41 < reg9009> chantra: correct.
20:41 < ecrist> cron2: you're gert, right?
20:41 <@mattock> reg9009: BSD support would have to be added
20:41 <@cron2> ecrist: yes
20:41 <@mattock> ...by someone
20:41 < reg9009> wasn't there a guy drinking beer sometimes with BSD core d=
evelopers?
20:41 < ecrist> that's me
20:42 < jamesyonan> correction: of course, we will need to test it thorough=
ly
20:42 < reg9009> maybe you can get someone to look at it.
20:42 <@mattock> dazo can put it to it's own feature branch so that people =
can test it more easily
20:42 < reg9009> Only thing that has to be adjusted is to open a kernel soc=
ket and listen for routing messages...
20:42 < chantra> reg9009: i guess this would normally be achieve with ipsec=
, but maybe openvpn would allow client with dinamic ips to do the job with =
less=20
                 hassle
20:42 < reg9009> don't know how to do it in BSD
20:43 < ecrist> if you guys develop it, I'll put it in, as an option, to th=
e freebsd port...
20:43  * ecrist doesn't know what he's looking at, though
20:43 < reg9009> chantra: yep. Also, IPSec is very strict with networks. Yo=
u cannot pass any networks you don't define in your connection.
20:43 < krzee> ecrist, hes saying maybe you know a dev who could port a ver=
y specific part to BSD
20:43 < krzee> [11:46]  <reg9009> Only thing that has to be adjusted is to =
open a kernel socket and listen for routing messages...
20:43 < reg9009> Only with some tunnel/GRE setup, which makes it a lot more=
 complicated
20:44 < krzee> needs a BSD dev to do that part for BSD, he has it working i=
n linux
20:44 < ecrist> reg9009: if you email me what you're looking for, specifica=
lly, I'll talk to some people.
20:44 <@mattock> how about OpenBSD et al?
20:44 < reg9009> ecrist: cool, I'll do...
20:44 < reg9009> well, *BSD
20:45 < ecrist> most of the BSD's share code
20:45 < reg9009> I would imagine that socket communication on *BSD should b=
e quite unified?
20:45 < ecrist> FreeBSD is where most of the network core code comes from f=
or the other two BSDs
20:45 < krzee> i thought network core code came from netbsd primarily...
20:45 < chantra> reg9009: actually, that could be interesting to interconne=
ct remote office that use DSL  :)  Will try to push that to use within the =
company=20
                 I work for  :)=20
20:45 < reg9009> we're preparing a nicer patch with the suggestions from Da=
vid. Should be ready by weekend...
20:46 <@cron2> chantra: well, those usually have well-known internal networ=
ks, no dynamic routing involved - so static ccd/iroute are sufficient
20:47 < reg9009> e.g., we have sites cross connected to ther sites via mult=
iple different routing possibilities (mesh network).
20:47 < reg9009> Some sites are behind a 2nd hop, and that's the problem. N=
etwork gets announced, but not routed.
20:47 < janjust> chantra: I'd actually use a site-to-site static key VPN fo=
r that=20
20:49 < janjust> I like the idea of dynamic irouting but am wondering how w=
ell it fits with one of my other idea: a VPN without assigning IPs to the=20
                 endpoints
20:49 <@mattock> ok, so this feature should be included, but it needs rewor=
king + BSD support... and thorough testing, of course
20:49 <@mattock> agreed?
20:49 < reg9009> ok
20:50 < krzee> +1
20:50 < krzee> (for the feature)
20:50 < reg9009> janjust: isn't this L2 (tap style) VPN?
20:50 <@mattock> I think this could go to a separate feature branch soon, e=
ven without *BSD support... what do you think?=20=20
20:51 <@cron2> mattock: +1, and configurable at run-time
20:51 <@mattock> cron2: exactly
20:51 <@cron2> +1
20:51 < janjust> even in L2 VPNs you still have IPs assigned to the clients
20:51 <@cron2> (for the feature branch)
20:51 < janjust> mattock: +1
20:51 <@cron2> janjust: yes, but you can route across openvpn, without open=
vpn noticing
20:51 <@cron2> (because openvpn just cares for mac addresses)
20:51 < chantra> cron2: thats right :s even by using random core openvpn se=
rver to interconnect offices, normal ospf between the core servers should b=
e=20
                 sufficient
20:51 < reg9009> and there are policies sometimes where L3 (routed only) is=
 a must...
20:51 < janjust> cron2: yes but what I have in mind is to not even assign a=
n IP to the VPN endpoints
20:52 < janjust> which can be done using ifconfig-noexec
20:52 < janjust> one less IP range to worry about , one IP range less to fi=
rewall etc
20:52 < janjust> (and it makes it look more like plain IPsec)
20:52 < reg9009> I thik we have a lot of ideas for some new modules in Open=
VPN 3.0  :)   :)=20
20:52 <@mattock> reg9009: agreed  :)=20
20:53 <@mattock> it seems we (=3Dyou guys) could discuss this all night... =
but shall we move on?  ;)=20
20:53 <@cron2> reg9009: policy-wise, doing tap without bridging is not real=
ly different from tun
20:53 < janjust> reg9009: ideas are never the problem, implementing the ide=
as is a different matter
20:53 <@cron2> it's still "dedicated l3 network for the VPN side", just mor=
e encapsulation
20:53 < reg9009> mattok: yep.
20:53 < reg9009> go ahead...
20:53 < jamesyonan> I have a question: when you have an openvpn client acti=
ng as a gateway for a whole network, while you can push routes to the machi=
ne=20
                    acting as the openvpn gateway, how do you push routes t=
o the whole gateway network?
20:54 < reg9009> BGP
20:54 < reg9009> OSPF talks too much, and BGP gives you more control of beh=
aviour...
20:54 < janjust> isn't this also possible using RIP/OSPF?
20:54 <@cron2> jamesyonan: well, same dynamic routing thing, just facing th=
e other direction
20:54 <@cron2> janjust: yes.  the (dis)advantage of BGP is that it's less a=
utomatic and can be filtered and controlled more easily
20:55 < reg9009> And by assigning fixed IP with ccd, you get your neighbors=
 at both ends...
20:55 < jamesyonan> what if there's just a consumer-grade router on the gat=
eway?
20:55 < reg9009> We have AVM Fritz boxes with Freetz on some consumer sites
20:55 < reg9009> Doing a great job for this little boxes...
20:55 < reg9009> And any homeworker can setup these themselves...
20:56 < janjust> jamesyonan: perhaps someone can write a UPnP plugin to pus=
h the routes to the home router?
20:56 < reg9009> Linux running quagga and openvpn on these boxes...
20:56 <@mattock> janjust: isn't using UPnP kind of a bad idea security-vise=
?  :)=20
20:57 <@mattock> or is it just bad idea to have UPnP open ports automatical=
ly?
20:57 < janjust> mattock: UPnP does have merits, it's just that the disadva=
ntages are so enormous
20:57 < krzee> its had some security issues, and im sure it'll have more
20:57 < janjust> but a properly configured UPnP system can be useful
20:57 < krzee> but that wont stop people from (unknowingly?) using it
20:57 < janjust> and BGP also has had tons of security issues recently
20:58 < jamesyonan> I'm wondering if the consumer-grade boxes support UPnP,=
 and to what level they implement security
20:58 < janjust> even my old dumb linksys wrt54g (not GL) supports UPnP so =
I think the answer is yes. how would people use P2P otherwise  ;-)  ?
20:59 < janjust> hehe I was just mentioning it as an *option*, folks  ;-)  =
we're getting distracted again
20:59 < krzee> ya even my cheap dsl modem/router here in 3rd world supports=
 upnp
20:59 <@mattock> janjust: agreed (on getting distracted)
20:59 < reg9009> If I may raise the next topic of state synchronisation?  ;=
)=20
20:59 <@mattock> reg9009: you may
20:59 <@mattock>  :)=20
21:00 < janjust> this is the transparent failover again, right?
21:00 < reg9009> yes
21:00 < reg9009> I was setting up some IPSec boxes on OpenBSD, which enable=
 stateful failover of IPSec (whoch is really cool!).
21:00 < janjust> my opinion has not changed since I last discussed this  ;-=
)=20
21:00 < reg9009> If OpenVPN would do some state synchronisation, too
21:01 < reg9009> One could failover all VPN stuff transparently
21:01 < reg9009> As of the internal structures of OpenVPN, I think this cou=
ld be achievable without too much hassle...?
21:02 < reg9009> In my thought, only the client instances would have to be =
synchronized?
21:02 <@mattock> jamesyonan: what do you think? would this be easily doable=
 given current codebase?
21:02 < waldner> this could perhaps be a plugin for v. 3.0?
21:02 < reg9009> (client instance structs)...
21:02 < janjust> waldner: +1=20=20
21:02 <@mattock> waldner: OpenVPN will include all the things in the world =
as plugins, it seems  :)=20
21:02 < chantra> +1 for that too. In a situation where you have 2 boxes sha=
ring a failover ip (ucarp...). If the master goes bananas, the slave can ta=
ke=20
                 over and have a copy of client states if i am getting it r=
ight
21:02 <@mattock> 3.0 ...
21:02 < waldner> mattock: ins't that what plugins are for..?  :)=20
21:02 < reg9009> could be. I would be very happy of input on what is needed=
 exactly to get traffic routed.
21:03 < janjust> the problem with the client states is that the session key=
s are also copied. that's a downgrade of the security of openvpn (even thou=
gh a=20
                 manageable one)
21:03 < jamesyonan> so for transparent failover, we would need a way to per=
sist a client instance object and send it to another server?
21:03 < reg9009> E.g., are there some sequence numbers involved, or does Op=
enVPN only checks for valid instances while a packet flows?
21:04 < reg9009> jamesyonan: Maybe we could sniff a bit in pfsyncs code. as=
 they do quite the same thing, I imagine...
21:04 < reg9009> janjust: well, sasyncd also synchronizes SAs over net. It'=
s just a matter of mention it and point people to secure this kind of traff=
ic...
21:05 < jamesyonan> copying keys isn't a big deal if it done via secure tra=
nsport
21:05 < chantra> jamesyonan: over vpn connection between the 2+ servers  ;)=
=20
21:05 < janjust> jamesyonan: true, but these sessions keys are copied all t=
he time (at every key reneg)
21:06 < janjust> in other words: I like the benefits of transparent failove=
r but am worried about the security implications
21:06 < jamesyonan> reg9009: there is some sequence number state in the cli=
ent instance object
21:07 < reg9009> pk, so we need to synchronize the instance objects (while =
being added or destroyed), and while traffic flows, the sequence numbers=20
                 accordingly...?
21:07 < jamesyonan> with failover you would obviously need to have a strong=
 trust relationship between the failover nodes
21:08 < janjust> hehe the spiderman phrase comes to mind: with great power =
comes great responsibility
21:08 < reg9009> I think the trustship between failover nodes can be ensure=
d, just use crossover cables between synch networks...
21:08 <@mattock> is there anything stopping from the failover nodes from ha=
ving a secure connection to synchronize the states?
21:09 <@mattock> reg9009: good point
21:09 < reg9009> Also, synch packets could be encrypted, if needed.
21:09 <@mattock> I mean are there _necessarily_ any bad security implicatio=
ns? (if implemented correctly)=20=20
21:10 < jamesyonan> how do you detect failover?  If you use a timeout-based=
 system, then maybe by then the application protocols have also timed out a=
nd you=20
                    lose your seamless failover?
21:10 < reg9009> I think as long as one can disable synchronization any tim=
es, it should be ok.
21:10 < janjust> usually a server failover is set up using some heartbeat m=
echanism
21:10 < krzee> more likely how its achieved by CARP
21:10 < krzee> right, heartbeat
21:11 < waldner> also if v3.0 is multithreaded, there could be a thread (in=
 its own plugin) dedicated to do the sync and keepalive
21:11 < janjust> so your application protocol should change less frequently=
 than the heartbeat mechanism
21:11 < reg9009> krzee: yes. And we can "borrow" carp's code for communicat=
ion.
21:11 < reg9009> We just need to know what we have to synchronize...
21:11 < jamesyonan> but in order for seamless failover to work, the openvpn=
 client would also need to detect when the server it is connected to has go=
ne=20
                    down.
21:12 < reg9009> I would imagine to send states via multicast.
21:12 < reg9009> jamesyonan: not really. That would be a job of existing cl=
uster solutions (VRRP, CARP, keepalive, etc.)
21:12 < janjust> jamesyonan: that is normally done using roundrobin on the =
switch/router in front of the two servers : the client won't even know that=
 it=20
                 has connected to a different machine (same IP)
21:12 < waldner> jamesyonan: not if the server's public IP is also transfer=
red to the failover server
21:13 < reg9009> But as soon as Virtual IP changes, other OpenVPN instance =
would need to know if the received packet is ok.
21:13 < janjust> waldner: yes, much better explanation than my feeble attem=
pt  ;-)=20
21:13 < jamesyonan> right, I get it -- you would use a ucarp-style virtual =
IP address that is shared between the nodes
21:13 < waldner> yes, that's my understanding
21:14 < reg9009> What about the tun interface. Are there any implications w=
ith that (I don't have experience using tun interfaces programming...)?
21:15 < waldner> the failover would need to create the tun interface with t=
he same parameters on the failover server, I guess
21:15 < jamesyonan> the tun interface is fairly stateless
21:16 < reg9009> waldner: you can start OpenVPN and all tun interfaces on t=
he backup node and run it parallel to the active node (te=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDhere's just no packet=20
                 that arrives on backup node).
21:16 < waldner> reg9009: yes, that could be an option too
21:16 < reg9009> Failover nowadays works, but there's one reconnect on clie=
nt side, as the tunnel is closed as soon as the failover takes place.
21:17 < waldner> yes, there's a small intervall to reestablish the tunnel t=
o the new server
21:17 < waldner> which may or may not acceptable, depends on the use case
21:18 < janjust> a transparant failover setup (or even a non-transparant on=
e) is definitely in the category "don't try this at home unless you really =
know=20
                 what you are doing"
21:18 < waldner> agreed
21:19 < reg9009> Who could volunteer by means of helping in some special co=
rners like packet flow in OpenVPN or other things.
21:19 < janjust> but the "really know what you are doing" is more related t=
o routing than to openvpn itself (as always)
21:19 < jamesyonan> this would require that the server-side SSL/TLS context=
 for each client be persistable and transportable to the failover peer
21:19 < reg9009> I would try to take care of initial coding...
21:19 < jamesyonan> this might require some OpenSSL hacking
21:20 < waldner> there's also the usual HA issue of false positives in dete=
cting the peer is down
21:20 <@mattock> so we'd have to cheat SSL to think the other end has not c=
hanged, right?
21:20 < janjust> jamesyonan: most defintely
21:20 < reg9009> hmm, ok. But sounds like a first idea fo where to look at.=
..
21:20 < janjust> mattock: right
21:20 <@mattock> isn't that exactly was SSL was designed to protect against?
21:21 < janjust> I'd first create an openssl s_server type app that does tr=
ansparant failover
21:21 < janjust> then integrate that into openvpn
21:21 < reg9009> Well, SSL load balancer do quite same thing, if running in=
 cluster...
21:21 < jamesyonan> well SSL is certainly going to protect against MiTM
21:21 < janjust> mattock: yes and that's exactly why I am having some secur=
ity concerns
21:21 <@mattock> reg9009: ok
21:21 < jamesyonan> but that doesn't preclude portable state
21:21 < reg9009> As long as the keys are the same, it should just work...
21:22 < reg9009> Same works if loadbalancing SSL sites (https).
21:22 <@mattock> ok, so it should be doable
21:22 <@cron2> mattock: if both server sides cooperate and fully share thei=
r SSL state, it works (same server certificate, etc.)
21:22 <@cron2> "sharing of internal state" is the tough part
21:22 < reg9009> If same keys are distributed on different servers, it work=
s well. Is this comparable?
21:22 <@mattock> cron2: ok
21:22 < jamesyonan> it might be possible to sidestep OpenSSL context copyin=
g by forcing a mid-session renegotiation at the failover point
21:23 < janjust> jamesyonan: I was pondering that as well but it's the orig=
inal server that needs to force the renegotiation
21:24 < jamesyonan> No, the server can force renegotiation as well.
21:24 < janjust> wouldn't that allow for a MitM attack/
21:24 < janjust> ?
21:24 <@cron2> jamesyonan: can the *new* server force renegotiation for an =
pre-existing session?
21:25 <@mattock> given that the old server is dead already at that point
21:25 < jamesyonan> So you're asking if a MiTM could force a renegotation?
21:26 < janjust> jamesyonan: yes, well , that can already happen but right =
now the client will notice it (due to the session dropping out)
21:26 < janjust> if the failover becomes transparant then a client would no=
t even notice that the server has been compromised
21:27 <@cron2> janjust: well, the MiTM server would obviously have to have =
a correct SSL certificate
21:27 < jamesyonan> right, but a MiTM doesn't have the internal OpenSSL con=
text for the connection that includes the session keys.
21:27 < janjust> cron2: true, so your server is compromised already anyways=
 but a transparant compromise freaks me out even more  ;-)=20
21:28 <@cron2> janjust: if you can intercept my traffic, that doesn't mean =
I'm compromised
21:28 <@mattock> I assume load balancing SSL is different, given that the l=
oad balancing happens during connection initiation, not at some random poin=
t=20
                 during the connection
21:28 <@mattock> referring to earlier discussion...
21:28 <@cron2> mattock: well, depending on the implementation, existing ses=
sions can fall over to the other device transparently
21:28 < reg9009> If we keep state synchronization as much as possible on th=
e layer beneath OpenVPN, it would be an option to use.
21:29 <@cron2> reg9009: you can do that today - just failover with carp, an=
d have the clients re-establish the tunnels
21:29 < reg9009> If someone still feels uncomfortable to use it, just don't=
 enable it in config, e.g....
21:29 < waldner> mattock: but if the server to which the session was initia=
lly sent dies, it should be able to transparently direct the session toanot=
her=20
                 server
21:29 <@cron2> waldner: "message from the grave"?
21:29 <@mattock> waldner: "it" being what?
21:30 < reg9009> cron2: That's what we are doing, but I want to failover wi=
thout the need of recreate the tunnel (as in IPSec).
21:30 < waldner> cron2: sort of  :)=20
21:30 <@cron2> waldner: how does it know that it dies if it just happens to=
...?
21:30 < waldner> mattock: the load balancer
21:30 < jamesyonan> well just at a theoretical level, imagine you have an S=
SL server running on a VM.  Then you copy the VM to new hardware in a way t=
hat is=20
                    fully transparent to the clients.  The clients won't kn=
ow the difference.  It would be difficult for an SSL implementation to even=
=20
                    protect against this.
21:30 <@cron2> jamesyonan: exactly.  good example.
21:30 < waldner> cron2: some load balancers perform health check of the bac=
kend servers to detect failure
21:31 < jamesyonan> It's not a MiTM attack, it's just an acknowledgment tha=
t fundamentally, a computer + its state is inherently portable
21:31 <@cron2> waldner: sure, but that won't move the state over, or tell t=
he client to renegotiate
21:31 <@cron2> waldner: carp does "send the packets to the backup server" j=
ust fine
21:31 < waldner> but you don't need that is it will be transparent to the c=
lient
21:32 < waldner> s/is/because/
21:32 < reg9009> VRRP (or CARP) failover usually doesn't even loose one pac=
ket (in terms of failover speed).
21:32 < waldner> or maybe I'm missing something
21:32  * janjust gotta go
21:32 <@cron2> waldner: it isn't (today), because OpenVPN context is lost, =
and tunnels will be broken
21:32 <@mattock> jamesyonan: so the switch to another VM would look like a =
short connection interruption from the client perspective...
21:32 <@cron2> mattock: yes
21:32 < reg9009> by janjust...
21:32 < janjust> bye all
21:32 <@cron2> bye
21:32 <@mattock> bye janjust
21:32 -!- janjust [~janjust@...1367...] has quit [Quit: Leaving]
21:32 < waldner> cron2: ok, yes for OpenVPN yes
21:33 <@mattock> ok, so this is doable
21:33 < waldner> sorry, I thought you were talking in general, my fault
21:33 <@mattock> reg9009: so you'd be interested in implementing this with =
some help for other devs?
21:34 <@mattock> I'm think that perhaps we should start working on this to =
get an idea of the issues
21:34 <@mattock> and if it's doable in 2.x series...
21:34 <@mattock> ...issues involved in this
21:35 <@mattock> what do you think?
21:37 <@mattock> anybody still here?  :)=20
21:37 < jamesyonan> it might be possible in 2.x, however it's good that we'=
re thinking about this now in relation to planning for 3.0
21:38 <@mattock> reg9009: still there?
21:38 < reg9009> sorry, short break...
21:38 < jamesyonan> because we can ensure that with 3.0, module state must =
be serializable
21:38 < reg9009> yes, I would with some help...
21:38 <@mattock> reg9009: could you take a closer look at the code and see =
what would have to be done?
21:39 < reg9009> I will do...
21:39 <@mattock> if you keep others updated via -devel list we can discuss =
this further
21:39 < reg9009> jamesyonan: That's a good idea.

--------------090408030804070001020100--

