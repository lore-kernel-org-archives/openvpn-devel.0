Date: Sun, 5 Dec 2021 19:04:30 +0100 (CET)
Message-Id: <202112051804.1B5I4U7I091218@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211124100838.861-1-lstipakov@...277...>
References: <20211124100838.861-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: vcpkg/pkcs11-helper:
 compatibility with latest vcpkg
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

Acked-by: Gert Doering <gert@...1296...>

I have no idea what this does, but it's "windows building" and not
"openvpn code", so "you're the expert here"...

I would ask for a 2.5.5 "pre-release" installer with this change, and
some testing, though.

Your patch has been applied to the master and release/2.5 branch.

commit e832658a6d7a78c97fc53a78faeda31419583529 (master)
commit 11437f53520e2e6b3a30202c7cbd9608c10a678d (release/2.5)
Author: Lev Stipakov
Date:   Wed Nov 24 12:08:38 2021 +0200

     vcpkg/pkcs11-helper: compatibility with latest vcpkg

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211124100838.861-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23253.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


