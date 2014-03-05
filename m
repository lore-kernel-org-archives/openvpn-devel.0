Date: Wed, 5 Mar 2014 13:21:13 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140305122113.GT16637@...1296...>
References: <1393929449-423915-1-git-send-email-vvk@...1868...>
	<53163C6D.7050801@...1227...> <283911394015829@...1871...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PryeMBWNihx6Jibm"
Content-Disposition: inline
In-Reply-To: <283911394015829@...1871...>
Subject: Re: [Openvpn-devel] [PATCH] Extract MAC addresses from ARP packets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vladimir Kamarzin <vvk@...1868...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--PryeMBWNihx6Jibm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Mar 05, 2014 at 04:37:09PM +0600, Vladimir Kamarzin wrote:
> 5. Switch (S) does not know where is 00:00:00:22:22:22, so it sends this =
packet to all ports

Yeah, I think that's the difference.  We don't do unicast flooding ("send
frames to unknown unicast destinations to every single port") because
bandwidth on the VPN is limited & more expensive.

Adding it would solve the issue at hand, but I'm not convinced that you'll
be happy with the end - it might actually end up saturating VPN links and
making users unhappy if you have "much flooded traffic" (which happens in
some of the networks).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--PryeMBWNihx6Jibm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUxcWuakuBuNlUUl1AQJnrAP9Er+6/mUBC77xCYXmkfHiB3K1Llrs3I6o
Y4/iBoeAnvMUXRj6UzPOjN6KufjfwcLJhBAl6P55EKJALT4F0QCNQY6xO7JznqRa
vW95/4nb/kM4XxWiWns5qpKG9XHbbVQ+WCO4svfZcuvWLOpP0SQ65iInhrc8PFuP
VYqbST2ijK8=
=wqGR
-----END PGP SIGNATURE-----

--PryeMBWNihx6Jibm--

