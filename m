Message-ID: <1509372566.3456.10.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Mon, 30 Oct 2017 14:09:26 +0000
In-Reply-To: <CAKuzo_guDg74RXr1OssXSXLQk=xFoCFwjDkvSgkEvtGcVQR_DQ@...278...>
References: <1509192147.3021.6.camel@...2316...>
 <20171029152418.GF958@...1296...>
 <1509293083.3116.22.camel@...2316...>
 <CAKuzo_guDg74RXr1OssXSXLQk=xFoCFwjDkvSgkEvtGcVQR_DQ@...278...>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Selva <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Sun, 2017-10-29 at 17:03 -0400, Selva wrote:
> Hi,
>=20
> On Sun, Oct 29, 2017 at 12:04 PM, James Bottomley <James.Bottomley@
> hansenpartnership.com> wrote:
>=20
> >=20
> > On Sun, 2017-10-29 at 16:24 +0100, Gert Doering wrote:
> > >=20
> > > Hi,
> > >=20
> > > On Sat, Oct 28, 2017 at 01:02:27PM +0100, James Bottomley wrote:
> > > >=20
> > > >=20
> > > > Engine keys are an openssl concept for a key file which can
> > > > only be
> > > > understood by an engine (usually because it's been wrapped by
> > > > the
> > > > engine itself).=C2=A0=C2=A0We use this for TPM engine keys, so you =
can
> > > > either
> > > > generate them within your TPM or wrap them from existing
> > > > private
> > > > keys.=C2=A0=C2=A0Once wrapped, the keys will only function in the T=
PM
> > > > that
> > > > generated them, so it means the VPN keys are tied to the
> > > > physical
> > > > platform, which is very useful.=C2=A0=C2=A0Engine keys have to be l=
oaded
> > > > via
> > > > a specific callback, so use this as a fallback in openvpn if an
> > > > engine is specified and if the PEM read of the private key
> > > > fails.
> > >=20
> > > How does this work in an OpenVPN context, as in, what do I have
> > > to do
> > > to make TPM keys work on client and server?
> >=20
> > If you have an existing private key, you convert it to a TPM key
> > using
> > the create_tpm[2]_key binary that comes with openssl_tpm[2]_engine.
> > =C2=A0The key you create is then locked to the TPM of the system you
> > create
> > it on (so save an offline copy of the non-TPM private key).
> >=20
> > >=20
> > > Do we need a new abstraction layer here somewhere, given that
> > > this
> > > seems to do something similar to using the windows crypto layer
> > > to
> > > access "private keys hidden in windows" (--cryptoapicert) and/or
> > > pkcs11?
> >=20
> > I don't really think so.=C2=A0=C2=A0The engine keys are a bit of an ope=
nssl
> > brainfart: there's no reason why PEM_read_bio_PrivateKey couldn't
> > actually check for engine keys and have the whole thing transparent
> > to
> > all applications, except that openssl didn't want to do it that
> > way.
> >=20
> > These keys are real files, so they're not like tokens, which is the
> > pkcs11 abstraction.
>=20
>=20
> That means, if one has the tpm_engine for openssl installed and
> TPM-wrapped keys, this should just work, is it? And, I suppose, the
> patch for openvpn is required only because openssl does not
> transparently use available engines.

Yes, and no. =C2=A0By the time openssl sees the load request, it has a bio,
rather than a file name, so there's a bit of additional glue openssl
would need for transparent engine support. =C2=A0I proposed a patch a while
ago to the openssl list, but it required an additional engine callback
and wasn't very enthusiastically received.

> If so, this looks like a easy way to provide TPM support to
> openssl users on some platforms. What about Windows? Is there
> an openssl TPM engine and tools to convert the key to a wrapped
> TSS blob on Windows?

No idea, I'm afraid. =C2=A0I would suspect not because windows isn't a great
consumer of openssl, so no-one on the windows development side probably
thought to write an openssl engine for their TPMs.

> I would like to see new features transparently supported on Windows
> as well without the need for too much extra code and associated
> maintenance burden. Our 'cryptoapicert' implementation is already in
> need of a major re-write to support TLS 1.2 and newer.

Well, windows supports engines (via dlls), so the engine code will work
for Windows, just not for my use case (their being no engine) and MS
CryptoAPI is one of the supported engines.

> From that point of view, instead of file-based wrapped keys, if a
> pkcs11 compatible API can be used to access TPM (that's possible
> isn't it?) TPM could be more widely usable without the need of any
> additional support in openssl or openvpn.

For TPM 1.2 it is possible to load the key into the TPM and then use
the TPM as a loaded token via PKCS11 but the usual key format is file
based not already present. =C2=A0For TPM 2, the design is different and the
key has to be loaded each time from offline storage (the file) because
the space in the TPM is so tiny, so treating it as a token is a bit
more difficult. =C2=A0Obviously with enough pressure, even a square peg will
fit in a round hole, it's just that it won't be elegant.

James


