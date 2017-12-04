Date: Mon, 4 Dec 2017 19:45:25 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171204184525.GY69387@...1296...>
References: <20171202134541.7688-1-a@...2181...>
 <20171202134541.7688-5-a@...2181...>
 <ead35daf-765c-9e74-2cac-d8f98e6d0c85@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="9sSKoi6Rw660DLir"
Content-Disposition: inline
In-Reply-To: <ead35daf-765c-9e74-2cac-d8f98e6d0c85@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 5/7] Remove CIPHER_ENABLED
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--9sSKoi6Rw660DLir
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Dec 03, 2017 at 03:17:51PM +0100, Steffan Karger wrote:
> On 02-12-17 14:45, Antonio Quartulli wrote:
> > Now that ENABLE_CRYPTO has been removed, CIPHER_ENABLED is basically
> > a useless shortcut which does not really help the readability of the
> > code.

Call me silly, but CIPHER_ENABLED has nothing to do with ENABLE_CRYPTO,
but more with "--cipher none", no?

So at least the commit message is misleading...

> >       * Set adjustment factor for buffer alignment when no
> >       * cipher is used.
> >       */
> > -    if (!CIPHER_ENABLED(c))
> > +    if (!c->c1.ks.key_type.cipher)

... and I don't really find the second one more easily understandable
than the first one...

gert
--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--9sSKoi6Rw660DLir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaJZfFAAoJEB2Cnv7KVigSdpkL/jYRsP3IV3YEju5I2kXg9qno
2I3PYnZpL6PrWj4chf/aoI9udGGiEqgmAgGW0MCQjE1hDGeBzrAjV16FW6/KfO4p
+BRqpBbAJ6UnmBj4mZI/O02ntmMXvTXIhidBo4kiMsArXPd5YxKkG+/Bd4M9FQ2U
cqaKCHgenW2ZPZh69s+7OVowrDkGeLZxcZ9VTIWWRDKiG18sma/hoZhrxWizfLoB
n5cvWIFPOpqawMaLTJv+RH3PG6SSXm4hA743Rj7NmTGsMKjnWQ5RCsLJP9nmIchZ
ozQQwHP0z6h+z/x2WJQYHlSuvLkLMDnozlMPLMutuEmIX8GxSofrQ5cioSUuBkqV
0eJWma1pRXcMb7ejeugcc+NHeLOsCcteqHGpqG1tDjXhUltglOzmbKw703Wu0gFE
AtO2FkV3MdR9XThU1lZjYo6EJZAoDrESBg/3I6AOIy/nEFTpNcioOvQZB5KODpyo
tebLZ2rwa8Ri58KA3ZItJHQ5hqsIwrzM6oxDxdv3Cw==
=jl3t
-----END PGP SIGNATURE-----

--9sSKoi6Rw660DLir--

