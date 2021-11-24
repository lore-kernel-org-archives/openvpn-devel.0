Date: Wed, 24 Nov 2021 17:22:23 +0100 (CET)
Message-Id: <202111241622.1AOGMNsf017889@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211124160347.1245-1-lstipakov@...277...>
References: <20211124160347.1245-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: ring_buffer.h: fix GCC warning
 about unused function
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks.  (Found while looking at the compiler warnings reviewing
the OpenSSL config loading patch).  Test built on MinGW, warnings gone.

Your patch has been applied to the master branch.

commit 71371f04afa6eba3ea02a67590a70e018cf203e5 (master)
commit 36b3129d47a6dbfcd43ff4773c69618a28eb48bc (release/2.5)
Author: Lev Stipakov
Date:   Wed Nov 24 18:03:47 2021 +0200

     ring_buffer.h: fix GCC warning about unused function

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211124160347.1245-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23260.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


