Date: Mon, 27 Apr 2015 18:54:35 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150427165435.GR382@...1296...>
References: <1429036445-17223-1-git-send-email-yegorslists@...1030...>
	<552E1111.6010201@...68...> <20150415120704.GI382@...1296...>
	<553E4C46.8050809@...1114...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VgNP6wxEowREGVu+"
Content-Disposition: inline
In-Reply-To: <553E4C46.8050809@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] m4: enable silent build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: Matthias Andree <matthias.andree@...68...>

--VgNP6wxEowREGVu+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Apr 27, 2015 at 04:48:38PM +0200, David Sommerseth wrote:
> Just tested a ./configure (used automake 1.13.4 on RHEL7) with
> - --enable-silent-rules.  That worked like a charm out-of-the-box
> without any patching.

David, thanks for testing and reporting.  With this, I think we can
let this thread end - people that want silent output can have it today,
no patches needed.

(I, for one, like seeing the actual compiler and especially linker=20
statements, as they are often needed to understand failures...)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--VgNP6wxEowREGVu+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVT5py6kuBuNlUUl1AQKYdwQAwxAR1nXjd+yevyuBZzEimt8xhJ3JX4rw
+NDkgUKXycvLSLlVfj3uinoHEfZd0swVBmg5u/Mcp3EzVbgfTlpq45mL8m1KUm84
DPqmLmAvFUcr2uCuc0x5lsVwSAvOuFUiz4j8H7JgyVfTvKtoybHF4WAfnqP2qB6b
L2Z8uDiStJQ=
=RWRU
-----END PGP SIGNATURE-----

--VgNP6wxEowREGVu+--

