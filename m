References: <20170907012225.21661-1-davids@...515...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <dd61a1ce-2301-e3bc-a57c-2fbb3d072a00@...2181...>
Date: Thu, 7 Sep 2017 09:55:54 +0800
MIME-Version: 1.0
In-Reply-To: <20170907012225.21661-1-davids@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Mf3uGX9Ehem05UxKFF0vjGNfvXHk0OR6r"
Subject: Re: [Openvpn-devel] [PATCH] lz4: Changing how LZ4 library handling
 is done
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Mf3uGX9Ehem05UxKFF0vjGNfvXHk0OR6r
Content-Type: multipart/mixed; boundary="ll721AcktSuLad1jqgosf2tRf8mnBepXs";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net
Message-ID: <dd61a1ce-2301-e3bc-a57c-2fbb3d072a00@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] lz4: Changing how LZ4 library handling is
 done
References: <20170907012225.21661-1-davids@...515...>
In-Reply-To: <20170907012225.21661-1-davids@...515...>

--ll721AcktSuLad1jqgosf2tRf8mnBepXs
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 07/09/17 09:22, David Sommerseth wrote:
> This change will expect the system to have LZ4 libraries and headers
> installed by default.  We still carry a bundled LZ4 library, which
> must now be explicitly enabled through providing --enable-bundled-lz4
> to ./configure.  Otherwise, as before, --disable-lz4 will completely
> remove any LZ4 support.
>=20
> Also improve the autoconf code slightly, to use AS_HELP_STRING() where
> needed and wrap some strings/values with [] where it was missing in
> the LZ4 segment of ./confiugre.ac.
>=20
> Signed-off-by: David Sommerseth <davids@...515...>

ACK.

Imho, this is a very good step towards moving the bundled lib apart.
The bundled lib is still there, so still usable by the maintainer who
wants that, but it basically becomes legacy.

Cheers,


--=20
Antonio Quartulli


--ll721AcktSuLad1jqgosf2tRf8mnBepXs--

--Mf3uGX9Ehem05UxKFF0vjGNfvXHk0OR6r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAlmwpy4ACgkQ0+HICM1s
oFDv4g//aRpzj+hDFDQq81VZ9rGZkKtAKrpu9A0NPW9OkBLL3bAHatrGWGvypznF
MLfQKgKfPcI0f+SDw04M5hV/YuH9chiStGozEFseegIMoLqPxHwBlLZ5e2/3ne6o
JRc4IQfB9dlFuzpYBrqqgWzxDMBV/YaNBK/ciSUgClyiveNqqToLRT/pER1O+adN
c+7xbdOnBBdAwNyRhI9nSX/ip1Es5GL26vi/ORO1fXUH6vNxvCenIZUUWeOIurge
mQ4TO/RisNdGfpffypVwZrtHUHAGnAqLQWQ1l4NUqitNiPTgzNYrp9oTDaUmDcOR
GzNNAZ/h/DZXPKILw6XA351zwRsUniyjeRq2bjG8N4esy6H87x/AAUFvsnUnkgyp
QZwPYGurqbtjubUDEvPUZ20rKmFyD3687sxdaPL3XMFdDBh1WHPs6dT7Q6cBKt/W
PHEQLl5v2fdQFESGvqKP81+lOOOcKdfcknsTK5Yto5QpAOysAHeuhcXsPisDJeY8
ptpz7Prg7qlCh6/FVU+c10XtY4OedDb2kSpLG2cyR47c9hsAnQdf0031HuhpWsMl
P+QwyIEjj0rutisj5JrQPygpY2ub0frVRD61ZSy7LcRXQsQV+Zzt9tzJ/v6+fRU2
cu/t+kKhcoLU9F+Y/ECoBph9g2GEETrzYvAVtH7tiTnBCnr5sGc=
=8Cn0
-----END PGP SIGNATURE-----

--Mf3uGX9Ehem05UxKFF0vjGNfvXHk0OR6r--

