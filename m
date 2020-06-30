Date: Tue, 30 Jun 2020 09:33:05 +0200 (CEST)
Message-Id: <202006300733.05U7X5FT006828@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200629190930.1360-2-cschenk@...2502...>
References: <20200629190930.1360-2-cschenk@...2502...>
Subject: [Openvpn-devel] [PATCH applied] Re: Log a note if someone wants to
 set a MTU below 1280 on IPv6
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
To: Christopher Schenk <cschenk@...2502...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Stared-at-code, looks good. Test build on ubuntu/mingw, passes.

I have not actually tested that it prints the warnings when expected, 
but the code looks good and the change is simple enough :-)

Your patch has been applied to the master branch.

commit 93439307e597007e0d60b904c0f3d9d85de26b49
Author: Christopher Schenk
Date:   Mon Jun 29 21:09:30 2020 +0200

     Log a note if someone wants to set a MTU below 1280 on IPv6

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200629190930.1360-2-cschenk@...2502...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20161.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


