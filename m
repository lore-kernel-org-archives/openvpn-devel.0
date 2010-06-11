Message-ID: <4C120EE5.9000702@...515...>
Date: Fri, 11 Jun 2010 13:24:37 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060008050300040007010506"
Subject: [Openvpn-devel] Summary of the IRC meeting (10th Jun 2010)
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
--------------060008050300040007010506
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 10th Jun 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-06-10>

Next meeting next week, same place, same time. Your local meeting time
is easy to check from services such as

<http://www.timeanddate.com/worldclock>

or with

$ date -u


SUMMARY

Discussed a potential bug, "Not using --push on server makes client
sending PUSH_REQUEST continuously":

<https://community.openvpn.net/openvpn/ticket/13>

The --push option allows server to send configuration details to client
for execution. Similarly, --pull on the client side makes client accept
the configuration details send by the server.

The root of the problem is that the "--client" option enables "--pull"
automatically and if "--push" is not used on the server side, the client
is unable to setup the VPN tunnel properly.

Agreed that although OpenVPN is behaving as expected, server should
respond (e.g. "NO_SOUP_FOR_YOU") to PUSH_REQUESTS from client even if
"--push" is disabled in server configuration. This would allow the
client to establish the VPN tunnel properly. Dazo volunteered to fix
this problem.


Discussed the "Handle non standard subnets in PF grammar" patch:

<https://community.openvpn.net/openvpn/ticket/14>

This patch had already been sent, reviewed, reworked and ACKed earlier.
Agreed that the code should also display a warning if there are problems
with the PF grammar.


Discussed the "Enabling Accounting/Stats for plugins" patch:

<https://community.openvpn.net/openvpn/ticket/15>

Agreed to proceed like this:

- chantra explains this patch in more detail
- we ask our users if they want the feature
- if users would like the feature, we should include it in "testing"


Discussed OpenVPN 2.2 briefly. Agreed that the following code should be
safe to include:

- bugfix2.1 branch (lots of bugfixes)
- feat_misc branch (several minor feature additions)
- frp branch (https://community.openvpn.net/openvpn/wiki/FRP)
- feat_eurephia branch (http://www.eurephia.net)
- IPv6-enabled TAP driver

All of these are viewable from here:

<http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=3Dopenvpn/openvpn-test=
ing.git;a=3Dsummary>

Estimated that the first 2.2 alpha could be released by the end of July.
Samuli tries to get the continuous integration / packaging / publishing
server online before end of June. This would get "testing" into much
wider circulation in preparation for the next release.


Discussed OpenVPN 3.0 briefly:

<https://community.openvpn.net/openvpn/wiki/RoadMap>

Agreed that we need to keep query and reply-oriented transports (e.g.
http and dns) in mind during design.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock




--------------060008050300040007010506
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-06-10.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-06-10.txt"

(21:13:42) mattock: hi james!
(21:13:48) jamesyonan: hi!
(21:14:00) dazo: perfect!
(21:14:02) krzee: that was faster than batman chasing the bat signal!
(21:14:11) mattock: krzee: that's fast!
(21:14:38) mattock: ok, so first topic was a potential bug: https://communi=
ty.openvpn.net/openvpn/ticket/13
(21:14:40) vpnHelper: Title: #13 (Not using --push on server makes client s=
ending PUSH_REQUEST continuously) =EF=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN (at c=
ommunity.openvpn.net)
(21:15:14) dazo: I've been checking it out, and this looks like a bug indee=
d ... if the client don't receive a PUSH response from the server, it just =
waits forever
(21:15:33) mattock: also, the "Adding either --tcp-nodelay (even though we'=
re using UDP) ... resolves this issue" sounds interesting
(21:15:48) dazo: mattock: that does a PUSH, I think I found out
(21:16:29) dazo: I've not been poking at the code level yet, but maybe jame=
syonan knows where to start looking?  I don't mind looking into it when I'm=
 back from holidays, unless somebody else are quicker
(21:16:35) mattock: one would not expect any tcp config option stuff to aff=
ect udp, though...
(21:16:38) jamesyonan: the client should need a "pull" option or a macro th=
at includes "pull" in order to query the server with PUSH_REQUEST
(21:16:43) krzee: wouldnt that be a config error?
(21:17:08) krzee: from them redesigning --server manually with no push, but=
 still using --client or --pull on the client
(21:17:23) dazo: jamesyonan: there are no --pull options in client config
(21:17:23) krzee: since if they use --server it will push something...
(21:17:33) krzee: dazo, including --client?
(21:17:35) dazo: --client is used
(21:17:45) waldner: --client implies --pull
(21:17:50) krzee: --client IS --pull
(21:17:56) krzee: or ya implies
(21:18:00) dazo: right!  I forgot that
(21:18:03) krzee: it has something else too
(21:18:27) dazo: --tls-client
(21:18:32) krzee: ya, thats it
(21:18:44) krzee: all client is is --pull and --tls-client
(21:18:57) krzee: i explained that to someone who found that "bug" in the I=
RC channel
(21:19:03) krzee: i wonder if it was the same person ;]
(21:19:34) dazo: but wouldn't it be expected that --pull should work on cli=
ent side even if server has nothing to push?  Server could simply say: "Sor=
ry, nada for you"
(21:19:44) cron2: dazo: that's what I was about to say
(21:19:49) krzee: true, that seems like a valid thing to so
(21:19:50) cron2: send empty PUSH REPLY back
(21:19:53) krzee: s/so/do/
(21:20:00) dazo: exactly
(21:20:21) jamesyonan: yeah, that would probably work
(21:20:39) dazo: jamesyonan: and quick ideas where to start poking?
(21:20:59) ***dazo got an 11 hour long flight coming .... perfect hacking t=
ime :-P
(21:21:33) mattock: unless the flight attendants force you to switch off yo=
ur computer... :)
(21:21:43) dazo: mattock: suspend mode?
(21:21:44) dazo: :-P
(21:21:58) cron2: dazo: lemme check
(21:22:16) cron2: well, there's obviously push.c :-)
(21:22:32) mape2k [~mape2k@...1306...:638:904:ffe0:21f:3bff:fe27:21a9] =EF=
=BF=BD=EF=BF=BD entrato nel canale.
(21:22:36) ***krzee hopes dazo gets a seat with travel charger port
(21:22:54) ***dazo hopes so too!
(21:23:13) dazo: coding on paper is so freaking boring
(21:23:29) cron2: my laptop has a new battery, 7+ hours lifetime :)
(21:23:36) jamesyonan: yeah, check out push.c
(21:23:37) dazo: cron2: send it my way!
(21:23:48) cron2: nah
(21:23:50) dazo: heh
(21:24:01) cron2: dazo: process_incoming_push_msg()
(21:24:13) dazo: not send_push_request()?
(21:24:18) dazo: ahh!
(21:24:19) dazo: yeah
(21:24:32) cron2: but I'm not sure under which conditions that would refuse=
 to send a PUSH_REPLY
(21:25:09) krzee: ok so dazo will look into solving that "bug" by allowing =
the server to reply to a push request with "no soup for you" during his hel=
lish 11hr flight...
(21:25:12) krzee: i give it a +1
(21:25:20) cron2: +1
(21:25:25) mattock: +1
(21:25:40) mattock: shall we move on?
(21:25:41) cron2: (11hr, that sounds like "new zealand" or something nice l=
ike this... dazo, where are you going to?)
(21:25:48) dazo: Alaska
(21:25:55) krzee: haha
(21:26:07) krzee: come to the caribbean man
(21:26:08) dazo: New Zealand is 24h+ ... been there, done that :-P
(21:26:16) dazo: krzee: next time ;-)
(21:26:23) jamesyonan: so you're going into the wild?
(21:26:39) cron2: dazo: ah, send_push_reply() has "if (BLEN (&buf) > sizeof=
(cmd)-1)" at the end, so it will just not send a reply if there is no soup
(21:26:45) dazo: my wife got some friends living in Fairbanks=20
(21:26:51) mattock: to hunt bears with your bare hands? or perhaps beers?
(21:26:53) dazo: cron2: yeah
(21:26:59) cron2: but it needs checking whether the client will choke on em=
pty messages or handle that gracefully
(21:27:03) krzee: lol mattock
(21:27:13) ***dazo don't like beer, but prefers beer before bears=20
(21:27:29) cron2: (the client code is quite robust there - the IPv6 stuff w=
orks because "unpatched" clients will just ignore unknown push-options)
(21:27:30) dazo: cron2: good tip!  I'll make sure to dig into that part
(21:27:52) jamesyonan: my guess is that the client might warn about an empt=
y push but will not choke over it
(21:28:12) krzee: ahh if they ignore over unknown, you can just send NO_SOU=
P option
(21:28:14) krzee: hehe
(21:28:22) dazo: jamesyonan: I'll check out that ... and make it ignore emp=
ty push silently ... would that be fine?
(21:28:23) cron2: krzee: heh.  good plan :-)
(21:29:14) dazo: next topic?
(21:29:15) mattock: next topic?
(21:29:19) mattock: ok
(21:29:19) dazo: heh
(21:29:21) mattock: https://community.openvpn.net/openvpn/ticket/14
(21:29:21) krzee: nexxxxt
(21:29:22) dazo: https://community.openvpn.net/openvpn/ticket/14
(21:29:23) vpnHelper: Title: #14 ([PATCH] Handle non standard subnets in PF=
 grammar) =EF=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN (at community.openvpn.net)
(21:29:24) vpnHelper: Title: #14 ([PATCH] Handle non standard subnets in PF=
 grammar) =EF=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN (at community.openvpn.net)
(21:29:30) jamesyonan: when the client gets push options from server, it wi=
ll run them through the command line processor
(21:29:44) mattock: hmm... deja vu
(21:30:49) krzee: looks like this ticket is a patch from chantra... chantra=
 you here?
(21:31:01) dazo: jamesyonan: but it will be in a "awaiting server push afte=
r having sent the push request, right?  So it can then validate the length =
of the push and consider to pass it on to the command line parser
(21:31:01) krzee: [chantra] idle 02:13:45
(21:31:07) chantra: krzee: yop
(21:31:25) fkr_ ha abbandonato il canale (quit: Quit: leaving).
(21:31:43) jamesyonan: dazo: probably
(21:31:45) dazo: The next patch is ACKed by cron2 already ... so I don't th=
ink it's much to be said here, I think
(21:31:51) cron2: dazo: yop
(21:31:58) cron2: (for the question before that)
(21:32:03) dazo: jamesyonan: I'll squash that bug then
(21:32:17) krzee: oh cool, already ack'ed!
(21:32:24) mattock: dazo: you mean this pf subnet stuff is ACK'd?
(21:32:32) cron2: for the patch in question: I think the only thing left to=
 agree on is "do we want a warning"?
(21:32:52) dazo: yes, that was what I was going to say
(21:33:12) krzee: how do users control the internet pf?  the fact that one =
exists is news to me (does it exist in 2.1.1?)
(21:33:14) chantra: to me it could be interpreted as a user typo and could =
be done silently
(21:33:17) krzee: errr
(21:33:24) krzee: s/internet/internal/
(21:33:34) dazo: I find appropriate to warn in that situation .... such a w=
arning says you have either wrong IP or wrong netmask
(21:33:59) ***cron2 agrees with dazo :)
(21:34:10) cron2: mattock: yes, patch has been sent, reviewed, reworked, an=
d ACKed
(21:34:19) mattock: cron2: great!
(21:34:20) dazo: if you do 192.168.0.155/24 ... you could mean 192.168.0.15=
5/32 ... or 192.168.0.0/32
(21:34:35) dazo:  192.168.0.0/24, I mean
(21:34:42) jamesyonan: agreed: a warning is probably appropriate, but I wou=
ld ACK as-is
(21:34:47) chantra: dazo: correct
(21:35:19) waldner: krzee: a plugin is needed, although virtually everythin=
g can be done using scripts
(21:35:30) dazo: cool, thx!  I'll merge those two submitted patches into on=
e simpler one, for the git history to look more sane
(21:35:37) waldner: but you do need a plugin that tells OpenVPN that you're=
 using the internal pf
(21:36:12) mape2k ha abbandonato il canale (quit: Ping timeout: 276 seconds=
).
(21:36:21) krzee: waldner, oh ok i see
(21:37:34) mattock: anything else on this issue?
(21:38:10) mattock: or shall we move on to https://community.openvpn.net/op=
envpn/ticket/15 ?
(21:38:12) vpnHelper: Title: #15 ([PATCH] Enabling Accounting/Stats for plu=
gins) =EF=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN (at community.openvpn.net)
(21:38:12) dazo: For me it is clear .... patch with warning is ACKed, I'll =
merge it in
(21:38:12) cron2: dazo: yes, makes sense
(21:38:30) krzee: +1
(21:39:28) dazo: There are a few things I don't feel so comfortable with th=
is patch
(21:40:07) dazo: openvpn-plugin.h is modified ... and there _STATS seems to=
 be replaced with _ACCOUNTING
(21:40:33) dazo: which is unclear to me why that is done
(21:40:47) mattock: chantra: care to elaborate?
(21:40:49) dazo: This will break third-party plug-ins which uses OPENVPN_ST=
ATS
(21:40:57) dazo: (at build time)
(21:41:00) chantra: oh, coz i called it stats based on the post http://perm=
alink.gmane.org/gmane.network.openvpn.devel/1048
(21:41:03) vpnHelper: Title: Radius support (Authentification, Authorizatio=
n and Accounting) (at permalink.gmane.org)
(21:41:23) ***cron2 can't claim to understand the plugin interface well eno=
ugh to comment
(21:41:32) chantra: coz the rest of the patch was actually _accounting.....=
 i though it would make more sense to call the plugin accounting
(21:41:35) dazo: further OPENVPN_PLUGIN_N is renumbered to 13 from 12 ... w=
hich can cause run-time complications
(21:41:39) mattock: that's pretty old thread (2005)
(21:41:59) dazo: to plug-in binaries compiled against an earlier openvpn re=
lease, and the openvpn is upgraded
(21:42:41) dazo: (there are also some white-space diffs in the patch as wel=
l ... so it "modifies" lines adding/removing spaces or tabs)
(21:42:53) chantra: dazo: i though plugin_n was the last number
(21:43:18) chantra: so i move it to the next available and put _accounting =
in place
(21:43:19) ***dazo need to double check that=20
(21:43:48) chantra: dazo: also, maybe I should have generated only one patc=
h and not the succession o patches from one commit to another
(21:43:56) dazo: aha!
(21:44:06) dazo: that's probably confusing us now
(21:44:14) chantra: i just used git format-patch=20
(21:44:23) dazo: yeah
(21:44:27) dazo: that's right
(21:44:58) dazo: chantra: I'll find some tricks how to collect several comm=
its into one commit for format-patch
(21:45:08) mattock: I assume we want the functionality of this patch, right?
(21:45:19) mattock: so it's just minor modifications and fixes and then it'=
s ACK?
(21:46:47) dazo: chantra: what exactly does this accounting provide in addi=
tion to the --status file?
(21:46:56) ***dazo just want's to be sure he understands it correctly
(21:47:40) chantra: in addition, nothing
(21:47:51) chantra: but rather a signal interface
(21:48:06) chantra: through the plugin you can provide a custom accounting =
interval
(21:48:24) chantra: the mainloop will call the plugin anytime this period i=
s expired
(21:48:46) chantra: dazo: https://community.openvpn.net/openvpn/attachment/=
ticket/15/accounting.patch
(21:48:48) vpnHelper: Title: Attachment =EF=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN=
 (at community.openvpn.net)
(21:49:29) chantra: it was discuss by jamesyonan a while back http://permal=
ink.gmane.org/gmane.network.openvpn.devel/1048
(21:49:31) vpnHelper: Title: Radius support (Authentification, Authorizatio=
n and Accounting) (at permalink.gmane.org)
(21:49:34) chantra: 2005 :)
(21:50:35) dazo: chantra: can you do a little write up of a little document=
 how to implement it?
(21:50:35) cron2: well, so it's up to James to ACK this patch, no? :-)
(21:50:48) dazo: that may help understand the API
(21:51:22) chantra: dazo: i tried to explain in the track ticket , but can =
elaborate sure
(21:51:52) jamesyonan: I should add that the management interface already s=
upports accounting.=20
(21:52:16) dazo: then we actually are doing the same twice
(21:52:20) chantra: the only wall i was hitting is that func_v2 seems to on=
ly be fully implmented (as in using return_list vlues) for PLUGIN_CONNECT_V2
(21:52:50) dazo: chantra: would you mind writing a little plug-in demo whic=
h illustrates the usage?
(21:52:55) chantra: dazo: but the you are dependant n either having the man=
agement interface on or parsing a file
(21:53:18) jamesyonan: There's some duplication here in the sense that the =
plugin interface and management interface can often be used to accomplish t=
he same thing
(21:53:30) dazo: chantra: I see the advantage of writing a plug-in rather t=
han writing a socket application connecting to the management interface
(21:53:30) chantra: dazo: np, i got some kind of running demo already, but =
it is backend dependant
(21:53:51) jamesyonan: the major difference is that the plugin interface is=
 synchronous while the management interface is asynchronous
(21:54:01) dazo: chantra: just make something very simple, which writes to =
a file every 60 second or so
(21:54:22) chantra: dazo: k
(21:54:30) dazo: and james' comment is what I was wondering about too
(21:55:41) chantra: thats right, but the management interface mean that you=
 need to start a telnet session from the plugin to connect to it
(21:55:48) chantra: parse the reply
(21:56:16) chantra: here, you have everything integrated and that cn be use=
d easily from within a C plugin
(21:56:51) chantra: to me, one is management as in humna managing openvpn
(21:56:54) dazo: or that the plug-in talks to a separate accounting daemon =
.... where the plug-in just asks the daemon "is client XYZ allowed?"
(21:57:23) chantra: the other one can be handle programatically
(21:57:31) cron2: plugins are .so loaded by OpenVPN?  Or how does the commu=
nication OpenVPN->plugin work?
(21:57:31) chantra: dazo: yeah, let get back on radius
(21:58:06) chantra: from my .so, i first receive plugin_auth_user_pass  and=
 authenticate user
(21:58:43) chantra: later on, connect_v2 kicks in and tell me what ip can b=
e provided to client, what time the session start...
(21:58:48) dazo: cron2: yeah, plug-ins are loaded by OpenVPN ... and the op=
envpn server process triggers different hooks
(21:59:14) chantra: at this time, the plugin can return tell openvpn to giv=
e it an update every so often
(21:59:37) dazo: cron2:  depnending on how the plug-in is initialised with =
openvpn, where it defines which hooks it will answer to
(21:59:57) dazo: chantra: I
(22:00:14) dazo: You've done a great job providing patches, and they genera=
lly have quite good quality
(22:00:24) cron2: dazo: ok (I was worried about having to do an exec() etc.=
 every few seconds, but if it's basically just a function call, the overhea=
d is not so bad)
(22:01:08) chantra: cron2: yeah, default is set to 60s, but you can set it =
to 0 to disable the feature
(22:01:40) dazo: but bringing up such old threads like this one, is dangero=
us ... as we might have other approaches solving similar issues ... it migh=
t be a good idea to ask if the feature is still needed, or what else others=
 might see as solutions on the mailing list ... just to avoid wasting time =
if the patch is not accepted=20
(22:01:43) chantra: then, the plugin can again change this value depending =
on what the AAA server told it to
(22:01:52) dazo: (but I'm not saying NACK now ... but we need to go a few m=
ore rounds on this one)
(22:02:05) chantra: dazo: :)
(22:02:34) chantra: yeah, i understand... but was probably needing this for=
 my on use anyway... so i was going to code it
(22:02:52) mattock: what if we proceed like this:
(22:03:06) mattock: - chantra explains this patch in more detail in the Tra=
c ticket
(22:03:15) mattock: - we ask our users if they want the feature
(22:03:17) dazo: then, I just say, thanks for sharing :)  And we'll have a =
deeper look into this one ... especially if you can provide some little exa=
mple code
(22:03:53) dazo: mattock: +1
(22:04:00) krzee: +1
(22:04:11) chantra: sounds good=20
(22:04:15) dazo: But honestly, I'd say we have one more important topic ...=
. which features to include into 2.2 ... that got postponed last week, do w=
e have time for this one now?
(22:04:26) mattock: dazo: I think so
(22:04:32) cron2: it would be good to at least briefly cover this
(22:04:37) dazo: yes
(22:04:42) mattock: also, yarrick may want to discuss 3.0 a little...
(22:05:13) mattock: (he's lead dev from iodine which according krzee is the=
 best dns tunneling app :)
(22:05:36) Yarrick: yes, that would be interesting
(22:05:55) mattock: yarrick: what if we discuss 2.2 first?
(22:06:02) Yarrick: go ahead
(22:06:41) krzee: has ipv6 been tested enough for 2.2?
(22:06:46) mattock: ok, so which features to include in 2.2...
(22:06:55) dazo: Features I find safe for OpenVPN 2.2 are basically the bug=
fix2.1, feat_misc, feat_frp and feat_eurephia=20
(22:07:23) mattock: what's in feat_misc and feat_frp?
(22:07:23) dazo: s/feat_frp/frp/
(22:07:40) dazo: feat_misc is a lot of minor feature additions ...
(22:07:45) ***dazo will look up the changelog
(22:07:52) cron2: krzee: "sort of"
(22:08:26) mattock: btw. regarding 2.2... I'll start working on the contino=
us integration/packaging/publishing server tomorrow
(22:08:46) mattock: been playing with puppet to automate annoying server se=
tup tasks, but I'm mostly finished with it now
(22:08:52) dazo: http://www.pastebin.ca/1880608
(22:08:53) mattock: (in a good way)
(22:08:55) cron2: krzee: I'm not sure about the IPv6 transport (JJo) stuff.=
  The IPv6 payload stuff is working well, and I have not heard "has problem=
s" reports so far - but I consider it not yet feature-complete, so I'd aim =
for 2.3 here
(22:09:20) cron2: dazo: what I would *love* to see in 2.2 is the TAP driver=
 changes necessary for IPv6 support
(22:09:27) dazo: pastebin is changelog from SVN BETA21 branch from last wee=
k which is not added
(22:09:41) dazo: cron2: is that possible to extract out?
(22:09:43) cron2: that way, users can build a new openvpn.exe for windows, =
but don't have to figure out how to build a device driver
(22:10:09) cron2: dazo: yes, it's isolated changes (on purpose :) ), let me=
 grab the commit IDs
(22:10:17) dazo: cron2: perfect!
(22:10:38) cron2: dazo: 175e17a5abd5969f6803a9cc9587b7959e1100ae
(22:10:57) mattock: cron2: I'd probably have to build windows.exe's, too, s=
o I'd love those TAP driver changes too
(22:11:23) cron2: dazo: and 6fa56ad77d30e40db43f54a347cc83eb04f4f6dd, one-l=
ine fix in the "DATE" specification
(22:11:26) dazo: http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=3Dopen=
vpn/openvpn-testing.git;a=3Dcommit;h=3D175e17a5abd5969f6803a9cc9587b7959e11=
00ae
(22:11:27) vpnHelper: Title: SourceForge - openvpn/openvpn-testing.git/comm=
it (at openvpn.git.sourceforge.net)
(22:11:46) dazo: http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=3Dopen=
vpn/openvpn-testing.git;a=3Dcommit;h=3D6fa56ad77d30e40db43f54a347cc83eb04f4=
f6dd
(22:11:47) vpnHelper: Title: SourceForge - openvpn/openvpn-testing.git/comm=
it (at openvpn.git.sourceforge.net)
(22:12:19) dazo: (click on 'commitdiff' if the patch changes don't show up)
(22:13:21) dazo: jamesyonan: do you agree to put IPv6 enabled TAP driver in=
to 2.2?
(22:13:33) mattock: and what about the rest of the stuff?
(22:14:20) dazo: mattock: bugfix2.1, feat_misc, frp and feat_eurephia?
(22:14:27) mattock: yep
(22:14:37) mattock: I mean what james thinks about those :)
(22:14:38) dazo: http://www.pastebin.ca/1880608 .... changelog overview of =
feat_misc
(22:14:50) jamesyonan: How much testing has the IPv6 enabled TAP driver rec=
eived so far?
(22:15:11) cron2: fairly basic testing only
(22:15:50) mattock: cron2: how big changes are in it (compared to non-IPv6 =
enabled TAP driver)?
(22:15:57) cron2: a few people have tested it on XP (works), Win7/32 (seems=
 to work) and Win7/64 (doesn't work because I have not yet signed it)
(22:16:10) dazo: as it is 2 pretty clean patches, and we don't have much wi=
ndows patches at all .... these two IPv6 patches can be reverted quite easi=
ly, if a beta phase indicates it is not solid enough
(22:16:41) cron2: mattock: the changes are not that big, but they *are* in =
the "all packets pass here" path, so they are relevant for IPv4-only users =
as well
(22:16:49) mattock: cron2: ok
(22:17:27) dazo: the vast majority of the patch seems to be pretty much iso=
lated to IPv6, though
(22:17:29) mattock: I'll try build the CI server a.s.a.p. (=3Dbefore end of=
 June) to get more coverage for "testing"
(22:17:29) cron2: the stuff is fairly isolated, though, and should be revie=
w'able fairly easy for obvious problems
(22:17:47) mattock: ...including ipv6
(22:18:10) mattock: dazo: when do you think we could roll out first alpha?
(22:18:20) cron2: mattock: cool :)
(22:18:26) dazo: before end of July?
(22:18:27) mattock: given these features (incl. ipv6-enabled tap driver)
(22:18:38) mattock: dazo: ok
(22:18:59) mattock: I'll concentrate on packaging+publishing first, CI stuf=
f (e.g. buildbot) can wait
(22:19:31) mattock: jamesyonan: does this plan for 2.2 contents + schedule =
sound sane to you?
(22:19:54) dazo: btw ... I'm running openvpn-testing version in production =
as a client, which got a 24/7 connection running ... and I have no issues o=
n basic stuff there=20
(22:19:54) jamesyonan: yeah, this looks reasonable
(22:21:31) mattock: ok, so let's try to get automated packaging+publish wor=
king by end of June and first 2.2 alpha out by the end of July
(22:21:51) dazo: perfect!
(22:22:12) mattock: ok, anything else on 2.2?
(22:22:14) cron2: dazo: cool.  (I use ipv6 payload in production, no window=
s unfortunately there yet... need to see whether one of my colleagues is st=
ill on windows, most of them migrated to macosX)
(22:23:23) dazo: cron2: this site I plan to upgrade to use ipv6 transport (=
when the ISP provides me with "proper" IPv6 addresses) ... and then IPv6 pa=
yload soon after, so we'll get some more testing there
(22:23:37) cron2: cool :)
(22:24:28) mattock: ok, shall we discuss 3.0 briefly now? Yarrick: anything=
 special you'd like to share?
(22:24:34) mattock: https://community.openvpn.net/openvpn/wiki/RoadMap
(22:24:39) vpnHelper: Title: RoadMap =EF=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN (a=
t community.openvpn.net)
(22:25:09) Yarrick: the architecture diagram looks sane
(22:25:32) Yarrick: i just wonder where fragmentation would fit in. in its =
own layer or in one of the others?
(22:25:53) mattock: yarrick: I assume this is the project you lead: http://=
code.kryo.se/iodine/
(22:25:55) vpnHelper: Title: kryo.se: iodine (IP-over-DNS, IPv4 over DNS tu=
nnel) (at code.kryo.se)
(22:26:01) Yarrick: mattock: correct
(22:26:38) dazo: fragmentation of packets to/from the TUN/TAP (bottom) ....=
 or on the socket side (top) ?
(22:26:42) mattock: that's one funky project, btw ;)
(22:27:13) krzee: i use iodine on ALL my travels
(22:27:19) krzee: its <3
(22:27:38) Yarrick: dazo: at the top, if the udp link is picky about length
(22:27:51) Yarrick: i guess its not a problem for normal vpns :)
(22:28:13) cron2: krzee: *lol* (I use dns2tcp, which is not tun based, but =
suffices for ssh)
(22:28:49) dazo: Yarrick: then the fragmentation would then happen in the s=
ocket module
(22:29:07) Yarrick: dazo: ok
(22:30:06) dazo: the "yellow field" is an internal packet bus, where packet=
s are tagged to or from modules ... so it could actually be a separate modu=
le as well, but as the fragmentation on the socket level is so tightly conn=
ected to what's being sent out, the socket module makes more sense in my he=
ad ..... but I'm not an experience low-level network coder, so I might be w=
rong
(22:30:50) jamesyonan: I would see fragmentation as belonging in the transp=
ort layer domain
(22:31:53) dazo: which corresponds to the "socket module" in the diagram
(22:33:26) Yarrick: building query and reply-oriented transports like http =
and dns requires a bit more logic than just tcp/udp, but as long as that is=
 thought of it should be straightforward to add
(22:34:00) dazo: Yarrick: we'll probably pull you more into the design, so =
that we're sure of thinking of this ;-)
(22:34:09) mattock: dazo: +1
(22:34:20) mattock: ;)
(22:34:30) mattock: anything else, anyone?
(22:35:18) mattock: if not, this meeting was pretty quick
(22:35:51) dazo: 1.5hour quick?  ;-)
(22:35:56) dazo: not bad, that's true :)
(22:36:22) mattock: 1:25 is more like it=20
(22:36:43) mattock: anyways, disregard my earlier comment :)
(22:36:54) mattock: ok, unless there are any objections, let's call this a =
day
(22:37:09) ***cron2 waves :)
(22:37:20) ***dazo waves too :)
(22:37:21) mattock: \o/
(22:37:28) dazo: +1
(22:37:30) mattock: I guess that's a wave, too... or an applause
(22:37:34) cron2: (nb: I found out how to build OpenWRT packages, so if one=
 of you wants to build something, let me know9
(22:37:55) cron2: OpenWRT+OpenVPN+feat_payload_ipv6 on company OpenVPN rout=
er now...
(22:38:09) krzee:  /o\
(22:38:11) dazo: cron2: can you send over the package to me!
(22:38:12) dazo: ?
(22:38:13) mattock: jamesyonan, cron2: I'd like to know everything about Op=
enVPN building, so I'll be bugging you during next few weeks :D
(22:38:29) jamesyonan: mattock: sure
(22:38:38) krzee: cron2, that could be interesting to have at /downloads...
(22:38:45) cron2: dazo: the problem with that is that you need to decide on=
 the specific architecture.  I have ar71xx and brcm-2.4 now
(22:38:56) krzee: releasing our own WRT releases... what do you guys think.=
..?
(22:39:05) mattock: cron2: can't you just build it for every platform?
(22:39:07) ***dazo woulkd like it
(22:39:34) dazo: cron2: I got an WRT54GL .... that's brcm-2.4, isn't it?
(22:39:38) mattock: I think we make release for every platform, as long as =
the build can be automated
(22:39:48) cron2: mattock: I'm not sure I understand all of this.  It's bas=
ically "checkout a huge tree of magic make files and subdirectories, run 'm=
ake menuconfig' to tell it "architecture 'X'" and then run make to build de=
velopment tools and packages"
(22:40:22) mattock: cron2: I'm not sure I understand it either, but I soon =
will :)... or fail trying
(22:40:23) cron2: changing architectures seems to require "build new .confi=
g file, re-build everything"
(22:40:46) mattock: I'll know more after doing some research
(22:40:52) cron2: dazo: wrt54gl is brcm-2.4, yes.  http://www.greenie.net/i=
pv6/openvpn.html, links to the two ipk at the end "binary packages"
(22:41:17) dazo: cron2: cool!  Thx!  I'll give it a whirl!   Is it based on=
 -testing.git?  which branch?
(22:41:34) cron2: mattock: for a single platform, it's fairly straightforwa=
rd ("checkout packages, add in extra patches you want, run make")
(22:41:45) cron2: dazo: it's 2.1.1 + ipv6 patch
(22:41:49) cron2: (ipv6 payload)
(22:42:10) dazo: nice!  That's worth testing out :)
(22:42:42) cron2: I have done notes in my own wiki, will clean them up and =
put to openvpn wiki
(22:42:47) cron2: (or mail to list)
(22:43:51) cron2: I hope that mape2k can help here as well, but he's busy t=
hese days
(22:44:30) mattock: cron2: I may be a little optimistic, but that's only be=
cause I don't know enough yet :)
(22:44:38) mattock: let see what happens
(22:44:56) mattock: I'll keep you guys posted=20
(22:44:57) cron2: mattock: there must be ways to run bulk-build for all the=
 OpenWRT platforms - otherwise the OpenWRT folks would not be able to do so.
(22:45:16) krzee: cron2, even if you do put it on mail list, pls also put i=
t on the wiki
(22:45:23) cron2: I have no contacts to these folks, though, so what I did =
was based on googling and experimenting :)
(22:45:24) cron2: krzee: yes
(22:45:25) mattock: krzee: +1
(22:46:02) mattock: cron2: I can contact them when the time comes... howeve=
r, I think I'll have to prioritize by focusing on "basic" packages first
(22:46:08) mattock: including windows (damn)
(22:46:22) cron2: heh :)
(22:47:29) ***dazo calls this a day
(22:47:34) dazo: thx for a good meeting today!
(22:47:38) mattock: dazo: +1... I'll send the summary tomorrow
(22:47:52) mattock: bye guys!
(22:48:05) dazo: see y'all in at least 2 weeks, maybe earlier if weather is=
 bad and Internet connection is good :-P
(22:48:17) mattock: dazo: are you leaving tomorrow?
(22:48:20) cron2: dazo: enjoy your vacation :) (and mind the time zones)
(22:48:33) dazo: yeah, leaving around noon (CEST)
(22:48:45) mattock: have a nice holiday!
(22:48:49) dazo: thx!
(22:48:59) mattock: remember not to spend it entirely on OpenVPN developmen=
t :)
(22:49:05) dazo: hehe
(22:49:23) dazo: my wife would probably kill me before I got too excited :-P
(22:51:08) dazo =EF=BF=BD=EF=BF=BD ora conosciuto come dazo_afk
(22:51:31) krzee: have a good holiday!
(22:53:39) krzee: i love the timing of these meetings
(22:53:45) krzee: they end, i get off work
(22:53:56) krzee: and speaking of which... im outta here!

--------------060008050300040007010506--

