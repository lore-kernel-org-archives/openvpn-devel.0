Date: Tue, 7 Sep 2021 18:00:14 +0200 (CEST)
Message-Id: <202109071600.187G0EEQ078262@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210818213354.687736-2-arne@...1227...>
References: <20210818213354.687736-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Include Chacha20-Poly1305 into
 default --data-ciphers when available
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

I have not tested this "in-depth", but the code looks good, and the result
passes my t_client rig with various OpenSSL and mbedTLS versions.

(I have not actually tested "both server and client have CHACHA-POLY
active and using that works" but I trust Antonio there :-) )

Your patch has been applied to the master branch.

commit a38a377fd524d0e14a23ed17487ea3e3d3ad3fe7
Author: Arne Schwabe
Date:   Wed Aug 18 23:33:54 2021 +0200

     Include Chacha20-Poly1305 into default --data-ciphers when available

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210818213354.687736-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22745.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


