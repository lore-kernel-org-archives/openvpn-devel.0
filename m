Date: Thu, 20 Feb 2025 10:30:17 +0100 (CET)
Message-Id: <202502200930.51K9UHcq001718@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250220080907.9298-1-gert@...1296...>
References: <20250220080907.9298-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-win: kernel notifications
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

Tested v20 on a Windows server as part of the tests for #815 - the
directly-visible bit for #816 is "make --timeout work".  I did not
test key rollover, though.

v20->v21 is comment + style, so did not re-test beyond a quick compile
test locally and waiting for the buildbots to be happy with it.

Your patch has been applied to the master branch.

commit 4599c9209d12d59140a7ae831e8d5abdd2749163
Author: Lev Stipakov
Date:   Thu Feb 20 09:09:07 2025 +0100

     dco-win: kernel notifications

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250220080907.9298-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30950.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


