Date: Sat, 25 Jan 2025 11:17:01 +0100 (CET)
Message-Id: <202501251017.50PAH1T3062172@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250125100838.20796-1-gert@...1296...>
References: <20250125100838.20796-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re:
 tls_crypt_v2_write_client_key_file: Fix missing-field-initializers compiler
 warning
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Not sure why the compiler is more picky here than on other inits, but
maybe it's "... = {2}" vs "... = {0}" (which means "all is 0", so the
actual element first in the struct does not matter).  Anyway, ".n = 2"
is what we want so there is no harm in writing that done :-) - and
the buildbots agree that all platform compilers are fine with it.

Your patch has been applied to the master branch.

commit 2a50daf5fe6c924c8d945b3d0455c9e282cd769f
Author: Frank Lichtenheld
Date:   Sat Jan 25 11:08:38 2025 +0100

     tls_crypt_v2_write_client_key_file: Fix missing-field-initializers compiler warning

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250125100838.20796-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30588.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


