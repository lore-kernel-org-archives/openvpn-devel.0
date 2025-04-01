Date: Tue, 1 Apr 2025 22:52:56 +0200 (CEST)
Message-Id: <202504012052.531KquN0094499@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250401181535.7854-1-gert@...1296...>
References: <20250401181535.7854-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-win: Fix crash when
 cancelling pending operation
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

I haven't tested it, just stared at the code, and test compiled with
mingw.  The change itself is straightforward - move the OVERLAPPED
structure inside struct tuntap, so it will share the same lifetime
(diagnosing this from a crash trying to close tt->hand is more 
impressive ;-) )

Reference URLs point to the sf.net list archive again, because
mail-archive.org is refusing to acknowledge existence of this mail...

Your patch has been applied to the master branch.

commit f60a49362515a87ccf8db406ef422499adf34eb7
Author: Lev Stipakov
Date:   Tue Apr 1 20:15:30 2025 +0200

     dco-win: Fix crash when cancelling pending operation

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250401181535.7854-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59168247/
     URL: https://gerrit.openvpn.net/c/openvpn/+/928
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


