Date: Thu, 29 Jun 2017 20:47:06 +0200 (CEST)
Message-Id: <201706291847.v5TIl6OQ057047@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170629142119.29502-2-logout@...260...>
References: <20170629142119.29502-2-logout@...260...>
Subject: [Openvpn-devel] [PATCH applied] Re: OpenSSL: remove
 EVP_CIPHER_CTX_free() from the compat layer
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
To: Emmanuel Deloget <logout@...260...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.4 branch.

commit 7ee9a94fcbbde941bfed167229a64df0f7cdae0b (master)
commit ebb5c70bf6acede8d941687ae0e40d827003fb2e (release/2.4)
Author: Emmanuel Deloget
Date:   Thu Jun 29 16:21:19 2017 +0200

     OpenSSL: remove EVP_CIPHER_CTX_free() from the compat layer

     Signed-off-by: Emmanuel Deloget <logout@...260...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <20170629142119.29502-2-logout@...260...>
     URL: https://www.mail-archive.com/search?l=mid&q=20170629142119.29502-2-logout@...260...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


