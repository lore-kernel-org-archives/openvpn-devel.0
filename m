Date: Mon, 30 Mar 2026 13:28:09 +0200 (CEST)
Message-Id: <202603301128.62UBS9hb035860@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260316134841.28362-1-gert@...1296...>
References: <20260316134841.28362-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: socket: restore per-connection
 lport override over global default
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
To: Gianmarco De Gregori <gianmarco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for the fix.

The change passes all BB and t_server tests, though this is mostly 
meaningless here - no <connection> blocks are excercised.  So I ran
this with a quick local config setup, with a global --lport and 
two <connection> profiles, one of them with a local --lport, verifying
that it indeed is honoured.

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 7ac5f89023b2c2870a210016a862ec042f709bb7 (master)
commit b5039975bf629d33fbff0b0feae6d072378e7edc (release/2.7)
Author: Gianmarco De Gregori
Date:   Mon Mar 16 14:48:36 2026 +0100

     socket: restore per-connection lport override over global default

     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Antonio Quartulli <antonio@...2726...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1555
     Message-Id: <20260316134841.28362-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36164.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


