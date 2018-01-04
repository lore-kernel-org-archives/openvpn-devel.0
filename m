From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <c01383c9-231a-a3c7-db92-b31fee0ce681@...515...>
Message-ID: <6becec76-0aef-e70f-8e01-031a41105f7a@...515...>
Date: Thu, 4 Jan 2018 10:00:34 +0200
MIME-Version: 1.0
In-Reply-To: <c01383c9-231a-a3c7-db92-b31fee0ce681@...515...>
Content-Type: multipart/mixed; boundary="------------2EFC8FE65CECF4901CAC2990"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (Wed, 3rd Jan 2018)
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
--------------2EFC8FE65CECF4901CAC2990
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting. Unfortunately I had forgotten to
send the meeting invitation until it was already too late.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 3rd Jan 2017
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2018-01-03>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, mattock, ordex and syzzer participated in this meeting.

--

Noted that Patchwork is not detecting patches sent to the list. Mattock
is investigating the problem.

--

Discussed the suggestion by Internet Bug Bounty to sponsor OpenVPN bug
bounties:

<https://internetbugbounty.org/>

Mattock has had discussions with OSTIF about IBB and IBBs policy of "no
overlap". These discussions are ongoing and more details will follow.

--

Syzzer gave an update on his and gertvandijk's control channel
optimization work.

They believe that we should ditch unique_retry and to do a 'fast
retransmit', similar to what many TCP implementations do.  That is, if
we receive multiple ACKs for packets with IDs higher than some packet we
did not yet get an ACK for, we immediately retransmit that (instead of
waiting for the 2s exp backoff timeout). With our current 4-packet send
windows, that won't do much, but as soon as we increase the send buffer
size that improves things a lot.

Another thing they've been looking at is if we can implement dynamic
send window scaling without wire protocol changes. That will, however,
depend on advertising the window size to the other end.

Right now the receive window is hardcoded to 8 packets. It was agreed
that we could use a peer-id-link with which we implement larger receive
windows without dynamic window scaling or fast retransmit. This could go
into 2.4 and would be fairly trivial to implement. If the client does
not advertise any window size, we would assume 8 packets. Larger send
windows would only be implemented in master.

---

Full chatlog attached.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------2EFC8FE65CECF4901CAC2990
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2018-01-03.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2018-01-03.txt"

(12:02:00) ordex: mattock: about patchwork: notsure what's wrong, but sud=
denly it stopped showing patches in the list
(12:02:12) ***cron2 needs to merge quite a bit... no reviewing right now =
(only tablet with me)
(12:09:39) mattock: ordex: it is receiving emails, but not parsing them
(12:10:32) mattock: it had the same problem earlier, and then it was abou=
t a rackspace "welcome" email that lacked message id
(12:10:42) mattock: but I don't see anything similar in the INBOX now
(12:11:52) ordex: mh
(12:12:24) ordex: is there any log you could check? maybe showing some er=
ror? (maybe you've done that already)
(12:15:50) mattock: I did debug the problem previously but failed to make=
 notes into JIRA
(12:15:59) mattock: so I have to relearn how to debug patchwork
(12:17:00) mattock: how did you guys resend patches to patchwork?
(12:17:11) mattock: is modify as new -> send to patchwork address enough?=

(12:17:35) ordex: probably
(12:17:38) cron2: i bounce from mutt
(12:17:43) ordex: I normally use the "redirect" plugin in thunderbird
(12:18:11) ordex: mattock: I can do it with one patch for you now i you w=
ant
(12:20:34) mattock: ordex: please do
(12:20:44) mattock: I will install the redirect plugin
(12:20:48) ordex: ok, to patchwork@...515... , right ?
(12:20:51) mattock: yes
(12:21:00) ordex: done
(12:21:03) mattock: thanks!
(12:21:12) ordex: it was: [Openvpn-devel] [PATCH] reliable: remove reliab=
le_unique_retry()
(12:22:50) cron2: syzzer has been quite busy
(12:26:23) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
8-01-03
(12:26:27) vpnHelper: Title: Topics-2018-01-03 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:30:30) syzzer: cron2: new years' cleanup :)
(12:32:03) mattock: let's start
(12:32:15) mattock: I have ~20 minutes (lunch appointment)
(12:32:28) mattock: topic #1: quick update on IBB
(12:32:42) mattock: I have not heard anything, and I assume nobody else h=
as either
(12:33:01) syzzer: not me at least
(12:33:01) mattock: however, I've been discussing the OSTIF<->IBB angle w=
ith Derek from OSTIF
(12:33:41) mattock: I will help coordinate co-operation between those par=
ties
(12:34:00) mattock: hopefully openvpn will be supported by both eventuall=
y
(12:34:05) mattock: more details will follow
(12:34:13) syzzer: very good :)
(12:34:46) mattock: topic #2
(12:34:52) mattock: Update on control channel optimization (gertvandijk, =
syzzer)=20
(12:35:35) syzzer: ok, so gertvandijk was wise enough to take a holiday b=
reak, so not much news on the ledbat front
(12:36:16) syzzer: but I've been trying to figure out what our current re=
liability layer does, and how the various design choices impact performan=
ce
(12:36:51) syzzer: my laptop is currently crunching to produce graphs, bu=
t you've seens the first result:  I think we should ditch the unique_retr=
y thingy
(12:38:28) syzzer: another thing I think we want to do is a 'fast retrans=
mit', similar to what many TCP implementations do.  That is, if we receiv=
e multiple ACKs for packets with IDs higher than some packet we did not y=
et get an ACK for, we immediately retransmit that (instead of waiting for=
 the 2s exp backoff timeout)
(12:38:59) cron2: +1
(12:39:35) ordex: yeah
(12:39:50) syzzer: with our current 4-packet send windows, that won't do =
much, but as soon as we increase the send buffer size that improves thing=
s a lot
(12:40:07) ordex: yeah, I just about to ask about the size of the window =
:P
(12:40:15) cron2: something that i find highly interesting as well is the=
 FEC works... having to cope with lossy networks ever so often...
(12:40:19) ordex: with a larger window fast retransmit is essential
(12:40:52) cron2: (different packets, though)
(12:41:13) syzzer: you seem to know all these things :')   I just went me=
asuring and hacking on the reliability layer and came to these conclusion=
s :p
(12:41:55) syzzer: FEC is definitly interesting, but I think I'll leave t=
hat for now...
(12:42:52) syzzer: okay, so I'll do some more measurements and probably s=
end a fast retrantmit patch to the list soon
(12:43:34) cron2: syzzer: well, I do packets for a living :) - but measur=
ing is stronger arguments than "cron's gut feeling" :)
(12:43:52) mattock: good
(12:43:58) mattock: patch review next?
(12:44:07) syzzer: the other thing I've been looking at is if we can impl=
ement dynamic (send) window scaling without wire protocol changes
(12:44:45) syzzer: but it seems (like I later recalled Arne told me in Ka=
rlsruhe) we at least need to advertise our send window to the other end
(12:44:57) ordex: mostly depends whether the receiver has any "expected" =
hardcoded window size for the sender or if it parses things as they arriv=
e
(12:45:20) ordex: yeah, if the receiver has some assumptions..that is pro=
bably required (but I have no clue if this is true or not)
(12:45:43) syzzer: and if we want the TLS handshake (which will likely in=
clude larger post-quantum keys in the future) to profit, we'll need to do=
 that *before* the push/pull
(12:46:14) syzzer: so we at least need to do something like the extra dat=
a in HARD_RESET packets I mentioned last meeting
(12:46:47) ordex: syzzer: you mean we need a new HARD_RESET_VX ? or you c=
an do that by amending the current HARD_RESET format?
(12:46:52) syzzer: ordex: we now have a fixed receive window of 8 packets=

(12:46:53) cron2: this needs checking indeed... possibly peer-info can be=
 leveraged, depending on the timing of peer-info/auth and pq key handshak=
e...
(12:47:09) syzzer: ordex: we can just amend the HARD_RESET format
(12:47:16) cron2: or that
(12:47:31) syzzer: *but* we need to thing about interaction with tls-cryp=
t-v2, because that already abuses the 'extra data' trick
(12:48:28) syzzer: cron2: everything we do if after the TLS handshake its=
elf, to peerinfo/push/pull/occ is all too late for the TLS handshake to p=
rofit
(12:48:41) syzzer: s/if/is/
(12:49:32) syzzer: that's about all for me :)\
(12:49:44) ordex: syzzer: about advertising the window: iirc what is impo=
rtant is that the *sender* knows how big the receiver window is. and if t=
hat is static, I am not sure you can apply any trick to "virtually" exten=
d it
(12:50:56) ordex: therefore I am not sure you can really improve the reli=
able algorithm without changing both ends. But this is just theory. I hav=
en't looked at the actual code
(12:51:18) cron2: ordex: well the hard reset packet goes first, and if th=
at tells the other side "give me all you have!", it could work
(12:51:44) syzzer: ordex: yeah, so we'd need to allow increasing the rece=
ive window size
(12:51:48) cron2: but increasing window indeed needs both ends
(12:51:50) syzzer: so that newer clients have better performance
(12:51:56) ordex: cron2: yeah
(12:52:04) syzzer: but performance for older clients should not suffer fr=
om that
(12:52:37) syzzer: so if the client does not advertise anything, we assum=
e a receive window of 8 pakets
(12:52:51) ordex: old clients won't have support for big-key-crypto anywa=
y, no? so they won't care about performance. we just need to make sure th=
ey still work
(12:53:03) cron2: older clients do not actually *need* the larger window,=
 so phasing this in now sounds like a good time
(12:53:13) ordex: yeah
(12:53:15) cron2: right
(12:53:16) syzzer: ordex: correct, although this also help people pushing=
 a lot of options
(12:53:39) cron2: good point, like 5000 routes
(12:53:48) ordex: oh we really have such use cases?
(12:53:50) syzzer: we could do a peer-id-link thing, where we do implemen=
t larger receive windows, but no dynamic window scaling in 2.4
(12:54:05) cron2: yep
(12:54:23) syzzer: "just the trivial bits"
(12:54:33) cron2: large receive window should be fairly trivial
(12:54:42) syzzer: exactly
(12:54:48) cron2: once we figure out how to signal this
(12:54:53) ordex: syzzer: imho the larger window without scaling can be p=
roblematic under packet loss condition. unless we enlarge it "just a bit"=

(12:55:07) ordex: but it's worth an attempt probably
(12:55:26) syzzer: ordex: that's teh *receive* side only
(12:55:27) ordex: *without scaling and without fast retransmit
(12:55:29) syzzer: that should not need scaling
(12:55:57) syzzer: larger send windows will only be implemented in master=

(12:56:06) ordex: right=20
(12:56:10) ordex: oky
(12:56:17) syzzer: that's still useful, because most bw goes server->clie=
nt
(12:56:22) cron2: what syzzer says - if the receiver can handke it, doesn=
t *require* the sender to fill it up
(12:56:46) cron2: screen keyboard is toooo sloooowwww...
(12:56:49) ordex: :D
(12:56:56) mattock: need to split now but you guys go ahead
(12:57:09) mattock: I will continue debugging patchwork post-meeting
(12:57:13) mattock: and post-lunch
(12:57:17) ordex: oky, thanks !
(12:57:52) mattock2 [~mattock@...1423.../corp/admin/mattock] =C3=A8 entrato =
nella stanza.
(12:58:30) syzzer: I think that was #2?
(12:59:01) ordex: think so
(12:59:42) syzzer: good, then I think I'll go for lunch too :)
(12:59:50) ordex: good :)
(12:59:56) cron2: enjoy
(12:59:58) ordex: then maybe we all go for lunch at this point ? :P
(13:00:05) syzzer: guess so, enjoy!
(13:00:10) cron2: my food is also coming soon
(13:00:16) ordex: mine too
(13:00:20) cron2: *wave*
(13:00:31) ordex: well, I think what remains is just "we have to review m=
ore patches" eheh
(13:00:32) ordex: bye !

--------------2EFC8FE65CECF4901CAC2990--

