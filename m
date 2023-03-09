Date: Thu, 9 Mar 2023 19:55:27 +0100 (CET)
Message-Id: <202303091855.329ItRbm094085@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230309120031.3780130-1-arne@...1227...>
References: <20230309120031.3780130-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Ensure n = 2 is set in key2
 struct in tls_crypt_v2_unwrap_client_key
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

Trivial enough :-) - wording fixes applied ("structer", "trigerring").

Interesting that Antonio could reproduce this while it "just works"
in my test beds.

Your patch has been applied to the master and release/2.6 branch.

commit 85832307fcb41c229ccb7ba83984726757eb32f7 (master)
commit ae6068842854278de70264218516b0e4fcdfc6d9 (release/2.6)
Author: Arne Schwabe
Date:   Thu Mar 9 13:00:31 2023 +0100

     Ensure n = 2 is set in key2 struct in tls_crypt_v2_unwrap_client_key

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20230309120031.3780130-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26363.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


