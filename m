Date: Sun, 24 Apr 2022 20:10:59 +0200 (CEST)
Message-Id: <202204241810.23OIAxIo037776@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220422134038.3801239-2-arne@...1227...>
References: <20220422134038.3801239-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove
 tls_init_control_channel_frame_parameters wrapper function
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

Easy enough, though this wrapper actually does more than usual
("turning around the argument and only passing on tas->frame").

One typo in ssl.h comment fixed.

Besides the text in the commit message, this patch also removes a 
pre-function comment that was leftover from the dark ages, and did not
have any relation to the following function...

I've left the spurious blank line removal in, to avoid later conflicts.

Your patch has been applied to the master branch.

commit 5e9fea71182137018a9f50b1ee8449b8d83ddc25
Author: Arne Schwabe
Date:   Fri Apr 22 15:40:30 2022 +0200

     Remove tls_init_control_channel_frame_parameters wrapper function

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220422134038.3801239-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24172.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


