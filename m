Date: Fri, 18 Apr 2014 23:05:22 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140418210522.GE16637@...1296...>
References: <1397645317-20116-1-git-send-email-Holger.Kummert@...1516...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PZifSn3kqWtw9nOX"
Content-Disposition: inline
In-Reply-To: <1397645317-20116-1-git-send-email-Holger.Kummert@...1516...>
Subject: Re: [Openvpn-devel] Fixes for HTTP proxy authentication with NTLM
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Holger Kummert <Holger.Kummert@...1516...>
Cc: openvpn-devel@lists.sourceforge.net

--PZifSn3kqWtw9nOX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Apr 16, 2014 at 12:48:35PM +0200, Holger Kummert wrote:
> Any opinions?

Any easy way to test this, without having a Windows domain around?

(I already run a number of test cases from my t_client test sets using
socks proxy, http proxy, http proxy to ipv4 hosts over ipv6, ..., and
if I could "easily" add a proxy with NTML auth to that mix, it would help=20
ensure that we're not accidentially breaking things)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--PZifSn3kqWtw9nOX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU1GTkqkuBuNlUUl1AQLcbAP/S65c3rZP9TS/SpCDYJ83EoMKd4PZH8QD
ejqIpWjayhsz6CTdJjIeh/lGdXJBm6tCi0ozj0w3ixnLUb2ye94ShwXAKclcMo8I
0oVT8NZTfHM9ocr8hVCJBSFiVR6wC6vHkQwFwz+br+HChP0c1V+fNHQrlnlIgl2y
mhhxWTLNn10=
=03zj
-----END PGP SIGNATURE-----

--PZifSn3kqWtw9nOX--

