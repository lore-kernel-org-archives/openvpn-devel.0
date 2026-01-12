Date: Mon, 12 Jan 2026 19:00:27 +0100 (CET)
Message-Id: <202601121800.60CI0RhJ079573@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260112171122.3994-1-gert@...1296...>
References: <20260112171122.3994-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: socks: Replace magic 10 for
 socks header with macro
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

Agreed, magic numbers are bad... the code change itself is trivial,
the BB socks t_client tests agree things still work.

Your patch has been applied to the master branch.

commit e2d0e856061d43eabd8010070b456a10052b4e2b
Author: Frank Lichtenheld
Date:   Mon Jan 12 18:11:12 2026 +0100

     socks: Replace magic 10 for socks header with macro

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1467
     Message-Id: <20260112171122.3994-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35214.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


