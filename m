Date: Mon, 9 Mar 2020 15:24:24 +0100 (CET)
Message-Id: <202003091424.029EOOOf001973@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200309131728.380-2-simon@...2293...>
References: <20200309131728.380-2-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnmsica: Fix
 TAPInterface.DisplayName field interpretation
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

I won't claim to understand what this all does, but the change matches
the documentation - if a "file name" is returned that has "8.3|long"
format, it will use the "long" part of it, otherwise the string as it is.

Your patch has been applied to the master branch.

commit 36493bf6383767fe4e20f1dfda6be2a7ee0dc1f2
Author: Simon Rozman
Date:   Mon Mar 9 14:17:18 2020 +0100

     openvpnmsica: Fix TAPInterface.DisplayName field interpretation

     Signed-off-by: Simon Rozman <simon@...2293...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200309131728.380-2-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19520.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


