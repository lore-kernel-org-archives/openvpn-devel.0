Date: Wed, 16 Feb 2022 09:02:14 +0100 (CET)
Message-Id: <202202160802.21G82E5t059660@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220215123157.10615-1-a@...2181...>
References: <20220215123157.10615-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: auth_token/tls_crypt: fix usage
 of md_valid()
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Stared at code (looks good).

Tested with Richard's config (no more warnings about SHA256, good), and
ran my usual set of client tests (no issues).

I did notice a long standing copy-paste thing in auth_token.c...

         msg(M_WARN, "ERROR: --tls-crypt requires HMAC-SHA-256 support.");

.. this should be "--auth-gen-token" not "--tls-crypt", I think...  for 
the next round of cleanups.

Your patch has been applied to the master branch.

commit af695b53e01035a9137bc78a868cd5410be817f4
Author: Antonio Quartulli
Date:   Tue Feb 15 13:31:57 2022 +0100

     auth_token/tls_crypt: fix usage of md_valid()

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20220215123157.10615-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23793.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


