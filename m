From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <de2ff642-df3f-c0a9-c6b0-10584555a4ac@...515...>
Message-ID: <d37bcb2f-6652-292b-9d1d-a5f3af76c359@...515...>
Date: Wed, 5 Feb 2020 14:41:43 +0200
MIME-Version: 1.0
In-Reply-To: <de2ff642-df3f-c0a9-c6b0-10584555a4ac@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QVKVcZewWeAr0O14L4SnSDEtWFD3eY1fD"
Subject: [Openvpn-devel] Summary of the community meeting (5th February 2020)
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
--QVKVcZewWeAr0O14L4SnSDEtWFD3eY1fD
Content-Type: multipart/mixed; boundary="gdSbugivWSDUR5MZZ2QnXJnZxAPgIhkFm"

--gdSbugivWSDUR5MZZ2QnXJnZxAPgIhkFm
Content-Type: multipart/mixed;
 boundary="------------D28EDD21AAAF7D1AC316993A"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------D28EDD21AAAF7D1AC316993A
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 5th February 2020
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-02-05>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, mattock and syzzer participated in this meeting.

---

Cron2 tried to do the argv patchset, but it needs a rebase + tun.c
adjustments from dazo.

---

Decided to start signing tags in tap-windows6 repository as suggested here:

<https://github.com/OpenVPN/tap-windows6/issues/101>

Mattock will use his personal key for signing.

Also noted that it might be a good idea to sign our personal GPG keys
with the security mailing list key.

---

Noted that OSTIF wants to do an audit of "changes between 2.4.0 and
2.5.0". They were fine with postponing the audit until 2.5.0 is ready -
the original tentative deadline for first 2.5 alpha - "end of January
2020" - was not met.

---

Decided to ask dazo, ordex and plaisthos what their suggestion is for
the new tentative deadline for first 2.5 alpha is. Much of the remaining
work depends on them.

Also noted that MSI installers are not a hard dependency for the 2.5
release, but not having them would mean having to support NSIS for the
entire lifetime of 2.5, which is not nice. We'll revisit this topic if
the other missing pieces are completed before MSI and MSI starts
blocking the release.

--

Full chatlog attached


--------------D28EDD21AAAF7D1AC316993A
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-02-05.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-02-05.txt"

(12:30:34) mattock: ok, meeting time it is
(12:30:37) mattock: I have 30 minutes to spare
(12:30:54) mattock: who has joined our merry group today?
(12:31:16) ***cron2 !
(12:33:03) mattock: lev__, ordex, plaisthos, syzzer, rozmansi?
(12:33:07) cron2: not much to report, though... I tried to do the argv pa=
tchset, but it needs a rebase + tun.c adjustments, and dazo went into hid=
ing...
(12:33:09) mattock: dazo said he can't make it
(12:33:26) mattock: I have a couple of small topics
(12:33:37) cron2: nice, useful meeting then :)
(12:33:54) mattock: #2 Signing tap-windows6 tags=20
(12:33:59) mattock: https://community.openvpn.net/openvpn/wiki/Topics-202=
0-02-05
(12:34:00) vpnHelper: Title: Topics-2020-02-05 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:34:04) mattock: https://github.com/OpenVPN/tap-windows6/issues/101
(12:34:05) vpnHelper: Title: Not able to verify source code. Push signed =
git tags? =C2=B7 Issue #101 =C2=B7 OpenVPN/tap-windows6 =C2=B7 GitHub (at=
 github.com)
(12:34:22) mattock: I believe we do sign the tags for openvpn.git
(12:34:23) cron2: I've seen the issue and I whould agree that this is use=
ful
(12:34:25) cron2: yes
(12:34:32) mattock: which key do we use for signing?
(12:34:38) mattock: security key or somebody's own key?
(12:34:41) cron2: my personal key
(12:34:45) mattock: ok
(12:34:51) cron2: because it's *me* who attests that this is what I pushe=
d
(12:34:55) mattock: yes
(12:35:16) mattock: I can make signing the tags a part of the tap-windows=
6 release process, i.e. sign with my key
(12:35:44) mattock: I think that covers that topic
(12:35:46) cron2: my key is signed by "all of you", but it might be an id=
ea to use the security@ key to sign the personal keys
(12:36:08) mattock: yep, would not hurt
(12:36:15) cron2: so the link "this personal key indeed belongs to someon=
e who is trusted by 'the organization'" is there
(12:36:32) mattock: indeed
(12:37:14) mattock: so I shall start signing tap-windows6 tags and we can=
 improve the web of trust of our keys by signing our respective personal =
keys
(12:37:22) mattock: another topic I forgot to add to the topic list
(12:38:31) mattock: OSTIF wants to do an audit of "changes between 2.4.0 =
and 2.5.0"
(12:38:53) mattock: I probably gave them our original estimate ("first al=
pha at the end of January")
(12:39:12) mattock: they were ok with postponing the audit until 2.5.0 is=
 ready
(12:39:26) cron2: nice
(12:39:58) mattock: not much more on that, except that we'd need to make =
2.5.0 ready :D
(12:42:24) mattock: anything else today?
(12:42:41) mattock: oh
(12:42:49) cron2: missing plaisthos, dazo, syzzer, lev__, rozmansi...
(12:42:52) cron2: how's msi coming along?
(12:43:04) mattock: community.openvpn.net is not longer a "PenVPN" site
(12:43:11) mattock: https://community.openvpn.net/
(12:43:13) vpnHelper: Title: OpenVPN Community (at community.openvpn.net)=

(12:43:15) mattock: logo changed
(12:43:33) mattock: I have no knowledge of the progress of the MSI
(12:43:45) mattock: we'd need to activate rozmansi for that
(12:43:59) mattock: he has been busy with lev, but on the MSI front proba=
bly not
(12:44:52) mattock: that said, we don't _need_ to make MSI a blocker - th=
ere's no reason we can't push MSI installers out after the initial releas=
e... but that would mean living with NSIS for the 2.5 lifetime, which is =
not nice
(12:45:41) syzzer: hi :)
(12:45:49) cron2: when we have everything else and MSI is not done we can=
 still decide for NSIS, but we have much stuff missing for openvpn itself=
 :(
(12:45:52) cron2: syzzer: hi!
(12:45:56) ***syzzer reading backlog now
(12:47:52) mattock: hi!
(12:50:10) syzzer: well, quick meeting it seems
(12:50:35) mattock: anything to add from your side?
(12:50:54) cron2: syzzer: how's life, family, things?
(12:51:24) syzzer: well, I can proudly announce that kid[0] now exists :)=

(12:51:34) cron2: fork() succeeded!  congrats! :-)
(12:52:02) syzzer: thanks :)
(12:52:32) syzzer: slowly starting to get used to the new schedule, not m=
uch spare time though :')
(12:53:47) syzzer: still planning to follow-up on the "new PRF" thing, no=
w that the prerequisite patch is in, not sure if I'll make that before th=
e 2.5 feature freeze
(12:53:48) mattock: syzzer: indeed, loss of free time is the biggest chan=
ce imho
(12:54:16) cron2: oh yes :-)
(12:54:18) syzzer: is there a new date for "feature freeze"?
(12:54:51) cron2: syzzer: tentatively end of february, but it's not looki=
ng realistic
(12:55:37) syzzer: ok, will keep that in mind
(12:56:19) mattock: I have to split in 3 minutes
(12:56:36) mattock: but I'll mark that "End of February" down as the new =
tentative deadline
(12:57:08) cron2: it really depends on dazo, ordex and plaisthos reappear=
ing
(12:57:24) cron2: maybe check internally what they think is realistic^Wdo=
able
(13:01:09) syzzer: so, wrap it up for today then?
(13:01:12) cron2: yes
(13:01:17) syzzer: good, lunch it is!
(13:02:17) mattock: will send summary later today

--------------D28EDD21AAAF7D1AC316993A--

--gdSbugivWSDUR5MZZ2QnXJnZxAPgIhkFm--

--QVKVcZewWeAr0O14L4SnSDEtWFD3eY1fD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl46uAcACgkQKVhNn0CG
RXhumQf7BrLlGQLIyovkp4PvyA6aK2B925KLsIrjqVzO6iKZ+GkVh+SvYUj9s29D
mucp6WVmgI1P2PP2jBRPNBzc4ErYenEjjM6euEQEy0I0UzFGOZMOYHzpQ/lyv0RS
e7Lv5BdJmB76+BmKPKHqq7meJ3BfLTDFitGyKT/ZAC6T9pBNqMfyFn1QBn94/VLE
OQGktT3mXOR5c5jSSFVZXnYXNfKaM6j9nPcYICvtp/DgJ87cML14YNsJ18FCt/+t
sKwQ9ym8d8bvq3l97lxsEcRZPcRxmGgxO/c6xRDg19rd75IebWDfHMvXCDbK6GDT
B/o5WMGf/t4Bw6gUF1XFMisQ9yU+hQ==
=vr8b
-----END PGP SIGNATURE-----

--QVKVcZewWeAr0O14L4SnSDEtWFD3eY1fD--

