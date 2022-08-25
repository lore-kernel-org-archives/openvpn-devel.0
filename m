Date: Thu, 25 Aug 2022 22:33:23 +0200 (CEST)
Message-Id: <202208252033.27PKXNDK084241@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220822141806.39406-1-frank@...2641...>
References: <20220822141806.39406-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: t_client.sh: do not require
 fping6
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

Thanks for working on that ancient script :-) - so far I mostly just
fixed the buildslaves by adding wrapper scripts, but of course this
is nicer.

I have not actually *tested* this yet, but the change looks reasonable,
and the buildbots will tell us soon enough...

To avoid the conflict when pulling up to release/2.5, I've just
applied the "Allow to force FAIL on prerequisite fails" (79932b94)
to 2.5 as well... since we do want good testing for 2.5, that one
is useful, too.

Your patch has been applied to the master and release/2.5 branch.

commit fb06c9f026a78b879f264ab8e67de09d725b5540 (master)
commit 64cac790b9d64b3c07fa5222bf46754a04ea1659 (release/2.5)
Author: Frank Lichtenheld
Date:   Mon Aug 22 16:18:06 2022 +0200

     t_client.sh: do not require fping6

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20220822141806.39406-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25058.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


