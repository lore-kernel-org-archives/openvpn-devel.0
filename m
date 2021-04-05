Date: Mon, 5 Apr 2021 12:40:29 +0200 (CEST)
Message-Id: <202104051040.135AeTli053960@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210405080007.1665-2-a@...2181...>
References: <20210405080007.1665-2-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: openssl: avoid NULL pointer
 dereference
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

According to OpenSSL documentation, this can indeed return NULL, 
so catch it... (Note: as for 1/3, this code is only in master, so
no need to backport to release/2.5)

Your patch has been applied to the master branch.

commit f3c7698957483e0ea0f14e712502d34c826c53ca
Author: Antonio Quartulli
Date:   Mon Apr 5 10:00:06 2021 +0200

     openssl: avoid NULL pointer dereference

     Signed-off-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210405080007.1665-2-a@...2181...>
     URL: https://www.mail-archive.com/search?l=mid&q=20210405080007.1665-2-a@...2181...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


