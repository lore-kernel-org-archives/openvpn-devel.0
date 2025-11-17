Date: Mon, 17 Nov 2025 09:20:29 +0100 (CET)
Message-Id: <202511170820.5AH8KTRv081923@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251117074921.26531-1-gert@...1296...>
References: <20251117074921.26531-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl_pkt: Avoid conversion
 warnings
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

Change looks reasonable.  Tested on FreeBSD t_client/t_server testbed.

Your patch has been applied to the master branch.

commit 5ab76ad9ec0b45874f49f04d4203fc5912fd55a8
Author: Frank Lichtenheld
Date:   Mon Nov 17 08:49:15 2025 +0100

     ssl_pkt: Avoid conversion warnings

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1360
     Message-Id: <20251117074921.26531-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34501.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


