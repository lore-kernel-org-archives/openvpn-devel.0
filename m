Date: Fri, 22 Mar 2013 16:44:54 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20130322154453.GI17727@...1296...>
References: <1363942465-3251-1-git-send-email-steffan.karger@...1435...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
Content-Disposition: inline
In-Reply-To: <1363942465-3251-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] Updated PolarSSL 1.2 support patch set
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: steffan.karger@...1435...
Cc: openvpn-devel@lists.sourceforge.net

--veXX9dWIonWZEC6h
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Mar 22, 2013 at 09:54:19AM +0100, steffan.karger@...1435... wrote:
> This patch set replaces the earlier PolarSSL 1.2 support patches. It cont=
ains all the changes in response to feedback on the previous versions, and =
should be ready to be merged.

Thanks.

I did review the patches again.  The code is fully identical to the last
set of patches in "the big thread", so nothing new in here.  The only=20
place where I'm not exactly sure what the code does is patch 1/6,=20
understanding that would need more detailed study of the polarssl 1.1=20
and 1.2 APIs (which I trust Adriaan to have done).

Compile and t_client tests on FreeBSD 7.4 succeeded, with default cipher
and default keysize, so with these we now have full compatibility in
default cipher mode between openssl-openvpn and polarssl-openvpn.

-> ACK!

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUUx8dakuBuNlUUl1AQKjqQP/bvNcq1aMA4Wulz2pfgfGV0zSnyEVPJo9
7CZv6ySLAWdLa5ebiy8RS1LNkyCYNdl3R2JUlbrPojM2tz7i4PkXBrzZRugQGOmI
DV+80O8pnbBQatpBR5KELIZPN4MEUTuKR6RkD0iyzZfJAA8Guhbx977ORLZpbgmm
1cgGs49fGik=
=8I1n
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--

