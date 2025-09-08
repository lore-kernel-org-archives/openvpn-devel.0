Date: Mon, 8 Sep 2025 12:37:53 +0200 (CEST)
Message-Id: <202509081037.588AbrjH037226@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250907211252.23924-1-gert@...1296...>
References: <20250907211252.23924-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: replace assert() calls with
 ASSERT()
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

As explained in the commit message, and in the discussion around #1169/#1170

Tested locally and via BB.  release/2.6 backport tested locally & via GHA.

Your patch has been applied to the master branch and release/2.6
(sort of a bugfix).  options.c hunk has been skipped (not in 2.6).

commit 88f8edbf7545dc7913d031ea12c4bae5250bb766 (master)
commit 2c57936e8fcfef65e95328b9503eeffde5c6e26a (release/2.6)
Author: Gert Doering
Date:   Sun Sep 7 23:12:46 2025 +0200

     replace assert() calls with ASSERT()

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: mandree <matthias.andree@...68...>
     Message-Id: <20250907211252.23924-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32824.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


