Date: Fri, 18 Jul 2025 21:21:25 +0200 (CEST)
Message-Id: <202507181921.56IJLP2B022789@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250718191702.9451-1-gert@...1296...>
References: <20250718191702.9451-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: improve float collision logging
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

Just a small commit but would have saved us a few hours staring at logs
today - due to a different bug, the floating code would try to "float to
itself", find "that ip+port is already in use", kill 'that' instance
(itself), and then crash on "where did my instance go?"...  and we just
got an ominous "closing instance" with no reason.

Verified that triggering the (already fixed) bug with the new message
would produce a nicer and more helpful message.  Good :-)

Your patch has been applied to the master branch.

commit 495e02e675a1c64ac902428ac82f6b1bfd35ed25
Author: Ralf Lici
Date:   Fri Jul 18 21:16:56 2025 +0200

     improve float collision logging

     Signed-off-by: Ralf Lici <ralf@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250718191702.9451-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32226.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


