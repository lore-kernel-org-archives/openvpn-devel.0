Date: Sun, 5 Aug 2018 20:59:13 +0200 (CEST)
Message-Id: <201808051859.w75IxDv6075230@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1511228605-23207-1-git-send-email-selva.nair@...277...>
References: <1511228605-23207-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Correct the declaration of
 handle in 'struct openvpn_plugin_args_open_return'
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.4 branch (bugfix).

The "git complains" part was due to patch context still talking about 
ENABLE_CRYPTO, which doesn't exist anymore in master - easily workarounded.

commit a2f43c2d6f086e7aa8b6160793f0c462ee9d6aa7 (master)
commit 359e66bcb17c856a74cada9136ae1b8f411a2493 (release/2.4)
Author: Selva Nair
Date:   Mon Nov 20 20:43:25 2017 -0500

     Correct the declaration of handle in 'struct openvpn_plugin_args_open_return'

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <1511228605-23207-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15908.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


