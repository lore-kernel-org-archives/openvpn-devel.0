Date: Wed, 13 Jun 2018 15:12:34 +0200 (CEST)
Message-Id: <201806131312.w5DDCYMK008956@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20180613122824.4207-3-a@...2181...>
References: <20180613122824.4207-3-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun: always pass a valid tt
 pointer
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

Makes the code more readable, doesn't change anything (check with 
"git show -w", otherwise all the whitespace change is non-helpful).

Note: there was a rebase fail in the "NetBSD" close_tun() function,
bringing back the gc_arena that v2 1/3 just dropped.  I've taken the
liberty to remove it again - it did not want to be there.

Your patch has been applied to the master branch.

commit 0bea472c98dca8b3470ef863fd90a63b6c79fa68
Author: Antonio Quartulli
Date:   Wed Jun 13 20:28:23 2018 +0800

     tun: always pass a valid tt pointer

     Signed-off-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20180613122824.4207-3-a@...2181...>
     URL: https://www.mail-archive.com/search?l=mid&q=20180613122824.4207-3-a@...2181...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


