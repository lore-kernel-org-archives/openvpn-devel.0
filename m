Date: Sun, 18 Apr 2021 22:05:49 +0200 (CEST)
Message-Id: <202104182005.13IK5nAO090761@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210408133626.29232-1-arne@...1227...>
References: <20210408133626.29232-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Ensure using const variables
 with EVP_PKEY_get0_*
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

I have not tested this any further, but glance-at-code looks good.

commit 6fc292d2ed008a53061ce953dea6ff1e692e6723
Author: Arne Schwabe
Date:   Thu Apr 8 15:36:26 2021 +0200

     Ensure using const variables with EVP_PKEY_get0_*

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210408133626.29232-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22081.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


