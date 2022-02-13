Date: Sun, 13 Feb 2022 14:10:38 +0100 (CET)
Message-Id: <202202131310.21DDAcjG064562@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220210162632.3309974-8-arne@...1227...>
References: <20220210162632.3309974-8-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove frame.extra_frame and
 frame.extra_buffer
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

And this is the final one in the "frame rewrite" series, hooray!
(Well, with the not-yet-sent "documentation cleanup" and "OCC MTU Test" 
fixes pending, but still...)

Stared at the code - lots of changes, but all "remove old cruft" :-) - and
ran client and server tests (all good).  It even passes some of my long
standing "this is broken" test cases now, where P2P-NCP going to non-GCM
ciphers would break full-sized packet, so even better.

It might be worth testing if this now fixes --disable-lzo --disable-lz4
(no COMP at all) for good...  MaxF, you listening? ;-)


For reference, this was 21/21 in v1+v2, and 14/14 in v3, neither of
which got any comments.

Your patch has been applied to the master branch.

commit 75a3e8599d2740704a8b705692a6f28541e8d514
Author: Arne Schwabe
Date:   Thu Feb 10 17:26:32 2022 +0100

     Remove frame.extra_frame and frame.extra_buffer

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220210162632.3309974-8-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23755.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


