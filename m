Date: Tue, 26 Nov 2024 15:07:58 +0000
From: Alexander von Gluck <alex@...2837...>
Message-ID: <x3Qj4vCvBTU0A_xXvg4Pul9B4_iDcxCYze3HpOH_aZn6QVp5Jw3HORNWY62yaE3mkJW5wgGfX8Cf0iJAsHKrSPDoFMmEl3YZRrPjw8A63WE=@terarocket.io>
In-Reply-To: <Z0XcAeifefZ_Ko9c@...1296...>
References: <20241126142639.67446-1-alex@...2837...>
 <Z0XcAeifefZ_Ko9c@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha512;
 boundary="------4b85b0691d95e3b7203de6692d9638a60ac6a49db632f37d9a3db9fb8a7c914e";
 charset=utf-8
Subject: Re: [Openvpn-devel] [PATCH 1/2] Haiku: Introduce basic platform
 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net, Alexander von Gluck IV <kallisti5@...2838...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------4b85b0691d95e3b7203de6692d9638a60ac6a49db632f37d9a3db9fb8a7c914e
Content-Type: multipart/mixed;boundary=---------------------7f2e96e6d8ad54b62b54365ee36a1163

-----------------------7f2e96e6d8ad54b62b54365ee36a1163
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, November 26th, 2024 at 8:32 AM, Gert Doering <gert@...1296...> =
wrote:
>=20

> this is great, but alas...
> On Tue, Nov 26, 2024 at 02:26:52PM +0000, Alexander von Gluck via Openvpn=
-devel wrote:
>=20

> > +#el
> > if defined(TARGET_HAIKU)
>=20

> ...
>=20

> > +#if defined(TARGET_H
> > AIKU)
>
> ... your mail program is wrapping the lines in weird ways.
>=20

> Can you please send with git-send-email or push to our gerrit?

Weird, yeah.  I'm using git-send-email but through a proton mail bridge. So=
rry for the noise.
=20

> (https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation#Patchs=
ubmissionviaGerrit)

I'll submit via Gerrit with your recommendations.


> > + // Need to add ifconfig_remote_netmask since right now it is just NULL
> ... and while at it: no // comments, please.

Will fix this (and other review comments)

Thanks!

 -- Alex=

-----------------------7f2e96e6d8ad54b62b54365ee36a1163--

--------4b85b0691d95e3b7203de6692d9638a60ac6a49db632f37d9a3db9fb8a7c914e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmdF5D4JkAcdh4cOBuc9RRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmfBrUyJqHpRj9jGWRH7s2UaA32DKRipDo5sLjBv
0CjfKRYhBNXwyu+WFVVM5ynW9gcdh4cOBuc9AABD4gD/WDGcXI+5ByQ4mgPQ
rSPbk01OajdDjFt6HAZB8wwcIe4BAPI754/3WNjbhtOcprymdeNc9QUUe1OG
XTX7gk9pu8wO
=I5KS
-----END PGP SIGNATURE-----


--------4b85b0691d95e3b7203de6692d9638a60ac6a49db632f37d9a3db9fb8a7c914e--


