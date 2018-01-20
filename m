Date: Sat, 20 Jan 2018 17:52:00 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180120165200.GN69387@...1296...>
References: <1516423647-21932-1-git-send-email-selva.nair@...277...>
 <201801201336.w0KDajf8027638@...2054...>
 <CAKuzo_hnkVLOLi1sxs_7kbcCKZ6=kbbV+a6njKh4=5LX=R5srA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="zrGaLLVn9NtiuXI2"
Content-Disposition: inline
In-Reply-To: <CAKuzo_hnkVLOLi1sxs_7kbcCKZ6=kbbV+a6njKh4=5LX=R5srA@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add
 SSL_CTX_get_max_proto_version() not in openssl 1.0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--zrGaLLVn9NtiuXI2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi

On Sat, Jan 20, 2018 at 09:05:50AM -0500, Selva Nair wrote:
> If/when the TLS1.2+ support for cryptoapicert is ready for merge, is
> it a candidate for 2.4? Technically its a new feature but considering
> the "popular belief" that TLS1.1 needs to be shunned, and 2.5 is still
> far away, its worth considering..
>=20
> In that case this patch would need to be backported to 2.4, so good to
> know what's the general consensus.

I would argue that TLS 1.2 is officially supported by 2.4, and as such
it's a bug if cryptoapicert doesn't :-)

Given that the changes are fairly well localized and will not affect
other platforms, and are likely to not affect users that do not use
cryptoapicert, I would tend to "make sure that all we offer works with
TLS 1.2" -> include in 2.4

But I let Steffan or David overrule me here if they find the patch too
intrusive.

gert
--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--zrGaLLVn9NtiuXI2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaY3OwAAoJEB2Cnv7KVigSCFcL/iB3ozfAuRDsviBo4sxkkDyE
jmJ2HeXzFwQ4jiB3gr506t7W9Rn6YGRKX9N9+pkWoPjmmOmaD6Ql6bS7A3NG6SOM
iV7XBBw1Ne3MUSxQoXdF4yJov+covrunBNjxpRpNXwPd8iu9ZnzoVOfXuMGcu7Vy
6j0868p8MebiymNgWysx4wrCmca4f90FNJbaGxTUYWlY5MX/UJ6KskPjbx7ZOoMO
4I/aAGubc+BILVyI7IB7wGQ8iBJCicjWnEjLjDSdPniahCV+k5ay6F8bkVwlINLt
RwLIybPkA+zBtrZlWlj2FgMpH0MPNIMUPE5L/znfHz/HNAWqxC1jCtOqy0NxY3I5
gCOxIJHaxkXqHGcHnnQ3Fkz/qV4F4Kdu5VMmBigy1XBALpTUYMzEFq0tLdtuvzQC
+RQpftqfu6245NV/lqmg6SXdtmZPit52nl86xRJEHkw1B0goZ/1winqyNGpaTB5A
yafZ/WtVRUjbIiuDqqgMlkdELsZQ18KCKXdVmQhbgA==
=HDuC
-----END PGP SIGNATURE-----

--zrGaLLVn9NtiuXI2--

