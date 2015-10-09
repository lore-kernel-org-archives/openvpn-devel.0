Date: Fri, 9 Oct 2015 17:08:05 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20151009150805.GQ22054@...1296...>
References: <20140509162908.375CFE0247@...1914...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a6YTfLRor63AaheO"
Content-Disposition: inline
In-Reply-To: <20140509162908.375CFE0247@...1914...>
Subject: Re: [Openvpn-devel] [PATCH] Export --redirect-gateway parameters
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Paul Stewart <pstew@...1913...>
Cc: openvpn-devel@lists.sourceforge.net

--a6YTfLRor63AaheO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, May 09, 2014 at 09:23:01AM -0700, Paul Stewart wrote:
> Report the flags passed to the --redirect-gateway and
> --redirect-private flags, so that systems that manage routing
> tables have hints about how the routing table should be modified.

I mentioned that we don't have enough time, and so it was - apologies for
not looking into this more quickly.

We discussed this today, and while the code is good enough, it needs to
satisfy the "why is this needed?" requirement - could you explain a bit
better what this would be used for?

(The drawback of this patch is that it needs maintenance if we add
new options, like "--redirect-gateway ipv6" - David suggested that we
add a global mapping table for that, and I wonder if the actual use
case warrants the extra maintenance effort...)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--a6YTfLRor63AaheO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVhfYVKkuBuNlUUl1AQKgnwQAu49o5xx5X3+K62l76924VL+gGPsfpZI/
4zrzFYunwldjsSF2IrGNx6RAcJB7f0Tl4Fv8fXdXXMxcRPkuDScMkLQ8CpvhzV0L
ltIUemjiwy4IPE0jdQrITqyh3Y3XXKproFkok/FVXWwb2Ycx8h9Nb0B2PiSIoGDA
fQYbTuynufQ=
=39tF
-----END PGP SIGNATURE-----

--a6YTfLRor63AaheO--

