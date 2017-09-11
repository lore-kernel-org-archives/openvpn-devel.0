From: Steffan Karger <steffan.karger@...1435...>
Date: Mon, 11 Sep 2017 23:51:59 +0200
Message-ID: <1505166722-5409-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove dependency on mbed TLS PKCS#11 module
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
To: openvpn-devel@lists.sourceforge.net

Hi,

The following three patches remove our dependency on the mbed TLS
PKCS#11 module.  While doing so, this adds better error reporting and
still manages to barely add any lines of code.

Not depending on the mbed TLS PKCS#11 module is good, because mbed TLS
has the PKCS#11 module disabled by default.  So this makes it easier to
use e.g. a distro-provided mbed TLS library.  Also, this makes it easier
to move away from pkcs11-helper should we want to go that way.

-Steffan


