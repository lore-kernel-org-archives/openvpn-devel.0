Date: Tue, 27 Apr 2021 16:24:37 +0200 (CEST)
Message-Id: <202104271424.13REObbW001735@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210408140229.31824-2-arne@...1227...>
References: <20210408140229.31824-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Change
 options->data_channel_use_ekm to flags
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

Lightly stared at code and ran client-side tests that actually used
EKM... which meant "upgrading the server the t_client tests talk to"
(and all passes).

Your patch has been applied to the master branch.

commit 9c625f4a6633de05d030884cac779cb41a5060e1
Author: Arne Schwabe
Date:   Thu Apr 8 16:02:26 2021 +0200

     Change options->data_channel_use_ekm to flags

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210408140229.31824-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22084.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


