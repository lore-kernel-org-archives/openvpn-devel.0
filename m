Date: Thu, 2 Apr 2020 20:55:58 +0200 (CEST)
Message-Id: <202004021855.032Itw2g021841@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200402103821.10347-1-arne@...1227...>
References: <20200402103821.10347-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix OpenSSL error stack
 handling of tls_ctx_add_extra_certs
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

Your patch has been applied to the master and release/2.4 branch (bugfix).

Looked at code and IRC discussion, makes all sense to me.  Tested a 
2.4 client build on linux and freebsd, mbedtls and openssl (build + 
t_client), just for extra sanity checking.

commit 3608d890583549dbdbefc40ed41bf617fa518aa1 (master)
commit 15bc476f80e66cee8e2bfba96879ef32e01380b5 (release/2.4)
Author: Arne Schwabe
Date:   Thu Apr 2 12:38:21 2020 +0200

     Fix OpenSSL error stack handling of tls_ctx_add_extra_certs

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20200402103821.10347-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19685.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


