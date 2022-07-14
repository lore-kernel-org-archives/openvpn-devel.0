Date: Thu, 14 Jul 2022 22:14:55 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YtB5P7DEHkHdQwGK@...1296...>
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-13-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="b8IYzwZrhczQSKJ7"
Content-Disposition: inline
In-Reply-To: <20220624083809.23487-13-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 12/25] dco: check that pulled options
 are compatible
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--b8IYzwZrhczQSKJ7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 24, 2022 at 10:37:56AM +0200, Antonio Quartulli wrote:
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index b0a4b252..091cbd24 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -2219,6 +2219,19 @@ do_deferred_p2p_ncp(struct context *c)
>      return true;
>  }
>=20=20
> +
> +static bool
> +check_dco_pull_options(struct options *o)
> +{

Nitpicking a bit - the "other" DCO option check functions are in dco.c
(not yet, but in the patches leading up to this), so why is this one in
init.c?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--b8IYzwZrhczQSKJ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi0Hk/AAoJEB2Cnv7KVigSafQL/0rEf3aTna+rPYJVljUyJeSH
6iLLEv8pgJRPx2+C513euJl7G2l9uOauNCdBTP061NdNM0lrcpOOwoWnzp/pvRFH
85jMyDaZGXKncQYrH6zT4/TzfOa8qb2SAQHh+eSKBgwBg+L0YUfkbSZ43EtDDh9G
V90oA5cZjq5DLC1xzmxYGh3BzEwO4e9oyeSOQuTzNlHY/Jm3aMgIV8bk8ZNhEKbH
+ayL4SkAMAAh3qm3qANHyBP3n2CY/SpZt/enSLB6CLLC+qniyesN+8mr4eJb+nys
jejViXnROGvkFJBsmJ4wluEnKUspCw4bbnSm7QCUQo0aLh0X60AQlXs3jwATBMhM
EAygKWMXIiose1HBgJYFVtHP4USDnwHDgNLXGud1qYbl6cF45Vgj3VuMEG/Xc17z
J05vZZm6tbEtgncP/VmB1Cae5VA6TtyKfFHoqcO/521Jp1JmZMHXM3LPIIcTIguS
kVeNDdOKc3YLDdcZZLTqahp8/HkQuTU9U2Ia0UaFMA==
=dc4+
-----END PGP SIGNATURE-----

--b8IYzwZrhczQSKJ7--

