Date: Thu, 3 Feb 2022 11:31:35 +0100 (CET)
Message-Id: <202202031031.213AVZuJ057025@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220127001410.7587-1-selva.nair@...277...>
References: <20220127001410.7587-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: pkcs11_openssl.c: check
 EVP_get_digestbyname() != NULL
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

Have not tested, but looks reasonable.

Your patch has been applied to the master branch.

commit fb60a5a9d0da982df0edeac8287aa5ee55f4e79a
Author: Selva Nair
Date:   Wed Jan 26 19:14:10 2022 -0500

     pkcs11_openssl.c: check EVP_get_digestbyname() != NULL

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20220127001410.7587-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23680.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


