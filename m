Date: Tue, 28 Oct 2025 20:22:13 +0100 (CET)
Message-Id: <202510281922.59SJMDo3024297@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251028185706.1247-1-gert@...1296...>
References: <20251028185706.1247-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: crypto_backend: Change len
 argument of md_ctx_update to size_t
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

"Makes sense, and BB is happy".  Does not remove as many #pragma as one
could have hoped for, but we knew this would be a long journey...

Your patch has been applied to the master branch.

commit 6607e4be62e71c8c006d3286e99ec582cb9912b6
Author: Frank Lichtenheld
Date:   Tue Oct 28 19:57:01 2025 +0100

     crypto_backend: Change len argument of md_ctx_update to size_t

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1287
     Message-Id: <20251028185706.1247-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33973.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


