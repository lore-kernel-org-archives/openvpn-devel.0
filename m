Date: Thu, 19 Jan 2023 09:14:36 +0100 (CET)
Message-Id: <202301190814.30J8EaNb003319@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230118142428.162-1-timo@...2669...>
References: <20230118142428.162-1-timo@...2669...>
Subject: [Openvpn-devel] [PATCH applied] Re: Don't clear capability bounding
 set on capng_change_id
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
To: Timo Rothenpieler <timo@...2669...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks for so quickly coming to help with investigating the issue and
providing a fix :-)

I have not tested this myself, but the code change is trivial, and the
positive effects have been verified in the GH issue.  I have tested
that "running a DCO p2mp instance as user nobody" still works (it does).

Your patch has been applied to the master and release/2.6 branch.

commit d8523119b95db55d2c101b8364ce7e9d0d0f6f3a (master)
commit 99a098e13a427e72ade5ef2812b7ea342ea64aa6 (release/2.6)
Author: Timo Rothenpieler
Date:   Wed Jan 18 15:24:28 2023 +0100

     Don't clear capability bounding set on capng_change_id

     Signed-off-by: Timo Rothenpieler <timo@...2669...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230118142428.162-1-timo@...2669...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26048.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


