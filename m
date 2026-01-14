Date: Wed, 14 Jan 2026 12:51:07 +0100 (CET)
Message-Id: <202601141151.60EBp7Nj029516@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260114112403.7046-1-gert@...1296...>
References: <20260114112403.7046-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Repair interaction between DCO
 and persist-tun after reconnection
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This was quite a hunt... for an "it looks trivial" 1-liner ;-)

Your patch has been applied to the master and release/2.6 branch (bugfix)
(slight massaging needed because someone has renamed "socket" to
"out_socket", so the check going away looks different - but did the
same thing, and had the same bug.  Unsurprising, as this was day#1 DCO
code from before 2.6.0...)

Note that this commit does not close the GH issue yet - the original
"why does it crash on me?" bug has been fixed, but the resulting code
is still not appealing to my sensitivities.

Note2: this does not apply to Windows, because win-dco signals things
differently ("we get timeout notification from driver via error on 
pending read request").

commit 52c3b435b11e6daf7f3f9524ff801ba285c1d985 (master)
commit fae4a9e3f51554bdecc9df45344135006da1f0d9 (release/2.6)
Author: Gert Doering
Date:   Wed Jan 14 12:23:49 2026 +0100

     Repair interaction between DCO and persist-tun after reconnection

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <antonio@...2726...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1473
     Message-Id: <20260114112403.7046-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35239.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


