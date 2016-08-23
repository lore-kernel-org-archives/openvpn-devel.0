References: <1451908945-12244-1-git-send-email-lstipakov@...277...>
	<1451911424-12970-1-git-send-email-lstipakov@...277...>
	<20160822191828.GT78279@...1296...>
	<20160823134336.GE78279@...1296...>
	<20160823134955.GF78279@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <bbd57d46-1990-c6b7-d804-54ff0b39d0c8@...2080...>
Date: Wed, 24 Aug 2016 00:34:08 +0200
MIME-Version: 1.0
In-Reply-To: <20160823134955.GF78279@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] Drop recursively routed packets
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 23/08/16 15:49, Gert Doering wrote:
> David, please revert both release/2.3 and master, and we'll need
> to rethink this, not using "is_ipv4()"...

Done.

- -- 
kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJXvM9gAAoJEIbPlEyWcf3ycNEQALsZ2nJQfHIqYalF4a+xxoA9
63R76nSZG6qQo1uyZnHwipBf0crYEPCLd4EbRdSIV3leilXrg3Va0QkW9X3Wn0ld
E5uQ4WR4Y4pNkrSB1+l2Iw+N0b1675H5tH/3pKhLe73RvVjI4/APiYtNMEA2FoUv
hnmTBgXzNgPfhJxZgkPiJ4LHIL2XG6SfuFt4H56InIs2BraOul6WKZ4XbvTKpE/R
fyRHMg4BCzRI20g5yd4SpXYlcMkggIPckFss8A78MlpeZfwZgRvsVGtviNyuL62o
Rodv5QSq0nxEMTqIiOK4hhIxmVBiOZu2Xh4HdnG9AAa3ghkux23fD8Iy+aGKmVvf
I2PEZCSorealH19DS8AoIDHaD+dlv8XNz46vwcfxLB06M5JUgTS3mt7iQWXI2dFP
8ORCrllvNb0HZjGPNrobkRGZ4JSos8TCjAYbereRpci642Qy323BqFHljwKbquV0
EThKqdHiQo/x8xJWaqxEz58AATBKF775b4lwy1DCbGO2ca2RSfZJueGzytGtn4Ke
d/5B2oLyOVT6vW5guNTvla8eywNKyVHiwAsaQs31tVEyGOjVa7mTQjUbpowVfntg
PRy4kC+imeElwHXun9dgVg0q9AwdTOQuUUt4OJUyHJqh8Bdp3wYTvxGO4yAFVyMu
yvWuf4Gfwi6FOBpNyjCt
=/Fjb
-----END PGP SIGNATURE-----

