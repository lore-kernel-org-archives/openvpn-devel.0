Date: Thu, 28 Feb 2019 16:07:53 +0100 (CET)
Message-Id: <201902281507.x1SF7rhL041239@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190224181400.42524-1-simon@...2293...>
References: <20190224181400.42524-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add NULL checks
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
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel@lists.sourceforge.net

(Re-send with proper references - my mailer and my git tools hate 
each other today)

Acked-by: Gert Doering <gert@...1296...>

Thanks :-)  (not only NULL checks, but calloc() as well!)

Test built on ubuntu1604/mingw.

Your patch has been applied to the master branch.

commit fbb5d6c56b5586ffd3731fc76e706131b635be58
Author: Simon Rozman
Date:   Sun Feb 24 19:14:00 2019 +0100

     Add NULL checks

     Signed-off-by: Simon Rozman <simon@...2293...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20190224181400.42524-1-simon@...2293...
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18231.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


