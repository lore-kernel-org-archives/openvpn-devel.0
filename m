Date: Mon, 13 Dec 2021 15:51:08 +0100 (CET)
Message-Id: <202112131451.1BDEp8vK058325@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211213135814.265-1-lstipakov@...277...>
References: <20211213135814.265-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: config-msvc.h: indicate key
 material export support
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

Applied to 2.5 even if 2.5 does not have tls-ekm, but it has the
generic "keying material export" which works in 2.5.0-2.5.3 and got
broken due to the change to MSVC in 2.5.4 -> regression, bugfix.

Your patch has been applied to the release/2.5 branch.

commit 0cad4ec29ad303bf1ec64035f0345e3dacf5a932
Author: Lev Stipakov
Date:   Mon Dec 13 15:58:14 2021 +0200

     config-msvc.h: indicate key material export support

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211213135814.265-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23395.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


