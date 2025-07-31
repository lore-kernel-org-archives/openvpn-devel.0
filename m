Date: Thu, 31 Jul 2025 12:55:29 +0200 (CEST)
Message-Id: <202507311055.56VAtTa5086394@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250731104833.23305-1-gert@...1296...>
References: <20250731104833.23305-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix --dns options for TAP
 adapter
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

I have stared at the code, and together with the findings from the
previous commit (040e0d1c) this very much looks like the right fix.

I haven't tested it myself, just let the BBs compile-test on all
platforms (especially win32 <-> android, given the #ifdefs in the
neighbourhood)

Your patch has been applied to the master branch.

commit 264fe91660fb1a7a426161a9a042ed3f9bd0a7a6
Author: Lev Stipakov
Date:   Thu Jul 31 12:48:27 2025 +0200

     Fix --dns options for TAP adapter

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250731104833.23305-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32436.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


