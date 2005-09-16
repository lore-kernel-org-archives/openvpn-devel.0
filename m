Message-ID: <432B0855.1060909@...277...>
From: Alon Bar-Lev <alon.barlev@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] openvpn-2.0.2-pkcs11-20050916.patch
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Sep 16 10:00:26 2005
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hello,

This patch enabled openvpn to access PKCS#11 cryptographic 
tokens. It is based on the opensc patch that was post earlier 
(http://sourceforge.net/tracker/index.php?func=detail&aid=1114521&group_id=48978&atid=454721).

This patch was tested under Linux. It was tested with the 
opensc PKCS#11 provider. Since it works with the opensc 
provider and PKCS#11 standard is much more common, it makes 
the opensc patch obsolete.

This patch compiles under Windows, but was not tested. I will 
be glad if somebody will test it under Windows as well.

The patch is capable of using several PKCS#11 providers at the 
same time.

The following options were added:
--pkcs11-providers provider... - Loads a PKCS#11 provider.
--pkcs11-sign-mode - How to perform signature.
--pkcs11-slot-type - Specifies how to locate correct slot.
--pkcs11-slot - Specifies slot name.
--pkcs11-id-type - Specifies how to find certificate and key.
--pkcs11-id - Specifies certificate and key name.

The following standalone options were added:
--show-pkcs11-slots - Displays PKCS#11 slots.
--show-pkcs11-objects - Displays PKCS#11 token contents.

Please refer to man page for further information.

The patch can be found at 
http://sourceforge.net/tracker/index.php?func=detail&aid=1293066&group_id=48978&atid=454721

Any comments/suggestions will be gladly accepted 
(mailto:alon.barlev@...277...).

Special thanks to:
Fritz Elfert - Wrote the original patch.
Iván Casado Ruiz - Updated original patch and helped in 
testing this one.

Best Regards,
Alon Bar-Lev.

