Date: Wed, 12 Nov 2025 12:26:49 +0100 (CET)
Message-Id: <202511121126.5ACBQnBK037347@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251109154438.15464-1-gert@...1296...>
References: <20251109154438.15464-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: iservice: make sure directories
 have trailing backslash
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

Stared at the code, it does what it says on the lid, though I wonder
if that's a reasonable thing to do in all cases... "log_dir" seems to
be fully unused in the code base, and "bin_dir" is only used once (to
call tapctl), and that one has two backslashes now, as the

src/openvpnserv/interactive.c:    if (swprintf_s(cmd, _countof(cmd), L"%s\\tapctl.exe", settings.bin_dir) < 0)

adds another one...  but it will not hurt, as far as I understand.

I have changed the Subject: to not end in a single "\", because that 
upsets half my scripts later on :-)

Your patch has been applied to the master branch.

commit 985f4eaeccf0d3f9d833f3271d88634e237d7cd5
Author: Heiko Hund
Date:   Sun Nov 9 16:44:31 2025 +0100

     iservice: make sure directories have trailing backslash

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1336
     Message-Id: <20251109154438.15464-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34285.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


