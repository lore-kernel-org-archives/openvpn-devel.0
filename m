Date: Mon, 20 Apr 2026 19:31:29 +0200 (CEST)
Message-Id: <202604201731.63KHVT6W093102@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260420160732.9492-1-gert@...1296...>
References: <20260420160732.9492-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: GHA: Factor out building SSL
 libs to a reusable workflow
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

I still have no idea what this is all about, but having less duplication
of code/rules is generally a good thing :-) - tested both branches in my GH
repo, all green...

Your patch has been applied to the master and release/2.7 branch
("long-term maintenance of test/build infrastructure").

commit 8485518dce6b7ebeda6295fcdf3bc7476b7b9117 (master)
commit 66be31fe491f5f6ff85ef135272bf2b6f064a9b5 (release/2.7)
Author: Frank Lichtenheld
Date:   Mon Apr 20 18:07:27 2026 +0200

     GHA: Factor out building SSL libs to a reusable workflow

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1630
     Message-Id: <20260420160732.9492-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36686.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


