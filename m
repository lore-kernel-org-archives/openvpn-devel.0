Date: Wed, 26 Sep 2018 11:59:04 +0200 (CEST)
Message-Id: <201809260959.w8Q9x4tW038486@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1536916459-25900-1-git-send-email-steffan.karger@...1435...>
References: <1536916459-25900-1-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: Do not load certificate from
 tls_ctx_use_external_private_key()
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

I have only done a very cursory sanity check, plus test build (of course,
mbedtls + openssl), and fixed one funky indentation artefact (8 spaces 
plus a tab in the very last change).

commit 73513aaa301e9e9413b6156ed263dd27f8fad7fd
Author: Steffan Karger
Date:   Fri Sep 14 11:14:17 2018 +0200

     Do not load certificate from tls_ctx_use_external_private_key()

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <1536916459-25900-1-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17464.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


