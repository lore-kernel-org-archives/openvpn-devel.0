Date: Sat, 9 Nov 2019 16:25:53 +0100 (CET)
Message-Id: <201911091525.xA9FPrNX082306@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1573148729-27339-4-git-send-email-lstipakov@...277...>
References: <1573148729-27339-4-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: wintun: implement opening
 wintun device
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

Your patch has been applied to the master branch.

Since this introduces a new library requirement, I gave it a test run 
on my Ubuntu 16 / MinGW linux build system.  "Builds fine".  Have not run
the result.

I have not done anything resembling proper code review.  Just basic 
"this is only changing _WIN32 code, and doesn't seem to do bad stuff 
with pointers".

What I do not really like is the inflation of the code with 

	if (!tt->wintun)

statements now.  I think this should be refactored out into an
"open_tun_wintun()" and an "open_tun_tap_windows()" function, where
all the bits that are now inside an "if (!tt->wintun)" get their
own function with less if() and less nesting.


commit e64b4a9e68bde3cb7d878d277878fb2805040e3e
Author: Lev Stipakov
Date:   Thu Nov 7 19:45:25 2019 +0200

     wintun: implement opening wintun device

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Simon Rozman <simon@...2293...>
     Message-Id: <1573148729-27339-4-git-send-email-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19029.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


