Date: Tue, 21 Mar 2023 09:22:25 +0100 (CET)
Message-Id: <202303210822.32L8MP2a086584@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230320195820.6675-1-a@...2181...>
References: <20230320195820.6675-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-linux: remove M_ERRNO flag
 when printing netlink error message
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

"Trivially correct" :-) - compile-tested on a DCO enabled linux.

Your patch has been applied to the master and release/2.6 branch.

commit 23903fd579353c9892415a750f17a9832a79cced (master)
commit 047f772b84843344b6131e9e915472d14adcea2b (release/2.6)
Author: Antonio Quartulli
Date:   Mon Mar 20 20:58:20 2023 +0100

     dco-linux: remove M_ERRNO flag when printing netlink error message

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230320195820.6675-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26452.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


