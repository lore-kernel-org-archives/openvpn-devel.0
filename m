Date: Tue, 3 Jun 2025 16:14:31 +0200 (CEST)
Message-Id: <202506031414.553EEVwD021261@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250603140414.10970-1-gert@...1296...>
References: <20250603140414.10970-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use
 mbedtls_ssl_export_keying_material()
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

I could not test this myself, and neither did the buildbots (as far as
I know) because we all have older mbedTLS versions - so the patch does
not break anything there, at least :-)

Arne has tested this with an mbedTLS development build, and it works
as it says on the lid - the new function is used, the API is called
correctly, things work.

Your patch has been applied to the master branch.

commit 4c2022ab9044d4449d2f6480fcf845461f02c114
Author: Max Fillinger
Date:   Tue Jun 3 16:01:01 2025 +0200

     Use mbedtls_ssl_export_keying_material()

     Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20250603140414.10970-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31856.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


