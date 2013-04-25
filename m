Date: Thu, 25 Apr 2013 20:58:13 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130425185813.GB20843@...1296...>
References: <1366467768-16260-1-git-send-email-arne@...1227...>
	<1366467768-16260-5-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
In-Reply-To: <1366467768-16260-5-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 5/5] Emulate persist-tun on Android
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

--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Apr 20, 2013 at 04:22:48PM +0200, Arne Schwabe wrote:
> On Android changing the configuration of tun is not possible. So instead =
of reconfiguring the tun device, open a new tun device and close the old on=
e if needed

I'm not sure I like this patch.  Wouldn't it be easier to tackle this
in options.c with an

#ifdef TARGET_ANDROID
    msg(M_WARN, "notice: android cannot do --persist-tun, ignoring statemen=
t");
#else
    ... old code here
#endif

(if you have to reopen the tun anyway) - or does persist-tun have other=20
side effects that I'm overlooking?
=20
gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUXl8xakuBuNlUUl1AQLSSgP/VQGQscDuqW/9vUxWhG6BiHNlt8r7oRgp
HyFwybF2Apvv1vF9Kk/7d3glRalV9mvLoFBJZs/k8/RO562xQn5ZF0DV3GrZE1NX
LAozZecWsfJf0AgiOfU5V/9xcgWsgL9uj/8WYAp//3XwoGUDx34/kg7y47HOCiKY
dQm8TIkj1kE=
=y6Gv
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--

