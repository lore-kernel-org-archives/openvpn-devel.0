Date: Tue, 15 Sep 2020 16:46:44 +0200 (CEST)
Message-Id: <202009151446.08FEki12005929@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200915094101.86470-1-gert@...1296...>
References: <20200915094101.86470-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix netbits setting (in TAP
 mode) for IPv6 on Windows.
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Patch has been applied to the master and release/2.5 branch.

(Due to build pains I have not tested this on Win7 yet, but
will do so with the upcoming beta5 installer - I do not expect
any surprises, though)

commit 81b6a7e75b343e324a44b4476c89c596d7b6c74b (master)
commit 859952560aff6d4442cdfa0c41ced494e9dc397e (release/2.5)
Author: Gert Doering
Date:   Tue Sep 15 11:41:01 2020 +0200

     Fix netbits setting (in TAP mode) for IPv6 on Windows.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20200915094101.86470-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21008.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


