Date: Fri, 14 May 2021 13:54:05 +0200 (CEST)
Message-Id: <202105141154.14EBs5Zq079359@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210512131511.1309914-5-arne@...1227...>
References: <20210512131511.1309914-5-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add missing free_key_ctx for
 auth_token
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

I won't claim to understand the lifetime of the various copies of
c1.ks.auth_token_key made by code in init.c (to "to.auth_token_key"
or "other contexts") - but it seems that these all are copying 
c1.ks.ssl_ctx as well - and if that can be safely free()'ed, the
other one should be fine, too.  I also checked that free_key_ctx()
is safe to be used should we have no auth_token_key at all.

Your patch has been applied to the master and release/2.5 branch.

release/2.4 does not have the offending code (no key-based tokens).

I have only compile-tested 2.5 and master ("it should be fine"),
but if not, the server-side test rig will find it later today...

commit fe39156a386bf0dbe79abe43717c84843830e3c0 (master)
commit 6471fd2ab1d07ad24c2c92e7fbda6bd645dd84c8 (release/2.5)
Author: Arne Schwabe
Date:   Wed May 12 15:15:06 2021 +0200

     Add missing free_key_ctx for auth_token

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210512131511.1309914-5-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22345.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


