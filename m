Date: Sun, 19 Apr 2020 12:03:34 +0200 (CEST)
Message-Id: <202004191003.03JA3Y6n007885@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200418094350.26349-1-a@...2181...>
References: <20200418094350.26349-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: sitnl: fix ignoring EEXIST when
 sending a netlink command
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Proper error handling is hard, we should just always crash with ASSERT() :-)

Your patch has been applied to the master branch.

commit db3d737ba3ef9d83c5ceffa2f653d0ee4a8abb54
Author: Antonio Quartulli
Date:   Sat Apr 18 11:43:50 2020 +0200

     sitnl: fix ignoring EEXIST when sending a netlink command

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200418094350.26349-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19777.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


