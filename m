Date: Sun, 16 Nov 2025 23:02:18 +0100 (CET)
Message-Id: <202511162202.5AGM2IqI057967@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251116183622.11727-1-gert@...1296...>
References: <20251116183622.11727-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl: Change update argument of
 compute_earliest_wakeup to time_t
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

Explanation & change make sense.  Smoke-tested on Linux.

Your patch has been applied to the master branch.

commit 0e2fc09d4336bd3e87dfb37123ba4df208b1c048
Author: Frank Lichtenheld
Date:   Sun Nov 16 19:36:15 2025 +0100

     ssl: Change update argument of compute_earliest_wakeup to time_t

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1299
     Message-Id: <20251116183622.11727-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34482.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


