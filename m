Date: Mon, 25 Apr 2022 18:00:15 +0200 (CEST)
Message-Id: <202204251600.23PG0Fu3075278@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220422134038.3801239-8-arne@...1227...>
References: <20220422134038.3801239-8-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add unit tests for
 test_tls_decrypt_lite
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Unit tests are always good :-) - and of course 06/28 is only there
to make this happen.  I have only done a "semi-deep" look into the code,
but it seems to cover the usual cases (good packet, short packet, corrupt
packet for nothing/tls-auth/tls-crypt) which is way more than we have now.

Passes "make distcheck" + "make check with mbedTLS and openssl"

[==========] Running 3 test(s).
[ RUN      ] test_tls_decrypt_lite_none
[       OK ] test_tls_decrypt_lite_none
[ RUN      ] test_tls_decrypt_lite_auth
[       OK ] test_tls_decrypt_lite_auth
[ RUN      ] test_tls_decrypt_lite_crypt
[       OK ] test_tls_decrypt_lite_crypt
[==========] 3 test(s) run.
[  PASSED  ] 3 test(s).
PASS: pkt_testdriver

Your patch has been applied to the master branch.

commit 34694688f43ba1cb5827d921df0b374c916119ce
Author: Arne Schwabe
Date:   Fri Apr 22 15:40:36 2022 +0200

     Add unit tests for test_tls_decrypt_lite

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220422134038.3801239-8-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24168.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


