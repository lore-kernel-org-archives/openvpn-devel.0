Date: Wed, 22 Apr 2020 10:21:52 +0200
From: Christian Hesse <list@...1798...>
Message-ID: <20200422102152.273bd40d@...1799...>
In-Reply-To: <20200421185953.GC1431@...1296...>
References: <2b5fbffa-6b18-2226-5b29-7c6be670413b@...1800...>
 <20200421183735.GB1431@...1296...>
 <20200421185953.GC1431@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Tw96ooEgEM.c+J5FbqSn3AV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Subject: Re: [Openvpn-devel] [Openvpn-users] new openssl = new OpenVPN
 release ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: mike tancsa <mike@...1800...>, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--Sig_/Tw96ooEgEM.c+J5FbqSn3AV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gert Doering <gert@...1296...> on Tue, 2020/04/21 20:59:
> Hi,
>=20
> On Tue, Apr 21, 2020 at 08:37:35PM +0200, Gert Doering wrote:
> > On Tue, Apr 21, 2020 at 02:15:43PM -0400, mike tancsa wrote:=20=20
> > > =C2=A0=C2=A0=C2=A0 Will the sec issue with OpenSSL force a new releas=
e of OpenVPN ?
> > >=20
> > > https://www.openssl.org/news/secadv/20200421.txt=20=20
>=20
> So, speaking to myself again :-) - I've looked at the advisory, and
> it talks about "Server or client applications that call the=20
> SSL_check_chain() function".
>=20
> Which we don't, I just grepped through our source tree.
>=20
> So, unless I misunderstand something about OpenSSL intricacies, I think
> we're safe - no new installers needed, and OpenVPN is not in risk.

Are you sure that openvpn code does not call any openssl function that calls
SSL_check_chain() then? Did not check, but I guess that's possible.
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/Tw96ooEgEM.c+J5FbqSn3AV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAl6f/qAACgkQiUUh18yA
9Hb/hQgAgZbNcFD12nilHGHI9cyIcheQDa3OTJJ4LTxe7Q7uA7iBaV1TjSLo1wPW
WcQ1QxoLvPeVNhQVArxW4aWWzOt0a5EwxoLQKl0xDdD3TblFhlPWdVaOaAM87+pU
6g0J7Ol3iPQdx/5aO1YzymCNtRkZAaxZz66n4TrS/8zHy8InrBIQelE1lfCoXoGi
GX/27qGVxuv4VCr7wkosEVbhxCQu3C2qMVUxyojysatPWQq/tHFOOsgSVpvoD6JZ
iLr1/64TIdFO1B6qlZd5oQof2UD1QhJngR7bq0Gn4P6YHl9h4BEAZt0pXh6KKO6V
HxbIQ6e8KS4cUwq/ZHrjjIQDz3NUIQ==
=KlXO
-----END PGP SIGNATURE-----

--Sig_/Tw96ooEgEM.c+J5FbqSn3AV--

