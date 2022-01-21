Date: Fri, 21 Jan 2022 14:23:14 +0100 (CET)
Message-Id: <202201211323.20LDNEp2033170@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220111150605.208-1-lstipakov@...277...>
References: <20220111150605.208-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: vcpkg-ports/pkcs11-helper: bump
 to release 1.28
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

I have no idea what this does, but I understand that it's related to
MSVC building and that we generally want/need to bump pkcs11-helper to
version 1.28 -> so, this is what it does :-)

Since this does not touch anything code or mingw-build-related I have
not tested it beyond "does 'git show' look reasonable?".

Your patch has been applied to the master and release/2.5 branch.

commit bced08530c011fc9ea2b736938e0ca2199a45e1b (master)
commit f71ae77ad7e44d7983606dfd79bfaf988daf0432 (release/2.5)
Author: Lev Stipakov 
Date:   Tue Jan 11 17:06:05 2022 +0200

     vcpkg-ports/pkcs11-helper: bump to release 1.28

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220111150605.208-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23526.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


