Date: Mon, 13 Dec 2021 18:40:56 +0100 (CET)
Message-Id: <202112131740.1BDHeuUu080404@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211210130651.3623725-1-arne@...1227...>
References: <20211210130651.3623725-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove cipher_kt_t and change
 type to const char* in API
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

Thanks to Selva for the v2 review, and thanks for the timely v3.

I have tested this more thoroughly this time...

 - Linux, mbedTLS 2.27.0   (light client side tests, full server side tests)
   [LOTSA FAIL!]
 - Linux, OpenSSL 1.1.1l   (full client + server side tests)  XXX
 - Linux, OpenSSL 3.0.0    (full client side tests)  XXX
 - FreeBSD, OpenSSL 1.1.1h (fairly thorough client side tests) -> 
	FAIL t_lpback.sh ("Segmentation fault")
 - FreeBSD, mbedTLS 2.26.0 (fairly thorough client side tests) -> 
	FAIL t_lpback.sh ("Segmentation fault")

and everything went well.  Plus, stare-at code, which also looks good
(Selva's points addressed).

I have not fixed the "TYPE* x" vs. "TYPE *x" this round, as it will
lead to extra rounds of conflicts with the later patchsets.  We have
agreed on IRC to do an uncrustify run when the "frame" (/21) set is in.

Your patch has been applied to the master branch.

commit 39058d50a9d6e534bd67f845035bb7ee452f073c
Author: Arne Schwabe
Date:   Fri Dec 10 14:06:51 2021 +0100

     Remove cipher_kt_t and change type to const char* in API

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211210130651.3623725-1-arne@...1227...>
     URL: https://www.mail-archive.com/search?l=mid&q=20211210130651.3623725-1-arne@...1227...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


