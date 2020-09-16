References: <015201d68c49$5e85b310$1b911930$@aronetics.com>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <a3b92e85-3db4-df35-e222-92e05fb73bcc@...2080...>
Date: Wed, 16 Sep 2020 21:26:04 +0200
MIME-Version: 1.0
In-Reply-To: <015201d68c49$5e85b310$1b911930$@aronetics.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="CU4fxW0zsGwSbuOvOwFVkyp61YNHmkNk8"
Subject: Re: [Openvpn-devel] LD Errors / vpn_connect or vpn_init
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: John A <john@...2578...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CU4fxW0zsGwSbuOvOwFVkyp61YNHmkNk8
Content-Type: multipart/mixed; boundary="Lmvnnrg0uS5cATNq078ncJ1N88HMTkKu0";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: John A <john@...2578...>, openvpn-devel@lists.sourceforge.net
Message-ID: <a3b92e85-3db4-df35-e222-92e05fb73bcc@...2080...>
Subject: Re: [Openvpn-devel] LD Errors / vpn_connect or vpn_init
References: <015201d68c49$5e85b310$1b911930$@aronetics.com>
In-Reply-To: <015201d68c49$5e85b310$1b911930$@aronetics.com>

--Lmvnnrg0uS5cATNq078ncJ1N88HMTkKu0
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 16/09/2020 18:49, John A wrote:
> Hey y=92all,
>=20
> I am new to this list and have been on listservs/majordomos since themid-=
90s.
> I visit here today to ask and hopefullyreceivean answer.
>=20
> I haveerrors of undefinedreferences such as:
>=20
> /tmp/ccDkPqm5.ltrans7.ltrans.o: In function `vpn_init()':
>=20
> <artificial>:(.text+0x1051): undefined reference to
> `openvpn::ClientAPI::OpenVPNClient::OpenVPNClient()'
>=20
> Isthere documentation somewhere that I can look over or an quick quip ans=
wer
> here of what obvious thing or stuff I am missing?

I would recommend you to have a look at the reference client implementation,
under test/ovpncli/cli.cpp.

But beware that the OpenVPN 3 Core library is designed to be a single
compilation unit (don't ask).  So you might need to do be careful how/where
you do the #include of the Core library, as well as being careful about how
you design your own compilation units.  In OpenVPN 3 linux, I do use multip=
le
compilation units, but needed to do some careful design around it.

> This in on CentOS 7 machine, x86_64, what more could I provide? Is there a
> slack group?

I've built both the cli reference client without any issues on CentOS 7, as
well as developing openvpn3-linux on RHEL-7 as the main development environ=
ment.

We're mostly on IRC, FreeNode in the #openvpn-devel room.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--Lmvnnrg0uS5cATNq078ncJ1N88HMTkKu0--

--CU4fxW0zsGwSbuOvOwFVkyp61YNHmkNk8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfYmbMAAoJEIbPlEyWcf3yCaIP/3SyJYyccpWeVrpYFuMBpB5b
OljAWtTRBx4BFlIKC+rsNBD5LAxQh2k/pvhP1VdywtOYE6mHaaIB2AgxVVf+LRkD
4Q+Oofqzr7bXmYx/Sd9KnXtz9sBxnbUqFRmunv285xD9Sx2rfWiYuLlMG5yVcILM
Ggo9P9VwsXHABiKtLMNRGx7CxqfbyAy22DTZMEeKnsenUcIXGCsVyqefl72fzCem
bVwmNC+mGmj0Squxrd+Nj1gDmvtN4fYTTGACo0fS/Y+9pCjsPI9dL43/Ujt+lwP6
ycIa5LA8yDPqeem9Zt/PhjiO/N2M0xVVnrR1Cxzf2nnEtEuJbmDtZMZbkcRytUV5
7cywW5uwXs5vBxGcaHQKHi2w1qCRz/jZxJBJkXxl2/nROE/MM/6NyT7IgpmjNd3Z
GvV/FXWtet5Uc0f3LKDP344+F7WYZhpC3ZIdlPAARR9r0gzCwvDSfzn9fbvXyR3e
UViGdfc/6t6t1y7D7mxaguOoWT1Wu8lbIvrTQIAnZpZmTCiMzqSPb0Ig4tIyV2SF
BcTVztN9Gq+j9ZH+yX+N/UKA0kr2RoutTmapIONoNKGPT7vIpPhIl8vmolpg9ZY/
P7uS38CqnoqoXXOo4JAfdEzC15MILnXyoTgLoQGC8DDxBRnl4YW8f6sYdJtILwCz
qOfLmBXrIjzFhGn4mMdM
=gSWB
-----END PGP SIGNATURE-----

--CU4fxW0zsGwSbuOvOwFVkyp61YNHmkNk8--

