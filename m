From: <steffan.karger@...1435...>
Date: Thu, 17 Jan 2013 09:23:26 +0100
Message-ID: <1358411009-2350-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] PolarSSL 1.2 support for OpenVPN 2.3
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

Hi,

From PolarSSL 1.1 to 1.2 the cipher names have changed and the API changed a bit. This causes the 2.3 release of OpenVPN to be in- compatible with PolarSSL 1.2.

We've prepared three patches to add support for PolarSSL 1.2 to OpenVPN 2.3. The first two patches just improve error reporting, the third patch adds the actual PolarSSL 1.2 support.

Version 1.2.0 to 1.2.2 of PolarSSL contained several issues that caused it to be unfit for use with OpenVPN. I added checks in the configure file to report an error when someone is trying to build OpenVPN against one of these PolarSSL versions.

This should also close ticket #250.

Kind regards,
Steffan Karger
Fox-IT


