Date: Sun, 16 Nov 2025 22:58:20 +0100 (CET)
Message-Id: <202511162158.5AGLwKpK057652@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251116183336.11447-1-gert@...1296...>
References: <20251116183336.11447-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl: Fix conversion warning in
 tls_prepend_opcode_v1
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

Change makes sense.  Arne has also reviewed this, and v3/v4 take the
initial comments into account.  Smoke tested on Linux / t_client
(though I'm not sure we have tests that excercise opcode_v1).

Your patch has been applied to the master branch.

commit d926257bf4636ea43f6f5c25f5235baa25f65203
Author: Frank Lichtenheld
Date:   Sun Nov 16 19:33:30 2025 +0100

     ssl: Fix conversion warning in tls_prepend_opcode_v1

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1298
     Message-Id: <20251116183336.11447-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34480.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


