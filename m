Date: Tue, 21 Nov 2023 12:45:18 +0100 (CET)
Message-Id: <202311211145.3ALBjIpr073592@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231121110430.16893-1-frank@...2641...>
References: <20231121110430.16893-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: sample-keys: renew for the next
 10 years
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

Passes selftests on master and release/2.6, and that's all these
keys are there for.

A minor script change has made it into the patch (gen-sample-keys.sh)
but this is fine as well (and only run for generating these files, not
automatically).

Your patch has been applied to the master and release/2.6 branch
(because we expect 2.6 to be around longer than 2024).

commit 78e0c5f2f57a18e8ea60951696a458a4b3ff3621 (master)
commit c1a983e8b8815dbc6a4e3aadf159d4cc9205680d (release/2.6)
Author: Frank Lichtenheld
Date:   Tue Nov 21 12:04:30 2023 +0100

     sample-keys: renew for the next 10 years

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20231121110430.16893-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27530.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


