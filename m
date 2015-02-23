Date: Mon, 23 Feb 2015 17:18:33 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20150223161832.GN8134@...1296...>
References: <20140827093409.GA659@...1900...> <20150223155132.GA28440@...2018...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y/C4Z0ZQWa14ewtO"
Content-Disposition: inline
In-Reply-To: <20150223155132.GA28440@...2018...>
Subject: Re: [Openvpn-devel] Add support for Keying Material Exporter [RFC
	5705]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Daniel Kubec <niel@...1898...>
Cc: openvpn-devel@lists.sourceforge.net

--y/C4Z0ZQWa14ewtO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Feb 23, 2015 at 04:51:34PM +0100, Daniel Kubec wrote:
> Keying Material Exporter [RFC 5705] Patch rebased to actual master
> branch.

There definitely needs to be much(!) more documentation about this, maybe=20
an extra .txt file under doc/ - I still(!) have *no* idea what this is=20
useful for, or how to use it, so right now this is "extra code complexity
with no well-explained gain" to me.

I understand that David understands this, but we really really need to=20
have documentation understandable to non-crypto-geeks about it before it=20
can go in.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--y/C4Z0ZQWa14ewtO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVOtS2KkuBuNlUUl1AQLO8QQAvHYRZaNxxSPuvfN0jUH/HaW999smoEGj
wjOpFY1VLkqr4ephU8GvaKSXmwXwacT4hNHnO6NxWPUFtYB7fB4pRLAI+H8+FQxV
J9BPAVXzYCCYgLCaab8JFG6jmSYrpdJ0wgzDX/gX8LTUke86FvHI+V+g3pEsdgtI
sdzv/3FwFrw=
=i80o
-----END PGP SIGNATURE-----

--y/C4Z0ZQWa14ewtO--

