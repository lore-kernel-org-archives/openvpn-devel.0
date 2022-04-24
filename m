Date: Sun, 24 Apr 2022 22:41:04 +0200 (CEST)
Message-Id: <202204242041.23OKf4D3040322@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220422134038.3801239-5-arne@...1227...>
References: <20220422134038.3801239-5-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add documentation for swap_hmac
 function
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

I have taken the hunks from 05/28 that relate to swap_hmac (change
the comment, add byte sizes to the "osid_size" comment) into this
one, so this one is now factually correct, and 05(bis)/28 does no longer
contain "swap_hmac" related changes.

As this brings no code change, I've just verified that the comment
matches my understanding of the function (it now does), not tested
anything.

Your patch has been applied to the master branch.

commit e061ec5800af746cb86ccbb9b571e1cb18f8ad99
Author: Arne Schwabe
Date:   Fri Apr 22 15:40:33 2022 +0200

     Add documentation for swap_hmac function

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220422134038.3801239-5-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24177.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


