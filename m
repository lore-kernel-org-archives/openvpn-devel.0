Date: Sun, 30 Mar 2014 15:46:19 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140330134619.GT16637@...1296...>
References: <1396001222-5033-1-git-send-email-arne@...1227...>
	<CAA1AbxJCv9ff7XHv1GKtCPuB-Hc5Lv33ufPfqcTraNpFnJf7fw@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8Mfcnc8eRzVGEeu4"
Content-Disposition: inline
In-Reply-To: <CAA1AbxJCv9ff7XHv1GKtCPuB-Hc5Lv33ufPfqcTraNpFnJf7fw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix man page and OSCP script:
	tls_serial_{n} is decimal
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8Mfcnc8eRzVGEeu4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 30, 2014 at 12:48:37AM +0100, Steffan Karger wrote:
> 3 - Change OpenSSL builds to use hax representation

I tend toward this one - user visible behaviour shouldn't change (unless
unavoidable) depending on SSL library used.

So for me this boils down to "how many users are relying on the current
behaviour, which is not what the docs say it should be"?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--8Mfcnc8eRzVGEeu4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUzggK6kuBuNlUUl1AQJVEAP+L/BHDrW7z013dtyl5xULTYyoUoH2R2U4
F0fgmHTwxZ5L0gtDZ+WfgDCX4f9JRfIxjzi7way/5xUmwoInkC6V3osGJVG/1+Nn
ZDEpLzVgUIS6VninCOWR7/wqNaqKKN0a92YFvX2AUHimKC4/ky41btGYEx0GVmCR
7m7xmEQR9KA=
=B4oa
-----END PGP SIGNATURE-----

--8Mfcnc8eRzVGEeu4--

