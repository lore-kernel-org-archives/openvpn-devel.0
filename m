Date: Fri, 5 Feb 2016 09:22:22 +0100 (CET)
Message-Id: <201602050822.u158MMve041784@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1453835508-26119-1-git-send-email-gert@...1296...>
References: <1453835508-26119-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: interactive service v3
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
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

I have taken out the "AM_PROG_CC_C_O" change to configure.ac as the
autoconf docs tell me that AC_PROG_CC will automatically check what
this used to do, starting with 1.14 - and *that* one seems to be 
auto-invoked as well...  (and I do not see us compiling on a system 
where the compiler cannot handle -c and -o at the same time any time
soon anyway):

  checking for gcc... gcc
  checking whether the C compiler works... yes
  ...
  checking whether gcc understands -c and -o together... yes
  ...

Next steps before this is ready for 2.4:

 - GUI: do not use the service pipe if running with admin privs
 - GUI+interactive service: change calling convention to ensure only
   whitelisted openvpn.exe options can be set up, including path checking
   to .ovpn files
 - GUI/installer/service: introduce a way to specify whether config files
   are restricted to "only from admin-writeable openvpn\config\ directory,
   or anywhere in the system" (however that might look in the end)
 - GUI: log directory if program files\openvpn\log\ isn't user-writeable
 - openvpn/interactive service: handle --block-outside-dns


commit a24dd2e31f196c76594666f37c130817402acb15 (master)
Author: Heiko Hund
Date:   Tue Jan 26 20:11:48 2016 +0100

     interactive service v3

     Signed-off-by: Heiko Hund <heiko.hund@...1489...>
     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Selva Nair <selva.nair@...277...>        (Service changes)
     Acked-by: Arne Schwabe <arne@...1227...>          (OpenVPN changes)
     Message-Id: <1453835508-26119-1-git-send-email-gert@...1296...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11027


--
kind regards,

Gert Doering


