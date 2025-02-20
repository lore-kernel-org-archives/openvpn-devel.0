Date: Thu, 20 Feb 2025 14:23:57 +0100 (CET)
Message-Id: <202502201323.51KDNvKZ009699@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250220124205.27502-1-gert@...1296...>
References: <20250220124205.27502-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-win: support for iroutes
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

Tested IPv4/IPv6 iroutes on my Windows 10 VM, gave interesting results
and nice blue screens ;-) - but the userland / OpenVPN part did exactly
what we wanted it to do.  The kernel side has some issues with host
routes, but Lev is working on it.  The userland API won't change, so
this can proceed nevertheless.

Since this touches the Linux/FreeBSD DCO part (mostly due to new
#ifdefs and trying to avoid warnings/extra #ifdefs) I did also test
on Linux/DCO - still works fine.

Your patch has been applied to the master branch.

commit bca57c1d9c82c890f1b16586b416fabd4f9b1e56
Author: Lev Stipakov
Date:   Thu Feb 20 13:42:05 2025 +0100

     dco-win: support for iroutes

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250220124205.27502-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30958.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


