Date: Thu, 15 May 2025 17:12:37 +0200 (CEST)
Message-Id: <202505151512.54FFCbP1096181@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250515150038.30097-1-gert@...1296...>
References: <20250515150038.30097-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement ovpn version detection
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
To: Ralf Lici <ralf@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Tested various complications - no module available, module without
"local" version number available (= built-in, in the future), and
new "backport" module.  Does what it says on the lid.

Your patch has been applied to the master branch.

commit f6c95ac2ffa69a1caaf2785859c48295a3bea199
Author: Ralf Lici
Date:   Thu May 15 17:00:31 2025 +0200

     Implement ovpn version detection

     Signed-off-by: Ralf Lici <ralf@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250515150038.30097-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31652.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


