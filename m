Date: Wed, 1 May 2024 18:37:18 +0200 (CEST)
Message-Id: <202405011637.441GbIND048303@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240501121819.12805-1-gert@...1296...>
References: <20240501121819.12805-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add missing EVP_KDF_CTX_free in
 ssl_tls1_PRF
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

Mildly tested (GHA and local t_client tests which *should* excercise this
code path with the libraries + peers involved).

Your patch has been applied to the master branch.

Not applied to release/2.6 as the code lacking this free() is master-only.

commit d4eb413181d1c414b854d0829f00cda5ad1e293d (master)
Author: Arne Schwabe
Date:   Wed May 1 14:18:19 2024 +0200

     Add missing EVP_KDF_CTX_free in ssl_tls1_PRF

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240501121819.12805-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28591.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


