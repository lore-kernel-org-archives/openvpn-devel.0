References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
	<f55ae849-32a0-5f7e-829f-1158bc3d68fc@...2080...>
	<3a78050c-8c18-d54e-fc37-330272de6d44@...2080...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <57d3acb0-a7c5-1535-77cc-4aac756ba6ab@...1856...>
Date: Wed, 14 Dec 2016 23:45:11 +0100
MIME-Version: 1.0
In-Reply-To: <3a78050c-8c18-d54e-fc37-330272de6d44@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hGLFQekqMLSntC0Nhw3SMNkvFpTTL2OA6"
Subject: Re: [Openvpn-devel] Coding style clean-up ... phase 1
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
--hGLFQekqMLSntC0Nhw3SMNkvFpTTL2OA6
Content-Type: multipart/mixed; boundary="8NWoKWWN0xeG3sEr418NcnM2nLjnI6Q4u"
From: Steffan Karger <steffan@...1856...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <57d3acb0-a7c5-1535-77cc-4aac756ba6ab@...1856...>
Subject: Re: [Openvpn-devel] Coding style clean-up ... phase 1
References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
	<f55ae849-32a0-5f7e-829f-1158bc3d68fc@...2080...>
	<3a78050c-8c18-d54e-fc37-330272de6d44@...2080...>
In-Reply-To: <3a78050c-8c18-d54e-fc37-330272de6d44@...2080...>

--8NWoKWWN0xeG3sEr418NcnM2nLjnI6Q4u
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 14-12-16 22:18, David Sommerseth wrote:
> On 13/12/16 22:42, David Sommerseth wrote:
>> So the first phase of the great reformatting is on its way.  I have
>> just pushed out a reformatting branch to the following=20
>> repositories:
>=20
>> https://github.com:OpenVPN/openvpn.git=20
>> https://gitlab.com:openvpn/openvpn.git=20
>> git://git.code.sf.net/p/openvpn/openvpn

> An updated reformatting branch have been pushed out.  If you have
> already fetched the it, git will most likely complain as to make
> these tests flow reasonably well without cluttering the git tree
> too much we have used forced pushes on this branch.

Great, getting really close now!  I just verified that commit
81d882d5302b8b647202a6893b57dfdc61fd6df2 is the result of running the
reformat-all.sh script from commit
2417d55c4945d491e528dd0e4cf24047da5ceae9 on that commit.

Scrolling through the changes almost everything looks good to me.  Some
details will need to be fixed when we touch the code, but in general
this looks like a *huge* improvement.

I also ran my usual tests: 'make check' including t_client for both
openssl and mbed TLS.

All this looks good, so ACK on merging
81d882d5302b8b647202a6893b57dfdc61fd6df2 into master.

-Steffan


--8NWoKWWN0xeG3sEr418NcnM2nLjnI6Q4u--

--hGLFQekqMLSntC0Nhw3SMNkvFpTTL2OA6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYUct9AAoJEJgCyj0AftKIHYAH/RSdjmJDMktFa3vUWCpC/+Kd
xw7TT3QnVpqSUIlOMqPe8qFFOHGhPkTv1EySBc7e2s8xLYYvHY1/9gAduhmR/JC9
GE5cDo7cMRfvvWN+ed8I9om//bWJyKsoS5PI5D3f57jHvXNaE9I8xfiJLywCmlNs
/zAEzLk3a2HBJ819HJXwskMoTyOTpaLhn9R/57LAPWqlgvst7LOQ0a3YzCTN6Vkj
ZnYSvv8aO0Q7dY73joCDEz6v5nb7VztHG3KSNcPwFvvXsMIyXz5UzPLvU4UTgE9S
6pnP9PSxQWumXECiPa1qd3kpTSLzNCNcBNBZY5HadcmFsiy0I0a1clrOO9kQEus=
=KKqL
-----END PGP SIGNATURE-----

--hGLFQekqMLSntC0Nhw3SMNkvFpTTL2OA6--

