Date: Wed, 17 Jan 2024 10:37:21 +0100 (CET)
Message-Id: <202401170937.40H9bLV0082556@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240117091711.5366-1-gert@...1296...>
References: <20240117091711.5366-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: NTLM: add length check to
 add_security_buffer
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

Same patch as for master (commit a021de2aa), but 2.6 needs one extra
call due to "NTLMv1 not removed yet".

Your patch has been applied to the release/2.6 branch.

commit 7a9670dfe95da691937c608b2d3a3b939f7a4d45 (release/2.6)
Author: Frank Lichtenheld
Date:   Wed Jan 17 10:17:11 2024 +0100

     NTLM: add length check to add_security_buffer

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240117091711.5366-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28042.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


