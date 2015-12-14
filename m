Date: Mon, 14 Dec 2015 09:26:19 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151214082619.GB24952@...1296...>
References: <CAKuzo_ikg1My8wt2nbycosHvOwKhrRQPO18hjdgqDreCMDbeoQ@...278...>
	<1450055187-17397-1-git-send-email-fish.thss@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yPZwCHe6H+6rrYXo"
Content-Disposition: inline
In-Reply-To: <1450055187-17397-1-git-send-email-fish.thss@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Make "block-outside-dns" option
 platform agnostic
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Fish <fish.thss@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--yPZwCHe6H+6rrYXo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Dec 13, 2015 at 05:06:27PM -0800, Fish wrote:
> Make the "block-outside-dns" option agnostic of Windows versions by dynam=
ically
> loading WFP-related functions. Cross-compiled on Linux and tested on Wind=
ows
> XP/10.
> ---
>  src/openvpn/Makefile.am |   2 +-
>  src/openvpn/init.c      |   4 -
>  src/openvpn/options.c   |  17 ++-
>  src/openvpn/win32.c     | 114 ++++++++-------
>  src/openvpn/win32.h     |   1 +
>  src/openvpn/win32_wfp.h | 361 ++++++++++++++++++++++++++++++++++++++++++=
++++++

This layout of "all the copied API bits go to win32_wfp.h" is good enough
for me (so, mails crossed here).  Thanks.

I leave the final decision on "how do we want 2.3 binaries to look like"
(single openvpn binary with copied-API bits or xp-binary and vista+ binary)
to the windows team.  Both would work for me.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--yPZwCHe6H+6rrYXo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVm59KqkuBuNlUUl1AQKFKgP9EZIFcv00Q+xqWsxzSLX/0+swSTJNJmXj
OsQkuRAnpfvxl7petDfNJQQUm/ZR8pgsYGCdkn6qxO6VnvGdoGGWb7pwcJPEhbZf
JhveQg6Steh+MGvqJ2aSZWlaRL+xXM6qKxIBU54MVIRjCa5/zb69ALhS306wequI
/3CCe9IqJuM=
=5xZg
-----END PGP SIGNATURE-----

--yPZwCHe6H+6rrYXo--

