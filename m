Date: Tue, 18 Mar 2025 18:35:51 +0100 (CET)
Message-Id: <202503181735.52IHZpFG001129@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250318172350.20996-1-gert@...1296...>
References: <20250318172350.20996-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Apply text-removal.sh script to
 Windows codebase
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Stared-at-code, as did Lev (whose +2 got lost due to gerrit flag changes).

Really 'just mechanically moving from TEXT("string") to L"string", "LPTSTR"
to "LPWSTR" and so on'.  I did a test compile on Ubuntu/MingW, and no
warnings ensued.

Your patch has been applied to the master branch.

commit 236cd36dadcf71be0ca75b3b77eacfcc265d2abf
Author: Frank Lichtenheld
Date:   Tue Mar 18 18:23:42 2025 +0100

     Apply text-removal.sh script to Windows codebase

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250318172350.20996-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31159.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


