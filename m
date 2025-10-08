Date: Wed, 8 Oct 2025 12:47:35 +0200 (CEST)
Message-Id: <202510081047.598AlZhZ081890@...2054...>
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

commit c9494e3ead87c83e08cfd505c2d2c5eebce066db
Author: Frank Lichtenheld
Date:   Wed Oct 8 12:02:16 2025 +0200

     test_options_parse: Add test for read_config_string

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1247
     Message-Id: <20251008100222.4610-1-gert@...1296...>
     URL: https://www.mail-archive.com/search?l=mid&q=20251008100222.4610-1-gert@...1296...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


