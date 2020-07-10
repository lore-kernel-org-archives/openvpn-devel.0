Date: Fri, 10 Jul 2020 18:51:01 +0200 (CEST)
Message-Id: <202007101651.06AGp102053986@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200709101603.11941-6-arne@...1227...>
References: <20200709101603.11941-6-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Cleanup: Remove special case
 code for old poor man's NCP.
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

Tested on client and server side (and server vs. 2.3/2.4/master clients)
and all works, including --ncp-disable clients.  I'm fairly sure I have
not all corner cases covered (like, master client talking to a 2.3 server
with poor man's NCP), so more testing is needed in the 2.5-beta phase...

Your patch has been applied to the master branch.

commit e539c95dc8d240327be17e8647e52556dd7fd92d
Author: Arne Schwabe
Date:   Thu Jul 9 12:16:01 2020 +0200

     Cleanup: Remove special case code for old poor man's NCP.

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200709101603.11941-6-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20251.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


