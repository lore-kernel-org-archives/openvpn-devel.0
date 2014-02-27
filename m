From: <steffan.karger@...1435...>
Date: Thu, 27 Feb 2014 20:40:05 +0100
Message-ID: <1393530007-6225-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] PolarSSL 1.3
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

The attached patches add support for PolarSSL 1.3. These patches are for
master only, as they drop support for PolarSSL 1.2. Supporting both versions
would require a lot of #ifdef's, so I opted for dropping 1.2.

Along with PolarSSL 1.3 comes support for AES-NI and elliptic curve crypto.
PolarSSL requires no specific initialization for EC crypto; everything just
works out-of-the-box.

Regards,
-Steffan


