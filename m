From: <steffan.karger@...1435...>
Date: Mon, 18 Mar 2013 17:37:27 +0100
Message-ID: <1363624652-7001-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] PolarSSL 1.2 support,
	while keeping config file compatibility
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
To: openvpn-devel@lists.sourceforge.net

Hi Everyone,

The attached patches add PolarSSL 1.2 support to OpenVPN 2.3, while maintaining OpenVPN configuration file compatibility between the OpenSSL and PolarSSL builds.

Patches 1-3 upgrade the supported PolarSSL versions to 1.2.5 or newer.

Patch 4 adds data channel cipher name compatibility.

Patch 5 adds TLS control channel cipher suite name compatibility as discussed at FOSDEM. It makes the IANA (IETF) cipher suite naming that PolarSSL uses since 1.2 the preferred format, but still accepts OpenSSL names. It attempts to tranlate cipher names in both directions whenever required.

Regards,
-Steffan


