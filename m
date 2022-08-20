Date: Sat, 20 Aug 2022 11:29:55 +0200 (CEST)
Message-Id: <202208200929.27K9Tt1M009928@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220820084719.243-1-lstipakov@...277...>
References: <20220820084719.243-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-win: use run-time dynamic
 linking for GetOverlappedResultEx
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

I have *not* tested this, but we've discussed the patch on IRC, and the
code matches what we want to achieve.  We've had GetProcAddress() dynamic
resolution in the code before (some IPv6 vs XP/Vista stuff, IIRC) and
this all looks reasonable.  GHA claims it compiles, and Lev said he has
tested on Win7+Win10.

(The intention is "have one single openvpn.exe binary for Win7 + Win10/11,
which will do non-dco stuff on Win7 - no driver - and DCO stuff on 
Win10/11" - much simpler than having to build extra Win7 installers, and
we still want to support Win7 "unless it's getting too costly")

Your patch has been applied to the master branch.

commit 2f8053f9a97584b759d11d05a668d38653508617
Author: Lev Stipakov
Date:   Sat Aug 20 11:47:19 2022 +0300

     dco-win: use run-time dynamic linking for GetOverlappedResultEx

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220820084719.243-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25038.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


