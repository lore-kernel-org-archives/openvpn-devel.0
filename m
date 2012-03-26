From: Alon Bar-Lev <alon.barlev@...277...>
Date: Mon, 26 Mar 2012 23:26:34 +0200
Message-Id: <1332797200-9295-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <CAOazyz06swLVgdoE1GPt2m9EEO7cvB2S8nBstn-a1ktDYtgH-Q@...278...>
References: <CAOazyz06swLVgdoE1GPt2m9EEO7cvB2S8nBstn-a1ktDYtgH-Q@...278...>
Subject: [Openvpn-devel] [PATCH 0/6] build patches
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
Cc: Alon Bar-Lev <alon.barlev@...277...>

More from my queue.

https://github.com/alonbl/openvpn/commits/build2

Alon Bar-Lev (6):
  build: openbsd: detect netinet/ip.h correctly
  build: tap: search for tap header
  cleanup: warnings at src/openvpn/httpdigest.c
  cleanup: warnings at src/openvpn/ntlm.c
  cleanup: warnings at src/openvpn/ssl_verify_openssl.c
  cleanup: ~0 is too large for 32bit ipv4 address

 configure.ac                     |   35 ++++++++++++++++-------------
 src/openvpn/Makefile.am          |    2 +-
 src/openvpn/httpdigest.c         |   44 +++++++++++++++++++-------------------
 src/openvpn/ntlm.c               |   12 +++++-----
 src/openvpn/route.c              |    2 +-
 src/openvpn/ssl_verify_openssl.c |    2 +-
 6 files changed, 50 insertions(+), 47 deletions(-)

-- 
1.7.3.4


