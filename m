Date: Tue, 21 Jul 2020 21:41:30 +0200 (CEST)
Message-Id: <202007211941.06LJfU2T065828@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200721100128.9850-1-arne@...1227...>
References: <20200721100128.9850-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove key-method 1
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

I have run a t_client test on FreeBSD/OpenSSL and Linux/mbedTLS, and
a full server side test.  Just to be sure.  This is surprisingly large 
changes in crypto code...  the changes look good, but...!

All tests pass :-)

Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2d 2e 3 4 5 5a 5b 5c 5v1 5v2 5v3 5w1 5w2 5w3 5w4 5x1 5x2 5x3 5x4 6 7 7x 8 8a 9 2f 4b.
Test sets failed: none.


I have ignored that hunk from the patch:

@@ -2312,7 +2246,7 @@ push_peer_info(struct buffer *buf, struct tls_session  
+*session)
          * push request, also signal that the client wants
          * to get push-reply messages without without requiring a round
          * trip for a push request message*/
-        if(session->opt->pull)
+        if (session->opt->pull)
         {
             iv_proto |= IV_PROTO_REQUEST_PUSH;
         }

because it fixes whitespace in code that is not there yet - so I'll
fix the whitespace on the fly when applying *that* patch (if we're
not at v8 by then, with the whitespace fix included).

commit 36bef1b52b49ebbc3790635be230e2f30f0532a7
Author: Arne Schwabe
Date:   Tue Jul 21 12:01:28 2020 +0200

     Remove key-method 1

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20200721100128.9850-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20516.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


