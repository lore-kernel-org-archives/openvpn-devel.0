Date: Thu, 10 Apr 2014 16:29:37 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140410142937.GZ16637@...1296...>
References: <20140406083549.GG16637@...1296...>
	<20140406085311.GH16637@...1296...>
	<20140407201711.GN16637@...1296...>
	<53430F50.4040709@...1227...>
	<20140408191204.GH16637@...1296...>
	<5346A91B.8070505@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CK5rkE5r1uaV/Nls"
Content-Disposition: inline
In-Reply-To: <5346A91B.8070505@...1227...>
Subject: Re: [Openvpn-devel] getaddrinfo() confusion / way forward?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--CK5rkE5r1uaV/Nls
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 10, 2014 at 04:22:19PM +0200, Arne Schwabe wrote:
> Am 08.04.14 21:12, schrieb Gert Doering:
> > Well, it's an interesting turn of events :-) - I'll commit that with
> > you as an author, and signed-off-by: lines from both of us.  OK?
> Okay for me.

Committed, and pushed.

commit 891636cb397e02d6e283da7e1926a5ca6cd11b02
Author: Arne Schwabe <arne@...1227...>
Date:   Mon Apr 7 22:12:05 2014 +0200

    Work around Solaris getaddrinfo() returing ai_protocol=3D0
...
    Signed-off-by: Gert Doering <gert@...1296...>
    Signed-off-by: Arne Schwabe <arne@...1227...>
    Acked-by: Gert Doering <gert@...1296...>
    Acked-by: Arne Schwabe <arne@...1227...>

"close cooperation" :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--CK5rkE5r1uaV/Nls
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU0aq0akuBuNlUUl1AQLl9AP+Mr0VIXB3PgAiYvXCWTQhRVyMLO0dC5EF
LYLeLQ9DkNF9eNw7XbztVNPvQckAyKIOreHk3Ge3OfbUa/891rbTfQvEZ9Y3oyva
y1X0tywABHjhOTTB+slEBjbeIMZaMjAO0a3F3P9zlFtpZqniglu8+oCwqo9lSToa
a88+k35fCnA=
=k/Hd
-----END PGP SIGNATURE-----

--CK5rkE5r1uaV/Nls--

