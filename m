From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <0118782c-d5eb-485d-eee6-73dfa7e6399b@...515...>
Message-ID: <e0e9c2fb-611b-221c-48d6-9dc6fe82c6fa@...515...>
Date: Thu, 5 Dec 2019 21:57:03 +0200
MIME-Version: 1.0
In-Reply-To: <0118782c-d5eb-485d-eee6-73dfa7e6399b@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IxzNn1xv5PojwWrMSPSX6GmzRIzJXAyEt"
Subject: [Openvpn-devel] Summary of the community meeting (5th December 2019)
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
--IxzNn1xv5PojwWrMSPSX6GmzRIzJXAyEt
Content-Type: multipart/mixed; boundary="FLS7CKVsJTaM9hWSZCo2St3v9DWNGn5Ow"

--FLS7CKVsJTaM9hWSZCo2St3v9DWNGn5Ow
Content-Type: multipart/mixed;
 boundary="------------E2B80E2D4DE7049504764B09"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------E2B80E2D4DE7049504764B09
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thursday 5th December 2019
Time: 20:00 CET (19:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-12-05>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock and Pippin participated in this meeting.

---

Lev now has access to the Windows 10 ARM64 laptop. Mattock will have to
do one more check to ensure that the VPN connection will remain alive at
all times.

---

Noted that HTTP to forums is broken. This may have something to do with
the forum upgrade by ecrist:

<https://forums.openvpn.net/viewtopic.php?f=3D20&t=3D29291>

---

Reviewed and updated OpenVPN 2.5 status:

<https://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn25>

No updates on the OpenVPN 2.5 MSI installer (since the hackathon). As
that starts to be the last remaining "must have" for the release we need
to start poking rozmansi now.

---

Discussed tomorrow's mini-hackathon. Cron2 will be able to join in the
afternoon. Mattock will take a stab at configuring the IRC bouncer
(finally).

--

Full chatlog attached

--------------E2B80E2D4DE7049504764B09
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-12-05.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-12-05.txt"

(21:00:50) mattock: hi
(21:02:51) dazo: Hey!
(21:04:58) mattock: anyone else?
(21:07:19) dazo: hmm
(21:08:01) cron2: ho
(21:09:31) mattock: hi!
(21:09:49) cron2: who broke http to forums.openvpn.net?
(21:09:54) mattock: https://www.mail-archive.com/openvpn-devel@...1439...=
ceforge.net/msg19196.html
(21:09:56) vpnHelper: Title: [Openvpn-devel] Summary of the community mee=
ting (27th November 2019) (at www.mail-archive.com)
(21:09:59) mattock: lollis
(21:10:02) mattock: sorry, wrong link
(21:10:08) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
9-12-05
(21:10:53) mattock: cron2: I did not know it even worked
(21:11:05) cron2: I have monitoring on it, so it worked until a few days =
ago
(21:11:30) cron2: if it has a v6 address, all services need to work.  Oth=
erwise user experience sucks if a poor user happens to have a v6-enabled =
client
(21:12:27) mattock: I have not touched forums in a long while
(21:12:50) cron2: I think ecrist did updates a few days ago, including a =
freebsd update... this might have caused firewall changes
(21:12:59) mattock: yeah, sounds likely
(21:13:21) Pippin_: Hi, see: https://forums.openvpn.net/viewtopic.php?f=3D=
20&t=3D29291
(21:13:33) vpnHelper: Title: Server Upgrades December 3, 2019 - OpenVPN S=
upport Forum (at forums.openvpn.net)
(21:13:48) cron2: takes me a while to get there... v6 is not working :)
(21:15:03) cron2: anyway, posted there, let's see :)
(21:16:28) mattock: so, what else shall we discuss today?
(21:16:46) mattock: arm64 "seems stable" and lev has access
(21:17:03) mattock: need to check one more thing to make sure it stays co=
nnected
(21:17:18) mattock: IRC bouncer is probably the next on my list
(21:17:40) mattock: I fixed an email delivery issue to gmail from trac, r=
elated to urlwatch
(21:17:54) mattock: internal PR is pending
(21:21:37) cron2: nice
(21:21:46) mattock: anything anyone else wants to bring up?
(21:21:50) mattock: tomorrow's mini-hackaton?
(21:22:02) cron2: I have no particulars, except "moar ACKs and speedier d=
iscussions needed"
(21:22:17) cron2: my TODO list has argv and ipv6-only
(21:22:31) dazo: Should we have a quick look at the status page?  https:/=
/community.openvpn.net/openvpn/wiki/StatusOfOpenvpn25
(21:22:32) vpnHelper: Title: StatusOfOpenvpn25 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:22:37) mattock: yes we probably should
(21:22:40) cron2: but I've been down with flu (or a bad cold) the last we=
ek so I didn't get much done :(
(21:23:17) dazo: I know ordex has been discussing ipv6only testing with k=
rzee internally ... krzee will help out testing and provide test env
(21:23:42) cron2: nie
(21:23:44) cron2: c
(21:25:51) dazo: The "=E2=80=8Bauth-gen-token: Inform client why auth-tok=
en was rejected" is replaced with plaisthos patches which should already =
be merged (the auth-gen-token patches we fiddled with for some time)
(21:26:18) dazo: struct argv overhaul is still in review .... can move th=
e responsibility for that one over to me
(21:26:42) dazo: (well, plaisthos volunteered to review it, but I'm follo=
wing up the development of these patches now)
(21:27:30) cron2: dazo: well, since you did the last round of fixes, some=
one else can now do the review&ack&merge
(21:27:37) dazo: yeah
(21:27:41) cron2: has been sitting around too long, starts annoying me :)=

(21:28:04) cron2: dazo: was the 2fa patchset fully ACKed?
(21:28:33) dazo: Need to double check the status of that=20
(21:28:38) cron2: patchwork says "no ACK received on v2 of the patch set"=

(21:29:14) cron2: on v1, only one ACK on 3/5 ("implement support for sign=
alling IV_SSO")
(21:30:43) dazo: I dunno if there's been an updated set of patches sent t=
o the ML ... I proposed to plaisthos to push out his stuff for review in =
a git branch, and we'll take it quickly that way ... so the ML patches wi=
ll just be a formality
(21:31:29) cron2: well, what we have on the ML was sent Nov 09, and has n=
o ACKs... so if the patch set is all good now, please re-send and ACK, so=
 I know :-)
(21:31:41) cron2: https://patchwork.openvpn.net/project/openvpn2/list/?se=
ries=3D581
(21:31:43) vpnHelper: Title: OpenVPN 2 - Patchwork (at patchwork.openvpn.=
net)
(21:34:00) dazo: ahh, so the subject line I was watching changed ... that=
's why it missed it
(21:34:12) dazo: subject line for the patch set
(21:34:23) cron2: yeah, it lost its "0 introduction" mail
(21:34:30) dazo: yeah
(21:34:44) dazo: alright, I'll spend some time looking at those tomorrow
(21:34:47) cron2: cool
(21:35:16) cron2: I will have to go to a customer tomorrow morning (a job=
 I started in March now needs finishing for real...)
(21:35:21) cron2: but I'll be around afternoon
(21:35:33) dazo: sounds good
(21:36:48) mattock: anything else?
(21:37:40) cron2: days are too short, and flu sucks
(21:37:57) dazo: got 2 kids with cold and fever here :/
(21:38:03) cron2: ewww
(21:38:08) ***cron2 sends over warm milk with honey
(21:38:17) dazo: thx! :)
(21:38:27) dazo: who will update the status page, btw?
(21:38:47) ***cron2 looks
(21:38:49) mattock: not me - I will focus on writing my elaborate meeting=
 summaries :D
(21:39:15) dazo: community manager chilling out :-P
(21:39:23) dazo: I can give it a stab
(21:39:27) cron2: so, how's the MSI installers coming along? :)
(21:39:40) mattock: cron2: asking me?
(21:39:58) ***cron2 looks for anyone else to ask who works on installers =
:))
(21:40:12) mattock: I don't see rozmansi here :)
(21:40:19) mattock: I have not heard of any updates
(21:40:48) mattock: I'll keep my fingers of MSI as far as possible, until=
 time to actually build them is here
(21:40:50) cron2: what was our release plan?  April 1?
(21:40:57) mattock: around that time I believe
(21:40:58) dazo: something like that
(21:43:10) cron2: minor update done
(21:43:47) mattock: thanks!
(21:43:54) dazo: I think we aimed at having all coding done by mid/end of=
 January? So the beta releases can start rolling out ... or did I confuse=
 it?
(21:44:39) cron2: not sure we agreed on a schedule for "how many betas in=
 which time scale", but yes, coding done end of January sounds like a ten=
tative goal to miss :)
(21:45:01) mattock: :)
(21:45:34) dazo: hehe
(21:46:56) mattock: so the MSI installers are starting to be last "must h=
ave" that is not yet being reviewed
(21:47:25) mattock: and I believe we decided that it would be ok to run t=
he tap-windows6 NSI installer from within the OpenVPN 2.5 MSI=20
(21:47:51) mattock: because support for driver installation in WiX toolse=
t was retarded
(21:48:01) mattock: or was it upgrading the driver, can't recall exactly
(21:48:12) mattock: we need to start poking @rozmansi :D
(21:48:16) cron2: yes :)
(21:50:30) mattock: are we good, or is there something else to bring up?
(21:50:36) cron2: I'm fine
(21:50:52) mattock: I will take a stab at the IRC bouncer thing
(21:51:02) mattock: that shall be my personal mini-hackathon
(21:51:03) mattock: tomorrow
(21:51:26) cron2: :)
(21:51:47) dazo: cool! looking fwd to that mattock1! :)
(21:52:18) mattock: yep!
(21:52:23) mattock: so, we'll meet again tomorrow!
(21:52:51) cron2: when shall we three meet again...
(21:52:57) cron2: ... in thunder, lightning, or in rain...
(21:53:17) mattock: I'm sure that is a quote from a song

--------------E2B80E2D4DE7049504764B09--

--FLS7CKVsJTaM9hWSZCo2St3v9DWNGn5Ow--

--IxzNn1xv5PojwWrMSPSX6GmzRIzJXAyEt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl3pYQ8ACgkQKVhNn0CG
RXg7eQgAltQAM1fCqtxQiS7S93D2jx1JHCDMZRuYnXof8kfKAkUbkEflUeg3dsgG
I8WMP3l1tTvb7uJLK1/ktM5Z/thB2xHHQ1jetFCsXu9oB0jM3ingpmzBQ81hL57z
qSPBKfotoFuO6hCkEkLrjph2lY8ELtjAdX20F34fcCcSMKjHGSB1YY5qnitZ3g/M
sSZz0Nk4lf4OOFfct/7f8RLR0SC46yWDY4m8JbMebgKQKoyp18rHp8qW6H78vqgs
dzrysTPWJMfGhiZYGLSLLd3EWW7BPA5ehYAhU7vE4AD1KSVQviQqbi6N6/9DRnCc
AJn3rid4GhJH4qHuJ8PRhTK9iY8bTw==
=5AA5
-----END PGP SIGNATURE-----

--IxzNn1xv5PojwWrMSPSX6GmzRIzJXAyEt--

