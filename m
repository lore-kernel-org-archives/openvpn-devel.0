From: Samuli =?ISO-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Content-Type: multipart/mixed; boundary="=-D1iIE0NcuFGE09jBs+tL"
Date: Fri, 16 Sep 2011 17:53:17 +0200
Message-Id: <1316188397.1563.29.camel@...1503...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Summary of the IRC meeting (15th Sep 2011)
Reply-To: Samuli =?ISO-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--=-D1iIE0NcuFGE09jBs+tL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <1316188396.1563.26.camel@...1503...>

Hi,

Here's the summary of the previous IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday 15th Sep 2011
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2011-09-15>

Next meeting will be announced in advance, but will probably be on the same=
 weekday and at the same time. Your local meeting time is easy to check fro=
m services such as

<http://www.timeanddate.com/worldclock>

or with

$ date -u


SUMMARY

dazo, dguerri, ecrist, jamesyonan and mattock participated in this meeting.

--

Discussed the "tun.c patch breaks compile on FreeBSD" issue:

<http://thread.gmane.org/gmane.network.openvpn.devel/4993>

Dazo wrote a patch that fixed this issue. The patch was tested by ecrist on=
 FreeBSD: he also promised to test it on OSX.

--

Discussed the updated "Add MinGW WinHTTP compatibility import library" patc=
h:

<http://thread.gmane.org/gmane.network.openvpn.devel/4927/focus=3D4987>

Jamesyonan needed further details from the author before giving it an ACK.

--

Discussed dguerri's "Client's routes ageing timer" patch:

<http://thread.gmane.org/gmane.network.openvpn.devel/4990/focus=3D4994>=20

Dazo gave it an ACK on the condition that a few small changes are made.

--

Discussed the "Snapshot openvpn-2.x-20110909-master-install.exe fails" issu=
e:

<http://thread.gmane.org/gmane.network.openvpn.devel/4983>

Mattock will reproduce this issue on WinXP after which appropriate actions =
can be taken.

---

Full chatlog as an attachment

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock=

--=-D1iIE0NcuFGE09jBs+tL
Content-Disposition: attachment;
	filename=openvpn_irc_meeting_chatlog_2011-09-15.txt
Content-Type: text/plain; name=openvpn_irc_meeting_chatlog_2011-09-15.txt
Content-ID: <0>
Content-Transfer-Encoding: quoted-printable

<jamesyonan> Hi
<dazo> Hey!
<mattock> topic page updated: https://community.openvpn.net/openvpn/wiki/=
Topics-2011-09-14
<vpnHelper> Title: Topics-2011-09-14 =E2=80=93 OpenVPN Community (at comm=
unity.openvpn.net)
<mattock> which topic first?
<dazo> d12fk:  d457k: Are you around?
<mattock> page renamed: https://community.openvpn.net/openvpn/wiki/Topics=
-2011-09-15
<vpnHelper> Title: Topics-2011-09-15 =E2=80=93 OpenVPN Community (at comm=
unity.openvpn.net)
<mattock> maybe we could start with http://thread.gmane.org/gmane.network=
.openvpn.devel/4993 ?
<vpnHelper> Title: Gmane Loom (at thread.gmane.org)
<dazo> makes sense
<mattock> ecrist: are you around?
<dazo> I know a little bit about that issue as well
<dazo> This is the compile error he got: http://pastebin.com/F8rd6136
<dazo> and it turns out to be the commit 7fb0e07ec3f7c5f65 which is a pri=
me candidate as suspect
<ecrist> I'm here
<dazo> that's the rediect-gateway block-local feature
<mattock> hi ecrist!
<mattock> dazo, jamesyonan: any ideas how to fix this?
<dazo> the fix itself is basically to do the same changes to the OSX/DARW=
IN and BSD platforms as has been done on the other platforms ... not sure=
 if there are even more platforms suffering from this
<mattock> ah, so they were just "left behind"
<dazo> yupp, exactly
<dazo> well, that's my impression after having looked at that commit and =
seeing ecrist's error
<mattock> is the fix straightforward enough to be "just fixed" without fu=
rther discussion?
<dazo> well, it's difficult for me to say ... that initial commit is pret=
ty big, and it changes a lot of the logic ... so at first glance, it does=
n't look like a simple trivial fix ... but for all I know, it might be
<mattock> jamesyonan: any ideas?
<jamesyonan> so is the issue that FreeBSD is using the old add_route prot=
otype
<dazo> yes
<jamesyonan> one sec, I'm looking at the code now...
<jamesyonan> probably just change to: add_route (&r, tt, 0, NULL, es);
<jamesyonan> the const struct route_gateway_info * parm may be NULL
<mattock> ecrist: can you try that out?
<ecrist> what am I changing?
<dazo> I think that's the syntax used other places as well ... and there =
is the change of r.defined moving over to r.flags too
<dazo> it would probably be better to offer ecrist a patch ... it'll be m=
ore changes
<ecrist> i agree
<mattock> ah, ok
<mattock> who'll write the patch?
<dazo> I wouldn't mind doing it ... but I have too much to do, and needs =
BSD boxes to test on ... so it can't happen soonish .... :/
<mattock> jamesyonan: do you have some time to write the patch?
<mattock> e.g. during
<mattock> the meeting
<jamesyonan> I don't generally use FreeBSD
<mattock> ecrist could probably do the testing?
<mattock> if you guys have good hunch what's causing this
<ecrist> I don't mind at all
<ecrist> I even have a freebsd box I'll make available.
<mattock> that'd be nice
<jamesyonan> it might work to just copy/paste the OS X code, since that c=
ode is known to work, and OS X is also a BSD
<ecrist> well, os x shares a lot of userland, but has a different kernel
<dazo> well, this is basically userland related
<mattock> ecrist: can you try that first?
<ecrist> no idea what I'm trying, but sure.
<ecrist> :)
<mattock> don't hesitate to ask for help ;)
<mattock> I would have a clear idea myself either yet
<mattock> would not
<mattock> maybe move to next topic?
<dazo> jamesyonan:  if you look at tun.c:1064 ... that's inside the TARGE=
T_DARWIN block which is used on OSX; right?
<dazo> that line says:
<dazo>    r.defined =3D true;
<dazo> and I don't see a 'defined' member being declared in route.h
<dazo> in the 'struct route' struct
<dazo> I don't understand how this can compile on OSX ....
<dazo> (me is using the latest master branch)
<jamesyonan> basically r.defined doesn't exist any more -- it's now a bit=
 flag RT_DEFINED set in r.flags
<dazo> exactly ... so I'm just wondering what's missing in our tree, if t=
his compiles for you on OSX
<jamesyonan> I've only built 2.1 branch on OSX
<jamesyonan> but 2.1 branch absolutely compiles on OSX
<dazo> okay, I'll check that branch
<mattock> ecrist: you got OSX where you could tesr bulding "master"?
<mattock> test
<mattock> to see if it's missing something that's in james' 2.1
<dazo> wooow .... those two tun.c files looks quite different ... seems t=
he big nasty merge has failed on this point
<dazo> the BSD parts are the same, but not the OSX
<mattock> any other differences?
<dazo> I've not diffed them yet ... just going through do_ifconfig() now
<ecrist> how about, I just wait until you smart people figure it out? :)
<dazo> heh
<dazo> TARGET_SOLARIS is slightly different (not considering IPv6 support=
 and proper tun/subnet support - which is community patches)
<dazo> actually, the TARGET_SOLARIS difference most likely due to the tun=
/subnet patch
<dazo> TARGET_NETBSD is very different, but that's most likely due to som=
e bug fixes as well
<mattock> does this mean we need to take closer look before fixing the Fr=
eeBSD build issue?
<dazo> I'm going through now ... it's not too bad ... I might have a patc=
h in a few mintues
<mattock> great!
<mattock> jamesyonan: can you take a look at d12fk's fixed mingw patch: h=
ttp://sourceforge.net/mailarchive/forum.php?thread_name=3D1315932286-6992=
-1-git-send-email-heiko.hund%40sophos.com&forum_name=3Dopenvpn-devel
<vpnHelper> Title: SourceForge.net: OpenVPN: openvpn-devel (at sourceforg=
e.net)
<mattock> if it's a straight ACK
<dazo> ecrist:  http://www.fpaste.org/4JRV/ ... can you test that one ...=
 great if you can also test it on OSX, as I'm fixing some issues there to=
o
* dguerri (~cdtdaddy@...1504...) has joined #openvpn-devel
<dguerri> hi there
<mattock> hi dguerri!
<mattock> what's up?
<dguerri> is there someone interested in the aging timer for openvpn rout=
es patch?
<dguerri> here: http://sourceforge.net/mailarchive/message.php?msg_id=3D2=
8087359
<vpnHelper> Title: SourceForge.net: OpenVPN: (at sourceforge.net)
<ecrist> testing now, dazo
<mattock> ah, that one
<dguerri> can you give me some hints about it's clean implementation? :)
<jamesyonan> re: mingw patch, why is http://openvpn.net embedded in the c=
all to WinHttpGetProxyForUrl?
<vpnHelper> Title: OpenVPN - Open Source VPN (at openvpn.net)
<ecrist> dazo: that patch gets it past the old error
<ecrist> waiting to see if it finishes
<mattock> jamesyonan: can't help with that...d12fk had to do some semi-na=
sty issues but I can't remember details
<ecrist> dazo: I think that fixes it
<ecrist> it compiles anyway
<mattock> would dguerri's patch be generally useful?
<dguerri> @mattock it seems to me that the openvpn routing table should b=
ehave like a forwarding db when opnevpn is in tap mode or like a routing =
cache when it is in tun mode
<dguerri> bot "tables" do have a aging timer=20
<dguerri> but openvpn does not
<dguerri> am i right?
<dazo> I think jamesyonan is the one who can best answer this
<dguerri> I think that the problem is the combination of 2 things: first,=
 routes doesn't expire (so they are monotonically increasing), second we =
have a maximum amount of routes per client (the defaults to 256)
<dazo> dguerri:  I'm reading quickly through your patch ... is it only un=
used routes which are removed?
<jamesyonan> are you talking about route handling in route.[ch] or mroute=
.[ch]?
<dazo> dguerri:  and I'm wondering what makes these routes increase over =
time ....
<dguerri> yeah, routes that have a last activity timestamp older that a c=
onfigurable amount of time
<dguerri> older than not that :)
<dguerri> @dazo i have to admit we have a rather uncommon setup
<dazo> dguerri:  then the man page part could be more clear on that ... b=
y the way, there's a ---- prefix too, which should probably be just -- ..=
.. and it should probably be escaped as \-\- .... debian complains about =
such missing escapes ... except of that, the patch looks fine enough at f=
irst glance
<dazo> but I'm uncertain how useful this feature would be main stream
<dguerri> in tap mode, for instance, if you have a "guest" lag behind you=
r openvpn client, you could a increasingly number of routes=20
<dguerri> omg sorry for this automagic correction NOT lag but LAN
<dazo> aha, so it's LAN-to-LAN over VPN which creates this issues, with e=
ver growing routes?
<dguerri> yes
<dguerri> i don't know if tho apply also in tun mode.. but i it should be
<dguerri> (lemme turn autocorrect off :) )
<dazo> I see, then it can begin to make sense ... it's probably not too m=
any who have LAN behind the openvpn client routing, which this would hit =
then
<dazo> thus this has not been raised as an issue, from what I know at lea=
st
<dguerri> that's sure
<mattock> so this would have no negative side-effects for most users?
<dguerri> for instance, we have many access point that bridge theirs wlan=
 network (L2) into a vpn tunnels
<dazo> mattock:  doesn't look so at all
<dguerri> since the wlan network is open, we have a lot of clients
<dguerri> so a lot of routes per vpn-clients
<dazo> mattock:  1) it needs to be activated by --stale-routes-check ....=
 2) it does sensible route maintenance from what I can understand
<dguerri> @dazo I hope so :)
<dazo> :)
<mattock> if it's generally useful then perhaps the configure flag could =
be eventually be dropped?
<dazo> it's not a configure flag involved at all
<dguerri> @dazo thanks for the hints about the man page, I will reissue a=
 patch with these corrections
<dazo> mattock:  it's enabled at run-time
<mattock> ah, sorry
<dazo> dguerri:  please provide a patch which is based on the latest mast=
er branch ... the 2.1 base is very different from what the current master=
 is on this area
<dguerri> @dazo sure
<dazo> mattock:  unless jamesyonan says NACK ... this patch does make sen=
se to me
<mattock> nice!
<dguerri> it sounds great to me, thanks for now
<mattock> so, we need d12fk for mingw
<mattock> freebsd issue is fixed
<mattock> then we have the inet_ntop issue
<mattock> haven't had time to reproduce it yet
<dazo> I would like to know for sure that BSD is fixed ... compiler error=
 is fixed, but does it work at runtime?
<mattock> ecrist: can you do some quick tests?
<mattock> now or later ;)
<mattock> dazo: are basic smoketests enough?
<ecrist> let me try to connect ot a vpn, gimme one minute
<dazo> yeah, I'd say so ... smoketest which includes getting a connection=
 and seeing that the tun/tap adapter is configured=20
<dazo> I've reviewed tun.c with the suggested patch against the 2.1 SVN v=
ersion ... and now it looks like it's generally IPv6 plus other community=
 patches which makes it differ
<dazo> I don't recognise all changes, but most of them I know I've seen b=
efore
<ecrist> it works
<ecrist> tested on tap
<ecrist> let me test on tun
<dazo> ecrist:  perfect!  could you also please do a similar test on OSX =
too?  Since I do some changes there as well
<ecrist> hrm
<ecrist> not sure, it fails at configure, and I'm not sure what I should =
be using
<ecrist> log isn't overly revealing
<ecrist> doh
<ecrist> I don't have developer tools on this box yet
<ecrist> I just upgraded to lion
<ecrist> WHICH btw, has a proper bridge adapter
<mattock> can we do anything about the inet_ntop issue khasran reported?
<dazo> that happened on WinXP, right?
<mattock> yep
<mattock> I only tested win7 64bit
<mattock> http://thread.gmane.org/gmane.network.openvpn.devel/4983
<vpnHelper> Title: Gmane Loom (at thread.gmane.org)
<dazo> I think that WinXP is lacking inet_ntop ... but as the compiler fo=
und it while linking it ... it might have passed through
<dazo> the compile box was newer than XP, or do I remember wrong?
<mattock> win2008r2
<dazo> that might be the reason why the linking worked fine
<mattock> maybe I'll try to reproduce the issue first
<mattock> on winxp
<dazo> probably a good idea
<mattock> at the end of the month, there are things even N900 can't do :P
<mattock> anything else for today?
<dazo> We're an hour over :)
<ecrist> I'll install Xcode 4 and test on os x, dazo
<dazo> I think this would cover it for today
<dazo> ecrist:  thx a lot!  If that works out, I'll mail it to the mailin=
g list, and will add a Tested-by: reference to you if you don't mind
<ecrist> sure
<mattock> ok, excellent!
<mattock> I'll see if I have nerves to write the summary with this N900..=
. can somebody mail me the chatlog?
<mattock> not sure I can copy and paste from this client
<ecrist> mattock, sounds like you need screen + irssi
<ecrist> ;)
--=-D1iIE0NcuFGE09jBs+tL--


