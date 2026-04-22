Date: Wed, 22 Apr 2026 09:45:51 +0200 (CEST)
Message-Id: <202604220745.63M7jpWQ035802@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260419134205.21459-1-gert@...1296...>
References: <20260419134205.21459-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dev-tools: Add script to run
 cppcheck against the code-base
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

While we do not have all cppcheck-found edges and corners properly sanded,
it makes sense to have the infrastructure and the exclude lists around
already.

No code changes to "the project", just new devtool + new "make" target.

Your patch has been applied to the master branch.

commit 0b7c29535049baec9fe89821cd2a65437094c9b1
Author: Frank Lichtenheld
Date:   Sun Apr 19 15:41:57 2026 +0200

     dev-tools: Add script to run cppcheck against the code-base

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1620
     Message-Id: <20260419134205.21459-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36664.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


