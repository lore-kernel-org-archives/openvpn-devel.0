From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <41aca567-bc2a-8507-bdfb-9fd78aeef049@...515...>
Message-ID: <8c6cdd56-c690-778c-bff9-d1d4628e4393@...515...>
Date: Wed, 5 Dec 2018 13:59:27 +0200
MIME-Version: 1.0
In-Reply-To: <41aca567-bc2a-8507-bdfb-9fd78aeef049@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0FlR5AwAbd9DrltcWDEuF3RnhbuWMKaiR"
Subject: [Openvpn-devel] Summary of the community meeting (Wed, 5th Dec 2018)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0FlR5AwAbd9DrltcWDEuF3RnhbuWMKaiR
Content-Type: multipart/mixed; boundary="lZjOOWu3cVlNXOOVUnfz0MAnyFLnnbYFE";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <8c6cdd56-c690-778c-bff9-d1d4628e4393@...515...>
Subject: Summary of the community meeting (Wed, 5th Dec 2018)
References: <41aca567-bc2a-8507-bdfb-9fd78aeef049@...515...>
In-Reply-To: <41aca567-bc2a-8507-bdfb-9fd78aeef049@...515...>

--lZjOOWu3cVlNXOOVUnfz0MAnyFLnnbYFE
Content-Type: multipart/mixed;
 boundary="------------5DCCF57B45FD3F763E82160B"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------5DCCF57B45FD3F763E82160B
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 5th December 2018
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2018-12-05>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock, ordex, plaisthos and syzzer participated in this
meeting.

--

Talked about OpenVPN T-shirts. Mattock has contacted various active
community members and asked if they want T-shirts. Once all have
responded mattock will place the order. For cases where shipping the
T-shirts from Finland would be challenging (import/export restrictions)
mattock will provide gift coupons instead.

--

Talked about buildslaves. Mattock will not migrate the following ones to
his updated home server as they're all EOL:

- ubuntu-1204-amd64
- debian-7-i386
- fedora-24-amd64

Mattock will create two new VMs to replace the above:

- ubuntu-1804-amd64
- fedora-29-amd64

Cron2 is working on a FreeBSD 12 buildslave.

It was agreed that having ARM64 version of FreeBSD as well as Linux,
e.g. on Raspberry Pi3 would be useful.

--

Discussed the option of using tags such as "tlscryptv2" to make "git
describe" output more human-friendly. Agreed that tagging the commit
that changes the version in version.m4 is reasonable.

--

Discussed rate-limiting of unauthorized incoming packets. Noted that
while tls-auth/tls-crypt solve the problem, there are cases where it
does not help:

- Large setups which can't easily migrate to either easi
- VPN providers who cannot trust their users

Tls-crypt-v2 is the long-term solution for the problem. Agreed that we
need to investigate how difficult adding rate limiting would be. After
that we can resume this discussion.

--

Talked about tap-windows6 HLK testing. Stephen Stair is working on it,
and it looks promising, though there has not been much progress since
the previous meeting last week. We will soon have to ask for updates.

--

Discuss networking API patch. No updates since last week.

--

Reviewed OpenVPN 2.5 status. MSI work is progressing well, but the
testing it is somewhat challenging because it requires a multi-machine
setup (Linux, Windows) with Samba shares. Mattock is working on it.

The rest of the release does not look so bright due to review delays
(see below).

--

Talked about the problem of patches getting stuck in "waiting for review
/ in review" state. Agreed to start assigning patches to people when it
is clear who is responsible. Also agreed to do weekly hacking sessions
(on Fridays) to help reduce the rather large review delays.

--

Full chatlog attached.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



--------------5DCCF57B45FD3F763E82160B
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2018-12-05.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2018-12-05.txt"

(11:07:04) L'argomento di #openvpn-meeting =C3=A8: Next meeting on 24/Oct=
/2018 at 11:30CEST. Agenda at https://community.openvpn.net/openvpn/wiki/=
Topics-2018-10-24
(11:07:04) L'argomento per #openvpn-meeting =C3=A8 stato impostato da ord=
ex!~linuxaro@...2309.../batman/ordex a 12:31:58 su 24/10/2018
(12:32:53) syzzer: meeting time?
(12:33:59) lev__: hello
(12:34:38) cron2: yes
(12:34:57) mattock: hi
(12:34:58) cron2: someone needs to wake up mattock, ordex, dazo, plaistho=
s...
(12:35:00) cron2: ah!
(12:35:25) mattock: I made it!
(12:35:43) syzzer: wow :D
(12:36:08) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
8-12-05
(12:36:09) vpnHelper: Title: Topics-2018-12-05 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:36:19) mattock: I have a topic to add, just a sec
(12:36:37) mattock: cron2's favorite
(12:36:43) mattock: T-shirts
(12:37:17) cron2: moar topics
(12:37:20) mattock: so I've been asking some people active in the communi=
ty if they want t-shirts=20
(12:37:22) mattock: most do
(12:37:28) cron2: *like*
(12:37:33) cron2: (well, both)
(12:37:42) mattock: once I get yes or no from them I will start the order=
 process
(12:37:56) cron2: \o/
(12:38:04) mattock: in some cases I will probably buy them a gift coupon =
(e.g. if sending t-shirts from Finland would be tricky)
(12:38:10) cron2: (indeed, my favourite topic, and I will get into troubl=
e with my wife)
(12:38:24) mattock: you wear the OpenVPN T-shirts too much? :P
(12:38:42) cron2: no, I have too many t-shirts, so the wardrobe overflows=

(12:38:52) syzzer: :')
(12:38:57) mattock: ah
(12:39:03) mattock: ok, but that's all about the T-shirts
(12:39:26) mattock: topic #2?
(12:39:26) cron2: let's do 2. later (when dazo shows up)
(12:39:29) mattock: ah
(12:39:30) mattock: ok
(12:39:41) mattock: #3 buildslaves then
(12:39:59) mattock: so, I plan to discontinue a few of them
(12:40:08) mattock: ubuntu-1204-amd64, debian-7 and fedora-24-amd64
(12:40:12) mattock: any objections?
(12:40:18) ***plaisthos is woken up
(12:40:34) mattock: all are EOL (except ubuntu 12.04 which might still be=
 barely alive)
(12:40:40) mattock: not sure
(12:40:55) ***ordex is here but quite busy
(12:41:36) mattock: ubuntu 12.04 is EOL
(12:41:41) mattock: anyways, those will go
(12:41:46) mattock: won't migrate them to my new home server
(12:42:00) mattock: but to compensate I will setup a few new ones: ubuntu=
-1804-amd64 and fedora-29-amd64
(12:42:26) mattock: those two are ready except for the actual buildslave =
config which may require some changes to puppet modules that setup buildb=
ot
(12:43:01) mattock: the old, non-decommissioned buildslaves are running b=
ut have not checked if they actually work
(12:43:15) mattock: any comments/questions or shall we move on?
(12:44:07) cron2: I'll just add that I'll setup a FreeBSD 12 buildslave "=
soonish" (release is next week or so)
(12:44:18) cron2: and then review the freebsd zoo to see which ones can g=
o
(12:44:47) cron2: (and I still want the PI3 to do an ARM64/FreeBSD builds=
lave, but that's taking time which is not there)
(12:45:17) mattock: ah that would be nice
(12:45:35) mattock: in fact it would be good to have ARM64 Linux as well
(12:45:45) mattock: I have a PI3 but it is doing other stuff
(12:46:44) mattock: now that dazo is semi-present, what about git tags?
(12:46:46) mattock: #2
(12:47:38) cron2: this was triggered by plaisthos yesterday, trying to ma=
ke sense out of "git describe"
(12:47:41) cron2: which is now
(12:47:46) cron2: v2.4_rc2-400-ge11d2d14
(12:48:27) cron2: so the question is "do we want to regularily tag master=
 with something that servers as a base for humans to give an idea how old=
/recent a certain commit is"
(12:48:45) cron2: (or, more specifically, how old a *build* might be that=
 you encounter in a log file, etc)
(12:49:33) mattock: this would show up in "openvpn --version"
(12:49:34) mattock: ?
(12:49:41) cron2: it might
(12:49:53) cron2: (if we want it to) :)
(12:50:48) plaisthos: I probably otherwise just tag the branching point i=
n my repo with v2.5-master
(12:50:57) plaisthos: so I get a nicer looking version in my app
(12:52:52) syzzer: I think what plaisthos says makes more sense
(12:53:29) syzzer: just add a tag right after branching out, something li=
ke v2.5-unstable or v2.5-master or so
(12:53:55) plaisthos: which is more complicated here since it is the same=
 as v2.4_rc2
(12:54:10) plaisthos: so git might pick up one or the other, right?
(12:54:43) syzzer: it picks the most recent tag
(12:54:55) plaisthos: okay
(12:55:09) cron2: what about v2.5-master-201811 or something like that?
(12:55:24) cron2: just throwing ideas around that might or might not be u=
seful
(12:55:53) syzzer: cron2: why the date?
(12:56:18) cron2: you have "$tag-<number>" for "so many commits since $ta=
g"
(12:56:45) cron2: so a date might give some idea "is this a recent build =
or based on 2016-ish master"
(12:57:13) plaisthos: cron2: that would only work if we tag frequently
(12:57:28) plaisthos: I think just one tag that points out the branching =
point is better for us
(12:57:30) cron2: yes, that is part of the discussion :)
(12:57:42) plaisthos: or we do semantic tags
(12:57:53) syzzer: what is semantic tags?
(12:58:04) plaisthos: like v2.5-master-tlscryptv2
(12:58:17) plaisthos: but it becomes then a bikeshed dicussion what chang=
es require a tag
(12:58:30) syzzer: for me personally, just tagging the branching point su=
ffices
(12:59:06) plaisthos: I am confused by git:
(12:59:09) plaisthos: [11:58]arne@...2220...:main/cpp/openvpn% git merge-base i=
csopenvpn openvpn/release/2.4 =20
(12:59:12) plaisthos: a5ae0138eed240a23f46c0f091f1830ab36396c2
(12:59:14) plaisthos: [11:58]arne@...2220...:main/cpp/openvpn% git show-ref --t=
ags |grep a5ae0               =20
(12:59:17) plaisthos: a5ae0138eed240a23f46c0f091f1830ab36396c2 refs/tags/=
v2.5-master
(12:59:20) plaisthos: [11:58]arne@...2220...:main/cpp/openvpn% git describe    =
              =20
(12:59:22) plaisthos: v2.4_rc2-410-gbb481e41
(12:59:55) syzzer: but didn't you now place the v2.4_rc2 and v2.5-master =
tags on the same commit?
(13:00:38) plaisthos: no, I got confused by a5ae0 commit message which is=
:  Preparing OpenVPN v2.4_rc2 release
(13:01:21) plaisthos: the tag  v2.4_rc2 actually points to a different co=
mmit
(13:01:22) syzzer: I think e1dd49a3 should just get a tag that matches ve=
rsion.m4
(13:02:37) syzzer: I'll have to leave in a few minutes to catch a plane b=
tw
(13:03:52) mattock: have we reached a consensus?
(13:04:27) syzzer: not sure, I've just been giving my opinion so far :p
(13:04:29) mattock: tagging the branching point?
(13:04:37) mattock: anyone objects to that? :P
(13:05:11) syzzer: more specificatlly, I propose "Tagging the commit that=
 changes the version in version.m4"
(13:05:23) mattock: ok
(13:05:31) mattock: makes sense
(13:05:53) cron2: ok
(13:05:58) cron2: I can live with that
(13:06:52) plaisthos: sounds good
(13:07:11) mattock: move on?
(13:07:33) mattock: we all have our lunches to eat :P
(13:07:37) mattock: or planes to catch
(13:07:44) cron2: while syzzer is still here, can we quicky cover 6.?
(13:07:50) mattock: definitely
(13:07:58) mattock: OpenVPN 2.5 status=20
(13:08:21) syzzer: or rate-limit?
(13:08:24) cron2: rate-limit
(13:08:33) plaisthos: I think rate limit incoming packets is not a big is=
sue
(13:08:35) mattock: oh yes
(13:08:38) mattock: topic list was updated
(13:08:49) plaisthos: if it is an issue for you, use tls-autch/tls-crypt/=
tls-crypt-v2
(13:09:10) syzzer: I read along on the ml, and think our answer should pr=
obably just be "use tls-auth/crypt/crypt-v2"
(13:09:46) cron2: it is a big issue, since we're not enforcing tls-auth/c=
rypt and people have large deployed configs that can't be moved to tls-au=
th over night
(13:10:00) cron2: (also, it's an issue for large VPN providers that *use*=
 tls-auth but have a malicious customer)
(13:10:08) mattock: that one indeed
(13:10:15) syzzer: that's where tls-crypt-v2 should help :)
(13:10:23) plaisthos: for large VPN provider then tls-crypt-v2 is the ans=
wer
(13:10:35) plaisthos: syzzer: can you actually revoke client keys?
(13:10:41) syzzer: plaisthos: yes
(13:10:49) cron2: tls-crypt-v2 is the long-term answer, but not short ter=
m
(13:10:59) syzzer: oh, *but* only after the third packets...
(13:11:24) syzzer: because the actual revocation checking is a burden on =
the server itself
(13:11:34) syzzer: so is only done after the first three-way handshake
(13:11:46) syzzer: oh, but I now really have to leave
(13:11:52) syzzer: I think this over a bit more
(13:11:53) plaisthos: bye
(13:11:56) mattock: bye!
(13:13:11) mattock: so how big a can of worms is implementing rate limiti=
ng?
(13:13:17) mattock: "should we go there"
(13:13:39) plaisthos: probably a lot of work=20
(13:13:45) cron2: I have no idea because I'm not sure how much magic Jame=
s has already provided
(13:13:56) cron2: we have hashes, timers, events
(13:14:01) plaisthos: and only benefits those large VPN providers
(13:14:23) plaisthos: everyone else should be fine with tls-auth/tls-cryp=
t(-v2)
(13:14:31) cron2: you have seen more client configs than we have - what's=
 the percentage of tls-auth-using VPNs out there?
(13:14:50) plaisthos: OpenVPN AS uses it by default
(13:15:05) plaisthos: for the rest depends on what tutorial people used
(13:15:16) plaisthos: some even if the same tls-auth key as in the tutori=
al :D
(13:15:42) mattock: you mean the VPN providers setup their servers with t=
ls-auth keys from a tutorial :P ?
(13:16:06) plaisthos: no for your home run vpn server
(13:16:15) mattock: I thought so
(13:16:27) plaisthos: but considering that there is *still* a VPN provide=
r with MD5 certificates I would not bet against you
(13:16:28) mattock: cron2 was specifically asking for client configs from=
 VPN providers
(13:16:40) cron2: not particularily, just "configs"
(13:16:53) mattock: ah
(13:16:59) mattock: well anyways
(13:17:12) mattock: 13 minutes left
(13:18:34) plaisthos: for most home use VPN configs the normal DOS will s=
aturate your bandwidth and you are dead anyway *shrugs*
(13:18:34) cron2: the point is reflection, throw packets at other people
(13:21:08) mattock: as for implementation: "need to investigate more"?
(13:21:17) cron2: definitely :)
(13:21:39) mattock: continue discussion after more investigation?
(13:22:21) cron2: yep.  leave on agenda for next week, then see if we wan=
t/can do something
(13:22:24) mattock: ok
(13:22:35) mattock: I propose #5 tap-windows6 because it is fast
(13:22:44) cron2: I was about to say that :)
(13:22:46) mattock: "not much has happened, will soon have to ask Stephen=
"
(13:23:57) cron2: on 4., no updates either
(13:24:02) mattock: that was fash
(13:24:04) mattock: fast
(13:24:12) cron2: which brings us to 7., and that's also not very satisfy=
ing
(13:24:31) mattock: OpenVPN 2.5 status
(13:24:53) mattock: rozmansi and selva have worked on it actively
(13:25:07) mattock: I'm in the process of testing the MSI packaging, but =
stuff keep getting in the way
(13:25:25) mattock: it involves a two-machine setup (one linux, one windo=
ws) with samba shares
(13:25:33) mattock: so it is more complicated than what we had previously=

(13:25:37) cron2: haven't seen anything from Selva - was that off-list?
(13:25:42) mattock: in the PR
(13:25:44) mattock: openvpn-build
(13:25:45) cron2: ah
(13:26:14) mattock: rozmansi's changes are very large, so it just needs t=
o be tested to see if there are any glitches
(13:26:28) cron2: I can merge the openvpnmsica patch set if you say "it's=
 working" - we haven't seen an ACK or LGTM on the *first* patch of the se=
ries, though, which is the biggest hunk...
(13:26:51) mattock: I did build-test the patch that added tapctl.exe and =
the MSI custom action
(13:26:54) cron2: it's not "openvpn code", but it's "runs privileged on w=
indows code", so it needs a bit of review, at least
(13:27:24) mattock: but I think we can wait until the test setup is ready=
, so that the whole build stack can be tested
(13:27:47) mattock: what about the "other stuff" in OpenVPN 2.5?
(13:27:53) cron2: this is at least some good news :-) - the rest is more =
depressing
(13:27:58) cron2: we have about 100 patches in patchwork, and once a week=
 (or even more infrequent) someone speaks up and complains about coding s=
tyle...
(13:28:16) mattock: review issues that is?
(13:28:28) cron2: so our ACKs are working even less well than usual
(13:28:59) mattock: maybe have these meetings weekly so that we can get t=
o the last topic ("review patches in patchwork")?
(13:29:10) mattock: maybe even pick some patches from patchwork to focus =
on
(13:29:24) cron2: we do have weekly meetings, even though you're not alwa=
ys here :-)
(13:29:29) mattock: lol yes
(13:29:34) mattock: the first time I believe I forgot to join
(13:29:49) mattock: now I will hear about it for the rest of my life :D
(13:30:31) mattock: but we could pick some patches as separate topics
(13:30:37) cron2: not sure the meeting is the right place to increase our=
 agility here ("ah, I could do a review now, but I can do it next wednesd=
ay, so let's wait for the meeting")
(13:30:55) mattock: that is a risk yes
(13:31:38) mattock: though I'm not sure what the best solution would be
(13:31:41) cron2: so, ordex, plaisthos, dazo: how can we improve?
(13:32:38) mattock: my worry is that internal development is taking (argu=
ably) too much time from ordex, plaisthos and dazo
(13:32:44) ordex: sorry if I am not here for real today - just very busy =
=2E-.
(13:33:01) ordex: what do we want to "improve" exactly? review effort?
(13:33:20) mattock: patches get stuck in review
(13:33:23) cron2: improve the "patch is out there for four weeks, and the=
n there is a review complaing about style, and then nothing ever again" c=
ycle
(13:33:34) ordex: yeah
(13:34:05) ordex: I think currently we have very complex patches out ther=
e and often very big, so just doing context switch to review requires qui=
te some time at every cycle
(13:34:11) cron2: focusing on style is ok, but I think the review should =
at least cover the technical merits as well, so "if the style is fixed, i=
t has my ACK" can really help move forward
(13:34:30) ordex: cron2: yeah, that's true
(13:34:41) ordex: it's just that sometimes it is better to do style revie=
w rather than nothing at all :p
(13:34:43) ordex: but I agree
(13:34:56) cron2: I'm not sure if a sole style complaint is better than "=
nothing at all"
(13:35:20) ordex: I am just use to the old rude rule "if style is not pro=
per, I won't even check your patch"
(13:35:26) cron2: if I send a patch to the list, nothing happens for four=
 weeks, and then I get back a "your coding style sucks" mail - do you thi=
nk I'll be motivated to send a v2 like the next day?
(13:35:50) cron2: now if the coding style complaint comes in like "5 minu=
tes after the patch hits the list" - that's something different
(13:36:00) ordex: cron2: well, if my time is so little that I could only =
spend it to review the poor style, that it really means the writer wasted=
 my time to be honest
(13:36:11) ordex: *then
(13:36:34) dazo: Can we "fix" this by just running uncrustify on commit t=
ime when there are code style complaints?
(13:36:35) ordex: nonetheless I agree that making everything faster would=
 be better
(13:36:50) cron2: dazo: that's what we already agreed that we want to do =
:-)
(13:36:58) ordex: yeah, having an automatic style checker would definitel=
y improve this, but we did not get there yet
(13:37:06) cron2: (and this is why I sent 3 uncrustify patches last satur=
day which nobody showed an interest in...)
(13:37:18) ordex: still, if after setting this rule we get patches with s=
tyle mistakes, they really won't deserve any review :-P
(13:37:22) ordex: yeah :(
(13:37:35) mattock: if there is a technical solution to the style problem=
s let's by all means implement it a.s.a.p.
(13:37:35) cron2: ordex: plaisthos' found the tool online, you just need =
to use it - since this is something that needs to be done locally
(13:37:57) cron2: "run uncrustify in the local pre-commit-check", at leas=
t those from the core team that do large patch sets
(13:38:12) ordex: yap
(13:38:13) plaisthos: I think for non core members we can be a bit more r=
eliant and run uncrustify for them but for core members we can enforce cl=
ean patches
(13:38:17) cron2: for a first-time submitter, be gentle and accepting (an=
d possibly uncrustify on merge)
(13:38:26) dazo: yes ... but ... still, this is actually just side-tracki=
ng the real problem .... most of us are just far too busy :/
(13:38:43) dazo: agreed
(13:39:13) ***cron2 can do merges in 5 minutes "at any times" - if I have=
 an ACK...
(13:39:38) ordex: I think it's the ACK that requires 5^n minutes :D
(13:39:47) dazo: yupp
(13:39:54) cron2: (and this is actually something that nicely fits in bet=
ween feeding kids, bringing them to bed, et.c)
(13:40:35) cron2: but I can't review windows patches, build system patche=
s, tap driver patches, networking patches, crypto patches, etc. all by my=
self
(13:41:00) cron2: anyway
(13:41:23) mattock: so how do we set aside time to do patch review?
(13:41:39) cron2: what we need to come to acceptance, I think, is that we=
're not going to make "end of december" with 2.5 - if we can agree that t=
his is acceptable, we can just move forward as time permits
(13:41:55) ordex: openvpn inc is already willing to "sponsor" some hours =
every week to do review or community work in general
(13:42:15) mattock: they ought to :P
(13:42:22) ordex: but the issue is really allocating time
(13:42:29) cron2: so I have heard at the hackathon, but it hasn't materia=
lized visibly yet :-)
(13:42:35) mattock: +1
(13:42:43) dazo: From a personal perspective .... I'm dragged in two dire=
ctions; paid work wants focus on openvpn3 related stuff - with its own de=
adline, but also understands the need to do openvpn2 community work .... =
and community work backlog is huge and taking a lot of efforts .... it is=
 really hard for me to find a good balance here
(13:42:55) dazo: I agree, we can't make the 2.5 in december
(13:43:22) cron2: shall we re-try the idea with focused community work da=
ys?
(13:43:31) mattock: I'm also constantly pulled into different directions =
which makes it difficult to focus on community stuff
(13:43:42) mattock: cron2: I like that idea
(13:43:45) ordex: personally I'd need to integrate a bit more openvpn com=
munity effort into my project management schedule: i.e. at the moment I d=
on't know what is waiting my review or what might be allocate don me. unl=
ess I spend 20 minutes checking the mailing list (of course I remember st=
uff, but can't remember the exact patches to review)
(13:43:46) cron2: like, "Friday, cron2, ordex and plaisthos are *online*,=
 and focus on quick turnarounds?"
(13:44:05) ordex: cron2: how would that work? we do review together ?
(13:44:24) ordex: if I';d get a number of patches allocated to me on PW I=
'd already be happier, because then I'd just go there and see my queue, f=
or example
(13:44:26) cron2: ordex: one of the problems right now is the delays
(13:44:33) cron2: plaisthos sends a patch
(13:44:38) cron2: you review it 5 days later
(13:44:44) cron2: plaisthos sends a v2 after a week
(13:44:49) cron2: you review it a week later
(13:44:51) cron2: plaisthos sends a v3 after a week
(13:44:56) cron2: ... a month lost
(13:45:10) ordex: yap
(13:45:12) ordex: true
(13:45:18) cron2: so if we can be online and active at the same time, we =
can discuss technical questions on IRC "in real time"
(13:45:44) cron2: like, "so, I try <this> and it does <that>, is that int=
entional?" and get back a "oh, I'll send a v4 right away" or "yes, it's i=
n the manpage"
(13:46:08) dazo: mattock1: aren't you doing some live internal hacking se=
ssions with Justin, via appear.in?   If so, what's the experience here?
(13:46:19) cron2: and stuff like style review or typos can be fixed for g=
ood because it's like "there is still something wrong here" - "ok, I#ll s=
end a v4!"
(13:46:59) dazo: we could try to do something similar, to have at least a=
n audio channel open during these sessions .... as in a virtual meeting r=
oom when working our way through the patches
(13:47:01) cron2: not sure we need audio/video conferencing, but "being p=
resent and responsive" is what ismissing
(13:47:20) dazo: but it's harder to "hide" when you have that channel ope=
n ;-)
(13:47:49) dazo: kinda like an ad-hoc online hackathon=20
(13:47:59) ordex: to be honest, I think the problem is just motivation. I=
 speak to plaisthos everyday basically, so I can get quick response from =
him in a very reasonable time. the point is that "it is never good time t=
o do community stuff"
(13:48:16) ordex: so this gets always pushed to later
(13:48:33) cron2: ordex: so, shall we arrange for chocolate to send your =
way, to increase motivation? :-)
(13:48:36) ordex: and "forcing ourselves" to be present at the same time =
to do community stuff might work a couple of times
(13:48:37) ordex: haha
(13:48:38) ordex: :D
(13:48:40) ordex: no thanks
(13:48:47) mattock: dazo: yes I do have sessions with Justin and they wor=
k well imho
(13:49:08) cron2: ordex: so, do you have an idea how to get moving again?=

(13:49:36) plaisthos: I am also not always in the mood or can concentrate=
 well enough to review patches
(13:49:37) cron2: I'm not going to "force" anyone to anything (as that do=
esn't work for community stuff), just trying ideas
(13:49:53) ordex: cron2: personally, as I said before, for me it might wo=
rk to get a task queue built up on my head: i.e. delegate patches to me o=
n pw. I have an easy and quick way to check patches in my queue and I go =
through when I have time allocated
(13:49:58) cron2: plaisthos: coffee or chocolate your way?
(13:50:07) ordex: yeah, this is why I used quotes :)
(13:50:09) plaisthos: coffee does not work on me :P
(13:50:15) ordex: hehe
(13:50:16) cron2: plaisthos: rum?
(13:50:22) plaisthos: cron2: tea ;)
(13:50:22) ordex: <o>
(13:50:43) cron2: (looking at some of the patches, I'm sure Alcohol must =
have been involved... :) )
(13:50:46) plaisthos: but having a view in patchworks that is assigned to=
 me and uassigned patches would really help
(13:50:47) mattock: I think we should try cron2's suggestion unless someb=
ody has better ideas
(13:51:15) plaisthos: I have far too often spend like 10 minutes to figur=
e out what to review next in patchworks and then given up
(13:51:19) ordex: cron2: how about going through the patches in pw and de=
legate to me what you believe I should review because .. it falls under s=
omething i can understand?
(13:51:22) cron2: we didn't "assign" stuff in patchwork so far because *I=
* do not like that :-) - but if you're ok with it, I can try that
(13:51:42) ordex: cron2: yeah, each of us has his own way, not saying it =
will work for everybody :)
(13:52:03) ordex: mattock1: that is? being online on friday night on IRC =
doing code review? :D
(13:52:23) cron2: ok, I'll try to assign a few things tonight, to see if =
that works out
(13:52:39) cron2: what about "v1 of the patch was sent, got back a commen=
t, and then nothing" stalemates?
(13:52:43) mattock: ordex: for example yes
(13:52:51) mattock: we can start with assigning patches though
(13:52:59) mattock: to see if that actually helps
(13:53:15) mattock: I need to go eat lunch
(13:53:18) ordex: cron2: yeah, I hope that would follow once the work is =
more structured
(13:53:23) ordex: oky
(13:53:29) mattock: consensus: "will start assigning patches in patchwork=
"?
(13:53:34) dazo: mattock1 and I have a meeting this Friday evening (19:00=
 CET) ... but otherwise, I think it's a good idea ... I can normally allo=
cate times on Fridays unless there are deadlines we're trying to reach.
(13:53:45) dazo: mattock1: +1
(13:53:50) mattock: ok
(13:54:08) cron2: I'll do a few tonight, and we see how it works.  I'll b=
e around on Friday after about 10 am to 6 pm local time
(13:54:25) dazo: I think it makes sense to assign patches in patchwork wh=
en there's a clearly defined person with the required skills to bring it =
forward
(13:55:00) mattock: done for today?
(13:55:08) cron2: totally so
(13:55:12) mattock: \o/
(13:55:12) ***cron2 needs coffee :)
(13:55:15) dazo: And I'll try to get the openvpn3-linux beta release out-=
the-door today, which hopefully will give me some more flexibility in the=
 near future
(13:55:18) mattock: let's get the train moving forward again
(13:55:20) cron2: but I think we have a way forward
(13:55:21) cron2: yes
(13:55:29) mattock: "Make OpenVPN 2.x development great again!"
(13:55:31) plaisthos: I will push openssl 1.1.1 on my app users :P
(13:55:45) cron2: I'll start with assigning the uncrustify patches to ord=
ex, they should be to his liking :)
(13:55:50) ordex: :)

--------------5DCCF57B45FD3F763E82160B--

--lZjOOWu3cVlNXOOVUnfz0MAnyFLnnbYFE--

--0FlR5AwAbd9DrltcWDEuF3RnhbuWMKaiR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlwHvZ8ACgkQKVhNn0CG
RXjjIggAroFY/qiBL2IuJHApudg/9IRhB0AoeKodMdo1fKqHc6UbmUPuS+ANqtAi
yzgY7djJpJDppHJ+DYmd5G4446zGX4ykVl/zWB+NKqtrTPotDYF6pMNySRGu/XFH
wo0NnyXUVHGETbYDzV58pyqtwonOk2mtCSR1ljCGBJUOrZaiiLLTCLys/PkVaBzT
FBKUWwJnWrr1+3Z06GXZWvYTREiKNHAYvNF+9xpYFsoGM5C92NrujUNLKJNxwgsV
kxFc/7JpB8W1kqg99ruMLFZKi9SWSsOJLlADHxv7kXSIQVcKVd1CQTyDST1l0Jum
A7/jhVXftwchxJDuzagA1vtkagcz4g==
=h3nF
-----END PGP SIGNATURE-----

--0FlR5AwAbd9DrltcWDEuF3RnhbuWMKaiR--

