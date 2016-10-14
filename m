References: <1476388771-16492-2-git-send-email-davids@...515...>
	<1476434891-14646-1-git-send-email-davids@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <69789502-e429-96d3-c9e7-7d0279d2de4b@...2080...>
Date: Fri, 14 Oct 2016 11:06:50 +0200
MIME-Version: 1.0
In-Reply-To: <1476434891-14646-1-git-send-email-davids@...515...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="CIXlq8M9vWH19PauaQpkSPe5JxXLiRkLU"
Subject: Re: [Openvpn-devel] [PATCH applied] Move memcmp_constant_time() to
 crypto.h
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CIXlq8M9vWH19PauaQpkSPe5JxXLiRkLU
Content-Type: multipart/mixed; boundary="6uxj4R5micmp8w1vA9im3aD4SFV3KvXoK";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <69789502-e429-96d3-c9e7-7d0279d2de4b@...2080...>
Subject: Re: [Openvpn-devel] [PATCH applied] Move memcmp_constant_time() to
	crypto.h
References: <1476388771-16492-2-git-send-email-davids@...515...>
	<1476434891-14646-1-git-send-email-davids@...515...>
In-Reply-To: <1476434891-14646-1-git-send-email-davids@...515...>

--6uxj4R5micmp8w1vA9im3aD4SFV3KvXoK
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 14/10/16 10:48, David Sommerseth wrote:
> Your patch has been applied to the master branch
>=20
> commit b891e57e1fe794483c08296e32c15751f2676a2d
> Author: David Sommerseth
> Date:   Thu Oct 13 21:59:27 2016 +0200
>=20
>      Move memcmp_constant_time() to crypto.h
>=20
>      Signed-off-by: David Sommerseth <davids@...515...>
>      Acked-by: Steffan Karger <steffan@...1856...>
>      Message-Id: <1476388771-16492-2-git-send-email-davids@...515...>
>      URL: https://www.mail-archive.com/openvpn-devel@...475...=
t/msg12698.html
>=20

[Lets try again, and see if Enigmail can be convinced not to encrypt it
this time]

Just for reference, as I forgot to state that in the previous mail.

This patch was slightly modified at commit time.  The function
declaration changed from 'static int' to 'static inline int', as
requested by Steffan Karger.

The difference is:
------------------------------------------------------------------------
@@ -31,7 +31,7 @@
 + * As memcmp(), but constant-time.
 + * Returns 0 when data is equal, non-zero otherwise.
 + */
-+static int
++static inline int
 +memcmp_constant_time (const void *a, const void *b, size_t size) {
 +  const uint8_t * a1 =3D a;
 +  const uint8_t * b1 =3D b;
------------------------------------------------------------------------


--=20
kind regards,

David Sommerseth


--6uxj4R5micmp8w1vA9im3aD4SFV3KvXoK--

--CIXlq8M9vWH19PauaQpkSPe5JxXLiRkLU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYAKAqAAoJEIbPlEyWcf3yIMQP/2jMRkI6Ax3nTwGAUR8uCHgd
u+aWhdXGF3O3K7VT0dUy+hR25xckppONISzVMFGu3ZLy33ANWVngEzA7YiS2Lfe1
574CnkiYR1FyAXW8FTrZ3mgVTt1buuCfGH+F7yiM63prZWJGoSfwSM02OxMBPu8Z
g7lBLH5bfiSmdhea+/LehmfQTnPdVN58+ukuR7O13tJESM3LqnTbrT4S8JRhjFi/
2DMSNRzyJJSYPkph03sew5NEhckGWbnXj8fDwn7ZBaNK+5JxGDvDmQg5e5fxGgRV
rQK4+RS/03HtAj6mkdT5qVAZGgmuzC3lVCVjAZYWqi8n7Re573/fF6AxUM4kcdGn
ARdf8MsY9ua02753zBykY7yBGZI162U2ln+oeQm1tv5NeUAIJH905OadKjgCRLBn
lK6s5cEnUV1VvGAIvp/AZ+EBjbcHrvPdeGknA7loDs7RA6xho7VOtT8Op51SSPjS
Zk2VkwxpHrTjW3bSIG+huhkI+3AEDYV6IEmjap/nZLbdWSdoBXl3dFXr+6J5+9cy
ren4ivtmJjA6rUNElf4FPT5tYdGvAx8PITCsDAKoMA33IEdT3NDN4tTqBZMe7BEy
eNpGR6ai8VTjR4cwMfGuX93CeyJpRcERWQOw8aQabJ+MvXUhEoqjyVW6+Kb4Nh07
n0qYH62ql/6opJgCoKig
=Gfl8
-----END PGP SIGNATURE-----

--CIXlq8M9vWH19PauaQpkSPe5JxXLiRkLU--

