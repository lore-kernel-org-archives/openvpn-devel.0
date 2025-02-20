Date: Thu, 20 Feb 2025 09:04:10 +0100 (CET)
Message-Id: <202502200804.51K84AxT098569@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250220074327.24922-1-gert@...1296...>
References: <20250220074327.24922-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-win: simplify control
 packets prepend code
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

Straightforward, so I have not actually tested the resulting openvpn.exe
- but stared very hard at the change & asked MinGW for an opinion (no
errors or warnings).

Fixed one whitespace gotcha on the fly.

Your patch has been applied to the master branch.

commit a8e67c7d0642f6b7e12ffc98af8495e66664d895
Author: Lev Stipakov
Date:   Thu Feb 20 08:43:27 2025 +0100

     dco-win: simplify control packets prepend code

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250220074327.24922-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30942.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


