Date: Thu, 25 Oct 2012 19:28:25 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20121025172825.GQ742@...1296...>
References: <CA+=Fv5QP9FY3AZoxfV62kG7rP0mU3Ad2UVtzt_LGTYONUJW9PA@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lvzXnIqIiPbDUI27"
Content-Disposition: inline
In-Reply-To: <CA+=Fv5QP9FY3AZoxfV62kG7rP0mU3Ad2UVtzt_LGTYONUJW9PA@...278...>
Subject: Re: [Openvpn-devel] openvpn on solaris
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Magnus Lindholm <linmag7@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--lvzXnIqIiPbDUI27
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Oct 25, 2012 at 06:24:20PM +0200, Magnus Lindholm wrote:
> with openvpn-2.2.2 I get "unable to redirect default gateway -- Cannot
> read current default gateway from system" on my solaris sparc box.
> Maybe I missed something but I solved this by putting together some
> code into a patch to route.c that lets openvpn read the default
> gateway correctly on solaris boxes (.SunOS 5.11 snv_151a sun4u) Let me
> know if anyone is interested in incorporating this functionality into
> openvpn

Please send the patch, then we'll see :-)

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
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUIl2uakuBuNlUUl1AQIiiAP+I8U1brVFCBtSC9eAVPUifLFRVkau02W9
SjsSuOnE9SXvf2AMOAwmAprdYItfy5d5BJ6v9NNbVjC6PZUCmC5ySHjOSIVjVqGw
V6Il53nhqhcDJ3vMU+9SAkcyKPeLurFxFYFt7FWn9V985GQAdI6FGSdRqLuFGkXg
XzIxqh2gMpM=
=Hbxs
-----END PGP SIGNATURE-----

--lvzXnIqIiPbDUI27--

