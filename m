Date: Thu, 30 Oct 2025 17:17:06 +0100 (CET)
Message-Id: <202510301617.59UGH6sD015466@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251030150432.4689-1-gert@...1296...>
References: <20251030150432.4689-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: interactive.c: add the upper
 bound for startupdata size
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

Looks good, reasonable hardening against unasked-for garbage coming in
via the service pipe.  Have not tested this, but since you have so nicely
made event logging beautiful again, evidence should be clearly visible.

Your patch has been applied to the master branch.

commit 37af2c953266a3ffd34b3fa95317bd995e985aec
Author: Lev Stipakov
Date:   Thu Oct 30 16:04:26 2025 +0100

     interactive.c: add the upper bound for startupdata size

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1331
     Message-Id: <20251030150432.4689-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34039.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


