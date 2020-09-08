References: <011701d6858cyandex-team.ru>
 <20200908123625.23179-1-themiron@...2010...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <33df2e45-ebd9-fbd5-1fac-e43c4d9090ca@...2080...>
Date: Tue, 8 Sep 2020 15:08:16 +0200
MIME-Version: 1.0
In-Reply-To: <20200908123625.23179-1-themiron@...2010...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="z9t9ozf2es34tJ6I8ubqk275gxt3sbHZW"
Subject: Re: [Openvpn-devel] [PATCH v3] Fix best gateway selection over
 netlink
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vladislav Grishenko <themiron@...2010...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--z9t9ozf2es34tJ6I8ubqk275gxt3sbHZW
Content-Type: multipart/mixed; boundary="k6eX5PIqrxdYydgUkWUUE8vvAccwU4X11";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Vladislav Grishenko <themiron@...2010...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <33df2e45-ebd9-fbd5-1fac-e43c4d9090ca@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v3] Fix best gateway selection over
 netlink
References: <011701d6858cyandex-team.ru>
 <20200908123625.23179-1-themiron@...2010...>
In-Reply-To: <20200908123625.23179-1-themiron@...2010...>

--k6eX5PIqrxdYydgUkWUUE8vvAccwU4X11
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 08/09/2020 14:36, Vladislav Grishenko wrote:
> On kernels earlier than 2.6.38 default routes are the last ones,
> so arbitrary host/net route w/o gateway is likely be returned as
> first, causing gateway to be invalid or empty.
> After refactoring in 2.6.38 kernel default routes are on top, so
> the problem with older kernels was hidden.

I haven't paid too much attention here, but I don't think I've seen this po=
int
being brought up.  But do we really care about such old kernels at all?

AFAIK, RHEL-6 (which goes EOL in November this year and which is not planned
to be supported in OpenVPN 2.5+) is the only distro carrying such an old
kernel release (2.6.32 baseline).  Even an internal OpenWRT 19.07 box of mi=
ne
(which should be upgraded, I know!) ships with 4.14.  Unless I'm completely
clueless (which is a possibility), 2.4 and 2.6 kernels are mostly interesti=
ng
for boards with 4MB flash memory.  And I would suspect such boards with that
little flash memory to belong to that past.  (And OpenVPN 2.4 is perfectly
fine too for some time forward anyhow, which should work just fine).

If this fix has other qualities, then it's fine to consider such a patch.  =
But
I don't see the need for this if it is primarily to enable support for anci=
ent
kernel releases which are no longer supported by the upstream kernel commun=
ity
(where 4.4 is the oldest one).

I would lean on what Antonio says here as well, as he kinda owns the sitnl
implementation and API.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--k6eX5PIqrxdYydgUkWUUE8vvAccwU4X11--

--z9t9ozf2es34tJ6I8ubqk275gxt3sbHZW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfV4JIAAoJEIbPlEyWcf3y/54QAIAIII9uwghyuGIRlWAsNuD1
GX4Lb+e+kElx7mnvh1GX3SlVlnrBEqwkrhlM2/p7afpX5ONOS/gJhwsWi1Rbwxfi
o+s4+ZcWA/BGu5KSpNKNub7rU9aI/4RaVqai0CiSqJ4bJE5dKV8TKVAdL/hq0MK6
sfUjI6mwLH03a3QlofJqE15L0tLlaFU6Vg5A6Shh5PBOjbpK7EzikOzTzQVieM8f
3gY3iryt1QEq7uwUmPddvhiHCFA39lW5JcDI87jEg/R2Ys+oTUFQY6BMqljUMjdO
XCO5fjCaVXCH4H8Cn+xZxl1Zc2xPWccebkrw3jQ+CjH0KLegRUqxDPCNQhVN6kS8
vw7blKuXPieTvDnpPuG0CxwYOofd7ey2AstjVXFj2hTqoFr+AN0+tGASWTmKgyAr
IdZgZmhS259DGNrbt57Jmt4xpFxDwDSu9O0c393lZVg7ZSlG7gwXSrcuoxubN0MY
ECixF62tejp5VSGgZYKXwVAd10ywOyVqvpywjyM4Ik6ufez+w+bhtlqWmFHA5HOb
8plnj3YFrgV9sv63zAdqF6OiqYaRT4vxbmf/c6tgfAcIWIkpvkmApmkr/3+vDtiS
bZYIMM9tq52HwblLn8xXRIis/d/hSnG6/2p6AKlsozvg/rApAF4DlTZCvFcF4mOH
/epl/bHqYaGwIYKhhIOc
=9PnI
-----END PGP SIGNATURE-----

--z9t9ozf2es34tJ6I8ubqk275gxt3sbHZW--

