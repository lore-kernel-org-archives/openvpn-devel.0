Date: Mon, 14 Jul 2025 11:21:35 +0200 (CEST)
Message-Id: <202507140921.56E9LZ1U032354@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250711100405.240625-1-frank@...2641...>
References: <20250711100405.240625-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix compiler warning in
 reliable.c with --disable-debug
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

Interesting trick :-)

Looking forward to see the first patch come in to remove this "totally
useless line" again.  But that's what "git blame" is for...

Since the buildbots are happy and this line explicitly does nothing
I have not tested this further.

Your patch has been applied to the master branch.

commit fcd8f0f9fccdba02ed643dee5df7422ba36ced12
Author: Frank Lichtenheld
Date:   Fri Jul 11 12:04:05 2025 +0200

     Fix compiler warning in reliable.c with --disable-debug

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20250711100405.240625-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32107.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


