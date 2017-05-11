From: David Sommerseth <davids@...515...>
Date: Thu, 11 May 2017 18:44:23 +0200
Message-Id: <20170511164423.1928-1-davids@...515...>
In-Reply-To: <1494358209-4568-1-git-send-email-steffan.karger@...1435...>
References: <1494358209-4568-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH applied] Drop packets instead of assert
	out if packet id rolls over (CVE-2017-7479)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: steffan.karger@...1435...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

ACK.

Your patch has been applied to the release/2.3 branch

commit b727643cdf4e078f132a90e1c474a879a5760578
Author: Steffan Karger
Date:   Tue May 9 21:30:07 2017 +0200

     Drop packets instead of assert out if packet id rolls over (CVE-2017-7479)

     CVE: 2017-7479
     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <1494358209-4568-1-git-send-email-steffan.karger@...1435...>
     URL: http://www.mail-archive.com/search?l=mid&q=1494358209-4568-1-git-send-email-steffan.karger@...1435...
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZFJTiAAoJEIbPlEyWcf3yLmIQALnv1wF4LwnVxVTxFLz3+41l
bxLI7Rkt5isMEJ6iGS6mivfajV3DWkaNTHOI2HcOtzN0OOlboUclT3Dkpk31GOCe
EgThx68E2ZNWBmr7t/cJkGHjIOs5pEorBIIzqHFUvUGfq5kOm63y2U/9tOBRpQxg
XE+Z+rtxdMQaVzQEhAv8LtFJypghoxUijZU7cj4w42yNL/G6vFlQqZl6v/B7sEoK
Yc5aOX72EbTZJUI2HcEDHGG0ZK6S5BnjoAg3u1+/ZVY1GAVNICF5EYVw3LSOoeKp
pkJ74FroxlvChohS7hobTjQJ9wnw26mkZM5faljzCWvc97r9eelMqyxd90NN8r/b
BwgKiiSJxyVQV0wqqoyjRz2VdYxKgAtjYhN+01b2JDhgVFD8fb0Lp5BzlW1qt4sp
tOgBiptbpz2lpVHeLLtjK1aIvUPq4mP8rxW+q2p++lAUZ+jhdIsGTTk1kEF6yCEJ
ExeIFMCujPdyAcLdbLJFe9IZnoYQ2tjuiHHCzvpROGW0NH2CIcDJexYIwdej68I9
9Xp6bvJCkz6ti/flF/WC0kiS0B8KqlHA/ZoHTTQAWRzwhNvjEvVmIuR8HN35626b
D7ym05llv5cfMgiArK7+Am22n0tMWV+iF1aYC5Z5/3c0BSJRNbFm4/QfZQSF/ShO
QSF+QebMj0bbeuxIebz1
=ZLZb
-----END PGP SIGNATURE-----

