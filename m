Date: Tue, 27 May 2025 18:43:38 +0200 (CEST)
Message-Id: <202505271643.54RGhcWL082366@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250527160356.10871-1-gert@...1296...>
References: <20250527160356.10871-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove
 HAVE_EXPORT_KEYING_MATERIAL macro
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
To: Max Fillinger <maximilian.fillinger@...2507...>
Cc: openvpn-devel@lists.sourceforge.net

"because it makes sense" - BB and GHA say that this build fine on
everything *but* Debian 11 with the stock mbedTLS package - and we made
a conscious decision to accept that fallout.  *If* someone needs this
particular combination (openvpn 2.7 and mbedtls on debian 11), they
need to build a newer mbedTLS version from source.

Less #ifdef really help make our code better.

The patch itself is fairly trivial (v2 had "fight with uncrustify" fallout),
removing the logic from cmake and autoconf, and removing #ifdefs galore.

Your patch has been applied to the master branch.

commit baa5b70d4150717ab35ef341198189918362066b
Author: Max Fillinger
Date:   Tue May 27 18:03:50 2025 +0200

     Remove HAVE_EXPORT_KEYING_MATERIAL macro

     Signed-off-by: MaxF <max@...2606...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20250527160356.10871-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31799.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


