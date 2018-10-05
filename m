Date: Fri, 5 Oct 2018 16:28:59 +0200 (CEST)
Message-Id: <201810051428.w95ESxNb042808@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1538510474-27602-3-git-send-email-selva.nair@...277...>
References: <1538510474-27602-3-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Refactor sending commands to
 interactive service
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

Acked-by: Gert Doering <gert@...1296...>

Patch looks good.  This one I have actually tested :-) - test build
on ubuntu 16.04/mingw, test run on win7.  This test also includes setting
of DHCP mode from an unprivileged user (which works)

  Fri Oct 05 16:26:52 2018 DHCP enabled on interface 15 using service

Your patch has been applied to the master branch.

Only merged to master because "refactoring".


commit 717c19300e27db8127553800cf8e0d81bd5bd5a8
Author: Selva Nair
Date:   Tue Oct 2 16:01:14 2018 -0400

     Refactor sending commands to interactive service

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1538510474-27602-3-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17519.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


