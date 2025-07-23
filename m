From: Kristof Provost <kprovost@...2661...>
Date: Wed, 23 Jul 2025 10:36:48 +0200
Message-ID: <20250723083816.71604-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] dco-freebsd: support float notifications
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>


Hi,

Here's an implementation of the float notification handling for FreeBSD.
The OpenVPN bits are pretty trivial because it just extends existing mechanisms.

This does expect FreeBSD to actually send the notification, which requires this
patch: https://reviews.freebsd.org/D51468
There's a test case in https://reviews.freebsd.org/D51469.

Best regards,
Kristof

