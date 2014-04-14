Date: Mon, 14 Apr 2014 19:38:17 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140414173816.GM16637@...1296...>
References: <20140413152613.GT16637@...1296...>
	<534B8A45.8040006@...1147...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9ukiCmED/ZpLhx5+"
Content-Disposition: inline
In-Reply-To: <534B8A45.8040006@...1147...>
Subject: Re: [Openvpn-devel] RFD: ssl library version numbers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

--9ukiCmED/ZpLhx5+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Apr 14, 2014 at 09:12:05AM +0200, Jan Just Keijser wrote:
> >- how do I get the library version for PolarSSL?
> void version_get_string_full( char *string )

I really wonder what they smoked when designing this API...

/**
 * Get the full version string ("PolarSSL x.y.z").
 *
 * \param string    The string that will receive the value.
 *                  (Should be at least 18 bytes in size)
 */
void version_get_string_full( char *string );


"pass me a pointer to a string, don't pass me a length field, and there's
no real way you can be sure whatever you use is long enough"...

Anyway.  Patch coming.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--9ukiCmED/ZpLhx5+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU0wdCKkuBuNlUUl1AQKAwgQAs+XniM2CDumRU3qxS5IbvVN5lw3VSM0M
DU8Y7InQC8bxZNMCskkOv6voNTJ76hI6ws7I2bBNJ8YKQyBRAJXWwskm8AKjhYqT
y89RpWvXdg6OieQNbpWxeTKosmVHa7L9kJV82Z7TMTwhphJJf5n4lB5gaMiNN1bv
QS9o67iney8=
=bgai
-----END PGP SIGNATURE-----

--9ukiCmED/ZpLhx5+--

