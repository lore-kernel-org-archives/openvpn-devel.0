References: <20180420111624.7230-1-a@...2181...>
 <20180420111624.7230-3-a@...2181...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <09ce3f2e-cd16-933d-1a52-b8d89e68ac74@...2181...>
Date: Sat, 21 Apr 2018 12:41:28 +0800
MIME-Version: 1.0
In-Reply-To: <20180420111624.7230-3-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RauYINXqhskykXbSfjmWKOotg3Un2zc6K"
Subject: Re: [Openvpn-devel] [PATCH 2/8] implement networking API for
 iproute2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RauYINXqhskykXbSfjmWKOotg3Un2zc6K
Content-Type: multipart/mixed; boundary="cmKUMcSQyAchvBmv7rTb9JKblsiTl0Gvm";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <09ce3f2e-cd16-933d-1a52-b8d89e68ac74@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 2/8] implement networking API for iproute2
References: <20180420111624.7230-1-a@...2181...>
 <20180420111624.7230-3-a@...2181...>
In-Reply-To: <20180420111624.7230-3-a@...2181...>

--cmKUMcSQyAchvBmv7rTb9JKblsiTl0Gvm
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

there is one little "open" thing in this patch that I wanted to
highlight. See below:


On 20/04/18 19:16, Antonio Quartulli wrote:
> +static struct env_set *es =3D NULL;
> +
.....
> +    openvpn_execve_check(&argv, es, S_FATAL, "Linux ip link set failed");

Right now the code initializing the environment set to be passed to
openvpn_execve() with NULL.
This means that not ENV is passed to the iproute commands.

This behaviour does not reflect the original one as in the current code
we always pass the complete ENV coming from the openvpn context.

This begs two questions:

1) how can we pass the env_set without making the API dependent on that?
(this is really just an iproute thing, unlreated to the networking side
of things)

2) do we really need to pass the entire ENV to iproute commands?

I understand it is needed for the scripts, but why passing it to these
commands too?
Shouldn't we expect them to work by using only the commandline arguments?


Cheers,

--=20
Antonio Quartulli


--cmKUMcSQyAchvBmv7rTb9JKblsiTl0Gvm--

--RauYINXqhskykXbSfjmWKOotg3Un2zc6K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlrawPgACgkQB6U8WA7y
zXTIIg//XUnO+5T+h1CFlyJAlQ+qQrxoy55Ba8g11rLTbdFio8AzQt9vvvFuizQs
WBh8i78SoRs0JjR4BIipBp6VMNKpfCTlLAJhKEBrM2mWd6nkGVFwe8/Dxz1211pz
5v6wY4V9Aj1OBV1mWasMqeKz5PDua12kZnro0wehdLR7K7EWcOeqlf/alMYbywKT
CCNFIj++VzQlCHFnYVSJ6bMQRlZUxD9x3xtz1vwl1VzPmsRai8djg5+Xg6zJeQMX
VGrrvNztPaNExogocyidsy3lXH/5nVZ5LOSJEqfZ0imEXCgsdnS5DLg3E+ofEblv
uFeMWBhVIZV1NMm+UCp/qp9eKQgQwhCI2bxlhslTEd/vAdBpJ3Vw/veqCfFHIa2N
vEByf1a7VBNIu+9WP5CAcQzJgNhIQ4RbxWCyDN4Z1ueJPtq2Lt9gA70GHIl4mzr/
zeJSL2mngyvhCKq6teIHAjRcWQ86At065RUJpqVAbGIpR319JqusbukmhQj+91cg
Pui/r2R4Q12uQUGtz2qtkKpWFaYNMBEOyUKIrHZPwLV64MOxPEHwN+Hw1nKUHUSY
RGpjk/TNwOeqNS/OfoS1H91nXAUNK+ze8vZON9SAsBqnTbE9D/sKBiQOG3WX3EUt
EnGcM0k9NYiGXpcDKinYWL7IBtW5Z+9nQGyR1o4LvKhUFKKyZyQ=
=JgcJ
-----END PGP SIGNATURE-----

--RauYINXqhskykXbSfjmWKOotg3Un2zc6K--

