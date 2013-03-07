Date: Thu, 7 Mar 2013 19:42:36 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20130307184236.GF953@...1296...>
References: <alpine.DEB.2.02.1301291154270.3577@...1804...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AXAqmCxJPvkQLT2P"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1301291154270.3577@...1804...>
Subject: Re: [Openvpn-devel] #172: NTLM auth does not work with SQUID proxy
	server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Joerg Willmann <joe@...1803...>
Cc: openvpn-devel@lists.sourceforge.net

--AXAqmCxJPvkQLT2P
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jan 29, 2013 at 11:55:25AM +0100, Joerg Willmann wrote:
> The patch attached to #172 solved my problem and seems to be reasonable.
>=20
> I'm just wondering what it takes to make this issue being accepted. (Sorr=
y=20
> I didn't find a description of this process in=20
> wiki/DeveloperDocumentation).
> Does it just take time or is some input required?

Thanks for your patience.  I have now committed this to master and
release/2.3, and will push ASAP.

commit f8ac53b98ed2513f1d80363b6fd2351f1b4ae511 (master)
commit 55058d4f96dfec96e9f0cad7802a5eaaf9a3301f (release/2.3)

Author: Christian Niessner <openvpn@...1812...>
Date:   Thu Mar 7 19:37:58 2013 +0100

    Fix corner case in NTLM authentication (trac #172)
=20=20=20=20
    The problem is located in the file proxy.c within
    "establish_http_proxy_passthru": To keep buffers small long
    base64-encoded NTLM-Strings are truncated.
=20=20=20=20
    But the truncating is done on a wrong place: base 64 strings can be
    cut every 4 chars. the buffer is 128 bytes - including the terminating
    \0, so the usable data is only 127 bytes. And decoding a 127 char
    base64 string fails... this is why the ntlm authentication fails in
    certain cases (long strings)...
=20=20=20=20
    Acked-by: Joerg Willmann <joe@...1803...>
    URL: https://community.openvpn.net/openvpn/ticket/172
=20=20=20=20
    Signed-off-by: Gert Doering <gert@...1296...>

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--AXAqmCxJPvkQLT2P
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUTjfnKkuBuNlUUl1AQIbwwP+MTGwD39RzfUhu4IHG7JewYKaWszE+m0n
uEC4xhiAt8ABtCl66CaxTKRDdodkirt8Ci1wLgV4Z2xZuYbFVK1FBGHSZldfdAlC
bE9UiVfWKEdlPr3ktlq8NPWY66tqr62MQ2jrjjJkcdAhSGLwi8uNmHBoQlJxdb4a
CzuIQ0PBfJE=
=j8bu
-----END PGP SIGNATURE-----

--AXAqmCxJPvkQLT2P--

