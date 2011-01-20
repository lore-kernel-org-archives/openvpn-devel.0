Message-ID: <4D386DCB.80702@...515...>
Date: Thu, 20 Jan 2011 19:15:55 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010105070503010401040300"
Subject: [Openvpn-devel] Summary of the IRC meeting (13th Jan 2011)
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
--------------010105070503010401040300
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 13th Jan 2011
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2011-01-13>

Next meeting will be announced in advance, but will be on the same
weekday and at the same time. Your local meeting time is easy to check
from services such as

<http://www.timeanddate.com/world clock>

or with

$ date -u


SUMMARY

dazo, ecrist, jamesyonan, krzee, mattock, psha and trispace were present
in this meeting.

--

Discussed integration of "Coverity" code analysis tool into Buildbot.
Mattock will take care of this now that he has the necessary credentials.

--

Discussed the latest plugin V3 API patch:

<http://thread.gmane.org/gmane.network.openvpn.devel/4255>

Jamesyonan gave this patch an ACK, which means that the entire plugin v3
API patchset can be now be merged into Git.

--

Discussed the "Use \r\n as newline in log files on Windows" patch:

<http://thread.gmane.org/gmane.network.openvpn.devel/4274>

Although it seems Notepad is the only text editor that does not support
UNIX linefeeds, it is also the default editor on Windows: agreed that
this patch makes sense. Jamesyonan gave this patch an ACK.

--

Discussed the "Multicast over TAP w/ OpenVPN" issue:

<https://forums.openvpn.net/post9180.html#p9180>
<http://openvpn.net/archive/openvpn-devel/2004-04/msg00032.html>

Mattock promised to create a new feature request to Trac, and did:

<https://community.openvpn.net/openvpn/ticket/79>

--

Discussed the "OpenVPN to filter DHCP requests in bridge mode" patch:

<https://forums.openvpn.net/topic7479.html>

Noted that the same effect can be achieved with tools such as ebtables.
Also, the scope of the patch was too specific (DHCP only), so decided to
give the patch a NACK.

--

Discussed the "OpenVPN documentation (man page) review" project:

<http://thread.gmane.org/gmane.network.openvpn.devel/4354>

Agreed that whenever a patch changes functionality, it should be
accompanied with update to documentation (e.g. man-page) to avoid
undocumented features. So far this has not been mandatory.

Participants of the meeting were divided on which tools to use for
documentation writing. The (Trac) Wiki has a number of benefits,
especially when trying to get contributions from non-developers:

- built-in versioning
- no need to learn developer tools or processes
- relative ease of use

The Wiki documentation will of course require editing to stay coherent.
Also, to simplify things, content would have to be edited in Wiki only,
and only moved to the Git repository periodically.

Other approaches were suggested also:

- man page in Git, the rest in Wiki (hybrid approach)
- everything in Git repo

As the goal of the man-page review project is to get more non-developers
 involved in the documentation effort it was decided to start using the
Wiki as main documentation repository. If this does not result in more
non-developer contributions, we can reconsider our approach.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------010105070503010401040300
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2011-01-13.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2011-01-13.txt"

(20:15:32) jamesyonan [~jamesyona@...1320...] =EF=BF=BD=EF=BF=BD entrato ne=
l canale.
(20:15:32) #openvpn-devel: modalit=EF=BF=BD=EF=BF=BD (+o jamesyonan) da Cha=
nServ
(20:16:36) mattock: hi james!
(20:16:39) dazo: \o/
(20:16:42) jamesyonan: hi!
(20:17:01) mattock: ok, let's get going, then
(20:17:11) mattock: so, topics here: https://community.openvpn.net/openvpn/=
wiki/Topics-2011-01-13
(20:17:13) vpnHelper: Title: Topics-2011-01-13 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN Community (at community.openvpn.net)
(20:17:44) mattock: coverity first?
(20:17:53) dazo: go ahead
(20:18:19) ***dazo is time limited today, max 90 min, preferably just 60 min
(20:18:25) mattock: jamesyonan: if I remember correctly, you were about to =
send me credentials for our coverity account... right?
(20:18:40) mattock: dazo: let's keep it tight
(20:18:50) dazo: thx
(20:19:29) mattock: once Windows building is taken care of (=3Dsoon) I can =
move on to other tasks (e.g. coverity)
(20:19:57) jamesyonan: mattock: I just forwarded the email to you
(20:20:02) jamesyonan: it's pretty old
(20:20:34) mattock: jamesyonan: thanks!
(20:20:36) jamesyonan: but I'm sure if you contact them that we can get our=
 account up to date
(20:20:38) ***ecrist is here
(20:20:41) psha [~psha@...1447...] =EF=BF=BD=EF=BF=BD entrato nel canale.
(20:20:49) mattock: jamesyonan: I'll do that, then
(20:20:57) mattock: hi ecrist!
(20:21:08) mattock: ok, coverity is settled... next topic
(20:21:15) mattock: dazo: Plugin V3?
(20:21:28) dazo: we can do that one!  http://thread.gmane.org/gmane.network=
.openvpn.devel/4255/focus=3D4343
(20:21:31) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(20:22:06) dazo: jamesyonan:  I've sent another patch, changing the plugin =
v3 struct versioning to a separate versioning constant ... does that look r=
easonable to you?
(20:22:11) mattock: dazo: if this gets an ACK, whole v3 API is ACKed, right?
(20:22:28) dazo: yes
(20:23:50) jamesyonan: this looks good
(20:24:51) dazo: then I'll apply these 5 patches to the tree and get it int=
o allmerged
(20:25:17) mattock: excellent!
(20:25:29) mattock: next topic would be this: http://thread.gmane.org/gmane=
.network.openvpn.devel/4274
(20:25:30) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(20:25:51) dazo: we skipped one patch
(20:25:55) dazo: http://thread.gmane.org/gmane.network.openvpn.devel/4274/f=
ocus=3D4276
(20:25:57) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(20:27:41) dazo: gah ... it's the same, just different starting points :P
(20:27:59) mattock: yeah, I was pretty sure I copied the correct link :)
(20:28:49) dazo: the first patch, which Alon replied to is out-of-date ... =
but the second patch (reply to Alon) is a better fix, imo
(20:30:10) mattock: dazo: I think your last reply makes sense
(20:30:59) mattock: even if the logs are written to a network drive (e.g. s=
amba share), nothing breaks (excepts newlines of the logfile on the samba s=
erver)
(20:31:09) mattock: and currently all logs on Windows are broken
(20:31:31) mattock: also, in many cases the fileserver is Windows-based, so=
 there's no problem
(20:31:40) mattock: ...if I understood all this correctly
(20:31:41) dazo: exactly
(20:31:52) mattock: I give this patch a "feature ACK" :)
(20:32:00) dazo: thx!
(20:32:12) dazo: james?
(20:32:14) mattock: jamesyonan: what do you think?=20
(20:32:23) mattock: code-vise... or in general
(20:33:09) krzee: [10:31]  <mattock> and currently all logs on Windows are =
broken
(20:33:11) krzee: how so?
(20:33:23) mattock: newline style
(20:33:32) mattock: this thread: http://thread.gmane.org/gmane.network.open=
vpn.devel/4274
(20:33:34) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(20:34:00) krzee: ohhh ok
(20:34:21) dazo: log files now are written with only \n as new line.   Wind=
ows uses \r\n ... so when opening up openvpn logs on windows, in f.ex. note=
pad you get one very long line with plentiful of black-boxes on the screen
(20:34:36) krzee: funny, the only time i ran openvpn on windows i had a net=
work share that i used unix to see the logs
(20:34:42) krzee: so i never even noticed
(20:34:45) dazo: haha :)
(20:35:06) mattock: also, most UNIX text editors can handle any newline sty=
le
(20:35:25) mattock: unlike the crappy Windows editors
(20:35:48) dazo: most *nix systems will simply not care about the \r part .=
.. it's will just look normal
(20:35:52) jamesyonan: have you ever seen a text editor other than notepad =
that can't handle unix line endings?
(20:36:34) krzee: !windows
(20:36:36) dazo: well, considering I haven't used Windows on my desktop sin=
ce 98 ... I can't really say I am up-to-date=20
(20:36:44) krzee: aww
(20:36:55) krzee:  <vpnHelper> "windows" is (#1) pcs are like air condition=
ers, they work fine unless you open windows
(20:37:01) mattock: jamesyonan: I was mostly referring to Notepad :D
(20:37:20) mattock: wordpad can handle them, but it's still pretty crappy
(20:37:23) jamesyonan: I guess it's reasonable to support notepad consideri=
ng it's universally available on windows
(20:37:24) dazo: which is very common to use to view .log and .txt files in=
 by default
(20:37:58) dazo: you have wordpad and notepad which is default installed, i=
irc
(20:38:11) mattock: I'll check wikipedia to see how widespread this "lack o=
f unix linefeed support" is on Windows
(20:38:35) krzee: either way... just notepad makes the patch worthy
(20:39:48) dazo: I remember fighting with \r\n and \n in my previous jobs, =
where I got files produced in windows going to be used on *nix and vice ver=
sa ... software like MS Office demanded \r\n to parse csv files
(20:40:24) mattock: ok, here's something: http://en.wikipedia.org/wiki/Comp=
arison_of_text_editors#Newline_support
(20:40:26) vpnHelper: Title: Comparison of text editors - Wikipedia, the fr=
ee encyclopedia (at en.wikipedia.org)
(20:40:55) mattock: hmm... Notepad is the _only_ editor in the list with no=
 UNIX linefeed support
(20:41:04) mattock: that must be intentional ...
(20:41:25) dazo: all other editors are not written by microsoft=20
(20:41:56) mattock: I wonder why Wordpad has UNIX linefeed support...=20
(20:42:11) mattock: anyways, notepad is the default editor
(20:42:27) dazo: it is, and it is people struggling with it in real-life
(20:42:46) dazo: (not so technical users who are asked to send logs file ex=
tractions, f.ex)
(20:42:54) mattock: yeah
(20:43:04) mattock: jamesyonan: was the patch ok code-vise?
(20:43:39) mattock: hmm, pretty trivial patch actually :O
(20:45:28) jamesyonan: so this is essentially just the one line translate-m=
ode patch?
(20:45:48) dazo: yes
(20:45:55) jamesyonan: sure, that's fine
(20:46:24) dazo: the first patch was due to me not knowing about the extra =
_fdopen() text-mode feature
(20:46:50) mattock: btw. does this affect *NIX in any way?
(20:47:06) dazo: no change at all
(20:47:15) mattock: ok
(20:47:25) dazo: this change happens inside a #ifdef WIN32 block, iirc
(20:47:39) mattock: ok, this one next: https://forums.openvpn.net/post9180.=
html#p9180
(20:47:41) vpnHelper: Title: OpenVPN Support Forum UPnP over openVPN, is it=
 possible? : Configuration (at forums.openvpn.net)
(20:47:50) mattock: more info here: http://openvpn.net/archive/openvpn-deve=
l/2004-04/msg00032.html
(20:47:52) vpnHelper: Title: Re: [Openvpn-devel] Multicast over TAP w/ Open=
VPN 2.0 (at openvpn.net)
(20:48:08) dazo: hmm??  forums not responding?
(20:48:14) dazo: oh, just slow
(20:48:57) dazo: this reference is also important: http://openvpn.net/archi=
ve/openvpn-devel/2004-04/msg00032.html
(20:48:57) mattock: krzee: is this the meat of this matter: "Is it possible=
 to make UPnP work over openvpn?"
(20:48:58) vpnHelper: Title: Re: [Openvpn-devel] Multicast over TAP w/ Open=
VPN 2.0 (at openvpn.net)
(20:49:08) mattock: dazo: ^^^
(20:49:11) mattock: :)
(20:49:36) dazo: gah
(20:49:42) ***dazo is super slow today
(20:49:55) mattock: oh yes, "Right now you could call it a bug, or maybe mo=
re accurately an unimplemented feature."
(20:50:19) mattock: jamesyonan: could you shed some light on this "Multicas=
t over TAP w/ OpenVPN 2.0" issue... is it still valid?
(20:50:23) mattock: =3Da problem
(20:50:50) krzee: james, i pointed to a mail list post you made in 2004, no=
t sure if it still counts
(20:51:49) jamesyonan: I think the crux of the email is still true
(20:52:24) jamesyonan: if you want OpenVPN to be an multicast router you ne=
ed to intercept IGMP messages
(20:52:44) jamesyonan: and use them to alter the internal routing table
(20:52:53) dazo: Is that a feature we would like?
(20:53:08) krzee: ohh i see
(20:54:05) jamesyonan: so right now, openvpn will treat a multicast as a br=
oadcast
(20:54:41) krzee: could this be why the OP couldnt get upnp working over hi=
s vpn?
(20:55:03) jamesyonan: but it could be potentially smarter and limit the nu=
mber of receivers on a multicast message if it kept track of IGMP messages =
that tell it which client wants to be a member of which multicast groups
(20:55:28) jamesyonan: the point being that this is just an optimization
(20:55:46) jamesyonan: right now multicast packets are forwarded, just not =
efficiently
(20:55:57) dazo: so multicast is not lacking, it's just not as optimal as i=
t could be, in regards to bandwidth/overhead on the tunnel?
(20:56:03) dazo: ahh, there you go
(20:56:07) jamesyonan: yes
(20:57:02) mattock: perhaps we should file an enhancement request to trac
(20:57:07) mattock: just as a reminder
(20:57:13) dazo: I would say we can put this optimisation on a low-prio wis=
hlist
(20:57:34) mattock: yep
(20:58:00) mattock: I can create a new ticket tomorrow
(20:58:10) mattock: with the info that came up today
(20:58:10) dazo: thx!
(20:58:20) mattock: next and final topic: https://forums.openvpn.net/topic7=
479.html
(20:58:21) vpnHelper: Title: OpenVPN Support Forum OpenVPN to filter DHCP r=
equests in bridge mode : Wishlist (at forums.openvpn.net)
(20:59:30) dazo: ecrist:  is ipv6 working properly?  forum server is slow f=
or me, like it needs to hit a timeout before switching to ipv4
(21:02:31) mattock: "Why not add an option to suppress DHCP requests in the=
 bridging scenario?"
(21:02:43) mattock: is there any reason to do (or not to do) that?
(21:03:13) dazo: basically not to do it because you can do such filtering, =
even on bridges with ebtables?
(21:03:25) krzee: well i think dazo's response in the forum was right
(21:03:52) krzee: if we reinvent that wheel, how many more must be reinvent=
ed...
(21:04:14) dazo: for me this is a filtering feature ... what will be the ne=
xt filter feature request?  "I don't want to see MSN traffic passing the tu=
nnel"
(21:04:22) dazo: exactly
(21:04:26) krzee: and the dev of the patch didnt come to hold up his side
(21:04:52) jamesyonan: there's already some code to filter DHCP requests
(21:04:56) krzee: (although no garuntee he even saw it yet)
(21:05:08) krzee: ...really?
(21:05:17) dazo: hmm?
(21:05:44) jamesyonan: dhcp_extract_router_msg
(21:06:04) krzee: how does the end-user enable it?
(21:06:18) jamesyonan: this is so when a client is running in bridged mode,=
 it will accept settings like DNS servers from the DHCP server, but the ROU=
TER setting
(21:06:55) jamesyonan: (if it accepted the ROUTER setting it would kill its=
 ability to reach the internet)
(21:07:42) dazo: ahh, so you intercept and kill the "set router" message on=
ly?
(21:08:08) Praetorians: but that directly effets the operation of openvpn, =
 not the traffic flowing through it.
(21:09:03) jamesyonan: server-bridge without any parameters enables options=
->server_bridge_proxy_dhcp mode
(21:09:25) jamesyonan: in this mode all DHCP messages are tunneled except f=
or ROUTER
(21:10:21) dazo: that makes sense to have in OpenVPN ... but this guy wants=
 to completely filter out any DHCP requests ... that's a different issue in=
 that case, isn't it?
(21:10:30) ecrist: not sure
(21:11:19) jamesyonan: it's a different issue, but probably could leverage =
on existing code in dhcp.[ch]
(21:11:34) mattock: I don't think it's wise to open this can of worms...=20
(21:11:44) mattock: if the same can be achieved with other tools
(21:11:55) dazo: yes, that is my thought as well
(21:13:00) dazo: I would rather see more development on the already impleme=
nted pf part then, which now only takes IP addresses - make that one also p=
arse protocol and port numbers in addition
(21:14:04) krzee: ... /me hears people carving away at the new and improved=
 wheel!
(21:15:40) dazo: krzee:  on some embedded platforms you might not have prop=
er packet filtering ... so on these platforms, it can be more useful than j=
ust filtering DHCP request
(21:16:15) dazo: others will see it as a extra layer of security, to have p=
roper firewalling + openvpn packet filtering
(21:16:43) dazo: But I don't like the idea to implement a solution which on=
ly targets DHCP request and is hard-coded to do so
(21:16:54) mattock: +1
(21:17:46) mattock: I think this specific issue should be considered a neat=
 hack to fix one specific issue
(21:17:55) dazo: agreed
(21:18:05) mattock: ok, is that all for today?
(21:18:37) dazo: I think so :)
(21:18:39) mattock: if so, we were quick today...=20
(21:19:00) mattock: one more thing, actually
(21:19:37) mattock: jamesyonan: what are the *.cat files in openvpn.nsi?
(21:19:44) mattock: e.g. File "${GEN}\amd64\${PRODUCT_TAP_ID}.cat"
(21:20:19) mattock: the new build system does not create them
(21:23:54) mattock: are they needed?
(21:24:02) mattock: or can I just comment them out?
(21:25:28) mattock: I think we can conclude the official part, though
(21:25:35) mattock: I'll write the summary tomorrow
(21:25:44) mattock: talk to you guys later!
(21:26:26) dazo: thx!
(21:35:23) trispace [~rf@...1448...] =EF=BF=BD=EF=BF=BD entrato nel canale.
(21:37:59) krzee: dazo, like windows im guessing
(21:38:43) psha: sorry to raise non development question...
(21:38:58) psha: recently there was talk about documentation improvement on=
 devel/user list
(21:39:02) psha: http://thread.gmane.org/gmane.network.openvpn.devel/4354/
(21:39:06) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:41:29) mattock: psha: this is not a developers-only meeting, so that's =
just fine
(21:41:39) dazo: psha:  sure, no prob :) ... well, documentation is probabl=
y more development related than support :)
(21:41:48) psha: hm, it's hard to formulate question...
(21:41:53) psha: let me clarify a bit my point
(21:42:07) psha: i'm currently contributing to project which is in same sit=
uation - docs migration
(21:42:15) ***ecrist guesses it's along the lines of, "when the hell are yo=
u updating the docs?"
(21:42:24) psha: but in openvpn it's mainly openvpn.8 man page in source an=
d there it's lyx docs
(21:42:51) psha: but issues are same - maintaining docs are comparably hard=
 as writing code :)
(21:43:10) dazo: and developers generally "love" to write documentation too=
 ;-)
(21:43:59) mattock: psha: agreed
(21:44:15) mattock: and if something it's not documented, it does not exist
(21:44:23) mattock: except for the one developer who wrote the code
(21:44:32) psha: so i've just come here in hope that someone already studie=
d different approaches and may shed some light on it
(21:44:46) psha: mattock: yes, that's issue...
(21:45:03) mattock: dazo: have you required people to write docs for their =
patches?
(21:45:13) mattock: I don't remember any "official" decision about that
(21:45:50) dazo: dazo:  nope, and I do see we have --x509-alt-username as u=
ndocumented .... some people have been good at updating docs though
(21:46:17) mattock: psha: what do you mean by different approaches?
(21:46:19) dazo: but we should enforce documentation updates to get patches=
 applied
(21:46:21) psha: last discussion in that mail thread was around wiki markup=
/integration to man
(21:46:23) mattock: dazo: +1
(21:46:47) psha: also there was mentioned ODF (odt?) as a way to allow user=
s easily contribute
(21:46:47) mattock: psha: yep, I think Wiki is best if we want to get non-d=
evelopers involved
(21:47:05) mattock: the problem with ODT is versioning...=20
(21:47:07) psha: there was similar discussion some time ago in Git mailing =
list about non-developers for docs
(21:47:10) psha: yes, diffs
(21:47:49) dazo: I think there exists some special git plug-ins for ODF, wh=
en I think about it ... but I don't know too much
(21:48:05) psha: dazo: it's only to look at diffs as i remember
(21:48:10) psha: not merging
(21:48:33) mattock: I guess merging anything but plain text (or maybe simpl=
e HTML/XML) can be difficult
(21:48:55) mattock: also, we can probably move some of the docs from openvp=
n.net to the wiki anyways
(21:49:13) mattock: I'll get verification by early next week
(21:49:45) dazo: Another thing is that ODF can work fine, if everyone uses =
compatible ODF writers ... we probably know how Microsoft tried to cripple =
ODF with their own interpretation of ODF
(21:50:38) psha: mattock: wiki is great for collecting useful docs but it m=
ay come very fragmented... so for writing some solid docs it's not great i =
think
(21:51:08) mattock: psha: I see what you mean, I've seen it
(21:51:13) psha: sure it's just style and organization problem...
(21:51:47) mattock: I guess the solution is editing... it seems people are =
scared to remove obsolete text from Wikis
(21:52:00) mattock: which means they get fragmented and fuil of useless inf=
ormation
(21:52:03) mattock: without editing
(21:52:14) psha: for example EMC2 (that's realtime linux based machine cont=
roller software) wiki is very large and contains lot of useful information.=
.. but finding it out is not easy :)
(21:52:48) trispace: I think the documentation should kept alongside the co=
de. So one can checkout from the repository and gets both in a consistent w=
ay
(21:52:52) dazo: docs needs some editorial work, no matter solution ... but=
 my opinion is that we  in OpenVPN basically need to get the documentation =
to be more like a living resource ... I was thinking that we have a simple =
wiki page for each man page
(21:53:27) dazo: so that when you enter these "special" pages, you know it =
is a man page you are looking/editing on
(21:53:28) mattock: trispace: agreed, depending on which documentation we'r=
e talking about
(21:53:45) psha: there are solutions like ikiwiki that are based on revisio=
n control as backend so maybe it's possible to have it living on top of sou=
rce repo?
(21:54:04) dazo: and then when we do a release, we pull down the markup cod=
e from the wiki, convert it to man/html ... and commit it to the repository
(21:54:17) dazo: that kind of "freezes" the man page for a release
(21:54:38) psha: dazo: so there is only way from wiki to source? and not re=
verse?
(21:54:55) dazo: and in this process, some editing probably needs to be don=
e on the final result ... but the less changes, the better
(21:55:08) dazo: psha:  yeah, that was my intention=20
(21:55:18) trispace: mattock: sure, but I think even documentation about ge=
neral topics should be kept in the repository (or release tarball)
(21:55:44) trispace: mattock: as often there are some minor code changes wh=
ich might affect the overall design as well
(21:56:54) mattock: I think there's no optimal solution... we just need to =
decide what benefits we want to emphasize
(21:57:05) dazo: trispace:  agreed, we could provide a broader set of docum=
entation ... but I do see this more as a separate repository and not a part=
 of the code repository
(21:57:36) mattock: having documentation in the code repository effictively=
 locks out non-developers from contributing to it
(21:57:38) dazo: at the moment, we have the official howto's on the web pag=
e ... and the man page, that's all
(21:58:19) mattock: and having it in the wiki requires conversions and make=
s documentation in the repo a little obsolete
(21:58:31) dazo: mattock:  good point, yes indeed ... but a repository can =
be used to freeze certain versions of the documentation, which will make it=
 easier to create doc packages on misc distributions
(21:59:35) psha: dazo: repository and wiki are not mutualy exclusive
(21:59:39) mattock: as long as stuff is pushed from the Wiki to the repo of=
ten enough
(22:00:06) mattock: psha: yep, true... but editing the docs from both may b=
ecome too complex and error-prone
(22:00:24) trispace: mattock: that's right, but at least in my opinion peop=
le who are willing to - lets say clone a git repository - often contribute =
better quality docs as a random surfer editing some wiki page
(22:00:33) psha: mattock: yes, only one way allowed
(22:01:10) mattock: we definitely don't want to encourage random surfers to=
 edit our FAQ or man page=20
(22:01:18) mattock: most of them probably wont
(22:01:39) psha: but limiting people to use only wiki is not good too...
(22:01:56) psha: that's problem with different 'rich' format like LyX - you=
 have only one way to do it
(22:02:00) mattock: now, the problem I see is that contributing docs simila=
rly to contributing code locks out people
(22:02:31) mattock: you'd basically have to know a) git, b) patching, c) ou=
r development process, d) subscribe to -devel mailinglist
(22:02:42) psha: mattock: last is easiest!
(22:02:47) mattock: yeah, true
(22:02:56) dazo: psha:  true, it can be united ... but it's much more work =
doing such bridging .... unfortunately, the active part of the OpenVPN comm=
unity (those who really do contribute with pure changes) is not so big as y=
ou might think
(22:03:37) psha: dazo: as i already mentioned i'm considering this issues n=
ot only in context of openvpn - probles are common among many projects
(22:04:03) mattock: now that I think of it, I think using a hybrid approach=
 might be best
(22:04:21) mattock: keep the man-page in the git repo and take snapshots of=
 it to the Wiki
(22:04:36) mattock: keep HOWTO, FAQ, etc. in the wiki
(22:04:40) trispace: mattock: sounds like a good idea
(22:04:48) mattock: the man-page is edited mostly by developers
(22:04:53) dazo: For docs, we simply must have as simple solutions as possi=
ble so that as many as possible can contribute easily.  It is far easier an=
d quicker for a developer to update a wiki page, than to teach a "normal" u=
ser how to do changes in a repository ... and I am not considering supporti=
ng both wiki and a docs repository, that is the same job twice basically
(22:04:55) mattock: the HOWTO, FAQ etc. mostly by users
(22:05:03) psha: dazo: i have some experiments with repository based wikis =
but for local work documentation only - two contributors
(22:05:28) mattock: dazo: what do you think the "hybrid" approach?
(22:05:35) dazo: mattock:  man page can benefit update from users ... it is=
 many things there which are not clear, where users can improve it
(22:05:41) dazo: mattock:  I don't like it, to be honest
(22:06:19) mattock: now, let's say we use the wiki for the "man page editin=
g project" and when things stabilize, keep the master copy in the Git repo
(22:06:32) dazo: I find it less work for us who need to put the pieces toge=
ther, to pick all docs from one place ... get it formatted and apply the re=
sult to the git tree
(22:07:19) dazo: which format it is in the git tree, is less relevant for m=
e ... as long as we're able to "build it" on all supported platforms
(22:07:56) mattock: well, if we can make the Wiki -> man conversion more or=
 less automated, then it could work well
(22:08:08) dazo: that's my intention
(22:08:38) mattock: I wouldn't want scenarios where the latest code in Git =
has undocumented features (=3Dobsolete man-page)
(22:08:54) psha: at least asciidoc has fine man page output, i think markdo=
wn also has similar features
(22:08:55) mattock: and you'd have to go to the wiki to find out about them
(22:09:09) krzee: (like ipv6 stuff, which is only uptodate on gert's page a=
faik)
(22:09:25) dazo: and it already in Trac must exists code for doing wiki mar=
kip to HTML ... taking that code out and massage it into some scripting (or=
 a C program for that matter) and to produce something which can easily be =
moved further=20
(22:09:27) mattock: krzee: oh, interesting... that's got to be fixed
(22:09:52) krzee: mattock, well the code is only avail in the dev snapshots=
 afaik
(22:10:07) krzee: and the docs on gerts page look ready for importing to me
(22:10:09) dazo: mattock:  that's my point for having one source for docs, =
and not a hybrid ... easier to know where to edit and keep up to date
(22:10:24) krzee: [12:10]  <vpnHelper> "ipv6" is (#1) http://www.greenie.ne=
t/ipv6/openvpn.html for ipv6 payload patch (adds some nice ipv6 options), o=
r (#2) see !snapshots for a release with ipv6 patches in it, report how it =
works to help it get included in a stable release
(22:10:26) vpnHelper: Title: Gert D?ring - IPv6 Payload Patch for OpenVPN (=
at www.greenie.net)
(22:10:28) krzee: (#1)
(22:11:23) mattock: dazo: I think that's worth a try... and if we don't get=
 contributions from users, we can reconsider what to do
(22:11:25) krzee: if all devs followed his lead on documenting their added =
features it would be a good thing (tm)
(22:12:04) mattock: krzee: true, that's pretty thorough
(22:12:06) dazo: mattock:  agreed ... if no users are editing the wiki, the=
n we can make it easier for ourselves
(22:12:12) krzee: im pretty sure there will be more user contributions if w=
e go the wiki route
(22:12:27) mattock: let's try that... this is not a irreversible change
(22:12:33) dazo: I am not sure, but I hope so much it will happen
(22:12:36) mattock: and frankly, we don't know enough yet
(22:12:41) dazo: :)
(22:12:52) krzee: i for one have contributed a small amount to the manual v=
ia trac... would do more if it were a wiki as opposed to a trac ticket
(22:12:54) mattock: so we can only make informed guesses
(22:12:54) vpnHelper: RSS Update - tickets: #74: openvpn-2.1.4 floods /var/=
log/messages when network is down / it is reconnecting <https://community.o=
penvpn.net/openvpn/ticket/74>
(22:13:47) mattock: I think I'll add this discussion to meeting agenda, too=
...
(22:14:20) dazo: good idea :)
(22:14:31) psha: thanks a lot for this discussion
(22:15:19) krzee: psha, thank you as well
(22:15:51) psha: i'll keep track on this in dev list - hope some descision =
will be posted there too
(22:17:43) dazo: psha:  thx a lot!
(22:24:44) ecrist: lots of stuff happens here, too
(22:24:55) ***ecrist would argue the 'real' work gets accomplished here.
(22:25:05) ecrist: in other words, psha, pop in from time to time
(22:28:56) psha: ecrist: i'm sitting on other channels here so just another=
 one to watch :)
(22:40:05) trispace ha abbandonato il canale (quit: Quit: trispace).
(22:42:26) ecrist: :)
(22:43:05) ecrist: I do have to say I agree with krzee and I think the docs=
 should be made more available for updates and editing by the community
(22:43:18) ecrist: mediawiki does support ldap auth, and we already use tra=
c's wiki
(22:43:30) ecrist: though, I still despise the wiki built in to trac

--------------010105070503010401040300--

