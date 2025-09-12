Date: Fri, 12 Sep 2025 19:00:30 +0200 (CEST)
Message-Id: <202509121700.58CH0U7f098700@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250911201222.25382-1-gert@...1296...>
References: <20250911201222.25382-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: add standard mi prefix
 handling to multi_process_incoming_dco()
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
To: Antonio Quartulli <antonio@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

This patch was basically a cooperation between Antonio and me, trying
to figure out how things should be, and then fixing the omissions for
the DCO event handler.  This is what you get when you inherit an old
code base full of magic... :-)

Tested on a FreeBSD+DCO system, with 3 clients renegotiating frequently,
and one of them floating back and forth "right in the middle", and we
think we now got both the mi prefix "for floating" and "afterwards" right.

An intermediate version had msg_get_prefix() / msg_set_prefix() calls
to restore the previous prefix set afterwards, but it turns out that
on intering the event handlers, it's "always NULL", because all other
multi* functions correctly call prefix_reset() at end.

Your patch has been applied to the master and release/2.6 branch (bugfix).

commit 531fef40b73f73632548c88697af34cf15a70531 (master)
commit 520a58d51fc53909d7e05ddf2a2da62eab439be3 (release/2.6)
Author: Antonio Quartulli
Date:   Thu Sep 11 22:12:16 2025 +0200

     dco: add standard mi prefix handling to multi_process_incoming_dco()

     Signed-off-by: Antonio Quartulli <antonio@...2726...>
     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250911201222.25382-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32859.html
     URL: https://gerrit.openvpn.net/c/openvpn/+/1116
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


