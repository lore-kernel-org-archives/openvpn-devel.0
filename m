Date: Thu, 15 Dec 2022 09:14:13 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y5rXVTcJzmoCGqSj@...1296...>
References: <20221211190913.190-1-marc.becker@...2704...>
 <202212150755.2BF7tJge044122@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="RRBVdHAM+4tY1eah"
Content-Disposition: inline
In-Reply-To: <202212150755.2BF7tJge044122@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: unify code path for adding
 PKCS#11 providers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Marc Becker via Openvpn-devel <openvpn-devel@lists.sourceforge.net>

--RRBVdHAM+4tY1eah
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

*sigh* - "Marc Becker via Openvpn-devel", this so messes up my workflow...
(can DMARC please go somewhere and die, alone, with no friends?).

I had to reapply these patches 1/3 and 2/3 to get the author right,
so you'll see new commit IDs.

For 1/3, these are:

On Thu, Dec 15, 2022 at 08:55:19AM +0100, Gert Doering wrote:
> commit b08f8cbb2b92f3ee0eced39d11665befea3aec87 (master)
> commit f1995ccca4c105e71728101bb719d235f5605b33 (release/2.6)

new:

commit 8958a365479348c1500dee44e1a8b27e7e35a96f ( master)
commit bcceded96775cc5a131bb9ab11ba855c7576603d (release/2.6)

Author: Marc Becker <marc.becker@...2704...>
Date:   Sun Dec 11 20:09:13 2022 +0100

    unify code path for adding PKCS#11 providers

nothing in the actual patch has changed, just the author (and that,
of course, changes the commit IDs).

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--RRBVdHAM+4tY1eah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjmtdVAAoJEB2Cnv7KVigSfO0L/2esOpMFpYKbWOMj9W3J8P/a
El7V1y35M0Tnzv0E/6bCVz2+MF1mF+SgXyObFLX7EhhMpiI4FMBgwDzp7cWsv+U3
HQ3HHcEvJ9tsKGwflHW0h6zm9LDswJxYVYufjK/v09EgPv7/beTcQv9ZB464oFL2
dKrsGJSFDN1hOdoqS/ufip+UwroOKgAriyEKW0yBLE324wPrLZpoN8DMWmCdWdjf
5+D6SGx9PZRrXlBfQ1VFJff2OyNbRDqWa1Vk0WemO1yxMMS21II8scTKPBVvHGds
qFzP1qHzoZNcB1Kkbtun9GbmRCbR1Pob3ZohzFmMpXLNFduyQ1riCYFsKpiENCGi
CwUUS4KZbAZEikbabVVAVEISE5NyNV8tG/J/JG8AzM4fOZQkSpCns3w7de4MGThl
YmAWyTVpctlie9D7QzxBG0AT3iTKMOshh0Ug0687mMNpxy0qv9xTHBgu5glwRR+F
EQrM9W+3cp6nv5LXCW7By51NyVxrMoULVfeDOyfn7w==
=gXDg
-----END PGP SIGNATURE-----

--RRBVdHAM+4tY1eah--

