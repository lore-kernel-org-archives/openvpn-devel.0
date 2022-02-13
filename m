Date: Sun, 13 Feb 2022 11:36:58 +0100 (CET)
Message-Id: <202202131036.21DAawgd047309@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220210162632.3309974-5-arne@...1227...>
References: <20220210162632.3309974-5-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use new frame header methods to
 calculate OCC_MTU_LOAD payload size
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

.. though I'm not sure I understand any of this code, or how to trigger
it.  So I've only run client/server tests, and stared at the code changes
for a bit.

I think it actually breaks the original intent, as the "changes per
iteration" variable "entry->delta" is gone now - so this is a semi-NAK,
as in "we need to come back here and fix this".  But I want to move
forward with the frame stuff, and 7/8 can not go in without this.

Can anyone tell me how to actually trigger an "OCC MTU test"?  --mtu-disc 
is doing socket level stuff ("only supported on OSes ... necessary system
call") - so maybe this was broken / inactive already before...

Your patch has been applied to the master branch.

commit fb76954a232decc86e071a76861c1e4fdd2507ab
Author: Arne Schwabe
Date:   Thu Feb 10 17:26:29 2022 +0100

     Use new frame header methods to calculate OCC_MTU_LOAD payload size

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220210162632.3309974-5-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23750.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


