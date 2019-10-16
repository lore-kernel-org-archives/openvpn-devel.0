From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <4d714839-b586-8b1c-df66-6ceb20a59fe3@...515...>
Message-ID: <53660481-ead4-036a-186e-c6477e68b4fd@...515...>
Date: Wed, 16 Oct 2019 13:42:30 +0300
MIME-Version: 1.0
In-Reply-To: <4d714839-b586-8b1c-df66-6ceb20a59fe3@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8d5eUzYXf8uG8vyJAfGAoGfMcWQq6wxz4"
Subject: [Openvpn-devel] Summary of the community meeting (16th October 2019)
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
--8d5eUzYXf8uG8vyJAfGAoGfMcWQq6wxz4
Content-Type: multipart/mixed; boundary="hPZbdJA2HJRM7ACPC7hq6Wtq2O2Jp9zYB";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <53660481-ead4-036a-186e-c6477e68b4fd@...515...>
Subject: Summary of the community meeting (16th October 2019)
References: <4d714839-b586-8b1c-df66-6ceb20a59fe3@...515...>
In-Reply-To: <4d714839-b586-8b1c-df66-6ceb20a59fe3@...515...>

--hPZbdJA2HJRM7ACPC7hq6Wtq2O2Jp9zYB
Content-Type: multipart/mixed;
 boundary="------------C647BC83542B18E991099904"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------C647BC83542B18E991099904
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 16th October 2019
Time: 11:30 CEST (9:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-10-16>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

eworm, lev, mattock and rozmansi participated in this meeting.

---

This was a very minimal meeting as many people were unable to attend.

Noted that mattock is setting up the new tapbuilder/signer instance
right now.

Rozmansi reviewed and approved Lev's Visual Studio project patch:

<https://patchwork.openvpn.net/patch/863>

--

Full chatlog attached.


--------------C647BC83542B18E991099904
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-10-16.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-10-16.txt"

(12:28:35) mattock: almost meeting time
(12:30:17) mattock: cron2, ordex and dazo won't make it today
(12:30:24) mattock: anyone here besides me?
(12:32:08) lev__: hello
(12:34:20) mattock: hi lev!
(12:34:41) mattock: now that you're here we could discuss the new tapbuil=
der instance
(12:34:47) mattock: I'm going to configure that today
(12:34:58) mattock: anything particular you need on that node?
(12:36:14) lev__: I guess VS 2019 community edition and WDK ?
(12:37:03) mattock: that's what I'm thinking
(12:38:03) lev__: speaking of VS, I am very close to send patches to add =
VS build to Travis
(12:39:00) lev__: it downloads openvpn-build for building dependencies an=
d builds openvpn with msbuild
(12:40:54) mattock: great!
(12:42:04) mattock: I'll check if I could automate the VS 2019 + WDK setu=
p as well - if chocolatey packages are available for those it should be d=
oable
(12:42:26) mattock: if there's nothing else I think we can conclude this =
mini-meeting :)
(12:42:38) lev__: yep
(12:45:44) rozmansi: hi
(12:46:44) rozmansi: just missed a mini-meeting. :)
(12:46:51) lev__: :(
(12:47:00) rozmansi: back to work I guess. :)
(12:48:47) rozmansi: lev__: btw, a few days ago I took time to wipe the d=
ust off from my openvpn involvement. Noticed that openvpn-build is still =
using Visual Studio 2017 project files and it is good to hear you're work=
ing on a VS2019 upgrade.
(12:49:07) ***eworm too... :-p
(12:49:27) eworm: Just joined to see if there is anything new about versi=
on 2.5
(12:50:29) lev__: rozmansi: yeah in wintun patch series the first one is =
to support VS2019
(12:51:04) lev__: rozmansi: have you see this https://community.openvpn.n=
et/openvpn/wiki/BuildingUsingMsvcBuildsystem
(12:51:06) vpnHelper: Title: BuildingUsingMsvcBuildsystem =E2=80=93 OpenV=
PN Community (at community.openvpn.net)
(12:51:48) mattock: oh hi!
(12:51:49) rozmansi: lev__: yes, I was using it when developing tapctl.ex=
e and openvpnmsica.dll
(12:52:07) lev__: but it order it to work, someone needs to ack this supe=
r complicated patch https://patchwork.openvpn.net/patch/863/
(12:52:08) vpnHelper: Title: [Openvpn-devel] Visual Studio: make it easie=
r to build with VS - Patchwork (at patchwork.openvpn.net)
(12:52:11) rozmansi: lev__: those were developed and tested in Visual Stu=
dio first. Then ported to MinGW.
(12:53:38) rozmansi: lev__: ACK... let me find it on the mailing list.
(13:04:26) mattock: thanks for the ACK rozmansi!

--------------C647BC83542B18E991099904--

--hPZbdJA2HJRM7ACPC7hq6Wtq2O2Jp9zYB--

--8d5eUzYXf8uG8vyJAfGAoGfMcWQq6wxz4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl2m9BcACgkQKVhNn0CG
RXipNwf+Ih8GTfNESXcPPWDW7weHJ4vicLm3ZRXY8iw72BWyngwi8DyJf/hQxvXE
MLM2pOKS+5dV+sb/nixwWg1Oz2lsFeJm2qOhRV/z9m+5GCZm2cQMAX49XWFVbFXS
cVxx8Wxk+tTiHS4QZ/03kvUad9Ki5eG22UCfr4II3N/WgRS3V+HEsKM2Wq5WUrot
f8dm7HxN4k4UEaj9zJs74sqA0Dz3eV5oyQzs5FTaULnjA78fmzE+9JVoAe4GWVFs
mdRVREpcqjVQeCFnB5593OVH+aCIGeFmpkFWNchc6d7vafXphmUJNqQoVp0XnMgs
HrCptRuaUjW+7pk+QS3rI0qOxkK05A==
=nj96
-----END PGP SIGNATURE-----

--8d5eUzYXf8uG8vyJAfGAoGfMcWQq6wxz4--

