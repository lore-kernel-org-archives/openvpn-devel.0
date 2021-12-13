Date: Mon, 13 Dec 2021 22:01:20 +0100 (CET)
Message-Id: <202112132101.1BDL1KIw089158@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211213150654.3993358-2-arne@...1227...>
References: <20211213150654.3993358-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove md_kt_t and change
 crypto API to use const char*
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

Acked-by: Gert Doering <gert@...1296...>

Exhaustive client- and server-side tests with OpenSSL 1.1.1, 3.0.0
and mbedTLS, on Linux and FreeBSD - nothing to complain about.

Stare-at-code brought up the question on whether

+static inline bool md_defined(const char* mdname)
+{
+    return strcmp(mdname, "none") != 0;
+}

should have a check for "mdname != NULL" - either ASSERT() or
"return mdname != NULL && strcmp(mdname, "none") != 0" style.

Since this works as is, I think, this can go to the followup patch
cleaning up my complaints about 7/9 v4 :-)


Your patch has been applied to the master branch.

commit b39725cf811cbe9334355d4c90990047494a6cc2
Author: Arne Schwabe
Date:   Mon Dec 13 16:06:54 2021 +0100

     Remove md_kt_t and change cyrpto API to use const char*

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211213150654.3993358-2-arne@...1227...>
     URL: https://www.mail-archive.com/search?l=mid&q=20211213150654.3993358-2-arne@...1227...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


