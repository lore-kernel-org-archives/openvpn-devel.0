Reply-To: openvpn-devel@lists.sourceforge.net
References: <1537375062-1385-1-git-send-email-lstipakov@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <a49685c4-4eb5-455b-bbbe-86cbea5c1b75@...2080...>
Date: Wed, 19 Sep 2018 23:07:23 +0200
MIME-Version: 1.0
In-Reply-To: <1537375062-1385-1-git-send-email-lstipakov@...277...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="qOceDhbwn9I6p2KjHZEmppPs2P9JS6ckx"
Subject: Re: [Openvpn-devel] [PATCH] Refactor NCP-negotiable options handling
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qOceDhbwn9I6p2KjHZEmppPs2P9JS6ckx
Content-Type: multipart/mixed; boundary="7BQ7proOUuwhwODZDtug8PFkt9VGIhYGm";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <a49685c4-4eb5-455b-bbbe-86cbea5c1b75@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Refactor NCP-negotiable options handling
References: <1537375062-1385-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1537375062-1385-1-git-send-email-lstipakov@...277...>

--7BQ7proOUuwhwODZDtug8PFkt9VGIhYGm
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 19/09/18 18:37, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
>=20
> This patch decouples setting/unsetting NCP options
> from the state of TLS context. At startup (and then
> per sighup) we load config (pre-NCP) values to c1,
> which persists over sigusr1. When tearing tunnel down
> we restore (possibly modified) c->options back to
> c1 (original) values.

Just an annoying nitpick on the commit message.

It's a good executive summary of what this change does.  But it lacks the
argument of "why" this change is needed, which is at least as important to =
the
"executive summary" of the "how".

The "Fixes" reference is good to have, but it's a too vague link when
considering this commit might be scrutinized 10 years into the future - and
Trac might not be available.  And Trac references should normally be "Trac:=
 #xxxx"

Sorry for pestering about this, but good commit messages can really be time
savers in the future.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--7BQ7proOUuwhwODZDtug8PFkt9VGIhYGm--

--qOceDhbwn9I6p2KjHZEmppPs2P9JS6ckx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJborqMAAoJEIbPlEyWcf3yfXUP/127tJ+BSApIseGf+zasH2mD
P+LZPxJ5Ks2Bv9DVP7Hfu7outp8uJTd+GZG33T69z4S4G4mjALkwevQDfWw8CMXp
qQ3yOowU2Aj2RyQZLodTu88u/v3IA8Tfp7TxH0DuFXG48AML/tCx8ZDa+vRVnQmX
f90d7aR6VumT50OYsCiQfujiBhzm1w6mFqd1FGkjYrLW+oMXk58Lm5R1BBMtfU6y
ePzUZvFHvFsKeQKNE/lBehKswMQN32IyehOi/6BbDBg0vufV81N5JT6oQTrtX/5a
c0H3l3xu9qqobFOWjtpZ2GyuZUz5FLjS8BjrbtON8eANJUmgvYdUpr4+bNWRWTSt
geZhEJTKLTVCLgU3Hcm0VhScwhjbRAVulqbQWYKJ5/lnPoACXRKXsJ5SApS5j9iC
2YgCVQi2aX9PEY1VK7v7VRL/Qndfxn/yd1zZhj4rN/yiBsyt2b23Q6V3n1wdKZEO
4IEsVp9DBIN8lnXCHRy+g1VTg2XgHUrbGK2fHyPHMkq3YuNjz/kQxmtHvZWHxdnh
euL6YVkEFOS/dETUeqmZAtNNhVaBSHgiN2lts2XYJt6N9EWS7KOALO6HKoSzbRfu
KtBjeNQUQlAxdV/VmCPzG36rjxuuBtOtLP+BZsKuqomSlfKomO8O+oqd2ZuLC0DY
/pI79SrLfyiJMe7IFDxB
=GSuG
-----END PGP SIGNATURE-----

--qOceDhbwn9I6p2KjHZEmppPs2P9JS6ckx--

