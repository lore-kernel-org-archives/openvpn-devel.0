From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <316dbdbb-5a21-1a08-9369-26010b106b18@...515...>
Message-ID: <5e9809cf-7df3-a520-1f9b-844954d5c211@...515...>
Date: Wed, 10 Feb 2021 13:44:15 +0200
MIME-Version: 1.0
In-Reply-To: <316dbdbb-5a21-1a08-9369-26010b106b18@...515...>
Content-Type: multipart/mixed; boundary="------------4D1366FA3ECCE61148BFF257"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (10th February
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
--------------4D1366FA3ECCE61148BFF257
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 10th February 2021
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2021-02-10>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

dazo, d12fk, gcox, lev, mattock, ordex and plaisthos participated in
this meeting.

---

Noted that plaisthos' "Pending authentication improvements" patchset:

<https://patchwork.openvpn.net/project/openvpn2/list/?series=1019>

Noted that some of them still need some (easy) fixes.

---

Talked about "Remove --no-replay" patch:

<https://patchwork.openvpn.net/patch/1297/>

It had managed to slip through the cracks because we have not decided
whether to support "--cipher none" or not - a thing that affects the
implementation of the above patch.

---

Talked about "--cipher none" and whether we should remove it. When
plaisthos accidentally broke it lots of users complained. That's why we
can't remove it right now, but removing it is our long-term goal. For
example ovpn-dco will not support "--cipher none".

---

Noted that wiscii's buildslaves have issues connecting to the
buildmaster. Mattock will investigate.

---

Full chatlog attached

--------------4D1366FA3ECCE61148BFF257
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2021-02-10.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2021-02-10.txt"

(12:29:53) lev__: guten tag
(12:30:30) plaisthos: moin
(12:31:16) d12fk: huhu
(12:31:41) ordex: oi oi
(12:31:59) mattock: hi!
(12:35:45) mattock: mkay let's start shall we?
(12:36:07) dazo: Hey!
(12:36:16) mattock: hi!
(12:36:23) mattock: https://community.openvpn.net/openvpn/wiki/Topics-2021-02-10
(12:36:34) mattock: it looks like our topic list is fairly short
(12:36:44) mattock: but I'm sure there's some syncing up to do :)
(12:37:26) mattock: cron2 mentioned that he's bound in a meeting
(12:37:30) mattock: not sure if he'll make it
(12:37:56) dazo: "Checking your browser before accessing openvpn.net." ... 40+ sec now
(12:38:04) mattock: try reload
(12:38:13) d12fk: they know who to check thoroughly
(12:38:15) mattock: or maybe you're just too suspicious to let you in
(12:38:15) dazo: yeah
(12:38:48) dazo: $rant_about_cloudflare
(12:39:38) dazo: so, lets catch up on the patches from plaisthos .... what is missing there?
(12:40:35) lev__: from 1-7 I've reviewed, 3 and 5
(12:40:47) lev__: (but it should be easy to fix)
(12:40:58) plaisthos: Yeah I need to resend some patches
(12:41:00) dazo: I did 8-11, was a few simple fixes there as well
(12:41:03) lev__: talking about "Pending authentication improvements" series
(12:42:52) dazo: plaisthos: btw, the if() statement I complained about, proposing a macro where you swapped to 2 bool vars .... that was a very nice change; I liked that .... much more readable
(12:43:40) plaisthos: yeah I didn't like the idea of a macro
(12:44:29) dazo: yeah, and it's a fair point on it hiding things .... it's just the old openvpn habbit stuck in me :-P
(12:48:06) dazo: anything else than this patch-set and the one ordex is looking at in the patch queue needing attention?
(12:49:54) ordex: plaisthos: did you resend 3/3 as one patch already?
(12:50:00) ordex: I haven't dug in the mailbox yet
(12:53:04) gcox: Maybe not "needs" attention, but https://patchwork.openvpn.net/patch/1297/ is a 6month old ack'ed patch that seems like it's held up pending a discussion + decision that hasn't happened.  Not saying y'all need to do it right now, but it looks like low-hanging fruit.
(12:53:05) vpnHelper: Title: [Openvpn-devel] Remove --no-replay - Patchwork (at patchwork.openvpn.net)
(12:56:53) dazo: gcox: oh, good catch ... that might have fallen through our cracks
(12:58:03) plaisthos: ordex: no, not yet
(12:58:36) ordex: okyz
(12:58:47) plaisthos: for none cipher no-replay is still useful
(12:59:10) plaisthos: but maybe we don't enough about none cipher and can still commit it
(12:59:13) dazo: so the question is then ... are we ready to decide whether to remove --cipher none support?
(12:59:44) plaisthos: we not ready to remove none
(12:59:52) plaisthos: I accidently did that
(13:00:11) dazo: I can pull up that patch again (probably needs a rebase anyhow) ... but would like to know if we should make the --cipher none exception or not
(13:00:32) dazo: what happened when you removed --cipher none, plaisthos?
(13:00:44) plaisthos: a lot of users complained about it not working anymore
(13:00:53) dazo: hmmmm
(13:01:04) dazo: which users?  why can't they use GRE tunnels instead?
(13:01:16) ordex: because they may still like other openvpn features
(13:01:25) plaisthos: exactly that
(13:01:25) ordex: like the authentication method
(13:01:32) ordex: or other stuff
(13:01:36) plaisthos: unencrypted tunnel but from a dynamic IP
(13:01:39) plaisthos: like to your streambox
(13:01:42) plaisthos: or something like that
(13:02:25) ordex: I also believe that using openvpn with no encryption is kinda...weird, but apparently all the knobs we have managed to create meaningful usecases
(13:02:39) dazo: but .... then it's just a VN not a VPN .... and we're OpenVPN not OpenVN ... and should we really care about users complaining that we increase the security aspect?
(13:04:51) plaisthos: VPN does not include encryption
(13:04:52) dazo: Don't get me wrong, I can see that for some users encryption isn't needed for their use case and they have a working setup (ab)using OpenVPN for a non-secure connection.  I can see the value of it.  But as a project, delivering a security project, are these users the ones needing our attention?
(13:04:56) plaisthos: it is jst a private network
(13:05:05) plaisthos: ;P
(13:05:46) dazo: plaisthos: heh, fair point!  You can twist it like that, indeed .... but it's like having a loud private conversation on the market square
(13:06:10) plaisthos: dazo: mpls vpn is an industry standard that does not include encryption
(13:06:49) dazo: sure, fair point that too
(13:08:05) dazo: but ... in today's world, where unencrypted traffic is being avoided everywhere ... is unencrypted VPNs a focus area we should put efforts into supporting?
(13:08:31) plaisthos: lets just keep none for now
(13:09:04) dazo: I don't have a good answer yet ... just wondering if it's worth the effort in the longer run
(13:09:21) plaisthos: ovpn-dco will also not support none
(13:09:29) dazo: exactly
(13:09:36) plaisthos: it is also a step to dorpping it
(13:09:54) plaisthos: but ovpn-dco does also not support other snowflake stuff like old ciphers etc
(13:10:10) dazo: which is also a good step forward too
(13:11:05) mattock: so --none shall stay
(13:11:55) dazo: at its core, this discussion is essentially a "seat belt discussion" ... many drivers hated it in the early days, now the vast majority use it without thinking about it
(13:12:26) dazo: mattock: for now --cipher none will stay, but we are moving towards dropping it in the longer run (ovpn-dco will not support it)
(13:12:43) mattock: sounds reasonbale
(13:12:55) mattock: we have given users rope with which they can hang themselves
(13:13:05) mattock: now we need to take that rope away and they don't like it :D
(13:13:20) dazo: yeah, that's the crux of it
(13:14:25) mattock: anything else for today?
(13:14:55) dazo: oh, did you see my side-channel remark to you mattock regarding inaccessible buildbot master?
(13:15:08) mattock: inaccessible how?
(13:15:30) dazo:  2021-02-09 17:54:05+0000 [-] Connection to build.openvpn.org:9989 failed: [Failure instance: Traceback (failure with no frames): <class 'twisted.internet.error.UserError'>: User aborted connection.
(13:15:40) dazo: well, that's wrong line
(13:15:44) mattock: .org will not work
(13:16:12) dazo: ahh ... that might be it .... ping works, but not buildbot connection
(13:16:22) mattock: build.openvpn.in
(13:16:29) mattock: or I can give you the actual IP
(13:16:31) dazo: mattock: can you follow-up wiscii on the details?
(13:16:56) mattock: where did this discussion happen?
(13:17:14) dazo: it was a PM
(13:17:18) mattock: ah
(13:17:41) mattock: so wiscii buildslaves are unable to connect I suppose
(13:17:52) dazo: correct
(13:17:58) mattock: ok, I'll that out
(13:18:14) mattock: check that out
(13:18:14) dazo: thx!
(13:19:23) mattock: that's all folks?
(13:19:58) dazo: lev__: did you have anything?
(13:20:10) lev__: next week I think
(13:20:14) dazo: cool!

--------------4D1366FA3ECCE61148BFF257--

