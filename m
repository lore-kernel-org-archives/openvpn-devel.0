Date: Fri, 8 May 2026 17:48:26 +0200 (CEST)
Message-Id: <202605081548.648FmQQj052582@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260507075321.25123-1-gert@...1296...>
References: <20260507075321.25123-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco_freebsd: Add
 check_malloc_return after realloc
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

Good find.  Arguably this is a bug, even if in the "unlikely to ever happen"
category, so backported to release/2.7 (without the cppcheck file).

Mildy tested on FreeBSD 14 + DCO (... after repairing the t_server setup).

Your patch has been applied to the master and release/2.7 branch.

commit fcc34b135222edf3d53976f406f8db19c19294c0 (master)
commit 1a15b3fa51537592bfda1ea588e28f73ded39caf (release/2.7)
Author: Frank Lichtenheld
Date:   Thu May 7 09:53:15 2026 +0200

     dco_freebsd: Add check_malloc_return after realloc

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1669
     Message-Id: <20260507075321.25123-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36842.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


