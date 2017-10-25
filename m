From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <c64336dd-09d7-4920-a841-419d14aa7793@...515...>
 <8be0d1d1-fc02-4200-2cbc-099a7bb8daec@...515...>
Message-ID: <b01422cf-aaab-1232-886d-e96e8685802c@...515...>
Date: Wed, 25 Oct 2017 21:52:18 +0300
MIME-Version: 1.0
In-Reply-To: <8be0d1d1-fc02-4200-2cbc-099a7bb8daec@...515...>
Content-Type: multipart/mixed; boundary="------------525345784A65251A3DCC3024"
Content-Language: en-US
Subject: Re: [Openvpn-devel] Summary of community meeting (Wed,
 25th Oct 2017)
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
--------------525345784A65251A3DCC3024
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Forgot to attach the chatlog, so here it is.

Samuli

On 25/10/2017 20:46, Samuli Sepp=E4nen wrote:
> Hi,
>=20
> Here's the summary of the IRC meeting.
>=20
> ---
>=20
> COMMUNITY MEETING
>=20
> Place: #openvpn-meeting on irc.freenode.net
> Date: Wednesday 25th Oct 2017
> Time: 19:00 CET (17:00 UTC)
>=20
> Planned meeting topics for this meeting were here:
>=20
> <https://community.openvpn.net/openvpn/wiki/Topics-2017-10-25>
>=20
> The next meeting has not been scheduled yet.
>=20
> Your local meeting time is easy to check from services such as
>=20
> <http://www.timeanddate.com/worldclock>
>=20
> SUMMARY
>=20
> dazo, mattock, ordex and syzzer participated in this meeting.
>=20
> --
>=20
> Discussed ways to avoid user fingerprinting in tls-crypt-v2. Agreed that
> at best we could offer pseudo-anonymity. Thus it was agreed that instead
> of spending time anonymizing tls-crypt-v2 we should put work into
> allowing transport layer plugins. The plugins could then handle the
> anonymity part, e.g. via traffic obfuscation.
>=20


--------------525345784A65251A3DCC3024
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2017-10-25.txt"
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2017-10-25.txt"
Content-Transfer-Encoding: quoted-printable

(19:57:43) ***dazo stretches his legs and gets ready
(20:01:18) syzzer: meeting time!
(20:01:42) dazo: yupp!
(20:02:12) ordex: bing
(20:02:16) dazo: o
(20:02:25) ordex: I think the only topic for this night is tls-crypt v2 ?
(20:02:43) syzzer: so says the agenda
(20:03:14) dazo ha scelto come argomento: Meeting 2017-10-25 19:00 CEST: =
Agenda at https://community.openvpn.net/openvpn/wiki/Topics-2017-10-25
(20:03:28) syzzer: though I'm also curious to hear what the plan with pat=
chwork is (I probably missed some info on that)
(20:03:43) ordex: as far as I know it is ready
(20:03:45) ordex: we can register to it
(20:03:50) dazo: https://patchwork.openvpn.net/project/openvpn2/list/
(20:03:51) vpnHelper: Title: OpenVPN 2 - Patchwork (at patchwork.openvpn.=
net)
(20:03:53) ordex: and get patches assigned
(20:04:09) ordex: or delegate them to somebody else, although cron2 doesn=
't like that idea :P
(20:04:17) syzzer: haha
(20:04:22) syzzer: yeah, I already registered
(20:04:28) syzzer: looks useful
(20:04:32) mattock: hi!
(20:04:45) syzzer: let's see if I can assign https://patchwork.openvpn.ne=
t/patch/35/ to someone :p
(20:04:46) vpnHelper: Title: [Openvpn-devel] make struct key * argument o=
f init_key_ctx const - Patchwork (at patchwork.openvpn.net)
(20:04:56) ordex: syzzer: :D
(20:05:23) ordex: honestly I see two approaches
(20:05:51) ordex: whoever sees a patch without an assignee could assign t=
he patch to whom is owning that particular piece of code (if this is know=
n/clear)
(20:06:12) ordex: or the owner of a piece of code assigns the patch to hi=
mself when he gets a chance to check patchwork
(20:06:35) mattock: syzzer: now you can assign
(20:06:38) ordex: I wouldn't mind the first approach as we implicitly kno=
w who is supposed to review what normally
(20:06:52) ordex: but as I said, cron2 does not like it
(20:07:11) mattock: patchwork also allows automatically assigning patches=
 to people based on the files/paths the patch touches
(20:07:26) mattock: not sure what it does if a patch touches several plac=
es
(20:07:32) syzzer: hehe "your fault!"
(20:07:59) syzzer: even just as a todo-list it's useful
(20:08:05) mattock: yup
(20:08:18) ordex: yeah
(20:08:31) ordex: just to keep track of what's pending, without scrolling=
 the inbox every time
(20:08:31) syzzer: for now I think it makes sense to not assign stuff to =
people, because it might give a false idea that someone else will take ca=
re of it
(20:08:38) ordex: :D
(20:08:49) ordex: that's the best false idea ever
(20:08:53) ordex: but i agree
(20:09:59) syzzer: okay, so, tls-crypt-v2?
(20:10:46) rabbit__ [2d4c6435@...2315.../web/freenode/ip.45.76.100.53] =C3=A8=
 entrato nella stanza.
(20:10:53) ordex: I just went through your email. so I guess the idea of =
switching to asym crypto is not really acceptable, right ?
(20:11:29) syzzer: well, *I* prefer to avoid it for this outer layer
(20:12:11) syzzer: but others might make different tradeoffs
(20:12:30) ordex: well, your explanation was quite convincing. and you ar=
e the guru of those things :)
(20:13:12) syzzer: don't underestimate yourself, you make very sharp obse=
rvations and suggestions
(20:14:03) dazo: Could we just to a quick TL;DR executive summary of pro/=
cons for symmetric vs asymmetric in this context?
(20:14:10) syzzer: it would be good to also hear from James on this
(20:14:15) ordex: sure, but in terms of "what could possibly go wrong" yo=
u have a better overview
(20:14:33) ordex: syzzer: maybe you could sum this up so also the others =
can follow a bit better ?
(20:15:11) syzzer: I think this paragraph sort of summarizes it: "This tr=
ades an engineering problem ('how to store the new WKc') for more
(20:15:11) syzzer: complex crypto (ECC instead of AES), less DoS protecti=
on (ECC is more
(20:15:11) syzzer: expensive than AES), no more post-quantum properties (=
ECC is not PQ) and
(20:15:11) syzzer: other engineering problems (how to prevent nonce reuse=
).  That's not
(20:15:12) syzzer: because the idea is bad, it's simply that asymmetrical=
 crypto is more
(20:15:12) syzzer: fragile and complex than symmetrical crypto is."
(20:17:04) dazo: So what we essentially try to resolve is how to have a s=
hared secret before a connection is trusted, and how do we ensure that ke=
y can be rotated .... or did I miss something?
(20:17:15) syzzer: correct
(20:17:19) ordex: yap
(20:17:35) ordex: well, we are not necessarily trying to rotate the key
(20:17:46) syzzer: so symmetrical has the disadvantage that the server ha=
s to send a new key, and the client has to store that new key somehow
(20:17:47) ordex: we just want to be sure to not send the same cryptogram=
 upon every connection
(20:19:34) ordex: and a concerned raised about that approach is that we m=
ight have client devices not having available storage for that
(20:19:39) syzzer: oh, and just to be clear: this all is only to prevent =
user fingerprinting, ie preventing that a very powerfull attacker that ca=
n mitm lots of connections can not see that connection x is made by the s=
ame user as connection y (but without seeing the certificate)
(20:19:39) dazo: okay .... I am just going to throw in a very different b=
all, which I believe does resolve some of that actually .... tang .... TL=
;DR of this concept is based on "how do we securely transfer a decryption=
 key for harddrives during boot in an automated fashion"  https://github.=
com/latchset/tang
(20:19:40) vpnHelper: Title: GitHub - latchset/tang: Tang binding daemon =
(at github.com)
(20:21:13) syzzer: and it's quite questionable that this suffices.  tor g=
oes through a lot of pain to prevent it, and then people just look at the=
 packet sizes of the connection and still fingerprint the users based on =
that
(20:21:18) dazo: not saying we should try to implement that protocol ....=
 but it uses a modified DH key exchange (yes, there's some papers on that=
) ... and that key exchange is fairly interesting
(20:21:50) ordex: syzzer: you mean after tls handshake has been performed=
?
(20:22:23) syzzer: ordex: yes, just look at the sizes of the P_DATA packe=
ts and you can likely fingerprint users
(20:23:23) dazo: random length padding on packets?
(20:23:37) dazo: (would hurt performance, though)
(20:23:43) dazo: or throughput, more likely
(20:24:03) syzzer: dazo: I'll read up on the protocol, but it likely has =
the same problems as ordex' proposal
(20:24:50) ordex: sounds plausible after reading a bit of it
(20:24:56) ordex: plausible that will have the same issues
(20:25:12) dazo: syzzer: http://redhat.slides.com/npmccallum/deck-1#/11
(20:25:13) vpnHelper: Title: Clevis/Tang Planning by Nathaniel McCallum (=
at redhat.slides.com)
(20:25:34) syzzer: dazo: random length padding makes it a bit harder, but=
 since the random will eventually just produce an average offset, it won'=
t stop the attack.  The attacker just needs more data.
(20:25:48) dazo: that's true
(20:26:09) syzzer: the only thing that helps is padding everything to the=
 max, and send at max-rate
(20:26:18) syzzer: otherwise the timing of packets can be used to identif=
y you
(20:27:41) dazo: syzzer: https://www.youtube.com/watch?v=3DPIKRy3WEn74  .=
... here Tang, Clevis and Jose is explained in more details
(20:28:14) syzzer: (in other words: if it's easy and has no disadvantages=
, I think we should implement fingerprinting prevention measures.  But if=
 people want anonymity, openvpn is probably just not the right tool...)
(20:29:17) ordex: mh interesting .. so it sounds like solving user finger=
printing at the tls-crypt level is not going to help for real? it will ju=
st avoid to make fingerprinting easier than now
(20:29:27) dazo: VPNs are really not suitable for anonymity at all .... t=
he exit point reveals what you do regardless
(20:31:49) syzzer: ordex: yes, it's sort-of "make it a little bit harder"=
, but not more than that
(20:32:21) ordex: I see
(20:32:28) ordex: I wonder if we should take care of this at all then ...
(20:33:08) ordex: we can still implement a user fingerprinting pretection=
 later when a reasonable easy idea comes along, rather than going down th=
e "store a new WKc everytime" path
(20:33:09) syzzer: nah "a bit harder" - little bit is too strong.  from s=
imple pattern matching to statistical analysis is a decent step forward
(20:33:14) ordex: not sure what you think about it
(20:33:23) ordex: ok
(20:33:25) ordex: right
(20:33:25) dazo: should we rather look more at having a plug-in interface=
 for the transport layer, so we can let an obfuscation plug-in handle the=
 fingerprint issue?
(20:33:43) syzzer: dazo: actually, yes.  I think it makes much more sense=
 to put effort into that
(20:33:49) ordex: yeah
(20:34:03) ordex: syzzer: would tls-crypt still be needed if we have yet =
another outern layer obfuscating the protocol ?
(20:34:34) dazo: or to flip it around ... how can we avoid DoS attacks wh=
en obfuscation is enabled?
(20:34:49) syzzer: ordex: not for anonymity
(20:35:08) dazo: tls-auth/tls-crypt covers this at a very early state=20
(20:35:10) syzzer: dazo: that fully depends on the obfuscation method
(20:35:22) ordex: syzzer: why? if the obfuscation is encrypted don't we g=
et anonymity as well ?
(20:35:44) ordex: well, it all boils down to how the obfuscation is imple=
mented. not sure we can make assumptions earlier
(20:36:03) dazo: true
(20:36:45) syzzer: ordex: my statement might have been ambiguous.  I want=
ed to say that if you use e.g. tor for obfuscation, you don't need tls-cr=
ypt for pseudo-anonymity anymore.
(20:37:19) syzzer: but tls-crypt-v2 would still offer protection of OpenV=
PN's TLS stack, and early-rejection of clients
(20:37:33) ordex: right
(20:37:34) syzzer: and post-quantum security :p
(20:37:54) ordex: that might be offered by the obfuscation too
(20:37:55) ordex: anyway
(20:38:04) ordex: I think we all agree that putting effort into that is p=
robably better :D
(20:38:21) syzzer: yeah, I think dazo is completely right about that
(20:38:47) dazo: yeah, fingerprinting in tls-crypt is solving the issue i=
n the wrong place
(20:40:20) syzzer: okay, so we continue with just finishing tls-crypt-v2 =
with the primary goal of DoS-protection for large deployments and VPN pro=
viders.
(20:40:50) dazo: agreed
(20:41:08) ordex: yup
(20:41:33) syzzer: well, that wraps up our agenda then :)
(20:41:35) ordex: syzzer: speaking about that, where are we now? I think =
we are quite close ?
(20:41:46) ordex: your code works so far
(20:41:59) ordex: and looks reasonably good. but maybe there is still som=
e refactoring pending ?
(20:42:14) syzzer: ordex: yeah, I think so.  I'll need to pick up the pre=
liminary patches again.  Those needed some final testing before I resend =
them to the list.
(20:42:27) ordex: oky!
(20:42:29) ordex: sounds good
(20:42:33) ordex: ping me if you need help
(20:42:34) syzzer: Then I can rebase again and finish the actual implemen=
tation patches
(20:43:46) syzzer: any other things to discuss now?
(20:43:58) mattock: not afaik
(20:44:03) syzzer: otherwise I'm going to make dinner :)
(20:44:13) mattock: quick summary:
(20:44:22) mattock: "Discussed ways to avoid user fingerprinting in tls-c=
rypt-v2. Agreed that at best we could offer pseudo-anonymity. Thus it was=
 agreed that instead of spending time anonymizing tls-crypt-v2 we should =
put work into allowing transport layer plugins. The plugins could then ha=
ndle the anonymity part, e.g. via traffic obfuscation."
(20:44:25) mattock: looks good?
(20:44:43) syzzer: ack
(20:44:47) mattock: ok
(20:45:16) mattock: if there is nothing else let's call this "yet another=
 good meeting that ended in less than one hour" :P
(20:45:28) dazo: :)
(20:45:36) syzzer: yeah, this weekly thing really seems to work :D
(20:45:39) mattock: it does
(20:45:41) dazo: then some of us can get ready for the third meeting in a=
 row :)
(20:45:51) mattock: there won't be time to accumulate huge backlog of thi=
ngs to discuss/review
(20:45:52) syzzer: hehe, enjoy ;-)
(20:45:53) dazo: agreed :)
(20:45:58) mattock: dazo: +1
(20:46:02) mattock: ok bye guys!
(20:46:06) syzzer: good night!
(20:46:06) mattock: I'll send the summary now
(20:46:19) ordex: good!
(20:46:21) ordex: thanks!
(20:46:38) mattock: sent

--------------525345784A65251A3DCC3024--

