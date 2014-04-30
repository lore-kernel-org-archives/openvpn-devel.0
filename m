Date: Wed, 30 Apr 2014 13:21:27 +0200 (CEST)
Message-Id: <201404301121.s3UBLRKU008764@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <535EB49E.5090809@...1856...>
References: <535EB49E.5090809@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Make serial env exporting
	consistent amongst OpenSSL and PolarSSL builds.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.

Patch is slightly bigger than f80a52b09eed8e5e0cad ("the same thing for 
master") as it also backports the renaming of x509_get_serial() to
backend_x509_get_serial() - which is purely cosmetic, but now the code
is better aligned.

Your patch has been applied to the release/2.3 branch.

commit 142d4dd2e98317a03ca9827f03fc4643fe922834 (release/2.3)

Author: Steffan Karger
Date:   Mon Apr 28 21:50:22 2014 +0200

     Make serial env exporting consistent amongst OpenSSL and PolarSSL builds.

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <535EB49E.5090809@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8664
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


