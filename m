Date: Fri, 9 Feb 2024 17:29:29 +0100 (CET)
Message-Id: <202402091629.419GTTlX031453@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240209111000.16258-1-frank@...2641...>
References: <20240209111000.16258-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Print SSL peer signature
 information in handshake debug details
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

Tested on the OpenBSD buildbot (some earlier LibreSSL version) and GHA
(different OpenSSL versions).  Looks all good.  As expected, LibreSSL builds
do not provide the new information (neither does mbedTLS), but OpenSSL
builds do...

   2024-02-09 17:09:00 Control Channel: TLSv1.2, cipher TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384, peer certificate: 2048 bits RSA, signature: RSA-SHA1, peer temporary key: 256 bits ECprime256v1, peer signing digest/type: SHA512 RSA

Your patch has been applied to the master branch.

commit b431721eb1b676f8e1a1cbcf233507d2dd29f846
Author: Arne Schwabe
Date:   Fri Feb 9 12:10:00 2024 +0100

     Print SSL peer signature information in handshake debug details

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240209111000.16258-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28206.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


