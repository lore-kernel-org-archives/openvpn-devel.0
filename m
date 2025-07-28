Date: Mon, 28 Jul 2025 12:35:32 +0200 (CEST)
Message-Id: <202507281035.56SAZWNC046801@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250728084255.1824-1-gert@...1296...>
References: <20250728084255.1824-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: mudp.c, multi.c,
 multi_io.c: get rid of 'all three DCO platforms' #ifdefs
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

Just for reference: we saw quite a few build errors in BB, but these are
due to "fedora 42 on arm 64" (only!) being different about <stdint.h>, 
which is addressed in gerrit #1118.  Unrelated to any recent patch.

Patch has been applied to the master branch.

commit 6d0e38370b62488374a09336652ab415776955fc
Author: Gert Doering
Date:   Mon Jul 28 10:42:49 2025 +0200

     mudp.c, multi.c, multi_io.c: get rid of 'all three DCO platforms' #ifdefs

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <antonio@...2726...>
     Message-Id: <20250728084255.1824-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32377.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


