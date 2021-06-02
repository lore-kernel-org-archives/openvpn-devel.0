Date: Wed, 2 Jun 2021 19:56:13 +0200 (CEST)
Message-Id: <202106021756.152HuD5r040043@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210524184506.20582-1-selva.nair@...277...>
References: <20210524184506.20582-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Do not require CA when
 peer-fingerprint is used
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

Haven't tested much (t_client only), but the change looks good and cleans 
up these multiple "the same but not the same" checks in a good way.

Your patch has been applied to the master branch.

commit b7fe49c2f9fe967155960608a029041065c54916
Author: Selva Nair
Date:   Mon May 24 14:45:06 2021 -0400

     Do not require CA when peer-fingerprint is used

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20210524184506.20582-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22443.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


