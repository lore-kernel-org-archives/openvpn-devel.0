References: <5f8d8043-5725-f535-e623-da042984196b@...2181...>
 <20171112163636.17434-1-steffan@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <145b8af8-b33c-9950-12a9-b45e0b83d59e@...2181...>
Date: Mon, 13 Nov 2017 01:44:00 +0800
MIME-Version: 1.0
In-Reply-To: <20171112163636.17434-1-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nfXXFwi8FmKutGM3nBOqkjK7fjriucawN"
Subject: Re: [Openvpn-devel] [PATCH v6] Add --tls-cert-profile option for
 mbedtls builds
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
--nfXXFwi8FmKutGM3nBOqkjK7fjriucawN
Content-Type: multipart/mixed; boundary="QJBgpgACg8War1fVNkjvxRKQBarJe7lfA";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <145b8af8-b33c-9950-12a9-b45e0b83d59e@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v6] Add --tls-cert-profile option for
 mbedtls builds
References: <5f8d8043-5725-f535-e623-da042984196b@...2181...>
 <20171112163636.17434-1-steffan@...1856...>
In-Reply-To: <20171112163636.17434-1-steffan@...1856...>

--QJBgpgACg8War1fVNkjvxRKQBarJe7lfA
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 13/11/17 00:36, Steffan Karger wrote:
> From: Steffan Karger <steffan.karger@...1435...>
>=20
> This allows the user to specify what certificate crypto algorithms to
> support.  The supported profiles are 'preferred', 'legacy' (default) and
> 'suiteb', as discussed in <84590a17-1c48-9df2-c48e-4160750b2e33@...1783...=
.>
> (https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg1421=
4.html).
>=20
> This fully implements the feature for mbed TLS builds, because for mbed it
> is both more easy to implement and the most relevant because mbed TLS 2+
> is by default somewhat restrictive by requiring 2048-bit+ for RSA keys.
>=20
> For OpenSSL, this implements an approximation based on security levels, as
> discussed at the hackathon in Karlsruhe.
>=20
> This patch uses 'legacy' as the default profile following discussion on
> the openvpn-devel mailing list.  This way this patch can be applied to
> both the release/2.4 and master branches.  I'll send a follow-up patch for
> the master branch to change the default to 'preferred' later.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>

Code looks good, but the commit subject is now wrong, because this patch
is actually implementing cert profiles for both mbedTLS and OpenSSL.


So I ACK it, but the committer should fix the subject for sake of clarity.

I have tested the patch with mbedTLS and with OpenSSL 1.0, but not with
OpenSSL 1.1.


Acked-by: Antonio Quartulli <a@...2181...>



--=20
Antonio Quartulli


--QJBgpgACg8War1fVNkjvxRKQBarJe7lfA--

--nfXXFwi8FmKutGM3nBOqkjK7fjriucawN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAloIiGAACgkQB6U8WA7y
zXRWEQ//XyOw6h2JwTMhpNOZeAzTCvvfTdrANcX8vBvDB27BAWVapte38GSNobBe
UzdXaG0aKojC6tq1VI+C/RpxZMZVvWMQTizaPkewDVRGREZkbDm+7i/Op7V5b2rt
80abm5P3Db3jotZjPY6XubyGm8hAxysPSMTZdMJNi6udq2HjbpIBFvDqZNTgQkxr
UOx0W3eRoMf6MbUUo9lRLGwVLuQVMbV43Gif0OQC4RYYjLtbRKDfF2cMMj9wlPkn
OQu51Ax9voTi29r1Vq1+X1McsdTHQBPxYG8FNk7llK+uZ3ZN0syL/mEWdqAtuv3h
04xsrkzHlb8wn1eZ/OwSm33yRwbBjwvgpzfYbs4C5t3XxA5og72iQiY24HqWZsAZ
jDF3TCeL7xunSz3/wk/CGWWszFbu1KySFN8NUjcekbXIhixyhXF5eLTonEi2EBbR
Dr08Dt0t1M2oJpb8TfTMRp9ql/tWoaDnmMVdUSEhyrorfMsfUJVm58vFLi92S/eF
CUNvTLO4q+907CvR5TOIMhO6TmmZ7Dw8SN2Bd0YfZkUQ9EmlXczTWCuAAtcrycck
AQEC5eHmBiRQxw+4aHtzeXZXyX608xJT3kZp5G6hzjcA+/BRBvGfRsbbMAgB/YA/
IjQvg0cP4hgveMrFXrU5xfz4TRFIqbuCdvILVfhUEzDZT3wXAV4=
=cPG0
-----END PGP SIGNATURE-----

--nfXXFwi8FmKutGM3nBOqkjK7fjriucawN--

