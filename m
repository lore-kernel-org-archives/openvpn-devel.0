Date: Wed, 7 Apr 2021 14:58:32 +0200 (CEST)
Message-Id: <202104071258.137CwWgt016740@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210406162518.4075-4-arne@...1227...>
References: <20210406162518.4075-4-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use EVP_CTRL_AEAD_* instead
 EVP_CTRL_GCM_*
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

Lightly client-side tested with OpenSSL 1.0.2 and 1.1.1

Your patch has been applied to the master branch.

commit 3fbeeda5cd3cbd0cbb4c039b469685e2a6254daf
Author: Arne Schwabe
Date:   Tue Apr 6 18:25:17 2021 +0200

     Use EVP_CTRL_AEAD_* instead EVP_CTRL_GCM_*

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210406162518.4075-4-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22050.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


