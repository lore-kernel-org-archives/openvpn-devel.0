Date: Thu, 4 Mar 2021 11:11:12 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210304101112.GP976@...1296...>
References: <CAAUX2SWYWhU-S97Ak-6XdAVQ+hty_Y8RHu_KSM8hZPiKaP7a1w@...278...>
 <e9f619bb-bd36-c77a-5f66-e7c33f6be579@...1227...>
 <CAAUX2SVde3STTxGmthXod2-pDzLPYkm+yRYvG1T4yyJGoLMKLw@...278...>
 <63cfcb94-6060-9d45-66f8-6dbfd69d7dd9@...2181...>
 <CAAUX2SWL_mw0YgkoCA6dd2vXT7YtkgZbib+GTQkDVrNvWMU72Q@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="xJoJ+2AiUVV9OskE"
Content-Disposition: inline
In-Reply-To: <CAAUX2SWL_mw0YgkoCA6dd2vXT7YtkgZbib+GTQkDVrNvWMU72Q@...278...>
Subject: Re: [Openvpn-devel] Segmentation fault in OpenVPN 2.6_git
 [git:dco/fcc852a9b2ea832c]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tony He <huangya90@...277...>
Cc: Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xJoJ+2AiUVV9OskE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 04, 2021 at 05:10:19PM +0800, Tony He wrote:
> I used static key and saw same error.

Seems static key is broken in this test branch.

This is not a recommended way to run OpenVPN, so it's not always fully
tested in development branches (we *do* have tests for it in the official
trees).

This is what Arne tried to tell you: using TLS based setups is what
the developers use, and what is known to work.

> Note: NOT using '--topology subnet' disables data channel offload.

I think this is documented in the release announcement.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--xJoJ+2AiUVV9OskE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgQLI/AAoJEB2Cnv7KVigS3/sMAJNEgERla/GQaXPQLL4k4UA9
jf+26xU5s0rRMSiPrAQHJoGysX2ma71QNCGYnsjDO82DPNyc4zwMM6y3A0CAn6do
VXQxOytCH1nhlMsPKxMB/leWI0ysj4DIuSBmZAJC0rElKgRoXy5vwjQLZkCqo12U
FnAtZPUhAO3nRc4fQQDaZPzwmEXxgbDDY2kiKtxJkcKplFCXSNbpILp5uTTuTu+Q
hg2xj3Q+8oXB8/4HtEMCOdOa9fL2zH73RyUx8hUS1tz2uks8CpbDLBufymwFCcbo
al5aXBkFVRQdPtlzBg4aWrhWO4R93JHt5j6A3i7thhgfQQfWTrdIPY8GaMcI25Yf
/1nXns+u94aB2n9j/Q7lHbB1b1o0sDhOJdx/xspI2SmjpCC7+V9rDNwadtZHJ4nD
FHJ8VuqerL2VhOGyAegOusSahSEZZgyTyrrYLw0eIYblp+mDqkfHRFZNh4YK5IQW
/E0bfB7sXLlWF2Iey6W5prYuGAh55NiYiFm30/5iuw==
=+Dtc
-----END PGP SIGNATURE-----

--xJoJ+2AiUVV9OskE--

