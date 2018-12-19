From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <9a1a18c6-67ff-73ad-69aa-bbb75df45490@...515...>
Message-ID: <07d3e88f-6f34-79b3-7244-a057b0820443@...515...>
Date: Wed, 19 Dec 2018 13:50:24 +0200
MIME-Version: 1.0
In-Reply-To: <9a1a18c6-67ff-73ad-69aa-bbb75df45490@...515...>
Content-Type: multipart/mixed; boundary="------------39968B5DB9F04903EFBB9D9B"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (Wed,
 19th Dec 2018)
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
--------------39968B5DB9F04903EFBB9D9B
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 19th December 2018
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2018-12-19>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, janjust, mattock, ordex, plaisthos, rozmansi and syzzer
participated in this meeting.

--

Mattock has almost finished the work on a Vagrant-based build VM that
will use sbuild_wrapper to produce Debian and Ubuntu packages. This
enables anyone to produce "official" OpenVPN Debian packages without the
effort of setting up the build environment manually.

--

Mattock requested review for a couple of openvpn-vagrant PRs. More are
coming up to openvpn-vagrant as well as to sbuild_wrapper.

--

Discussed tap-windows6 HLK testing / WHQL certification. Stephen has
made good progress in resolving the issues in tap-windows6 that prevent
it from passing the HLK tests. It will take a bit more time to resolve
them, but we're getting there. The person who bragged about having WHQL
certified tap-windows6 has not responded to Stephen/us yet.

--

Discussed Windows VPN API. It will not be a replacement for tap-windows6
driver in the near future for multiple reasons:

- It is immature and buggy
- It performs (even) worse than tap-windows6
- It is client-side only (people do run OpenVPN servers on Windows)
- Microsoft tends to break it accidentally

--

Discussed MSI packaging which is almost ready now: mostly end-user
documentation is missing. Mattock is nearing the point where he can
start testing the whole build/packaging process. It was agreed that we
need thorough testing of the MSI packages. The participants of the
meeting seemed to collectively have a good selections of Windows
versions to test it on.

Test installers by rozmansi are available here:

https://github.com/rozmansi/openvpn/releases

The current ones are a bit outdated, so please wait until tomorrow (20th
Dec) before you try them out.

--

The rate-limiting patches would require review/feedback from syzzer.

--

No progress since last week on the VLAN v2 patchset.

--

Ordex will try to send the "transport-api" patchset to the list this
week or the next. The transport API will allow, for example, writing
obfuscation plugins. The code was sponsored by Google's Jigsaw project
and the code was good, but some cleanups by ordex are required to clean
up the commit history.

--

Agreed that we need to look into MTU handling and deprecation of
--fragment in OpenVPN 2.5 in more detail before making any decisions.
For example, right now 2.4/2.5 code base subtracts too much from the
server-side MTU when compensating for NCP, reducing in performance
reduction of ~10%. Details are available in the chatlog.

Previous discussion about this is here:

https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17966.html

--

Full chatlog attached.




--------------39968B5DB9F04903EFBB9D9B
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2018-12-19.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2018-12-19.txt"

(12:26:28) L'argomento di #openvpn-meeting =C3=A8: Next meeting on 24/Oct=
/2018 at 11:30CEST. Agenda at https://community.openvpn.net/openvpn/wiki/=
Topics-2018-12-12
(12:26:28) L'argomento per #openvpn-meeting =C3=A8 stato impostato da daz=
o!~freenode@...1423.../corp/developer/dazo a 12:37:08 su 12/12/2018
(12:26:34) mattock: hi
(12:30:26) rozmansi [sid334387@...2315.../web/irccloud.com/x-okfxlucegyhkaba=
d] =C3=A8 entrato nella stanza.
(12:30:34) rozmansi: hi
(12:31:01) mattock: hi rozmansi!
(12:31:10) syzzer: hi :)
(12:31:32) mattock: hi
(12:32:07) cron2: re
(12:32:18) cron2: sorry for being late
(12:32:24) cron2: had a meeting :)
(12:32:25) mattock: no problem, only two minutes
(12:32:44) mattock: anyone else joining today?
(12:34:51) janjust [~janjust@...1423.../community/support/janjust] =C3=A8 en=
trato nella stanza.
(12:35:16) cron2: mornin' janjust :)
(12:35:21) janjust: morning folks
(12:35:30) janjust: it's been a while :)
(12:35:36) rozmansi: morning
(12:36:07) janjust: has the meeting started yet?
(12:36:31) cron2: mattock1: please start :)
(12:36:35) plaisthos: hi
(12:36:42) dazo: Hey!
(12:36:53) mattock: let's go
(12:37:13) mattock: anything to add to the topic list? https://community.=
openvpn.net/openvpn/wiki/Topics-2018-12-19
(12:37:15) vpnHelper: Title: Topics-2018-12-19 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:37:33) janjust: I am here to talk about fragment+mtu things ...
(12:37:58) cron2: oh, lots of new items on the agenda
(12:37:58) mattock: ok
(12:38:14) mattock: I'll cover #1 quickly
(12:38:45) dazo: Since janjust is here just for the mtu/fragment stuff ..=
=2E lets squeeze that in afterwards
(12:38:55) mattock: so I have a Vagrant VM almost ready sets up sbuild_wr=
apper and the build schroot and allows Joe Random to build the Debian/Ubu=
ntu packages
(12:39:09) mattock: includes patches to openvpn-vagrant and sbuild_wrappe=
r
(12:39:11) mattock: that's it
(12:39:13) janjust: I'm interested in the other stuff as well - squeeze i=
t whenever
(12:39:26) mattock: dazo: problem solved already
(12:39:30) mattock: :P
(12:39:39) cron2: mattock1: nice!
(12:39:50) mattock: as for #2: if somebody could review those PRs that wo=
uld be good
(12:39:57) mattock: not necessarily now but soon
(12:40:01) ***cron2 wonders why he's not seeing the PRs
(12:40:29) mattock: dazo's comments about openvpn-build-bionic bootstrapp=
ing have been covered and the second one is trivial
(12:40:39) mattock: oops
(12:40:43) mattock: other link is wrong, will fix
(12:40:58) cron2: it tells me that I'm seeing them, but I haven't seen an=
y mail.  Anyway.  Yes.
(12:41:20) cron2: ah, it's fairly old already.  on my plate.
(12:41:34) mattock: ok
(12:41:37) dazo: I had comments about openvpn-build-bionic? .... hmmm ...=
=2E probably long ago :)
(12:41:37) mattock: we can move on
(12:41:48) mattock: dazo: indeed, this is why I'm pushing this a bit :)
(12:41:50) dazo: I've tried to get lev__'s attention
(12:41:51) cron2: dazo: it was october/november
(12:42:36) cron2: wrt #3 - ordex has sent a new patchset yesterday evenin=
g/this morning
(12:42:44) mattock: https://github.com/OpenVPN/openvpn-vagrant/pull/5
(12:42:45) cron2: so we have review work to do
(12:43:40) mattock: cron2: does that cover #3?
(12:43:43) cron2: mattock1: #5 has been merged :)
(12:43:46) mattock: great!
(12:44:26) cron2: mattock1: unless ordex shows up or someone else wants t=
o comment on the "networking API" agenda item, I think #3 is covered
(12:44:46) mattock: #4 is also quick
(12:44:48) dazo: It is progressing, that's the important detail
(12:44:52) mattock: +1
(12:45:16) janjust: FTR, what is "tap-windows6 HLK testing"
(12:45:39) mattock: #4 stephen has made progress again with tap-windows6 =
and the guy who bragged about having WHQL certified tap-windows6 has not =
responded to him
(12:45:57) cron2: janjust: openvpn.inc is paying a windows developer "who=
 understands things" to get the tap6 driver into shape where it passes th=
e windows <acronyms_here> tests you need for a signature today
(12:46:07) mattock: for windows server 2016 in particular
(12:46:15) mattock: desktop operating systems are easy/easier
(12:46:22) janjust: thx cron2
(12:46:27) cron2: you can't sign drivers yourself anymore (details omitte=
d) but need to pass a very strict and very long test, which our driver di=
dn't yet do
(12:46:35) mattock: that's the condensed version without all the blood an=
d tears and frustration
(12:46:49) cron2: we found someone who is good at this, but unfortunately=
 he's also very busy with being good at other things :-) - so it's slow
(12:47:09) mattock: but it's not like we're in a terrible hurry, as long =
as the job gets done
(12:47:16) mattock: we've had this problem since June or so
(12:47:30) cron2: the end goal is "have a better driver which fixes a few=
 bugs and installs without pains on all supported windows version"
(12:47:56) mattock: or with minimal pain
(12:48:00) cron2: yep
(12:48:15) ***ordex is here!
(12:48:23) ordex: sorry - I had to run to buy some icecream!
(12:48:25) mattock: no pain would involve a boatload of WHQL certificatio=
ns (all supported Windows versions)
(12:48:29) janjust: is the driver still needed for win 10 & 2016?  would =
it be possible to phase it out?
(12:48:36) mattock: not at the moment
(12:48:48) mattock: the VPN API in Windows 10 is too immature
(12:48:53) mattock: plus I believe it is client-side only
(12:49:09) rozmansi: and totally undocumented
(12:49:15) mattock: and that
(12:49:29) mattock: I know lev__ endured a lot of pain writing OpenVPN Co=
nnect to use that VPN API
(12:49:42) mattock: an MS keeps breaking the API as well
(12:49:51) dazo: "immature" is a very diplomatic and polite word
(12:49:57) ordex: yeah and MS is still working on providing fixes
(12:50:06) mattock: dazo: are you saying it sucks?
(12:50:08) janjust: ah OK, good to know... and M$ being immature and brea=
king everything seems to be common nowadays
(12:50:28) dazo: mattock1: currently our current tap-windows6 driver perf=
orms better
(12:50:33) mattock: oh that one as well
(12:50:53) mattock: and our tap-windows6 driver does not perform _that_ w=
ell tbh
(12:50:59) janjust: hm and performance of the tap-win6 driver wasn't too =
good to begin with...
(12:51:08) janjust: lol , you  beat me to it, mattock1=20
(12:51:09) dazo: exactly ;-)
(12:51:11) mattock: :)
(12:51:25) mattock: anything else on tap-windows6 which we have to live w=
ith for years to come?
(12:52:37) rozmansi: #5 now?
(12:52:40) dazo: on the plus-side, MSFT has been receptive to our feedbac=
k and have acknowledged much of our remarks ... and they have fixed thing=
s .... but they managed to break the VPN API completely with the latest W=
indows update
(12:52:43) mattock: works for me
(12:52:44) dazo: yeah
(12:53:20) mattock: quick update on my end: so I finally had a change to =
return to the wonderful world of building and packaging stuff
(12:53:37) mattock: slash OpenVPN 2.x project stuff
(12:53:54) mattock: so I will soon (before end of the year) be able to pr=
operly test and play with the MSI packaging
(12:54:06) mattock: it just requires quite a bit of background work
(12:54:20) cron2: dazo: *lol*
(12:54:23) mattock: rozmansi: any updates at your end?
(12:54:24) rozmansi: mattock1: if there's anything I can modify, to make =
your life easier, just tell me
(12:54:36) rozmansi: the msi packaging is mostly complete
(12:54:45) mattock: rozmansi: at this point nothing, but I'm sure somethi=
ng will come up
(12:54:59) cron2: the "merging of the 473 rozmansi patches" is on my plat=
e
(12:55:03) rozmansi: I have some unsubmitted patches still (uncrustify an=
d some minor enhancement) for openvpn repo
(12:55:08) mattock: I would love to vagrantify the MSI builder VM as well=
, but Windows VMs are always a big pain in Vagrant
(12:55:17) mattock: mostly due to lack of good base images
(12:55:52) rozmansi: I still owe us a good documentation how to use MSI p=
ackages.
(12:55:57) mattock: and using a cloud provider would involve costs (for o=
ther people, that is)
(12:56:13) mattock: docs would be very good to have
(12:56:17) rozmansi: This is now my top priority. Comes up after holiday =
season unfortunately.
(12:56:32) mattock: seems like that won't be a problem given our schedule=

(12:56:55) rozmansi: last thing from my side: MSI packages needs real-wor=
ld testing
(12:57:16) mattock: upgrades will probably be the most problematic part
(12:57:17) rozmansi: I have tested them thorouglhy myself, but that doesn=
't count
(12:57:26) mattock: agreed
(12:57:26) janjust: rozmansi, I can do testing on Windows XP & 2000 :)
(12:57:34) mattock: lol
(12:57:47) janjust: but seriously, I *can* test MSI packages on Win7=20
(12:57:47) mattock: well I guess the MSI could work
(12:57:49) rozmansi: Nope. They are targeted for Windows 7, though it sho=
uld still support Vista
(12:58:25) cron2: I have an XP VM as well \o/
(12:58:31) cron2: (but this is a very non-goal)
(12:58:34) rozmansi: Excellent. I have some binaries already prepared at =
https://github.com/rozmansi/openvpn/releases
(12:58:36) mattock: we can go through the usual dance of "send download l=
inks to ml, ask to test, get two responses, notice after release that eve=
rything is broken" :)
(12:58:36) vpnHelper: Title: Releases =C2=B7 rozmansi/openvpn =C2=B7 GitH=
ub (at github.com)
(12:59:00) cron2: mattock1: well-established process!
(12:59:17) mattock: rozmansi: oh nice! I will note that link in the summa=
ry
(12:59:21) janjust: rozmansi, so which files need testing?  the 2 MSI fil=
es or the .exe as well?
(12:59:22) rozmansi: mattock1: agreed.
(12:59:37) rozmansi: The .exe is a package of both .msi files
(13:00:02) rozmansi: .exe =3D sfx + arch detect bootstrapper to launch co=
rrect .msi
(13:00:10) janjust: cute: 4.35 MB + 3.8 MB =3D 4.76 MB :)
(13:00:17) rozmansi: 7zip compression
(13:00:39) cron2: nice
(13:00:39) mattock: cron2: seriously: we are able to test on Windows 8.1,=
 Windows 10, Windows Server 2012r2 and Windows Server 2016
(13:01:04) janjust: I'll run an install test on Win7
(13:01:11) cron2: mattock1: I can test win7/64.  My win7/32 machine selfd=
estructed in august and I had no time to repair it yet
(13:01:23) mattock: rozmansi: openvpnserv2.exe is now an optional feature=
, right?
(13:01:25) cron2: (like in "it bluescreens at boot and windows forgot to =
put up a recovery point")
(13:01:55) rozmansi: If you give me a couple of hours, I shall put up the=
 latest version of MSI packages, then you start testing. Those published =
currently have quite some flaws and strategy changes from what I have now=
 in my latest version.
(13:01:55) mattock: I have a Windows 7 64-bit laptop I can use
(13:02:06) rozmansi: mattock1: righ
(13:02:18) mattock: rozmansi: upgrading the packages would be most good
(13:02:28) janjust: whoops. ok rozmansi ; rm OpenVPN-install-2.4.6-I602.e=
xe
(13:02:33) mattock: I will note that in the summary as well ("wait until =
tomorrow to test these")
(13:02:50) rozmansi: mattock1: thanks
(13:02:59) mattock: anything else on MSI?
(13:03:13) janjust: rozmansi, add the milestone flag to the filename, tha=
t will make it easier to refer to the correct version
(13:03:21) rozmansi: mattock1: that would be all from my side - yes openv=
pnserv2.exe is now optional
(13:03:28) rozmansi: optional =3D non-default
(13:03:31) mattock: \o/
(13:03:58) rozmansi: janjust: thanks, will do that
(13:04:56) rozmansi: I would really like to polish and test MSI thoroughl=
y, as things get very ugly should anything break on the end-user computer=
=2E
(13:06:03) mattock: would this be a good time to discuss fragmentation?
(13:06:09) mattock: or can the remaining topics covered quickly?
(13:06:14) janjust: fine with me
(13:06:25) cron2: #6 is fairly quick
(13:06:31) mattock: let's do that
(13:06:42) cron2: syzzer: can you find a few minutes to think about these=
 patches and give feedback? :-)
(13:06:45) cron2: "done"
(13:06:55) mattock: VLAN v2?
(13:06:58) cron2: (the long and detailed explanation of the "what and why=
" is in last week's protocol)
(13:07:07) cron2: no progress on the vlan patches
(13:07:20) cron2: at least "no visible progress" - ordex: ?
(13:07:29) mattock: btw. did someone receive the meeting summary from las=
t week or did SF.net eat it?
(13:07:35) janjust: hmm syzzer not available? pity, as some of my MTU ran=
ts are related to NCP
(13:07:52) mattock: syzzer was here in 35 minute ago
(13:07:54) cron2: he said "hi" 36 minutes ago
(13:07:55) cron2: :)
(13:08:18) plaisthos: .oO(probably idling as I do)
(13:08:26) janjust: I can't find the meeting summary from last week in my=
 mail=20
(13:08:40) janjust: but that does not say too much :)
(13:09:03) ordex: cron2: nothing visible
(13:09:07) ordex: sorry
(13:09:14) ordex: it's next on the todo list
(13:09:19) ordex: togther with plaisthos' patches
(13:09:28) cron2: cool
(13:09:29) mattock: janjust: I think SF.net ate it - I received a warning=
 email from there
(13:09:33) mattock: let me resend
(13:09:34) ***cron2 todo list has "ipv6-only"
(13:09:36) ordex: so will land somewhen in the following days
(13:09:44) cron2: like "next days"
(13:09:56) ordex: another thing I wanted to say is that I will probably s=
end the "transport-api" patches this week or the next
(13:10:11) cron2: christmas presents
(13:10:15) janjust: what patches are those, ordex?
(13:10:46) ordex: janjust: jigsaw project (sponsored by google): providin=
g transport-api so that anybody can write his own plugin implementing the=
 obfuscation he wants
(13:10:49) janjust: transport-api sounds interesting and sounds like an i=
dea that has been lurking in my mind for a while - if only I can find tim=
e to implement it
(13:11:20) ordex: I have to make them "presentable" (now they are a bunch=
 of commits with less than ideal order, but good code) and then I will se=
nd them to the ml
(13:11:29) janjust: ok cool
(13:11:36) mattock: resent
(13:12:51) dazo: okay, just got a msg from lev__ he is out in a meeting
(13:13:16) janjust: Hehe, and lev__ was the other person I wanted to talk=
 to about the MTU/fragment stuff
(13:14:19) dazo: yeah, but I think with cron2, ordex and plaisthos presen=
t ... we can cover most of the needed details anyhow ... plaisthos (and o=
rdex?) been reviewing his approaches fairly detailed anyhow
(13:14:34) plaisthos: I probably need to go in 10 minutes
(13:14:52) dazo: okay ... 10 min mtu/fragment discussion now :)
(13:14:55) janjust: okay
(13:15:05) cron2: I admit I haven't spent time on the fragment discussion=
 yet :-/
(13:15:17) cron2: (I saw the mails and had them tagged for "when brains a=
re back")
(13:15:36) dazo: but you know a lot about the challenges ... and you were=
 part of the discussion here on irc a few weeks ago :)
(13:16:19) janjust: let's start with the MTU thing first:   the mtu setti=
ng on an OpenVPN 2.4 server is a bit too low; if you fix the link-mtu @ 1=
500 (which is what you get without fragment, really) then the tun-mtu =3D=
 1379=20
(13:16:29) janjust: that is to account for the maximum crypto overhead
(13:16:44) janjust: but the calculation of the maximum crypto overhead is=
 WAY too conservative
(13:17:03) cron2: syzzer: *poke* *poke*
(13:17:22) janjust: lev__ posted a minor patch to work around this if a u=
ser specifies --ncp-disable , and that patch gives me a 10% throughput bo=
ost
(13:17:24) dazo: right, I remember lev__ looking into this, and found thi=
s was related to the NCP stuff
(13:17:33) dazo: ouch, that's a lot
(13:18:08) janjust: yes, on an older machine on a gigabit link performanc=
e went from ~450 Mbps to ~500 Mbps with aes256gcm
(13:18:37) ordex: not bad
(13:18:52) ordex: I think that due to ncp, buffers are allocated earlier =
and they account for the very worse case that might be chosen
(13:18:54) janjust: nope, esp as it's "only" a sandybridge CPU
(13:19:06) janjust: yes, but the "worst case" is calculated FAR too conse=
rvative
(13:19:31) janjust: plus, the crypto overhead calculation for GCM modes i=
s off by 12 bytes at any rate
(13:19:32) dazo: so the crypto overhead is estimated to be too low .... g=
ot an idea what we miscalculate .... how get it so wrong?
(13:19:48) plaisthos: janjust: sure?=20
(13:19:52) janjust: yes
(13:19:52) cron2: syzzer is hiding :(
(13:20:10) cron2: plaisthos: I've seen mails about this - we include spac=
e for the HMAC, but there is none
(13:20:12) ordex: well, if this point is "clear", we can still pester him=
 later :]
(13:20:29) dazo: true :)
(13:20:36) ordex: isn't it because with ncp we might still choose an algo=
rithm that needs HMAC?
(13:20:40) janjust: first we calculate the MTU size the "old way" . and t=
hen in init.c we subtract the "crypto_max_overhead()"
(13:21:21) dazo:     return packet_id_size(true) + OPENVPN_MAX_IV_LENGTH
(13:21:21) dazo:            +OPENVPN_MAX_CIPHER_BLOCK_SIZE
(13:21:21) dazo:            +max_int(OPENVPN_MAX_HMAC_SIZE, OPENVPN_AEAD_=
TAG_LENGTH);
(13:21:27) janjust: and in "crypto_max_overhead()" we assume the worst an=
d subtract the maximum crypto+hash size , not taking into account that we=
 already adjusted for the *current* crypto+mac
(13:21:28) dazo: that's crypto_max_overhead()
(13:21:31) plaisthos: 1500-4(id/op)-32(authtag)-8byte(?iv) is still way l=
arger what we sure
(13:22:11) janjust: now you will only really see this when you fix the li=
nk-mtu (which is what you end up doing when throwing out --fragment)
(13:23:09) janjust: but without lev__'s patch, tun-mtu on the server side=
 ends up as 1379 ; with the patch, it is 1451 bytes
(13:23:17) janjust: that accounts for most of the 10% perf diff
(13:24:02) janjust: and we can make it go even higher if we would calcula=
te the crypto overhead correctly for GCM modes
(13:24:53) dazo: If I've read packet_id_size(true) correctly, that will r=
eturn 3 (sizeof uint8_t + uint16_t)
(13:25:02) janjust: yes
(13:26:26) janjust: OPENVPN_MAX_IV_LENGTH=3D16 ; +OPENVPN_MAX_CIPHER_BLOC=
K_SIZE=3D32; OPENVPN_MAX_HMAC_SIZE=3D64
(13:27:03) dazo: hmmm ... when the connection starts .... what is the cip=
her *before* NCP hits you?
(13:27:31) janjust: in my config it was aes-256-cbc+sha256
(13:28:08) janjust: so we subtracting 3+16+32+64 =3D 115 bytes
(13:28:11) dazo: hmmm .... that should have a bigger overhead than gcm if=
 NCP pushes --cipher
(13:29:11) janjust: also, if the server has ncp-disable then there is no =
worse case scenario; plus, even if we do have NCP then we can calculate t=
he maximum overhead based on the allowed ciphers, NOT on the absolute wor=
st case
(13:29:38) plaisthos: crypto_max_overhead is basically static
(13:29:50) janjust: yep, so I guess we need to make it more dynam
(13:29:55) janjust: *dynamic
(13:29:57) plaisthos: janjust: no
(13:29:59) cron2: can someone please put this on the "must fix for 2.5" p=
age?
(13:30:06) dazo: But is the frame size adjusted at all after NCP changes =
the cipher?
(13:30:07) ***cron2 needs to leave now (next meeting starts *now*)
(13:30:08) plaisthos: why would you do that?
(13:30:11) janjust: mattock1, I just received the summary
(13:30:25) plaisthos: crypto_max_overhead is used to calculate the maximu=
m overhead and adjust buffer accordingly
(13:30:31) mattock: janjust: sent it again
(13:30:33) janjust: dazo, on the client size: yes.  on the server side: n=
o
(13:31:01) janjust: plaisthos, but the maximum overhead will always depen=
ds on the list of allowed ciphers
(13:31:08) plaisthos: janjust: no
(13:31:13) janjust: if I never use any SHA512 macs then we don't need to =
adjust for that
(13:31:36) mattock: cron2: good luck with your next meeting!
(13:32:03) plaisthos: janjust: the problem is probably not the buffers be=
ing a few bytes to big here
(13:32:05) janjust: plaisthos, no? in what scenario can the server end up=
 with a cipher that is NOT listed in the config file or in the NCP list
(13:32:14) plaisthos: janjust: client-connect script
(13:32:36) plaisthos: ccd file
(13:33:03) dazo: but ... is that even accepted?  If the the ccd file uses=
 a cipher not enlisted in --ncp-ciphers?
(13:33:08) janjust: ah true, but we could rule that out also then (i.e. i=
f no CCD option is given then be less conservative)
(13:33:09) plaisthos: sure
(13:33:18) janjust: dazo, yes, that is allowed, I believe
(13:33:20) dazo: that sounds more like a bug than a feature
(13:33:20) plaisthos: need to run
(13:33:50) janjust: I'll check whether it is supported and whether it act=
ually *works*
(13:34:48) ***ordex pulls his hair
(13:34:54) janjust: at any rate, if we are to deprecate things like --fra=
gment (which I still object to) then we need to be 200% sure that we are =
not overcompensating for crypto overhead
(13:35:09) dazo: that's a side track of this discussion ... but important=
 to have worked out the semantic here if we want to change how crypto_max=
_overhead() works
(13:35:35) janjust: as most of this crypto overhead compensation is smoth=
ered by --fragment / a link-mtu being far higher than 1500 bytes
(13:37:00) dazo: smothered ... or hiding a bug ... not sure which yet ;-)=

(13:37:58) mattock: so what is the conclusion?
(13:38:07) mattock: "need to resolve MTU issues somehow"? :)
(13:38:08) dazo: janjust: if you get a chance to verify whether using non=
-ncp-listed cipher works with ccd, that's a good detail to know
(13:38:11) janjust: "more investigation is needed"
(13:38:14) dazo: :)
(13:38:17) mattock: ok good enough for me
(13:38:18) janjust: dazo, will do
(13:38:22) dazo: thx a lot!
(13:39:18) janjust: and the second part of the conclusion is:  the openvp=
n 2.4/2.5 code base subtracts too much from the server-side MTU when comp=
ensating for NCP stuff
(13:41:19) mattock: ok good
(13:41:27) mattock: I think we're done unless somebody has something real=
ly important :)
(13:41:34) mattock: 11 minutes overtime
(13:41:50) ***janjust will shut up for now :)
(13:42:20) rozmansi: Merry Christmas to everyone and a Happy New Year :)
(13:42:24) dazo: janjust: did you have any other comments in regards to -=
-fragment?  Other than what's discussed on the ML ... or questions relate=
d to it?
(13:42:36) dazo: rozmansi: best wishes to you too!
(13:42:50) rozmansi: see you
(13:42:57) rozmansi: gotta run
(13:43:20) rozmansi ha abbandonato la stanza.
(13:45:20) ***janjust will shut up for now. Perhaps more questions/commen=
ts will arise when I've dug into the mtu overhead stuff=20
(13:45:33) janjust: dazo:  Perhaps more questions/comments will arise whe=
n I've dug into the mtu overhead stuff=20
(13:45:48) mattock: sounds good

--------------39968B5DB9F04903EFBB9D9B--

