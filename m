References: <20180605090421.9746-1-a@...2181...>
 <20180605090421.9746-2-a@...2181...> <20180605143603.GL57262@...1296...>
 <CAKuzo_i5wMwqSKjH-ohK8ujSApthxNrHsbFw2k5U9q_YKb_YqA@...278...>
 <9319a55d-c27e-aa07-749d-9c998271a5c4@...2181...>
 <CAKuzo_gfgG=6LxX-s0aPReZeaXDwEBM0zfrtWxZR9JzNvkraOA@...278...>
 <20180605185352.GR57262@...1296...>
 <CAKuzo_gaiCL1Y_zbHUBjaQwxtU2WYzg5Z4zv9tDUS-J4oeoLVg@...278...>
 <20180605195935.GU57262@...1296...>
 <CAKuzo_jP1F13rw2pdRx9zF0n-7+N29u3d4FE53tL9SrwxMwk9w@...278...>
 <9a878b99-12ef-47b4-fc85-a16ecc196363@...2181...>
 <CAKuzo_hU64ML71iL7Xdt5_k08QLXwDytXd1W2TVze=7SUhLLSQ@...278...>
 <CAKuzo_gp9jcVocxgf79TNQpgP-ScioC1pM_3oTq9+SHHAhEonw@...278...>
 <665fcdae-dad7-b6c8-14ee-512ff7992963@...2181...>
 <CAKuzo_jLhL=pLrkRoqWXHPRLzBGBiUCgq20Wzxd+DiidoAmOJA@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <30206ee5-f602-57f3-2ce4-4a7b768200f2@...2181...>
Date: Fri, 8 Jun 2018 00:23:29 +0800
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jLhL=pLrkRoqWXHPRLzBGBiUCgq20Wzxd+DiidoAmOJA@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NLygyAFmYZn6aoXE7ugDflVrFAvLVt5v7"
Subject: Re: [Openvpn-devel] [PATCH 1/5] tun: ensure interface can be
 configured with IPv6 only
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NLygyAFmYZn6aoXE7ugDflVrFAvLVt5v7
Content-Type: multipart/mixed; boundary="2bAPPn3l1grBSVS1r4Mk4XTibWj2BY0e0";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <30206ee5-f602-57f3-2ce4-4a7b768200f2@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] tun: ensure interface can be
 configured with IPv6 only
References: <20180605090421.9746-1-a@...2181...>
 <20180605090421.9746-2-a@...2181...> <20180605143603.GL57262@...1296...>
 <CAKuzo_i5wMwqSKjH-ohK8ujSApthxNrHsbFw2k5U9q_YKb_YqA@...278...>
 <9319a55d-c27e-aa07-749d-9c998271a5c4@...2181...>
 <CAKuzo_gfgG=6LxX-s0aPReZeaXDwEBM0zfrtWxZR9JzNvkraOA@...278...>
 <20180605185352.GR57262@...1296...>
 <CAKuzo_gaiCL1Y_zbHUBjaQwxtU2WYzg5Z4zv9tDUS-J4oeoLVg@...278...>
 <20180605195935.GU57262@...1296...>
 <CAKuzo_jP1F13rw2pdRx9zF0n-7+N29u3d4FE53tL9SrwxMwk9w@...278...>
 <9a878b99-12ef-47b4-fc85-a16ecc196363@...2181...>
 <CAKuzo_hU64ML71iL7Xdt5_k08QLXwDytXd1W2TVze=7SUhLLSQ@...278...>
 <CAKuzo_gp9jcVocxgf79TNQpgP-ScioC1pM_3oTq9+SHHAhEonw@...278...>
 <665fcdae-dad7-b6c8-14ee-512ff7992963@...2181...>
 <CAKuzo_jLhL=pLrkRoqWXHPRLzBGBiUCgq20Wzxd+DiidoAmOJA@...278...>
In-Reply-To: <CAKuzo_jLhL=pLrkRoqWXHPRLzBGBiUCgq20Wzxd+DiidoAmOJA@...278...>

--2bAPPn3l1grBSVS1r4Mk4XTibWj2BY0e0
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Selva,

thanks for testing this branch again!

See below:

On 08/06/18 00:14, Selva Nair wrote:
> Hi,
>=20
> On Thu, Jun 7, 2018 at 1:51 AM, Antonio Quartulli <a@...2181...> wrote:
>>
>> Hi Selva,
>>
>> I have tried to account most of your comments, but something might still
>> be off. Building openvpn for Windows might need some time here as I
>> don't have the entire environment ready yet.
>>
>> Would you mind giving my latest branch a try and let me know how it goes
>> with regards to your previous observations?
>=20
>=20
>=20
> Did some quick tests and this seems to work quite well (but see the
> note at the bottom):
>=20
> - v4 routes via tun just fail with a warning which is good (our route
> errors not being FATAL pays off here)
> - v4 routes via net_gateway just works : no idea why we support this,
> but good to see this patch doesn't break it
> - redirect-gateway causes warnings as v4 routes fail:
>   If its not too hard could we check !tt->did_ifconfig_setup before
> attempting v4 redirect? Saying this because "--redirect-gateway with
> no options automatically implies ipv4" is just a hangover from the
> past that we are stuck with. For other routes it may be harder to
> detect whether its via the tun or not so just letting them error out
> is fine. And those warnings provide useful feedback to the user.
>=20

Don't you think it's still meaningful to print the warning? somebody is
asking for a redirect that does not make sense because there is no v4
configured and the config should be adjusted. No?

> A minor thing:
>=20
> - The warning
> "WARNING: OpenVPN was configured to add an IPv4 route. However, no
> IPv4 has been configured for this interface, therefore the route
> installation may fail or may not work as expected."
> is printed without the M_WARN flag  --- so syslog won't see it as a
> warning nor does the GUI. M_INFO|M_WARN will make it print at verb > 0
> with the warning tag. If that sounds like a strange combination,
> invent a warning level like D_GENERIC_WARNING =3D LOGLEV(1,0,M_WARN). We
> don't have one.
>=20

you are the master of the log levels, therefore I'll just follow your
suggestion, unless somebody else objects.

> Note: All that said, I can't seem to connect to the server via ipv6
> when there is no v4 address. tracert fails before the first hop.
> v6 does work when ifconfig is not filtered out.
>=20
> One difference from my  earlier test using your previous
> version with the minor change to allow tap initialize is that the tap
> adapter now gets the link-local v4 address (169.254.x.y) as opposed to
> staying at 0.0.0.0 earlier. But this may be just dependent on the order
> in which I tried various combinations and may not matter.
>=20

This happens because I have factored out the set 0/0/0 in open_tun(). I
have added a "if (tt->did_ifconfig_setup)" that prevents the entire
setup if no ipv4 is present. I wanted to see if this could make any
difference. Should be at tun.c:5721. Feel free to remove that if and see
if it makes any difference again.

> So, is the tap-driver mis-behaving when the v4 ip/net/mask is set as
> 0/0/0 ? Will test this further when I get time later today.
>=20
> Thanks for working on this,

Thank you! I am still struggling to get my cross builder going,
therefore having somebody else doing sane windows tests is a big value
for this work.

Cheers,

--=20
Antonio Quartulli


--2bAPPn3l1grBSVS1r4Mk4XTibWj2BY0e0--

--NLygyAFmYZn6aoXE7ugDflVrFAvLVt5v7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlsZXAEACgkQB6U8WA7y
zXRo/BAAvb8dHyPKc3+BMOsBl/0PSswXiM8DV+8IWhJEC1MLlf2rvQdljaHyliq/
l6fkPCxWawn0mcPt6mAhmBmguZxTmkK+N2XRgVZlhS5STvhZsV+YhsemFzYdJtMJ
tOiCcS2n6EGjfK6rjarpLGdqXmRaEkDVkbtsDjFbXj63E73WnzQu2G+t+qESaOQQ
N/O/PTLrUXBRMY5kp+Lfv9CSdRIyWCzqUBWARCE/88/eYWpAz8QtE2hyhwmkc6fC
i5UeU34bB4D0rxdsW/03SFf/ocCoiJduw3LCP1TGdUEkt533wr3jnbfrsjYS1/r+
lBYrpoasFUiV06hHvUxASlLbF8XMZ8wgz6QmQdxqYOoHxoNhWw+rVL7yNXUNqn18
MQ7p3w1XOT2MdQ6cP2HcQDSm5HELYJARlkpgax9cwJ/eOTEELuUTH3ZYT6nls3aB
bagSDCaH71s4NkjpFi7nUiz1QxkQv/QEp+WkCvi+4ELSvGbh3/PhvIUGQIhXaSU5
HX9M/fxfeifIo9rIb1vRPKyNLpF7Gq2xHpyp8x+bf3PJSwieU92S2MkiYGYj6Qs2
qS7B1QatVEAYdFBNk1p5z1DJs+Q1jxGgufqklwMeFXRkdSFY/bezZiIKW+1IHmPC
1kNhRh1tFjPAML6deUjOX7wqjrF3toPMrvP0qR7+41zzl1X9CTg=
=O4Sr
-----END PGP SIGNATURE-----

--NLygyAFmYZn6aoXE7ugDflVrFAvLVt5v7--

