Date: Fri, 4 Sep 2020 15:50:52 +0200 (CEST)
Message-Id: <202009041350.084DoqPM000139@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1599177404-29996-1-git-send-email-selva.nair@...277...>
References: <1599177404-29996-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: In tap.c use DiInstallDevice to
 install the driver on a new adapter
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

Your patch has been applied to the master and release/2.5 branch.

Minor typo in commit message ("instalaltion") fixed.

(I have not tested anything, fully trusting you and Lev here - thanks!)

commit f3f09541dcff3f0b307067bdf5dcaabc530db4c7 (master)
commit 87b43ded380af06129ea59744d27684e36635c74 (release/2.5)
Author: Selva Nair
Date:   Thu Sep 3 19:56:44 2020 -0400

     In tap.c use DiInstallDevice to install the driver on a new adapter

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <1599177404-29996-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20880.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


