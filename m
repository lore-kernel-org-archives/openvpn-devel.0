References: <8eebd206-6742-712d-2097-ee196bbb025c@...2181...>
 <20180722100645.5813-1-steffan@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <e98c6d38-f453-3f77-e31d-b9dbb2cf064a@...2181...>
Date: Sun, 22 Jul 2018 20:01:29 +0800
MIME-Version: 1.0
In-Reply-To: <20180722100645.5813-1-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mVIe1QfVj0CCdhKMDuoFFMFaDXNQLUmMG"
Subject: Re: [Openvpn-devel] [PATCH v3 2/9] Add crypto_pem_{encode, decode}()
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
--mVIe1QfVj0CCdhKMDuoFFMFaDXNQLUmMG
Content-Type: multipart/mixed; boundary="oGrFnjjGO69pHY2VlAwungzHKOeWd7vAU";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <e98c6d38-f453-3f77-e31d-b9dbb2cf064a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3 2/9] Add crypto_pem_{encode,decode}()
References: <8eebd206-6742-712d-2097-ee196bbb025c@...2181...>
 <20180722100645.5813-1-steffan@...1856...>
In-Reply-To: <20180722100645.5813-1-steffan@...1856...>

--oGrFnjjGO69pHY2VlAwungzHKOeWd7vAU
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 22/07/18 18:06, Steffan Karger wrote:
> From: Steffan Karger <steffan.karger@...1435...>
>=20
> Needed for tls-crypt-v2, but isolated enough to be reviewed as a separate
> patch.
>=20
> The encode API allocates memory, because it fits our typical gc-oriented
> code pattern and the caller does not have to do multiple calls or
> calculations to determine the required destination buffer size.
>=20
> The decode API does not allocate memory, because the required destination
> buffer is always smaller than the input buffer (so is easy to manage by
> the caller) and does not force the caller to use the heap.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>

Acked-by: Antonio Quartulli <antonio@...515...>

--=20
Antonio Quartulli


--oGrFnjjGO69pHY2VlAwungzHKOeWd7vAU--

--mVIe1QfVj0CCdhKMDuoFFMFaDXNQLUmMG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAltUchkACgkQB6U8WA7y
zXTS5A/+OTkMLBTKgPzCgrd4aBVZD1tji14a5jpVTpUqJVKUNDgZLJ2Ath2kw6Mz
Kjo//nM9Av4KU9UEUFp/oVXmz+2DrvJGvqtCtdoCC5fpyw6NrrqDpVZihGd+2wax
EU07T54nOFq9Pbwhw57eL4tUrqKUYmRACnmVjWFmPbrueZSnO0XQa5DoSc+bTSmo
gYwSXgCVZDKzHoavCAzTnQJXngZHBXubf1NqPWqn/10isE57AaIwahIgtLNOo+oA
OmX6gGfRqqDJkeqv+0l3XlKwCoAgnmMMVO99efRUz39zncsLk4R4AAh0UAnhfV3E
UAXSR1aw3XM/3U5IHDDY1czS6OBcaMmGUenntMKDy19yx1fTK15BK9Hn4xuCL6xA
/e7XVUTMj06qkJZ5JwccvZyePUV5IVRPKbhV7sQ8Yu2PC7jHJdma+o8BF1laHe2y
N48d1sZpla7WdetsutrEPxYH9OJpfAFS+9YSNyn1PNy17byGRz0Wkq+CLZShNFkY
cq8+QYn2eqLHN1/C7iufZcGH6tmbN2oMP0bbCMVk2etCIIrqqgpB9hT8Ej0aXrY2
eWq8UEhcput6N8nxdbwAaLYXE7lZx4HyF2oq9jmv5u4ZMxKotnj9xgaL0SATPwSS
iu/GD8CkQwkaczT2yxz06QSFEUSYMGPJ6569gYOsG06Z3w+VucM=
=I6Cu
-----END PGP SIGNATURE-----

--mVIe1QfVj0CCdhKMDuoFFMFaDXNQLUmMG--

