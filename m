Date: Mon, 14 Feb 2022 08:32:24 +0100 (CET)
Message-Id: <202202140732.21E7WOUR009589@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220214003321.3741582-1-arne@...1227...>
References: <20220214003321.3741582-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add unit test for mssfix with
 compression involved
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

Have not done all the calculations myself, but passes the unit tests
for "with compression" (default), "without LZO" and "with no compression".

Your patch has been applied to the master branch.

commit de152bccc00daf7aebfa97e376ec2e37c3e1f574
Author: Arne Schwabe
Date:   Mon Feb 14 01:33:21 2022 +0100

     Add unit test for mssfix with compression involved

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220214003321.3741582-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23777.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


