Message-ID: <1509293083.3116.22.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Sun, 29 Oct 2017 16:04:43 +0000
In-Reply-To: <20171029152418.GF958@...1296...>
References: <1509192147.3021.6.camel@...2316...>
 <20171029152418.GF958@...1296...>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-wL7oKA7siDyffgtpukyv"
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 0/1] add engine keys keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--=-wL7oKA7siDyffgtpukyv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2017-10-29 at 16:24 +0100, Gert Doering wrote:
> Hi,
>=20
> On Sat, Oct 28, 2017 at 01:02:27PM +0100, James Bottomley wrote:
> >=20
> > Engine keys are an openssl concept for a key file which can only be
> > understood by an engine (usually because it's been wrapped by the
> > engine itself). =C2=A0We use this for TPM engine keys, so you can either
> > generate them within your TPM or wrap them from existing private
> > keys. =C2=A0Once wrapped, the keys will only function in the TPM that
> > generated them, so it means the VPN keys are tied to the physical
> > platform, which is very useful. =C2=A0Engine keys have to be loaded via
> > a specific callback, so use this as a fallback in openvpn if an
> > engine is specified and if the PEM read of the private key fails.
>=20
> How does this work in an OpenVPN context, as in, what do I have to do
> to make TPM keys work on client and server?

If you have an existing private key, you convert it to a TPM key using
the create_tpm[2]_key binary that comes with openssl_tpm[2]_engine.
=C2=A0The key you create is then locked to the TPM of the system you create
it on (so save an offline copy of the non-TPM private key).

> Do we need a new abstraction layer here somewhere, given that this=C2=A0
> seems to do something similar to using the windows crypto layer to
> access "private keys hidden in windows" (--cryptoapicert) and/or
> pkcs11?

I don't really think so. =C2=A0The engine keys are a bit of an openssl
brainfart: there's no reason why PEM_read_bio_PrivateKey couldn't
actually check for engine keys and have the whole thing transparent to
all applications, except that openssl didn't want to do it that way.

These keys are real files, so they're not like tokens, which is the
pkcs11 abstraction.

> I see more #ifdef in the code and this is usually a sign of "it will
> increase testing requirement, and we can't even test the abstraction
> if none of us has the hardware".
>=20
> But I leave the more specific discussion to Steffan and Antonio :-)

Testing is possible. =C2=A0If you look at the build repository of
openssl_tpm2_engine:

https://build.opensuse.org/project/show/home:jejb1:TPM

You'll see there are tests in there that fire up a software tpm to run.
=C2=A0However, the software TPM is a bit capricious and certainly only runs
on openssl 1.0.2, so I can't run the tests on Fedora 26 for instance
without rewriting the swtpm2 package.

James

--=-wL7oKA7siDyffgtpukyv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJZ9fwbAAoJEAVr7HOZEZN4CAkQAIBjEXFR6YHOcmqisPPDBuhf
ISxE2cIDjWF3ZSXaK73TadehQZwGOdoYuAN6y+6J8dG39vyb6zX4ieUGG3QS5wWt
7h3++LLo59m3dqaXMZ7vlFThSDZBdda1ZoSvpXq4qW2+YlEt4UhxrF5RcxYN1oIY
VmeVS6CAYr3VDEphWoHJ3yrsJ4Ucz9+0oxXa3NQj7aQwHDC0+IWTA4h0wVO+HGRg
QiJSM6RrPG7mYaFEYhfD0m2i3W4m0PYMLJTt4x6nLzKTUKCPe8LngXQu9+ijiFXK
P54XVAPdVREP1g6w9CoWnd7X6yXshS5hqekj0R+ATUTwllKvtBQiRrX2ROGqejzI
iE3yIZza1w9G9iIk5zgzjUrKHVBJkDlxiwjzfR+O5dK4eC4Jge3UGyQoYlpOj759
en5En5hcTQwGdQmzRErab7934GYe3ew4r0xl9TRtQXhPeXhhU9Xa3/iwVhtE2atM
QM/VQFLy5OZUf05Uf4QOq0NfwOSUekro1MyNjTZtrVShuXqdwT3+SMjIcvqYvF2/
VaM6i3wzGtyZZo/59NoqKDdtn+3MdayacgbbhKqjXR4aV2EVfSykTnKQNgM18qn4
pBMumImCx3oqTCEaXw5/hot7PJbF2PszVeaFqIHTeY++iuA5toBaQ7SdZ/nUEtMr
bB9juqv2xheEedJexClW
=G57w
-----END PGP SIGNATURE-----

--=-wL7oKA7siDyffgtpukyv--


