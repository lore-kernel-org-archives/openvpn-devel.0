Date: Mon, 10 Aug 2020 19:49:08 +0200 (CEST)
Message-Id: <202008101749.07AHn8sk028455@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200810143707.5834-9-arne@...1227...>
References: <20200810143707.5834-9-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Rename
 check_ping_restart_dowork to trigger_ping_timeout_signal
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

(Why have local prototypes when the "real" prototype is just
a few lines further up in the same .h...??  And another
.._dowork() removal lurking :-) )

Basic client test.

Your patch has been applied to the master branch.

commit 76ea0859c5d0549f5d6193cbd5e43873e22d5906
Author: Arne Schwabe
Date:   Mon Aug 10 16:36:58 2020 +0200

     Rename check_ping_restart_dowork to trigger_ping_timeout_signal

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200810143707.5834-9-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20675.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


