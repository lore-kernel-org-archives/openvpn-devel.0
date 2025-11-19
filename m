Date: Wed, 19 Nov 2025 17:48:24 +0100 (CET)
Message-Id: <202511191648.5AJGmOXv006903@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251119140149.31867-1-gert@...1296...>
References: <20251119140149.31867-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add option to check
 tls-crypt-v2 key timestamps
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
To: Max Fillinger <max@...2606...>
Cc: openvpn-devel@lists.sourceforge.net

I have not really reviewed this, just run a few tests on the tls-crypt-v2
server side testbed (which has a verify script, but no timestamps), and
it passes.  Memory and integer arithmetics look reasonable, the compilers
to not complain (-Wconversion -Werror).

Your patch has been applied to the master branch.

commit 20b234b23d483cecfb5dec07ae5f9d8b393847a7
Author: Max Fillinger
Date:   Wed Nov 19 15:01:43 2025 +0100

     Add option to check tls-crypt-v2 key timestamps

     Signed-off-by: Max Fillinger <max@...2606...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1304
     Message-Id: <20251119140149.31867-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34545.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


