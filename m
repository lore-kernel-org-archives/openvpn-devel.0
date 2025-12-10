Date: Wed, 10 Dec 2025 12:44:04 +0100 (CET)
Message-Id: <202512101144.5BABi4oa013014@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <CAM8w-qEE6vHj=yUOpTFbM7DqPKzUV0NupvEG4rUefY=kNB2DxQ@...278...>
References: <CAM8w-qEE6vHj=yUOpTFbM7DqPKzUV0NupvEG4rUefY=kNB2DxQ@...278...>
Subject: [Openvpn-devel] [PATCH applied] Re: PUSH_UPDATE: fix option reset
 logic in continuation messages
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
To: Moritz Fain <moritz-openvpn@...2969...>
Cc: openvpn-devel@lists.sourceforge.net

So, after a bit of work, this is now in - always remember to use 
"git send-email" to send patches to the list (or use gerrit), as normal
e-mail clients tend to line-wrap things.  So about 30 lines in the patch
were wrapped, needing manual repair...

I have not explicitly tested this with a long server-triggered PUSH_UPDATE
command ("no infrastructure yet"), but it does pass the unit test - thanks
for that addition - and the explanation & code make sense (arguably the
change to update_option() is not really necessary - one could just pass
in a pointer to o->push_update_options_found - but given that this is
not code where "keep branches similar" is relevant it does not make
a big difference either way).

Also, Marco has ACKed this (twice *cough*), and it's his code ;-)

Your patch has been applied to the master branch.

commit 309c2332c353e741d0b696112891cbe0a8e4080f
Author: Moritz Fain
Date:   Mon Dec 1 15:04:18 2025 +0100

     PUSH_UPDATE: fix option reset logic in continuation messages

     Acked-by: Marco Baffo <marco@...2726...>
     Message-Id: <CAM8w-qEE6vHj=yUOpTFbM7DqPKzUV0NupvEG4rUefY=kNB2DxQ@...278...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34814.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


