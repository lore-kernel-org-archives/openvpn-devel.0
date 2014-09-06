Date: Sat, 6 Sep 2014 14:03:57 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140906120357.GA1118@...1296...>
References: <1409930731-15263-1-git-send-email-davids@...1347...>
	<1409930731-15263-3-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LfkXUpJB8bp103ra"
Content-Disposition: inline
In-Reply-To: <1409930731-15263-3-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH 2/4] Don't try to use
	systemd-ask-password if it is not available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: davids@...1347...
Cc: openvpn-devel@lists.sourceforge.net, fcrozat@...1519...

--LfkXUpJB8bp103ra
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Sep 05, 2014 at 05:25:29PM +0200, davids@...1347... wrote:
>    return (lstat("/sys/fs/cgroup", &a) =3D=3D 0)
> -	  && (lstat("/sys/fs/cgroup/systemd", &b) =3D=3D 0)
> -	  && (a.st_dev !=3D b.st_dev);
> -
> +    && (lstat("/sys/fs/cgroup/systemd", &b) =3D=3D 0)
> +    && (stat(SYSTEMD_ASK_PASSWORD_PATH, &c) =3D=3D 0)
> +    && (a.st_dev !=3D b.st_dev);

ACK on the code, NAK on the indent change.   The old code had tabs there,
the new one has spaces - and not enough of them anyway.

For clarity, you might want to keep the "a.st_dev !=3D b.st_dev" comparison
befor the stat() on SYSTEMD_ASK_PASSWORD_PATH, as the comparison belongs
to the /sys/fs/... stuff, not to the third stat().

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--LfkXUpJB8bp103ra
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVAr4LakuBuNlUUl1AQJ7HAP+PjBK8yf2qCaLwzhaxaJszHTdy2A1Ps+0
q2kLlkoO4rlEBYsfWQz20N1vRrjy2ooWDOIluYmjbPvmbAFOm1FjbD9HWgW1P9Ea
dqrnnQyVUThcEGxGok8ZZ8B2MWn1NCkJnD/s6HsEnSrsbs2viNK/VHxRUFdXNxeH
sqSjj4gO4kg=
=9j7/
-----END PGP SIGNATURE-----

--LfkXUpJB8bp103ra--

