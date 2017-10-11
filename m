From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <09e46183-07f4-35dd-86d9-0a0c0098ac98@...515...>
Message-ID: <f36f92c1-152e-edfa-4da7-953e85fb36ad@...515...>
Date: Wed, 11 Oct 2017 21:07:18 +0300
MIME-Version: 1.0
In-Reply-To: <09e46183-07f4-35dd-86d9-0a0c0098ac98@...515...>
Content-Type: multipart/mixed; boundary="------------98F2C86BB17904C819979E80"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (Wed,
 11th Oct 2017)
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
--------------98F2C86BB17904C819979E80
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 11th Oct 2017
Time: 19:00 CET (17:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2017-10-11>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, mattock and ordex participated in this meeting.

---

Talked about patchwork. The registration URL problem (http instead of
https) has been fixed. Mattock, however, had forgot all about the
inability to delegate tickets. He will look into that problem tomorrow.

---

Talked about the RADIUS and LDAP plugins. Mattock will start discussions
with their authors about getting them under "OpenVPN" organization on
GitHub. That is, unless somebody complains about that plan soon.

--

Full chatlog attached.

--------------98F2C86BB17904C819979E80
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2017-10-11.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2017-10-11.txt"

(19:47:12) L'argomento di #openvpn-meeting =C3=A8: Meeting 2017-09-27 19:=
00 CEST: Agenda at https://community.openvpn.net/openvpn/wiki/Topics-2017=
-09-27
(19:47:12) L'argomento per #openvpn-meeting =C3=A8 stato impostato da ord=
ex!~linuxaro@...2309.../batman/ordex a 07:22:46 su 26/09/2017
(19:47:50) chipitsine [~ilia@...2312...] =C3=A8 entrato nella stanza.=

(19:53:48) cron2: I'll be a tad late... kid is not feeling well, taking t=
ime to bring her to bed
(19:56:26) mattock: ok
(20:04:20) cron2: actually I'm here but need to be on-and-off for a bit l=
onger
(20:04:32) mattock: ok, let's start
(20:05:03) mattock: this could be _really_ quick: https://community.openv=
pn.net/openvpn/wiki/Topics-2017-10-11
(20:05:05) vpnHelper: Title: Topics-2017-10-11 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(20:05:21) mattock: unless somebody has other topics and/or syzzer is pre=
sent
(20:05:32) cron2: this will be quick since syzzer is still surfing in tai=
wan or such
(20:05:55) cron2: I'll go and review CRCinAU's contrib later tonight (and=
 I'm busy commiting simon's patches)
(20:06:02) mattock: ah, good!
(20:06:36) mattock: question: do you know which RADIUS plugin sucks the l=
east?
(20:07:05) mattock: as in: which one could become starting point for the =
"official" plugin?
(20:07:09) cron2: I think the valdikss fork has seen the most bugfixes
(20:07:21) mattock: GitHub?
(20:07:23) cron2: and since he's around that would be a good starting poi=
nt, I think
(20:07:40) mattock: agreed
(20:08:14) cron2: https://github.com/ValdikSS/openvpn-radiusplugin
(20:08:15) vpnHelper: Title: GitHub - ValdikSS/openvpn-radiusplugin: Radi=
usplugin with various patches and fixes (at github.com)
(20:08:48) cron2: but we should spend some time to look whether other for=
ks have bugfixes not in there
(20:08:52) cron2: it's a bit messy
(20:08:53) mattock: ok
(20:09:55) mattock: I will also have a look at the LDAP plugins
(20:10:07) mattock: and if nobody complains soon, I will start discussion=
s with their authors
(20:10:36) ordex: mattock: how about patchwork?
(20:10:37) ordex: :P
(20:11:05) mattock: it is ready
(20:11:15) mattock: or, rather, http -> https redirect is in place now
(20:11:27) cron2: cool
(20:11:40) mattock: so the registration links (that was the problem, righ=
t?) should now work
(20:12:15) ordex: mattock: how about "delegate to" ?
(20:12:20) mattock: mhmh
(20:12:31) mattock: oh yes
(20:12:38) mattock: forgot about that :P
(20:12:39) ordex: :P
(20:12:50) mattock: well, I will look into it tomorrow
(20:12:53) ordex: how can I assign patches to cron2 otherwise :P
(20:12:57) ordex: ok, thanks :)
(20:13:03) mattock: good point
(20:13:10) mattock: :P
(20:15:18) cron2: I'm not sure if we want to do that
(20:15:28) cron2: or if *I* want ordex to do that
(20:15:37) ordex: :P
(20:15:42) ***cron2 has enough work queues that stall
(20:15:48) ordex: that
(20:15:57) ordex: that's the only reason why i am pushing for patchwork :=
P
(20:16:40) cron2: patchwork is very useful to keep track of patches, but =
we should be careful about assigning work to volunteers
(20:17:04) mattock: summarizing: mattock will soon start discussions with=
 radius and ldap plugin authors to get them under OpenVPN/, mattock will =
fix the delegate_to problem in patchwork -> patchwork "ready"
(20:17:29) cron2: and then we decide whether we do delegate, and accordin=
g to which protocol :)
(20:17:48) cron2: ("ask on IRC", "yes, hand it to me" would be a "protoco=
l", but might not be the only option)
(20:17:57) ordex: cron2: don't worry too much ;P
(20:18:39) mattock: with only reliable volunteers that protocol would be =
fine
(20:19:06) ordex: but jokes apart, I think there is a somehow clear conce=
pt of "domains" within the openvpn2 core code
(20:19:16) ordex: i.e. crypto -> syzzer, unless somebody takes over
(20:19:20) ordex: route, tun -> cron2
(20:19:21) cron2: true.  Everything that is ugly -> syzzer
(20:19:24) ordex: something like that
(20:19:25) ordex: :D
(20:19:26) ordex: haha
(20:19:27) cron2: socket -> ordex
(20:19:32) ***ordex runs
(20:19:34) cron2: see :)
(20:20:07) ordex: hehe
(20:21:58) ordex: so the meeting is over? :)
(20:22:37) mattock: it could be sure
(20:22:39) mattock: I was about to ask
(20:22:52) mattock: do we have any topics besides friendly talk? :P
(20:23:05) ordex: I don't
(20:23:25) ordex: there are still these vlan patches, i hadn';t enough ti=
me to allocate. will try to do better in th enext days
(20:23:48) ordex: (read: been quite lazy last week)
(20:24:50) mattock: ok, no worries
(20:25:24) mattock: meeting concluded then :)
(20:25:56) ordex: good!
(20:26:03) mattock: +1

--------------98F2C86BB17904C819979E80--

