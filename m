Message-ID: <53163C6D.7050801@...1227...>
Date: Tue, 04 Mar 2014 21:49:49 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1393929449-423915-1-git-send-email-vvk@...1868...>
In-Reply-To: <1393929449-423915-1-git-send-email-vvk@...1868...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="ad8ieUuPVJNvC3JJDc2rkjJoPoof9WavV"
Subject: Re: [Openvpn-devel] [PATCH] Extract MAC addresses from ARP packets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Vladimir V. Kamarzin" <vvk@...1868...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ad8ieUuPVJNvC3JJDc2rkjJoPoof9WavV
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 04.03.14 11:37, schrieb Vladimir V. Kamarzin:
> From: "Vladimir V. Kamarzin" <vvk@...1868...>
>
> When working in TAP mode, openvpn at server side maintains mapping table
> "MAC" -> "client". It needs to know what MAC belongs to what client to
> be able to forward traffic.
>
> Before this change extraction of MAC addresses was performed only from
> ethernet headers of packets, coming from the client. This patch
> introduces extraction from ARP packets.
>
> Why extraction only from ethernet header may be not enought? Obviously
> in such cases, when MAC in ethernet header differs from ARP message
> "Sender Hardware Address" field. For example, one device (A) performs
> handling of ARP traffic for other device (B) on the client side (C)
> connected to server (S) via TAP (server bridge mode). Unless (B) send
> some traffic to server-side network, it will be inaccessible because ARP
> handling performed by (A) and not (B) itself.
>
>
OpenVPN basically just emulates a learning switch. Learning switches
also don't need these special logic. If your setup does not work with
OpenVPN then either

a) it won't work with a learning switch either or
b) OpenVPN learning switch implementation has a bug

I would like to have either a) confirmed or b) fixed than to included a
band aid.

Arne


--ad8ieUuPVJNvC3JJDc2rkjJoPoof9WavV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (Darwin)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMWPHIACgkQe8+cMNS4zRfFTgCfdfAiJQFrXCMg+AWeUbuBXq6Q
9S0AoJ/1/goI5x7mF/Vtc+YXl9A6aFCN
=Jtf+
-----END PGP SIGNATURE-----

--ad8ieUuPVJNvC3JJDc2rkjJoPoof9WavV--

