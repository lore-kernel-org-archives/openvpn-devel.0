Message-ID: <4CC14989.70503@...515...>
Date: Fri, 22 Oct 2010 11:21:29 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050205030109090303090709"
Subject: [Openvpn-devel] Summary of the IRC meeting (21st Oct 2010)
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
--------------050205030109090303090709
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 21st Oct 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-10-21>

Next meeting will be announced in advance, but will be on the same
weekday and at the same time. Your local meeting time is easy to check
from services such as

<http://www.timeanddate.com/worldclock>

or with

$ date -u


SUMMARY

Discussed an issue with relative paths in openvpn configuration breaking
when a certain plugin was loaded. The exact reasons for this behavior
are complex (see below), but the actual bug is caused by a chdir("/")
after openvpn daemonization.

Jamesyonan explained the background in detail:

"Plugins usually call daemon[ize]() if they need to fork off a process
before privilege downgrade occurs. It's used as a split privilege
technique. If a plugin needs to fork it's child early before the main
process has daemonized, and if the child then doesn't also daemonize, it
can end up that the process as a whole doesn't look like it's
daemonized, i.e. the openvpn command wouldn't return immediately as one
would expect. [For example,] you would say "openvpn --daemon ..." and
the command would just hang up and never return. [Therefore] any plugin
that forks a child before main-process daemonization needs to have the
child also daemonize.  None of this is necessary if the plugin doesn't
fork, or if the child process is forked after main-process daemonization."

The plugin that triggered this bug was eurephia, so dazo will
double-check it to verify that it works as intended.

--

Discussed the "LOTS of bogus routes added on client connect" bug which
was originally reported to Debian BTS:

<https://community.openvpn.net/openvpn/ticket/64>
<http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D600166>

This issue discussed in the OpenVPN Forums is most likely the same:

<https://forums.openvpn.net/viewtopic.php?f=3D1&t=3D7201&p=3D8168#p8168>

Patches written by cron2 were ACKed by dazo and jamesyonan and have
already been tested by agi. Agi will push an updated package to Debian
repositories when original (Debian) bug reporter has tested the patches.

A fixed version will be published soon as OpenVPN 2.1.4. This version
will also include James' new SVN code.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------050205030109090303090709
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-10-21.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-10-21.txt"

(20:59:03) jamesyonan [~jamesyona@...1320...] =EF=BF=BD=EF=BF=BD entrato ne=
l canale.
(20:59:10) #openvpn-devel: modalit=EF=BF=BD=EF=BF=BD (+o jamesyonan) da Cha=
nServ
(20:59:22) dazo: Hi!
(21:00:01) mattock: hi james!
(21:00:09) cron2: hi james!
(21:00:28) mattock: so, topic list is here: https://community.openvpn.net/o=
penvpn/wiki/Topics-2010-10-21
(21:00:29) vpnHelper: Title: Topics-2010-10-21 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN Community (at community.openvpn.net)
(21:00:44) mattock: agi: are you present?
(21:00:52) jamesyonan: hi
(21:01:29) mattock: (if agi is not here, dazo can perhaps fill in the blank=
s conserning topic #1)
(21:01:30) agi: yep, here
(21:01:33) mattock: hi!
(21:01:39) agi: hiya!
(21:01:59) mattock: agi: could you explain the issue you found in more deta=
il?
(21:02:30) agi: well, the issue is not a crical bug or such
(21:02:53) dazo: just annoying and unexpected :)
(21:02:54) agi: I simply found that when I 'loaded' a plug-in
(21:03:04) agi: in a working configuration
(21:03:11) agi: the configuration will stop working
(21:03:31) agi: because all the relative paths to files (certs, keys,...)
(21:03:41) agi: won't be working then
(21:03:57) mattock: relative paths in openvpn configuration?
(21:04:01) dazo: yeah
(21:04:05) mattock: annoying...
(21:04:15) agi: after the daemon(0, 0) openvpn will chdir("/")
(21:05:00) agi: and it seems most/all plugins use (0, 0) instead of (1, 0) =
wich avoid the chroot, and seems to work as fine
(21:05:19) dazo: so what we're wondering is A) should plug-ins really call =
daemon() at all?  and B)  if it's needed is it safe to use daemon(1, 0)
(21:05:52) dazo: jamesyonan:  we probably need your eyes on this discussion
(21:05:52) ***cron2 wonders why plugins call daemon() in the first place?  =
It's not their call...
(21:06:00) dazo: that's what I'm thinking as well
(21:06:16) agi: (/me looks at the topic list and feels a bit noisy this wee=
k)
(21:06:47) dazo: it *can* make sense, if the plug-in forks out a child whic=
h is to be daemonised .... but that should happen in the child, not the par=
ent
(21:07:16) cron2: ack
(21:08:17) dazo: jamesyonan:  is there a reason plug-ins calls daemon() at =
all?  I see it happens in all the examples in the source code
(21:08:46) jamesyonan: plugins usually call daemon if they need to fork off=
 a process before privilege downgrade occurs
(21:09:07) jamesyonan: it's used as a split privilege technique
(21:09:25) dazo: but shouldn't that happen in the child, not the parent?
(21:10:10) dazo: because doing it in the parent ... will actually daemonise=
 the openvpn process itself, happening in the plug-in before the openvpn pr=
ocess gets that far
(21:10:24) jamesyonan: well the problem is that sometimes a plugin might fo=
rk off its child before the parent openvpn has daemonized
(21:11:15) ***cron2 might not even want to daemonize the openvpn itself... =
so a plugin that calls daemon() in the parent would mess up things
(21:11:29) dazo: I'm not sure I follow completely (and I suspect it's also =
related to set_sid() as well)
(21:15:24) mattock: surprisingly long pause... I'll break the silence :)
(21:15:28) dazo: What I am wondering about is why it is a problem that the =
plug-in does fork() and then daemon() in the child ... that will disconnect=
 it from the parent ... while if the plug-in "parent" process calls daemon(=
), I do not see which advantages that has related to fork()ed children
(21:15:36) jamesyonan: if a plugin needs to fork its child early before the=
 main process has daemonized, and if the child then doesn't also daemonize,=
 it can end up that the process as a whole doesn't look like it's daemonize=
d, i.e. the openvpn command wouldn't return immediately as one would expect
(21:17:20) ***dazo thinks
(21:19:23) dazo: I'm sorry, but in my mind, that looks like me that the plu=
g-in in that case implements things wrongly ... as if the parent "locks up"=
 because the child has not daemon()ised yet ... because the parent part of =
the plug-in should not care if the main process is daemon()ised yet or not
(21:19:54) cron2: +1
(21:21:49) mattock: dazo: how would you propose to fix this?
(21:22:28) jamesyonan: keep in mind that the parent part of the plugin is t=
he main openvpn process
(21:22:46) dazo: yes, I do know that
(21:23:16) dazo: maybe it's easier to understand if we have a real case sce=
nario, a plug-in which experiences these problems to understand it better
(21:24:02) jamesyonan: the problem arises because of the need to fork off a=
 child before the parent has daemonized
(21:24:28) mattock: I agree that we need a diagram / use case / something t=
o visualize this better... too hairy for me at least
(21:24:43) krzee [krzee@...1423.../community/support/krzee] =EF=BF=BD=EF=BF=
=BD entrato nel canale.
(21:25:04) dazo: yes, but I don't understand why that causes a problem ... =
that a child is forked out before the parent is daemonised .... what change=
s when that happens?
(21:25:12) dazo: is it related to session id?
(21:25:15) mattock: jamesyonan: and does openvpn drop it's privileges when =
it daemonizes?
(21:25:48) jamesyonan: the problem is that it breaks daemonization
(21:26:32) cron2: why?
(21:26:44) jamesyonan: you would say "openvpn --daemon ..." and the command=
 would just hang up and never return
(21:27:08) jamesyonan: because the shell would be waiting for the child pro=
cess to terminate
(21:27:09) cron2: but that's just in the case that the plugin forks, and th=
e plugin-child does not call daemon() itself - but I'd call *that* a bug
(21:29:09) jamesyonan: but the child process IS the one that calls daemoniz=
e()  (I'm looking at auth-pam.c)
(21:31:34) jamesyonan: the point is that any plugin that forks a child befo=
re main-process daemonization needs to have the child also daemonize.  None=
 of this is necessary if the plugin doesn't fork, or if the child process i=
s forked after main-process daemonization.
(21:31:44) cron2: I just checked down-root.c, and that one also calls daemo=
nize() only in the child
(21:32:15) cron2: daemonizing() in the child should not do harm
(21:32:24) cron2: agi: which plugin is biting you?
(21:32:47) ***agi points at daz
(21:32:48) agi: o
(21:33:16) agi: eurephia
(21:33:21) dazo: eurephia triggers the chroot() issue of this
(21:33:33) cron2: there is a misunderstanding going on :-) - of the sample =
plugins, only two call daemon[ize](), and both do so in the plugin-child
(21:34:08) dazo: well, I definitely need to double check eurephia then ... =
as that hits the issue at agi
(21:34:44) dazo: (the daemonize part is taken mostly out of the example plu=
g-ins, but it doesn't fork() if not using the firewall plug-in in eurephia)
(21:36:00) mattock: dazo: could this be an eurephia-specific issue?
(21:36:19) dazo: I definitely needs to check this up
(21:36:48) dazo: I'll take this discussion with agi afterwards ... to see w=
hat kind of config he got
(21:36:55) mattock: I suggest that the correct behavior (and why it's corre=
ct) is documented somewhere
(21:37:06) mattock: this is not exactly simple stuff
(21:37:53) dazo: nope, a plug-in doc would be good, on the implementation p=
art (not that API part, which is covered pretty well in openvpn-plugin.h)
(21:38:14) dazo: we can continue to the next part then, and if needed I'll =
bring this topic up again
(21:38:19) mattock: ok, sounds good
(21:38:31) mattock: topic #2: https://community.openvpn.net/openvpn/ticket/=
64
(21:38:33) vpnHelper: Title: #64 (LOTS of bogus routes added on client conn=
ect) =EF=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN Community (at community.openvpn.ne=
t)
(21:38:45) mattock: cron2, agi: this is fixed, right?
(21:39:21) cron2: mattock: yes.  It won't harm to have another pair of eyes=
 look at this, but the patch works for agi
(21:39:21) dazo: we got a patch, and agi confirmed it worked at least
(21:39:32) mattock: does it have an ACK? do we need more testing?
(21:39:34) dazo: jamesyonan:  you should have a look at that ticket
(21:39:36) agi: it worked for me. I asked the original reporter (at debian)=
 to try it, and I'll  get his answer tomorrow
(21:39:39) dazo: mattock:  I''ll ACK it
(21:40:14) mattock: oh, a one-liner :)
(21:40:17) dazo: yeah
(21:40:39) dazo: btw ... I think this is related ... https://forums.openvpn=
.net/viewtopic.php?f=3D1&t=3D7201&p=3D8168#p8168
(21:40:41) vpnHelper: Title: OpenVPN Support Forum View topic - Too many ro=
utes problem (at forums.openvpn.net)
(21:40:55) dazo: (in fact, I think this is the same issue)
(21:41:10) dazo: so we should really consider to spin a 2.1.4, especially f=
or the poor windows users
(21:41:26) cron2: yeah, looks very much like it
(21:41:50) dazo: jamesyonan:  what's your thoughts about that
(21:41:55) dazo: ?
(21:42:03) agi: dazo: they pay licenses, they aren't that poor :)
(21:42:26) cron2: I'm all for spinning a 2.1.4 - it breaks existing configs
(21:42:32) dazo: agi:  after having paid microsoft taxes, they're poorer ;-)
(21:42:48) krzee: agi, how many of them actually pay that? ;]
(21:42:49) dazo: cron2:  +1
(21:42:59) mattock: if we're realistic, we need to release 2.1.4 or 99% of =
windows users won't benefit from the fix
(21:43:25) agi: krzee: sadly too many, I did, because it came with the comp=
uter. take it or leave it=20
(21:43:27) dazo: well, in fact, all of the stable users (2.1.3) will not be=
nefit from that fix
(21:43:58) agi: I suggested a workaround
(21:44:06) cron2: dazo: ?
(21:44:09) agi: applicable in 99% of cases
(21:44:57) dazo: cron2:  all 2.1.3 who uses this feature, no matter platfor=
m, will most likely suffer from this bug
(21:45:05) agi: change "remote_host" with the ip of the vpn server (not app=
licable when it has several, depending on how the client reaches it)
(21:45:07) cron2: yes
(21:45:18) cron2: (to both, actually :) )
(21:46:58) dazo: agi:  anyhow, you can add both those patches from cron2 to=
 the debian builds, to solve it there ... as it's probably too late to sugg=
est moving to 2.1.4 when we get that out the door
(21:47:44) cron2: *sigh*, gentoo also needs this, then
(21:48:21) dazo: but gentoo is quicker to rebase, as that's never in a "sta=
ble" state
(21:48:24) agi: dazo: yez, debian package is ready and will be uploaded as =
soon as reporter ack's it is working
(21:48:34) dazo: goodie!
(21:48:49) cron2: agi: great :)
(21:50:52) jamesyonan: I'm fine with the fix for ticket 64
(21:51:05) mattock: dazo, jamesyonan: any plans regarding 2.1.4?
(21:51:27) mattock: (did not understand what dazo said about getting it out=
 of the door :)
(21:51:27) cron2: dazo: so this goes to bugfix2.1, and thus automatically t=
o 2.2 and allmerged?
(21:51:46) dazo: cron2:  yes
(21:51:53) mattock: and 2.1.4?
(21:52:01) raidzx ha abbandonato il canale (quit: Quit: Leaving).
(21:52:23) raidz [~Andrew@...1424...] =EF=BF=BD=EF=BF=BD entrato nel canale.
(21:52:23) raidz ha abbandonato il canale (quit: Changing host).
(21:52:23) raidz [~Andrew@...1423.../corp/admin/andrew] =EF=BF=BD=EF=BF=BD =
entrato nel canale.
(21:52:23) #openvpn-devel: modalit=EF=BF=BD=EF=BF=BD (+o raidz) da ChanServ
(21:52:36) dazo: I can branch out svn-BETA21 apply this patch and prepare 2=
.1.4=20
(21:52:49) dazo: unless jamesyonan wants to do it
(21:53:15) jamesyonan: I'm swamped as usual
(21:53:30) dazo: In fact, I can branch out 2.1.3 apply this fix and publish=
 it as 2.1.4 ... then the changes will be this fix
(21:53:52) dazo: the challenges is the windows builds and signing
(21:55:27) jamesyonan: I can do the actual build and signing
(21:56:48) mattock: dazo?
(21:56:52) mattock: oops
(21:56:55) mattock: sorry
(21:57:32) mattock: yeah, windows building... I have not yet managed to bui=
ld openvpn on WinXP
(21:57:34) dazo: jamesyonan:  I can prepare 2.1.4 then ... but do you want =
it based on your latest SVN changes ... or shall I fork 2.1.3 and add this =
fix only?
(21:59:08) jamesyonan: you can include the latest svn changes
(21:59:48) dazo: jamesyonan:  goodie!  would you mind updating the ChangeLo=
g with your comments, and I'll add the last stuff there
(22:00:27) jamesyonan: ok
(22:01:04) mattock: jamesyonan: can you build the windows executable? Or sh=
all I rethink my plans and really start configuring the WinXP build compute=
r?
(22:01:12) mattock: I need to do that sooner or later, though...
(22:01:18) dazo: jamesyonan:  shoot me a mail or ping here on irc ... I can=
not promise I can manage it before the weekend ... but I can try
(22:01:37) jamesyonan: for now I can build it
(22:01:55) mattock: great!
(22:02:07) jamesyonan: dazo: will you be merging the bogus routes fix patch=
 into svn?
(22:03:15) dazo: jamesyonan:  the branch I have in SVN is not usable, tbh .=
.. that did become a mess and I abandoned it  (that was during the beginnin=
g of 2.2 beta)
(22:03:46) dazo: I could remove all files there ... and import them again (=
doing all directly in SVN)
(22:04:04) dazo: or I can send the final commit directly to you
(22:04:51) jamesyonan: I just want to have the bogus routes patch in svn BE=
TA21 branch.
(22:05:39) dazo: I understand ... for now, I think it's quicker if I mail y=
ou the patch so you can commit it directly .... I got the commit message al=
most ready
(22:05:52) jamesyonan: sure
(22:06:46) mattock: anything else anyone?
(22:08:15) dazo: jamesyonan:  mail sent
(22:12:19) ***agi blinks
(22:12:33) mattock: ok, unless there's something else, let's call this a day
(22:12:43) mattock: (I take silence as a "yes") :)
(22:12:45) cron2: dazo: bootstrap.sh / version 2.x- :-)
(22:12:58) dazo: cron2:  yeah, it's coming as well :)
(22:13:11) cron2: great
(22:13:37) dazo: just want to get your more important fix into misc branches
(22:13:40) dazo: furst
(22:13:46) dazo: first*
(22:14:06) ***dazo was not indicating cron2 being a f=EF=BF=BD=EF=BF=BDrst =
:-P
(22:14:08) cron2: ack
(22:14:10) cron2: :)
(22:16:12) mattock: ok, I'm pretty certain the official part is over ;)
(22:16:18) mattock: I'll write the summary tomorrow
(22:16:32) dazo: ack

--------------050205030109090303090709--

