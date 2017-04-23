References: <1492699272.18647.3.camel@...2264...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <0e3d6163-c8bb-bf76-1012-59dcfd264783@...1856...>
Date: Sun, 23 Apr 2017 10:59:28 +0200
MIME-Version: 1.0
In-Reply-To: <1492699272.18647.3.camel@...2264...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oadDMaowgmVurTO7uDdH2W6FKdRQvObQf"
Subject: Re: [Openvpn-devel] [PATCH] Fix extract_x509_field_ssl for external
 objects
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oadDMaowgmVurTO7uDdH2W6FKdRQvObQf
Content-Type: multipart/mixed; boundary="etRMcEi9gsEakntVm4kx8j4TAWIVj8Owr"
From: Steffan Karger <steffan@...1856...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <0e3d6163-c8bb-bf76-1012-59dcfd264783@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Fix extract_x509_field_ssl for external
	objects
References: <1492699272.18647.3.camel@...2264...>
In-Reply-To: <1492699272.18647.3.camel@...2264...>

--etRMcEi9gsEakntVm4kx8j4TAWIVj8Owr
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

The change makes sense, so 'Feature-ACK', but one remark:

On 20-04-17 16:41, Hristo Venev wrote:
> @@ -191,16 +191,23 @@ extract_x509_field_ssl(X509_NAME *x509, const char =
*field_name, char *out,
>      X509_NAME_ENTRY *x509ne =3D 0;
>      ASN1_STRING *asn1 =3D 0;
>      unsigned char *buf =3D NULL;
> -    int nid =3D OBJ_txt2nid(field_name);
> +    ASN1_OBJECT *obj =3D OBJ_txt2obj(field_name, 0);
> +
> +    if (obj =3D=3D NULL)
> +    {
> +        crypto_msg(M_FATAL, "Cannot get ASN1_OBJECT for %s", field_name);
> +    }

M_FATAL is currently acceptable, because field_name always comes from
the local config file, but I'd prefer to make this non-fatal, and return
FAILURE.  That ensures that if someone decides to use this function in a
way where field_name *is* attacker controlled, we do not introduce a
remote DoS.

As for the log level of this message: I think D_TLS_DEBUG_LOW (--verb 3)
or possibly D_TLS_ERRORS (--verb 1) are appropriate.

-Steffan


--etRMcEi9gsEakntVm4kx8j4TAWIVj8Owr--

--oadDMaowgmVurTO7uDdH2W6FKdRQvObQf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJY/GzwAAoJEJgCyj0AftKIbhMIAKp4plFGsGk2sX33p60whGzD
C3xapHEX+b+tV57SsuSYTxQA689LZ/FzINTrwXcWq4f9RSpVDU5h9sRlpHGoC1Cu
eB8yOsVTiWXpjYaTG5MjlUAUouFsMtG0FB/np4N1h/u6Hi6qulzwaXSNWdBEPsLT
hqw6wrF2WbwOB4kQ5fPz8N7nIcddTbp42LS1vPeI/tusQAKeVuOW9oK3fVnBTFjE
o9ZXFSTW+gFUGWCJ1BFtRMPWhKweP6KuU60I1g9mgZOkb5wH5wisXWlVHDflIyKZ
fPMqUp5OUL0Ka9FPgOiTcd5/h2ICJbPcN3nwbApKHhWdzlQBFBFbnQvZJN8Tfg8=
=xTxO
-----END PGP SIGNATURE-----

--oadDMaowgmVurTO7uDdH2W6FKdRQvObQf--

