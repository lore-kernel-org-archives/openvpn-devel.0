Date: Fri, 3 Nov 2017 19:54:39 +0100 (CET)
Message-Id: <201711031854.vA3IsdId002989@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1508094315-466-1-git-send-email-selva.nair@...277...>
References: <1508094315-466-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix missing check for return
 value of malloc'd buffer
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.

Patch is actually fairly trivial as soon as one recognizes that 
"utf8to16()" is one of our functions, which does exactly what the
code removed here does - length check, malloc, malloc check, 
conversion-if-memory-allocated.

Your patch has been applied to the master and release/2.4 branch.

commit f3d389a2d2b87aeb649bfdccd596f485346a32c7 (master)
commit 9ef03874bf0ca35348c58b4b21cb06cc49026efd (release/2.4)
Author: Selva Nair
Date:   Sun Oct 15 15:05:15 2017 -0400

     Fix missing check for return value of malloc'd buffer

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1508094315-466-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15641.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


