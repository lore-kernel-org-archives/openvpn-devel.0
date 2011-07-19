Date: Tue, 19 Jul 2011 13:41:09 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110719114109.GZ8496@...1296...>
References: <4E1F227F.7060308@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lXmiyU9ryIv8cp4K"
Content-Disposition: inline
In-Reply-To: <4E1F227F.7060308@...515...>
Subject: Re: [Openvpn-devel] First Windows installer snapshot now available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--lXmiyU9ryIv8cp4K
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jul 14, 2011 at 10:08:15AM -0700, Samuli Sepp=E4nen wrote:
> The first Windows installer snapshot is now available here:

Cool :-)

> I did basic IPv4 smoketests on Windows 7 64-bit and it seems to work.
> Both the installer and the TAP-driver are unsigned, so users of 64-bit
> versions of Vista (and above) need to start their computers in "Test
> mode" to try this out. The goal is to put signed TAP-drivers to future
> installers.

Since the TAP driver unchanged between 2.2.x release and "master"
we could just use the already-signed TAP driver bundle from 2.2.x.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--lXmiyU9ryIv8cp4K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTiVtVakuBuNlUUl1AQKClAP+MtxXrRZr4yN+M+EuO6xwQkGPJ3Bq3baW
f6HiqLsK3/XeSNwK41cEMWT2DuU8HPOzRdfpSS/u8e0x4XJc2AhWrLFFF/BxKc+p
60ye0DaslmHNLJg1ASaS/BoR0q7DX2VH4nxVwSAN64StVSKP+yZGnS5n4lxdsvMc
THQYN8s7OlQ=
=B4+V
-----END PGP SIGNATURE-----

--lXmiyU9ryIv8cp4K--

