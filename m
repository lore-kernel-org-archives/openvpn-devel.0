References: <20180527190057.3488-1-chipitsine@...277...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <77f85744-4ae0-e8e5-148e-e327130adcc3@...2181...>
Date: Sun, 24 Jun 2018 11:28:23 +0800
MIME-Version: 1.0
In-Reply-To: <20180527190057.3488-1-chipitsine@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dIyZnTPdX5WInWj1OvhM6txsQQYLPc9IE"
Subject: Re: [Openvpn-devel] [PATCH v2] travis-ci: cleanup, refactor,
 upgrade ssl libraries
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Ilya Shipitsin <chipitsine@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dIyZnTPdX5WInWj1OvhM6txsQQYLPc9IE
Content-Type: multipart/mixed; boundary="xdvAtK9fHIZFsmf1ZqvmoG5uZDuOa3UjH";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Ilya Shipitsin <chipitsine@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <77f85744-4ae0-e8e5-148e-e327130adcc3@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] travis-ci: cleanup, refactor, upgrade
 ssl libraries
References: <20180527190057.3488-1-chipitsine@...277...>
In-Reply-To: <20180527190057.3488-1-chipitsine@...277...>

--xdvAtK9fHIZFsmf1ZqvmoG5uZDuOa3UjH
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 28/05/18 03:00, Ilya Shipitsin wrote:
> -    - MBEDTLS_VERSION=3D"2.5.1"
> +    - MBEDTLS_VERSION=3D"2.8.0"

I know travis-ci currently is caching both the downloaded tarball and
the built library, therefore my question: what will happen to
mbedtls-2.5.1-*? Will that be wiped after some time? Or do we need to
wipe the cache manually?

Cheers,

--=20
Antonio Quartulli


--xdvAtK9fHIZFsmf1ZqvmoG5uZDuOa3UjH--

--dIyZnTPdX5WInWj1OvhM6txsQQYLPc9IE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlsvD9cACgkQB6U8WA7y
zXSaSBAAgSuPK9sBLf5weIdgLOyLRW4CBH2TbmYMTAILJf9HCeC8r2RCsAVkv49w
zi53RBFe0a9ZP7XUYrDyd2Kzj4AvTaS7nKBjfNw98i4aCZ4fqeTWwb5vWXgIV3VD
FNXJjw1aFyNiRL3KN7Tu0redcCAwmWN69B4MJIyR0j04gGKEHmKAXvZrxsAjCXgW
njzkRkDNpLwEmWbXD6hFU0b0t68zBXHqvN+W3DkZ5u4x06G2vjz/siry7EZzHuo/
BIWyjgds5ofSIUZDsmTIdY5ScR7wEwVy+8RkNa40P5cr64PBdkw5uOScNsTBqeeg
XUUmvyQNTNYKVZ0B1ficVs7S9rFeocM87fZixq7VZ/Lkl7Sul/ug7YR29EM4Eh2J
4Cu3dozdFqd61ehg+VEAEcHwscFUTuo4gb6fWbRrD0weMLQDzEPDyv0PQfN4ESQ/
k4Ijtb2YYom+VzK/UxTBBU2HkQcB3qEOhlKMCSoi9kP5NW1oHGJ7XXdgaQbY2ZzR
3cMiycs+VO9jJntSNovXzrLv4R6UUp4xc4rO7/t+/Y/zelTsxv1AKgnoN38m0M59
epBtgCEak7HLqj41tHbbZt8oc4bzKIESijfDTBehkniSyTl7dVgKWZYpGkwgZaLd
vnYXQ/VoCjyHEl1zeakigdYokP6URbAt1XY0oxBr8ZZcBZ9vdn8=
=rPKI
-----END PGP SIGNATURE-----

--dIyZnTPdX5WInWj1OvhM6txsQQYLPc9IE--

