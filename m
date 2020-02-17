Date: Mon, 17 Feb 2020 19:33:40 +0100 (CET)
Message-Id: <202002171833.01HIXeaO073378@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200217144339.3273-2-arne@...1227...>
References: <20200217144339.3273-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Only announce IV_NCP=2 when we
 are willing to support these ciphers
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

Your patch has been applied to the master branch.

(Have stared at the patch a bit and gave it a t_client test run, did
not explicitly test the case without the required ciphers)

commit 868b200c3aef6ee5acfdf679770832018ebc7b70
Author: Arne Schwabe
Date:   Mon Feb 17 15:43:35 2020 +0100

     Only announce IV_NCP=2 when we are willing to support these ciphers

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20200217144339.3273-2-arne@...1227...>
     URL: https://www.mail-archive.com/search?l=mid&q=20200217144339.3273-2-arne@...1227...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


