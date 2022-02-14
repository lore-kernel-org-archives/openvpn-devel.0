Date: Mon, 14 Feb 2022 07:59:11 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Ygn9v2VtPVt26g7b@...1296...>
References: <20220214001440.3739838-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="y8pDxYjbCG5NVjsc"
Content-Disposition: inline
In-Reply-To: <20220214001440.3739838-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Remove FRAME_HEADROOM, PAYLOAD_SIZE,
 EXTRA_FRAME and TUN_LINK_DELTA macros
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

--y8pDxYjbCG5NVjsc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Feb 14, 2022 at 01:14:40AM +0100, Arne Schwabe wrote:
> The buffer overhaul simplified the frame struct to a point that these
> macros are either not used anymore or are not adding any benefit in
> understanding the code anymore. Replace the macros with direct member
> acessses.

Looks good, but if you get rid of FRAME_HEADROOM, do not forget
the #define in mtu.h :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--y8pDxYjbCG5NVjsc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiCf2/AAoJEB2Cnv7KVigSB5EL/0yJ72I/KUd1hc4tdQ9uBz2w
EzaWXpUridrtPWDnP5/TvCabsZOmt+PDS/j2X47Az6lEJ6AO+iMZFlyYYL37U1lg
otMgc8OVD/fUkX8CbTwiGafcNXmK2fpuG4V26mXRRbaLQVEpNqFoByakMVSuMxDf
GCa+P7s7ftMrqNVZfWTvCeXjKJKB2uWiWhXTIsDko5k924bdYx1KfoLDL5lYHahh
gTEyQ7opiRc668MWO5cMBubIoZrvH1oTn47uuNGWIk8mX0RIAyyPNia+k5Fca3Jo
hmfcoWgPAaefKjTWFhC88RHfbqH33MqUzhIFyoB21c8bUm9zwf8dtxhe3D0m5NjM
31LGTMXibCAeOWCDI2m2tdMzr4gTmoJwVGokVPuJ1NEyO7FFAK7Sa38d31V4UgsB
MlZfreKKyNPTkatyAkTSidi3/wY/HYIVr0lL0kEISqS5b5kSn61BrZeglfvL5XJg
0p3cLE8OeHof2dHQZWY/6+0ratOSmH6JXW1enbPLGQ==
=8XwY
-----END PGP SIGNATURE-----

--y8pDxYjbCG5NVjsc--

