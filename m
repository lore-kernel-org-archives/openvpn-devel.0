From: chipitsine@...277...
Date: Thu, 11 Apr 2019 12:45:18 +0500
Message-Id: <20190411074519.9982-1-chipitsine@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/1] fix unit tests build when LZO installed
 to custom folder
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

From: Ilya Shipitsin <chipitsine@...277...>

Under FreeBSD default folder is /usr/local/lib, all 3rd parties software is installed
to it. I added LZO directories to unit tests search path

Ilya Shipitsin (1):
  configure.ac: fix compile-time error in argv_testdriver

 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.20.1


