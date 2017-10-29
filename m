References: <1509192147.3021.6.camel@...2316...>
 <20171029152418.GF958@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <aa266135-ea01-9f8e-cc8f-159ca195f18d@...1227...>
Date: Sun, 29 Oct 2017 17:17:21 +0100
MIME-Version: 1.0
In-Reply-To: <20171029152418.GF958@...1296...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH 0/1] add engine keys keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 29.10.17 um 16:24 schrieb Gert Doering:
> Hi,
>=20
> On Sat, Oct 28, 2017 at 01:02:27PM +0100, James Bottomley wrote:
>> Engine keys are an openssl concept for a key file which can only be
>> understood by an engine (usually because it's been wrapped by the
>> engine itself). =A0We use this for TPM engine keys, so you can either
>> generate them within your TPM or wrap them from existing private keys.
>> =A0Once wrapped, the keys will only function in the TPM that generated
>> them, so it means the VPN keys are tied to the physical platform, which
>> is very useful. =A0Engine keys have to be loaded via a specific callback,
>> so use this as a fallback in openvpn if an engine is specified and if
>> the PEM read of the private key fails.
>=20
> How does this work in an OpenVPN context, as in, what do I have to do
> to make TPM keys work on client and server?
>=20
> Do we need a new abstraction layer here somewhere, given that this=20
> seems to do something similar to using the windows crypto layer to
> access "private keys hidden in windows" (--cryptoapicert) and/or
> pkcs11?
>=20
> I see more #ifdef in the code and this is usually a sign of "it will
> increase testing requirement, and we can't even test the abstraction if
> none of us has the hardware".
>=20
> But I leave the more specific discussion to Steffan and Antonio :-)

As a sidenote, OpenVPN itself implements its own "engine" (with the
older pre engine RSA_method) to allow management-external-keys.

Unifying that would be nice but is probably a lot of work, especially
since OpenVPN engine is not so straightforward to implement.

Arne

