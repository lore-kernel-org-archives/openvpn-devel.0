Date: Tue, 21 Sep 2021 13:25:13 +0200 (CEST)
Message-Id: <202109211125.18LBPDX6021709@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210913192929.26391-1-a@...2181...>
References: <20210913192929.26391-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: set TLS 1.2 as minimum by
 default
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Verified that v2 is indeed the same as v1, without the init options
hunk.  I have stared a the code a bit (looks reasonable) and run the
client side tests (pass).

To test if the compat mode works, I've connected from a client that
was forced with "--tls-version-max 1.0" to be incompatible with TLS 1.2
- connecting to "master with this patch", it fails ("TLS error: 
Unsupported protocol").  Setting "--compat-mode 2.3.0" on the server
makes it negotiate TLS 1.0 -> good, does what it says.

I have adjusted the manpage to document that "1.0" is no longer the
default for --tls-version-min.

Your patch has been applied to the master branch.

commit 968569f83b1561ea4dff5b8b1f0d7768e2a18e69.
Author: Antonio Quartulli
Date:   Mon Sep 13 21:29:29 2021 +0200

     set TLS 1.2 as minimum by default

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210913192929.26391-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22838.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


