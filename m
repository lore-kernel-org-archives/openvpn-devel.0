Date: Fri, 27 Dec 2024 18:29:49 +0100 (CET)
Message-Id: <202412271729.4BRHTnpn023855@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241227111133.5893-1-gert@...1296...>
References: <20241227111133.5893-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Change API of init_key_ctx to
 use struct key_parameters
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

I'm not sure I understand all the intricacies here (like,
"cipher_size = MAX_CIPHER_KEY_LENGTH", what's that for?), but it passes
all the client/server test, memory operations look safe, and it has a
unit test and a +2 from Frank :-)

Your patch has been applied to the master branch.

commit 5bbf0aa484470486fcc2f491fba81605aa8649ed
Author: Arne Schwabe
Date:   Fri Dec 27 12:11:33 2024 +0100

     Change API of init_key_ctx to use struct key_parameters

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20241227111133.5893-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30228.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


