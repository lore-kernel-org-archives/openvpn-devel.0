Date: Thu, 5 May 2022 16:04:59 +0200 (CEST)
Message-Id: <202205051404.245E4x9Z040550@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220504113158.1051861-1-arne@...1227...>
References: <20220504113158.1051861-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix format specifier for
 printing size_t on 32bit size_t platforms
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

%zu is now a first class citizen even in MSVC, so we're safe to use it.  

Says Lev, and The Internet.

https://stackoverflow.com/questions/15610053/correct-printf-format-specifier-for-size-t-zu-or-iu

Only minimally tested ("does it compile on amd64 linux with no warning").

Your patch has been applied to the master branch.

commit 6e375353ed99b794994b809570b217e3e732a44b
Author: Arne Schwabe
Date:   Wed May 4 13:31:58 2022 +0200

     Fix format specifier for printing size_t on 32bit size_t platforms

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220504113158.1051861-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24277.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


