Date: Thu, 24 Jun 2021 15:35:28 +0200 (CEST)
Message-Id: <202106241335.15ODZSws075246@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210520151148.2565578-3-arne@...1227...>
References: <20210520151148.2565578-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add connection_established as
 state in tls_multi->context_auth
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

Stared at the patch, seems to make sense.

Tested on the t_server test rig, and behaves nicely - both alone, and
together with 4/9 (the final patch needed to fix the CVE).  Test rig has
p2mp and p2p servers.

Client tests also succeded (unsurprisingly).

As discussed on IRC, added refererences to CVE-2020-15078 to the commit 
message.  Also added some comments about the CAS_* changes to the 
commit message, which were missing.

Your patch has been applied to the master branch.

commit d01277608a248f31df3fde1883eba6dd8d16a1e4
Author: Arne Schwabe
Date:   Thu May 20 17:11:42 2021 +0200

     Add connection_established as state in tls_multi->context_auth

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210520151148.2565578-3-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22419.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


