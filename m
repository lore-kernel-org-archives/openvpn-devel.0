Date: Mon, 16 Sep 2024 16:58:06 +0200 (CEST)
Message-Id: <202409161458.48GEw6L4009483@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240916133436.29943-1-gert@...1296...>
References: <20240916133436.29943-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Make read/write_tun_header
 static
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

Verified that it's not used outside tun.c, test built OpenBSD (which
uses this).

Your patch has been applied to the master branch.

commit ac3a7fd93542420f12d58e5c7490076b5741fb5a
Author: Arne Schwabe
Date:   Mon Sep 16 15:34:35 2024 +0200

     Make read/write_tun_header static

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240916133436.29943-1-gert@...1296...>
     Signed-off-by: Gert Doering <gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29249.html


--
kind regards,

Gert Doering


