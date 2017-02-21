From: David Sommerseth <davids@...515...>
Date: Tue, 21 Feb 2017 20:27:34 +0100
Message-Id: <20170221192737.24166-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 0/3] LZ4 updates
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

This is an updated LZ4 patch series.  It fixes a silly bug
which sneaked into the lz4-rebaser.sh tool, rebases LZ4 to
upstream lz4-1.7.5 and updates our LZ4 usage to not use a
deprecated API.

This patch-set replaces the previous [1] LZ4 update series.


[1] Message-Id: <1481833246-32507-1-git-send-email-davids@...515...>
    <http://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg135=
76.html>

Christian Hesse (1):
  Replace deprecated LZ4 function

David Sommerseth (2):
  dev-tools: lz4-rebaser tool carried a typo
  lz4: Rebase compat-lz4 against upstream v1.7.5

 dev-tools/lz4-rebaser.sh |   2 +-
 src/compat/compat-lz4.c  | 830 ++++++++++++++++++++++---------------------=
----
 src/compat/compat-lz4.h  | 377 +++++++++++++--------
 src/openvpn/comp-lz4.c   |   4 +
 4 files changed, 635 insertions(+), 578 deletions(-)

--=20
2.11.0


