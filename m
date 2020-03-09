Date: Mon, 9 Mar 2020 15:00:06 +0100 (CET)
Message-Id: <202003091400.029E06Xg001628@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200309131728.380-1-simon@...2293...>
References: <20200309131728.380-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnmsica: Remove required
 Windows driver certification detection
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
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

It only takes code away, which is now handled outside in the 
tap-windows6.msm (tap-windows6/pull/106).  Not claiming to understand
any of this, but the code change does not introduce anything new 
which looks dangerous - and it's all your code anyway, so you'll know
best :-)

Your patch has been applied to the master branch.

commit 026cf3e5d3ada763617bf86087cb651cc57bddb2
Author: Simon Rozman
Date:   Mon Mar 9 14:17:17 2020 +0100

     openvpnmsica: Remove required Windows driver certification detection

     Signed-off-by: Simon Rozman <simon@...2293...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200309131728.380-1-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19530.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


