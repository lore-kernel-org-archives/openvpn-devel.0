Date: Sun, 19 Mar 2017 17:21:42 +0100 (CET)
Message-Id: <201703191621.v2JGLgEh031695@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1488653397-2309-1-git-send-email-steffan@...1856...>
References: <1488653397-2309-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Deprecate --ns-cert-type
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  Makes sense from the discussion, and the patch itself is trivial
(just adding a warning and updating documentation, not disturbing
functionality).  Plus, does what it says on the lid :-)

Your patch has been applied to the master and release/2.4 branch.

commit 2dc332266449d5378f1fe04f950cbebf128ec9c9 (master)
commit 57637d0f677d824dacdc83d858357ccc80723f45 (release/2.4)
Author: Steffan Karger
Date:   Sat Mar 4 19:49:57 2017 +0100

     Deprecate --ns-cert-type

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1488653397-2309-1-git-send-email-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14222.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


