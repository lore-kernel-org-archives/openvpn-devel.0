Date: Mon, 14 Sep 2020 11:42:06 +0200 (CEST)
Message-Id: <202009140942.08E9g6Tq064614@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200909122223.9222-1-gert@...1296...>
References: <20200909122223.9222-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: socks.c: fix alen for DOMAIN
 type addresses, bump up buffer sizes
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

Thanks for the review.

Patch has been applied to many branches (bugfix)...

commit eebeaa02367d247fc2549df3edf8e598c58c3572 (master)
commit c7f0d7b95bff05b0a5ddab15318cd53fcc91d60a (release/2.5)
commit 64a76533b676ad441ca20bab0c8b2e387bd56ebe (release/2.4)
Author: Gert Doering
Date:   Wed Sep 9 14:22:23 2020 +0200

     socks.c: fix alen for DOMAIN type addresses, bump up buffer sizes

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20200909122223.9222-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20928.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


