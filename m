Date: Fri, 3 Mar 2023 17:59:04 +0100 (CET)
Message-Id: <202303031659.323Gx4lK054095@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230214112044.1021962-1-arne@...1227...>
References: <20230214112044.1021962-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Reduce initialisation spam from
 verb <= 3 and print summary instead
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

Acked-by: Gert Doering <gert@...1296...>

This is a useful change.

I have stared a bit at the code, and it does what it wants to achieve.

I do not exactly like the "add_delim_if_non_empty()" approach, but this
seems to be an ever-recurring topic ("how to build a string with lots
of optional parts and delimiters in between") which is ugly even in
language with good string support...

Not sure why the patch moves cc_exit_notify_enabled() to occ.h, as it's
still only called from sig.c - but "static inline in .h" is our usual
convention.

I have very unscientifically connected to a few destinations with
verb 3 / verb 4 and compared the results (yep, nice, and all the details
are still there if you really want them) and pushed to GH and buildbot for
"will it break $randomthing?".  Does not break any compile variants.

Your patch has been applied to the master and release/2.6 branch.

commit c333a0c05f9d454efb38fc04c1dca1413bfc48ff (master)
commit 7538557108f6add04f835eb161cb0a33610c6b14 (release/2.6)
Author: Arne Schwabe
Date:   Tue Feb 14 12:20:44 2023 +0100

     Reduce initialisation spam from verb <= 3 and print summary instead

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230214112044.1021962-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26249.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


