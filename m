From: Antonio Quartulli <a@...2181...>
Date: Mon, 10 Jul 2017 12:34:37 +0800
Message-Id: <20170710043441.24770-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 0/4] ntlm: remove warnings and improve code
 style
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
Cc: Antonio Quartulli <a@...2181...>

This small patcheset is aimed to simply remove some unnecessary warnings
and improve the readability of ntlm.c.

Compile tests have been performed with "-Wall -std=c99".

This is another step towards having a clean build when using -Wall.


Cheers,

Antonio Quartulli (4):
  ntlm: convert binary buffers to uint8_t *
  ntlm: avoid useless cast
  ntlm: restyle compressed multiple function calls
  ntlm: improve code style and readability

 src/openvpn/ntlm.c | 129 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 74 insertions(+), 55 deletions(-)

-- 
2.13.2


