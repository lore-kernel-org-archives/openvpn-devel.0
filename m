Date: Mon, 25 Apr 2022 18:38:16 +0200 (CEST)
Message-Id: <202204251638.23PGcGvU076021@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220422134038.3801239-9-arne@...1227...>
References: <20220422134038.3801239-9-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Split out reliable_ack_parse
 from reliable_ack_read
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

Your patch has been applied to the master branch.

Tested on client and server ("for good measure") even if stare-at-code
suggests it's really the same code, split in half.  The change in
ssl.c is due to "ack->len is now always zeroed".

Uncrustify (0.74.0_f) has opinions on "if ( a && (b || c))" 
constructs, so a bit of whitespace was changed.

Comment in reliable.h adjusted ("compares extracts").

commit ac97e16123aba7d4792ca978a4e2e6875973b8ed
Author: Arne Schwabe
Date:   Fri Apr 22 15:40:37 2022 +0200

     Split out reliable_ack_parse from reliable_ack_read

     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20220422134038.3801239-9-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24145.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


