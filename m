From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <8a2c220c-e169-0cb1-c8b4-3c8af5fab82a@...515...>
Message-ID: <c573880b-af3b-0876-d00f-70e7a06c69fa@...515...>
Date: Wed, 21 Mar 2018 13:45:04 +0200
MIME-Version: 1.0
In-Reply-To: <8a2c220c-e169-0cb1-c8b4-3c8af5fab82a@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="n0eWHlHrlf3aZrZrZxj92KeeT8EXJszUZ"
Subject: [Openvpn-devel] Summary of the community meeting (Wed,
 21st Mar 2018)
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
--n0eWHlHrlf3aZrZrZxj92KeeT8EXJszUZ
Content-Type: multipart/mixed; boundary="6GCKguj2iC9XYFdmeWmoeE3uPlkm2zDam";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <c573880b-af3b-0876-d00f-70e7a06c69fa@...515...>
Subject: Summary of the community meeting (Wed, 21st Mar 2018)
References: <8a2c220c-e169-0cb1-c8b4-3c8af5fab82a@...515...>
In-Reply-To: <8a2c220c-e169-0cb1-c8b4-3c8af5fab82a@...515...>

--6GCKguj2iC9XYFdmeWmoeE3uPlkm2zDam
Content-Type: multipart/mixed;
 boundary="------------0678D4544F5303F0CA57CD70"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------0678D4544F5303F0CA57CD70
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.
---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 21st Mar 2018
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2018-03-21>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, janjust, mattock, ordex and syzzer participated in
this meeting.

--

Janjust initialized the meeting with virtual group hug.

--

Discussed the security issue in tap-windows6 reported to the security
mailing list. While the issue is not critical it needs to be fixed.
Mattock will produce an installer with the fix. Cron2 will compare
unfixed and fixed versions to verify that the problem is gone. Dazo will
get us a CVE for the problem. Once this is done we will release new
Windows installers for OpenVPN 2.4.5.

--

Discussed "multi-port/multi-ip listening support: config format". The
format agreed upon in the meeting was this:

  local IP [port] [proto]

Where IP can be an IPv4 address, and IPv6 address, or * which means
dual-stack IPv4/IPv6. Proto can be either udp or tcp; the udp6 and tcp6
variants are not needed as they can be deduced from the IP address.

Note that on OpenBSD "local *" will bind to IPv6 addresses only. This is
because v4-mapped v6 sockets are not available on that platform.

--

Discussed Viscosity's patches to OpenVPN and their tap-windows adapter.
According to janjust Viscosity's tap-windows6 adapter performs
significantly better than our tap-windows6 adapter. Agreed that we
should first verify that they're using tap-windows6 and not something
they wrote themselves. If yes, we should check if their source code is
available. And if not, we should ask them to publish it according
GPLv2's requirements.

Janjust will do more testing with Viscosity's driver and report the
results to mattock who will start bugging Viscosity as necessary.

--

Discussed the "netlink support: quick roadmap recap" topic. Previously
we have agreed on providing unit tests to check the output of netlink
with what is expected from using ip/route/ifconfig. Agreed that we
should have unit tests in place at merge time. Otherwise we fear the
unit tests will never arrive.

Also agreed that we should try to provide testing Debian/Ubuntu package
for this. While that is doable right now, it requires manual work. It
would thus make more sense to automate the package creation process.

--

Dazo informed that OpenVPN 3 developers will start using openvpn-devel
for their patches. We will need to figure out how to make patchwork
detech whether a patch belongs to openvpn2 or openvpn3.

---

Full chatlog attached.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------0678D4544F5303F0CA57CD70
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2018-03-21.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2018-03-21.txt"

(12:31:27) dazo: hey!
(12:31:36) janjust: hi dazo
(12:31:50) dazo: nice that you could join, janjust :)
(12:32:23) ordex: hi!
(12:32:43) janjust: just don't get used to it, dazo ;)
(12:32:48) dazo: hehehe ;-)
(12:32:49) ordex: syzzer: here too?
(12:32:52) ordex: mattock: ?
(12:33:06) dazo: janjust: nah, that wouldn't make it so special!  We need=
 to protect this special feeling ;-)
(12:33:14) janjust: lol
(12:33:14) mattock: good day
(12:33:20) ordex: we have some topics pending from last week that we did =
not really go through (nothing major I think): https://community.openvpn.=
net/openvpn/wiki/Topics-2018-03-14
(12:33:21) vpnHelper: Title: Topics-2018-03-14 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:33:22) cron2: grouphugs!
(12:33:26) ordex: :D
(12:33:30) ***janjust hugs cron2
(12:33:30) dazo: lol
(12:33:49) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
8-03-21
(12:33:51) vpnHelper: Title: Topics-2018-03-21 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:33:54) mattock: enough hugging already :D
(12:34:02) ***janjust hugs mattock=20
(12:34:04) janjust: :P
(12:34:08) mattock: oh that was so nice :D
(12:34:10) ***dazo had to check which channel he joined
(12:34:13) cron2: ordex: can you just move over the agenda items from -14=
 to -21?
(12:34:22) ordex: yup
(12:34:26) cron2: (so we have *one* agenda to work, and put stuff to -28 =
then)
(12:35:12) ordex: done, refresh
(12:35:18) ***syzzer here now
(12:35:21) syzzer: sorry for the delay
(12:35:26) syzzer: reading backlog...
(12:35:30) dazo: btw ... There's one more topic regarding openvpn 3 devel=
opment which needs to be added .... mostly FYI on what's happening
(12:35:30) cron2: pretty full agenda now :-)
(12:35:36) ordex: it's mostly about hugs, syzzer=20
(12:35:37) ordex: :P
(12:35:41) cron2: syzzer: except lots of enjoyment, nothing missed :)
(12:35:44) mattock: dazo: sounds good
(12:35:48) janjust: yeah... I'm pretty interested in the tap-win part for=
 today
(12:35:57) janjust: need a hug , syzzer ?
(12:36:08) syzzer: always :D
(12:36:28) cron2: *hugs*
(12:36:34) syzzer: \o/
(12:36:43) ordex: lol
(12:36:45) janjust: let's rename this channel to #openvpn-grouphug
(12:37:11) mattock: let's hug tap-windows6 for a while
(12:37:15) dazo: +1
(12:37:17) dazo: :-D
(12:37:38) mattock: so a problem was reported to security list
(12:37:46) janjust: good plan; I have a "tangent" question on it (later)
(12:37:48) mattock: not critical but needs to be fixed
(12:37:58) mattock: we have a patch from cron2, but afaik it has not gott=
en any review
(12:38:02) mattock: correct?
(12:38:17) cron2: mattock: correct.  You wanted to build a test installer=
 with it :)
(12:38:30) cron2: I don't even know if it compiles, but it "looks reasona=
ble"
(12:39:16) mattock: ah yes
(12:39:23) mattock: I was waiting for a formal review :)
(12:39:25) mattock: then build
(12:39:29) syzzer: hm, I should really fire up my tap-windows build env a=
gain too
(12:39:29) mattock: but we can reverse that
(12:39:47) cron2: is there documentation how to build tap-windows/tap-win=
dows6?
(12:40:24) dazo: 1. Ask mattock
(12:40:25) dazo: 2. Profit
(12:40:56) mattock: cron2: yes, check the tap-windows6 repo in GitHub
(12:41:01) mattock: the instructions are fairly thorough
(12:41:11) cron2: the "how to build windows snapshots" installation is ni=
ce (just to mention it) :)
(12:42:09) mattock: cron2: you will need to play some tricks to use a pre=
-built tapinstall.exe (haven't been able to build it in years)
(12:42:09) cron2: well... the instructions are not dummy-level enough for=
 me... "you need python 2.7, windows 7 wdk, windows code signing certific=
ate, git".  So, yes, and how do I get those? :)
(12:42:24) mattock: well you don't need the code signing certificate
(12:42:34) cron2: it says "required"... :)
(12:42:44) mattock: I suggest "python windows", "git windows" for starter=
s :)
(12:42:51) mattock: those will lead you to correct page
(12:42:52) mattock: s
(12:43:17) ordex: mattock: does tap-windows need to be re-signed with som=
e special key that is accepted by Windows everytime?
(12:43:20) cron2: yeah, but anyway, like "Win 7 WDK" - does that mean "it=
 has to be a windows 7 machine" or "the WDK has a version number, 7.x", .=
=2E.
(12:43:24) cron2: ordex: yes
(12:43:28) ordex: k
(12:43:40) mattock: cron2: I build on Windows 2012r2 so no
(12:43:43) cron2: (you can tell windows to ignore driver signing requirem=
ents, but that is not a generally good idea)
(12:44:02) mattock: lemme check the WDK verison
(12:44:03) mattock: version
(12:44:06) cron2: ((and it's a boot-time selection...))
(12:44:33) ordex: (I see, so it has to be signed every time - ok)
(12:44:43) mattock: WinDDK 7600 is supposed to work
(12:44:46) syzzer: cron2: you can build on newer windows
(12:44:47) cron2: while a major PITA, it's generally speaking a good idea=

(12:44:54) mattock: how to get it: don't know
(12:45:10) syzzer: probably even with newer WDK - there is some compat ve=
rsion thingy defined somewhere iirc...
(12:45:16) mattock: download a version of WinDDK for your OS and hope it =
is not too recent
(12:45:17) cron2: I see me send a PR with "for dummies, click here, click=
 there" :-)
(12:45:32) mattock: cron2: I will gladly merge that kind of PR
(12:45:37) cron2: anyway: next steps - test installer or review?
(12:45:38) janjust: https://www.microsoft.com/en-us/download/details.aspx=
?id=3D11800
(12:45:39) vpnHelper: Title: Download Windows Driver Kit Version 7.1.0 fr=
om Official Microsoft Download Center (at www.microsoft.com)
(12:46:09) janjust: https://tortoisegit.org/download/
(12:46:12) vpnHelper: Title: Download =E2=80=93 TortoiseGit =E2=80=93 Win=
dows Shell Interface to Git (at tortoisegit.org)
(12:46:21) mattock: janjust: that WinDDK link looks promising
(12:46:27) mattock: 7600 in the ISO filename and all
(12:46:50) janjust: https://www.python.org/downloads/release/python-2714/=

(12:46:52) vpnHelper: Title: Python Release Python 2.7.14 | Python.org (a=
t www.python.org)
(12:46:55) cron2: 7.1.0 has 7600 in the filename.  Yay :)
(12:47:14) cron2: janjust: thanks - I'll do the searching and testing and=
 send mattock a PR
(12:48:44) mattock: I can build a new tap-windows6 installer later today
(12:49:00) mattock: I happened to test the build system a few weeks ago a=
nd it was not horribly broken
(12:49:12) mattock: then we can do the code review
(12:49:26) mattock: then make an installer release for 2.4.5
(12:49:35) cron2: cool.  Then I can clone a VM and try to generate a "bad=
 packet" and see if I can actually break the old tap driver, and see if t=
hat does not break anymore afterwards (and nothing else breaks)
(12:49:44) cron2: dazo: can you get us the CVE?
(12:50:13) dazo: cron2: sure! ... Now I might even be able to do it direc=
tly with MITRE as well
(12:50:24) cron2: good :)
(12:53:02) dazo: I might need some help to draft the contents of the vuln=
erability, but will let you know when I've prepared a draft
(12:53:11) cron2: ack
(12:53:55) syzzer: sounds good
(12:54:05) dazo: mattock: [off-topic]=C2=A0.... would it be possible and =
a good idea to get a openvpn community etherpad, restricted with LDAP aut=
h from community LDAP?
(12:54:16) cron2: yes
(12:54:22) dazo: would be a better place to collaborate on such security =
notes
(12:54:29) mattock: dazo: definitely (next month, too busy this month)
(12:54:35) dazo: sure
(12:54:40) mattock: I will add a ticket for myself
(12:54:43) dazo: thx!
(12:55:17) dazo: next topic?
(12:55:23) mattock: +1
(12:55:33) mattock: "Security list GPG key expiry policies"
(12:55:40) cron2: mattock: reload :)
(12:55:40) mattock: something we touched briefly elsewhere
(12:55:56) mattock: oh some nasty person added stuff there :P
(12:55:57) mattock: ok
(12:55:59) ordex: :P
(12:56:01) mattock: topic #1
(12:56:09) ordex: but we can finish the gpg thing first if we want
(12:56:13) mattock: =E2=80=8Bhttps://patchwork.openvpn.net/patch/263/
(12:56:14) cron2: we skip that one, I'd say, since it's plaisthos'
(12:56:15) vpnHelper: Title: [Openvpn-devel,v2] Rework OpenVPN auth-token=
 support - Patchwork (at patchwork.openvpn.net)
(12:56:17) ordex: plaisthos: is not here apparently - he "owns" topic #1
(12:56:19) ordex: yeah
(12:56:22) mattock: next then
(12:56:28) cron2: ordex: yours
(12:56:31) mattock: multi-port/multi-ip listening support: config format =

(12:56:34) ordex: yeah
(12:56:49) ordex: I just wanted to quickly hear your opinion about how to=
 re-arrange the config options once introducing the multiport feature
(12:57:01) ordex: basically a server will be able to listen on multiple p=
orts
(12:57:13) ordex: so it will be possible to define "port xxx" multiple ti=
mes with different xxx each time
(12:57:16) cron2: my thoughts on that: while apache generally stinks, the=
 "Listen" directive from there ("Listen <port>" or "Listen <ip>:<port>") =
generally seems to be easy to understand
(12:57:35) ordex: mh yeah that's a good idea
(12:57:50) cron2: what we have now with "bind", "port", "lport" is confus=
ing at best - but if you all tell me "multiple lport statements are good"=
, fine with me :)
(12:58:22) ordex: well multiple lport is equivalent to multiple Listen <p=
ort> no ?
(12:58:30) cron2: ye
(12:58:31) cron2: s
(12:58:41) ordex: the problem is: if we have multiple IPs to listen to, a=
nd 2 ports
(12:58:48) ordex: does the user need to list all the combinations ?
(12:59:02) ordex: Listen ip1:port1 Listen ip1:port2, etcc
(12:59:20) cron2: the socket API needs this explicitly
(12:59:37) ordex: sure, but the config does not need to be 1:1 with the A=
PI :P it's for people after all
(12:59:44) cron2: you can either bind *:port or *-v4:port or *-v6:port or=
 "one fixed IP":port
(12:59:50) cron2: understood
(13:00:35) cron2: so you'd prose to do multiple "local" and "lport" state=
ments, and then combine them?
(13:00:38) cron2: local 1.2.3.4
(13:00:44) cron2: local 2001:db8::5
(13:00:49) cron2: lport 80 udp
(13:00:51) cron2: lport 443 tcp
(13:00:52) cron2: ?
(13:00:54) ordex: right
(13:00:57) ordex: this is one way
(13:01:02) ordex: even though I am not fully convinced
(13:01:15) ordex: probably the listen ip:port is just simpler to understa=
nd and avoid ambiguity
(13:01:20) cron2: we need to expand "lport" in any case to add udp/tcp
(13:01:26) ordex: yap
(13:02:05) dazo: I'm wondering of "Listen" + "lport" will confuse users e=
ven more though .... as they essentially do almost the same .... the diff=
erence though, lport can also be used on client side as well
(13:02:31) dazo: but the "listen" semantic is simpler
(13:03:10) ordex: we can still support "lport" but document the clear map=
ping in behaviour. i.e. if you specify lport X, this is just an alias for=
 "listen :X" check --listen in manpage
(13:03:13) cron2: if you want to do stuff like "listen on 1.2.3.4:80 and =
4.5.6.7:443", you cannot specify this with two individual options
(13:03:15) dazo: since we have --remote which can be used multiple times,=
 and have support for ports and protocols ... wouldn't it be better to ha=
ve the same syntax approach for 'local' instead?
(13:03:22) ordex: cron2: right
(13:03:35) cron2: I would not mind extending local into "local $ip:$port =
$proto"
(13:03:36) dazo: cron2: yeah
(13:03:41) cron2: does not have to be called "listen"
(13:03:56) ordex: listen is good because it does not exist for now :D and=
 matches other server configs
(13:03:59) dazo: I think that's a better approach ... no new option, just=
 a natural expansion
(13:04:03) cron2: lol
(13:04:12) ordex: ah "local"
(13:04:14) ordex: sorry I misread
(13:04:15) dazo: yeah
(13:04:22) cron2: you do agree beforehand on who agrees and who disagrees=
, simultaneously, do you?
(13:04:26) ordex: hmmm but we have to keep it backward compatible
(13:04:28) dazo: :-P
(13:04:36) dazo: IRC latency is tricky some times :-P
(13:04:49) dazo: ordex: yeah
(13:05:07) ordex: so if somebody specifies "local ip:port proto" and *als=
o* lport we trigger an error?
(13:05:08) dazo: ordex: but lets aim for the same argument order as --rem=
ote
(13:05:21) dazo:        --remote host [port] [proto]
(13:05:31) cron2: works for me
(13:05:40) ordex: the error or the order?
(13:05:40) dazo: so for --local, it would be   --local IP [port]=C2=A0[pr=
oto]
(13:06:02) ordex: --local IP [port]=C2=A0[proto] << sounds good
(13:06:21) cron2: dazo: how to specify "I do not care about the IP addres=
s (=3DANY) but I want 1194/udp + 443/tcp"?
(13:06:27) cron2: local * 1194 udp
(13:06:31) cron2: local * 443 tcp
(13:06:31) cron2: ?
(13:06:33) dazo: I was just pondering on that ..... 0.0.0.0 as IP?
(13:06:40) dazo: oh ipv5
(13:06:42) dazo: ipv6*
(13:06:45) ordex: yeah
(13:06:46) cron2: that is legacy IP only, which you might want, or not
(13:06:47) dazo: yeah *
(13:06:51) ordex: * is better
(13:06:54) dazo: agreed
(13:07:08) cron2: so 0.0.0.0 is "any v4", :: is "any v6", * is "do a dual=
-stack v6 socket"
(13:07:09) dazo: * or ANY ... I don't care :)
(13:07:20) dazo: agreed
(13:07:25) ordex: cron2: waitttttt don't let new features sneak in :P
(13:07:26) mattock: that sounds reasonable
(13:07:33) dazo: :-P
(13:07:38) ***cron2 sees an incoming patch from ordex with "we do DNS res=
olution on this" with a special case for "ANY" :)
(13:07:44) ordex: LOL
(13:07:45) cron2: ordex: mmmh?
(13:07:45) mattock: many daemons do 0.0.0.0 / :: / * thingy
(13:08:06) ordex: cron2: the dual socket thing is currently not addressed=
 by all this
(13:08:20) ordex: this reminds me: protocol udp6/4 are not required anymo=
re then ?
(13:08:30) ordex: because 0.0.0.0 will imply udp/tcp4 ?
(13:08:31) cron2: ordex: it actually is - if you throw 0.0.0.0 or :: at g=
etaddrinfo(), you get back "v4" or "v6" ANY chunks
(13:08:39) ordex: yeah true
(13:09:07) ordex: it's the * case that is not well defined (unless you me=
ant that openvpn will open two sockets)
(13:09:12) cron2: ordex: indeed, if you do multi-socket, the old "proto" =
thing is not generic enough - so it would still be there for single-socke=
t, and maybe lport/proto should trigger an error if multiple "local" are =
there
(13:09:33) ordex: ok
(13:09:37) dazo: yeah, that makes sense ... multiple local with lport/pro=
to should bail out
(13:09:39) cron2: ordex: well, "*" could mean what "bind !ipv6only" does =
today: do a v6-socket with dual-stacking enabled
(13:09:40) ordex: so if proto exist -> allow only 1 local
(13:09:52) ordex: cron2: that works on every platform?
(13:09:54) dazo: yeah
(13:10:15) cron2: ot works on everything but OpenBSD (who removed v4-mapp=
ed v6 sockets)
(13:10:24) dazo: hmmm .... server side, that should be how it is today ..=
=2E. client side ... might be different
(13:10:36) cron2: but "just do two binds with v6only=3D1" might be more e=
xplicit plus also OpenBSD-portable
(13:11:02) ordex: yap
(13:11:13) cron2: dazo: client side *if you do not bind* is basically "we=
 do not need to care".  If the client wants to bind to multiple addresses=
, things will be interesting, but we can just disallow it
(13:11:32) ***cron2 tends to "show me a good use case for a multi-bind cl=
ient"
(13:11:34) dazo: yeah, agreed ... I think that makes sense, at least for =
now
(13:11:42) ordex: client and multiple addresses? guys please, no smoking =
:D
(13:11:46) ordex: hehe
(13:11:47) ordex: yeah
(13:11:55) dazo: We just need to tackle users doing that without explodin=
g ;-)
(13:12:04) mattock: :P
(13:12:16) ordex: < cron2> but "just do two binds with v6only=3D1" might =
be more explicit plus also OpenBSD-portable << cron2 so this means 2 sock=
ets, one bound to 0.0.0.0 and one to :: ?
(13:12:17) cron2: ordex: someone, somewhere will have a setup that would =
benefit from it :-) - and then do load-sharing between both sockets
(13:12:19) dazo: and failing with a M_FATAL when users try to do that is =
very fine for me
(13:12:21) mattock: if it explodes we will get email to openvpn-devel lis=
t sooner or later
(13:12:21) ordex: (or with v6only)
(13:12:59) cron2: ordex: wrt "one or two sockets", I do not care much eit=
her way - both works everywhere but OpenBSD, and on OpenBSD one could alw=
ays do "local 0.0.0.0 1194" + "local :: 1194"
(13:13:19) ordex: cron2: right
(13:13:26) dazo: mattock: uncontrolled explosions are bad - they might tr=
igger security issues ... failing controlled (like M_FATAL) is a controll=
ed behaviour with not risks
(13:13:43) dazo: s/not /no /
(13:13:47) mattock: I was not implying that we should blow up thing in un=
controlled fashion :)
(13:13:53) dazo: :)
(13:14:06) mattock: just that somebody _will_ complain if we break a high=
ly esoteric use-case
(13:14:14) cron2: always
(13:14:24) ordex: do we agree that "local" will support only udp/tcp (wit=
hout any 6 or 4 at the end)
(13:14:26) ordex: ?
(13:14:28) dazo: as long as it is documented, we can do the RTFM
(13:14:34) cron2: 5 years later, in CAPITAL LETTERS, in trac :)
(13:14:39) ordex: lol
(13:14:51) cron2: ordex: yes, because 4/6 is explicit from the address
(13:14:55) dazo: ordex: yeah, that makes sense to me .... IPv4/IPv6 is gi=
ven by the IP address
(13:15:01) cron2: first!
(13:15:10) dazo: heh :-D
(13:16:03) ordex: good
(13:16:08) ordex: :)
(13:16:34) ordex: i think this closes the topic. it seems we pretty much =
covered all the cases for the next 10 years
(13:16:46) cron2: .oO(what about sctp...)
(13:16:51) ***cron2 hides
(13:16:54) dazo: heh
(13:16:58) cron2: and no, it does not make sense
(13:17:08) janjust: you forget openvpn-over-icmp ;)
(13:17:11) ordex: we might have other protocols coming from plugin
(13:17:18) ordex: but those might need to be "registered" somehow
(13:17:18) ordex: :P
(13:17:25) dazo: but that's tackled by the plugins ;-)
(13:17:29) ordex: yeah
(13:17:56) janjust: before this meeting is closed I have a question on ta=
p-windows and the windows version of Viscosity
(13:18:31) cron2: go ahead :)
(13:19:04) janjust: I've got access to the win version of viscosity; it s=
eems those guys patched openvpn itself and even provide their own tap ada=
pter
(13:19:18) janjust: that adapter performs *BETTER* than the tap-win adapt=
er
(13:19:28) mattock: hmm
(13:19:31) dazo: hmmmm
(13:19:36) janjust: question is: has anyone else seen this?  question 2: =
 should we go "after them" to release their patches?
(13:19:41) mattock: we need to check if they version's code is available =
somewhere
(13:19:46) mattock: no and yes
(13:20:07) mattock: what is the performance difference?
(13:20:10) dazo: first we need to dissect it, to see if it is plausible i=
t contains tap-windows code
(13:20:31) ordex: but they should definitely publish the openvpn changes,=
 I think
(13:20:36) dazo: they could have written something from scratch ... "whit=
e reverse engineered" or something like that
(13:20:41) mattock: yes, and also tap-windows6 changes as both are GPLv2
(13:20:46) cron2: janjust: is that adapter compatible with us?  So, if vi=
scosity is installed, and you fire up openvpn.exe, what does it see?
(13:21:09) cron2: (and of course, publish changes to GPLed code)
(13:21:11) janjust: hmm I haven't tested that, cron2, will do so after th=
is meeting (I need to reboot into win7)
(13:21:58) janjust:  but AFAICT viscosity uses a patched version of openv=
pn.exe so I wouldn't be surprised if you can mix&match
(13:23:11) mattock: I can start bugging them for their changes once we ha=
ve more info
(13:23:22) janjust: alright, I will send feedback to you mattock=20
(13:23:26) mattock: thanks!
(13:23:58) mattock: next topic?
(13:24:04) mattock: 54 minutes in
(13:24:15) ordex: quickie about netlink?
(13:24:16) cron2: netlink: quick recap, 5 minutes?
(13:24:19) cron2: :)
(13:24:20) ordex: yeah
(13:24:20) mattock: sounds good
(13:24:21) dazo: https://www.sparklabs.com/blog/ ... They definitely use =
openvpn 2.x
(13:24:23) vpnHelper: Title: Blog - SparkLabs (at www.sparklabs.com)
(13:24:30) mattock: yeah they do
(13:24:38) mattock: and they did use tap-windows6 in the past at least
(13:24:52) mattock: they actually reported a bug in it, maybe even provid=
ed a patch early on
(13:24:55) ordex: we should definitely ask to publish the patches
(13:25:18) mattock: yep, I've done that in the past with them and they've=
 been responsive
(13:25:37) mattock: anyhow, netlink
(13:25:41) ordex: ok
(13:25:48) ordex: so the code has been used by a couple of users so far f=
or quite some time
(13:25:54) ordex: and it seems to work[tm]
(13:26:15) ordex: we agreed on providing unit tests to check the output o=
f netlink with what is expected from using ip/route/ifconfig
(13:26:24) ordex: now, the unit tests are not there yet and may require q=
uite some time
(13:26:39) ordex: however, how about we move on and try to review/merge t=
he netlink code already?
(13:26:43) ordex: so people testing master can get it ?
(13:26:51) dazo: I'll create a Fedora Copr repo for Fedora/RHEL environme=
nts ... I'll use that for testing in my servers at least
(13:26:52) ordex: unit-tests are expected to come before the release
(13:27:07) cron2: unit-tests are expected to come together with merging
(13:27:12) ordex: :D
(13:27:18) ordex: I tried!
(13:27:19) cron2: (otherwise unit-tests will never arrive...)
(13:27:20) mattock: cron2: +1
(13:27:32) ordex: yeah, I have to say you're right :P
(13:27:34) cron2: I've done too much software development :-)
(13:27:37) dazo: :)
(13:27:44) ordex: ok, so I'll publish the patches to the ml
(13:27:55) cron2: but looking at the stuff for a first round of feedback =
is certainly a good idea
(13:27:56) ordex: and hopefully I'll run them through buildbot, now that =
mattock has pointed it to the other repo
(13:28:17) ordex: ok. then work on the unit tests
(13:28:19) ordex: good!
(13:28:25) dazo: cool, and I'll use them for the Copr repo .... mattock, =
can we have a separate openvpn-netlink repo for testing for Deb/Ubu?
(13:28:25) ordex: I'll send them soon then
(13:28:39) cron2: we need to work on the patch queue already out there :-=
( - because the more patches are pending, the more merge clashes we end u=
p with
(13:28:40) mattock: hmm
(13:28:46) ordex: yeah :/
(13:28:47) mattock: technically yes
(13:28:56) ***ordex will work on tls-crypt-v2
(13:29:19) dazo: mattock: perhaps we should try to make something automat=
ed .... would benefit openvpn3 too
(13:29:34) mattock: dazo: I fully agree, but time is a scarse resource
(13:29:39) dazo: yeah, I know
(13:29:49) mattock: I would like to just take a commit and push out vario=
us "things" built from that commit
(13:29:49) syzzer: whee, my build bot claims to have built both tap-windo=
ws and tap-windows6 :)
(13:29:50) ordex: mattock: dazo: we could create a new openvpn-testing re=
po and have packages in there built from different branches? (only some)
(13:30:03) dazo: yeah, that's my thought
(13:30:04) cron2: mattock: so to be sure I understand the setup - the bui=
ldslaves are fetching from your new repo on "build" now, and "we" can all=
 push to branches there?
(13:30:13) mattock: cron2: that is correct
(13:30:14) syzzer: ordex: oh, I should do that too...
(13:30:16) cron2: ("we" being "people that have mailed you their ssh key =
and are trusted")
(13:30:24) mattock: and have VPN access
(13:30:27) mattock: so double trusted
(13:30:32) cron2: build is not in vpn
(13:30:35) dazo: btw ... openvpn3 development ... quick words here .... w=
e're going to start pushing openvpn3 patches to the public mailing list i=
n not too far future
(13:30:40) mattock: oh yes, it is also accessible without VPN
(13:30:45) mattock: I can definitely fix that though :P
(13:30:50) cron2: ah, "click on buildmaster", that needs VPN
(13:30:51) ordex: (even via ipv6!)
(13:30:53) cron2: no, the other part is good
(13:31:10) mattock: ok
(13:31:15) dazo: We will have done internal review on those patches comin=
g from @openvpn.net addresses .... so they should all carry a "Approved-b=
y:" line in the commit messages
(13:31:41) cron2: dazo: I'm curious how that is going to work out with pa=
tchwork :-)
(13:32:05) dazo: so they will be pushed to the git repo directly .... but=
 copies patches to the ML for distributed archive purpose
(13:32:35) dazo: cron2: that's going to be interesting as well ... we mig=
ht need to "tag" openvpn3 patches differently, as patchwork has this "pro=
ject" reference
(13:32:53) ordex: i think one project =3D one mailing list ?
(13:32:54) cron2: something like that would be good, otherwise the "openv=
pn2" view would be confusing
(13:33:10) dazo: but I'd like to see these patches arrive in patchwork to=
o ... but under a different project
(13:33:40) dazo: it might be a little bit noise in the beginning as we fi=
gure out these details ... the intention is not to make things worse than=
 it is :)
(13:33:40) cron2: +1
(13:33:41) mattock: yeah, definitely have 1:1 mapping between a project a=
nd a mailing list
(13:33:54) mattock: patchwork can filter the emails, but I think that get=
s tricky
(13:34:12) cron2: I need to leave this discussion now, as $wife is biting=
 other people already - time for lunch
(13:34:14) dazo: mattock: lets see how we can tackle this filtering
(13:34:15) mattock: it needs to have a clue as to where a patch belongs t=
o
(13:34:25) mattock: let's stop here
(13:34:28) mattock: I need to eat also
(13:34:28) ordex: oky
(13:34:32) ***ordex too
(13:34:39) ordex: and the laptop does not taste good today
(13:34:46) ***syzzer too, before the canteen closes (which is about now :=
p )
(13:34:50) ordex: :D
(13:34:52) dazo: we discussed briefly earlier to have separate mailing li=
sts for openvpn2 and openvpn3 ... but consensus was to have a unified one=
 .... okay, lets eat :)
(13:34:52) ordex: run!
(13:35:05) mattock: ok bye guys!
(13:35:07) ordex: bye!
(13:35:11) syzzer: bye! :)
(13:35:15) mattock: let me know if this is accurate:
(13:35:16) janjust: hehe , bye everyone
(13:35:18) mattock: iscussed "multi-port/multi-ip listening support: conf=
ig format". The format agreed upon in the meeting was this:
(13:35:18) mattock:   local IP [port] [proto]
(13:35:18) mattock: Where IP can be an IPv4 address, and IPv6 address, or=
 * which means dual-stack IPv6. Proto can be either udp or tcp; the udp6 =
and tcp6 variants are not needed as they can be deduced from the IP addre=
ss.
(13:35:46) dazo: " which means dual-stack IPv6" --> " which means dual-st=
ack IPv4/IPv6"
(13:35:55) mattock: ah yes
(13:36:18) ordex: yap
(13:36:25) dazo: yeah, that's a good summary
(13:36:27) mattock: will openbsd just break if "local *" is defined?
(13:36:36) mattock: that would worthy of mention
(13:36:43) ordex: nope, it will do the same as today with udp6
(13:36:47) ordex: which is not really dual-stack
(13:36:47) mattock: ok
(13:36:53) mattock: so IPv6 only
(13:36:59) ordex: yap
(13:37:01) mattock: ok
(13:37:14) ordex: we can have some define in the code to error out and su=
ggest to use 2 local statements
(13:37:20) dazo: that could be improved later on though, to actually do d=
ual sockets on OpenBSD ... but that's for later
(13:37:27) ordex: right
(13:38:41) janjust ha abbandonato la stanza (quit: Quit: Leaving).

--------------0678D4544F5303F0CA57CD70
Content-Type: application/pgp-keys;
 name="0x40864578.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0x40864578.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
XuwT7RpGDZ6jBfphYQ=3D=3D
=3DNnZq
-----END PGP PUBLIC KEY BLOCK-----

--------------0678D4544F5303F0CA57CD70--

--6GCKguj2iC9XYFdmeWmoeE3uPlkm2zDam--

--n0eWHlHrlf3aZrZrZxj92KeeT8EXJszUZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlqyRcYACgkQKVhNn0CG
RXiboQgAq7MfxhrFdHIwLgFtH+efUAtGcgC9/G50IgO7KCCp1Utfd+4IquOCaC8n
phgkg29tOds7tbW6rILrsbsYgJ7BQm+zYaSaz3Y5K8d0ulz24g9QCiFpable7rXY
o6ZC66RlSyaOqUAR/T1XhY3Dj3rCw4ljSXfBqNF6RNUXXlTmzYbq5kP/Ti1n3rfA
CUzND/D+C86wxSxOLxL1GXyCz3QeDSLa0konbUjrik38FzHi+WLfU99C9mxW3eZp
kIcPj/svrlDEO5GgcoC4c1a5LRJcsjYMkMjIRSo7/3BBbfMrljWnCitjjP+E+Kdq
WhjBqbfzTYJWwttNnbj5GUTr69R6DA==
=6EhO
-----END PGP SIGNATURE-----

--n0eWHlHrlf3aZrZrZxj92KeeT8EXJszUZ--

