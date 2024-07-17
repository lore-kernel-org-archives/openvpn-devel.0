Date: Wed, 17 Jul 2024 22:01:04 +0200 (CEST)
Message-Id: <202407172001.46HK14PV089240@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240711113022.52076-1-frank@...2641...>
References: <20240711113022.52076-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Allow trailing \r and \n in
 control channel message
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

Thanks for the backport.  Verified that it's the same change (without the
unit test, and having extract_command_buffer() in forward.c), and that
it gets the job done :-)

Your patch has been applied to the release/2.5 branch.

commit dddb87f126a6e87e61de830a9efe0bc257a71e2b (release/2.5)
Author: Arne Schwabe
Date:   Thu Jul 11 13:30:22 2024 +0200

     Allow trailing \r and \n in control channel message

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240711113022.52076-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28923.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


