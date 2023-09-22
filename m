Date: Fri, 22 Sep 2023 18:09:51 +0200 (CEST)
Message-Id: <202309221609.38MG9p0r036021@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230911110735.34491-1-frank@...2641...>
References: <20230911110735.34491-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: GHA: new workflow to submit
 scan to Coverity Scan service
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

Acked-by: Gert Doering <gert@...1296...>

I'm not sure how that works, and how to test it - but the description
matches what we agreed as being useful ("run the test each night, but
only if something new was pushed this day").

Your patch has been applied to the master and release/2.6 branch.

commit 607ae9b821665dadb6bd0a3ceb6288bda10d5e67 (master)
commit 36605648a8974f1f7151a5842e94c75d08410fd0 (release/2.6)
Author: Frank Lichtenheld
Date:   Mon Sep 11 13:07:35 2023 +0200

     GHA: new workflow to submit scan to Coverity Scan service

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230911110735.34491-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27001.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


