From: Magnus Kroken <mkroken@...277...>
Message-ID: <ec25d8af-ecfe-19eb-9d86-4525300cde2f@...277...>
Date: Sun, 12 Jun 2016 17:14:06 +0200
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN-mbedTLS depends on mbedTLS debug module -
	safe to remove?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi

The mbedTLS/PolarSSL build of OpenVPN depends on the debug.c part of 
mbedTLS. Specifically ssl_polarssl.c (ssl_mbedtls.c in master branch), 
key_state_ssl_init() calls debug_set_threshold() [1]. Removing this line 
removes the dependency.

Is it safe to remove the call to debug_set_threshold? Is it only used 
for more verbose logging, or can this cause a TLS error to not be 
noticed (or lead to other security implications)?

Building mbedTLS with the debug module increases its size by about 40k, 
and e.g. OpenWrt builds it without the debug module by default for this 
reason. I'm not asking OpenVPN to remove this, but I would like to know 
the known consequences of such a change.

1: 
https://github.com/OpenVPN/openvpn/commit/a9226fbdd90ac37891937b396c9c3212cd324262#diff-a06a4475e26fd6ec7e0cd3bbdcb30966R745

Regards,
Magnus Kroken

