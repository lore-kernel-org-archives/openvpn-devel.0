Date: Sun, 19 Oct 2025 19:11:38 +0200 (CEST)
Message-Id: <202510191711.59JHBcW8079900@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251017205837.8553-1-gert@...1296...>
References: <20251017205837.8553-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: remove
 dco_read/write_bytes from dco_context_t
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
To: Ralf Lici <ralf@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

As this is fairly straightforward ("remove things nobody wants anymore"),
I have only compile-tested on FreeBSD/DCO, Linux/DCO and MinGW.  Compiles
fine :-)

Your patch has been applied to the master branch.

commit 3e76d8f8a475d08bcb50321e742a06c53e19d45d
Author: Ralf Lici
Date:   Fri Oct 17 22:58:31 2025 +0200

     dco: remove dco_read/write_bytes from dco_context_t

     Signed-off-by: Ralf Lici <ralf@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1276
     Message-Id: <20251017205837.8553-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33431.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


