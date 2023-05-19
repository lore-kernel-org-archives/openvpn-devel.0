Date: Fri, 19 May 2023 09:28:23 +0200 (CEST)
Message-Id: <202305190728.34J7SN3S015821@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230518173345.2722530-1-selva.nair@...277...>
References: <20230518173345.2722530-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Interactive service: do not
 force a target desktop for openvpn.exe
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

This is all voodoo to me, but it doesn't break compilation, doesn't
bring in unsafe pointer constructs, and people say "it makes their use
case work", so it sounds like a good fix.

Microsoft documentation on

  https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-createprocessasuserw

says interesting things...

   "The user must have full access to both the specified window
    station and desktop. If you want the process to be interactive,
    specify winsta0\default. If the lpDesktop member is NULL, the
    new process inherits the desktop and window station of its
    parent process. If this member is an empty string, "", the new
    process connects to a window station using the rules described
    in Process Connection to a Window Station."

.. so we're moving from "winsta0\default" to "NULL" (startup_info is
ZeroMemory'ed), which sounds like "now it will run in the desktop
environment of the iservice", whatever *that* might be...  but it's
certainly a valid and documented choice...  and since openvpn.exe
"as run from iservice" doesn't want any windows etc., whatever makes
it succeed sounds good to me.

Your patch has been applied to the master and release/2.6 branch.

(Not sure this is a "bugfix" or a "mini feature", but it certainly
warrants a bit more thorough testing across Windows variants before
releasing 2.6.5)

commit 244d9b7942dabf0297c8f689457eeb0f9fa0aa1e (master)
commit 9e112be5dde043cdc1f073f33ada0a1810b730a6 (release/2.6)
Author: Selva Nair
Date:   Thu May 18 13:33:45 2023 -0400

     Interactive service: do not force a target desktop for openvpn.exe

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230518173345.2722530-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26705.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


