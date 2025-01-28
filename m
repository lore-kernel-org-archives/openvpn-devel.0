Date: Tue, 28 Jan 2025 15:04:18 +0100 (CET)
Message-Id: <202501281404.50SE4IiX005095@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250128134454.2888-1-gert@...1296...>
References: <20250128134454.2888-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco_linux: extend netlink error
 cb with extra info
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
To: Antonio Quartulli <antonio@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Straight and to the point, after some initial complications due to older
Linux distributions...  v9 looks good to me, comes from the Netlink master,
and both BB and GHA claim "it's not failing anything"

Your patch has been applied to the master branch.

commit edad5fa42bff2f291d7d416ccb90f4e7cd5b3f39
Author: Antonio Quartulli
Date:   Tue Jan 28 14:44:54 2025 +0100

     dco_linux: extend netlink error cb with extra info

     Signed-off-by: Antonio Quartulli <antonio@...2726...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20250128134454.2888-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30658.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


