Date: Sun, 23 Mar 2014 22:27:45 +0100 (CET)
Message-Id: <201403232127.s2NLRjR8028335@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <CAA1AbxJh17KYmVU1BVa5kp4iJsUJT+xnXp0rVU_3g3c5hPnqDQ@...278...>
References: <CAA1AbxJh17KYmVU1BVa5kp4iJsUJT+xnXp0rVU_3g3c5hPnqDQ@...278...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure.ac: check for
	SSL_OP_NO_TICKET flag in OpenSSL
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

Tested on my "normal" OpenSSL installation (OK) and by deliberately removing 
SSL_OP_NO_TICKET from openssl/ssl.h -> correct error message:

..
checking for SSL_OP_NO_TICKET flag in OpenSSL... no
configure: error: OpenVPN 2.4+ requires SSL_OP_NO_TICKET in OpenSSL


Your patch has been applied to the master branch.

commit e9b088b20847905ed2c2b85a12be58f457c10d06
Author: Steffan Karger
Date:   Sun Mar 23 14:07:47 2014 +0100

     configure.ac: check for SSL_OP_NO_TICKET flag in OpenSSL

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <CAA1AbxJh17KYmVU1BVa5kp4iJsUJT+xnXp0rVU_3g3c5hPnqDQ@...278...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8389
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


