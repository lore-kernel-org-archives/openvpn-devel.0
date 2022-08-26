MIME-Version: 1.0
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 26 Aug 2022 10:00:52 +0300
Message-ID: <CAGyAFMV7-KOLA3aw1=L4DGOh8PkmEEvgNN9QprHU2WR8zt2KUQ@...278...>
Subject: [Openvpn-devel] OpenVPN Windows DCO driver
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>, openvpn-users@lists.sourceforge.net

Dear all,

The DCO driver for Windows (https://github.com/openvpn/ovpn-dco-win)
implements OpenVPN data channel in kernel, eliminating context switch
and thus noticeably improves performance.

Support for dco-win driver has been merged into openvpn master branch
and openvpn installer:

   x64: https://build.openvpn.net/downloads/snapshots/github-actions/openvpn2/openvpn-master-20220825T0959-104e4ef1-amd64.msi

   arm64: https://build.openvpn.net/downloads/snapshots/github-actions/openvpn2/openvpn-master-20220825T1004-104e4ef1-arm64.msi

(newer snapshots will also do)

Please give it a try and share your feedback with us. To enable
dco-win driver, add "windows-driver ovpn-dco" to your .ovpn profile.

Known limitations:

 - available for Windows 10 2004 and newer
 - persist-tun support is coming soon
 - only aes-128/192/256-gcm ciphers are supported. chacha20-poly1305
is supported starting from Windows 11
 - compression is not supported (and should not be used anyway)
 - server-side support is missing

DCO Windows driver will be part of 2.6 release which is coming later this year.

-- 
-Lev

