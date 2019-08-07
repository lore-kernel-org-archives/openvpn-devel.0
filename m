From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <596f0202-4908-6657-373e-ce6b7346b8e5@...515...>
Message-ID: <fe6d1190-50d4-ef2c-db4c-6e20678f70c8@...515...>
Date: Wed, 7 Aug 2019 13:57:00 +0300
MIME-Version: 1.0
In-Reply-To: <596f0202-4908-6657-373e-ce6b7346b8e5@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VUB49QdjFdionlmCVKYZhCjxW60yJtegJ"
Subject: [Openvpn-devel] Summary of the community meeting (7th August 2019)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VUB49QdjFdionlmCVKYZhCjxW60yJtegJ
Content-Type: multipart/mixed; boundary="okAUMxlPd4VGoz919x6N2WO4mi1gahpc4";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <fe6d1190-50d4-ef2c-db4c-6e20678f70c8@...515...>
Subject: Summary of the community meeting (7th August 2019)
References: <596f0202-4908-6657-373e-ce6b7346b8e5@...515...>
In-Reply-To: <596f0202-4908-6657-373e-ce6b7346b8e5@...515...>

--okAUMxlPd4VGoz919x6N2WO4mi1gahpc4
Content-Type: multipart/mixed;
 boundary="------------70D0EFF2EC74AC44F87ED6D0"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------70D0EFF2EC74AC44F87ED6D0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 7th August 2019
Time: 11:30 CEST (12:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-08-07>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, lev, mattock, ordex, plaisthos and rozmansi participated in
this meeting.

---

Talked about some buildslave failures. Ubuntu 14.04 failure was due to
too old cmocka, which was removed, and the build is fine now. Ubuntu
16.04 fails because it tries to connect to the OpenVPN server using IPv6
transport and there's no IPv6 connectivity in its network. Mattock will
try to fix this soon. Some of tincantech's buildslaves are failing as well.

--

Gave https://github.com/OpenVPN/tap-windows6/pull/94 the final approval
and merged it. It will make it to the HLK tests.

--

Talked about progress on various patchsets. There are SITNL cleanup
patches on the list which cron2 intends to work on "soon". Ordex has
been cleaning up the VLAN patchset to make it easier to review.
Plaisthos is rebasing the async-connect patches.

Plaisthos found a corner-case with empty username in "write
auth-token-gen to be based on HMAC ..." patch (4/7) and is fixing it.

--

Discussed the still failing E2EPerf HLK test. Rozmansi was able to make
the test pass in a virtualized environment which points to some local
problem in mattock's HLK lab. It is likely that (test/message) traffic
gets redirected to a wrong interface which makes the test fail. Mattock
will check things such as:

- Routes
- Default routes
- Routing metrics
- Per-interface DNS settings

Rozmansi will send the logs for his successful E2EPerf run, plus related
interface, routing, etc. data to mattock. This should help mattock
resolve this final test problem.

--

Full chatlog attached.

--------------70D0EFF2EC74AC44F87ED6D0
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-08-07.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-08-07.txt"

(12:29:57) L'argomento di #openvpn-meeting =C3=A8: Next meeting 4/July/20=
19 at 20:00 CEST.  Agenda at https://community.openvpn.net/openvpn/wiki/T=
opics-2019-06-26
(12:29:57) L'argomento per #openvpn-meeting =C3=A8 stato impostato da daz=
o!~freenode@...1423.../corp/developer/dazo a 12:33:36 su 26/06/2019
(12:30:03) mattock: good day folks
(12:30:11) lev__: hello
(12:32:00) rozmansi [sid334387@...2315.../web/irccloud.com/x-fozktbjitwtidmp=
a] =C3=A8 entrato nella stanza.
(12:32:05) rozmansi: hi
(12:33:22) mattock: anyone else present?
(12:33:31) ordex: yup
(12:33:36) mattock: hi ordex!
(12:33:38) lev__: btw rozmansi I just made ring buffers work with shared =
memory=20
(12:33:39) ordex: cron2 was around too I think
(12:33:41) ordex: hi!
(12:33:46) ordex: dazo won't make it apparently
(12:33:49) ordex: plaisthos: here ?
(12:34:05) rozmansi: lev__: excellent! any performance benchmarks yet?
(12:34:06) lev__: rozmansi: so far for ovpn3
(12:35:12) ordex: mattock1: how was your vacation? :)
(12:35:26) rozmansi: lev__: you did notice that spin-loops were redesigne=
d in our client? The old 50ms one incurred significant CPU/battery hit.
(12:35:55) lev__: rozmansi: I tried once with my early implementation and=
 got about the same results as before, but I don't blame ring buffers sin=
ce the bottleneck could be in our (proprietary) backend
(12:36:28) lev__: rozmansi: ah, no. I still use spin-loop for 50ms and th=
en WaitForSingleObject
(12:36:53) cron2: ho
(12:37:04) mattock: ordex: I managed to avoid work quite well, which I li=
ke :D
(12:38:00) lev__: rozmansi: you mean this one? https://github.com/WireGua=
rd/wireguard-go/commit/b4010123f74470eeca0551a151dea3e7a7381bcc
(12:38:01) vpnHelper: Title: tun: windows: spin for only a millisecond/80=
 =C2=B7 WireGuard/wireguard-go@...2523... =C2=B7 GitHub (at github.com)
(12:38:12) ordex: mattock1: :D
(12:38:15) mattock: rozmansi: btw thanks for trying out e2eperf - I'm pre=
tty sure I'm having a local issue that makes this particular test confuse=
d=20
(12:38:43) mattock: ...more on that later
(12:38:50) rozmansi: lev__: yes.
(12:39:51) ordex: btw we have a number of builders complaining most of th=
e times we launch a test - any chance to fix those ?
(12:40:16) cron2: are the ubuntus still failiung on the v6 connects?
(12:40:18) ***dazo is here ... manage to rearrange a few things
(12:41:03) mattock: cron2: I have not done anything on them, except maybe=
 disable the v6 tests to reduce spam (can't recall)
(12:41:25) cron2: mattock1: no, you haven't (=3D it's still spamming), bu=
t please reenable working v6
(12:41:56) ordex: I think we still have some cmocka failure
(12:42:00) ordex: at least one
(12:43:33) cron2: that is tincantech
(12:43:44) ordex: ubuntus have also 4a failing with : ./t_client.sh:  Ope=
nVPN did not initialize in a reasonable time
(12:43:54) ordex: at least the 16.04 instance
(12:43:59) mattock: let me check the situation
(12:44:31) ordex: builder-ubuntu-1404-amd64-stable-master--with-crypto-li=
brary=3Dmbedtls--enable-crypto << this one is failing on cmocka
(12:44:34) mattock: yeah, 16.04 is correct
(12:44:34) ordex: is this tincantech's ?
(12:44:39) mattock: no, it is mine
(12:44:44) ordex: ok
(12:44:52) mattock: let me try to fix 14.04 - "should be easy"(tm)
(12:45:10) ordex: it's complaining of some unknown types
(12:45:14) ordex: related to cmocka
(12:45:41) plaisthos: ordex: yes
(12:45:57) ordex: test.c:45:29: error: array type has incomplete element =
type const struct CMUnitTest tests[] =3D { << this is the actual error
(12:45:59) cron2: ordex: 4a is --proto udp6
(12:46:03) ordex: cron2: ah ok
(12:46:09) ordex: so related to what you were saying before
(12:46:11) ordex: okok
(12:46:53) cron2: ordex: tincantech's is the one that fails the dummy int=
erface test
(12:46:58) cron2: (this got me confused)
(12:47:11) ordex: yap, right
(12:47:35) ordex: for that one I don't know yet what is going wrong, but =
that can be checked last
(12:48:50) mattock: so, would this CMUnitTest thing on 14.04 be an issue =
in the tests, or in cmocka version?
(12:49:50) ordex: likely the latter
(12:50:00) ordex: because it works on newer ubuntus
(12:50:02) cron2: that smells like cmocka version... so possibly just rem=
oving libcmocka altogether might fix it (as in "we do not bothre")
(12:50:18) ordex: cron2: that would prevent running the unit tests, no ?
(12:50:32) ordex: but I guess we still run t_client.sh
(12:51:34) mattock: I'll get rid of cmocka then
(12:52:19) cron2: ordex: yes, it would only affect cmocka based tests
(12:52:33) ordex: ok
(12:52:46) ordex: sounds good
(12:55:21) mattock: gone for good
(12:55:55) mattock: triggered a rebuild on 14.04
(12:56:52) mattock: I'll check the logs on 16.04
(12:57:03) mattock: but that can happen outside of precious meeting time
(12:57:17) mattock: so, what have you guys done during my absence? :P
(12:58:29) cron2: we've been waiting for you :-)
(12:58:43) rozmansi: :)
(12:58:49) cron2: but besides this, we've been waiting for dazo
(12:59:02) rozmansi: I did this: https://github.com/OpenVPN/tap-windows6/=
pull/94
(12:59:02) rozmansi: any chance to get it merged before WHLK?
(12:59:03) cron2: and patch respins from plaisthos
(12:59:04) vpnHelper: Title: Remove NCF_HAS_UI flag from Characteristics =
by rozmansi =C2=B7 Pull Request #94 =C2=B7 OpenVPN/tap-windows6 =C2=B7 Gi=
tHub (at github.com)
(12:59:06) dazo: should I run? :-P
(12:59:16) cron2: dazo: hah! :-)
(12:59:41) mattock: rozmansi: no problem at my end, I've started from scr=
atch and will make E2EPerf test pass before I run any other tests
(12:59:55) mattock: so merging stuff is still quite doable
(13:00:00) cron2: rozmansi: it looks good to me, everyone else said "yeah=
, this looks reasonable"; so I'm fine.  I think mattock1 wanted to merge =
it anyway already
(13:00:11) mattock: I can do it now
(13:00:33) plaisthos: Yeah, I think I will do the new patches this week
(13:00:46) rozmansi: thanks. eduVPN project has a potential customer that=
 use HP Envy laptops exclusively and cannot use OpenVPN without this.
(13:01:14) mattock: done
(13:01:15) cron2: dang
(13:01:36) cron2: I was about to merge it and then write to the channel "=
no you can't, I've already merged it!" but logging in took too long
(13:01:43) cron2: I saw the button disappear :-)
(13:01:43) mattock: lol!: )
(13:02:02) cron2: anyway
(13:02:50) cron2: we have a bunch of SITNL cleanup patches on the list, t=
hat I intend to work on "soon".  ordex wants to move forward to other lar=
ger blocks - vlan, async-cc.
(13:02:58) cron2: syzzer reappeared and disappeared again
(13:03:08) cron2: that's about what happened :-)
(13:03:28) mattock: ok, so not that much :)
(13:03:32) cron2: oh, there's two ACKed patches in patchwork that I need =
to take care of
(13:03:44) cron2: iservice-for-tap-open and openssl 1.1 stuff
(13:08:08) ordex: :)
(13:08:36) ordex: the sitnl cleanup patches should just need a "light" re=
view - but you never know :D
(13:08:50) lev__: cron2 we need to wait with iservice patch, since latest=
 wintun changed security model and API and we no longer need to be privil=
eged to open device
(13:08:58) ordex: in background I started working on reorganizing the vla=
n patches so that they are easy to review/test/merge. MEanwhile I am witi=
ng for plaisthos to rebase his async-connect patches
(13:09:18) cron2: lev__: a-ha.  So I shall not merge the acked v6 then?
(13:09:29) plaisthos: ordex: hu?
(13:09:41) lev__: otoh, buffers registration should be done by privileged=
 process, but we do not have that yet in openvpn2
(13:09:42) plaisthos: do they need rebasing?
(13:09:57) lev__: yep, do not merge=20
(13:09:59) ordex: plaisthos: yes, this is what I Asked on #openvpn-devel =
yesterday, no? that message you said you have read :D
(13:10:04) plaisthos: ah
(13:10:13) ordex: [2115.46]<@ordex> plaisthos: when you've got a chance, =
could you please rebase your client-connect code on top of latest master =
and let me know the name of the brain I can pull from ?
(13:10:13) ordex: [2116.00]<@ordex> I'd like to move on with the review, =
but I also don't want to break your code by doing the rebase myself
(13:10:13) ordex: [2116.02]<@ordex> thanks !
(13:10:15) ordex: :D
(13:10:16) cron2: lev__: can you send a followup mail on the list to expl=
ain what I should do?  (So we have it on the list, otherwise it looks a b=
it funky "there is an ACK but no merge, why?  does cron2 not like lev__ a=
nymore?" :-) )
(13:10:25) plaisthos: should I also send them to list then?
(13:10:26) ordex: no rush - as I have other things to follow anyway
(13:10:26) cron2: ordex: there is no brains
(13:10:46) lev__: will do
(13:10:51) ordex: plaisthos: I don't think so for now - let me first see =
if I have comments on the actual code, unless rebasing changes the patche=
s a loot
(13:14:42) ordex: cron2: there never was one
(13:14:50) ordex: !!
(13:15:13) plaisthos: okay rebasing went with only a minimal conflict in =
one commit
(13:15:20) plaisthos: o github.com:schwabe/openvpn.git
(13:15:20) plaisthos:  + b19e26b7...9071028d deffered_client_connect_reba=
se -> deffered_client_connect_rebase (forced update)
(13:16:30) ordex: plaisthos: ok, so I use this branch: deffered_client_co=
nnect_rebase ?
(13:19:55) plaisthos: yeah
(13:20:36) cron2: plaisthos: you were working on a "take dazo's comment i=
nto account plus bugfix" of the "write auth-token-gen to be based on HMAC=
 ..." patch (4/7).  Any news on this?
(13:20:58) cron2: since dazo is back we can then push him to review and A=
CK :)
(13:21:09) plaisthos: found a corner case bug with empty username that I =
want to fix
(13:22:08) plaisthos: but I am confident to do that this week
(13:22:49) cron2: cool
(13:23:39) mattock: I have one question about Windows you guys might have=
 a clue about
(13:23:49) mattock: regarding the final failing HLK test - E2EPerf
(13:24:24) mattock: let me know if I may proceed without interrupting som=
ething else :)
(13:24:50) rozmansi: go ahead
(13:24:56) mattock: ok
(13:25:40) ***cron2 listens :)
(13:26:02) mattock: so, rozmansi was able to make E2EPerf pass in Virtual=
box, which means there's some local issue in my test setup that this part=
icular test triggers
(13:26:26) mattock: one option is that (some of the) traffic goes into th=
e wrong interface
(13:26:59) mattock: any ideas how such a thing could happen?
(13:28:02) mattock: rozmansi already suggested that maybe traffic gets re=
directed to the s.c. MessageDevice network (=3Dcommunication with HLK con=
troller) because that's faster (which it is)
(13:28:10) mattock: well actually
(13:29:06) rozmansi: one think I remembered later... mattock1, are you us=
ing tap or tun for tunnels?
(13:29:10) mattock: tap
(13:29:22) mattock: earlier (=3Din EC2) I was using tun
(13:29:22) rozmansi: ok, I did too, so this is not the case.
(13:29:54) mattock: I just recalled some routing metric discussions relat=
ed to Windows, which is why I asked
(13:30:18) rozmansi: as far as I understood the test network should be co=
mpletely isolated from message network
(13:30:53) mattock: and it actually is now - the HLK client and support m=
achine attached directly with a cable
(13:31:07) mattock: with statically configured interfaces
(13:31:12) mattock: and openvpn traffic goes on top of that
(13:31:14) rozmansi: oh, yes... Windows do have a service that monitors n=
etwork traffic and tries to adjust metrics to redirect traffic to faster =
route.
(13:32:10) mattock: so, if it thinks it can route traffic through to <a> =
through 10Gbps interface <n>, it will choose that over interface <m> whic=
h is only 1GBps, right?
(13:32:39) rozmansi: and openvpn and traffic channel have separate IP add=
ress space, right? And no packet forwarding anywhere, right?
(13:33:00) rozmansi: mattock1: right
(13:33:10) mattock: yes, that is the case, but I will have to double chec=
k those in case there are some odd defaults
(13:33:13) cron2: mattock1: windows should only do that if there are mult=
iple routes
(13:33:28) mattock: yeah, I will definitely need to start looking at metr=
ics and routes and all that
(13:33:30) cron2: (like, lan+wifi in the same 192.168.x segment, or two d=
efault routes)
(13:33:51) rozmansi: mattock1: I didn't set any routes in may openvpn set=
up. Just p2p.
(13:34:26) mattock: rozmansi: the openvpn config is as documented here: h=
ttps://community.openvpn.net/openvpn/wiki/HLKTesting
(13:34:27) vpnHelper: Title: HLKTesting =E2=80=93 OpenVPN Community (at c=
ommunity.openvpn.net)
(13:34:34) mattock: but anyways, I can move forward with this
(13:34:51) mattock: good to know the test _can_ pass and that this is pro=
bably a problem with packets going to a wrong place
(13:35:04) rozmansi: mattock1: I can send you my .conf files and describe=
 my setup again. I didn't even use separate NIC and cable/switch to deliv=
er VPN traffic.
(13:35:11) mattock: I did start looking at packet captures, but did not (=
yet) notice anything wonky
(13:35:23) rozmansi: mattock1: yes, this is definitely _not_ a driver iss=
ue.
(13:35:25) mattock: rozmansi: if you can also send the logs for your succ=
essful run that'd help
(13:35:54) mattock: plus whatever routing/interface info you can get (e.g=
=2E with powershell)=20
(13:36:06) mattock: DNS servers set for the interfaces, etc.
(13:36:28) mattock: anyways, is there anything else for today?
(13:36:32) mattock: we're 66 minutes in
(13:36:49) rozmansi: mattock1: sure, will fire up VPCs and send you every=
thing...
(13:37:08) mattock: thanks!
(13:39:30) mattock: oh, and mini-hackathon next Fri
(13:39:37) mattock: btw. yes, I will be joining Trento
(13:39:46) mattock: I'm trying to soften up $wife to join
(13:40:00) mattock: she'd like to go to Italy, but she claims it is cold =
in Trento in November
(13:40:19) mattock: :D
(13:40:37) ordex: :D
(13:40:44) ordex: witht he latest climate changes you never know !
(13:40:46) mattock: ordex: any comments on the temperature/humidity/rain?=

(13:40:53) ordex: but yes, "might" start getting colder by then
(13:41:09) mattock: daytime temperature being reasonable still I guess?
(13:41:16) mattock: 15+ celsius?
(13:41:26) rozmansi: mattock1: funny... my $wife wanted to go too. after =
trying to explain I will be on totally different planet in Trento, she di=
dn't took it so well. :(
(13:41:36) ordex: I'd say between 10 and 15 yes, but we better check the =
forecast :D
(13:41:43) ordex: it's gonna be my fiorst november here in a while
(13:41:45) mattock: ordex: ok
(13:41:56) ordex: rozmansi: :D
(13:41:59) mattock: rozmansi: yeah, that is a challenge
(13:42:15) mattock: my $wife can venture around by herself, plus she'd ha=
ve one week of vacation left
(13:42:31) mattock: I'd like to stick around for a bit longer anyways
(13:42:44) mattock: I'll report when I have convinced her, or failed doin=
g so :)
(13:43:11) mattock: ok writing summary, will send soon

--------------70D0EFF2EC74AC44F87ED6D0--

--okAUMxlPd4VGoz919x6N2WO4mi1gahpc4--

--VUB49QdjFdionlmCVKYZhCjxW60yJtegJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl1KrnwACgkQKVhNn0CG
RXhmUwgAsJVzRxI/sduF3kgtolH+Nrv3VYLsoUAbhpKnV3m1YrjlX2GT+0V9TurA
9gw9PP47EYDQfWZDVfnkkb322cKlSBK0y+wLASImN0Vf6wke6S/qa40AdUER1zRm
BI0h9PH83ga+NRRJWNZkcfKrFfdsm7SevYIb1Z5oBkhlsT6HIqR3UcHn+3faR6qX
BYsZtZcbPEgX5+mUauh8ixzL7pY6P7sIsSDYeXR5/TE+/8jmq4hZmXt+BFUQeIvk
IXvU8HUbHXGTGFcMEe6hvqSlyju2KHikwqsdlrBZEy9U1XEC+EwyGlaEHZFQPmcd
TYPN5p20D2Kwk+nKeBqNLM75tkT0rA==
=foFU
-----END PGP SIGNATURE-----

--VUB49QdjFdionlmCVKYZhCjxW60yJtegJ--

