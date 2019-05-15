From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <796722c6-e08b-6de4-67aa-6f2ecc21623e@...515...>
Message-ID: <3d54550a-aeb0-ac34-3fa0-fe7017d20fbd@...515...>
Date: Wed, 15 May 2019 13:34:50 +0300
MIME-Version: 1.0
In-Reply-To: <796722c6-e08b-6de4-67aa-6f2ecc21623e@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="02qtp8nfHV1oVHf0xYf7RNnMqPTYJdDkZ"
Subject: [Openvpn-devel] Summary of the community meeting (15th May 2019)
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
--02qtp8nfHV1oVHf0xYf7RNnMqPTYJdDkZ
Content-Type: multipart/mixed; boundary="Zdx6jxKzOwPRq1ATArBPm2IyQDe13L2hT";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <3d54550a-aeb0-ac34-3fa0-fe7017d20fbd@...515...>
Subject: Summary of the community meeting (15th May 2019)
References: <796722c6-e08b-6de4-67aa-6f2ecc21623e@...515...>
In-Reply-To: <796722c6-e08b-6de4-67aa-6f2ecc21623e@...515...>

--Zdx6jxKzOwPRq1ATArBPm2IyQDe13L2hT
Content-Type: multipart/mixed;
 boundary="------------0A9B17787AD141374B8FBB45"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------0A9B17787AD141374B8FBB45
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 15th May 2019
Time: 11:30 CEST (9:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-05-09>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

dazo, lev, mattock, ordex, plaisthos, rozmansi, syzzer and zx2c4
participated in this meeting.

--

Mattock gave a brief tap-windows6 HLK testing update. He's working on an
OpenVPN setup that HLK tests would be happy with. The simplistic version
proposed by cron2 did not work as-is.

--

Talked about the wintun driver. Lev managed to make it work on openvpn3
with a fairly small amount of work. It was agreed that integrating it
with openvpn2 makes sense.

--

Discussed the location of the next hackathon. Decided on Trento, Italy,
where ordex lives at the moment. Ordex will create a Doodle poll for the
hackathon. Other proposed alternatives were Delft, Netherlands and Oulu,
Finland.

--

Discussed the patches in patchwork. The sitnl patches have been ACKed
and cron2 wants to work them in tonight. Dazo is working on patches for
auth-token hmac from plaisthos.

--

Agreed that mini-hackathons will be organized on "Fridays after Thursday
meetings". Mattock will mention the mini-hackathons in the the monthly
meeting invitation emails.

--

Full chatlog attached.


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock




--------------0A9B17787AD141374B8FBB45
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-05-15.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-05-15.txt"

(12:41:43) mattock: back at my laptop finally
(12:42:05) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
9-05-15
(12:42:06) vpnHelper: Title: Topics-2019-05-15 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:43:06) dazo: so ... tap-windows6 update?
(12:43:07) mattock: so it seems we have the usual stuff only
(12:43:26) mattock: working on openvpn setup that HLK would be happy with=

(12:43:46) mattock: what gert proposed does not work as-is
(12:44:03) mattock: my original client-server setup worked fine for the m=
ost part
(12:44:13) mattock: but we don't need to discuss the gory details in this=
 meeting
(12:44:35) lev__: hello
(12:44:38) mattock: hi lev!
(12:44:56) plaisthos: I am here
(12:45:04) plaisthos: hey all
(12:45:13) mattock: so many people and cron2 said he'd be a tad late
(12:45:50) ordex: hey hey
(12:46:46) mattock: hi!
(12:46:53) mattock: we're breaking record numbers today :)
(12:47:00) mattock: now we'd just need to discuss something :)
(12:47:36) syzzer: do we have plans for the hackathon this year already?
(12:47:39) lev__: I have some news on Wintun
(12:47:45) syzzer: let's do that first
(12:48:06) lev__: So I was able to make openvpn3 work with wintun
(12:49:10) lev__: I had to do (a few) changes to openvpn3, but nothing dr=
astic. Also a small change to wintun to allow non-LocalSystem processes t=
o open device
(12:49:18) rozmansi: @lev__ nice... Any first impressions, thoughts?
(12:49:31) plaisthos: syzzer: there an idea floating around that we all i=
nvade ordex's place
(12:50:09) rozmansi: @lev__ ah yes, I have that patch for non-LocalSystem=
 for my testing too.
(12:50:30) dazo: rumours has it ordex won big time on a bitcoin bet, so h=
e bought a massive mansion up on the Italian alps ........
(12:51:10) lev__: I found a bug in wintun readme :) I didn't have time ye=
t to run proper performance tests, but with remote VPN server I got same =
performance of tap-windows6 and wintun. I plan to run it against VPN serv=
er in local network, preferably in AWS
(12:51:13) plaisthos: no that was syzzer collegue
(12:51:16) ordex: :D
(12:52:07) lev__: so maybe after testing and stabilising openvpn3, we cou=
ld add wintun support to openvpn2
(12:52:21) ordex: I am looking for options here - I have space in a cowor=
king space and they have meeting rooms
(12:52:28) ordex: with restaurants nearby and so on=20
(12:52:34) plaisthos: ordex also lives in a strange place where everyone =
is Italian but some people respond in Austrian if they detect your German=
 Accent
(12:54:47) syzzer: that sounds perfect
(12:54:48) mattock: +1 for wintun
(12:55:05) syzzer: both the wintun results, plans and the hackathon solut=
ion
(12:56:19) mattock: I don't mind invading italy, and germans already have=
 experience on it
(12:56:24) mattock: +1
(12:56:38) mattock: I'm referring to ~400AD
(12:56:50) dazo: :-P
(12:57:04) lev__: ah, old good times when we were young
(12:57:07) mattock: indeed
(12:57:19) mattock: when ships were of wood and men were of iron
(12:57:29) mattock: anyways
(12:57:32) syzzer: yeah, Italy sounds great. Otherwise I could also invit=
e you to Delft again
(12:57:46) syzzer: but let's keep that as a backup
(12:57:58) lev__: or we can meet in Oulu, Northern Finland
(12:58:14) mattock: I would not mind that either
(12:58:22) syzzer: lev__: sounds good to, just maybe in summer then?
(12:58:35) mattock: maybe in mid-winter when you can go skiing etc.
(12:58:42) dazo: +1 for summer time in Oulu :)
(12:58:44) mattock: summer is gree nwinter there
(12:58:46) lev__: yes, summer is definitely better here weather-wise
(12:58:46) plaisthos: mattock1: I like light
(12:59:15) syzzer: though skiing sounds good too
(12:59:31) ordex: :D so many options now hehe
(12:59:31) mattock: there's actually snow that far up north, unlike here =
- you never know
(12:59:39) mattock: is there snow there ordex?
(12:59:45) ordex: now yes
(12:59:48) ordex: even though it was not expected
(12:59:59) lev__: I wouldn't mind to visit Italy
(13:00:12) mattock: everybody seems to be in agreement about italy
(13:00:18) dazo: Italy, Delft, Oulu .... that's a nice line-up :)
(13:00:40) dazo: mattock1++
(13:00:52) mattock: it has been decided then
(13:00:53) syzzer: ordex: you in Trento, right?
(13:01:32) ordex: right
(13:01:34) dazo: But .... perhaps syzzer and lev__ could already consider=
 if they want to invite for next years hackathon ... so we can plan that =
a bit more earlier than last years ...
(13:01:38) lev__: rozmansi: do you have skype or something? I might have =
a few stupid questions about wintun
(13:01:49) dazo: lev__: appear.in!
(13:01:50) lev__: rozmansi: or shall I ask them on #wireguard
(13:02:04) zx2c4: lev__: ask them in #wireguard
(13:02:05) dazo: zx2c4 ^^^
(13:02:12) dazo: ahh, you were here :)
(13:03:11) zx2c4: lev__: [reading backlog] can you submit a patch for you=
r bug in the readme?
(13:04:18) zx2c4: lev__: alternatively, you can query me directly here on=
 IRC
(13:05:05) lev__: zx2c4: sure. That's about padding size calculation, "4+=
" seems to be unnecessary
(13:05:11) zx2c4: lev__: you dont need to change the ACL permissions to u=
se it as administrator
(13:06:19) zx2c4: lev__: that might be right...
(13:06:59) lev__: zx2c4: hm.. I'll double check. IIRC it didn't work when=
 I ran my app via remote debugger running as administrator
(13:11:34) zx2c4: lev__: confirmed the 4+ is required
(13:11:34) zx2c4: thanks
(13:11:36) zx2c4: fixing.
(13:13:28) zx2c4: lev__: pushed.
(13:13:38) mattock: open source at work
(13:13:45) mattock: shall we move on?
(13:14:09) dazo: yupp!
(13:15:32) mattock: so we have 2.5 and patchwork
(13:15:44) zx2c4: lev__: er, i meant *not* required. but you get the idea=

(13:15:44) mattock: any patches that would need coordination?
(13:15:46) ***cron2 is here!
(13:15:48) cron2: sorry
(13:16:07) mattock: np
(13:17:43) mattock: anything to add to the above cron2?
(13:18:41) cron2: what didnt work in the HLK setup I proposed?
(13:18:53) mattock: cron2: can we discuss that outside of the meeting on =
#openvpn-devel?
(13:18:57) mattock: it could take a while
(13:19:06) cron2: if you stop disconnecting every few minutes :-)
(13:19:16) mattock: I only disconnect several times a day :D
(13:19:17) cron2: otherwise, fine with me
(13:19:29) mattock: I know, the bouncer
(13:19:44) mattock: anything to discuss regarding 2.5 or patchwork patche=
s?
(13:19:44) cron2: anyway - 2.5 and patchwork
(13:19:59) cron2: I got all I need for sitnl now (-1 and 1..7 all ACKed),=
 want to work them in tonight
(13:20:44) cron2: last Friday's hackathon was semi-successful ("someone b=
esides me and mattock showed up!") - we can improve on this :-)
(13:20:51) dazo: nice!  I'm planning to get a chance to rewiew Arne's pat=
ches for the auth-token hmac stuff
(13:21:26) dazo: cron2: I was present ... but was "hidden" working on som=
e other patches for openvpn2 ... hope to have that ready too in not too f=
ar future
(13:21:44) cron2: good enough :)
(13:21:50) dazo: (the plug-in improvements Greg Cox provided ended up bei=
ng more work than initially expected)
(13:21:58) mattock: next hackathon friday next week, right? I'm not 100% =
sure we actually decided to follow the "Friday after Thursday meeting" sc=
hedule
(13:22:08) cron2: nobody objected
(13:22:12) mattock: ok
(13:22:19) mattock: it is official then
(13:22:32) mattock: easy to remember, and I'll add that to June's invitat=
ion email
(13:22:56) dazo: This Friday is a public holiday (constitution day) ... I=
'll be mostly unavailable on Friday, but will try to get some community w=
ork done today and tomorrow
(13:22:57) cron2: I'll be sitting in airports and plane for half the day =
(flight leaves at 12, arrives back home at 4, plus travel to/from airport=
 =3D 10 to 5:30)
(13:23:01) cron2: dazo: n ext friday
(13:23:09) cron2: "the one after thursday's meeting"
(13:23:31) cron2: but getting work done any other day is always welcome :=
-)
(13:23:53) cron2: (the "agree on a day" thing is mostly to help with revi=
ew/next version cycle delays)
(13:25:14) dazo: yeah
(13:26:44) mattock: 4 minutes left
(13:27:01) mattock: anything else to discuss?
(13:27:29) syzzer: who sends the hackathon doodle?
(13:28:09) syzzer: traditionally that's done by the host, *hint*
(13:28:14) mattock: :)
(13:28:30) mattock: indeed, because without the host organizing the hacka=
thon would be challenging
(13:28:38) mattock: ordex: this landed on your plate it seems :D
(13:29:06) ***cron2 has nothing else
(13:29:44) syzzer: good, time for lunch then :)
(13:29:44) ordex: lol sounds like it
(13:29:54) ordex: I will provide some more details later on
(13:30:02) plaisthos: syzzer: did you see my question if of not sending t=
he --auth digest for ncp in #openvpn-devel?
(13:30:17) plaisthos: shoudl we just assume both client and server always=
 have the same?
(13:31:37) mattock: ok official meeting over - people are leaving for lun=
ch already :)

--------------0A9B17787AD141374B8FBB45--

--Zdx6jxKzOwPRq1ATArBPm2IyQDe13L2hT--

--02qtp8nfHV1oVHf0xYf7RNnMqPTYJdDkZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlzb60oACgkQKVhNn0CG
RXiMLwf+KM0F+lJ2Rsh/sYT9QhKEZ6WMWDDhz6sDo2vXdQpqq2g4iG52WKMeAo63
0FDaviKmRwZUP3pE2c0g4O6x+PuqrbT889Y8hYoprOdEWlHjGRJpkxfWreYCduEF
BZZPCw+psU+W6+w5DBdOmZTAQ42XYk4KM2R3hCYpo0IrsYejTvLgS5N47VxQJx5g
ursmJ8QEQ5prhKFuscYetphdEJLaV6buGNfte37/1oXOg3vd0hvlPGdEsrgTxGMf
9jkmHhgnbSGijze86dtxUTcpZCQrzhSJue7YekTzbtbO/+YCZrAHuz5k7EE4v0b0
/8ROtWXTCg6J+AP5FlLx+dhz5yv1hw==
=penS
-----END PGP SIGNATURE-----

--02qtp8nfHV1oVHf0xYf7RNnMqPTYJdDkZ--

