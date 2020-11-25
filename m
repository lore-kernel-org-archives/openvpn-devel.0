From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <d30b8aa4-30c5-4bfe-eba4-a78172686528@...515...>
Message-ID: <a63b698f-7890-0591-0a0b-ea93bdc495c1@...515...>
Date: Wed, 25 Nov 2020 13:50:29 +0200
MIME-Version: 1.0
In-Reply-To: <d30b8aa4-30c5-4bfe-eba4-a78172686528@...515...>
Content-Type: multipart/mixed; boundary="------------985C0293B778D9B215F392B4"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (25th November
 2020)
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
--------------985C0293B778D9B215F392B4
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 25th November 2020
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-11-25>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, mattock, ordex and plaisthos participated in this meeting.

---

Talked about the 80 character limit in the OpenVPN codebase and agreed 
to set the soft limit to 80 chars and the hard limit to 120 characters. 
This was because sometimes trying to stay below 80 characters for the 
sake of it makes the code uglier, not prettier. For example, when you 
have to use temporary variables with short names just to accomplish it. 
Plus on modern terminals 80 characters is quite little.

---

Talked about the data channel offload (DCO) kernel module work in 
OpenVPN 2 by plaisthos and ordex. The current code/status is hacky and 
works with only one peer and renogotiation does not work yet. A cleaner 
integration is probably coming when ovpn-dco gets p2mp support: this 
avoids having to refactor twice.

Lev is checking if DCO could be reasonably be done within the 
tap-windows6 driver as well. There is also the possibility that Linux 
version of OpenVPN 2 + DCO could be used as-is on WSL2 (Windows 
Subsystem for Linux) which basically runs a Linux kernel on top of Hyper-V.

The DCO changes will require us to improve our automated testing to 
ensure things do not break too badly.

--

Noted that OpenVPN 2.4.10 release is on schedule. That is, it will be 
released "next week".

--

Noted that mattock is now able to resume the Buildmaster upgrade work. 
This will require upgrading all buildslaves to Python 3, including our 
zombie from the dinosaur age, OpenSolaris. Our codebase still supports 
that platform so we should not stop testing it, either.

---

Full chatlog attached

--------------985C0293B778D9B215F392B4
Content-Type: text/plain; charset="utf-8"; name="openvpn_irc_meeting_chatlog_2020-11-25.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-11-25.txt"

(12:29:45) cron2: meeting calling...
(12:30:44) mattock: hello
(12:31:18) cron2: hi!
(12:32:58) mattock: anyone else?
(12:33:10) cron2: so, while we wait for dazo, plaisthos, ordex to find their way... any news on IPv6?
(12:34:08) ordex: here here
(12:34:26) ordex: dazo most likely won't join
(12:34:34) ordex: he's out at least until the end of the month I believe
(12:34:45) cron2: :(
(12:35:29) mattock: nothing on ipv6, it all depends on the migration to openvpn.com domain which I can keep asking about (no meeting this week though, Thanksgiving and all)
(12:35:54) cron2: yeah... *sigh*
(12:37:38) mattock: such an empty topic list: https://community.openvpn.net/openvpn/wiki/Topics-2020-11-25
(12:37:42) cron2: so, where is plaisthos hiding :-)
(12:38:02) mattock: ordex?
(12:38:59) ordex: I don't really have much on my side
(12:39:00) plaisthos: since even Linux kernel allows now 100 chars wide code, can we also allow a bit longer lines? *makes dog's eyes*
(12:39:07) ***ordex agrees
(12:40:27) cron2: I think a general 80 character "soft limit" is still reasonable, with flexibility if the alternatives are just plain ugly... so 100 or 120 "flex margin" would work for me
(12:41:02) cron2: I am tempted often enough to just make something 83 characters, because wrapping looks more ugly...
(12:41:36) ordex: yeah
(12:41:39) ordex: that makes sense
(12:43:30) cron2: since you two are the ones who wrote most of the code in the last years, I think we can just decide this here and now...
(12:43:44) cron2: (and not wait for dazo or syzzer or james to show up and agree :-) )
(12:45:05) Pippin_ [Pippin_@...2315.../vpn/protonvpn/pippin/x-75792076] è entrato nella stanza.
(12:45:23) plaisthos: a lot of times I am wrapping functiosn to two lines instead of one because of the 80 char limit or introduce temporary variables to shorten the names
(12:45:29) plaisthos: I would like to reduce that
(12:45:41) plaisthos: because I don't think that improves overall readability
(12:45:45) mattock: I'll add this decision to the meeting summary and anyone who wants to complain can complain :)
(12:45:51) cron2: understood.  Would you be fine with a "general 80 character limit, as a goal, with flexibility to go to 100/120"?
(12:46:01) cron2: (the last sentence was intended for plaisthos)
(12:46:24) plaisthos: unless you are really on a machine or terminal that cannot be made 100 or 120
(12:46:54) plaisthos: lets keep a 120 hard limit
(12:47:10) cron2: I personally find code that has "all very long lines" (or extremely deeply nested) harder to read, that's why "soft/hard"
(12:47:17) plaisthos: yeah
(12:47:19) cron2: okay, so "soft 80, hard 120"?  Everyone ok with that?
(12:47:24) plaisthos: okay
(12:47:52) cron2: ordex went for lunch, it seems :)
(12:47:55) ordex: nono
(12:47:58) ordex: still thinking :D
(12:48:08) ordex: soft 80, hard 120 sounds good though
(12:48:27) ordex: I was just thinking that also moving the soft to 80 would be ok imho. 80 is just very very short on nowadays terminals
(12:48:29) plaisthos: for the DCO integration in  OpenVPN 2
(12:48:41) ordex: but I am fine either way as long as we can get up to 100/120 when needed
(12:48:54) cron2: let's try this, and see where it leads us :-)
(12:49:02) cron2: plaisthos: all ears!
(12:49:02) plaisthos: current code/status is hacky but works with only one peer
(12:49:09) ordex: cool
(12:49:14) cron2: *like*
(12:49:18) plaisthos: and renogotiation does not work yet
(12:49:44) plaisthos: a cleaner integration is probably coming when ovpn-dco gets p2mp support since I would like to avoid refactoring twice
(12:49:47) ***cron2 sees a bunch of patches related in some way to renegotiation... I need to busy myself with these reviews
(12:49:56) plaisthos: nah
(12:50:24) plaisthos: it is more that after giving the socket to the kernel I don't receive the control channel messages anymore :D
(12:50:29) cron2: I just took it as a reminder "there is more that doesn't work, but patches are out"
(12:50:45) cron2: oh, interesting.  Is that a kernel omission or "just not programmed properly yet"?
(12:51:00) plaisthos: not programmed at all yet
(12:51:29) cron2: still very nice :)
(12:52:06) cron2: the "pass socket to kernel" stuff is going to be interesting for p2mp, with "one UDP socket" and "tons of TCP sockets"
(12:52:24) cron2: ("one ore more UDP sockets", eventually :) )
(12:53:54) plaisthos: probably for tcp server mode we probably will keep the listener socket in userspace
(12:58:04) ordex: yap
(12:58:06) ordex: that's expected
(12:58:22) ordex: the server socket stays in userspace and upon creating a new peer in kernel space the new client socket is passed along
(12:58:27) cron2: easy 1:1 correlation of sockets to clients
(12:58:28) cron2: yeah
(12:58:31) ordex: right
(12:58:37) cron2: but UDP is more interesting
(12:58:47) ordex: in udp mode the socket is passed upon session creation
(12:58:55) ordex: thn new peers are created without a socket
(12:59:15) ordex: we could potentially support udp and tcp peers at the same time :D
(12:59:18) ***ordex hides
(12:59:31) plaisthos: you could also just pass socket for udp peers
(12:59:32) ordex: but this is what we want in any case with the multi-listen thing that is still WIP
(12:59:34) cron2: I know that someone who has been working on this... now is the time :-)
(12:59:35) plaisthos: and then refcount it :)
(12:59:54) ordex: plaisthos: yeah, that too...will see what's easier/cleaner/simpler
(13:00:04) ordex: right one we have one handler per socket
(13:00:12) ordex: cron2: :p
(13:04:03) cron2: sooo... that's the exciting 2.6 news :-)
(13:04:17) ordex: sounds like it's gonna be BIG !
(13:04:20) ordex: hehe
(13:04:30) cron2: 2.4.10 is slowly progressing - I've merged the IV_CIPHER patches yesterday, and want to do a respin of the line number bugfix (as suggested)
(13:04:42) mattock: perhaps after 2.6 we should bump version number to 4?
(13:04:44) cron2: so "2.4.10 release next week" is in the time plan
(13:04:55) mattock: cron2: roger that
(13:05:01) cron2: mattock: I thought we go for 2.10 eventually, just to confuse your build scripts
(13:05:13) mattock: oh that would be nice
(13:05:21) mattock: everyone loves fixing broken build scripts
(13:05:27) mattock: :D
(13:05:38) cron2: 2.5 has been extremely quiet so far
(13:05:50) cron2: one man page install fix, one travis build fix
(13:06:03) cron2: waiting for the man page patch for "we removed $ifconfig_broadcast" :-)
(13:06:38) cron2: SRV v9 has been ACKed and is on my "review, test, merge" agenda
(13:06:50) plaisthos: cron2: btw. for that cipher normalise
(13:07:01) plaisthos: if bF-cBc works or not, depends on your OpenSSL version
(13:07:33) cron2: ah, so you order the cipher from openssl, and then you ask it "how is this cipher called"?
(13:07:58) cron2: I stopped reading after finding the translate functions + tables :-)
(13:08:14) plaisthos: yeah
(13:09:11) cron2: this explains my confusion :-) - thanks
(13:10:09) plaisthos: but even without that case insenstive there are things like BLOWFISH-CBC that works in mbed but needs to be translated to BF-CBC to have the normalised name
(13:10:17) ordex: oh we need to fix the doc about the broadcast not existing anymore in the env
(13:10:31) cron2: plaisthos: this one I actually tested (after finding the table) and I can confirm "it works" :-)
(13:10:34) cron2: ordex: yes
(13:14:34) plaisthos: lev__ is also looking if DCO can be done inside the wintap driver
(13:15:41) cron2: yeah, I like that
(13:15:48) ordex: yeah, that'd be another interesting feature for 2.6 if it comes together
(13:15:56) ordex: will build on the same work that plaisthos is doing now
(13:16:51) cron2: I'm a bit scared of the review / test platform work that will surface eventually from this...
(13:17:46) cron2: like, "run an openvpn *server* with TCP and UDP on a windows box, with n>1 test clients concurrently"
(13:18:19) mattock: yes, this will be a good reason to extend testing even more
(13:18:24) cron2: oh wait.  This is windows, so mattock's testing department :-)
(13:18:25) ***cron2 runs
(13:18:25) mattock: =ots of work
(13:18:27) mattock: lots
(13:18:43) mattock: OpenVPN server on Windows... people _do_ do that
(13:18:45) plaisthos: the windows stuff might be client only
(13:18:49) mattock: there's even a howto for it
(13:18:59) ordex: :D
(13:19:58) plaisthos: A friend showed me a mail of someone running hmailserver with 4000 accounts and asking for help since it runs out of memory since there is only a 32 bit version available
(13:20:02) plaisthos: people do strange stuff
(13:20:06) cron2: plaisthos: should be good enough...
(13:20:26) plaisthos: yeah
(13:20:50) plaisthos: you might be able to run openvpn2+dco on wsl2
(13:20:56) plaisthos: or on a VM
(13:21:27) ordex: we can also tackle this step by step ...
(13:21:38) ordex: and windows-client only with dco sounds more than enough as first step :D
(13:22:08) cron2: plaisthos: I once tried to install a winsock driver on OS/2, "because it is compatible, no?".  Got a spectacular crash.
(13:22:39) cron2: so not sure if kernel-level stuff on wsl2 is going to work well... but we'll see
(13:22:48) ordex: what is wsl2 ?
(13:23:05) plaisthos: minimal linux kernel running on hyper-v
(13:23:23) plaisthos: and providing a lean linux environment for windows
(13:23:39) plaisthos: in contrast to wsl1, which implements the linux syscalls in the windows kernel
(13:24:14) cron2: in that case it might actually work nicely... and be faster than "on the windows side" :-)
(13:25:54) cron2: anything else?  mattock will want to go to lunch in 5 minuts
(13:27:01) mattock: I already had lunch
(13:27:08) mattock: I don't have anything
(13:27:54) mattock: it looks like I could continue the buildmaster upgrade work soon, just wrapped up some major infrastructure tasks
(13:28:21) cron2: oh, indeed, that project.  I'm ready to rebuild everything on my side with python3...
(13:29:29) cron2: OpenSolaris scares me a bit, but the rest should be fairly easy
(13:29:46) mattock: will opensolaris ever die?
(13:30:07) cron2: no, it's like AIX.  A zombie from the dinosaur age...
(13:30:09) plaisthos: it is already dead iirc
(13:30:26) mattock: cron2: but you _do_ want to keep doing test builds on it?
(13:30:36) mattock: do _you_ use that zombie from the dinosaur age? :D
(13:30:41) cron2: it's an officially supported OpenVPN plattform
(13:30:52) cron2: so either we rip out all #ifdef TARGET_SOLARIS, or we keep testing it
(13:31:25) cron2: I very much dislike projects that have a README that said "oh, yeah, someone managed to make this work on <platform>, 5 years ago, but we do not know whether it works or not"
(13:31:35) plaisthos: Oracle pretty much cancelled Solaris OSS
(13:31:47) cron2: yeah, official oracle upstream is dead
(13:32:02) cron2: but other folks have picked up the open source bits and built stuff like OpenIllumos, OpenIndiana, ...
(13:32:04) plaisthos: not sure if the commercial Solaris is very alive
(13:32:15) cron2: there is a life ecosystem, though I do not understand it (at all)
(13:33:33) plaisthos: is Sparc still alive?
(13:33:44) cron2: maybe
(13:34:07) cron2: Oracle/Sun sparc is dead, but Fujitsu is still building SPARC servers, and allegedly even building on new CPU generations
(13:40:29) plaisthos: I got lost in wikipedia processors and ended up with a russian Transmeta like processor the Elberos 2000
(13:40:38) plaisthos: I think I should get back to work
(13:40:44) cron2: haha :-)
(13:41:05) cron2: yeah, meeting has silently concluded anyway, I think.  Next on the agenda is "patch review", which I intend to do now-ish
(13:45:24) mattock: summary done
(13:45:26) mattock: meeting over
(13:45:27) mattock: :D

--------------985C0293B778D9B215F392B4--

