Date: Fri, 16 Dec 2022 09:47:15 +0100 (CET)
Message-Id: <202212160847.2BG8lF1m046650@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221215190143.2107896-3-arne@...1227...>
References: <20221215190143.2107896-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl_verify: Fix memleak if
 creating deferred auth control files fails
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

As agreed on the security@ list - this covers all possible leaks, and
is fully "normal OpenVPN style".  I didn't test actual file creation
failures, but I *did* test regular server operation with plugins and
scripts, and that all still works fine.

As instructed, I've fixed the "Trial" to read "Trail of Bits" :-)

Your patch has been applied to the master and release/2.6 branch.

release/2.5 and older do not contain this code (no async/deferred 
--verify-auth-user-pass scripts yet) - that was only added in 2021
via commit 28e6103096ae8.

commit 0567da5377704cf64bd2599f2d49aa478d386941 (master)
commit cdfdfb3da0ce714f43b23f679a8ef9b36ab9f370 (release/2.6)
Author: David Sommerseth
Date:   Thu Dec 15 20:01:37 2022 +0100

     ssl_verify: Fix memleak if creating deferred auth control files fails

     Signed-off-by: David Sommerseth <davids@...515...>
     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221215190143.2107896-3-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25737.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


