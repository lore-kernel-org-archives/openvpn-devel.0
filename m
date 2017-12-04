Date: Mon, 4 Dec 2017 18:59:19 +0100 (CET)
Message-Id: <201712041759.vB4HxJaT048678@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20171203211654.1044-1-simon@...2293...>
References: <20171203211654.1044-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: Add support for
 multi-instances
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
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel@lists.sourceforge.net

I've done a bit of staring at the code as well, and it seems to make
sense (but thanks to Selva for a thorough review and actually testing
this :-) ).

Given the interaction with EduVPN 2.4, and the fairly well localized
changes, I agree to Selva's suggestion of having it in 2.4 as well.

Your patch has been applied to the master branch and release/2.4 branch.

commit f3fec49b1c916a701058ef2445b4c07005c30673 (master)
commit 8a52d07c844d718c7032c4936e0c43f0e3e6033d (release/2.4)
Author: Simon Rozman
Date:   Sun Dec 3 22:16:54 2017 +0100

     openvpnserv: Add support for multi-instances

     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20171203211654.1044-1-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16002.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


