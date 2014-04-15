Date: Tue, 15 Apr 2014 09:42:39 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140415074239.GR16637@...1296...>
References: <20140413152613.GT16637@...1296...>
	<20140414193422.GN16637@...1296...>
	<534C42AB.7040700@...1114...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JJ02811x3CkhBuQp"
Content-Disposition: inline
In-Reply-To: <534C42AB.7040700@...1114...>
Subject: Re: [Openvpn-devel] RFD: ssl library version numbers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--JJ02811x3CkhBuQp
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

On Mon, Apr 14, 2014 at 10:18:51PM +0200, David Sommerseth wrote:
> Regarding your patch - the PolarSSL stuff
>=20
> +char *
> +get_ssl_library_version(void)
> +{
> +    static char polar_version[30];	/* "at least 18 bytes in size" */
> +    version_get_string_full( polar_version );
> +    return polar_version;
> +}
>=20
> version_get_string_full() is crappy due to the "at least 18 bytes".
> That's ugly.  Can we please ensure that we at least adds a NULL
> termination in polar_version[29] after version_get_string_full() ...
> just to reduce the risk somewhat, in case it suddenly gets longer.  Then
> it should (hopefully) be somewhat harder to get a buffer information leak.

Different approach:

char *
get_ssl_library_version(void)
{
    static char polar_version[30];
    unsigned int pv =3D version_get_number();
    sprintf( polar_version, "PolarSSL %d.%d.%d",
                (pv>>24)&0xff, (pv>>16)&0xff, (pv>>8)&0xff );
    return polar_version;
}

this is well-defined (polarssl/version.h), and guaranteed to not overflow.

> Or maybe even slightly more hardened.  Put version_get_string_full()
> into a much bigger temporary buffer, which then uses a strncpy() or
> memcpy() into the polar_version[] buffer.  The strncpy()/memcpy() should
> restrict it to 30 bytes, including NULL terminator.

"much bigger", right :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--JJ02811x3CkhBuQp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU0zi76kuBuNlUUl1AQLy1gQAtnPOB2IzIYv2VhGrAs6QNhhSTijCybN7
SMUY9knNbGgFr/N349QLxj0FliSL13FsKv8rlVmRu05h4sWzyoVJDDKITjcj7gve
BWgLT5jKWBGQ/VRxD31sISSPfHVVgvsZl51uRt6oUA6omO3+kK5MtQ7YjRKxSYse
2mqaTANkU/o=
=rAw+
-----END PGP SIGNATURE-----

--JJ02811x3CkhBuQp--

