Date: Tue, 20 Oct 2015 15:52:34 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20151020135234.GM22054@...1296...>
References: <1445347379-29943-1-git-send-email-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+3N0iaIwLQJ9Oyk"
Content-Disposition: inline
In-Reply-To: <1445347379-29943-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Replace variable length array with
	malloc
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

--x+3N0iaIwLQJ9Oyk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Oct 20, 2015 at 04:22:59PM +0300, Lev Stipakov wrote:
> Commit https://github.com/OpenVPN/openvpn/commit/685e486e8b8f70c25f09590c=
24762ff734f94a51
> introduced a variable length array. Although C99 supports that, MSVS 2013=
 still requires
> size of array to be compiler time constant. As a fix, use OPENSSL_malloc/=
free.

Why OPENSSL_malloc() in particular?

(As I have no clue about the intricacies of openssl-interfacing code, this
might be a stupid question, but it looks like "normal gc_malloc() should
be perfectly fine")

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--x+3N0iaIwLQJ9Oyk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBViZHIakuBuNlUUl1AQK3/QQAua1SYbkcG38U0ovMo38HGE1ZpDdv9VQg
VB9BfC6Rqol00nnzlT5Z+AU838n4Ve5LJmfX1hCDFHf3sdu/GdNNHIfGqbCesAf8
y4khKWWF5OAqTlsY3tXA7qAgFl594Z/aFGf6gSy9x6IitqJHlZNpWKusZznWobgh
fmSeosM6ueo=
=5LRy
-----END PGP SIGNATURE-----

--x+3N0iaIwLQJ9Oyk--

