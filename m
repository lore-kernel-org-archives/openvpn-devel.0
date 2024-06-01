Date: Sat, 1 Jun 2024 22:27:22 +0200 (CEST)
Message-Id: <202406012027.451KRMJs025653@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240408124933.243991-1-frank@...2641...>
References: <20240408124933.243991-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Allow the TLS session to send
 out TLS alerts
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

Took me a bit to find a setup where this made a difference, but with
CA / fingerprint validation errors on the client, I saw

  tlsv1 alert unknown ca

on the server, and with a "tls-version-min/max" mismatch (server requiring
1.1, client capped to 1.0) I saw a proper error on the client

2024-06-01 22:18:57 Received fatal SSL alert: protocol version
2024-06-01 22:18:57 OpenSSL: error:0A00042E:SSL routines::tlsv1 alert protocol version:SSL alert number 70
2024-06-01 22:18:57 TLS_ERROR: BIO read tls_read_plaintext error

.. while "without the patch" (older server) it would just sit there
and timeout, never hearing anything back from the server.  Haven't tried
variants more likely to occur in practice (especially "client cert expired")
but expect this to be a useful addition to troubleshooting.

An older client connecting to a patched server will receive the alerts
perfectly fine (as expected, no code changes in those paths), but obviously
won't send them *out* - even though visible in the client log.

   2024-06-01 22:25:25 Sent fatal SSL alert: unknown CA


For completeness, sent through the server side threadmill (testing
with the full set of 2.2 to master clients), and also through GHA -
all works.  Great :-)

Your patch has been applied to the master branch.

commit fbe3b49b373ea8e81aaa31a383258403a3bfcd07
Author: Arne Schwabe
Date:   Mon Apr 8 14:49:33 2024 +0200

     Allow the TLS session to send out TLS alerts

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240408124933.243991-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28540.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


