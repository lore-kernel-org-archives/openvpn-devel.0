Date: Tue, 1 Oct 2019 13:27:23 +0200 (CEST)
Message-Id: <201910011127.x91BRNXp096178@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190917123321.15993-1-arne@...1227...>
References: <20190917123321.15993-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement unit tests for
 auth-gen-token
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
To: Arne Schwabe <arne@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

Did client side tests, see the unit tests pass on linux and freebsd...

..
[ RUN      ] auth_token_test_timeout
[       OK ] auth_token_test_timeout
[==========] 8 test(s) run.
[  PASSED  ] 8 test(s).
PASS: auth_token_testdriver

The "Fox Crypto B.V." copyright notice in a *new* C source looks a bit
funky, though.

commit ef2c7b2fa4fd9fae934e608e37dc8d98edbace5f
Author: Arne Schwabe
Date:   Tue Sep 17 14:33:21 2019 +0200

     Implement unit tests for auth-gen-token

     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20190917123321.15993-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18821.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


