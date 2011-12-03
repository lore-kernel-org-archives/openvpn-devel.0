Date: Sat, 3 Dec 2011 11:12:45 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111203101245.GF8496@...1296...>
References: <1322840064-30528-1-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ySLh/fXpNxWaNtMt"
Content-Disposition: inline
In-Reply-To: <1322840064-30528-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Don't look for 'stdin' file when using
	--auth-user-pass
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

--ySLh/fXpNxWaNtMt
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Dec 02, 2011 at 04:34:24PM +0100, David Sommerseth wrote:
> This argument allows the keyword 'stdin' to indicate that the input
> is to be read from the stdin.  Don't check for file existence if the
> file name is set to 'stdin'

ACK.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ySLh/fXpNxWaNtMt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTtn2HakuBuNlUUl1AQIeGAP/XHN4SlDSenE1NETTer1MPCr0sTQ+hmXu
IKNa9ZY58POnyFgRz8W2pg10coo2t7tu1Ab3U7SkXyDKNWv+OW07uvPQJzV4ODlW
yk9qfjjErSV7AEbZ3ZR31NJAHZJ+uqocX9BfV9CoYnAko0kYn3XG+Zq8uWwlPtCU
vgM4wjCsfLk=
=78G8
-----END PGP SIGNATURE-----

--ySLh/fXpNxWaNtMt--

