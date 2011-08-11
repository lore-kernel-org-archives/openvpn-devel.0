Date: Thu, 11 Aug 2011 17:54:17 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110811155416.GS8496@...1296...>
References: <1313075986-26862-1-git-send-email-heiko.hund@...1489...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GcLbzumBudVYaWfy"
Content-Disposition: inline
In-Reply-To: <1313075986-26862-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH] remove legacy code to query IE proxy
	information
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

--GcLbzumBudVYaWfy
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 11, 2011 at 03:19:46PM +0000, Heiko Hund wrote:
> The code in ieproxy.[ch] is not used anywhere in OpenVPN anymore.
> So, there's no need to keep it.

ACK!  (This is great, and fully inline with one of the goals for 2.3=20
"cleanup accumulated cruft" :) ).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--GcLbzumBudVYaWfy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTkP7KKkuBuNlUUl1AQKoDQQAlsLKr75u5kV0+StUAItJabcOEf6KqhnJ
u9LGNHOs1ReZlTlBYS2dYAQuKz5VmIRaqqcUlPdHTUb4PGcZG3DeHIHZN/P0OQrD
lo1NJONxpy3sKixvQdrEbY6Zcfm2ojmJpcKAfTz0WHGStjc8109HEf/WHgHce/SR
7LlnIYjViaE=
=QKaj
-----END PGP SIGNATURE-----

--GcLbzumBudVYaWfy--

