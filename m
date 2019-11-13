Date: Wed, 13 Nov 2019 10:18:44 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20191113091844.GA40538@...1296...>
References: <20191113085854.6016-1-tom.ty89@...277...>
 <CAGnHSEnZraNv72SvtfdiipptQ4ESHvOSBn87vJREdh6trCb7ng@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="KdsnslqZnlo4hNtV"
Content-Disposition: inline
In-Reply-To: <CAGnHSEnZraNv72SvtfdiipptQ4ESHvOSBn87vJREdh6trCb7ng@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix server directive for /31 subnet
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tom Yan <tom.ty89@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--KdsnslqZnlo4hNtV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 13, 2019 at 05:13:09PM +0800, Tom Yan wrote:
> For the record, as I don't see why `o->ifconfig_pool_end` was
> `(o->server_network | ~o->server_netmask) - 2` for tun + subnet while
> it was `(o->server_network | ~o->server_netmask) - 1` for tap, I
> assume the former is a typo.

It might be related to the way the windows tap6 driver always needs a=20
gateway address even in tun mode (and uses the last address from the
subnet for this).  There's very few typos in OpenVPN code regarding
*this* type of math, and way more "just funny platforms and old lore".

> By the way, why does `o->ifconfig_pool_netmask` need to be set even
> when `nopool` is set?

Not sure.  This code has been rewritten a number of times over the
years, so maybe the assignment slipped outside of an if() block...

Things like this can (and should) all be fixed, but please do not lump=20
them together with a functional change in one big patch.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--KdsnslqZnlo4hNtV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdy8pzAAoJEB2Cnv7KVigSGIQL/iMw+IeNISMQs8dzT++qz230
Z4lxpcu0a5XAHoqR9ltVyE9y3Ekqeg9JBwmhRMx2NEa/8+9l2ivXUdCdYWHVPDqu
z2eTEpJkcVVaHhkbw4mmYTDGymU0TuNIAPeZN+PbpHwJUHM3+qtjDK1TXWIFDaDR
mLM1FDbSgPDwqBXUZyqn4vHbs+hyeiUF7vCgwV/nPbg8siVIJsaG4jWO0Mea3bMY
5ukEt663UDidl/JjIPV0hAiWhCB2EYdsD6dvq4XN16/9g5XvlKBwRSdcAY0ddyOD
1TsyOdRMUiOG0ja/z6lfH2HvSEN0dqeVVBtvZpR4VTl/VoMqDLBvt8rsOX3SrjNb
/cd3iHv6HcVB5jnrJCXQvWnONIIXC0/mQWC0fifKRRaEFGRvGJa2ERp2bBG0lPHy
c5pANqzIKjk2+eRICzy+kKodgrWN3WP0yNFxhf8ObKUPdz0do0Ewxz1TeJ7CWx8U
K5O5sXhvtwu7tRXviO62IMojo87V6xq7e5YcqCrkXw==
=2EAo
-----END PGP SIGNATURE-----

--KdsnslqZnlo4hNtV--

