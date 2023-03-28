Date: Tue, 28 Mar 2023 09:25:12 +0200 (CEST)
Message-Id: <202303280725.32S7PC7q076380@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230327171236.51771-1-selva.nair@...277...>
References: <20230327171236.51771-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Bug-fix: segfault in
 dco_get_peer_stats()
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Antonio Quartulli <a@...2181...>

Thanks for the good find.  Since I could reproduce the crash yesterday
(and I do need management for it) I can verify that it does no longer
crash with the patch.

(For whatever reason, --tls-version-max 1.0 did not suffice to trigger
the error this morning, but --tls-version-min 1.3 + management + bytecount
still did)

Your patch has been applied to the master branch.

commit 10c3f25a26bce480f80624c5ef4cb6774a31c305 (master)
commit d01b9d751d6a5b4dc3737b339ec1ca5c23705243 (release/2.6)
Author: Selva Nair
Date:   Mon Mar 27 13:12:36 2023 -0400

     Bug-fix: segfault in dco_get_peer_stats()

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20230327171236.51771-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26530.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


