Date: Tue, 18 Mar 2025 18:47:25 +0100 (CET)
Message-Id: <202503181747.52IHlPKv001723@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250318173914.24425-1-gert@...1296...>
References: <20250318173914.24425-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: Clean up use of
 TEXT() from DNS patches
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

Everything very straightforward, TEXT to L"", adding "%s, __func__"
which makes the lines wrap nicer, and some of them end up not wrapped
at all.  MinGW has nothing to complain either.

Your patch has been applied to the master branch.

commit f134eeb9c09a124127f64d64191e16a9ed7e105d
Author: Frank Lichtenheld
Date:   Tue Mar 18 18:39:06 2025 +0100

     openvpnserv: Clean up use of TEXT() from DNS patches

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250318173914.24425-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31161.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


