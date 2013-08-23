Date: Fri, 23 Aug 2013 11:16:27 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130823091626.GW16543@...1296...>
References: <521668C9.5070003@...515...> <3175682.0C6cFygpIW@...1526...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b1CVx77D595wdcW8"
Content-Disposition: inline
In-Reply-To: <3175682.0C6cFygpIW@...1526...>
Subject: Re: [Openvpn-devel] Proposed change to allow use of statically
	linked OpenSSL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

--b1CVx77D595wdcW8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 23, 2013 at 10:00:04AM +0200, Heiko Hund wrote:
> I see no potential for breakage, so ACK.

committed and pushed to master and release/2.3

commit 30e358e5de352c8de04a955dc89f33e1710e9b97 (master)
commit 588c5fe795169c6b53e8e61f060714c1334b8e8e (release/2.3)

test-built with a dynamic openssl on Linux (no breakage).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--b1CVx77D595wdcW8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUhcoaqkuBuNlUUl1AQIFqwQArNmAGnELsXRjqMqpB+ND+VXILkzl3cUR
P0e33TVTNi/kPGy+OCrWchNlbOcfTswxw4bD83Rwo+l1WjJ5YOXZNuytlfL+H+tD
iywUTHHrhmgqYS1+Xc9VGHcdfPt4cf9/oSwLU8wannaclMplkiS7ZCe6N9w9MS8n
6nYXpQ002Xg=
=0GsC
-----END PGP SIGNATURE-----

--b1CVx77D595wdcW8--

