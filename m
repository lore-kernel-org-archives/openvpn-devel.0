References: <323226c5-b097-9d1c-5d43-0790cfa1ccfb@...277...>
	<1b07213d-4844-d629-195e-3211735b854c@...277...>
	<20170403201504.GA93896@...1296...>
	<9cdcac22-40bb-0ebf-c21f-a8b96f55a5d2@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <eb2af641-73a0-1395-8196-f8ce00237c87@...2080...>
Date: Mon, 3 Apr 2017 23:21:05 +0200
MIME-Version: 1.0
In-Reply-To: <9cdcac22-40bb-0ebf-c21f-a8b96f55a5d2@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CjIMxq2hKrxVtk4ohdgWlMuCVISJE5xIF"
Subject: Re: [Openvpn-devel] gentoo build inconsistency with openssl in
 openvpn using elliptic curve cert
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CjIMxq2hKrxVtk4ohdgWlMuCVISJE5xIF
Content-Type: multipart/mixed; boundary="1H0eDE309dkSX6hvbIvOgEMpXVQi5Omxt";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: debbie10t <debbie10t@...277...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <eb2af641-73a0-1395-8196-f8ce00237c87@...2080...>
Subject: Re: [Openvpn-devel] gentoo build inconsistency with openssl in
	openvpn using elliptic curve cert
References: <323226c5-b097-9d1c-5d43-0790cfa1ccfb@...277...>
	<1b07213d-4844-d629-195e-3211735b854c@...277...>
	<20170403201504.GA93896@...1296...>
	<9cdcac22-40bb-0ebf-c21f-a8b96f55a5d2@...277...>
In-Reply-To: <9cdcac22-40bb-0ebf-c21f-a8b96f55a5d2@...277...>

--1H0eDE309dkSX6hvbIvOgEMpXVQi5Omxt
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 03/04/17 22:37, debbie10t wrote:
>=20
> Something to do with Licences:
> #gentoo
> <me> out of curiosity .. i presume gentoo intend to include elliptic=20
> curve algos in openssl at some time ?
> <iamben> they are included if you disable the bindist flag
> <iamben> USE=3Dbindist disables them, so that you can legally redistribut=
e=20
> your package as built
> <iamben> those algorithms are (possibly) patent-encumbered

Huh!?  Fedora and RHEL are usually very much weary in regards to such
patents.  And they've distributed openssl-1.0.1 for quite some time now,
with EC (backported?) ... but, I do see that at least the Fedora
packages does a lot of funky stuff in regards to EC [1]

But there are some patent concerns, according to Wikipedia:
<https://en.wikipedia.org/wiki/ECC_patents>


[1] OpenSSL 1.1.0:
<http://pkgs.fedoraproject.org/cgit/rpms/openssl.git/tree/>
    OpenSSL 1.0.2:
<http://pkgs.fedoraproject.org/cgit/rpms/openssl.git/tree/?h=3Df25>


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--1H0eDE309dkSX6hvbIvOgEMpXVQi5Omxt--

--CjIMxq2hKrxVtk4ohdgWlMuCVISJE5xIF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY4rzCAAoJEIbPlEyWcf3yLUMQALqRhdjhTSba3NvXbyH1Rd9A
n7T1lxQA6Vgqj9KRMeJQATFbj0KEhbJZk3AayiJy84rCv/PokpKG0qqdWFAof3EZ
yc/la++oVfXe0VTDaSBQ0QVrvxL5GQJIK2dT2xpr3NoNlg8VNi5CQGp3QGfozbE7
y4aeqiwDadJhQov2Z2jVe6PkgoaaxGUHFP2SXTk/wsKLWuMNJu7MIr3lVD1Jvy7D
FiK8qf4PM+Ew15tplu+KB1XG1JbPVGjDFhCedzoDjfTz0JVmWQ1P9BAXK+JKdMnM
0hkFQrpzUHQ/5ea5G2AhCQshX7C2r0+2wL72qc9tu9SoFYa6eA8oxEYZUqggGw9T
LC7UgQm7dQOptx8zLPbCfnYCaI6xlqzsS9nEX+VmYcJh3e2rOW+1DAHDOe0TVI0A
XSjEq0SyI6LILyyeB/UTUL0IPZ6KoGzYo3CBAlmwhxQ3wPiB2qysfYacaJ/0RC7A
8qE5RkvW7UseZzSJEwKCN745Lc9uiOoaoP7KzwKgrTN7R8ZPHk9TaHitkjG1hMR6
I5EYXjrNkQDr01yviK86uxAoHE0BvyQGuUpRa4uJZ5FOjhDIy+XwOOuRscK3brnO
3ux3O7tsH/wcZ5EHEStzqfdPfJa5f+yDADRInjHRu9GUhlbGBK2mqI2zrsE+7+6a
vBUX1ZER6+WhUVlerkI4
=NbKr
-----END PGP SIGNATURE-----

--CjIMxq2hKrxVtk4ohdgWlMuCVISJE5xIF--

