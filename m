Date: Sat, 23 Jan 2021 14:56:06 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210123135606.GG976@...1296...>
References: <CAL3L06F7YvNHSFxWXrMFZf_8fSjmCH-RkMn1GXmLu7cW-G1=nw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Fno2Nek0FungcKUa"
Content-Disposition: inline
In-Reply-To: <CAL3L06F7YvNHSFxWXrMFZf_8fSjmCH-RkMn1GXmLu7cW-G1=nw@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] Exit management interface loop
 early on receiving 'remote MOD' message.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Daniel Kaldor <daniel@...2518...>
Cc: openvpn-devel@lists.sourceforge.net

--Fno2Nek0FungcKUa
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jul 03, 2019 at 03:50:41PM +0100, Daniel Kaldor wrote:
> OpenVPN using management interface and running with
> 'management-query-remote' in the config will wait for a 'remote MOD'
> or 'remote ACCEPT' message before continuing with connection.
>=20
> Logs indicate that this stage of the connection process currently
> takes ~1s to complete.
> This seems to be because the management interface polling loop is
> being run once unnecessarily after receiving 'remote MOD' message, and
> is only exiting after 1s timeout is reached on final polling loop.
>=20
> This change exits the polling loop early, immediately after receiving
> 'remote MOD' message and removes 1s delay in connection.

This might actually have been fixed by=20

commit d08b66f39cf80733a51e1607386dc4993faef09f
Author: Vladislav Grishenko <themiron@...2010...>
Date:   Fri Oct 2 03:53:19 2020 +0500

    Speedup TCP remote hosts connections
=20=20=20=20
    For non-blocking TCP/Unix connection, OpenVPN checks was it established=
 in
    loop and if not - sleeps or handles management for next one second. Sin=
ce
    the first check is made right after the connection attempt, it will lik=
ely
    be always unsuccessful, causing redundant wait for one or more seconds:
...
    v3: teach management_sleep() to handle zero timeout and reject negative
        use 1s timeout for connection and 0s timeout for management events


could you check if this solves the delays you are experiencing as well?

If not, please re-send, taking Arne's comments into account.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Fno2Nek0FungcKUa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgDCr2AAoJEB2Cnv7KVigSL6IL/1FU9Vq2gcsWmTXmIfMtGwKB
580GYyYhStfVQ/KnGndyHghaE0ydALFGTbAjy7uqAbqi4Xn1wl/JH4SH6uk6wZ94
qKGnWkPT1fHSJobX6odbSVmcr7ldrdxUFHVhhxC7UZVV03n0Tj7BKbkdBuks/XrX
D/AQk4YCT0yLZ7sbR1yXTnUtqiZoAcIlNR3vYzQ4v4SuEiCLS/bH0r5gsAVEVGM7
FBDq+Trt0HMaK+qY7xOoWyUQLA5LeII2VIVwLrS0EPnyVVybclBS56xLCHLZCdfF
sEtRHBjvdD684KtZdGUyrO1DLH6PFUT3kAgPRWm/AMqiU7/HNBmKyvyuMmUe57Jo
dgZCeHpIUzixVP5cXwSVH9l50+6oz76iS0wY782+WStoLiQQiTDG0E4aLNnjO2KW
f1NPLxk2pFp+idtTqH6Ha4n/PbNnMPCwLDrVMapm7RLZNPq+opVml21pHDAPZxl/
kylnNLFElEnzPBJ1Np3JoXNWlyHDVGk8p1geoLA8Nw==
=m9pV
-----END PGP SIGNATURE-----

--Fno2Nek0FungcKUa--

