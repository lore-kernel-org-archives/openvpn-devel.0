Date: Wed, 4 Mar 2026 17:43:58 +0100 (CET)
Message-Id: <202603041643.624Ghw1w064158@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260304144028.2459-1-gert@...1296...>
References: <20260304144028.2459-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl_openssl: Use correct return
 type for RSA_size
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Trivially correct ;-) - and easier-to-understand logic while at it.

Your patch has been applied to the master branch.

commit 8289589a5afd63def246a5e1e7b87f12c4c2f15a
Author: Frank Lichtenheld
Date:   Wed Mar 4 15:40:21 2026 +0100

     ssl_openssl: Use correct return type for RSA_size

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1493
     Message-Id: <20260304144028.2459-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35890.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


