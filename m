Date: Tue, 27 Dec 2022 19:25:42 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y6s4pog4C22Sb+uY@...1296...>
References: <20210907223126.8440-1-selva.nair@...277...>
 <202212270831.2BR8VUQ3085016@...2054...>
 <CAKuzo_jAq3Roq_HfR_WOmVW1OWcPKa-h0JGSYF8=4xC1VW1ukA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="zWs4ozjlo4idpVDD"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jAq3Roq_HfR_WOmVW1OWcPKa-h0JGSYF8=4xC1VW1ukA@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add remote-count and
 remote-entry query via management
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--zWs4ozjlo4idpVDD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 27, 2022 at 01:18:02PM -0500, Selva Nair wrote:
> My test implementation in the GUI constructs the list when first >REMOTE
> query is received. If there is no >REMOTE from the daemon, the feature is
> not used. That works.

So what's the magic --option to make openvpn query for >REMOTE?

(My understanding of the management interface details is limited... I just
happen to stumble across things here and there :-) )

> That said, making these commands work from management-hold would have been
> nice, but looked harder to implement -- we need a callback to get the
> context in management.c, but callbacks are initialized late.

Yes, definitely looked like it.  But if OpenVPN queries for >REMOTE=20
voluntarily ("if more than one option exists"), that sounds good enough.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--zWs4ozjlo4idpVDD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjqzimAAoJEB2Cnv7KVigSa5AL/1ID/wy17pmC4OXF3KZ2fZRO
kCbCROemgKd3qddHkbdpFYhM03P8ealVjcMy6ZHGOE1wcSmNFtfz6GEu+CvSVnit
vLuVtl8pAr42o+PKY8oaujjhb4TIPizgmUAYiBKrDAfQ9HDxC4WgsqsNyGsowl4p
Hfm9zNhZcFIc9BU6QE7vFrQfPTJDhv1UUELD7SlV2s/oiTKZxfyImLqqFv0x9wpP
aA2D2U/yB3o2wkEs8h5hBi9Z8IB+gH/pjBGLlLd8WDMPoec7FDc81J51FhDnNrb5
U+lMMfX/jmtRXLI4YX7jpc8Z760H4BcUpfAZO5DEXS9k6cSpmocamPl1qwL3W2kk
/ylPYjbEsiCzgCTHqcLU6uS+V7Rbykxh3Bylei2rbjV6m+FihrrmLItEJzJpa8KT
/KZt8vlZXh3XTp4XMbYUB7StDCP4Hfv/LpzF/TfjPOJ+6bA4JgTQqutgVclf2fs+
rLmS9qIyf80GLYOUdE0IYcg3CJJAExfD2n4ci+G/fQ==
=k/83
-----END PGP SIGNATURE-----

--zWs4ozjlo4idpVDD--

