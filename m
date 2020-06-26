Date: Fri, 26 Jun 2020 14:50:20 +0200 (CEST)
Message-Id: <202006261250.05QCoK7c002990@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200626110554.3690-1-arne@...1227...>
References: <20200626110554.3690-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Make compression asymmetric by
 default and add warnings
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

Lightly tested, aka "t_client test on FreeBSD and Linux", which does use
various lzo/lz4 variants - so it's not breaking existing setups (though
it might turn off compression :-) - which I have not verified)

David: this brings in a sizeable manpage change - please transform in a
suitable way into your tree... (unfortunate, but not fully avoidable)

commit c67e93b25208be2e893473bea4aabccbde914f47
Author: Arne Schwabe
Date:   Fri Jun 26 13:05:54 2020 +0200

     Make compression asymmetric by default and add warnings

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20200626110554.3690-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20138.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


