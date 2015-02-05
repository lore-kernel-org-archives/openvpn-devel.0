Date: Thu, 5 Feb 2015 11:55:44 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20150205105544.GN8134@...1296...>
References: <CAB7qsSN2BzxzuY2hfqE59U+5dw4+wdGGOfUrXRQ4YmoMwAt4Mw@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lvzXnIqIiPbDUI27"
Content-Disposition: inline
In-Reply-To: <CAB7qsSN2BzxzuY2hfqE59U+5dw4+wdGGOfUrXRQ4YmoMwAt4Mw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix CN maximum length
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jorge Luiz Silva Peixoto <jorge.peixoto@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--lvzXnIqIiPbDUI27
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Feb 04, 2015 at 02:01:58PM -0300, Jorge Luiz Silva Peixoto wrote:
>                  subject,
> -                TLS_USERNAME_LEN);
> +                TLS_USERNAME_LEN-1);

As David has remarked, this is not really easy to understand - better
keep this at 64, and ensure the buffers where it is used are allocated
as=20

  char[TLS_USERAME_LEN+1];		/* max len + terminating null byte */

or something like this.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--lvzXnIqIiPbDUI27
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVNNML6kuBuNlUUl1AQLIYQP/ehind2Tk1Byvwn06OzcHiMbzrm2hdj4Q
vM550zjw4WP2CBw3KrtfHkcO7s9LH0GsrNSWXWHrUIfnNwsC0FJgbHuTPeYRyUld
RH8XQTvN2kmbjG6RjjWO0ao3fAOSuxjKHyFPJaFVvbZhknwt8kNJYtLe4DNSyWFX
+Vjw05NuehI=
=xwDZ
-----END PGP SIGNATURE-----

--lvzXnIqIiPbDUI27--

