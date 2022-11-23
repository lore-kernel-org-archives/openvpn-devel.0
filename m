Date: Wed, 23 Nov 2022 22:09:47 +0100 (CET)
Message-Id: <202211232109.2ANL9lYH025975@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221123154912.28394-1-maximilian.fillinger@...2507...>
References: <20221123154912.28394-1-maximilian.fillinger@...2507...>
Subject: [Openvpn-devel] [PATCH applied] Re: Check if pkcs11_cert is NULL
 before freeing it
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
To: Max Fillinger <maximilian.fillinger@...2507...>
Cc: openvpn-devel@lists.sourceforge.net

Confirmed that it crashes without the patch, and does not crash with it.

Added a comment, as suggested.

Your patch has been applied to the master and release/2.5 branch (bugfix).

commit 19c64f16baebbce966d55c62135d1ef066f7c8c2 (master)
commit 4f5e57d2c7ff9384b16c42eb9aa5af11d31f5dd1 (release/2.5)
Author: Max Fillinger
Date:   Wed Nov 23 16:49:12 2022 +0100

     Check if pkcs11_cert is NULL before freeing it

     Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20221123154912.28394-1-maximilian.fillinger@...2507...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25530.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


