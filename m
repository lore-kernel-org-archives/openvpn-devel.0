References: <003bd3ed-9a64-3e77-cd06-2212b82a6165@...515...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <6a8f8780-a49c-9d1f-30ac-d3b804e9476b@...1435...>
Date: Thu, 23 Feb 2017 09:22:48 +0100
MIME-Version: 1.0
In-Reply-To: <003bd3ed-9a64-3e77-cd06-2212b82a6165@...515...>
Subject: Re: [Openvpn-devel] Should we use mbedTLS certificate profiles?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi James,

On 22-02-17 19:48, James Yonan wrote:
> mbedTLS 2 has a new feature that allows rejection of certificates if the=
=20
> key size is too small or the signing hash is weak.
>=20
> The feature is controlled via struct mbedtls_x509_crt_profile.
>=20
> For example, you could specify that certificates must be at least 2048=20
> bits and use a SHA-2 signing alg.
>=20
> Wondering if we should enable this via an option, or tie it into the=20
> existing tls-version-min.
>=20
> The granular approach would be to have specific options for each limit,=20
> such as ssl-min-key-size, ssl-require-sha2
>=20
> The bundled approach would be to take an existing option such as=20
> tls-version-min and add additional constraints onto it.  For example, if=
=20
> tls-version-min is 1.2 or higher, then also require minimum key size to=20
> be 2048 and certificate signing hash to be SHA-2.

OpenVPN 2.4 currently just uses mbed TLS' default profile, and we tell
people to use stronger keys (RSA 2048+ / ECDSA) or a stronger hash
function (SHA1+) if that causes trouble.

If we are going to make this configurable, I think we should separate it
from tls-version-min.  The main use case I see for using a lower
security setting would be an out-of-the-admins-control CA, or something
like (old) smart cards that don't support RSA-2048.  I wouldn't want to
block people from enforcing TLS 1.2, because their smart card is crappy.

So I think we'll have to add the relevant --tls-rsa-key-size-min,
--tls-curves (could replace --ecdh-curves), --tls-digests options.  If
we want to make it configurable, that is.

-Steffan

