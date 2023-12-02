Date: Sat, 2 Dec 2023 17:07:23 +0100 (CET)
Message-Id: <202312021607.3B2G7N0Q085858@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231128104129.62761-1-frank@...2641...>
References: <20231128104129.62761-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add check for nice in cmake
 config
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

Indeed, having that check would be nice :-)

Your patch has been applied to the master and releae/2.6 branch (bugfix).

commit 4d8ee61ce2c2a8b387773d33b4dd01bc2e147941 (master)
commit cc81f014bcbcfb248fdae91dc3527565c5889ff4 (release/2.6)
Author: Arne Schwabe
Date:   Tue Nov 28 11:41:29 2023 +0100

     Add check for nice in cmake config

     Acked-by: Frank Lichtenheld <frank@...2641...>
     Signed-off-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20231128104129.62761-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27574.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


