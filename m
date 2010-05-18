Message-ID: <4BF2AC4C.9080802@...515...>
Date: Tue, 18 May 2010 18:03:40 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000503070201020705080904"
Subject: [Openvpn-devel] Summary of the IRC meeting (13th May 2010)
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
--------------000503070201020705080904
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 13th May 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-05-13>

Next meeting next week, same place, same time. Your local meeting time
is easy to check from services such as

<http://www.timeanddate.com/worldclock>

or with

$ date -u


SUMMARY

Discussed OpenVPN 3.0 roadmap. Agreed that the current plans for OpenVPN
3.0 design are still valid:

<https://community.openvpn.net/openvpn/wiki/RoadMap>

In a nutshell, OpenVPN 3.0 would consist of a core and modules hooked
into it. These modules could do things like compression, encryption,
filter or routing to the packets. When chained together, these would
allow VPN functionality as well as host of other things.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock






--------------000503070201020705080904
Content-Type: text/plain; name="openvpn_irc_meeting_chatlog_2010-05-13.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-05-13.txt"

<dazo> Hi jamesyonan!
<jamesyonan> hi
<krzee> hello james!
<jamesyonan> hi everyone
* krzee smells a meeting
<dazo> todays agenda is not too long ... and I think we can spend a little bit long time than planned in the agenda
<dazo> the agenda is here: https://community.openvpn.net/openvpn/wiki/Topics-2010-05-13
<vpnHelper> Title: Topics-2010-05-13 - OpenVPN (at community.openvpn.net)
<dazo> a little longer time on the roadmap, I tried to say
<dazo> So lets start on the roadmap ... everyone ready for that?   https://community.openvpn.net/openvpn/wiki/RoadMap
<vpnHelper> Title: RoadMap - OpenVPN (at community.openvpn.net)
<dazo> If we focus on the OpenVPN 3.0 Design and implementation ... that's probably the best place to start right now
<dazo> jamesyonan:  does the ascii art there match your idea of 3.0? 
<jamesyonan> basically yes
<dazo> Is there something you would like different ... or would like to add?
<cron2> hi
<cron2> sorry for being late
<dazo> cron2:  no worries  :)   good you could come!
* krzee canes cron2 ;]
<dazo> If not ... let's have a little look on what types of modules we need to support in 3.0
<dazo> In the Design and Implementation section ... I've suggested a few modules .... SSL, Authentication, Logging, Network & Protocol ... I might have forgotten some
<jamesyonan> I think the diagram is fine -- the challenge will be to define the details of the user-space network stack API, packet bus, and event system.
<dazo> yes, I've been thinking about that
<dazo> and I think we need to align our perceptions of what a user-space network stack is ...
* reg9009 (~chatzilla@...1370...) has joined #openvpn-devel
<reg9009> hi all...
<dazo> I'm thinking about user-space as what's users run ... vs. kernel space is what the OS runs ... and I sense jamesyonan's meaning is a bit different
<jamesyonan> No, I mean user-space in the sense of running in user mode as opposed to kernel mode
<dazo> Oki ... then I can probably explain a bit more the drawing
<dazo> the kernel-space on this drawing is actually the top and the bottom of the "core engine"
<cron2> yep
<dazo> the top part ... is where you have tcp/udp sockets read/writing from/to a remote host ... the core engine takes this data and places it on an internal bus, tagging it as "socket data"
<cron2> mmmh
<dazo> the bottom part ... is where the "core engine" takes traffic tagged "device data" (need a better name) ... and moves data from the tun/tap device to/from the internal bus
<dazo> what's happening in the middle ... is basically the user-space part
<dazo> so what typically would happen ... data goes from the bus as "socket data" to the SSL module, where it would decrypt data ... data from the message bus tagged as "ready for socket", would go through the SSL module to be encrypted
<jamesyonan> my conception is that the actors on the packet bus fall into certain categories: producer, consumer, encapsulator, router, mangler, and filter
<jamesyonan> for example a tun/tap interface is a producer/consumer
<dazo> yes, that's right ... just as the socket side would be another set of producer/consumer ... right?
<jamesyonan> the OpenVPN protocol is an encapsulator/deencapsulator
<jamesyonan> the routing engine is just a router
<dazo> router, mangler, filter would go into the "Network & Protocol" module
<jamesyonan> a packet filter (like a firewall implementation) would be a filter
<cron2> ... or multiple such modules
<dazo> true!
<dazo> cron2:  exactly!
<dazo> I see that routing, mangler, filter, etc ... all of them are individual modules which are hooked up together in "serial" 
<dazo> but they all belong to the group "Network & Protocol"
<dazo> the encapsulation/deencapsulation is what the top part would do ... it would take the udp/tcp packets, parse them into the local bus
<jamesyonan> one of the interesting things about existing kernel mode networks stacks, is that they are generally kernel-mode in name only, because they don't do things that force them to run in kernel space like access hardware directly, handle interrupts, or deal with process scheduling
* reg9009 (~chatzilla@...1370...) has left #openvpn-devel
<jamesyonan> so it's possible to take a kernel mode network stack and build it to run in userspace, as the user-mode linux project has demonstrated
* reg9009 (~chatzilla@...1370...) has joined #openvpn-devel
<dazo> but that again will require some kernel modules, which hooks into the kernel to give the right access and prepare the kernel for this .... it's is not completely transparent, afaik ...
<dazo> you have the network queues, which only kernel-space can read/write to ... but that happens from user-space via read/write syscalls on the defined sockets of the application
<jamesyonan> right -- I'm not advocating that we build this by forking user-mode linux, just that there's a huge amount amount of networking experience embedded in the development choices that have been made when designing open source network stacks such as linux
<cron2> jamesyonan: isn't UML basically a special *kernel* that knows "not to talk to real hardware"?
<jamesyonan> cron2: yes, exactly
<cron2> mmmh, so the network stack itself still pretty much runs in "kernel space", even if that kernel is a userland process
<dazo> that's basically my point
<jamesyonan> my point is that the network stack in user-mode linux is not altogether very different from the user-space network stack we are planning for OpenVPN
<cron2> but yes, taking a close look at existing network stacks isn't going to harm
* openvpn2009 has quit (Ping timeout: 264 seconds)
<dazo> as long as we don't plan any kernel changes, openvpn will need to run completely in user-space ... and to my knowledge, we can then only access the kernel space network layers via sockets ... so I'm not sure how we would be able to pull this off otherwise?
<reg9009> would it be really a problem to continue to communicate via sockets?
<cron2> if we want this to be portable across OSes, sockets is the way to go
<cron2> "standard TCP/UDP sockets", that is
<jamesyonan> of course, we will continue to communicate via sockets.  sockets would be used by producer/consumer modules on the packet bus.
<reg9009> ok. So basically, new OpenVPN would provide some kind of "hooks" where plugins can intercept and manipulate data (for whatever reason/function)?
<jamesyonan> right
* openvpn2009 (pandora@...1371...) has joined #openvpn-devel
* raidz gives channel operator status to openvpn2009
* openvpn2009 is now known as Guest12047
<dazo> I don't think I quite follow how this would work out .... jamesyonan, can you explain the route a network packet would go?  Presume the tunnel is established ... you have application X sending a network packet to application Y on the other side of the tunnel ... how would that happen?
* Guest12047 is now known as openvpn2009
<jamesyonan> okay, on X's machine they send a packet to 10.1.2.3
<jamesyonan> kernel network stack routes to the tun interface
<jamesyonan> OpenVPN tun interface (packet bus producer) gets the packet and puts it on the bus
<jamesyonan> for normal OpenVPN usage the bus might be configured like this tun -> compress -> openvpn_encrypt_encapsulate -> socket
<waldner> sounds more or less like it is now
<jamesyonan> then the packet is sent to the other machine and the reverse process is performed
<dazo> jamesyonan:  exactly!  you are pretty much explaining well the process in my draft
<cron2> on a p2mp server, it would be tun -> router -> filter -> compress -> encrypt+encapsulate -> socket
<cron2> (or filter->router, or filter->router->filter  :)  )
<jamesyonan> this is a lot like the way OpenVPN works now.  The only difference is that now, the "bus" is hardcoded.  With the planned development, the bus would be become configurable, and the actors on the bus would be plug-in modules.
<cron2> and possibly --> traffic shaper -> 
<reg9009> and much more  ;) 
<dazo> okay, then we are on the same page  :) 
<dazo> but some of the modules will need to be placed in a chain, in a particular order, depending on the traffic direction
<jamesyonan> right, the modules would definitely be chained
<dazo> and basically ... if you have a openvpn core without any plug-ins, it would simply just pass the traffic straight through from socket to tun device and vice versa ... add a module, and it begins to investigate and possibly change/modify the data before it goes to the next module
<krzee> this is much how freeswitch works in the ip telephony world
<jamesyonan> right -- if you had an openvpn core with only producer/consumer modules
<dazo> yes
<reg9009> I think that's a solvable problem. The question is which type of hooks will be available.
<reg9009> better, would be available.
<dazo> so the core would need some categories ... and some priorities for the module, to figure out which module the packet should go to next
<reg9009> This would determine the type of plugins which could be written...
<waldner> would modules also allow to choose a different transport from plain TCP or UDP? like eg tunnelling over ICMP, or over HTTP, etc.
<dazo> waldner:  yes, possibly
<cron2> waldner: that would be a different type of "socket" interface module, then
<cron2> but I don't see "why not"
<jamesyonan> probably the producer/consumer would determine the transport
<waldner> yes, but I guess it could be abstracted behind a module
<cron2> for self-testing we might want to have producer-from-file and consumer-to-file modules
<cron2> (did I mention that I want to see more automated testing? *duck*)
<dazo> cron2:  which reminds me of the "IP over Homing Pigeon" project  :) 
<krzee> LOL
<dazo> heh
<krzee> just build a homing pigeon module!
<jamesyonan> it's amazing the crazy kinds of transport protocols people ask for  :)   years ago, someone wanted to adapt OpenVPN to use AOL IM as the transport protocol.
<krzee> hahahah
<dazo> jamesyonan:  okay ... but I think we have a common understanding now ... want me to go a bit deeper on the draft I wrote to next week, to add this new info?
<jamesyonan> sure
<krzee> (although i do admit, i use other apps for transport over icmp/DNS)
<dazo> krzee:  http://en.wikipedia.org/wiki/IP_over_Avian_Carriers
<vpnHelper> Title: IP over Avian Carriers - Wikipedia, the free encyclopedia (at en.wikipedia.org)
<dazo> (it's already done)
<dazo> jamesyonan:  good, I'll do that
<waldner> if an extensible system is in place, and can provide a consistent API, then people could theoretically write a module to transport data over (almost) anything
<dazo> krzee:  you had a question ... we're beginning to run out of time, so I'll give you the stage now
<waldner> which would bi a kind of "holy grail" or tunnelling
<krzee> ok
<dazo> waldner:  yupp  :) 
<waldner> and way cool, if you ask me
<krzee> this will be quite the change of subject
<krzee> jamesyonan, not sure if you know, but in ##openvpn we dont support AS
<krzee> its not that we dont want to help you get $, we sure wouldnt mind helping with that
<krzee> its that AS uses different style configs and logs look different
<krzee> if you were to make AS use/make normal configs, and log more normal (by normal i mean like opensource openvpn) we would happily help those who come using AS
<krzee> not sure if you care to, but i wanted to put that out there
<krzee> i clearly cant speak for everyone, but thats the situation for me and ild be surprised if it wasnt similar across the board for those who regularly help on IRC
<jamesyonan> AS tries to solve a different problem than what we usually talk about on the openvpn community forums
<jamesyonan> I'm not sure it makes sense to mix AS and openvpn community forums
<krzee> right, but if it solved it in a way thats similar in the background with opensource openvpn, we could help those users who have issues
<krzee> ok cool
<krzee> just wanted to make sure that was a conscious decision by you
<jamesyonan> AS is a commercially supported product, so it's better if AS users are directed towards existing AS forums
<krzee> cause you have a lot of free support for the OS version, figured maybe youd wanna take advantage of that for your paid version
<krzee> cool, whats the existing AS forum then? ill link to it in !AS on my bot
<dazo> that sounds like a sensible solution then, that we can at least guide the users somewhere than just "reject" them
<krzee> exactly
<krzee> currently its just "we dont support AS"
<ecrist> if it's not now, it used to be in /topic
<raidz> krzee: we don't have a forum for as support, however you could direct users to: http://openvpn.net/index.php/access-server/support-center.html
<vpnHelper> Title: Support Center (at openvpn.net)
<jamesyonan> I don't know if Andrew Proctor is online, but you can reach him at andrew at openvpn.net -- he coordinates AS support
<raidz> I am here  :-) 
<krzee> ecrist, its in the onjoin in CAPS, often ignored tho ;]
<reg9009> by the way, we've been talking about dynamic iroute changes last week...
<raidz> and out live chat can be found on this page: http://openvpn.net/index.php/access-server/quick-start-guide.html
<vpnHelper> Title: Quick Start Guide (at openvpn.net)
<reg9009> I could find a volunteer for it, though his last C experiences were couple of years ago.
<dazo> jamesyonan:  I have one more thing, if you have time ... I know we're exceeding the time, so I want to be brief ... 
<reg9009> sorry to intercept...
<krzee> reg9009, interesting!
<dazo> reg9009:  if you find someone who is willing to write patches, defend them and make sure they are in shape for inclusion ... please do!
<reg9009> well, we try our best, but be gentile...  ;) 
<dazo> jamesyonan:  it's about OpenSSL 1.0.0 .... http://thread.gmane.org/gmane.network.openvpn.devel/3091
<vpnHelper> Title: Gmane Loom (at thread.gmane.org)
<reg9009> We're doing good progress. We established communcations and just need to manipulate iroute table.
<reg9009> That should be working by next week, at which we would have a prototype.
<reg9009> Unfortunately only for linux, yet.
<dazo> jamesyonan:  do you know about this issue?  and if you're got some pointers, I'm more than willing to dig into this 
<jamesyonan> No, I haven't looked at OpenSSL 1.0 (I
<jamesyonan> I'm still on 0.9.8
<jamesyonan> Probably take a look at the release notes and see what's changed.  It looks like some functions prototypes changed.
<dazo> jamesyonan:  yes, I just wanted to be sure I didn't begin researching for known info already ... I'll have a look then
<dazo> I think that concludes this meeting .... unless someone else got something urgent burning?
<jamesyonan> actually -- one thing...
<cron2> OpenVPN *works* with OpenSSL 1.0.0, it's just compiler warnings
<dazo> yes
<dazo> jamesyonan:  go ahead!  :) 
<jamesyonan> does anyone have access to a LAN environment that defines WPAD proxy settings?
<cron2> the windows cross-compile thing uses 1.0.0, because openssl 0.9.x is very cross-compile-unfriendly
<cron2> jamesyonan: no, sorry
<dazo> jamesyonan:  I'd send a mail to JJK ... he might know something
<jamesyonan> I've been working on adding WPAD support to the OpenVPN windows build, but I don't have an environment to test it.
<reg9009> yes, I do...
<krzee> not i
* jamesyonan (~jamesyona@...1320...) has left #openvpn-devel
* jamesyonan (~jamesyona@...1320...) has joined #openvpn-devel
<jamesyonan> cool -- would you mind testing a beta client that uses the new proxy discovery code?
<reg9009> no problem...
<jamesyonan> cool -- email me at jim@...41... and we can coordinate
<dazo> Thanks a lot! And the next meeting is next week, same place, same channel ... and mattock will hopefully be back too  :) 
<jamesyonan> bye everyone
<dazo> bye!
<krzee> bye james!
<cron2> bye  :) 
<reg9009> bye
<reg9009> dazo: would you be willin to dosome code review first before we submit a patch to the mailing list (or anybody else, of course)?
<dazo> reg9009:  sure, send it my way, and I'll have a look at it!
<krzee> reg9009, that could be a very nice feature
<krzee> would it basically be like iroute adaptive in a ccd?
<reg9009> yep...
<krzee> that would be a perm solution for those clients who for some lame reason send their data with src IP of eth0 device
<reg9009> as soon as a route is palced into kernel (or deleted), we check if the next hop is in the client list of OpenVPN
<krzee> however, theres a few reasons it wouldnt help too much with LANs behind the client
<krzee> a) the server doesnt push routes to already connected clients
<reg9009> if it is, we update the iroute table with the new information...
<krzee> b) even if it did, you couldnt lower permissions when using it
<krzee> and an iroute without matching "route" doesnt do much
<krzee> c) server couldnt run with lowered permissions either
<krzee> (to add corresponding "route")
<reg9009> it only works together with dynamic routing protocols (bgp, in our case)
<krzee> oh, i gotchya
<krzee> so RIP setups wouldnt need ptp tunnels
<reg9009> rip setups aren't suitbale for this.
<reg9009> ospf should work, though...
<krzee> ya, that would be cool, and would help with the future idea here: http://ovpnforum.com/viewtopic.php?f=10&t=141
<vpnHelper> Title: OpenVPN Forum View topic - Idea for direct connections (at ovpnforum.com)
<krzee> (i think)
<krzee> meh, maybe not... i only got 3 hrs sleep
<reg9009> the problem we had is that if a new network behind a vpntunnel is setup, even all routers know the new net in kernel routes
<reg9009> we can't reach them because iroute table within OpenVPn doesn't get noticed of that new network and doesn't pass traffic...
<reg9009>  ;) 
<krzee> reg9009, sounds like thats the same issue with using RIP to build a mesh...   http://www.secure-computing.net/wiki/index.php/OpenVPN/RIPRouting
<vpnHelper> Title: OpenVPN/RIPRouting - Secure Computing Wiki (at www.secure-computing.net)
<reg9009> but, 
<reg9009> yes, it is...
<dazo> !logs
<vpnHelper> dazo: "logs" is http://secure-computing.net/logs/%23openvpn-devel.log updated every 30 minutes.
<reg9009> but, as OpenVPN got a connection to the clients, dynamic push of new routes to the client which puts them into kernel there should be possible
<krzee> to the connecting client, yes
<krzee> to the already connected ones, only when not using lowered permissions

--------------000503070201020705080904--

