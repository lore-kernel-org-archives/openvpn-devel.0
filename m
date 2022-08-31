Date: Wed, 31 Aug 2022 15:54:37 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yw9oHZ+rxAbkaqDo@...1296...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220831134140.913337-1-arne@...1227...>
 <20220831134140.913337-2-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="rsXpWYmEPoBz4Qlm"
Content-Disposition: inline
In-Reply-To: <20220831134140.913337-2-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 29/28] Add workaround for Softether
 server dropping P_ACK_V1 with >= 5 acks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--rsXpWYmEPoBz4Qlm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 31, 2022 at 03:41:40PM +0200, Arne Schwabe wrote:
> This behaviour has been fixed on the Softether side with commit 37aa1ba5
[..]
> +     * in a packet (see commit a14d812dcbc in Softether) */

The code seems to do what the commit says, but seeing two different commit
IDs here confuses me.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--rsXpWYmEPoBz4Qlm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjD2gdAAoJEB2Cnv7KVigSC8cL/jAyj11rLI2l4N4MRFwsq5FU
VwOheEh6L5BJJEkIQSnWhamRgC9zrTcpy7s6/f2iPbPXm+TP0FtGt27FOeIPvFN6
6yDlFFmdimIHavy423Y0oZhsOj7QcQ/+bt7/dj0X7iWh+2j41bt57nt515H269Al
7Rvh+MSzpP5pL4/J41dBctXBcrMm3lLduvNTohJe7rnWR+wvJuHM6NyBwARTsf+0
8OyLR2mcdxCku5vLjdMvR/obRjM+B+lSfXeqUisqVUvuB7OMtAPp+GficvaDveUR
JqIai4WvDQuK6jOXXEt/+gveIzi3SbbE+XEH+auM+91vxOFIe6NNoUjpnxcj90KL
BxGNFdHhaIX7apfqm44hnqh3SYglcImD60VaXL5UF8luVV3rcGyPLLpTcjdMoitS
GO42GbgMg+dBvad9NFHeRBol4oLLMmqZn2j++O8LnBisEH0L6JvkPBpEDy36VxSF
p4wsDHZtDUY48796y3lqOEFXUeK8IqAd4msBQIhy8Q==
=pMv8
-----END PGP SIGNATURE-----

--rsXpWYmEPoBz4Qlm--

