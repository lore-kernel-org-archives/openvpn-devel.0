Date: Wed, 10 Nov 2021 14:47:04 +0100 (CET)
Message-Id: <202111101347.1AADl4hR038291@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211109144811.3426928-1-arne@...1227...>
References: <20211109144811.3426928-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use TYPE_do_all_provided
 function for listing cipher/digest
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

This is "v3 with the SIZE() change", and this change looks good.  Max
has already stated "looks good and works", but wanted the sizeof() 
change which is now in - so taking his pre-review, adding my own testing
(makes the "cipher" part of "make check" finally succeed with 3.0, 
yay :-) )

The "load providers" part is not in, so I couldn't test

  openvpn --provider legacy:default --show-ciphers

yet... will come back.

Your patch has been applied to the master branch.

commit ab3f32b9069c31d1724d906b38549ab683c0d97b
Author: Arne Schwabe
Date:   Tue Nov 9 15:48:11 2021 +0100

     Use TYPE_do_all_provided function for listing cipher/digest

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211109144811.3426928-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23142.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


