Date: Tue, 23 Jun 2020 08:45:38 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200623064538.GC1431@...1296...>
References: <61c1b837-3f81-6783-5934-8128bb81881b@...2181...>
 <20191113100702.6863-4-tom.ty89@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="aG5m9hvpg0r8v0eH"
Content-Disposition: inline
In-Reply-To: <20191113100702.6863-4-tom.ty89@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2 4/4] Do not set pool netmask when
 nopool is set
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

--aG5m9hvpg0r8v0eH
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 13, 2019 at 06:07:02PM +0800, Tom Yan wrote:
> The setting probably just slipped out of the if-block over rewrites.

Possibly... so it makes sense to clean this up.

Can you please re-send the patch to change *both* places where this
occurs, helper.c line 348 and helper.c line 391?  Seems a bit weird to
just change one occurance.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--aG5m9hvpg0r8v0eH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe8aUSAAoJEB2Cnv7KVigScPMMAKgoGEuJzdnOi5uLMTMOM33v
IJiQdkmNVFgjzQa0CHwzG+YRqOj6YuzwZNTnEt3pam594l9w92ddc+0nVb+C6+zc
A0MzP1mcGjdg8Y+8ndhkz94HJCNQs0dBLMVC9ZEUe/nLhNfe0IZb9INp0uYqeeAp
DAZuu0P+XQYd6+lc590W4su3iNhfUwT5N0mRBO6pfz+0j+ZKmvFZelRtoDJWQ23n
YCrLNEIfBML3RKqFg6kIsPU41bza2+9q6daVXN+0iB8H6y3UATysaznmhJ5rgr2u
ultD3i9c5Q6bdmx8TGjEae3I9x+yVQUbmoQ/NnCg5eHCbjSokC7b+7i0SH60gGxt
+UPt3/V+WGmLHUCeferVc/5sL26teV/RxIGcqmf2pviFcUEl2V+Pu2/JlQB4a71l
bs3e8ijdK+o5+DYys7yBmVGEBb5UdHTEbPnmjfHlYX7hvMUTL2AhPkBsRPBNTtab
S0vRmeYkrFKjBiugJOuCOw7RfRtngYZjhadL6U+dlQ==
=EwTx
-----END PGP SIGNATURE-----

--aG5m9hvpg0r8v0eH--

