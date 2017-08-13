From: Ilya Shipitsin <chipitsine@...277...>
Date: Mon, 14 Aug 2017 01:52:16 +0500
Message-Id: <20170813205217.16736-1-chipitsine@...277...>
Subject: [Openvpn-devel] [PATCH 0/1] travis-ci: libressl support for osx
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

Tunnelblick ships openvpn binary built with libressl
(see https://github.com/Tunnelblick/Tunnelblick/issues/317 )

Ilya Shipitsin (1):
  travis-ci: add libressl build for osx

 .travis.yml            |  5 +++++
 .travis/build-check.sh |  4 ++++
 .travis/build-deps.sh  | 31 +++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

-- 
2.13.3


