References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
	<CAKuzo_gH06N2yip+h-=Q_w1xpyP62d6v4-7=Bb2NK-=+ji6iKw@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <943c0ce1-501c-df5a-fb47-53ab7a689d36@...2080...>
Date: Thu, 8 Dec 2016 23:45:18 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gH06N2yip+h-=Q_w1xpyP62d6v4-7=Bb2NK-=+ji6iKw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Xm0Up0aJgIjHNKGjh1GRki7sjeBJMTB4c"
Subject: Re: [Openvpn-devel] Coding style clean-up ... phase 1
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xm0Up0aJgIjHNKGjh1GRki7sjeBJMTB4c
Content-Type: multipart/mixed; boundary="7KAEDJRU9fUO7nnkLCq5f6DTejGDQS0T9";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>
Message-ID: <943c0ce1-501c-df5a-fb47-53ab7a689d36@...2080...>
Subject: Re: [Openvpn-devel] Coding style clean-up ... phase 1
References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
	<CAKuzo_gH06N2yip+h-=Q_w1xpyP62d6v4-7=Bb2NK-=+ji6iKw@...278...>
In-Reply-To: <CAKuzo_gH06N2yip+h-=Q_w1xpyP62d6v4-7=Bb2NK-=+ji6iKw@...278...>

--7KAEDJRU9fUO7nnkLCq5f6DTejGDQS0T9
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 08/12/16 22:56, Selva Nair wrote:
> Hi,
>=20
> On Thu, Dec 8, 2016 at 4:15 PM, David Sommerseth
> <openvpn@...2080...
> <mailto:openvpn@...2080...>> wrote:
>=20
>=20
>     This is fairly inline with the initial agreement from the 2014 Munich
>     hackathon [3] and the summarized CodeStyle wiki page [4].
>=20
>     This proposal allows for the "open bracing" question, which allows
>     '} else {'  and '} else if () {'.
>=20
>=20
>     So now the bike shed debate opens up ... Is this something we can get
>     consensus around?
>=20
>     And a few examples of reformatted files:
>=20
>      tun.c: <https://paste.fedoraproject.org/501999/81229253/
>     <https://paste.fedoraproject.org/501999/81229253/>>
>      ssl.c: <https://paste.fedoraproject.org/502010/22971814/
>     <https://paste.fedoraproject.org/502010/22971814/>>
>=20
>=20
> Looks excellent.
>=20
> Yes, responding to the call for bikeshedding , some questions/comments:
>=20
> Reformatted tun.c has at least two instances of char* xxx, we want char
> *xxx, right? So why not add some sp_xxx_ptr_star options.

Good catch!  tun.c and ssl.c are the biggest files we have ... so there
might be some details we've not spotted.  Uncrustify doesn't change
things we don't tell it to change, so we just haven't spotted this.

I agree, we should change to this.

> Less of a concern at least for me is function_name (...) and
> function_name(...) both appears to be allowed. Just because we can do
> it, why not add some sp_func_xxxx_paren options to normalize those..

I agree to consistency.  And Steffan already suggested what I was about
to suggest.  I'll send an updated config file soonish too.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--7KAEDJRU9fUO7nnkLCq5f6DTejGDQS0T9--

--Xm0Up0aJgIjHNKGjh1GRki7sjeBJMTB4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYSeJ/AAoJEIbPlEyWcf3ylcEP+gN9ljuwY1Gs05zPnzuV2gmh
LW/vrN3vtmXGc1K3Dhf5TH7bm2Nnm3OYviyurCWHp2FoqDRGXn59DWippFpental
4SHpV4BlgLcYxM5bpKDFf+YBugwRrHJSnIl13N4RU2tKSQSAYs1meWXdhj3gxjE2
9UkVoL71eDMbWdRARnpz8Y/zB9+kmnlCgpZq91ZPyDHO3f3rITLkkRLvIOGg99ZZ
4Kl0fV0nKO9bjpXdXKQvJMZj5saBTUwMJfhoWnmZ2klQ0CYMRsmhUVmYherJgLUI
IRs8fgjzUssKWPe6FJQlCdtzggahYIwlGUwamOsdL7doVoVDeIliaqfT3SWP/oRL
feb/tt8E1j55JKmSFqMiZ8RskpOZEjnkQRC2YmLgqWixPNMzjoqstm+OHyz89W31
nsB5ebJ+xt281bnzFnVfNaFnIodHMyvZ5fdkYpkLLnG53GJhg/TM2PK5ecpGUXia
mlLQNnAhIIEai8FQLHXIFh4+/nt7w3upSZtQvmMfpx8tSrxvd4x/HpLFzFZmqyfo
NS6vd1zXK5B2zYNOYzbjd6wiXnzvEThXmjCSWYo4ILFbBb1i1qiWGgIBWE4ivXH6
MawqEFGsZY/dgpET2RjrSUl8jkXOJJYK8pGU8OXLjsmc8H+M3CMScYBnqLliYIi4
SMcTMIe2WLcTgKDYKhSz
=CRgv
-----END PGP SIGNATURE-----

--Xm0Up0aJgIjHNKGjh1GRki7sjeBJMTB4c--

