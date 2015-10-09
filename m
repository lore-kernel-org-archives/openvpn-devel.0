Date: Fri, 9 Oct 2015 15:39:50 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20151009133950.GN22054@...1296...>
References: <1444393757-21376-1-git-send-email-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZQ93ZA/51YEIDw4/"
Content-Disposition: inline
In-Reply-To: <1444393757-21376-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Support for disabled peer-id
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--ZQ93ZA/51YEIDw4/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Oct 09, 2015 at 03:29:17PM +0300, Lev Stipakov wrote:
> +	  peer_id_disabled =3D peer_id =3D=3D 0xFFFFFF;

The general patch is fine, but while this line is technical correct, I don't
think we should do so...  please add least add some brackets...

	  peer_id_disabled =3D (peer_id =3D=3D 0xFFFFFF);


> +		      /* TODO: support for disabled peer-id */

What is this TODO about?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ZQ93ZA/51YEIDw4/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVhfDpqkuBuNlUUl1AQKkwQP/XtN3oXuBhP2ZtZkqw1SYhQA1nV+380k+
Fi6qRZOlIAfGlY6Y/AKKtaEUnnCRisyqSOvjvd9ilQFoOUK9S9AI1bcsNgdwOEii
5RSJv4IniSbR12bKvts9j1vVh+I8SfW689OuS/g2SQxVzx4Kuj6fXoCPMZkknJQ6
EjGkqZPSkWo=
=8GAv
-----END PGP SIGNATURE-----

--ZQ93ZA/51YEIDw4/--

