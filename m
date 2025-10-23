Date: Thu, 23 Oct 2025 17:50:43 +0200 (CEST)
Message-Id: <202510231550.59NFohPi066723@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251023153514.18691-1-gert@...1296...>
References: <20251023153514.18691-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Do not try to use the
 encrypt-then-mac ciphers from OpenSSL 3.6.0
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

This is basically the same as commit a69d9b665 on master, but due to 
context/formatting changes it did not directly apply and Arne was so
nice and did a 2.6 version.

BB says this is all good, did not wait for GHA results.

Your patch has been applied to the release/2.6 branch (long-term compat).

commit 0848531640f670f7f6bb79833223ac8a05c1b36e
Author: Arne Schwabe
Date:   Thu Oct 23 17:35:08 2025 +0200

     Do not try to use the encrypt-then-mac ciphers from OpenSSL 3.6.0

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1295
     Message-Id: <20251023153514.18691-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33849.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


