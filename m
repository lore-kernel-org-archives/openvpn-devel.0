Subject: Re: [Openvpn-devel] Default MTU
From: Jan Johansson <jan.johansson@...1...>
In-Reply-To: <01c101c225f3$932d10c0$1000000a@...4...>
References: <01c101c225f3$932d10c0$1000000a@...4...>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-DoOWoNKmg80iCG6hpBfj"
Message-Id: <1026111778.1445.4.camel@...2...>
Mime-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Mon Jul  8 00:04:01 2002
To: James Yonan <jim@...3...>
Cc: openvpn-devel@lists.sourceforge.net

--=-DoOWoNKmg80iCG6hpBfj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2002-07-07 at 22:19, James Yonan wrote:
> What should the default MTU be?
>=20
> Right now the default UDP MTU is 1500 if you use --ifconfig, which is
> probably too high, because as Matthias Andree pointed out, 1500 + IP head=
er
> size is greater than 1500 and will cause fragmentation on ethernet networ=
ks
> where the MTU is 1500.
>=20
> 1450 might make more sense because that leaves ample space for the IP
> header, forming a total packet size of less than 1500.

> So at this point a static default is certainly the simpler way to go, but
> any changes to the static default should be carefully considered since th=
ey
> would introduce backward incompatibility issues.

I'd go for 1300 or so. Even if 1450 works now, you could still encounter
more issues later that require another change. I don't think the
performance loss will be that great, since all that run TLS now with
1500-ish packetsizes probably already split lots of packets into one
large and one tiny packet as it is.

If you are to go for new major version that breaks compat, go for lower
defaults on MTU too. You might aswell backport some sort of small logic
for the older OpenVPN-track that tries the lower MTU in case it seems
like it doesn't work, or a "--compat-v2" setting.

--=20
Jan Johansson (jan.johansson@...1...)
BioMat System AB
Klarabergsgatan 37, III
SE-111 21 Stockholm, Sweden
Phone: +46-(0)8-233500, Fax: +46-(0)70-3873952

THIS COMMUNICATION IS ONLY INTENDED FOR THE USE OF THE INDIVIDUAL, OR
ENTITY, TO WHICH IT IS DIRECTED AND MAY CONTAIN INFORMATION THAT IS
PRIVILEGED, CONFIDENTIAL AND EXEMPT FROM DISCLOSURE UNDER APPLICABLE
LAW.  IF RECEIVED IN ERROR: PLEASE NOTIFY US IMMEDIATELY THROUGH
INFO@...25...

--=-DoOWoNKmg80iCG6hpBfj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9KTkhNJYxu+mj1OkRAsdUAKDLJIktDHWhlWcBKS70AFCFdhkjFgCgqO6P
YhxpqKe9zfSMZu3oCrtO6YQ=
=/R7s
-----END PGP SIGNATURE-----

--=-DoOWoNKmg80iCG6hpBfj--


