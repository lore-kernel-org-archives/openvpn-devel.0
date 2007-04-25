Date: Wed, 25 Apr 2007 19:53:32 +0200 (CEST)
From: Andrzej Chmielowiec <ac181080@...1019...>
Message-ID: <Pine.LNX.4.64N.0704251951080.2737@...1019...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN and ECC support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

I am finishing my USB hardware token with ECC support. It is integrated
with OpenSSL by the engine interface. I have also integrated it with OpenVPN
software. My version works with two new options:
(1) --ecdh file - file with ECDH domain parameters to support Elliptic Curve
     Diffie-Hellman algorithm,
(2) --engkey - bool option to indicate that private key is on hardware  device
     and can be read only by engine interface.

What do you think about adding this options to standard distribution of  OpenVPN
source code. Today ECC Cipher Suite is official standard described in RFC 4492
and its algorithms are implemented in OpenSSL (turn off by default in version
0.9.8, but will be on in version 0.9.9).

Best Regards,

Andrzej Chmielowiec,
CMM Sigma (www.cmmsigma.eu)


