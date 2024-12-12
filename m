Date: Thu, 12 Dec 2024 16:26:25 +0100 (CET)
Message-Id: <202412121526.4BCFQPEe025843@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241212143845.4090-1-gert@...1296...>
References: <20241212143845.4090-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use XOR instead of
 concatenation for calculation of IV from implicit IV
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

This might be the patch with the larges amount of ACKs and confusion
in Gerrit :-) - we do have lots of +2 and then gerrit forgot some on
pushing a new version, and I complained about ASSERT()... but in the
end, the crypto bits have been thoroughly reviewed by MaxF, Steffan
and Antonio, and I have complained sufficiently about the memcpy()
and ASSERT() parts for v10...

v8 (which is identical except for the ASSERT()) has been through 
full client/server interop testing, so I did only basic testing on v10.

Your patch has been applied to the master branch.

commit baa9192851006e2dbb90b410011e61ecf2e01870
Author: Arne Schwabe
Date:   Thu Dec 12 15:38:45 2024 +0100

     Use XOR instead of concatenation for calculation of IV from implicit IV

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: MaxF <max@...2606...>
     Acked-by: Antonio Quartulli <antonio@...2726...>
     Acked-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20241212143845.4090-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30097.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


