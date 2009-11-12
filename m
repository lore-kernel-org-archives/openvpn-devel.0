Message-ID: <4AFC0EB7.6050409@...1114...>
Date: Thu, 12 Nov 2009 14:33:43 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] providing certificate SHA1 fingerprint in
	environment table
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi,

I've rebased and rewritten the patch which gives SHA1
fingerprints/digests of the certificates in the environment table for
plug-ins and scripts.

The patch can be downloaded here:
<http://sourceforge.net/projects/eurephia/files/OpenVPN/OpenVPN%20eurephia%20patches/openvpn-2.1_rc21_eurephia.patch/download>

The rewriten patch makes now use of the code practice which is found
other places in OpenVPN, and it is not as intrusive as earlier.


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkr8DrMACgkQDC186MBRfrpToACgkyo1iv0qut6nJm+xeYJ4FE8T
aIQAn0BKTA1Q4h/3arAn6UYsuTHCf/XA
=7QOo
-----END PGP SIGNATURE-----

