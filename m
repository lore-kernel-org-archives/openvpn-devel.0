Subject: Re: [Openvpn-devel] Protocol Change policy
From: Jan Johansson <jan.johansson@...1...>
In-Reply-To: <03d501c221f7$26727830$1000000a@...4...>
References: <03d501c221f7$26727830$1000000a@...4...>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-6laI/ma7N2WXRdItdQwi"
Message-Id: <1025687775.1385.63.camel@...2...>
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
Date: Wed Jul  3 02:17:05 2002
To: James Yonan <jim@...3...>
Cc: openvpn-devel@lists.sourceforge.net

--=-6laI/ma7N2WXRdItdQwi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-07-02 at 20:34, James Yonan wrote:=20
> I'd like to hear your opinions on how the OpenVPN project should handle
> patches which break backward compatibility.
> Here are some answers that come to mind:
>=20
> (1) Accumulate such patches and merge them all at once in a future release
> such as 1.3.0 or 2.0.0, while warning users that this release will not be
> backward compatible.

I'd prefer this one. Even though ssh seems to work nicely, you wind up=20
(at least when you have versions 1.3, 1.5 and 2) with lots of weird code
that you can't figure out if it runs or not.

I'd like the more clean model without too much #ifdefs. With several
platforms and stuff, you'll have enough of those anyhow. =3D)

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

--=-6laI/ma7N2WXRdItdQwi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9IsDeNJYxu+mj1OkRAjy/AKDcJEwe6eRVKT7yYOaCuwpfn9ty7QCeLMvK
tgZ2Ydvsn/KR8fQ+9HoF8Hs=
=TtDy
-----END PGP SIGNATURE-----

--=-6laI/ma7N2WXRdItdQwi--


