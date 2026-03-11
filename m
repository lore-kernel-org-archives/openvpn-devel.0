Date: Wed, 11 Mar 2026 18:36:22 +0100 (CET)
Message-Id: <202603111736.62BHaM0x024445@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260311163852.21387-1-gert@...1296...>
References: <20260311163852.21387-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Win32: Make interface index
 DWORD consistently
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Patch in itself looks reasonable, and also fixes the -Werror breakage
I introduced merging the last one "out of sequence".  Sorry for that.

Your patch has been applied to the master branch.

commit 7afd3cf066bfc13b3b01c0845ccf1c35ea640b1d
Author: Frank Lichtenheld
Date:   Wed Mar 11 17:38:45 2026 +0100

     Win32: Make interface index DWORD consistently

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1519
     Message-Id: <20260311163852.21387-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36021.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


