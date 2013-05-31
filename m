Date: Fri, 31 May 2013 09:38:14 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130531073813.GU20843@...1296...>
References: <1369949255-7302-1-git-send-email-arne@...1227...>
	<1369949680-9499-1-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1o9jrj+SkgBpwUj4"
Content-Disposition: inline
In-Reply-To: <1369949680-9499-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [Patch v2] Fix #ifdefs for P2MP_SERVER
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

--1o9jrj+SkgBpwUj4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, May 30, 2013 at 11:34:40PM +0200, Arne Schwabe wrote:
> -#ifdef P2MP_SERVER
> +#if P2MP_SERVER

ACK.  Sorry for overlooking that.

(For the rest of the audience: P2MP_SERVER is one of the #define-s that is
always #define'd - it's either "#define P2MP_SERVER 1" or "... 0", so
with #ifdef, it will always be matched)

Will commit ASAP.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--1o9jrj+SkgBpwUj4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUahTZakuBuNlUUl1AQL1/AQAvsq4xy0WrozIkriiqUgMSXS0dUMNQ+pQ
J4nVDQRWC5g/0RHKW05qwVtUAbUgdwkQuv1h5m72pHa/zwNXSZ+/FXKpkNE8a/q5
mbCmtLFpSFFJeqwvbRXPkvwyWlKIQYEI7z8v4ZeHl/V+ba/Pw5ftq9OpMb7b74L+
u+RbXYzIN3E=
=x9Cd
-----END PGP SIGNATURE-----

--1o9jrj+SkgBpwUj4--

