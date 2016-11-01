Date: Tue, 1 Nov 2016 12:28:12 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161101112812.GJ28918@...1296...>
References: <1477922488-26941-1-git-send-email-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XQcRXTRNkp3cy0Cu"
Content-Disposition: inline
In-Reply-To: <1477922488-26941-1-git-send-email-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] man: Improve the --keepalive section
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--XQcRXTRNkp3cy0Cu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Oct 31, 2016 at 03:01:28PM +0100, David Sommerseth wrote:
> -.B \-\-keepalive n m
> +.B \-\-keepalive ps pto

What does "ps" stand for?  I find this not much clearer than "n"...

"pto" sounds like "ping time out", which I find halfway understandable.

Maybe make the first argument "t" for "time"?=20=20

Or "i" and "to" for "interval" and "timeout"?

Lots of options for bikeshedding here...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--XQcRXTRNkp3cy0Cu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWBh8TKkuBuNlUUl1AQKJDQP+IQMJMMIRkZ2cLx6uP8C651JyXbqm6Lk0
bJzfF/2iO7nGvfHOcZTDZf5TLimKvaxe0aY9gYnQnqJC/YJyDI/upy0CrjmmGuta
38eJ2vJVtDoLrXSvXuwntvkLbt+KSN+Nv0KGWoSwQVVAeoYphPGOeu0xka3gE/W6
an2Gf/icGtY=
=+Cj6
-----END PGP SIGNATURE-----

--XQcRXTRNkp3cy0Cu--

