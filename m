From: David Sommerseth <davids@...515...>
Date: Fri,  2 Dec 2016 00:27:13 +0100
Message-Id: <1480634833-5339-1-git-send-email-davids@...515...>
In-Reply-To: <20161201213104.5667-1-list@...1798...>
References: <20161201213104.5667-1-list@...1798...>
Subject: Re: [Openvpn-devel] [PATCH applied] Use systemd service manager
	notification
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
To: mail@...1798...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

ACK.  Code looks good and does what it promises.  This also
improved the situation where OpenVPN needs username/passwords
from the console.  So this is indeed a far better solution.

The patch got also fairly good testing on a relatively short
time, across multiple systemd based distributions, client and
server profiles, even some configurations with explicit errors.

Your patch has been applied to the master branch

commit c5931897ae8d663e7e6244764fc6379d7b4740f3
Author: Christian Hesse
Date:   Thu Dec 1 22:31:03 2016 +0100

     Use systemd service manager notification

     Signed-off-by: Christian Hesse <mail@...1798...>
     Tested-By: Richard Bonhomme <fragmentux@...277...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20161201213104.5667-1-list@...1798...>
     URL: http://www.mail-archive.com/search?l=mid&q=20161201213104.5667-1-list@...1798...
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYQLHEAAoJEIbPlEyWcf3y/gUQAJwqRYi5s0QcMyBhsdY3gRVd
kzU+OXiDXZtO/QgMN45rWpdZxAkp2IUxe3tFDEdQjzPsdcCRWL41l9dZcIxAuNEb
MHsv33/QUsH90svWGdhVH/nTf2ySR0rS3rLCuBCrwDfdm3mC7kQN7wsjaSRGcUIC
AdL5eAbDzrIntDJKXtN+m78lgpZ9zng2w2FHsizJcD2zLsjjSJgJNSO4fIyXs0D8
GZ/W1Ex1d4eMficWHKH6CYmj0dX0c6010X5lVdmT/d25TofahQBPReha0ej3jpAo
5dHtel4nGw+m5ooBa7tOnC5bWp8K7RAr8Vau6+sMhy9LabNZ5BY5Z0cBi/p0ViXx
hzlVFBCiVuXtEZhz9yHEp/uNbvnUNBfqzauyFmz7Obyyog3HWx7p5IM8LC7CNZF8
sL3wdSzxp7JFQrKl5vQb1MRAmmQZc/+DClLOxtdxX7bj3nc2wiP6C1iLoe+BvEZA
9tJIyfkh7oxM2Ec0Lt1yC7zMh+rknC5H6MffuvaapG7Xmc5iGekRJzWDZgZPtoJB
wreksV4OYUhFRogMMCCKHzfuCuIf3alLOocExNjUFHnAFJwFw+hq0r9YABbWtZ+c
FcePeavHusz0afAqyiAmEuQo6dxWN6Nq+lgDWV9SKrulRX0k7DB3/PgE2OfY3UEL
WaF1Gx2wZ0ur3SRZIrRA
=Y46U
-----END PGP SIGNATURE-----

