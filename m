Date: Mon, 10 Aug 2020 20:56:06 +0200 (CEST)
Message-Id: <202008101856.07AIu6SR029732@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200810143707.5834-15-arne@...1227...>
References: <20200810143707.5834-15-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Skip existing interfaces on
 opening the first available utun on macOS
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

Acked-by: Lev Stipakov <lstipakov@...277...>

Lev ACKed the v1 of this patch, with the request to remove the
ASSERT() wrapping - v2 fixes this instead so it actually works, so
that should take the comment into account.  I think the ASSERT()
is slightly overdoing things - this cannot fail, and having too
much "did it really not fail?" wrapping makes the code harder to
read again.  But then, I did not write the code, and it works...

Not really tested except for "test compile on current OSX and run
make check"

Your patch has been applied to the master branch.

commit 4edcf5710d043d366d8fd52a53b259399678309a
Author: Arne Schwabe
Date:   Mon Aug 10 16:37:04 2020 +0200

     Skip existing interfaces on opening the first available utun on macOS

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20200810143707.5834-15-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20665.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


