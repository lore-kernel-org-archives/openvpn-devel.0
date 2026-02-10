Date: Tue, 10 Feb 2026 12:08:53 +0100 (CET)
Message-Id: <202602101108.61AB8rMH027823@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260130071137.14398-1-gert@...1296...>
References: <20260130071137.14398-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Mbed TLS 4: Add more algorithms
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
To: Max Fillinger <maximilian.fillinger@...2918...>
Cc: openvpn-devel@lists.sourceforge.net

Very isolated, only affects mbedTLS 4 builds, and is useful for better
compatibility with existing deployments.  Plus it removes 2 TODO comments.

Your patch has been applied to the master branch.

commit 2183eb5d5437df03f74141f35fd548ae481f6b11
Author: Max Fillinger
Date:   Fri Jan 30 08:11:31 2026 +0100

     Mbed TLS 4: Add more algorithms

     Signed-off-by: Max Fillinger <maximilian.fillinger@...2918...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1500
     Message-Id: <20260130071137.14398-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35507.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


