Date: Wed, 8 Oct 2025 12:47:39 +0200 (CEST)
Message-Id: <202510081047.598AldMN081895@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251008100222.4610-1-gert@...1296...>
References: <20251008100222.4610-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: test_options_parse: Add test
 for read_config_string
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

More tests are always good, especially if they discover bugs :-) - tested,
passes... with gerrit#1246, that is :-) - without it, it properly fails with

[ RUN      ] test_read_config
[  ERROR   ] --- test_options_parse.c:47: error: Check of parameter p, function __wrap_add_option failed
test_options_parse.c:288: note: Expected parameter declared here
[   LINE   ] --- test_options_parse.c:47: error: Failure!
[  FAILED  ] test_read_config


Your patch has been applied to the master branch.

commit 775488b81c493382625c368a71f06d009f826a35
Author: Frank Lichtenheld
Date:   Wed Oct 8 12:02:16 2025 +0200

     test_options_parse: Add test for read_config_string

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1247
     Message-Id: <20251008100222.4610-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59243809/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


