From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <604d3782-646c-4f12-b789-2ae9ebbae069@...515...>
Message-ID: <41b4cec4-4be8-fc01-db9b-b6aa90bcbe7c@...515...>
Date: Wed, 1 Sep 2021 15:52:30 +0300
MIME-Version: 1.0
In-Reply-To: <604d3782-646c-4f12-b789-2ae9ebbae069@...515...>
Content-Type: multipart/mixed; boundary="------------781AFF18C771D008BAE54C08"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (1st September
 2021)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------781AFF18C771D008BAE54C08
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on libera.chat
Date: Wed 1st September 2021
Time: 14:00 CET (12:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2021-09-01>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, d12fk, lev, mattock, plaisthos, rob0 and syzzer participated in 
this meeting.

---

Mattock is done with buildbot/windows packaging except for some small 
documentation fixes and some work on the msibuilder vm in 
openvpn-vagrant. The next step after those is to setup the production 
buildmaster.

---

Plaishos is working on DCO again.

---

Ordex is chopping the compat-mode patch and will send a small series to 
replace it.

---

Lev is working on zerocopy dco-win, which is much faster comparison to 
existing implementation (which is already fast enough).

---

Plaisthos noted that with normal Linux tun sends at 400MBit/s, but 
receives 1.5GBit/s. In Windows with Wintun he gets 1.2GBit/s in both 
direction. So, there is a major performance issue somewhere, probably in 
our *magic* select/poll/epoll maze. Windows/wintun avoids that maze 
because it has a different implementation that uses windows specific 
functions.

---

Noted that the forums board rethinking forum post has not been responded 
to. We probably need to contact some key people directly about it. 
Mattock will check the forums database to locate the key contributors 
and contact them.

-- 

Full chatlog attached

--------------781AFF18C771D008BAE54C08
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2021-09-01.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2021-09-01.txt"

(14:59:59) lev_: guten tag
(15:00:29) ordex: hoi hoi
(15:02:12) d12fk: gday
(15:03:14) plaisthos: hey
(15:04:22) mattock: hi
(15:07:44) rob0: the /topic would seem a bit out of date ;)
(15:08:22) plaisthos: :D
(15:08:39) ordex: not much
(15:08:40) d12fk: its still good
(15:09:03) mattock: it is always the same
(15:10:59) d12fk: kommst du nachher mit dem westwagen zum deppenlager?
(15:11:14) plaisthos: d12fk: wrong channel?
(15:11:21) d12fk: indeed =3D)
(15:12:11) d12fk: guess it is encypted enough to go public ;-)
(15:12:21) d12fk: so, anything here?
(15:13:00) ordex: .oO
(15:13:10) mattock: I don't have much, I tried almost all the loose ends =
in buildbot/windows packaging
(15:13:31) mattock: just small documentation fixes and some work on the m=
sibuilder vm in openvpn-vagrant
(15:13:38) cron2: yo
(15:13:39) mattock: then of course the production buildbot setup
(15:13:48) mattock: that's something for next week it seems
(15:13:57) mattock: I'll probably work on those on Friday as well
(15:14:17) cron2: next week is good.  This week I'm still mostly afk
(15:14:42) rob0: dazo's out this week too
(15:14:58) plaisthos: I finally got enough time to work on dco again
(15:15:19) syzzer [~syzzer@...2615...] =C3=A8=
 entrato nella stanza.
(15:15:22) ordex: \o/
(15:15:33) ordex: I am chopping the compat-mode patch
(15:15:46) ordex: will send a small series on the list that substitutes i=
t
(15:16:01) cron2: okay
(15:17:12) ***lev_ working on zerocopy dco-win, which is much faster comp=
arison to existing implementation (which is fast enough)
(15:17:20) cron2: nice
(15:18:07) plaisthos: at some point we *really* need to figure out why li=
nux with tun is slow when receving
(15:18:16) plaisthos: I get 1,2 GBit/s in both directions with wintun
(15:18:38) lev_: windows has much better network stack
(15:18:39) plaisthos: and normal Linux tun is 400 MBit/s sending but 1,5 =
GBit/s receving
(15:18:44) ***lev_ runs away
(15:19:17) syzzer: Well, having a kernel/user context switch for each pac=
ket doesn't help
(15:19:33) plaisthos: syzzer: sure, but it must be something else.=20
(15:19:41) plaisthos: since one direction works and the other one doesn't=

(15:20:07) lev_: do we get multiple packets with one syscall on rx path ?=

(15:20:10) plaisthos: and the number of context siwtches *should* be simi=
lar in one direction and the other=20
(15:20:20) plaisthos: lev_: no
(15:20:26) cron2: lev_: not today.  syzzer started on multi-packet, but t=
hat never got traction
(15:20:29) syzzer: yeah, that definitely strange
(15:20:34) cron2: (and, btw, nice seeing you :-) )
(15:20:44) plaisthos: but we might do something like trying to do read() =
again to see if something is ready again or something like that
(15:20:58) syzzer: (thanks cron2 :-) )
(15:21:08) plaisthos: yeah good to see you
(15:21:13) mattock: +1
(15:23:05) syzzer: It's been years since I attempted to do performance pr=
ofiling
(15:25:39) plaisthos: yeah, I was just getting some dco numbers and that =
was really odd
(15:26:02) plaisthos: I suspect some of our *magic* select/poll/epoll maz=
e is broken
(15:26:33) plaisthos: windows/wintun uses a different implementation that=
 uses windows specific functions
(15:26:35) ordex: could be
(15:29:15) mattock: somebody needs to take a deep dive
(15:29:39) mattock: need to sync more on 2.5/2.6?
(15:30:41) ordex: not here
(15:31:31) mattock: a small update on forum board rethinking: no response=
s to my forum post about it
(15:31:39) mattock: so I think we just need to contact some key people di=
rectly
(15:31:57) mattock: I can dig up a list of top forums contributors from t=
he database and ask if they have a say
(15:32:17) mattock: that's all
(15:32:47) ordex: okay
(15:33:29) mattock: 2.4 oldstable thing is the same as before ("collect s=
ome patches -> release final version")
(15:33:49) rob0: my opinion as a not-much contributor to forums: we reall=
y do need to make it clear where client questions should go, whether by a=
dding to certain forums' descriptions, or by creating a new forum.
(15:33:58) mattock: I agree
(15:34:22) syzzer: 'msg *nickserv ViewCommands
(15:34:23) mattock: IPv6 to community: no real progress, but as mentioned=
 before, no hard blockers anymore, either
(15:36:04) cron2: good :-)
(15:37:19) mattock: anything else to discuss today?
(15:37:41) cron2: not from me... still lazying around... :)
(15:37:58) mattock: lazying is good, keep on doing it!
(15:38:59) cron2: eventually I need to return to "pretend to be busy"... =
customers are getting restless
(15:39:24) mattock: :)
(15:40:11) mattock: I'll start writing the summary now
(15:41:47) d12fk: okay, will get back to idle again then *waves*
(15:42:16) cron2: competition idling
(15:46:03) ordex: I think dazo won already
(15:46:21) cron2: bah

--------------781AFF18C771D008BAE54C08--

