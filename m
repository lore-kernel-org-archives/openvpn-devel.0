Date: Sun, 19 Jan 2020 15:59:58 +0100 (CET)
Message-Id: <202001191459.00JExwp4061458@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200116141900.1524-1-simon@...2293...>
References: <20200116141900.1524-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: wintun: refactor code to use
 enum driver type
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

Your patch has been applied to the master branch.

Test compiled on MingW/Ubuntu 16 (worked).  Stared a bit at the code, 
most of it looks good and actually simplifies.  The convoluted if() is
something I'd like to see unwrapped - see other mail.

commit 36215dc5c3e08a935392460ab236030d6d9cde8b
Author: Simon Rozman
Date:   Thu Jan 16 15:19:00 2020 +0100

     wintun: refactor code to use enum driver type

     Signed-off-by: Simon Rozman <simon@...2293...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20200116141900.1524-1-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19312.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


