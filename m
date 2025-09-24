Date: Wed, 24 Sep 2025 09:41:59 +0200 (CEST)
Message-Id: <202509240741.58O7fxXB052953@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250923160459.32273-1-gert@...1296...>
References: <20250923160459.32273-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: multi_io_init: simplify
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

A particular way to do extra-complicated nothing really...  I have stared
at the code for a bit, the flow of "t->options.max_clients" into
"m->max_clients" (assigned exactly once), etc. - and also compared the
logging before/after.

old: MULTI IO: MULTI_IO INIT maxclients=1024 maxevents=1029

new: MULTI IO: MULTI_IO INIT maxclients=1024 maxevents=1029

same numbers ;-)


Your patch has been applied to the master branch.

commit 945db23ef49c3e8c36c6bef8857058544caa77f6
Author: Frank Lichtenheld
Date:   Tue Sep 23 18:04:53 2025 +0200

     multi_io_init: simplify

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1209
     Message-Id: <20250923160459.32273-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33176.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


