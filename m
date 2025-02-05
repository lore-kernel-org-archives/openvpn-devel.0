Date: Wed, 5 Feb 2025 18:10:44 +0100 (CET)
Message-Id: <202502051710.515HAiv8094255@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250205170232.3473-1-gert@...1296...>
References: <20250205170232.3473-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: add missing (void) to win32
 function declarations
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Found these while testing #815 on ubuntu/mingw...

Patch has been applied to the master branch.

commit 817577d56ba48e160d4c7ad939ce62a93b55ab7f
Author: Gert Doering
Date:   Wed Feb 5 18:02:32 2025 +0100

     add missing (void) to win32 function declarations

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20250205170232.3473-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30813.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


