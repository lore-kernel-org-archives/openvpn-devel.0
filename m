Date: Sun, 5 Oct 2025 22:41:43 +0200 (CEST)
Message-Id: <202510052041.595KfhO6042572@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251003100602.375062-1-frank@...2641...>
References: <20251003100602.375062-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: platform: Do not assume
 uid_t/gid_t are signed
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Looks reasonable, has an ACK, passes BB tests :-)

Tested locally on my "t_client --dns and --user nobody" test instance,
also passes fine.

Your patch has been applied to the master branch.

commit eadae51341dbf80c83e827bb4011e80dfcbc6927
Author: Frank Lichtenheld
Date:   Fri Oct 3 12:06:02 2025 +0200

     platform: Do not assume uid_t/gid_t are signed

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: MaxF <max@...2606...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1206
     Message-Id: <20251003100602.375062-1-frank@...2641...>
     URL: https://www.mail-archive.com/search?l=mid&q=20251003100602.375062-1-frank@...2641...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


