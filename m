Date: Tue, 27 Apr 2021 12:31:45 +0200 (CEST)
Message-Id: <202104271031.13RAVjxf084639@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210422151724.2132573-1-arne@...1227...>
References: <20210422151724.2132573-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move tls_select_primary_key
 into its own function
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

As Antonio says, "just moving around code" (and cleaning up a messy if()
statement - so besides this, it's really trivial to see in diff)

Your patch has been applied to the master branch.

commit 26e40c48b89478cb53d6c2733b346e6dbdc7480b
Author: Arne Schwabe
Date:   Thu Apr 22 17:17:18 2021 +0200

     Move tls_select_primary_key into its own function

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210422151724.2132573-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22198.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


