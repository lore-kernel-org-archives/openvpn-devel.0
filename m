From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <de2ff642-df3f-c0a9-c6b0-10584555a4ac@...515...>
Message-ID: <0733421b-880b-52f3-2e24-d94f33b00a78@...515...>
Date: Thu, 13 Feb 2020 22:00:52 +0200
MIME-Version: 1.0
In-Reply-To: <de2ff642-df3f-c0a9-c6b0-10584555a4ac@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Nxn96HXMJowqlY65eCBfjuJUGuZHi0uNb"
Subject: [Openvpn-devel] Summary of the community meeting (13th February
 2020)
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
--Nxn96HXMJowqlY65eCBfjuJUGuZHi0uNb
Content-Type: multipart/mixed; boundary="68aT3Pdj36cSnUCWJ5KbxZPIFFtoadKM8"

--68aT3Pdj36cSnUCWJ5KbxZPIFFtoadKM8
Content-Type: multipart/mixed;
 boundary="------------DB6832BFE7B2198F055E620A"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------DB6832BFE7B2198F055E620A
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thu 13th February 2020
Time: 20:00 CET (19:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-02-13>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, lev, mattock, plaisthos and wiscii participated in this meeting.

---

Lev and plaisthos got the ok from OpenVPN Inc. to spend as much time on
OpenVPN 2.5 as needed to get it out. One of the big motivations was the
upcoming OSTIF.org audit.

Noted that despite that meeting the "end of February" deadline might be
challenging as cron2 will be on vacation on next week (so merging will
be slow).

The main missing pieces from 2.5 are client-connect and joint (MSI)
installer with Wintun and tap-windows6. Plus plowing through the open
trac tickets and patchwork to see what needs to be fixed.

--

Noted that MSI installers will need - and were planned to - be
architecture specific, with a shim installer that is able to select the
correct installer based on architecture.

--

Full chatlog attached

--------------DB6832BFE7B2198F055E620A
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-02-13.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-02-13.txt"

(21:05:05) cron2: I am sort of here
(21:05:15) lev__: okay, so plaisthos and me got an approval from inc to s=
pend as much time as needed to get 2.5 out soon
(21:06:04) cron2: wut
(21:06:16) cron2: this is great
(21:06:32) mattock: yep, I  brought this up in a meeting with CEO and oth=
ers
(21:06:43) mattock: one of the big motivations was the upcoming OSTIF.org=
 audit
(21:06:55) cron2: I have been crayzily busy for the last few weeks (like,=
 charging 14.5 hours to $customer yesterday... starting work at 8, finish=
ing at midnight)
(21:07:26) cron2: the next 3 days I go snowboarding with the kids, but wi=
ll see that I can get a few things merged in the evenings :)
(21:07:59) mattock: good, because we need a merger :)
(21:08:02) cron2: we won't make "end of february", though, as that hits m=
y vacation week...
(21:08:10) lev__: why not ski? :)
(21:08:37) cron2: did ski for ~35 years, decided it's too much effort and=
 somewhat boring, started something new, liked snowboarding more
(21:08:42) cron2: fits my hairstyle better
(21:08:48) mattock: :D
(21:09:00) mattock: anyhow
(21:09:06) cron2: will do my best
(21:09:55) mattock: should we do some 2.5 coordination here? or just let =
lev and plaisthos plow through the patches?
(21:10:14) cron2: what about ordex?  that secret project keeping him busy=
?
(21:10:43) lev__: not sure how secret is it, but yes
(21:10:50) mattock: I was about to say exactly the same
(21:11:23) lev__: what critical things we are missing? client-connect, wh=
at else?
(21:11:44) cron2: client-connect and joint installer with wintun, I think=

(21:12:15) cron2: and plowing through the open trac list which of those a=
re real bugs and should be fixed :)
(21:12:25) lev__: current nsis installer already supports wintun
(21:13:01) lev__: but it won't be bad to have msi
(21:13:15) mattock: but I guess ordex could be detached for stuff nobody =
else can do
(21:14:17) mattock: MSI is at the mercy of rozmansi
(21:14:37) mattock: I won't have time to learn MSI well enough to take hi=
s place or even help him out except in testing
(21:16:11) lev__: by the way, our (inc) apps team told that they had to p=
roduce separate installers for x86 and x64, since wintun provides separat=
es installer modules and apparently they cannot be used together
(21:16:39) mattock: this is about MSI, correct?
(21:16:49) lev__: yes
(21:17:20) mattock: rozmansi did plan on having separate installers anywa=
ys, and having a "shim" that is able to select which one to use, dependin=
g on the architecture
(21:17:25) mattock: so I guess that is covered
(21:17:43) lev__: wg also provides two separate installers
(21:22:12) cron2: yep
(21:22:40) mattock: anything else we should discuss?
(21:24:31) cron2: working my way through the ACK queue
(21:24:37) mattock: ok
(21:24:59) cron2: it's really nice to see so much activity (though I had =
preferred to have this in less busy times, like "last month", but anyway,=
 ACKs and reviews are good)
(21:26:09) mattock: I will also dare open my INBOX - I've been avoiding f=
or a day or so that I get work done :D
(21:29:48) plaisthos: hey, I am semi afk but yeah, I am trying to go thro=
ugh all patches in patchworks
(21:29:51) plaisthos: and I started with the oldest
(21:31:13) mattock: which year is that from? :P
(21:32:02) plaisthos: 2018
(21:32:59) mattock: well not that bad
(21:33:18) cron2: you have set NAKed patches to "changes wanted" (etc) al=
ready?
(21:33:29) cron2: like, the "alternative names support" patch?
(21:37:28) plaisthos: yeah
(21:37:43) plaisthos: I might have forgotten some but will do that eventu=
ally
(21:37:54) plaisthos: to what status do I set acked but not yet merged pa=
tches?
(21:41:20) cron2: if there is an ACK, I will hopefully pick em up by my o=
wn
(21:41:30) cron2: but you can delegate to me (if you can't, bugger mattoc=
k to give you rights)
(21:42:12) wiscii: might i recommend "bother" not bugger
(21:42:27) cron2: why?
(21:42:57) wiscii: the meaning is self evident
(21:43:34) mattock: in any case bother or bug me as needed :D
(21:48:27) mattock: I have a summary ready if there is nothing else :)
(21:49:54) wiscii: my request can wait till after
(21:51:12) mattock: I forwarded it to openvpn-devel
(21:51:48) mattock: I will send the summary in 5 minutes unless somebody =
brings up a topic
(21:51:59) wiscii: mattock: if you mean me then thanks but i'll msg dazo =
after
(21:52:10) mattock: yes I mean you
(21:52:13) mattock: :)
(21:52:20) wiscii: okey dokey, thanks
(21:52:33) mattock: no problem!

--------------DB6832BFE7B2198F055E620A--

--68aT3Pdj36cSnUCWJ5KbxZPIFFtoadKM8--

--Nxn96HXMJowqlY65eCBfjuJUGuZHi0uNb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl5FqvQACgkQKVhNn0CG
RXgmQwgArV6O0YETWCIVfc+IXNKG94IKCCruqyBf6+qnOC0M3mWIzN593MH8kxaC
2Cbcr4BrNGG6zEChKoglE9HklfPs1iB2VadVdX/ql/kFjehxbnh9YYkOGfyD4tiw
97cx/0PUSC3KtrjDvtb6Y/C13OjPDSR4MGfGgy1+V9USiclA2RfAuck6KLbI2SYa
TeTOSCJJn6M8DAn6/rP9qq7L8iOib/cIsuK3Q/B7d2ErusuwCp3K4I5Ak9GZwwPv
14/sAROPLI97BhZaJtnrTxzumjbI3AeUIO2mhj9xpbV7VgLy83dfCAxX6QdN2Qib
6L0D4FZweNgirk6pdwMdKcBQMoUVUQ==
=lDWJ
-----END PGP SIGNATURE-----

--Nxn96HXMJowqlY65eCBfjuJUGuZHi0uNb--

