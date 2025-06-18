Date: Wed, 18 Jun 2025 15:00:57 +0200 (CEST)
Message-Id: <202506181300.55ID0vc7097349@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250618124835.24737-1-gert@...1296...>
References: <20250618124835.24737-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dns: deal with --dhcp-options
 when --dns is active
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

So - finally the Grand DNS Rewrite is reaching the final commits - thanks
Heiko for all the work.

This patch brings working --dns-updown for configs where the server still
pushes "dhcp-options DNS" - and vice versa, compat "foreign_option..."
settings in --up for configs where the server pushes "--dns ..."

Windows will see DNS via iservice "but not if TAP + DHCP is active"
(compat again).

Lev has tested the various windows variants, I have tested all the
"incoming" variants (reference server can push this or that, depending
on client requests) and verified that --dns-updown applies whatever
makes sense, and alternatively "--up printenv.sh" will show the correct
DNS options.

There might be bugs lurking, but overall this does what it aims for, and
the code looks good (I stared at it quite a bit over the last months ;-) ).

NOTE: Android has not explicitely been tested, but given that it shares
the "tuntap" option handling with Windows, I expect nothing to break there.

Your patch has been applied to the master branch.

commit 2dfc4f82792b197dfa47d2bfe32c2af66b329611
Author: Heiko Hund
Date:   Wed Jun 18 14:48:29 2025 +0200

     dns: deal with --dhcp-options when --dns is active

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250618124835.24737-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31922.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


