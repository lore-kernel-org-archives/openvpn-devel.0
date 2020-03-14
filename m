Date: Sat, 14 Mar 2020 09:47:48 +0100 (CET)
Message-Id: <202003140847.02E8lmtP092053@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200312060829.19468-1-lstipakov@...277...>
References: <20200312060829.19468-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun.c: fix 'use after free'
 error
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

No testing done on my side, but from a stare-at-code perspective this
looks reasonable & necessary.  Thanks.

commit 5d28b47c51f4fcef631f9dae83f9cbc7120c6812
Author: Lev Stipakov
Date:   Thu Mar 12 08:08:29 2020 +0200

     tun.c: fix 'use after free' error

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Simon Rozman <simon@...2293...>
     Message-Id: <20200312060829.19468-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19547.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


