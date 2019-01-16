Date: Wed, 16 Jan 2019 20:54:03 +0100 (CET)
Message-Id: <201901161954.x0GJs3EV076940@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190114154819.6064-3-arne@...1227...>
References: <20190114154819.6064-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add
 send_control_channel_string_dowork variant
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

Acked-by: Gert Doering <gert@...1296...>

"Just moving of code" (though the change c2->c2.multi -> multi makes this 
harder for git to show).  Tested with t_client testset plus a profile that
uses user+pass auth so these still go out.

Your patch has been applied to the master branch.

commit 1000d5e1191d0a372e9e82f76dd1d1f101fe308e
Author: Arne Schwabe
Date:   Mon Jan 14 16:48:16 2019 +0100

     Add send_control_channel_string_dowork variant

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20190114154819.6064-3-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18092.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


