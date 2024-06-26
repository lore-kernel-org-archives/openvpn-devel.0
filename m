Date: Wed, 26 Jun 2024 11:18:03 +0200 (CEST)
Message-Id: <202406260918.45Q9I3TG008514@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240623200551.20092-1-gert@...1296...>
References: <20240623200551.20092-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Http-proxy: fix bug preventing
 proxy credentials caching
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
To: Gianmarco De Gregori <gianmarco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

The original ACK came from Frank, I'm just ACKing the change v8 -> v10
(rebased, and add (void) to function declaration / prototypes where missing).

I do not have a test setup to properly test this right now - I do have
proxies, but they do not need auth, and especially the "cache on reconnect"
needs a different client-side driving framework to verify client behaviour
(volunteers for a t_client.sh-alike using the management interface?).  But
I am told that Frank and Gianmarco have tested this very extensively, and
it does not break any of the things I *can* test (basic auth-user-pass and
token).  So in it goes :-)

Your patch has been applied to the master and release/2.6 branch (bugfix).

commit 3cfd6f961d5c92bec283ac3616e1633b4e16760c (master)
commit ad0c2c078ea505436b19255ebfbc8365044c5953 (release/2.6)
Author: Gianmarco De Gregori
Date:   Sun Jun 23 22:05:51 2024 +0200

     Http-proxy: fix bug preventing proxy credentials caching

     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240623200551.20092-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28835.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


