Date: Wed, 4 Dec 2019 17:00:52 +0100 (CET)
Message-Id: <201912041600.xB4G0qdW047757@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191204110836.6364-1-arne@...1227...>
References: <20191204110836.6364-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add support for OpenSSL TLS 1.3
 when using management-external-key
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

Your patch has been applied to the master branch.

I have diff'ed v7 and v8 of the patch, and the only difference is
"commit message" and "comments in the code" - as far as I could see
without really checking every single change, all to address Selva's
comments.  Since v7 got an ACK, I'm applying this to v8 ("same code").

thanks, Arne and Selva.

(Lightly tested on FreeBSD and Linux, but that's really mostly compile-test
since I have nothing that uses management-external-key)


commit 8be444df89be09689ba82e58cbc89452a5fcceca
Author: Arne Schwabe
Date:   Wed Dec 4 12:08:36 2019 +0100

     Add support for OpenSSL TLS 1.3 when using management-external-key

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20191204110836.6364-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19219.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


