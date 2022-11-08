Date: Tue, 8 Nov 2022 17:28:41 +0100 (CET)
Message-Id: <202211081628.2A8GSfDF062235@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220914172527.2661529-1-arne@...1227...>
References: <20220914172527.2661529-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Improve data key id not found
 error message
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

Most of it is actually straightforward (if no workable key is
found, go to the "print fail" function, find the right key slot
*again*, print "not initialized" or "not authorized" according
to ks->state / ks->authenticated - and if nothing matches, print
the existing "generic out of sync" message.

We still don't know how to trigger this on-demand, but even so it
won't do harm, and cleans up handle_data_channel_packet() a bit.

What I do not like so much is the extra gc + 3 gc_free() calls
(while the caller has its own gc + gc_free() right after calling
print_key_id_not_found_reason()...) - but then, gc is "something
local", so be it...  and for some reason the existing gc_free()
gets moved around - that looks a bit spurious (but harmless).

I fed this to the client/server test bed, to see if I could
trigger something (or it would *break* something) - didn't break
anything, but didn't trigger key messages either...

Your patch has been applied to the master branch.

commit 616a143552143a8c0a3b727362cc3931541ca785
Author: Arne Schwabe
Date:   Wed Sep 14 19:25:27 2022 +0200

     Improve data key id not found error message

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220914172527.2661529-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25212.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


