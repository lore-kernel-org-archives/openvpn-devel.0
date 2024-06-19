Date: Wed, 19 Jun 2024 16:40:18 +0200 (CEST)
Message-Id: <202406191440.45JEeIuU076380@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240619134451.222-1-lev@...515...>
References: <20240619134451.222-1-lev@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: interactive.c: Improve access
 control for gui<->service pipe
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is another "developed in secrecy on the security@ mailing list"
patch, because it has security implications.

It affects windows builds, where it is possible to have two different
processes provide a pipe with the same name (ewwww!), and a connecting
client will might not end up at the interactive service but at "some
random process".  This is not a major issue in itself, but the GUI sends
a "user credentials token" (so openvpn.exe can be run as "normal user"
later on) and this can be abused by a malicious process to get access
to the user running openvpn-gui.exe - now, it's a somewhat theoretical
attack (malicious software having sufficient privileges to do use
a user token, but not having either "that user access" or "system privs"
to start with) - but it's worth fixing.

So, just stay calm, don't panic, and upgrade to 2.6.11 ;-)

I have not tested this beyond "does it compile?" on a local
ubuntu/mingw build and on GHA.  Lev, Selva and Heiko did all the
grunt work on coming up with a solution and testing the patch.

Your patch has been applied to the release/2.6 branch.  A rebase to
master is in the works (this conflicted with the snprintf() cleanup
patch, which is "only in master" and was merged right after *this*
was developed and tested).

Backport to release/2.5 is not fully straightforward either - there have
been a number of fixes to interactive.c, and not all of them have been
backported.  OTOH, we do not intend to provide 2.5.x windows binaries 
ever again (and said so at 2.5.10 release), so now is the time to
upgrade your windows clients to 2.6.x

commit 51301eb6c233c284270e3f4ed0c7f5781f2b5c62 (release/2.6)
Author: Lev Stipakov
Date:   Wed Jun 19 16:44:23 2024 +0300

     interactive.c: Improve access control for gui<->service pipe

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20240619134451.222-1-lev@...515...>
     URL: https://www.mail-archive.com/search?l=mid&q=20240619134451.222-1-lev@...515...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


