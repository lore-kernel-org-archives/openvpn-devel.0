Date: Mon, 10 Aug 2020 14:49:03 +0200 (CEST)
Message-Id: <202008101249.07ACn338012236@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200810090032.4220-1-arne@...1227...>
References: <20200810090032.4220-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Document different behaviour of
 dynamic cipher negotiation
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

Thanks, this is necessary (Changes.rst) and helpful (cipher-negotiation.rst).

I still think we might need a matrix in the wiki (because users of older 
OpenVPN versions might not find the new man page).  But this can be done
independently.

Fixed an extra B, reworded Changes.rst slightly.

Your patch has been applied to the master branch.

commit bf42466dd00c56b8b61f5cd0c7f451882e5bc861
Author: Arne Schwabe
Date:   Mon Aug 10 11:00:32 2020 +0200

     Document different behaviour of dynamic cipher negotiation

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200810090032.4220-1-arne@...1227...>
     URL: doc/man-sections/cipher-negotiation.rst
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


