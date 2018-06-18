Date: Mon, 18 Jun 2018 20:32:52 +0200 (CEST)
Message-Id: <201806181832.w5IIWqmc070696@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20180618074733.19773-1-a@...2181...>
References: <20180618074733.19773-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun: ensure interface can be
 configured with IPv6 only
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
To: Antonio Quartulli <antonio@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

TARGET_SOLARIS fixed, and that's (diffing the two patches) the only
code difference - all the rest has been reviewed and tested for v4 
already.  Windows won't do ipv6-only, but ipv4(+ipv6) should be fine.

Your patch has been applied to the master branch.

commit 611fcbc487292054306767a76e727aea4e593725
Author: Antonio Quartulli
Date:   Mon Jun 18 15:47:33 2018 +0800

     tun: ensure interface can be configured with IPv6 only

     Signed-off-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20180618074733.19773-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17064.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


