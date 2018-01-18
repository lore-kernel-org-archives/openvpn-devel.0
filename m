From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <7e30a9ca-2b93-c99e-997c-ad1d9814c52b@...515...>
Message-ID: <dbfb262b-1193-e6c1-5e1c-2e4b20fd6db6@...515...>
Date: Thu, 18 Jan 2018 11:16:43 +0200
MIME-Version: 1.0
In-Reply-To: <7e30a9ca-2b93-c99e-997c-ad1d9814c52b@...515...>
Content-Type: multipart/mixed; boundary="------------4D04218C73FDBC123D97ABB8"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (Wed,
 17th Jan 2018)
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
--------------4D04218C73FDBC123D97ABB8
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.
---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 17th Jan 2018
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2018-01-17>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock, ordex, plaisthos and syzzer participated in this
meeting.

--

Discussed the option of having Buildbot build "release/2.4" branch in
addition to "master". Agreed that it makes sense. Mattock will make it
happen.

--

Discussed the OpenVPN 2.4.5 release. Most of the improvements will be
related to Windows:

- OpenSSL 1.1.0
- Update easy-rsa-old
- Updated openvpn-gui
- PKCS#11 RFC7512 URI compliance

The release date was set to Thursday 25th.

--

Discussed the "'ecdsa-sig' management interface command" as requested by
Selva:

<https://community.openvpn.net/openvpn/wiki/Topics-2018-01-17#ecdsa-sig>

It was decided to let Selva make the call based on the feedback (see
full chatlog).

---

Full chatlog attached.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------4D04218C73FDBC123D97ABB8
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2018-01-17.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2018-01-17.txt"

(12:29:40) syzzer: almost time...
(12:30:12) cron2: time!
(12:30:22) syzzer: go go go!
(12:30:29) ordex: :O
(12:30:33) ***ordex jumps
(12:31:06) ***dazo sits down
(12:31:11) dazo: to hard to type and run at the same time
(12:32:05) syzzer: So, https://community.openvpn.net/openvpn/wiki/Topics-=
2018-01-17
(12:32:06) vpnHelper: Title: Topics-2018-01-17 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:32:13) ordex: din din din
(12:32:16) ordex: the market opens
(12:33:46) syzzer: I guess we need mattock for #1, so start with #2?
(12:33:46) ordex: buildbot first ?
(12:33:55) ordex: ah ok
(12:34:03) mattock: guten tag
(12:34:07) ordex: aloha
(12:34:36) mattock: I will need to split quite soon, but will follow the =
discussion on my selfphone
(12:34:42) mattock: tight schedule today
(12:34:46) mattock: buildbot first?
(12:34:53) syzzer: ok
(12:34:54) ordex: ok
(12:35:04) cron2: go :)
(12:35:06) mattock: do we want to build release/2.4?
(12:35:30) mattock: if yes, which combos?
(12:35:33) syzzer: I think it would make sense to actually build and test=
 the code we ship to users
(12:35:38) ordex: I think it makes sense. that is the one we should pay m=
ore attention to, I think
(12:35:39) ordex: yeah
(12:35:47) mattock: syzzer: you make a convincing point there :D
(12:35:51) mattock: which build combos?
(12:35:55) mattock: all?
(12:36:27) syzzer: if that's not too much work
(12:36:57) mattock: not really
(12:37:01) mattock: probably a few lines of code
(12:37:07) cron2: ordex: I'm not sure about the "more" attention, as we u=
sually do not put things-that-break into 2.4 (but break them in master, f=
ix them, backport them, or break master and 2.4 at the same time)
(12:37:10) mattock: I will add a task for myself
(12:37:26) cron2: but generally speaking, testing at least the most commo=
n build combinations on 2.4 is a good thing
(12:37:34) cron2: t_client.rc will be compatible (unlike 2.3<->2.4)
(12:37:58) mattock: right now we don't have _that_ many builds going on, =
so doubling them is doable
(12:38:00) ordex: cron2: the way you say it looks like you know what is g=
oing to break and what not :-P
(12:38:25) mattock: shall we move on to 2.4.5?
(12:38:25) ordex: but I get what you mean, still I think buildbot would i=
ncrease confidence in the code correctness, no ?
(12:38:34) mattock: ordex: agreed, and doing that is cheap
(12:38:38) ordex: ok
(12:38:40) ordex: next
(12:38:47) cron2: ordex: usually I have a good idea whether something wil=
l blow up one of the BSDs, or a particular network corner
(12:39:00) cron2: but yep, ok, next
(12:39:12) ordex: okyz :)
(12:39:14) syzzer: re 2.4.5:  I think mattock, cron2 and dazo need to agr=
ee when to push it out.
(12:39:23) cron2: mattock: ... and --disable-crypto on master, as that's =
just wasting CPU (which is not cheap)
(12:39:24) mattock: that is the case
(12:39:30) mattock: cron2: will do
(12:39:50) cron2: syzzer: indeed.  What do we want in there?  Windows ins=
tallers with OpenSSL 1.1?  Any particular wishes?
(12:40:33) syzzer: cron2: I'd really like Allow changing cipher from a cc=
d file (https://patchwork.openvpn.net/patch/92/) to go in
(12:40:34) vpnHelper: Title: [v2] Allow changing cipher from a ccd file -=
 Patchwork (at patchwork.openvpn.net)
(12:40:49) cron2: syzzer: into 2.4?  I thought that is master stuff?
(12:41:00) cron2: ah
(12:41:02) ***cron2 is confused
(12:41:30) cron2: we effectively have per-client ciphers in 2.4, as we *h=
ave* NCP, so it's just "remember that we can do that" thing :)
(12:41:58) syzzer: cron2: exactly
(12:42:01) mattock: I'll check my notes for 2.4.5
(12:42:50) dazo: What's in the pipe for 2.4.5 looks mostly to be improvin=
g the Windows parts as well ... the generic code is just minor clean-ups =
or minor bug fixes
(12:42:56) cron2: right
(12:43:10) dazo: I have no issues with shipping this out
(12:43:23) mattock: openssl 1.1.0, updated easy-rsa-old, updated openvpn-=
gui, pkcs#11 RFC7512 uri compliance
(12:43:48) mattock: many of the above have been merged already
(12:43:55) dazo: mattock: any reason not to add the new easy-rsa together=
 with easy-rsa-old?
(12:44:09) mattock: yes, the need to do extra work :P
(12:44:15) dazo: :-P
(12:44:37) mattock: but yes, I see your point
(12:44:54) mattock: or we could spend the effort into the MSI installer i=
nstead
(12:45:31) mattock: which would bundle easy-rsa 3 as the only option mayb=
e?
(12:45:59) syzzer: MSI installer can be an independent thing, right?
(12:46:04) mattock: yeah, definitely
(12:46:16) mattock: an alternative for NSIS installer at first
(12:46:23) syzzer: yeah, perfect
(12:46:38) syzzer: so, should we set a date?
(12:46:42) mattock: yes
(12:46:59) mattock: thursday next week?
(12:47:08) cron2: works for me
(12:47:59) syzzer: +1
(12:48:02) mattock: great!
(12:49:15) ordex: I don't have anything to do, but I agree!
(12:49:22) mattock: :)
(12:49:38) ordex: dazo might be out
(12:49:47) ordex: but let's see what he says
(12:49:52) mattock: ok, so I need to split now
(12:49:56) cron2: if you do not mess with keys too much, I can do that
(12:49:59) mattock: but please check topic #3 from selva
(12:50:04) mattock: I won't be of much use there anyways
(12:50:10) ***cron2 is out on #3
(12:50:33) mattock: moving to my selfphone now...
(12:50:37) syzzer: I already posted to the ml:  I think a generic pkey-si=
gn is a good idea
(12:51:49) mattock_ [~mattock@...1423.../corp/admin/mattock] =C3=A8 entrato =
nella stanza.
(12:52:14) dazo: Next week I'm at devconf.cz ... Thursday is travelling d=
ay
(12:52:25) plaisthos [~arne@...1423.../community/developer/plaisthos] =C3=A8=
 entrato nella stanza.
(12:52:31) syzzer: plaisthos might have an opinion
(12:52:37) syzzer: https://community.openvpn.net/openvpn/wiki/Topics-2018=
-01-17
(12:52:40) syzzer: topic #3
(12:52:41) vpnHelper: Title: Topics-2018-01-17 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:53:05) dazo: but I think cron2 can tackle this ... or I can prepare t=
hings Wed evening
(12:53:37) plaisthos: the pk-sig stuff?
(12:54:16) plaisthos: I think renaming it to pk-sig is better option here=

(12:54:39) plaisthos: that is a relatively obscure feature and most clien=
t that use it will use a bundled openvpn anyway=20
(12:54:58) syzzer: ok, perfect.  I think so too.
(12:55:10) plaisthos: and with pk-sig, the client can still then answer w=
ith an empy sig if it does not support signature of that kind
(12:55:22) plaisthos: instead of hanging forever like it is probably with=
 the v1 of the patch
(12:55:58) plaisthos: and worst case for clients that need support <2.5 a=
nd 2.4 is to treat pk-sig and rsa-sig identical so problem there
(12:56:43) plaisthos: and I would not go through deprecation of rsa-sig, =
just rename it now and put into changelog
(12:57:04) syzzer: yeah.  so conclusion is that we agree that selva takes=
 that direction
(12:57:52) syzzer: or just keep it around as an alias, simple enough
(12:57:54) plaisthos: tunnelblick will need to adapt :)
(12:58:00) plaisthos: syzzer: nah cannot have that
(12:58:10) plaisthos: for response yes
(12:58:27) syzzer: I know more users who use external-key
(12:59:00) plaisthos: but since the query will change from >RSASIGN to >P=
K-SIGN you need to change the code anyway, so keeping just half compabibi=
lity is not that nice
(12:59:17) plaisthos: but yeah makes it a bit easier on management client=
 (I can always respond with rsa-sign)
(12:59:34) syzzer: hm, I'm not so sure why an alias of RSASIGN wouldn't w=
ork?
(13:00:05) syzzer: but let's first leave that to Selva, he usually comes =
up with a good solution :p
(13:00:47) plaisthos: syzzer: the client request the client to send a sig=
nature
(13:01:00) plaisthos: currently the client gets RSASIGN with the base64.
(13:01:09) syzzer: ah, right!
(13:01:20) plaisthos: sending both PK-SIGN with base64 and RSASIGN with b=
ase64 would be strange
(13:01:59) syzzer: you convinced me, hard switch makes sense
(13:02:31) plaisthos: (:
(13:03:16) dazo: I'm very sceptical to remove RSASIGN ... this can truly =
break some setups we're not aware of.  Rather make RSASIGN be an "alias" =
for PK-SIGN
(13:03:31) syzzer: dazo: see discussion above ;-)
(13:05:29) syzzer: the way around would be to keep sending RSA-SIGN for R=
SA sigs "forever"
(13:05:32) dazo: Yeah ... If I've understood correctly, it sounds like RS=
ASIGN will be removed and replaced with PK-SIGN ... and that is a no-go
(13:06:10) syzzer: dazo: this is a *command* from openvpn to the mgmt if,=
 so we have to either keep it forever=20
(13:06:17) syzzer: or make a hard switch
(13:06:24) syzzer: it can not be an alias
(13:06:53) cron2: oh, we could add capability negotiation between openvpn=
 mgmt if and mgmt if client
(13:07:02) ***cron2 ducks
(13:07:11) dazo: I don't follow why it can't be an alias ... it needs a m=
inor logic in the reply (if command was RSASIGN, respond with >RSASIGN ..=
=2E otherwise >PK-SIGN)
(13:07:12) syzzer: cron2: yauh, you better :p
(13:07:28) syzzer: dazo: that is the other end of the mgmt if
(13:07:30) cron2: dazo: that's the reply on the mgmt client side, but wha=
t sort of request shall openvpn send out?
(13:07:32) syzzer: *we* send the command
(13:07:47) dazo: ahh ...=20
(13:08:07) syzzer: glad to see I'm not the only one that overlooked that =
:p
(13:08:14) dazo: :)
(13:08:47) dazo: That does indeed speak for hard-switch .... but that wil=
l truly cause lots of bug reports
(13:08:58) dazo: from various implementation we're not aware of
(13:09:40) syzzer: yeah, it will,  so we should be document it clearly in=
 changes.rst and only do in a major update
(13:09:45) plaisthos: only alternative we have is to have the burden ours=
elf to introduce an option that says that the client is pk-sign ready whi=
ch introduces a lot of complexity for us
(13:10:00) syzzer: yeah, let's not do that
(13:10:01) dazo: Then I think we need a pre-command ... which does the sw=
itch .... PK-INIT 2  (to use PK-SIGN) ... or PK-INIT 1 (default, as it is=
 today, uses >RSASIGN)
(13:10:23) syzzer: I'd rather send RSA-SIGN "forever"
(13:10:30) plaisthos: or always use RSA-SIGN even though it can ask for e=
cdsa sigs
(13:11:04) syzzer: we know when we expect an RSA sig, right?  we can just=
 send RSA-SIG forever in that case
(13:11:18) plaisthos: yeah
(13:11:27) syzzer: and treat the responses as aliases
(13:11:35) dazo: yeah, that does sound cleaner .... Let me follow-up with=
 this question internally, and see if we see any issues from the corp sid=
e of things .... If the corp side says "PK-SIGN" will work in a major upd=
ate, then much of my concerns are gone
(13:11:41) plaisthos: just document it that it is called rsa-sig for hist=
orical reasons
(13:12:16) plaisthos: dazo: you just need to alias in your code to treat =
PK-SIGN as RSA-SIGN
(13:12:42) plaisthos: otherwise we stick to the "for historical reasons"
(13:12:47) dazo: right ... but it's not just our code ... we have custome=
rs too implementing openvpn 2 and 3 in various settings :)
(13:13:58) dazo: Currently I'm now leaning towards "for historical reason=
s" ... that gives the least potential for breakage
(13:14:20) plaisthos: depends if you want to have compatibility reasons
(13:14:49) plaisthos: or let users that upgrade to 2.5 double check that =
their implementation does not segfault when it gets a request with ecdsa =
signing
(13:15:05) plaisthos: as openvpn did with management-external-key not lon=
g ago
(13:17:02) plaisthos: (small risk in normal environment since you need ec=
 certs to get that code path)
(13:18:23) syzzer: I don't like "for historical reasons", it results in t=
errible user experience
(13:19:21) syzzer: just recall the SSLv23_new() stuff from openssl
(13:20:18) syzzer: this is a power user corner case.  If we document it w=
ell, they should be able to deal with it.
(13:21:03) plaisthos: oh yeah, beta API evar. But we then also need anoth=
er implement PK-SIGN that only does RSA and RSA-SIGN that does ecdsa+rsa =
to fully capture the spirit of SSLv23_new
(13:21:19) ordex: :D
(13:22:58) syzzer: (still, we could keep sending RSA-SIG for a while for =
rsa sigs only, and send PK-SIG for EC sigs, right?)
(13:23:52) syzzer: as an escape if we expect troubles
(13:26:00) syzzer: anyway, I think we have plenty of input for Selva :p
(13:26:02) plaisthos: PK-SIG unaware clients would just hang
(13:26:31) plaisthos: and we would have the same discussion for next rele=
ase
(13:26:32) syzzer: because we wait forever for a response?
(13:26:35) plaisthos: yes
(13:26:44) syzzer: then we should not wait forever?
(13:27:05) syzzer: a timeout sounds like a decent thing anyway
(13:27:13) plaisthos: well
(13:27:28) plaisthos: you might have a smartcard or something else with u=
ser input in there
(13:27:50) syzzer: sure, so a rather large timeout
(13:27:59) plaisthos: Don't put a timeout there, it is just complicates t=
hing for no good reason
(13:29:20) plaisthos: we can expect magement-clients to be well behaved
(13:30:42) syzzer: hm, that makes sense too...
(13:30:57) syzzer: okay, I'll just back off untill I've taking a closer l=
ook at this
(13:31:45) cron2: so the ACK for 3/3 should be revoked then, right?
(13:31:53) cron2: because the documentation won't look as proposed
(13:32:16) plaisthos: I think that is implicit=20
(13:32:51) syzzer: Un-acked-by: ?
(13:32:59) cron2: no idea if that can be done
(13:33:05) syzzer: haha
(13:33:35) cron2: anyway... I think 3. is concluded?  $Wife is hungry :)
(13:33:37) syzzer: in other news: time's up, I need lunch :p
(13:34:27) ordex: good idea
(13:35:02) cron2: so what about 5.?
(13:35:13) plaisthos: sounds good
(13:35:24) plaisthos: although most bugs end in my github=20
(13:35:42) plaisthos: but yeah for the misguided adding a OpenVPN for And=
roid component is easier on ordex=20
(13:35:45) syzzer: yeah, 5. makes sense
(13:36:10) plaisthos: but users will mix that up anyway
(13:36:27) plaisthos: I also get OpenVPN connect questions
(13:36:40) ordex: plaisthos: we could have "Community clients"
(13:36:45) ordex: to group also tunneblick and other stuff
(13:37:03) ordex: plaisthos: yeah but at least we can later better classi=
fy ourselves
(13:37:31) plaisthos: ordex: yeah, feel free, and bugs that my client can=
 be closed and dircted to my github issue tracker if needed
(13:37:50) ordex: ok
(13:38:04) ordex: sounds good
(13:38:57) plaisthos: There is the category that is OpenVPN for Android b=
ut actually core openvpn might be a thing you might think aobut for 5 min=
utes
(13:39:29) plaisthos: but probably fine that just openvpn
(13:42:29) ordex: yep

--------------4D04218C73FDBC123D97ABB8--

