From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <3898de1c-1799-46f3-2ec2-55f70fa04679@...515...>
Message-ID: <ddb3d046-5e32-4987-1b5b-4ab260060fd0@...515...>
Date: Wed, 10 Mar 2021 13:35:17 +0200
MIME-Version: 1.0
In-Reply-To: <3898de1c-1799-46f3-2ec2-55f70fa04679@...515...>
Content-Type: multipart/mixed; boundary="------------64449F609759B77BAEDFFB5F"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (10th March 2021)
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
--------------64449F609759B77BAEDFFB5F
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 10th March 2021
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2021-03-10>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock, ordex and plaisthos participated in this meeting.

---

Plaisthos is working on the Windows side of DCO. The Linux part is 
waiting for the patch backlog to clear. Besides that the Linux part is 
ready except that some fringe cases might still not work and some 
cleanups would be in order.

Once plaisthos gets DCO integrated with the Access Server then OpenVPN 
Inc. QA will start their testing it. This will also help on the 
community side.

---

Noted that FIPS support is now ready.

---

Agreed that Wednesday 17th March 2021 is a reasonable release date for 
OpenVPN 2.5.2. The CVE numbers are in the works and GPG signing key 
renewal has been completed. FreeBSD and Debian package maintainers have 
been given a heads up.

---

Noted that community.openvpn.in does not support IPv6.

---

Agreed that the fix to the mbedTLS 2.25.0 crashbug is reasonable. We'd 
like to get syzzer's approval, though.

---

Full chatlog attached

--------------64449F609759B77BAEDFFB5F
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2021-03-10.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2021-03-10.txt"

(12:29:25) mattock: hi
(12:30:17) cron2: ho!
(12:31:26) plaisthos: moin moin
(12:31:43) dazo: hey!
(12:32:29) cron2 ha scelto come argomento: Agenda https://community.openv=
pn.net/openvpn/wiki/Topics-2021-03-10
(12:33:47) Pippin_ [~Pippin_@...2600...] =C3=A8 entrato nella stanza=
=2E
(12:34:56) mattock: ok are we ready?
(12:35:16) cron2: ordex and lev__ are missing...
(12:35:30) ordex: here here
(12:35:31) ordex: sorry
(12:35:54) cron2: then let's start :-)
(12:36:22) notafile ha abbandonato la stanza (quit: Quit: Bridge terminat=
ing on SIGTERM).
(12:36:47) mattock: yes
(12:36:52) mattock: sync up
(12:37:07) mattock: lev is on vacation btw
(12:37:09) dazo: lev__ is on holiday
(12:37:15) mattock: haha, I was faster
(12:37:18) mattock: :)
(12:37:21) dazo: :-P
(12:37:24) cron2: okay, so...
(12:37:27) cron2: 2.6/master
(12:37:42) cron2: I'm working my way through the "delayed auth" patchset,=
 and might eventually get there :-)
(12:38:44) cron2: then, SRV, and possibly "OOM handling revisit"
(12:39:53) dazo: OOM?
(12:40:22) ordex: the M_FATAL on alloc failure ?
(12:40:25) cron2: when we hit out of memory, and memory is really short, =
it's possible that we hit OOM again on our way towards an "orderly cleanu=
p"
(12:40:35) cron2: and then we start looping and filling syslogs
(12:40:59) cron2: https://community.openvpn.net/openvpn/ticket/1390
(12:41:27) dazo: thx!
(12:42:08) cron2: so any news from the DCO side?  or anything else relate=
d to 2.6/master?
(12:42:34) ordex: plaisthos is working on the windows part now
(12:42:50) ordex: the linux part is kind of "on-hold" but I don't know wh=
at's required to get it "done"
(12:43:02) cron2: who is holding it?
(12:43:05) ordex: plaisthos is also worried that sending more patches to =
the ml will just not look good
(12:43:29) ordex: so he was hoping that our backlog could be cleaned up b=
efore sending the dco patches
(12:43:48) cron2: yeah, we need to get patchwork into a proper state agai=
n.  There's the fingerprint patchset, and I think some sort of "cleanup/r=
efactor" of TLS stuff
(12:44:13) cron2: volunteers on this one?  https://patchwork.openvpn.net/=
project/openvpn2/list/?series=3D907
(12:44:15) vpnHelper: Title: OpenVPN 2 - Patchwork (at patchwork.openvpn.=
net)
(12:44:21) cron2: (that's the fingerprint stuff)
(12:44:35) ordex: for FIPS we are done, right ?
(12:44:44) plaisthos: cron2: I am fithgint against windows overlapped i/o=
 on the dco side
(12:44:45) cron2: it's a bit political ("do we want to go there?") and lo=
ts of "is the implementation sane"
(12:45:16) cron2: ordex: I think so, yes.  The "waht to do with mbedTLS d=
ebugging?" is pending a decision and/or feedback from them
(12:45:25) plaisthos: For the linux parts there is basically more testing=
 required and some more fringe features might be broken but otherwise it =
is kind of done
(12:45:37) cron2: very nice
(12:46:12) notafile [notafilema@...2315.../shell/matrix.org/x-cnbxilqmymxgdw=
vb] =C3=A8 entrato nella stanza.
(12:46:16) plaisthos: it is still rough in some parts and might require s=
ome clean up but all the code is there
(12:46:20) dazo: I can also spin up some Fedora Copr builds on the openvp=
n-git repo, giving installable packages for daring users
(12:46:52) plaisthos: dazo: doesn't make sense yet
(12:47:02) plaisthos: either user can compile it themselves or they can't=

(12:47:21) dazo: okay, more time for me to do other things in the mean ti=
me :-P
(12:47:28) plaisthos: and unless we also package ovpn-dco there is no sen=
se in prebuilding just openvpn+dco
(12:48:20) cron2: has there been feedback from the "Linux Kernel" people?=
  or have you not submitted it yet?
(12:48:34) ordex: not submitted
(12:48:44) ordex: we have to test omre
(12:48:45) ordex: more
(12:48:48) dazo: yeah, we have a few "tail chasing" challenges now relate=
d to openvpn3-linux repos, where the ovpn-dco stuff resides .... and we'r=
e not yet ready with another openvpn3-linux release
(12:48:49) ordex: add more features hopefully
(12:48:59) ordex: so until we have openvpn2 running with it, we can't get=
 there
(12:49:52) cron2: okay
(12:50:28) cron2: I'll focus on the "delayed auth" patchset, and after th=
at maybe I can spin up a test rig for openvpn2-dco-server and see in whic=
h intersting ways I can break it
(12:50:34) ordex: the userbase is basically 3 people at the moment, we ne=
ed more ;p
(12:50:48) cron2: "ship it with the next AS release"
(12:51:04) dazo: hehehe
(12:51:07) cron2: so... cleanup of patchwork... any volunteers on the "fi=
ngerprint" patchset?
(12:51:09) ordex: +1
(12:51:22) ordex: I can jump on it
(12:51:26) ordex: since I am done with fips
(12:51:30) ordex: and I like that thing
(12:51:46) ordex: will delegate to me
(12:52:08) ordex: done
(12:52:32) plaisthos: ordex: if it doesn't apply cleanly anymore I can re=
send a rebased version
(12:52:44) ordex: sure
(12:52:45) ordex: will check
(12:53:05) cron2: ordex: great, thanks
(12:53:19) cron2: but somewhat more serious - can corp QA help with DCO?
(12:53:27) cron2: or is it not yet in that stage?
(12:53:51) ordex: probably can
(12:53:51) ordex: and will
(12:53:59) ordex: especially once arne gets an AS running with dco
(12:54:16) plaisthos: yeah
(12:54:27) plaisthos: I have a hacky AS version with dco
(12:54:32) cron2: nice
(12:54:43) mattock: I'm aiming to reduce the workload of corp QA in the c=
oming months: krzee and I will convert a huge bunch manual test "playbook=
" into automated tests=20
(12:54:46) plaisthos: but it requires either multihome or multiple socket=
s to be a drop in replacements
(12:54:49) mattock: will not help us now, but in the future
(12:54:53) plaisthos: and also lot of ui and handholding
(12:54:54) ordex: plaisthos: why not focus on that and get it to QA befor=
e going full spin on windows? (even though you are there already)
(12:55:13) ordex: plaisthos: ah multihome is a must ?
(12:55:22) ordex: AS always has more than one IP ?
(12:55:32) plaisthos: well. Or even more refactoring on AS side
(12:55:49) plaisthos: basically by default AS listens on 0.0.0.0 with mul=
tihome
(12:55:58) ordex: ok, we can discuss in some corp meeting then
(12:56:01) plaisthos: so not having multihome would probably break some s=
etups
(12:56:44) ordex: ok, that's coming, so we can wait for it
(12:56:59) plaisthos: but next AS release 2.9 will not have it anyway
(12:57:09) plaisthos: that is basically feature frozen at this point
(12:57:28) ordex: plaisthos: sure sure, the point was crafting something =
that can be tested by corp QA
(12:57:33) ordex: to extend the coverage of testing
(12:57:44) plaisthos: yeah that can work
(12:57:52) cron2: "next AS release" brings us to 2.5.2, I think... :-)
(12:57:53) ordex: yap, so we can have more people find unreasonable bugs =
;p
(12:58:12) dazo: :-D
(12:58:41) dazo: unreasonable .... or "oh, is that also a feature being u=
sed?" :-P
(12:59:08) ordex: :D
(12:59:16) cron2: does "next wednesday" still stand for the AS and OpenVP=
N 2.5.2 release?
(13:00:05) plaisthos: need to check with novaflash
(13:00:20) plaisthos: but I think so
(13:00:21) dazo: I think that is more doable now, if mattock has all he n=
eeds for spinning of the release machinery
(13:00:32) dazo: *off
(13:00:42) mattock: I did not test the new security gpg key, but assuming=
 it works there are no blockers
(13:01:16) cron2: dazo: did you make progress with the CVE numbers?
(13:01:44) dazo: cron2: yes, we have a solution now ... there are just so=
me minor things needed to be sorted out and we're good.
(13:02:04) dazo: I'll keep you posted when the number is ready
(13:02:23) cron2: cool
(13:02:46) cron2: I'll prepare everything tuesday evening and can push to=
 mattock's tree early wednesday
(13:03:55) cron2: plaisthos might want to look into the new thing reporte=
d to security@ - if that is easily fixable, maybe we can get it into 2.5.=
2 as well
(13:04:03) dazo: I'll schedule the Fedora repos as well, so when tarball =
+ sig is ready, I can kick it off.
(13:04:15) mattock: cron2: ok
(13:04:41) mattock: btw. I'm looking into the NSIS snapshot builder (open=
vpn-build buildslave) now
(13:05:14) cron2: debian package maintainer has been pre-warned, freebsd =
is m-a, so I'll catch him when we're sure about release (-> novaflash ACK=
s)
(13:05:16) mattock: it was down (intentionally but mistakenly shut down b=
y another person) so now it is up
(13:05:31) mattock: need to fix some issues with it though
(13:05:45) cron2: that was easy... :-) (and your monitoring needs some lo=
ve)
(13:05:56) mattock: what monitoring?
(13:05:58) mattock: :P
(13:06:11) cron2: which, btw, mentions that we have no IPv6 on community.=
=2E.
(13:06:35) mattock: yep, I've heard that issue has persisted quite a whil=
e
(13:06:37) mattock: :D
(13:06:56) cron2: ok, let's not loose time on that now
(13:07:13) dazo: I wonder if they're about to skip IPv6 and awaits IPv7 i=
nstead ....
(13:07:26) plaisthos: dazo: can you give me the security key
(13:07:30) dazo: plaisthos: sure!
(13:07:34) plaisthos: so I can look into the thing that cron2 said?
(13:07:46) cron2: I offered to implement IPX in OpenVPN, but there is no =
currently-maintained unix OS that still supports IPX...
(13:08:05) dazo: :-D
(13:08:41) dazo: cron2: you know that's quite telling of your age when yo=
u get that kind of offers :-P  /me ducks
(13:09:33) cron2: I had to implement IPX routing for one client at a time=
 (over GRE tunnels between Ciscos) and Appletalk routing for a different =
client (using Telebit routers that could do it natively)...
(13:09:51) cron2: never got to do Banyan Vines or DECnet, alas!
(13:09:59) dazo: :-D
(13:10:09) cron2: and yeah, I'm old, and now I'm going to tell stories of=
 the time before the war...
(13:10:13) cron2: ;-)
(13:10:18) cron2: shall we return to the agenda?
(13:10:23) mattock: yes, I was about to ask
(13:10:27) plaisthos: does windows still support IPX?
(13:10:29) dazo: I remember the join when turning off an IPX network with=
 a Novel server back in the late 90s :-P
(13:10:46) plaisthos: I remember that games required IPX to work
(13:10:52) dazo: oh, true!
(13:11:04) dazo: but .... agenda!  history session is done :-P
(13:12:35) mattock: did we agree something on #3: mbedTLS 2.25.0 crash bu=
g / patch ?
(13:12:36) cron2: so, mbedTLS 2.25.0 crashbug... where do we want to go? =
 Given that we do not know (yet) if 2.26.x will have this fixed, or if th=
ere will be a 2.25.1 with the fix, doing "we only do something #ifdef MBE=
D_VERSION =3D 2.25.0" doesn't sound a good approach
(13:13:03) cron2: that is #4 on my agenda :)
(13:13:23) mattock: on mine as well, now that I re-read it
(13:13:25) mattock: :)
(13:15:49) plaisthos: so I think the reduce log level to 2 when we don't =
need it part is good
(13:15:58) cron2: yeah
(13:16:02) cron2: I need to drop out, sorry
(13:16:06) plaisthos: since there might be other debug print issues lurki=
ng as this seems not to be tested well on their side
(13:16:12) cron2: food delivery man brought lunch 1 hour early :-(
(13:16:20) plaisthos: cron2: good appetite
(13:16:48) mattock: I think we managed to avoid the "review culture" disc=
ussion
(13:16:56) mattock: I'm sure cron2 would have input there
(13:17:10) dazo: I think the fix on the list is reasonable for the time b=
eing.  Would be great to get syzzer's approval though, but reducing the c=
hances to crash openvpn is always a good idea
(13:20:23) ***plaisthos waits for the mail from dazo
(13:21:46) plaisthos: meanwhile my errors get more and more bizarre: 2021=
-03-10 12:21:17 us=3D109000 write UDP: No error (fd=3D0,code=3D364)
(13:21:58) mattock: shall we move the rest of the conversation to next we=
ek?
(13:22:14) mattock: no movement on buildbot front, except what I mentione=
d earlier in this meeting
(13:25:54) dazo: plaisthos: found the "Send" button now :-P
(13:26:36) plaisthos: on the two patches of series 874
(13:26:59) plaisthos: patch 1 is obsoleted/superseded with connect improv=
ements
(13:27:34) plaisthos: for patch 2 that needs to be rebased on master
(13:30:12) mattock: dazo: you have been forgetting about the existence of=
 that button recently :P
(13:30:29) mattock: ok we're done here, unless somebody screams in 2 minu=
tes
(13:30:29) plaisthos: dazo: where do I get the passpharse for that key?
(13:30:55) dazo: plaisthos: look carefully in some of your other windows =
;-)
(13:31:17) plaisthos: ah that is the password
(13:32:39) mattock: sending the summary now, I think this went from meeti=
ng into hacking :D

--------------64449F609759B77BAEDFFB5F--

