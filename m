Date: Fri, 9 Jun 2017 22:44:31 +0200 (CEST)
Message-Id: <201706092044.v59KiVVB022320@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <CAO5O-EL11jDxO+c1Gu0FvunqwUTW2uxjy910+A-s63Nr5O3NWw@...278...>
References: <CAO5O-EL11jDxO+c1Gu0FvunqwUTW2uxjy910+A-s63Nr5O3NWw@...278...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix 2 memory leaks in proxy
 authentication routine
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
To: Guido Vranken <guidovranken@...277...>
Cc: openvpn-devel@lists.sourceforge.net

ACK (see lengthy reply in previous mail).

As a side note: please send patches with "git send-email" - your mail
client wrapped all the long lines, so I had to repair the patch before
it could be applied.

Your patch has been applied to the master, release/2.4 and release/2.3 branch.

commit 8d606cd3f6bce304874b1d7745d40d11f64ea17d (master)
commit ec204e172f524e40ec6dcefaffb4b0ffd182fe2e (release/2.4)
commit a95927638f8ee5e14e7ac8845b20c5350cefc9b8 (release/2.3)

Author: Guido Vranken
Date:   Thu Jun 8 16:36:54 2017 +0200

     Fix 2 memory leaks in proxy authentication routine

     Signed-off-by: Guido Vranken <guidovranken@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <CAO5O-EL11jDxO+c1Gu0FvunqwUTW2uxjy910+A-s63Nr5O3NWw@...278...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14758.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


