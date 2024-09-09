Date: Mon, 9 Sep 2024 08:04:15 +0200 (CEST)
Message-Id: <202409090604.48964Fik040098@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240906103900.37037-1-frank@...2641...>
References: <20240906103900.37037-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add a test for loading
 certificate and key using file: URI
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Again, an easy-to-test one :-) - only unit tests, and those pass on
various OpenSSL and mbedTLS versions ("SKIPPED"), including the GHA
windows unit tests.

Your patch has been applied to the master branch.

commit f086a49b5511adcd5ad0835f7cbac7d403dbf4af
Author: Selva Nair
Date:   Fri Sep 6 12:39:00 2024 +0200

     Add a test for loading certificate and key using file: URI

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240906103900.37037-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29076.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


