Message-ID: <534C42AB.7040700@...1114...>
Date: Mon, 14 Apr 2014 22:18:51 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20140413152613.GT16637@...1296...>
	<20140414193422.GN16637@...1296...>
In-Reply-To: <20140414193422.GN16637@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="5mV8qqEbC4jSFMp5hcrfupX6WQsox8erS"
Subject: Re: [Openvpn-devel] RFD: ssl library version numbers
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5mV8qqEbC4jSFMp5hcrfupX6WQsox8erS
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 14/04/14 21:34, Gert Doering wrote:
> Hi,
>=20
> On Sun, Apr 13, 2014 at 05:26:13PM +0200, Gert Doering wrote:
>> OpenVPN does not currently report the version of the SSL library it is
>> using - which I'm not sure whether it's by design or just because nobody
>> ever added it.  Anyway, right now I think we need it, to help future
>> cases.
>=20
> OK, here's a "continue the discussion" patch.
>=20
> This is actually surprisingly messy, as the "first line" OpenVPN prints
> is a static string that is referenced all over the place, sometimes sent
> to file descriptors, sometimes used with msg(), so extending this to
> include the "library version numbers" would be a fairly big change.  So
> I've decided to just print a second line:

Makes sense!

>=20
> If --push-peer-info is set (and only then), this is sent as part of the
> peer-info handshake towards the server:
>=20
> Apr 14 21:23:49 gentoo openvpn[17804]: 2001:608:4:0:222:68ff:fe7f:7420 pe=
er info: IV_SSL=3DOpenSSL_1.0.1g_7_Apr_2014

Looks good.

Regarding your patch - the PolarSSL stuff

+char *
+get_ssl_library_version(void)
+{
+    static char polar_version[30];	/* "at least 18 bytes in size" */
+    version_get_string_full( polar_version );
+    return polar_version;
+}

version_get_string_full() is crappy due to the "at least 18 bytes".
That's ugly.  Can we please ensure that we at least adds a NULL
termination in polar_version[29] after version_get_string_full() ...
just to reduce the risk somewhat, in case it suddenly gets longer.  Then
it should (hopefully) be somewhat harder to get a buffer information leak.

Or maybe even slightly more hardened.  Put version_get_string_full()
into a much bigger temporary buffer, which then uses a strncpy() or
memcpy() into the polar_version[] buffer.  The strncpy()/memcpy() should
restrict it to 30 bytes, including NULL terminator.

I presume get_ssl_library_version() will be treated as a normal NULL
terminated string elsewhere in the code, also later on.


--=20
kind regards,

David Sommerseth


--5mV8qqEbC4jSFMp5hcrfupX6WQsox8erS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNMQq0ACgkQDC186MBRfropqgCfVKw0SxZMgsZVVF50bfFcdF4x
y/wAnRKsOu4YPfabXTRMKDhFR2RptveP
=zIw/
-----END PGP SIGNATURE-----

--5mV8qqEbC4jSFMp5hcrfupX6WQsox8erS--

