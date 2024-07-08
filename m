From: Ilia Shipitsin <chipitsine@...277...>
Date: Mon,  8 Jul 2024 23:08:17 +0200
Message-ID: <20240708210912.566-1-chipitsine@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/5] handle strdup errors
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

strdup might return NULL in case of failure, which is sometimes not handled

Ilia Shipitsin (5):
  src/openvpn/init.c: handle strdup failures
  sample/sample-plugins/defer/multi-auth.c: handle strdup errors
  src/openvpn/auth_token.c: handle strdup errors
  src/openvpn/ssl_verify.c: handle strdup errors
  tests/unit_tests/openvpn/test_auth_token.c: handle strdup errors

 sample/sample-plugins/defer/multi-auth.c   | 15 +++++++++++++++
 src/openvpn/auth_token.c                   |  8 ++++++++
 src/openvpn/init.c                         |  4 ++++
 src/openvpn/ssl_verify.c                   |  8 ++++++++
 tests/unit_tests/openvpn/test_auth_token.c |  2 ++
 5 files changed, 37 insertions(+)

-- 
2.43.0.windows.1


