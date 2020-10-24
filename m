Date: Sat, 24 Oct 2020 22:01:08 +0200 (CEST)
Message-Id: <202010242001.09OK18ld091080@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201023113431.26691-4-arne@...1227...>
References: <20201023113431.26691-4-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove explicit setting of
 peer_id to false
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

Acked-by: Gert Doering <gert@...1296...>

I can see why this initalization was put there, initially, to 
make clear "P_DATA_V2 is not enabled by default" - but since we do
not do this for all other "do not enable this $bool by default"
initializations either, it is indeed an oddball and confuses more
than it helps.

(If Lev yells at me that he really likes this particular line I
can put it back, though :-) )

Your patch has been applied to the master branch.

commit 0d4ca79d4fc3c42b3970190f96781ed4f2552b32
Author: Arne Schwabe
Date:   Fri Oct 23 13:34:30 2020 +0200

     Remove explicit setting of peer_id to false

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20201023113431.26691-4-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21218.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


