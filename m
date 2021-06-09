From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <48241a88-28ce-5a08-6dc8-34423634f092@...515...>
Message-ID: <fb9dda8a-2a32-cf19-737a-1d30541b12f1@...515...>
Date: Wed, 9 Jun 2021 16:26:20 +0300
MIME-Version: 1.0
In-Reply-To: <48241a88-28ce-5a08-6dc8-34423634f092@...515...>
Content-Type: multipart/mixed; boundary="------------75ABEC39101799B9867945CD"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (9th June 2021)
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
--------------75ABEC39101799B9867945CD
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on libera.chat
Date: Wed 9th June 2021
Time: 14:00 CET (12:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2021-06-09>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, d12fk, lev, mattock, plaisthos and syzzer participated in 
this meeting.

---

Talked about patches aimed at OpenVPN 2.6. Ordex plans on reviewing nine 
patches from plaisthos this week. Cron2 will test and merge a few 
pending auth patches.

---

Agreed to try to release new OpenVPN 2.5.2 installers with ARM64 MSI 
support next wednesday. Possibly this could become 2.5.3 release as well 
as there's a crash bug in 2.5.2.

The main blocker is that mattock's vagrantized MSVC build VM (=the 
upcoming buildbot worker) does not work now because Microsoft's download 
servers seem to be borked, preventing some Visual Studio components from 
downloading. So, mattock is unable to build things with MSVC at the 
moment. It used to work last Monday or so.

Lev will try to build the MSVC build VM independently to rule out local 
issues caused by mattock's laptop/internet connection (e.g. IPv6 blocked 
at MS end).

---

Noted that copyright notices should be upgraded (to 2021). We have a 
script to do it.

---

Noted that there's no IPv6 on openvpn.net domain yet. Invented some 
novel ideas on how to make IPv6 a reality.

---

Mattock gave an update on Buildbot. The buildbot worker part is working 
on the Windows Server 2019 VM now, but Visual Studio component 
installation issues are blocking things (see above).

---

Mattock will create a Doodle poll for the hackathon (November 2021).

--------------75ABEC39101799B9867945CD
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2021-06-09.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2021-06-09.txt"

(14:58:39) mattock: hi
(14:59:03) ordex: hoi
(14:59:11) dazo: yeh!
(14:59:26) lev__: hello
(14:59:30) cron2: hey, you're all early
(14:59:37) ***cron2 is still digesting
(15:00:29) ordex: same here
(15:00:50) lev__: video or chat?
(15:00:51) dazo: Just a heads-up, I have another meeting at 15:00, so nee=
d to part around 14:45
(15:01:04) ***cron2 feels like chat today
(15:01:09) ordex: chat chat
(15:01:42) dazo: +1
(15:02:22) d12fk: hi
(15:02:42) mattock: chatchat
(15:03:23) mattock: https://community.openvpn.net/openvpn/wiki/Topics-202=
1-06-09
(15:03:40) mattock: #1 sync up
(15:04:03) syzzer_: hi!
(15:04:24) cron2: yo!
(15:05:21) cron2: I haven't seen much activity in "master/2.6" related pa=
tches... ordex: what is your time planning?
(15:05:41) ***cron2 is able to focus on things again: KIDS ARE IN SCHOOL.=
  BOTH.  On the SAME DAY.
(15:06:16) mattock: that's EXCELLENT news cron2! :D
(15:07:47) ordex: cron2: this week I have the 9 patches v2 from plaisthos=
=20
(15:07:57) ordex: planning to et those reviewed within this week
(15:08:00) ordex: *get
(15:08:33) cron2: ordex: ok, that's a lot :-) - let's see how it works ou=
t
(15:08:43) cron2: I have one of the "pending auth" still on my test-and-m=
erge list
(15:08:47) cron2: (3, actually)
(15:09:32) ordex: cron2: yeah it is, goal is to get them all checked, but=
 let's see where we get :)
(15:09:52) cron2: cool.  (Any word on where plaisthos is hiding?)
(15:12:22) ordex: (somewhere)
(15:12:55) plaisthos: here!
(15:13:06) mattock: welcome!
(15:13:09) ***d12fk waves vigorously
(15:14:01) cron2: plaisthos: your agreement on the msg() patch is missing=
 ("in here" is good enough)
(15:14:11) plaisthos: Yeah, just apply it
(15:14:22) plaisthos: I was just annoyed that my build failed because of =
-Werror
(15:14:57) ***ordex waves fist against lev__=20
(15:15:26) lev__: well, I made it better - at last it compiles with msvc
(15:15:30) lev__: *at least
(15:16:04) ordex: hehe
(15:16:05) plaisthos: not if you use msvc+clang
(15:16:15) ordex: not sure -Werror is enabled by default
(15:16:18) ordex: :p
(15:18:14) ordex: anything else for the sync up /
(15:18:15) ordex: ?
(15:18:47) cron2: you can use msvc+clang?
(15:18:56) lev__: lets to 2.5.2/3 arm64
(15:18:59) lev__: *do
(15:19:55) cron2: mattock, lev__: next week wednesday?
(15:20:10) mattock: sounds doable
(15:20:52) lev__: I would love to see a few patches (msvc standalone, pkc=
s11-helper + arm64 in openvpn-build) merged
(15:20:54) mattock: if there are not pending, important 2.5 changes then =
2.5.2 installer release might be sufficient
(15:21:05) cron2: there's a crashbug in 2.5.2 :-)
(15:21:32) lev__: there are also some 2fa improvements in openvpn-gui
(15:21:43) mattock: my main challenge now is that Visual Studio component=
s fail to install because of upstream (Microsoft server) issues, so I don=
't have a build environment for MSVC
(15:22:09) cron2: lev__: yeah, one of these build patches is on my radar.=
  I'll ping you tomorrow/friday on what else is missing.
(15:22:12) ***lev__ shrugs
(15:22:20) lev__: cron2: sure, thanks
(15:23:14) lev__: mattock: we could have AMI in ec2 under inc account for=
 msvc release building
(15:24:07) mattock: yeah, but that does not help if we can't at the momen=
t install all the visual studio components we need
(15:24:32) mattock: I can try building on an EC2 VM just to rule out the =
possibility that my computer is somehow part of the problem
(15:24:39) lev__: yeah
(15:24:42) mattock: but I was able to install all the components yesterda=
y or so
(15:24:46) mattock: so it seems quite unlikely
(15:25:09) mattock: anyhow
(15:25:29) lev__: I just reinstalled build tools 2019
(15:25:54) mattock: it would help if you could check out "dockerized_buil=
dbot" branch in my fork of openvpn-vagrant
(15:26:05) mattock: and try to "vagrant up buildbot-worker-windows-server=
-2019"
(15:26:33) mattock: that would show if the problem is at my end (somehow)=
 or if it is at the MS end
(15:26:52) lev__: I could try, I think
(15:27:04) mattock: if you have vagrant+virtualbox installed it should wo=
rk
(15:27:06) cron2: mattock: it is always your computing infrastructure :-)=

(15:27:30) mattock: the only thing I could potentially blame is IPv6
(15:27:33) mattock: honestly
(15:27:34) mattock: :D
(15:28:03) mattock: I recently learned that with this particular internet=
 connection I actually have public IPv6 connectivity, which of course bro=
ke things for me which I needed to fix :D
(15:28:27) cron2: fixing IPv6 is very good
(15:28:31) mattock: yeah
(15:28:47) mattock: quite often DNS gives an AAAA record and if firewalls=
 and all that are not set up correctly then boom
(15:28:49) mattock: like today
(15:30:11) ordex: mah
(15:30:20) ordex: discrimination against IPv6 is not allowed!!
(15:30:29) cron2: why do you have outgoing firewall rules...?
(15:30:41) cron2: and why would they disallow IPv6?
(15:30:54) mattock: I don't have outgoing rules
(15:30:55) cron2: there is something wrong in the company culture...
(15:31:12) mattock: ip6tables was accidentally misconfigured
(15:31:17) mattock: but this was not even openvpn inc. stuff
(15:31:35) cron2: too much exposure to the openvpn inc IPv6 negativity, I=
'm sure!
(15:31:38) cron2: anyway
(15:31:42) cron2: shall we aim for next wednesday?
(15:31:47) mattock: more like "it seems to work, good enough"
(15:32:02) mattock: yeah, works for me
(15:32:38) cron2: so, anything else that should go into 2.5.3 (openvpn-bu=
ild is noted)?
(15:34:08) ordex: seems not
(15:38:17) ordex: ipv6 on community?
(15:39:27) cron2: yeah, please!
(15:39:47) ordex: !
(15:40:12) cron2: mattock disappeared after so much IPv6
(15:40:25) cron2: so let's assume "nothing" and jump to the copyright thi=
ng
(15:40:39) cron2: dazo: can you send a patch for 2.5 and master to update=
 copyright messages etc., once again?
(15:41:07) mattock: no progress afaik
(15:43:16) dazo: cron2: sure!
(15:44:03) dazo: cron2: we do have a script checked in which does the job=
 though ... dev-tools/update-copyright.sh
(15:44:22) cron2: dazo: does it update the copyrigtht message printed at =
"--version" too?
(15:44:33) dazo: It should
(15:45:18) cron2: yeah, these are all "2018" as well :)
(15:47:01) cron2: please :-)
(15:47:06) ordex: yeah
(15:47:08) cron2: (seems we missed that before 2.5.0 release)
(15:47:22) dazo: I'll send a patch when I'm back, need to go now
(15:47:32) cron2: thanks
(15:47:39) cron2: (that was all I wanted, so perfect on time)
(15:47:47) cron2: last item: CR_TEXT
(15:49:44) ordex: what is it ?
(15:49:50) cron2: https://patchwork.openvpn.net/patch/1843/
(15:49:52) vpnHelper: Title: [Openvpn-devel,1/2] Improve documentation of=
 AUTH_PENDING related directives - Patchwork (at patchwork.openvpn.net)
(15:50:16) cron2: that patch has an ACK, but a subsequent discussion abou=
t CR_TEXT and "empty response"
(15:50:27) cron2: and I'm not sure if it should go in "as is" or a v2 is =
needed?
(15:51:00) cron2: ah
(15:51:02) cron2: no
(15:51:16) cron2: it's actually "proxy_url" vs. "proxyurl"... and Selva n=
ever got a reply on that question :-)
(15:53:56) ordex: hm
(15:54:04) cron2: plaisthos: this is in your field...
(15:54:50) plaisthos: not used anywhere yet, so we can name what we want
(15:54:54) plaisthos: should be cosistent
(15:55:05) plaisthos: this is a bikeshed where I don't really have an opi=
nion
(15:55:23) cron2: it is your bikeshed after all, so you are entitled to h=
ave one :-)
(15:55:34) plaisthos: openurl_with_proxy_support is something I would obj=
ect for being too long though
(15:55:45) ordex: :D
(15:56:14) cron2: (CR_TEXT was a parallel openvpn-gui thread which got al=
ready sorted out and applied, I just lost track)
(15:57:01) plaisthos: empty response is for something like "press magic b=
utton on your phone to connect"
(15:57:31) plaisthos: with old 2FA the empty response was mandatory to tr=
igger the reconnect basically
(15:57:52) plaisthos: for pending auth, the no real need anymore but spec=
ifying how it should work is good
(15:57:57) plaisthos: even if the server just ignores it=20
(15:58:27) cron2: the client does not reconnect, it just sits there patie=
ntly and waits for the server to tell it "now we're good!"
(15:58:32) cron2: right?
(15:58:55) plaisthos: yes, waits until it gets either a PUSH_REPLY or an =
AUTH_FAILED
(15:59:11) cron2: ok, I got that right :-)
(15:59:19) cron2: now, proxy_url or proxyurl?  your decision, in=20
(15:59:19) cron2: 3
(15:59:21) cron2: 2
(15:59:23) cron2: 1
(15:59:26) cron2: now!
(15:59:36) ordex: proxy_url !
(15:59:49) plaisthos: although you can also directly connect the client a=
nd use pending auth to just allow more ressources=20
(16:00:03) cron2: ordex: wrong "you" :)
(16:00:20) plaisthos: ordex seems to care more about the colour than I do=
 :D
(16:00:39) ordex: :D
(16:01:19) cron2: so, proxy_url it is
(16:03:38) cron2: and with that, we return to "IPv6 to community"... and =
the meeting has to go on until this is answered in a satisfactory way!
(16:06:07) ordex: mattock: !!
(16:06:52) mattock: I already answered it
(16:06:54) mattock: no progress afaics
(16:08:10) mattock: buildbot vise: windows buildbot worker works (in the =
sense that it is able to connect to buildmaster and could in theory do th=
ings)
(16:08:42) mattock: building the windows worker setup automation is mostl=
y ready, but this Visual Studio 2019 component installation failure block=
s things
(16:08:46) mattock: could actually be IPv6 related
(16:09:01) mattock: microsoft download servers might fail if reaching out=
 ot them via IPv6
(16:09:08) mattock: I need to disable IPv6 to see if that helps
(16:09:16) cron2: "no progress" is not satisfactory, you need to meet on =
and on... for ever...
(16:09:36) mattock: well, things will happen naturally when they happen
(16:09:50) mattock: occasional poking is the best I or ordex or anyone el=
se can do
(16:10:02) mattock: unless we resort to violence or something novel :D
(16:11:18) mattock: anyhow
(16:11:20) mattock: anything else?
(16:11:30) ordex: :D
(16:11:32) ordex: I guess this is it
(16:11:33) mattock: bribery might be an option as well
(16:11:36) mattock: :P
(16:11:46) ordex: even though the answer was not satisfactory enough
(16:12:11) cron2: bribery sounds good
(16:12:25) cron2: you could bribe me, and if that is satisfactory, the me=
eting can end :)
(16:13:05) mattock: well, that's actually a novel idea
(16:13:06) ordex: :)
(16:13:26) mattock: perhaps bribing the person who is most afraid of IPv6=
 at openvpn inc. could "grease the wheels"
(16:13:33) mattock: oh
(16:13:40) mattock: I'll create a doodle poll for the hackathon
(16:13:45) mattock: after the summary is done
(16:13:50) mattock: ok?
(16:14:59) cron2: +1
(16:15:21) ordex: cool
(16:15:23) ordex: thanks mattock=20
(16:15:29) cron2: taking openvpn inc money to bribe openvpn inc personell=
 sounds like "pay people a bonus for their job (if well-done)" :-)
(16:18:46) mattock: yeah, I think technically it would not be a bribe
(16:18:59) mattock: hence: perfectly legal
(16:19:23) mattock: writing the summary, assuming meeting has ended
(16:20:19) ordex: :D
(16:20:30) ordex: cron2: although it may work with some people

--------------75ABEC39101799B9867945CD--

