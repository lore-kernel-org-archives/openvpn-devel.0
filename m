References: <20210318161609.76073-1-juliusz@...2525...>
 <749924e0-5927-ba54-9e09-e722d53ae8ef@...2080...>
 <20210318175611.GG976@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <bd5a1fd4-834b-593e-5505-2ef3f92f839b@...2080...>
Date: Thu, 18 Mar 2021 19:00:18 +0100
MIME-Version: 1.0
In-Reply-To: <20210318175611.GG976@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rT1QjSzXz5lcnfNmeAn3MsIxWp2XqUBVV"
Subject: Re: [Openvpn-devel] [PATCH] Add PKG_CHECK_VAR compatibility
 definition for old autoconf versions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Juliusz Sosinowicz <juliusz@...2525...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rT1QjSzXz5lcnfNmeAn3MsIxWp2XqUBVV
Content-Type: multipart/mixed; boundary="4y31HuEinvQqTkIevj8PXkxeQDAwtNeHs";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Gert Doering <gert@...1296...>
Cc: Juliusz Sosinowicz <juliusz@...2525...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <bd5a1fd4-834b-593e-5505-2ef3f92f839b@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Add PKG_CHECK_VAR compatibility
 definition for old autoconf versions
References: <20210318161609.76073-1-juliusz@...2525...>
 <749924e0-5927-ba54-9e09-e722d53ae8ef@...2080...>
 <20210318175611.GG976@...1296...>
In-Reply-To: <20210318175611.GG976@...1296...>

--4y31HuEinvQqTkIevj8PXkxeQDAwtNeHs
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 18/03/2021 18:56, Gert Doering wrote:
> Hi,
>=20
> On Thu, Mar 18, 2021 at 06:25:13PM +0100, David Sommerseth wrote:
>> I'm not seeing the rationale to why we need this; can you explain that?
>=20
> See my other mail: because the previous configure.ac patch (for WolfSSL
> support) breaks some platforms.  Seems "some m4 bits" are not universally
> there.

Right, I missed that context when looking at it ... but that context=20
could still have been in the commit message, for the git history to=20
explain why we needed it ;)


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--4y31HuEinvQqTkIevj8PXkxeQDAwtNeHs--

--rT1QjSzXz5lcnfNmeAn3MsIxWp2XqUBVV
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmBTlTIACgkQhs+UTJZx
/fIVWRAApQTE8wfOJnpOtb7epQcJnyZMPuxlUQGZRAtpddcBpu/3fPTUe52bzgCm
46+lYIyN9RVjFXoB9KqDyziIjLSPAq2znTl9EoaMvv5qOXJXE+z/eW6opCWzsYgp
K2Lcs62P2a77tLPfEil0IFHQSfLB/OExQBabPQfxv8FOq10G8OEyScRk9D0o/n+a
uNFUPuernBNpf/F71UULDK27YxEE57ZeiVcpy0tLYDV6vFBrgb7/bn7vD5Oj/Bz3
gFJzOR6uWHpfZ0Dzj00M2f5A1JMxvht0O7SSz6jZU4CYV/5SBNtqqKyY7/9r8Rhb
IOEwcAAsYq7B11mYul7w6Nlq6VDT23i/06IUiw9YE5MSjffTK2W8bVpio2p/7e37
b9USOWyMnRQCYDfx7L1ycEHKLKt8d5o72xFtg06A361S7/IkRvwB60ceME5gYh7G
JoLkHyO4Ln/jR+EfpZ81+D39fSExD/oIPwGONLJoaDtYc/7WOzgKQOZZunDAgj6y
aWqt/RqDSCbTEBiP+QrA9aDISryujcQW6UAh9fv4En0hgUOo+8eJ8J3XgOJpaQK/
0radFTYtb/Tgr38VJAZ6HE/3BxK+QEjNF8WeKUxjEI3DF7ktk6y96I0JWny9Y2dx
Rj7RPMmVs4W6T+2Zvw59cSg+AxsE8yVd72irJQiWBf8deYIOWKI=
=wjSy
-----END PGP SIGNATURE-----

--rT1QjSzXz5lcnfNmeAn3MsIxWp2XqUBVV--

