References: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
 <20171101220342.14648-1-steffan@...1856...>
 <20171101220342.14648-4-steffan@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <ebc9ae16-769b-1ea2-65eb-039fbfa9f1b5@...2181...>
Date: Thu, 9 Nov 2017 11:17:52 +0800
MIME-Version: 1.0
In-Reply-To: <20171101220342.14648-4-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="psNq21LsNsrXdb8qx1KGNmmXeJW1x73rE"
Subject: Re: [Openvpn-devel] [PATCH 3/4 v2] Don't throw fatal errors from
 create_temp_file()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--psNq21LsNsrXdb8qx1KGNmmXeJW1x73rE
Content-Type: multipart/mixed; boundary="4LB3gEo56nCGCcNN7uAnFuo9QNr7QOn41";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <ebc9ae16-769b-1ea2-65eb-039fbfa9f1b5@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 3/4 v2] Don't throw fatal errors from
 create_temp_file()
References: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
 <20171101220342.14648-1-steffan@...1856...>
 <20171101220342.14648-4-steffan@...1856...>
In-Reply-To: <20171101220342.14648-4-steffan@...1856...>

--4LB3gEo56nCGCcNN7uAnFuo9QNr7QOn41
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 02/11/17 06:03, Steffan Karger wrote:
> From: Steffan Karger <steffan.karger@...1435...>
>=20
> This function is called in response to connecting clients, and can fail
> when I/O fails for some (possibly temporary) reason.  In such cases we
> should not exit the process, but just reject the connecting client.
>=20
> This commit changes the function to actually return NULL on errors, and
> (where needed) changes the callers to check for and handle errors.
>=20
> Since the tls-crypt-v2 metadata code also calls create_temp_file() when
> clients connect, I consider this a prerequisite for tls-crypt-v2.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>

Acked-by: Antonio Quartulli <a@...2181...>

--=20
Antonio Quartulli


--4LB3gEo56nCGCcNN7uAnFuo9QNr7QOn41--

--psNq21LsNsrXdb8qx1KGNmmXeJW1x73rE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAloDyOAACgkQB6U8WA7y
zXRmoQ//YqeE910S9xq5pS7boW4vJ4RYNjK0KqNvLsjxMjFjd/bhIGZxzV8s6imR
+vMBHGhemcNnMCaZ7RGI3uS1g47bF9jmrvKmmAguiSciqf68PFU5coJGGmUScaHc
6ijNA6sO6F3x/H0C4n7O0qENATBMkw5ACv8+vSRXD6s4EWXxdFkM1GjMVVsVdQ/L
yKEoaY2pkRzNG7+qhOqT+Dw1XmKis0kfk1UFlHQdSpO9nEVoK1ehW66IlXQeUD3u
DBT7HZlnC35kKr0eH0zrsODAIrpYsOPDCR6WH5XfMPIlNviU5I7jrOzOU8TVqCKR
ksJK898xRR2cApaNqXPdLVf6x69aDmTYSALrZg+jFr9EFMUs4ijdGTpdJfdOVecO
sqqykpERan21tOKvdtk5U6AUqPVQe7n2dYYzIqW8ugme6N0QwtyvvWW6niN8j2XU
1TBPP1ipmce0Zhdn6F01IhyUVcB52nbXJhTTrCxjS5AnMer+Q5/j3dR+vcvttHYx
9E4CywDyZyUSXFoZ4SqyQ5uSestyQkVjyupfFcxWxCrENy6ThCSxryWDa6sz3FuT
yfw/upH6wrIHCCU50qgNHlD+/DLMurNEcCFW38TCkQ69MTcm02cL3HNNqMNQPhLa
Qgw09q4sGfPCLrpc/f4D4RqxGupPVnsy4DG66Dotk9x7yEsZ7O8=
=r+sI
-----END PGP SIGNATURE-----

--psNq21LsNsrXdb8qx1KGNmmXeJW1x73rE--

