Date: Wed, 17 Jan 2024 10:24:48 +0100 (CET)
Message-Id: <202401170924.40H9OmfX082042@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240117085951.27414-1-gert@...1296...>
References: <20240117085951.27414-1-gert@...1296...>
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

This extra check makes sense, the code is not very robust here - maybe
the wording of the message could be made more understandable (what does
"security buffer too big for message buffer" mean?) but at least we
have a check + message now.

I have not tested this for real as I do not have a working NTLM setup,
but Frank has, and the code does not affect anything "not NTLM".

Your patch has been applied to the master branch.

The *check* needs to go into release/2.6 as well, but since the code is
different (due to NTLMv1 removal) there is one extra add_security_buffer()
to be handled by the 2.6 patch (gerrit/493).  Coming next :-)

commit a021de2aabb21a24c7b69aaae1c710a9b6fee429 (master)
Author: Frank Lichtenheld
Date:   Wed Jan 17 09:59:51 2024 +0100

     NTLM: add length check to add_security_buffer

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240117085951.27414-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28037.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


