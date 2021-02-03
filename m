From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <316dbdbb-5a21-1a08-9369-26010b106b18@...515...>
Message-ID: <9dd7631e-1769-e7a2-c906-237c56504c8a@...515...>
Date: Wed, 3 Feb 2021 14:22:16 +0200
MIME-Version: 1.0
In-Reply-To: <316dbdbb-5a21-1a08-9369-26010b106b18@...515...>
Content-Type: multipart/mixed; boundary="------------67E34B6152779C8DA98824F6"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (3rd Feb 2021)
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
--------------67E34B6152779C8DA98824F6
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 3rd February 2021
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2021-02-03>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, d12fk, lev, mattock, ordex and plaisthos participated in
this meeting.

---

Noted that OpenVPN DCO ("Data Channel Offload") is progressing well. UDP
server works, including client dicsonnect. Client support is broken, but
once that is fixed an official announcement can be made. A lot of the
work still needs to be merged into "master", though.

On plaisthos' test system (Hyper-V with Ubuntu VMs) he was able to, with
iperf, get 550 Mbit for openvpn2 w/o DCO, 11 GBit/s raw, gre tunnel 4,5
GBit/s, 3,2 GBit/s with DCO+aes-gcm, 2,4 GBit/s for DCO+Chachapoly1305.

---

Discussed OpenVPN 2.5.1. Noted that there is client-side stuff in (echo
msg, windows fixes, and important auth-token improvements) already in.

On server-side there are server-side auth-token fixes, which should go
into 2.5 at some point. These are all "good and reasonable
improvements", but nothing truly critical.

It was agreed to make a decision about the 2.5.1 release schedule next week.

--

Discussed "possible DoS vector with non-successful auth for the same
client cert as for an existing session". This is related to the fact
that OpenVPN ties reauth TLS session to the original session only by
IP/port, so if a different cert comes in from the same IP+port, and 2.5
would "reauth fail, go away" while master does "reauth fail, unauth all
keys, you all go away"?

---

Full chatlog attached


--------------67E34B6152779C8DA98824F6
Content-Type: text/plain; charset="utf-8"; name="openvpn_irc_meeting_chatlog_2021-02-03.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2021-02-03.txt"

(12:30:32) dazo: Meeting time?
(12:30:32) ***: Playback Complete.
(12:30:33) cron2_: yes
(12:30:35) mattock: yes
(12:31:08) mattock: who else is present?
(12:31:23) d12fk: here
(12:31:32) dazo ha scelto come argomento: Agenda https://community.openvpn.net/openvpn/wiki/Topics-2021-02-03
(12:31:50) dazo: d12fk: cool!
(12:31:58) cron2_: \o/
(12:32:03) mattock: hi!
(12:32:30) dazo: I know plaisthos and lev__ are alive ....
(12:32:52) dazo: (and I've pinged them)
(12:32:56) cron2_: ordex was complaing about doas yesterday, so yesterday he was alive, too :)
(12:33:41) dazo: hehehe
(12:33:57) becm [~becm@...2593...] è entrato nella stanza.
(12:33:58) dazo: he might have been up hacking ovpn-dco last night
(12:34:03) lev__: hi
(12:34:13) mattock: hi!
(12:34:14) plaisthos: hehe
(12:34:14) dazo: o/
(12:35:01) ordex: here here !
(12:35:06) ordex: sorry
(12:35:36) dazo: surfaced from a km long kernel stacktrace  ...... :-P
(12:35:47) ordex: LOL
(12:35:58) ordex: those activities are secret !
(12:36:02) dazo: :-D
(12:36:05) dazo: sorry!
(12:37:05) mattock: https://community.openvpn.net/openvpn/wiki/Topics-2021-02-03
(12:37:12) mattock: let's get on with it :D
(12:37:29) mattock: "Sync up on OpenVPN 2.5 and 2.6" first?
(12:37:44) ***plaisthos checks
(12:38:01) plaisthos: currently 54 commits ahead of master
(12:38:02) plaisthos: :P
(12:38:29) mattock: 2.6 I presume
(12:38:29) cron2_: working my way through those bits that are on the list already... (and I have some questions about 02/11 v2, will ask later)
(12:39:01) cron2_: 2.6 is sort of "what's happening in DCO land", since this is "the!" feature for 2.6, I think...
(12:39:17) cron2_: any exciting news you're willing to share?
(12:39:29) plaisthos: UDP server works
(12:39:34) ***ordex cheers
(12:39:45) cron2_: including client disconnect?
(12:39:49) plaisthos: yes
(12:39:50) ordex: yap
(12:39:51) cron2_: cool
(12:40:23) plaisthos: it is still work in progress and I want to fix client to work again before we publish it with an announcement on the mailing list
(12:40:39) cron2_: ah, so we have a server-only implementation now :)
(12:40:42) ordex: :D
(12:40:43) cron2_: something for a change
(12:40:57) ordex: I am working on the ovpn-dco support (APIs have changed since last release)
(12:41:07) ordex: so we can do ovpn3 to ovpn2-server soon :D
(12:41:17) plaisthos: but if you checkout the experimental branch of ovpn-dco and the dco branch of my repo you can get a working version
(12:41:41) cron2_: exciting news indeed!
(12:42:17) ordex: yap yap they are!
(12:43:36) cron2_: on my side, I am working my way through the (already-ACKed) patches on the list - sorting what belongs where, if I can add more testing, ... - but progress has been slow.  Too many distractions ("MAMA I DO NOT UNDERSTAND THIS HOMEWORK QUESTION?")
(12:44:24) mattock: does not help focus for sure
(12:44:24) cron2_: gcox is keeping us busy with sample plugin improvements :-)  (and they are sort of "small and one-shot" so they are much easier to "just merge and get out of the way" than bigger stuff)
(12:45:41) plaisthos: on my hyper-v ubuntu vms and using iperf I get 550 Mbit for openvpn2 w/o DCO, 11 GBit/s raw, gre tunnel 4,5 GBit/s, 3,2 GBit/s with DCO+aes-gcm, 2,4 GBit/s for DCO+Chachapoly1305, wireguard only gets 800 MBit/s in that setup, not sure what is going there
(12:47:42) cron2_: impressive :)
(12:48:24) plaisthos: It is also on a Zen2 processor so not really lowend ... ;)
(12:49:29) ordex: on my side I will review the new version of the FIPS patches
(12:49:32) ordex: this week
(12:50:58) ordex: anything else for 2.5/2.6 ?
(12:51:24) mattock: what is missing from 2.5.1?
(12:52:05) cron2_: okay... so, 2.5.1... there is client-side stuff in (echo msg, windows fixes, and important auth-token improvements)
(12:52:44) cron2_: on master, we have server-side auth-token fixes, which should go into 2.5 at some point
(12:53:00) cron2_: we could do a 2.5.1 now, and merge that stuff to 2.5.2, or delay 2.5.1 a bit more
(12:53:27) mattock: I'm all for delaying, if the delay is "a few weeks" and not "a few months"
(12:53:33) ordex: yeah
(12:53:41) cron2_: this depends on plaisthos' time to unfocus from DCO and look into this TLS handshake area again...
(12:53:43) ordex: it doesn't seem like we have critical fixes to get out
(12:53:50) mattock: no point releases after a major release in three months is quite an accomplishment imho
(12:53:57) mattock: 2.5.0 has been good
(12:54:24) cron2_: what we have in tree is all "good and reasonable improvements", but nothing truly critical
(12:54:36) ordex: yeah, then postponing a bit seems reasonable
(12:54:44) cron2_: (well, auth-token + auth-nocache is broken in everything including 2.5.0, but "so do not use auth-nocache, then")
(12:55:11) ordex: yap, that's been longstanding
(12:55:15) ordex: not a regression
(12:55:21) cron2_: but it is fixed in release/2.5 now :-)
(12:56:22) cron2_: anyway, I'll keep it on the agenda :-)
(12:56:35) cron2_: which brings us to the other agenda item
(12:56:42) cron2_: "possible DoS vector with non-successful auth for the same client cert as for an existing session"
(12:57:39) cron2_: what I understood from plaisthos is that the changes in *master* might have opened up our "handle incoming TLS session" handling to a "user A kicks user B" DoS, *if* they use the same TLS cert, but user A does not have valid user+password credentials
(12:58:20) plaisthos: yeah but it seems  like not a real issue
(12:58:20) cron2_: different cert -> no problem, valid user+pass -> korrekt logic ("this is considered a new login of the same user, so the old session is closed")
(12:58:38) plaisthos: a different cert will also kill the connection :/
(12:59:02) cron2_: well, a different cert should be sorted towards a different session anyway?  Or "different cert with the same common name"?
(12:59:21) plaisthos: no if it has the same source ip/port
(12:59:36) plaisthos: That is actually a weakness in the OpenVPN protocol
(12:59:52) plaisthos: that we tie reauth TLS session to the original session only by IP/port
(13:00:54) cron2_: okay, so a different cert comes in from the same IP+port, and 2.5 would "reauth fail, go away" while master does "reauth fail, unauth all keys, you all go away"?
(13:01:07) plaisthos: yep
(13:01:41) cron2_: two questions - "can we fix this in a nice way" and "do we care enough to fix it?"
(13:02:23) cron2_: both scenarios sound like something which is hard to trigger in practice... though the "same IP+port" scenario could be triggered by an attacker on the path by injecting fake packets
(13:04:45) mattock2 [~mattock@...1423.../corp/admin/mattock] è entrato nella stanza.
(13:04:45) modalità (+o mattock2) da ChanServ
(13:06:27) plaisthos: yeah to properly fix this we probably need changes to the protocol
(13:06:49) plaisthos: maybe if syzzer surfaces again gets some ideas with him
(13:07:35) plaisthos: something like giving out a session token or something on the initial auth and when you reauth you have to have it or something like that
(13:09:05) ***cron2_ sends a gallon of fresh coffee to Delft
(13:09:13) ordex: :D
(13:09:19) cron2_: dunno, maybe it helps :)
(13:09:33) ordex: plaisthos: yeah, like a secure cookie
(13:09:54) cron2_: plaisthos: so for now, we keep master "as is" and do not merge the server-side reauth-fixes to 2.5?
(13:09:58) ordex: or couldn't we store the fingerprint of the cert used for the first session ?
(13:10:08) plaisthos: we do :P
(13:10:18) plaisthos: and if they mismatch we deauth the session
(13:10:53) plaisthos: The biggest problem of all this is that we don't have a proper way to tell a client that TLS reauth session fails
(13:11:54) ordex: we can't send an AUTH_FAIL at that point
(13:11:54) ordex: ?
(13:12:01) ordex: what happens if the cert expire in the meantime?
(13:12:06) ordex: between sessions
(13:12:10) plaisthos: that disconnects the client completely
(13:12:29) ordex: right
(13:12:48) ordex: in this case we may just want to ignore the bogus renegotiation attempt
(13:12:50) plaisthos: if the cert expires you fail early enough in the TLS session that client does not think that it is authenticated
(13:13:07) cron2_: AUTH_FAIL is tied to session state, and if it's not the *same* client failing, you kick off the "real" client with it
(13:13:11) cron2_: if I understood that right
(13:13:35) ordex: yap
(13:13:44) cron2_: so we can either ignore incoming "something is not right with this" reauth (which is what 2.5 does, so "expired token" leads to "unpleasantness for the client")
(13:13:46) plaisthos: ordex: problem is that client doesn't know that the reauth failed and will switch to the new keys after the 60s defer timeout
(13:13:49) ordex: this is why I more inclined towards "ignore" the malicious reauth
(13:13:59) ordex: hm
(13:14:11) cron2_: or deauth, which fixes "expired auth-gen-token" cases, but opens us to other deauth attacks
(13:14:24) ordex: plaisthos: if it wasn't the client to reauth, why does he need to care if the fake reauth failed?
(13:14:51) cron2_: ordex: it could have been the client that failed the reauth, because its auth-gen-token lifetime ran out
(13:14:57) cron2_: so a new 2FA login is needed now
(13:15:25) cron2_: and if we do not tell it, the result is "stuck connection"
(13:15:27) ordex: well, that's another problem now, unrelated to the attack ?
(13:16:11) cron2_: yes and no.  It's a problem, and the fix for that problem opens the attack
(13:16:20) ordex: ah got you
(13:16:33) ordex: anyway, this may need a longer and specific discussion I presume?
(13:16:43) ordex: hopefully involving syzzer
(13:16:44) ordex: :)
(13:17:13) cron2_: I agree.  I wanted to bring this up, because plaisthos mentioned that there "might be a problem", and it's relevant for the 2.5.x planning
(13:17:20) ordex: yap yap
(13:17:34) cron2_: but I do not actually want to unfocus the DCO work, so, ignore me
(13:18:05) cron2_: (OTOH if we can't fix this in 2.5 easily, we might as well do a 2.5.1 release "soonish", for the client-side goodies)
(13:18:36) dazo: agreed
(13:18:47) cron2_: shall we just let this settle for a week and decide on a specific plan next week?
(13:18:57) ordex: sounds good
(13:18:59) dazo: +1
(13:19:04) mattock2: +1
(13:19:08) plaisthos: on the other hand, OpenVPN AS (or rather management) has done it this way forever
(13:19:27) plaisthos: if a reauth failed you got kicked off alltogether
(13:26:36) mattock2 ha abbandonato la stanza (quit: Quit: IRC for Sailfish 0.9).
(13:27:43) cron2_: still sounds like "let it settle for a week" :-) (and it scared mattock away)
(13:28:09) cron2_: if there is a mattock instance left - any news on v6 for community?
(13:30:36) mattock: yes
(13:30:38) mattock: no
(13:30:47) mattock: in that order
(13:31:18) cron2_: okay.... my time for asking unpleasant question is over
(13:33:07) mattock: meeting over I suppose
(13:33:10) mattock: 3 minutes overtime
(13:34:08) cron2_: yep
(13:34:16) cron2_: everone else fell asleep already
(13:35:59) d12fk: now you woke me up! =)

--------------67E34B6152779C8DA98824F6--

