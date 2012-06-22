Message-ID: <4FE44FFC.4060504@...1114...>
Date: Fri, 22 Jun 2012 12:59:08 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1340044749-10694-1-git-send-email-arne@...1227...>
	<1340044749-10694-4-git-send-email-arne@...1227...>
	<4FE445E1.5010309@...1114...>
In-Reply-To: <4FE445E1.5010309@...1114...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig94B3D45167C6983098576941"
Subject: Re: [Openvpn-devel] [PATCH 3/6] Remove ENABLE_INLINE_FILES
 conditionals,
 this code is always enabled and removing the #ifdef make the code a little
 bit clearer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig94B3D45167C6983098576941
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 22/06/12 12:16, David Sommerseth wrote:
> On 18/06/12 20:39, Arne Schwabe wrote:
>>
>> Signed-off-by: Arne Schwabe <arne@...1227...>
>> ---
>>  src/openvpn/common.h       |    2 --
>>  src/openvpn/crypto.c       |    6 ------
>>  src/openvpn/init.c         |    4 ----
>>  src/openvpn/misc.c         |    6 ------
>>  src/openvpn/options.c      |   24 ------------------------
>>  src/openvpn/options.h      |    6 ------
>>  src/openvpn/ssl_backend.h  |   36 ++++++++++--------------------------
>>  src/openvpn/ssl_openssl.c  |   39 +++++++------------------------------=
--
>>  src/openvpn/ssl_polarssl.c |   34 ++++++----------------------------
>>  src/openvpn/syshead.h      |    8 --------
>>  10 files changed, 23 insertions(+), 142 deletions(-)
>=20
> Applied to master.

The ACK for this patch can be found here:
<http://mid.gmane.org/4FE44882.3090706@...515...>


kind regards,

David Sommerseth


> commit 31f83cc7ce798c4e355480532f77640b78d74695
> Author: Arne Schwabe <arne@...1227...>
> Date:   Mon Jun 18 20:39:06 2012 +0200
>=20
>     Remove ENABLE_INLINE_FILES conditionals
>=20=20=20=20=20
>     This code is always enabled and removing the #ifdef make the code a l=
ittle bit clearer
>=20=20=20=20=20
>     Signed-off-by: Arne Schwabe <arne@...1227...>
>     Acked-by: James Yonan <james@...515...>
>     Message-Id: 1340044749-10694-4-git-send-email-arne@...1227...
>     URL: http://article.gmane.org/gmane.network.openvpn.devel/6746
>     Signed-off-by: David Sommerseth <davids@...1347...>
>=20
>=20
> kind regards,
>=20
> David Sommerseth
>=20
>=20
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and=20
> threat landscape has changed and how IT managers can respond. Discussions=
=20
> will include endpoint security, mobile security and the latest in malware=
=20
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



--------------enig94B3D45167C6983098576941
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/kT/wACgkQDC186MBRfrqvXwCggm927MJcah5iO0sXBdjns1md
+9YAnii5ms5PCPZYcN1cVlJHsO3E3eC9
=35Hq
-----END PGP SIGNATURE-----

--------------enig94B3D45167C6983098576941--

