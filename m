From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <5913da48-b476-7922-4248-8700ba21aa61@...515...>
Message-ID: <77bbaa92-8772-78be-9e3c-d5eb4b0b9091@...515...>
Date: Wed, 5 May 2021 16:33:05 +0300
MIME-Version: 1.0
In-Reply-To: <5913da48-b476-7922-4248-8700ba21aa61@...515...>
Content-Type: multipart/mixed; boundary="------------A3D75748C0FA65484E15704B"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (5th May 2021)
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
--------------A3D75748C0FA65484E15704B
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 5th May 2021
Time: 14:00 CET (12:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2021-05-05>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, d12fk, lev, mattock, ordex and plaisthos participated in=20
this meeting.

--=20

Lev is working on arm64 support in dco-win. So far he has managed to=20
produce MSI which runs on arm64, but installation fails because his=20
customactions.dll runs on .net framework which is not available for=20
arm64, so he is rewriting it to C++ (should=92t be a big task).

---

Talked about  backporting the "Fix build with mbedtls w/o SSL=20
renegotiation support" patch to 2.5. Agreed that this should be merged=20
because the patch that breaks the build is also there.

---

Ordex is working on the few remaining patches from Arne - they touch the=20
TLS state machine so further digging is required, hence more time to=20
stamp with ACK.

---

Talked about DCO for Linux. There has not been much feedback on it, so=20
either it is not being used much, or it works perfectly. Agreed that to=20
know for sure it needs to be released to the mainstream in 2.6. After we=20
have enough real users we can consider upstreaming the Linux kernel patches.

---

Talked about the CRL extractor script:

<https://patchwork.openvpn.net/patch/1502/>

Agreed to merge this. Noted that we could have a "openvpn-contrib" repo=20
for this kind of things, but did not move forward with the idea. Also=20
noted that "contrib" directory in openvpn repo is fairly unmaintained.

---

Talked about compat mode introduced by plaisthos:

<https://github.com/schwabe/openvpn/commit/0a71694af10cebac5b7f9bbc80f618e8=
ab355811#diff-6d82adaf397d76307d31a148a32699fe031eba9f56516223ee23a0d19ecf1=
ad0>

Basically it allows more easily configuring default options OpenVPN to=20
be compatible with old OpenVPN versions. This allows changing the=20
defaults without affecting users too much. Agreed that it would make=20
sense to make this compat-mode feature client-only.

---

Mattock is figuring out the technical details regarding GitHub + HCK-CI=20
with the Daynix guys.

---

Mattock now has dockerized buildbot + two workers that are actually to=20
build openvpn2 correctly. This is all in Vagrant for now. The main=20
challenge is keeping the configuration clean given all special builders=20
and build parameters we have.

Noted that the two buildbot setups can co-exist peacefully so there's no=20
particular hurry in migrating the buildslaves.

---

Full chatlog attached

--------------A3D75748C0FA65484E15704B
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2021-05-05.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2021-05-05.txt"

(14:48:03) plaisthos: I am probably semi-afk in the meeting since I have =
another meeting in parallel :/
(14:57:58) ***ordex waves fist
(14:58:33) mattock: hello
(14:58:39) cron2: who schedules such!
(14:59:02) mattock: I blame the ukrainians as the americans are sleeping
(15:01:31) lev__: Hello
(15:02:11) dazo: hey
(15:02:35) d12fk: howdy
(15:02:46) cron2: I think corp meetings need to be refused unless they ha=
ve IPv6
(15:02:59) dazo: :-D
(15:03:06) ordex: agreed!!
(15:03:12) d12fk: or only held in black and white
(15:03:14) ordex: or they shuld be held only on ipv6-only servers
(15:03:18) ordex: *should
(15:03:29) cron2: we have a correct topic! and an agenda page!
(15:03:35) ***cron2 congratulates mattock :-)
(15:04:27) ordex: wooo
(15:04:35) ordex: "Topic set by ordex"
(15:04:39) ordex: :-P
(15:05:36) dazo: ordex++
(15:05:44) ordex: \o/
(15:06:07) ordex: so, anything for the sync up ?
(15:07:05) ***lev__ prepared ovpn-dco-win enabled client in the form of M=
SI installer
(15:07:06) ordex: I think for 2.5 not much has happened since the last me=
eting?
(15:07:25) cron2: yeah, that's easy.  Nothing on my plate.
(15:07:31) ordex: lev__: what is that based on? master + dco patches from=
 arne + ?
(15:07:55) mattock: topic is not my doing, but agenda pages are mostly
(15:07:56) cron2: well, there's this mbedtls patch where someone on the l=
ist requested 2.5 pull-up, but I haven't looked more closely yet (=3D if =
needed, I'll do, but I think the prerequisite patch isn't even in)
(15:08:36) ordex: mbedtls patch ?
(15:09:00) lev__: Now working on arm64 support. So far I managed to produ=
ce MSI which runs on arm64, but installation fails because my customactio=
ns.dll runs on .net framework which is not available for arm64, so I am r=
ewriting it to C++ (should=E2=80=99t be a big task)
(15:09:31) lev__: Based on Arne=E2=80=98a DCO branch
(15:09:48) cron2: ordex: https://www.mail-archive.com/openvpn-devel@...1697...=
=2Esourceforge.net/msg22178.html
(15:09:50) vpnHelper: Title: Re: [Openvpn-devel] [PATCH applied] Re: Fix =
build with mbedtls w/o SSL renegotiation support (at www.mail-archive.com=
)
(15:09:59) cron2: lev__: cool
(15:10:18) ordex: lev__: oky
(15:10:56) ordex: cron2: yeah, that makes sense
(15:11:04) mattock: lev: there's the risk that Microsoft will get off the=
 hook if you do all the work (their App Assurance team was about to parti=
cipate in the arm64 work, but we have not heard back from them in several=
 weeks)
(15:11:10) ordex: any objection to merging it to 2.5?
(15:11:11) lev__: There is =E2=80=9C.net core=E2=80=9D which runs on arm6=
4, but it is not supported by Wix CustomActions framework, unlike =E2=80=9C=
=2Enet framework=E2=80=9D
(15:11:30) mattock: .net core is the cross-platform framework
(15:11:35) cron2: ordex: if it is needed, I'll merge.  If "the patch that=
 breaks stuff" is not in, I'll not merge.  Haven't looked more closely ye=
t.
(15:11:59) cron2: I just wanted to say "this is the only thing on my 2.5 =
agenda today"
(15:12:58) lev__: mattock: we can send a bill to MSFT when the work is do=
ne
(15:13:06) cron2: can you?
(15:13:32) ordex: [cron2: yeah, the offending patch was merged to 2.5 too=
]
(15:13:52) mattock: lev: I think you should send it so you get the money =
directly
(15:13:53) mattock: :D
(15:14:12) ordex: for 2.6 I am working on the few remaining patches from =
Arne - they touch the TLS state machine so further digging is required, h=
ence more time to stamp with ACK
(15:14:13) lev__: Sure, anyone can. Doesn=E2=80=99t mean they=E2=80=99ll =
pay, though.
(15:14:29) cron2: ordex: okay, thanks for looking (did I mention I find m=
bedTLS' approach to conditional features silly?  Why couldn't they just k=
eep the API call, and return "ERROR!" for anything that is not "turn it o=
ff"?)
(15:15:00) ordex: agreed - the approach you state is the one I normally g=
o with - so the ifdefs are all hidden
(15:15:24) ordex: anyway, we can't change that (yet)
(15:15:38) cron2: re 2.6: the rest of the "pending authentication" patchs=
et (1577, 1604, 1585) is on my plate
(15:16:47) ordex: cool
(15:17:02) ordex: anything else for 2.5/2.6 ?
(15:18:05) cron2: not from my side
(15:18:17) ordex: it seems nobody has anything else for this point :)
(15:18:24) mattock: yep
(15:18:26) ordex: #2
(15:18:27) mattock: ipv6 =3D no
(15:18:30) ordex: IPv6 to community
(15:18:34) cron2: I'm a bit curious on DCO for Linux - it has been quiet =
for a while now.  Is someone using it for real?  Did you get test results=
?
(15:18:43) ordex: cron2: no
(15:18:52) ordex: somebody may be using it with the ovpn3-linux client
(15:18:57) ordex: but we haven't heard much
(15:19:03) mattock: either it works perfectly or nobody is using it
(15:19:07) ordex: :D
(15:19:25) cron2: or it didn't work because someone couldn't figure out t=
he options and tried wg instead...
(15:19:26) ordex: i believe it will be adopted more once we get it into o=
vpn2
(15:20:02) mattock: the bugs will be found when it becomes mainline
(15:20:03) ordex: dazo: did you manage to get any insight on the progress=
 of the net->.com move yesterday evening? (if it was you joining that mee=
ting)
(15:20:04) mattock: 2.6
(15:20:11) ordex: yeah, think so too
(15:20:18) ordex: this is why we have to push 2.6 forward
(15:20:28) cron2: doing my part :)
(15:20:44) ordex: at that point it will also be used on servers
(15:20:46) mattock: how is the upstream kernel-side of DCO moving along? =

(15:21:15) ordex: it is a requirement that we get dco tested before even =
thinking to send it upstream
(15:21:26) ordex: so it's all a dependency chain
(15:21:29) dazo: ordex: that meeting was not happening due to the Ukraini=
ans having a public holiday
(15:21:42) ordex: ovpn2 -> test -> bugfix -> start upstreaming approach
(15:21:52) mattock: ok
(15:22:03) mattock: makes sense
(15:22:06) ordex: sending upstream something that currently nobody uses i=
s pointless hehe
(15:22:15) ordex: it makes us weak too
(15:22:18) cron2: ordex: but didn't you test it?  "it compiles, all good,=
 ship it" :-)
(15:22:21) ordex: so better grow some userbase first
(15:22:31) ordex: cron2: not sure that's enough of an argument :)
(15:23:06) ordex: dazo: oh ok
(15:23:18) ordex: we move to #3?
(15:23:30) mattock: 01
(15:23:32) mattock: oops
(15:23:33) mattock: +1
(15:24:13) ordex: ok, this patch was sent by David long time ago
(15:24:26) ordex: plaisthos: first acked then he raised some valid concer=
ns
(15:24:33) cron2: yeah, it got an ACK first, and then a "maybe not ACK"
(15:24:35) ordex: but then the patch was forgotten
(15:24:37) ordex: yeah
(15:24:52) ordex: after reading the whole thing I proposed an "automatic =
approach": https://patchwork.openvpn.net/patch/1297/#3422
(15:24:53) vpnHelper: Title: [Openvpn-devel] Remove --no-replay - Patchwo=
rk (at patchwork.openvpn.net)
(15:24:54) cron2: but if plaisthos is not here, #3 and #5 should be postp=
oned to next week... it is not really urgent
(15:25:03) ordex: right
(15:25:10) ordex: and I think he is not here at the moment
(15:26:09) ordex: my opinion about #4 is that "the CRL is *not* reloaded =
upon each client connection"
(15:26:18) ordex: only if it was modified since the last reload
(15:27:00) ordex: but the patch seems interesting, no?
(15:27:10) ordex: but why merging such tool in the core repo?
(15:27:30) ordex: isn't it better maintained outside?
(15:27:42) cron2: well, the CRL is reloaded if it as modified, and if he =
has like 10000 entries in the CRL, and it changes often...
(15:28:10) ordex: yeah, may introduce some lag
(15:28:16) cron2: we do have the crl-directory feature, and that would he=
lp other users to use it more easily...
(15:28:22) ordex: indeed the "dir" approach exists and this is a good use=
 case
(15:28:37) d12fk: basically he states that --ca-dir is the solution, and =
it's there already
(15:28:50) d12fk: wonder why we need python for that though
(15:29:01) d12fk: little shell and openssl should suffice
(15:29:06) cron2: people seem to think it's a viable programming language=

(15:29:13) ordex: not --ca-dir but --crl-verify 'dir'
(15:29:40) ordex: but the question is: why do we need to merge it in our =
repo? it could be freely available as an external tool, no? (that we can =
recommend, like easyrsa)
(15:29:43) d12fk: think --ca-dir also does drls if they are there
(15:29:57) d12fk: they have a .1 suffix, cas .0 iirc
(15:30:04) ordex: ah ok
(15:30:21) d12fk: if its somehwere noone will find it
(15:30:52) cron2: ordex: well, the thing is "so people can find it".  If =
we think it's useful, it should be somewhere that does not go stale
(15:31:02) d12fk: i think openss has a script for generating the hashes f=
rom the .pem files already
(15:31:08) d12fk: *openssl
(15:31:14) cron2: (we could put it on a sample script section in trac...)=

(15:31:22) cron2: or just point to d12fk's script instead :)
(15:31:22) ***d12fk is searching
(15:31:32) ordex: hash? you mean the serial?
(15:32:01) dazo: ordex: it's targeted for contrib/ ... where we have simi=
lar scripts too
(15:32:19) ordex: hm I see
(15:32:23) ordex: are they maintained at all?
(15:32:25) cron2: I would put it in contrib/, provided it works :-) - bec=
ause it is useful.
(15:32:32) cron2: contrib/ is semi-unmaintained.
(15:35:23) ordex: in any case, with openssl you can print the serial of t=
he revoked certificates (in a longer output), grep for the right thing, t=
rim and touch files accordingly
(15:36:10) cron2: which is what this script does - so "someone builds a s=
cript, in a language of their choice, and we either put it into contrib/ =
or not", no?
(15:36:37) ordex: ah actually the python script is also calling the opens=
sl binary xD
(15:36:46) mattock: another question might be: should we have a "contrib"=
 repo separately
(15:36:47) ordex: yeah
(15:37:02) mattock: with lower barrier to entry than the main project
(15:37:04) ordex: "yeah" to cron2
(15:37:20) mattock: generally splitting things off has been beneficial (o=
penvpn-build, openvpn-gui, etc)
(15:37:21) d12fk: $ man c_rehash
(15:37:25) cron2: mattock: I think we've been there before, but I can't r=
emember what we thought, then
(15:37:26) d12fk: that's what I meant
(15:37:36) cron2: No manual entry for c_rehash
(15:37:51) d12fk: it should come with openssl
(15:37:59) d12fk: it should come with openssl
(15:38:03) ordex: I do have the manpage, but it talks about hashes, not s=
erial numbers, no?
(15:38:04) cron2: yeah, linux has the manpage for c_rehash, FreeBSD does =
not
(15:38:18) d12fk: yeah those are needed for the ca-dir feature
(15:38:25) mattock: cron2: re: being there earlier: you're probably right=

(15:38:56) d12fk: not aware if crl dir is a ossl feature or added by ovpn=

(15:39:07) d12fk: maybe noone was aware of the .1 files
(15:39:19) dazo: d12fk: sure?  I think that's a openvpn specific behaviou=
r, not using the hash approach normally expected
(15:39:29) cron2: d12fk: openvpn
(15:39:37) cron2: verify_check_crl_dir()
(15:39:44) cron2:     if (!openvpn_snprintf(fn, sizeof(fn), "%s%c%s", crl=
_dir, PATH_SEPARATOR, ser
(15:39:49) cron2:     fd =3D platform_open(fn, O_RDONLY, 0);
(15:39:52) cron2:         msg(D_HANDSHAKE, "VERIFY CRL: depth=3D%d, %s, s=
erial=3D%s is revoked",
(15:39:57) dazo: --capath uses hashes, though, iirc
(15:40:31) ordex: d12fk: the crl dir thing is a openvpn approach
(15:40:38) d12fk: yeah thatis what i am suggesting instead of the proprie=
tary approach
(15:41:00) d12fk: might make sense with more than on tls lib though
(15:41:10) d12fk: crls have a .r0 suffix
(15:41:17) d12fk: was almost right =3D)
(15:41:19) ordex: hehe
(15:41:37) ordex: d12fk: so you're suggesting to have one CRL per certifi=
cate ?
(15:41:48) ordex: with the name being the hash of that cert ?
(15:42:04) ordex: and then totally kill the crl dir approach?
(15:42:13) d12fk: i think that is what openssl supports out of the box
(15:42:35) d12fk: if there's a better reason for using something else i'm=
 fine
(15:42:52) d12fk: was not aware or the crl serial thing before today =3D)=

(15:43:23) plaisthos: so re
(15:43:36) d12fk: re plaisthos
(15:44:55) ordex: we haven't decided if we want to merge this though?
(15:44:55) ordex: :D
(15:45:05) ordex: we could merge it to contrib and be done with it
(15:45:07) plaisthos: cron2: I thinhk c_rehash and the hash.0 as filename=
 is normal OpenSSL stuff
(15:45:12) ordex: if we kill the feature, we also kill the script later o=
n
(15:45:19) dazo: I think that's reasonable
(15:45:30) cron2: which of the two? :)
(15:45:35) dazo: lets merge it, it is useful today ... it's not overly co=
mplicated
(15:45:58) dazo: I only see one patch, or did I miss anything?
(15:46:09) cron2: now that I actually checked the code inside OpenVPN on =
how crl-dir works, I find it fairly straightforward :-)
(15:46:17) cron2: (I assumed it's something magic in the SSL libraries...=
)
(15:46:33) cron2: dazo: yeah, only this patch, but since it is so old, I =
wanted to bump it up
(15:46:36) cron2: bump
(15:46:45) cron2: I can handle the rest :)
(15:47:04) ordex: so verdict is: merge
(15:47:05) ordex: ?
(15:47:09) cron2: yep
(15:47:13) ordex: ay
(15:47:55) ordex: we have 10 minutes left
(15:48:02) ordex: wanna talk about #3 or #5 ?
(15:48:04) dazo: right .... the python code is pretty much straight forwa=
rd ... you could question the implementation design (exec of openssl), in=
 which a pure shell approach would be more portable and just as elegant
(15:48:04) mattock: yes
(15:48:10) ordex: maybe #5 ?
(15:48:11) cron2: --no-replay?
(15:48:13) ordex: it is more urgent
(15:48:46) plaisthos: keeping --no-replay is important if we care about p=
eople who want openvpn with cipher none
(15:48:47) cron2: I'll leave that decision to plaisthos
(15:49:51) ordex: plaisthos: should we rather talk about #5 since we have=
 few minutes left?
(15:49:56) ordex: --no-reply can wait longer
(15:49:57) plaisthos: I personally don't think cipher none is important a=
nymore since the performance hit from AES-GCM is low
(15:50:20) plaisthos: for #5: https://github.com/schwabe/openvpn/commit/0=
a71694af10cebac5b7f9bbc80f618e8ab355811
(15:50:24) plaisthos: WIP commit for that
(15:50:57) plaisthos: reading changelog.rst and generic-options.rst shoul=
d be enough to get the idea what I am doing
(15:51:03) dazo: I can understand the usefulness of running openvpn with =
--cipher none for debugging and testing .... but if you use it because yo=
u really want a plain text tunnel, there are better approaches.  If you w=
ant to ensure data is not modified in transit, enforcing encryption is no=
t the worst thing.
(15:51:07) ordex: plaisthos: we should explain what is the decision thoug=
h ?
(15:51:24) plaisthos: For #5?
(15:51:28) ordex: yeah
(15:52:31) plaisthos: so basically DCO enabled/ready by default and by do=
ing upgrades without changing configs is a desirable goal
(15:52:48) plaisthos: however it conflicts with being backwards compatibl=
e with 2.3 out of out of box
(15:53:00) ordex: yap
(15:53:15) plaisthos: Also rasing TLS minimum version to TLS 1.2 conflict=
s with <=3D 2.3.7 out of the box
(15:54:05) plaisthos: so the idea behind compat-mode is that we get new b=
etter default and users cna then add compat-mode 2.3.0 to get an easy way=
 to work with old peers
(15:54:24) dazo: Also consider that we have only committed to git-tree on=
ly support until June 2021 for the release/2.3 branch
(15:54:40) plaisthos: We might also make that feature client mode only, f=
orcing server admins to spend a bit more effort
(15:55:49) cron2: client-only sounds like a good idea
(15:56:00) cron2: sometimes you just need to talk to something broken, as=
 a client
(15:56:36) dazo: but at some point, you need to draw a line too
(15:57:02) dazo: that's what we've done with supported windows versions a=
s well as various linux distributions
(15:58:14) plaisthos: dazo: the line is simple
(15:58:29) plaisthos: compat-mode only sets defaults on features we still=
 support anyway
(15:58:34) plaisthos: it is only best effort
(15:59:02) plaisthos: e.g. it does bring back support for compeltely remo=
ve features like no-iv (or maybe later no-replay)
(15:59:12) ordex: it does *not*
(15:59:29) plaisthos: yeah, sorry, it does not
(15:59:30) cron2: I understand "compat-mode" to be, basically, a macro fo=
r "set this, this and this option to $oldvalue, because we have now chang=
ed the default away to $newvalue"
(15:59:41) plaisthos: cron2: yes
(15:59:44) ordex: yeah
(16:00:05) cron2: this can be documented in a fairly straightforward way
(16:00:08) cron2: compat-mode 2.3.0
(16:00:12) cron2:   - tls-version-min 1.0
(16:00:16) cron2:  - cipher BF-CBC
(16:00:23) cron2:  - topology net30
(16:00:30) plaisthos: I didn't readd cipher BF-CBC :)
(16:00:34) cron2: (maybe not, but "some other stupid option")
(16:00:36) plaisthos: since 2.5 already blocks that
(16:00:59) plaisthos: cron2: did you already look at this bit? https://gi=
thub.com/schwabe/openvpn/commit/0a71694af10cebac5b7f9bbc80f618e8ab355811#=
diff-6d82adaf397d76307d31a148a32699fe031eba9f56516223ee23a0d19ecf1ad0
(16:01:04) cron2: nah
(16:01:05) plaisthos: the manpage that tries that
(16:01:16) plaisthos: what you just described
(16:01:27) cron2: yes
(16:01:36) cron2: now I looked :-)
(16:01:58) plaisthos: and if there is any other default we should probabl=
y bring in 2.6.0 I am all ears
(16:01:59) cron2: I find this a fairly low-impact way to go for more mode=
rn defaults
(16:02:09) cron2: topology subnet
(16:02:17) cron2: --nopull if --client
(16:02:20) cron2: nobind
(16:02:32) cron2: (but topology subnet is server side)
(16:02:38) plaisthos: I considering doing --nobind as default when ...(an=
d now you were faster)
(16:02:58) ordex: hehe
(16:03:22) ordex: anyway, I guess we will see this patch landing and more=
 comments will go to the mailing list. but overall seems a sensible appro=
ach
(16:03:34) cron2: invdivdiual
(16:03:35) ordex: at least to get out of the stale situation we are in
(16:03:36) plaisthos: have to think a bit about topology subset since it =
might break configs
(16:03:43) cron2: the spelling dragon does not like this
(16:03:48) ordex: !!
(16:03:50) ordex: subset !
(16:03:52) cron2: topology net30 -> subnet
(16:03:58) cron2: *will* break configs
(16:04:13) cron2: but sticking to net30 for new deployments is just silly=
 (and was, for the last 10 years)
(16:04:19) plaisthos: and the other settings only break your configs if y=
ou have wacky configs/really old server/lcients
(16:04:53) ordex: dazo: are you fine with moving forward this way? then w=
e rant more on the mailing list for the details?
(16:07:59) mattock: I hope so :)
(16:08:05) dazo: yeah
(16:08:05) ordex: gone with the wind
(16:08:06) ordex: :D
(16:08:08) mattock: we'd had several discussions about this already :D
(16:08:09) ordex: ah!
(16:08:36) ordex: well, nobody will forget !
(16:08:40) dazo: I've raised my points enough times, I believe ... no nee=
d to beat a dead horse more than needed :-P
(16:08:55) mattock: :P
(16:09:51) mattock: I can give a really quick update: moving forward with=
 HCK-CI (technical details), have dockerized buildbot + two builders that=
 actually build openvpn2 correctly
(16:09:52) plaisthos: dazo: drop 2.3 support in openvpn3-linux and we are=
 talking!
(16:10:24) mattock: main challenge in buildbot is keeping the code reason=
ably neat with all the special cases for various platforms, different bui=
lder types, etc
(16:10:26) dazo: I don't care about 2.3 support in openvpn3-linux ;-)
(16:10:35) dazo: not after June 2021 at least :-D
(16:10:55) mattock: kill support in July :)
(16:10:55) plaisthos: dazo: then you should seriously considering, settin=
g TLS 1.2 as default minimum TLS version
(16:11:17) plaisthos: dazo: we should probably do that as default for ope=
nvpn3 in general
(16:11:23) dazo: plaisthos: make that the default in Core lib and you get=
 it for free ;-)
(16:11:34) plaisthos: the connect apps have their "select tls version any=
way"
(16:11:38) dazo: yepp
(16:11:44) plaisthos: dazo: as AS person I don't care ;P
(16:12:12) ordex: you are also a core person !
(16:12:13) ordex: :D
(16:12:19) ordex: ascore !
(16:12:24) ordex: I guess the meeting can end here ?
(16:12:32) ordex: enough dead horses on the street
(16:12:35) plaisthos: that breaks <=3D 2.3.7 by default on new installati=
ons by adding tls-version-min 1.2 in both client and server configs :]
(16:15:30) d12fk: signing out, need to help with exam prep
(16:15:58) cron2: mattock: so, when do you estimate we can move my buildb=
ots to python3?
(16:18:00) mattock: cron2: this will take a while, but anything between 2=
-4 weeks
(16:18:32) mattock: I'm writing the summary now, so I say "end this meeti=
ng" (officially)
(16:19:06) mattock: well, I also need to build the official buildbot setu=
p, this is all in Vagrant now
(16:19:33) mattock: but the two setups can co-exist peacefully
(16:19:37) mattock: so no hurry in that sense

--------------A3D75748C0FA65484E15704B--

