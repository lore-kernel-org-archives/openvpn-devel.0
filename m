Date: Sun, 8 Mar 2020 20:55:37 +0100 (CET)
Message-Id: <202003081955.028Jtb7k065172@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200205184922.883-1-simon@...2293...>
References: <20200205184922.883-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: wintun: check for conflicting
 options
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

Your patch has been applied to the master branch.

Indeed, check makes sense :-) - compile tested on Ubuntu 16 / MinGW.

commit 05ce4563fbea51a2653a6aa1ee51154ae6b7c6a0
Author: Simon Rozman
Date:   Wed Feb 5 19:49:22 2020 +0100

     wintun: check for conflicting options

     Signed-off-by: Simon Rozman <simon@...2293...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20200205184922.883-1-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19368.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


