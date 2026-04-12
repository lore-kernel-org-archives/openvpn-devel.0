Date: Sun, 12 Apr 2026 15:46:18 +0200 (CEST)
Message-Id: <202604121346.63CDkIBJ076411@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260313104955.16748-1-frank@...2641...>
References: <20260313104955.16748-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove multi_context->iter
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

This is the beginning of all the good stuff for 2.8 :-)

We have an ACK from Frank.  I have stared-at-code at this for a bit, and
subjected it to the t_server testbed (which can have at least 3 active clients
at one time, so lots of iteration!)...

Tests still pass fine, the code complexity goes down ("walk an array"
is an easy concept, "understand what this hash iteration stuff does" 
not so much.  C is just not the language for this...).

Performance will be even further improved by the next patch in this
series, "remembering highest peer id".

Your patch has been applied to the master branch.

commit 930968086deeeaac6f5717067339537c467c10d0 (master)
Author: Arne Schwabe
Date:   Fri Mar 13 11:49:55 2026 +0100

     Remove multi_context->iter

     Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1556
     Message-Id: <20260313104955.16748-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36087.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


