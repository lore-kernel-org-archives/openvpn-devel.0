Date: Sat, 6 Jan 2024 09:44:42 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZZkS-i49qnymThV7@...1296...>
References: <20240105135742.21174-1-steffan@...1856...>
 <202401052214.405MEwCs053531@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Gvn9zlxsuPWtArv8"
Content-Disposition: inline
In-Reply-To: <202401052214.405MEwCs053531@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Fix IPv6 route add/delete
 message log level
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

--Gvn9zlxsuPWtArv8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jan 05, 2024 at 11:14:58PM +0100, Gert Doering wrote:
> Patch looks good, makes sense, thanks for that.
>=20
> Interesting enough, the old code had weird formatting ("msg( M_INFO")
> which led to weird indenting of the *next* lines - this patch changed
> the msg() call to have no leading blank, and uncrustify complained that
> now the successive lines had whitespace errors... fixed on the fly.
>=20
> Not tested beyond "looks reasonable, compiles, and add_route() indeed
> uses D_ROUTE for informational msg() calls".
>=20
> Your patch has been applied to the master and release/2.6 branch.
>=20
> commit b959b02b4f607628896b4092f7ddfa675e87d929 (master)
> commit 9abf74c92c1c13de089523babc1dfeda7bb7255f (release/2.6)

Unfortunately I fat-fingered cherrypicking and commit-id'ing - "master"
has

commit 7268e14dba61254b04a0b2db37c12c8ab58423ea (master)

and the ID referenced above is "the patch without the whitespace fixes" -
which only exists in my local repo, not pushed anywhere.

Doubly unfortunate, I also cherry-picked b959b0, so release/2.6 ended up
with a commit that was uncrustify-broken.  I'm not going to fix this with
a force-push, so we have a new commit in 2.6 now...

commit 9fb62e2b32fd4e63ae323ccfbc79dfaba6ce4d91 (HEAD -> release/2.6)
Author: Gert Doering <gert@...1296...>
Date:   Sat Jan 6 09:38:41 2024 +0100

    fix uncrustify complaints about previous patch

... which contains the diff b959b0..7268e1:

--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1939,11 +1939,11 @@ add_route_ipv6(struct route_ipv6 *r6, const struct =
tuntap *tt,
=20
 #ifndef _WIN32
     msg(D_ROUTE, "add_route_ipv6(%s/%d -> %s metric %d) dev %s",
-         network, r6->netbits, gateway, r6->metric, device );
+        network, r6->netbits, gateway, r6->metric, device );
 #else
     msg(D_ROUTE, "add_route_ipv6(%s/%d -> %s metric %d) IF %lu",
-         network, r6->netbits, gateway, r6->metric,
-         r6->adapter_index ? r6->adapter_index : tt->adapter_index);
+        network, r6->netbits, gateway, r6->metric,
+        r6->adapter_index ? r6->adapter_index : tt->adapter_index);
 #endif



apologies for that.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Gvn9zlxsuPWtArv8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJlmRL6AAoJEB2Cnv7KVigSGycL/0LtGXBseQUmWq/wEndfo3u2
FP1Y1Ozi3xZDpEICQdHuu3BP5NlS2QswYIRJAUxVX7TYcxMdmGvc0UixhRNb8rWU
gpTxSdg8eUkcor7+YJKFuxwwVtTe6O1PORoERHI1VxdZ5k3W2mmnppydiDCtgwBL
EfaCTj2Xt4AZOiC28zZ0XdyXDbgK8iAuoSTCA+zRutNoQgCaXGoRWk5C3dp7yKUS
vdi6x+dOsvxKQs7KDWL661R0r4qadfKM9BRLJeHELth/+K9JgMddbaFQwCbfQIjA
jB6+4w4cezhQ1RCm4A9gVYqzUz5dNdOcCLvPYNWomtquGWjTecWnslqaFz/+p0fV
NhYqYoV/nFpIIgMILu5ibGQ7oRA3T8wCugnoIR9mgyKkRplZ+4sUykIkfw/TpFCF
goQudZaeaJwOYEiLBABx29qlcB6rflSOmEAKdI5gsWHxqDPaQSciEGXQuf+IBiAv
cT4IkXbmj4BXLI7RWB4URQqa6Wx1e2ranlkrbTjlHQ==
=XTLc
-----END PGP SIGNATURE-----

--Gvn9zlxsuPWtArv8--

