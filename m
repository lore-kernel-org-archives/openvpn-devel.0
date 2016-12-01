From: David Sommerseth <davids@...515...>
Date: Fri,  2 Dec 2016 00:29:20 +0100
Message-Id: <1480634960-5685-1-git-send-email-davids@...515...>
In-Reply-To: <20161201213104.5667-2-list@...1798...>
References: <20161201213104.5667-2-list@...1798...>
Subject: Re: [Openvpn-devel] [PATCH applied] Refuse to daemonize when
	running from systemd
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

ACK.  A natural continuation of commit c5931897ae8d663e7e.

Your patch has been applied to the master branch

commit 7660bba111f739f9cc7017c392c1434f201b8c44
Author: Christian Hesse
Date:   Thu Dec 1 22:31:04 2016 +0100

     Refuse to daemonize when running from systemd

     Signed-off-by: Christian Hesse <mail@...1798...>
     Tested-By: Richard Bonhomme <fragmentux@...277...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20161201213104.5667-2-list@...1798...>
     URL: http://www.mail-archive.com/search?l=mid&q=20161201213104.5667-2-list@...1798...
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYQLJIAAoJEIbPlEyWcf3yMKgQAJapsRNhfkI1+WSaRP2PoVh/
scQQxFEV8HPHOASDtFZQZnaz3ZqkQ0yA+Zyn5w+KRefEIKGJ7/B8AWV5MfmtqPXS
d4TTbUXMziK+E4cJpcZukWm/r5eEjIfy6ZhNe+fopq3zMt/JtbJD9nbBjVOe+KiK
Kml60oUEP/vDmHKqQYJr69Z+9zgPC9W+etDY6MW6fyoo5O93G+OSenAeG2PJa3IZ
JsHOlcaYNIjrUKMZoxeiGKgqaU7aoTqHq/5l83cy7mayI8w3F6tOhYaH02NhVn15
PZ8BDJAG9Dl67/ROll9HO1HaoUegcpAR3lEXWAeRV7TaEn5x9W9HrmDJiWcuWZhj
BbvlqMmC0ocQyODul+6NFXWPX9+BmiReDGh+R6g+7H/ZhC01c4kyqBF+xne0DkSY
YnEs5ZMkxyY3ItrnUrQGiywayvDIsa0+DNv7jTRnVRy8bfnkKW0grOzDFQvyKqWR
K0rwBVOuKNqeRh6vhFSYNjfMIfcvkONMZKPlLjjHHIWzYr8eapxff6Ozw36UVXfI
1AGQ0bSChAjwufD9y6Xy+LDf+GtQI4kWkRjjjnXP/n01fYSLBJSGnLBWC3V+JUV1
JPT4GtD5cPAjxU3alGyrUMw4f18zXoqvlP82Kt+ViMneRwJkffxpOFWG7tD5MKYb
73a0O3IBgkb+SZRjFB4J
=xSqP
-----END PGP SIGNATURE-----

