From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <cc8868d4-2b4a-4f95-f0f4-085421f0f241@...515...>
Message-ID: <f251b3e4-0f98-6c92-a4b0-803319686440@...515...>
Date: Wed, 2 May 2018 14:43:28 +0300
MIME-Version: 1.0
In-Reply-To: <cc8868d4-2b4a-4f95-f0f4-085421f0f241@...515...>
Content-Type: multipart/mixed; boundary="------------09C9E9C321CD5257A707760B"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (Wed, 2nd May 2018)
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
--------------09C9E9C321CD5257A707760B
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.
---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 2nd May 2018
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2018-05-02>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock, ordex and syzzer participated in
this meeting.

--

Discussed the obfuscation approach taken by Google's Jigsaw project /
Operator Foundation. The preliminary patches are semi-private, and it
was agreed that they should be modified somewhat before we ask them to
be sent to the mailing list.

Our suggested approach is this:

  - preserve current settings (proto, port, etc)
  - specify --transport-plugin <plugin.so> [params],
    referencing one plugin per connection block
  - plugin needs to be loaded at startup with --plugin
  - 'ops' like approach for required functions (i.e. attached to
    connection block)

--

Had a discussion of the networking API (netlink patchset). The current
WIP API is here:

<https://patchwork.openvpn.net/patch/307>

And how to use it from tun.c:

<https://patchwork.openvpn.net/patch/313/>

Some changes were proposed. Ordex will try to implement them by next
meeting.

--

Full chatlog attached.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock




--------------09C9E9C321CD5257A707760B
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2018-05-02.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2018-05-02.txt"

(10:57:29) ordex: mattock: Topic for #openvpn-meeting: Next meeting on 02=
/May/2018 at 11:30CET. Agenda at https://community.openvpn.net/openvpn/wi=
ki/Topics-2018-05-02
(10:57:31) vpnHelper: Title: Topics-2018-05-02 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:31:19) ordex: aloha :)
(12:31:23) dazo: Hey!
(12:31:34) ordex: aah! I am not alone!
(12:31:42) ordex: mattock: syzzer: cron2 ?
(12:31:48) syzzer: moin :)
(12:31:49) cron2: I'm alway shere
(12:31:52) ordex: :D
(12:32:04) cron2: at least, electronically... whether my brain is engaged=
=2E..
(12:32:07) ***cron2 goes checking
(12:32:10) dazo: cron2 .... the spirit of openvpn :-P
(12:32:14) ordex: :D
(12:32:19) dazo: lurking in the corners of the interwebs
(12:32:53) mattock: hi!
(12:33:19) mattock: start from #1?
(12:33:26) mattock: networking API: discussion and high-level review (net=
link patchset)=20
(12:33:26) ordex: actually, I'd suggest to start from #2
(12:33:28) mattock: ok
(12:33:30) ordex: because it's shorter
(12:33:35) mattock: #2 get feedback for approach taken by obfuscation via=
 plugin (Jigsaw project)=20
(12:33:40) ordex: yeah
(12:33:55) cron2: yeah
(12:34:01) ordex: so basically I went through the patches provided by the=
se guys working for Google, that are implementing a obfuscation API for o=
penvpn2
(12:34:09) cron2: where are they?
(12:34:16) ordex: the patches or the guys?
(12:34:17) ordex: :D
(12:34:22) cron2: (sorry, brain is still missing)
(12:34:24) cron2: patches
(12:34:35) ordex: the patches are those that dazo pointed us to in a priv=
ate email some time ago
(12:34:39) ordex: they have not been sent to the ml yet
(12:34:41) cron2: ah
(12:34:45) ordex: I wanted to provide some early feedback first
(12:35:19) ordex: as I Was saying the code is fairly good already so I wi=
ll tell them to go ahead and send to the ml
(12:35:22) ordex: just one question for you
(12:35:34) ordex: the approach they took is as following (high-level):
(12:35:41) cron2: grumble, can't find the mail.  Anyway: listening
(12:36:02) ordex: Subject: "Fwd: Plugin API for Obfuscation"
(12:36:13) cron2: found it
(12:36:23) cron2: was looking for "mails from dazo".  Mail is from davids=

(12:36:32) dazo: :)
(12:36:41) ordex: - they have extended the plugin API to include calls fo=
r establishing a connection and then "mutate/obfuscate" the traffic
(12:36:56) ordex: the way they tell openvpn about this is by means of a s=
pecial "protocol"
(12:37:05) ordex: so instead of specifying udp or tcp they specify "inter=
cept"
(12:37:13) syzzer: oh, I totally missed that patches were already sent :'=
)
(12:37:20) cron2: syzzer: they weren't
(12:37:21) ordex: syzzer: not sent yet
(12:37:25) cron2: https://github.com/OpenVPN/openvpn/compare/db34435...Op=
eratorFoundation:rtt-working
(12:37:27) vpnHelper: Title: Comparing OpenVPN:db34435...OperatorFoundati=
on:rtt-working =C2=B7 OpenVPN/openvpn =C2=B7 GitHub (at github.com)
(12:37:57) ordex: my question for which I just wanted to get some feedbac=
k from you is about this "intercept" protocol. just wanted to hear is fro=
m an high-level perspective this looks like a reasonable entry point
(12:38:10) ordex: or if a "transport API" should rather have something mo=
re specific
(12:38:21) ordex: s/is/if
(12:38:40) cron2: I do not like the word "intercept".  I can live with "a=
 specific keyword to 'proto' that states 'let the plugin API deal with al=
l the details'"
(12:38:53) cron2: OTOH
(12:39:01) dazo: so ... you need --proto intercept + --plugin which suppo=
rts the hooks to obfuscate?
(12:39:08) ordex: dazo: correct
(12:39:33) cron2: maybe it would be nicer to actually stick to "proto udp=
 1234" and add "--plugin-transport-massacre" to enable the plugin
(12:39:43) dazo: how is udp/tcp protocol defined?  By the plug-in?
(12:39:51) cron2: so the "which protocol, which port" bit would still be =
in the openvpn config (=3D you can find it)
(12:40:00) ordex: dazo: I think so. I think at that point udp/tcp is a pl=
ugin specific knob
(12:40:17) ordex: cron2: so you know what the plugin is actually using?
(12:40:26) ordex: (i.e. for port forwarding/firewall in general)
(12:40:33) dazo: I actually like this approach ... when considering multi=
ple --remote / connection profiles
(12:40:48) dazo: it means it can try to connect without obfuscation and w=
ith obfuscation in the same config
(12:40:52) syzzer: cron2: so what would the "proto udp 1234" in the confi=
g mean when using the plugin
(12:40:55) cron2: ordex: the plugin can be free to ignore me (like, "alwa=
ys connect to some magic wonderbox and hand over credentials")
(12:41:20) cron2: syzzer: it could mean "the remote server is listening o=
n udp 1234, but expects $pluginmagic not standard-openvpn"
(12:41:52) dazo: I would probably prefer to use the keyword "plugin" inst=
ead of "intercept" though ... that gives a clearer semantic
(12:42:05) ordex: dazo: yeah, think so too
(12:42:15) cron2: but if I just do "proto intercept", how do I specify wh=
ere my server is?  If I have more than one?  It would have to be "on the =
plugin line", which there can only be one (so, connection retry / failove=
r to next host / ... logic would need to be in the plugin)
(12:42:16) syzzer: Ah, yes, I think that could make sense. Considering fo=
r example the immensely popular "xor obfuscation"
(12:42:38) cron2: syzzer: right.  That would not even have a "connect()" =
method, just "encap/decap"
(12:42:44) ordex: can plugins parse the config?
(12:42:48) ordex: and have their own set of options?
(12:43:02) cron2: ordex: they have their own set of options on the "plugi=
n ..." line
(12:43:03) dazo: you can pass options to plugins ... via the --plugin=20
(12:43:12) ordex: ah ok
(12:43:32) cron2: what we would need is to pass "all options that are con=
nection-related" to the plugin->connect() method
(12:43:41) cron2: (like, proto, port, v4/v6, proxy, ...)
(12:43:47) ordex: yeah
(12:43:51) syzzer: but that would mean that we'll need to support plugin =
in <connection? blocks...
(12:44:37) cron2: if we go by --plugin cli arguments, yes - and this will=
 be complicated-to-impossible
(12:44:38) dazo: with the --proto intercept/plugin approach .... we would=
 not need to extend <connection/> or multiple --remote lines
(12:45:05) cron2: dazo: the problem with that is "if you want multiple re=
motes, you cannot specify them inside openvpn.conf anymore"
(12:45:43) dazo: yes you can .... --remote server1 1194 udp --remote serv=
er1 11194 intercept
(12:46:22) cron2: dazo: if you have <n-1> without intercept and one with =
intercept, but is that a useful case?
(12:46:41) cron2: like, you want xor plugin.  You have a VPN server provi=
der that offers 20 remotes, all with xor.
(12:46:44) cron2: how do you config that?
(12:46:57) syzzer: cron2: as a get-aroundt-the-gfw fallback, that sounds =
useful
(12:47:25) dazo: right, the plug-in would only support a single set of ob=
fuscation parameters, that's true
(12:47:36) cron2: syzzer: yes, but should we design the API in a way that=
 that's the only way it can handle multiple remotes?
(12:47:43) ordex: i think what cron said earlier is the "simplest" concep=
t: if a plugin implements ->connect(), then we simply pass all the connec=
tion-related options to it. so they come from the standard --lport, --rem=
ote, etc config options
(12:47:44) dazo: but adding support for --plugin within connection blocks=
 .... that's not a trivial task
(12:47:54) cron2: so my idea would be like this:
(12:48:05) cron2: - we keep --proto / --remote / --port as it is
(12:48:23) cron2: - we add an option "--transport-plugin-enable <options>=
"
(12:48:55) cron2: - plugin->connect() gets access to our <connection> opt=
ions plus the <transport-plugin-enable> options
(12:49:08) cron2: and then it can do with it whatever it wants - honour t=
hem, ignore them, mutate them
(12:49:26) cron2: if --transport-plugin-enable is configured, a plugin MU=
ST be loaded that can do, well, transport
(12:49:36) dazo: so --transport-plugin-enable would be given the .so to l=
oad as well?   Or just the arguments to pass to a --plugin ?
(12:49:43) cron2: dazo: you'd do
(12:49:48) cron2: --plugin mymagic.so
(12:49:50) cron2: <connection>
(12:49:55) cron2:   remote vpn.ca 1234
(12:50:02) cron2:   transport-plugin-enable 0x12345
(12:50:04) cron2: <connection>
(12:50:08) cron2:   remote vpn.us 4321
(12:50:13) cron2:   transport-plugin-enable 0x99999
(12:50:15) cron2: </connection>
(12:50:45) ordex: should we consider loading multiple plugins? or not for=
 now?
(12:50:47) cron2: the "0x12345" number here could be "the xor key", or "a=
nything else that makes sense to the transport-plugin in that case
(12:51:18) dazo: multiple --plugin would truly be even more tricky ... yo=
u can do that already, and they would be chained
(12:51:20) cron2: ordex: we'll have to handle that eventually (on the ser=
ver side, you might want a transport plugin and an auth plugin)
(12:51:44) ordex: in constrained environment, it would be needed to try d=
ifferent obfuscations. even though this can be solved with multiple confi=
gs and multiple servers
(12:52:17) cron2: --transport-plugin-enable myxor.so 0x9999
(12:52:25) cron2: --transport-plugin-enable magicgoogleAES.so 0x123452341=
4
(12:52:36) cron2: ?
(12:52:51) ordex: I like that, but this is going to be interesting codewi=
se :D
(12:53:00) cron2: ("force use of a plugin with that name, and pass it <ar=
guments>")
(12:53:07) cron2: ordex: I don't think it will be, tbh
(12:53:22) ordex: oh ok
(12:53:26) ordex: even better :)
(12:53:32) dazo: that's probably a somewhat simpler approach .... doing i=
t via --plugin + --transport-pluing-enable would need a massive rework of=
 the plugin.c code  (it is currently a for() loop looping over the set of=
 feature being requested in the plugin, defined by a "type" mask)
(12:53:32) cron2: if plugins can be chained today (this is how I understa=
nd dazo), we just need to agree on "do I want a single transport plugin, =
or stacked"
(12:54:09) cron2: dazo: I do not want them *loaded* in the --transport-pl=
ugin-enable code, just referenced -- loaded at startup time with the norm=
al --plugin call
(12:54:23) cron2: --transport-plugin-enable mymagic.so=20
(12:54:51) cron2: would then find that plugin in the list, and set up som=
e sort of ->connect(),->encap(),->decap() pointers
(12:55:04) cron2: so we do not need to walk for every packet
(12:55:08) ordex: oh so we'd still need to list multiple --plugin options=
 to load them all?
(12:55:20) cron2: since a plugin can provide other features, yes
(12:55:25) ordex: ok
(12:55:27) cron2: so you ave
(12:55:30) cron2: plugin myauth.so
(12:55:34) cron2: plugin eurephia.so
(12:55:38) cron2: plugin myxor.so
(12:55:42) cron2: plugin googlesAESthingie.so
(12:55:44) cron2: and then
(12:55:48) cron2: <connection>
(12:55:57) cron2:   transport-plugin-enable myxor.so 0x1235
(12:56:00) cron2: <connection>
(12:56:04) cron2: ...
(12:56:18) cron2: "I think this could work, and be easy to see in the con=
fig what is happening"
(12:56:24) dazo: look at plugin.c:814 / plugin_call_ssl() ... this is wha=
t is being called whenever anything in OpenVPN wants to make use of a plu=
g-in
(12:56:24) ordex: yeah
(12:57:00) dazo: then the real call inside the plugin happens via plugin_=
call_item()
(12:57:29) dazo: but the plugin_call_ssl() need to be extended with a "fi=
lter" to only run the selected transport plugin, defined in a connection =
block
(12:58:15) cron2: dazo: or we add something like "plugin_setup_transport(=
)" that would find desired transport plugin and setup "fast calls" for co=
nnect/encap/decap later on
(12:58:48) cron2: but anyway, that is implementation, iff we agree on the=
 approach
(12:58:57) ordex: yeah
(12:59:04) ordex: implementation details can be discussed later
(12:59:08) ordex: when the code is on the ml
(12:59:32) ordex: even though an approach in "ops-style" like suggested b=
y cron2 would not be bad. so the lookup is done only once
(12:59:45) ordex: anyway, do we all like this per-connection/remote appro=
ach?
(12:59:46) dazo: I would actually suggest we provide this feeback back to=
 Operation Foundation, so they can consider all this before submitting to=
 the ML
(13:00:18) cron2: dazo: yes (on "feedback before patches")
(13:00:43) ordex: I think we could directly suggest the "ops-like" approa=
ch, no? but /me is not up-to-date with the entire plugin stack
(13:00:53) dazo: I see the advantage of being able to use different obfus=
cation plugins ... I'm more concerned about the implications it does to t=
he complexity
(13:01:29) cron2: my mental eye sees one extra call per packet ("if c->pl=
ugin.encap_function !=3D NULL ...")
(13:01:35) cron2: and one extra call per function setup
(13:01:42) cron2: all the rest nicely encapsulated away
(13:01:54) cron2: s/function setup/connection setup/
(13:02:00) ordex: cron2: we could force those ops to be non-null at load =
time
(13:02:04) ordex: or we reject the plugin (?)
(13:02:15) cron2: ordex: well, we could be running "with no plugin" :)
(13:02:27) ordex: event though some obfscation plugins may not have all t=
he APIs implemented
(13:02:39) cron2: (we could certainly have the c->encap_function point to=
 "our normal encap function")
(13:02:46) ordex: cron2: well, yeah..in a way or another there must be a =
check
(13:03:03) dazo: right, but we have the struct plugin which keeps a list =
of all plugins ... so the plugin_call_ssl() can then not be used to for t=
raffic obfuscation, it needs a different call ... which should point at t=
he specific plugin for the connection profile
(13:03:36) dazo: so it is kind of duplicating existing plug-in code paths=
 but at the same time it will be somewhat simpler in other aspects
(13:03:52) cron2: "always do function pointers for encap/decap" is certai=
nly the "elegant" way, but it makes the code harder to understand for the=
 normal case... (ran into this when trying to figure out setsockopt() fai=
lures in NetBSD... call chain through 4 or 5 function pointers...)
(13:04:09) cron2: dazo: yes
(13:05:35) dazo: well, plugins depends on function pointers anyhow ;-) ..=
=2E But we should make it as simple as possible
(13:05:40) ordex: cron2: hehe yeah. but if we keep it simple, it should n=
ot get that bad :P
(13:05:46) ordex: yeah
(13:05:54) dazo: Hmmm ... perhaps the connection block could just carry t=
he function pointer?
(13:06:15) dazo: IIRC, connection blocks are used under the hood, even if=
 only a single --remote is configured
(13:06:42) mattock: (12:33:26) ordex: actually, I'd suggest to start from=
 #2 ... because it's shorter
(13:06:43) mattock: :P
(13:06:48) ordex: :P
(13:07:01) ordex: dazo: that's probably how it may work..
(13:07:17) dazo: mattock: Murphy's law in practice ;-)
(13:08:24) ordex: dazo: yeah, connection blocks are used also for one rem=
ote
(13:08:40) ordex: the remote is converted to a connection entry in the po=
st-options-parse thing
(13:09:01) ordex: so some per-connection block field is probably the clea=
nest solution
(13:09:24) ordex: I think I've got enough to get back to them and keep bu=
sy for a while..
(13:09:24) dazo: so if --transport-plugin is defined, it looks up all loa=
ded --plugins and sets the function pointer directly to the obfuscation f=
unction .... this way, there's less CPU cycles wasted when passing data f=
or obfuscation/de-obfuscation
(13:09:38) ordex: yes
(13:09:50) ordex: this is the "ops-like" approach cron2 described before,=
 I think
(13:10:00) dazo: yeah
(13:10:08) dazo: okay, I'm convinced about this approach now :)
(13:10:10) ordex: this is common in the kernel for FS or network devices =
too
(13:10:11) ordex: :D
(13:10:12) ordex: goood!
(13:10:25) ordex: i'll forward our comments to them and see what they thi=
nk about it
(13:11:04) dazo: thx!
(13:11:29) ordex: are we good with #2 ?
(13:11:38) cron2: yep :)
(13:11:39) dazo: yeah
(13:11:47) mattock: ordex: if you could summarize our thoughts for me as =
well
(13:11:50) mattock: for the summary
(13:12:06) ordex: ok
(13:12:09) ordex: let me see
(13:12:11) mattock: thanks!
(13:13:16) ordex: - preserve current settings (proto, port, etc)
(13:13:16) ordex: - specify --transport-plugin <plugin.so> [params], refe=
rencing one plugin per connection block
(13:13:16) ordex: - plugin needs to be loaded at startup with --plugin
(13:13:16) ordex: - 'ops' like approach for required functions (i.e. atta=
ched to connection
(13:13:16) ordex:   block)
(13:13:26) ordex: needs to be reworded and extended :P of course
(13:13:47) ordex: but i think these are the major points we touched, no?
(13:14:03) cron2: dazo: commit 23d61c56b9fd218c39ad151b01b7e2d6690e6093
(13:14:10) cron2:     Always use connection_list, simplifies the reconnec=
tion logic.
(13:14:21) dazo: " referencing one plugin " -> "reference the callback fu=
nction in one plugin per connection block"
(13:14:53) ordex: oky
(13:15:12) dazo: cron2: yeah, I vaguely recalled something like that :)
(13:15:26) cron2: this is why I went looking it up :)
(13:15:33) dazo: :)
(13:16:09) ordex: 15 minutes left for netlink :D
(13:16:13) dazo: :-D
(13:16:28) cron2: ok, which is the most relevant patch you want feedback =
for?
(13:16:39) ordex: I think the networking API per se
(13:16:43) ordex: let me pick it
(13:17:05) ordex: so this is the API I came up with: https://patchwork.op=
envpn.net/patch/307/
(13:17:06) vpnHelper: Title: [Openvpn-devel,1/8] implement platform gener=
ic networking API - Patchwork (at patchwork.openvpn.net)
(13:17:22) ordex: and here it is used for tun.c: https://patchwork.openvp=
n.net/patch/313/
(13:17:24) vpnHelper: Title: [Openvpn-devel,3/8] tun.c: use new networkin=
g API to handle tun interface on Linux - Patchwork (at patchwork.openvpn.=
net)
(13:17:25) cron2: *reading*
(13:17:35) ordex: ok
(13:17:52) ordex: the question is: is this "reasonable" so that we can mo=
ve also the other platforms to this API in the future?
(13:18:02) cron2: this is what I'm looking for :)
(13:18:21) ordex: hehe yeah, I think we all want that. this way we'd clea=
nup tun.c/route.c big time
(13:19:00) cron2: first nitpick: "add an IPv4 address to an interface"
(13:19:11) syzzer: ordex: I don't have much to add to the dicussion, but =
I do want to say that both the netlink and the multisocket stuff is very =
cool!
(13:19:19) cron2: we should be sure that is what we want, "add to whateve=
r is already there" instead of "set address for an interface"
(13:19:35) ordex: syzzer: glad to hear that! :)
(13:20:15) ordex: cron2: if we want to "set", the external layer could do=
 a "flush all addrs on $dev", "ass new $addr"
(13:20:34) ordex: not sure we have a way to flush right now, we could be =
implemented in the current API
(13:21:04) ordex: cron2: your concerns comes from the actual behaviour of=
 "ifconfig" ?
(13:21:11) ordex: because with iproute2 we already do "ip addr add"
(13:21:18) ordex: and this API is basically the same as that
(13:21:50) cron2: it's a bit of "what do we really use?" plus "ifconfig c=
an only do <x>" plus "omg, windows"
(13:22:17) cron2: and what we *use* today is "set".  Calling "ip addr add=
" might just work because a new tun/tap has no address, but technically t=
hat's just coincidence
(13:22:27) ordex: :D
(13:22:30) ordex: nice to know
(13:22:31) dazo: I think supporting "add" instead of just "set" is more f=
uture proof, even though now we can only support a single VPN IP address =
per IP stack
(13:22:54) dazo: today
(13:22:58) cron2: but maybe we want *add*, to give people more rope to ha=
ng themselve :-) (predefined tun interface, with some addresses already t=
here that "MUST NOT BE DELETED!!!")
(13:22:59) ordex: yeah what dazo said. but maybe then we should add a "fl=
ush_addr" API, so that the external logic can make that behaviour clear
(13:23:10) dazo: yeah, that makes sense
(13:23:34) ordex: hmmm
(13:23:44) cron2: so, this is one thing that came to my mind :) - "be cle=
ar on what we want, set or add, and if we want set, make the API support =
that"
(13:23:48) cron2: so, next thing
(13:24:41) cron2: if we use that API as an internal upper half / lower ha=
lf for route.c, tun.c, splitting "net_iface_up()" and "net_addr_v4_add()"=
 will cause extra exec() calls on some of the ifconfig plattforms
(13:24:59) cron2: right now we do "ifconfig tun0 1.2.3.4 up" and be done =
with it
(13:25:04) ordex: yeah, is that a problem?
(13:26:30) cron2: we'd need to test this (if "ifconfig tun0 up" will nice=
ly work everywhere) - I assume it's not a hard problem, I just loathe ext=
ra exec() calls if not needed
(13:26:32) dazo: Or we could also figure out some kernel APIs on those pl=
atforms as well, and migrate to a similar approach there too - having ifc=
onfig as the fallback there
(13:26:57) cron2: dazo: we do not want to find kernel APIs for Solaris, r=
eally not :-)
(13:27:01) ordex: :D
(13:27:19) ordex: but, yeah, we need to make sure it works. buildbot shou=
ld safely check that, no?
(13:27:19) dazo: fair point! :)  I was more thinking about *BSD ;-)
(13:28:04) dazo: (I really wonder how widely OpenVPN is used on Solaris n=
owadays)
(13:28:21) cron2: I would see "kernel packet link APIs" as a non-goal.  I=
f someone really feels like they need this, good, but since part of the r=
eason we want this on linux ("100000 routes" and "non-root, capabilities"=
 ) do not really seem to exist for those plattforms
(13:28:49) cron2: anyway
(13:29:00) cron2: the API will not work on windows in its current form
(13:29:06) ordex: oh ok, why?
(13:29:37) cron2: because you pass in a "const char * iface" but you miss=
 the service pipe handle
(13:29:53) dazo: oh, true
(13:30:07) cron2: (windows passes "give me a route! give me an ifconfig!"=
 via pipe to the iservice daemon)
(13:30:40) ordex: hmmm can't the windows API implementation be the one bu=
ilding what the iservice needs?
(13:30:53) ***ordex has no clue about how this works at the moment
(13:31:32) dazo: hmmm .... well, it's ugly, but the service pipe could be=
 a global variable ... which would only be defined on Windows
(13:31:45) cron2: dazo: no
(13:32:22) ordex: ah
(13:32:28) cron2: I would tend to add an opaque struct pointer to the API=
 calls which they can use to store "things they need" in it
(13:32:31) dazo: the alternative is to have some init() setup ... which c=
onfigures a struct used by this API ... for Linux it would mostly be a NO=
OP
(13:32:35) ordex: this is similar to the env_set problem with iproute
(13:32:41) ordex: we could have an opaque ctx like for ssl
(13:32:47) ordex: yes
(13:32:49) cron2: yes
(13:32:55) ordex: we all said the same thing I believe :D
(13:33:02) dazo: yeah, that's what I mean too
(13:33:07) dazo: ::)
(13:33:23) ordex: that's probably the best, so we hide all the implementa=
tion specific requirements in the opaque ctx
(13:33:37) ordex: or any required state
(13:33:56) cron2: ... and if it turns out we run into a platform that can=
not do "ifconfig tun0 up", we can just have the struct remember "tun want=
s up, but is not yet" and the ifconfig calls can then do that
(13:34:16) dazo: yeah
(13:34:42) ordex: yup
(13:34:56) ordex: this way we can re-use the same ifconfig-implementation=
 for the "broken" platforms
(13:34:58) ordex: sounds good :)
(13:35:13) ordex: I think this is already enough for no
(13:35:14) ordex: w
(13:35:24) ordex: I can restructure the API to include the ctx
(13:35:35) dazo: sounds good to me
(13:35:50) cron2: the net_route_* functions *should* work, though we use =
an interface index on windows, not the name
(13:36:18) cron2: (and since it's not always the same interface, using "i=
nit()" for this won't work)
(13:36:19) ordex: can't thatbe retrieved from the implementation? also ne=
tlink retrieves the ifindex from the name
(13:36:30) cron2: we might not have a name
(13:36:35) ordex: ah
(13:36:47) cron2: like, for the "where is the current ipv6 default gatewa=
y?  so we can add a $host/128 bypass route"
(13:37:06) cron2: I think the "where is the route?" API will spit out an =
ifindex+gateway
(13:37:15) ordex: hmm will check that
(13:37:36) dazo: hmmm ... is that index something we could put into a ctx=
 instead of providing an interface name each time?
(13:37:54) ordex: it's a bit ugly...but we could have some openvpn_iface_=
type_t
(13:38:03) ordex: that gets redefined based on the implementation we choo=
se
(13:38:11) ordex: char * for those using a name
(13:38:16) ordex: or $whatever for windows
(13:38:17) cron2: dazo: "all but one" route will point to the tun/tap int=
erface, and *one* (redirect-gateway) will point elsewhere, which might on=
ly be identified by an index...
(13:38:23) cron2: yeah
(13:38:49) cron2: making "const char *iface" an "openvpn_platform_if_t if=
ace" might make this work
(13:39:02) ordex: yeah some name like that
(13:39:03) dazo: I was thinking an "init ctx" call could do the ifindex l=
ookup and save the needed details needed for each platform
(13:39:44) dazo: if it saves ifindex + a char *, or what it uses later on=
 would be up to the "sitnl" implementation for each platform
(13:39:48) ordex: this means we might need to call the init() everytime w=
e have to work on a different ifname
(13:39:55) cron2: dazo: we have no name
(13:40:05) ordex: that too :P
(13:40:23) ordex: so basically we have no "common type" that we can use i=
n our abstraction
(13:40:26) cron2: (even for the tap interface on windows, we take great c=
are to use the ifindex today :))
(13:40:33) dazo: I was thinking of the "char *iface"
(13:40:34) ordex: we need to redefine the type per implementation..
(13:40:42) dazo: so bad terminology from my side :)
(13:41:14) cron2: ordex: I think most plattforms will be fine with char *=
 iface, as long as we find a way to transport an integer without too much=
 hurt
(13:41:46) dazo: Then openvpn_platform_if_t iface would be a bit cleaner
(13:41:50) ordex: yap
(13:41:54) cron2: yep
(13:42:06) cron2: I was thinking about struct/union, but that just compli=
cates things for everybody
(13:42:23) mattock: I will have to get some lunch now
(13:42:41) mattock: but do not let that stop you from continuing :P
(13:42:44) dazo: mattock: bring your laptop and Internet connection! :-P
(13:42:48) ordex: cron2: well, but where do we use it? if it's for a sing=
le member, better to just redefine the type
(13:42:57) ordex: :D
(13:43:13) ordex: anyway, let's try the openvpn_platform_if_t approach
(13:43:17) cron2: ordex: this *should* have conveyed "... so I do not thi=
nk struct/union is a good idea" :)
(13:43:18) ordex: anyway I can test this on windows?
(13:43:28) ordex: ah :D
(13:43:30) ordex: ok
(13:44:28) cron2: ordex: if you have _init(), you could just experiment w=
ith one of the easy ones (net_route_v6_add())...
(13:44:37) ordex: ok
(13:44:52) ordex: and btw, converting windows is not part of this patchse=
t yet
(13:45:10) ordex: so ensuring it works might come later, even though the =
API should be good enough to not being touched anymore
(13:45:37) cron2: ordex: understood :) - and that's why it was important =
you urged us to review the API today
(13:45:43) cron2: (thanks)
(13:45:44) ordex: yup :)
(13:46:08) ordex: it would be nice if we could rediscuss this next week (=
hopefully with these changes applied by me)
(13:46:15) ordex: but for now i think we are good
(13:46:16) ordex: !
(13:47:40) ordex: anything else we want to mention?
(13:48:04) ***cron2 is a bit exhausted
(13:48:14) ordex: food for everybody then ;P
(13:48:37) syzzer: yeah, food! :D
(13:48:39) cron2: mattock: any news on driver signing?  Or have you avoid=
ed even thinking about that?
(13:48:39) syzzer: :p
(13:49:08) cron2: syzzer: you haven't said *that* much :)
(13:50:42) syzzer: cron2: correct, but I still need food ;-)
(13:50:54) cron2: hrhrh :)
(13:51:11) cron2: syzzer: so how's your busy-level these days?  Haven't s=
een much from you lately
(13:51:21) syzzer: cron2: slowly decreasing :)
(13:51:26) cron2: promising
(13:51:39) dazo: down to 128% ... or something around there? :-P
(13:52:03) syzzer: new team member starting today, so still need to inves=
t time to get everything rolling.
(13:52:26) syzzer: hopefully once the new team members are up-and-running=
, I get time to do other stuff again
(13:52:29) cron2: dazo: only 128%?  Are you neglecting your family, or no=
t sleeping enough? ;)
(13:53:12) dazo: sleeping is overrated
(13:53:24) dazo: ;-)
(14:22:40) mattock: cron2: no progress on the driver signing front - nati=
onal holidays and all that got in the way
(14:22:59) mattock: I will start the via dolorosa soon enough, though

--------------09C9E9C321CD5257A707760B--

