Date: Tue, 3 Jun 2025 16:18:48 +0200 (CEST)
Message-Id: <202506031418.553EImvt021543@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250603140631.11696-1-gert@...1296...>
References: <20250603140631.11696-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: mbedtls: Allow TLS 1.3 if
 available
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

A twisty nightmare of passages, all alike...  (but ignoring the eye sore,
these particular #ifdef are not actually that complex, well described,
and well contained).

I have removed my Acked-By: from the commit - this was more a gerrit
artefact due to -1'ing and then +2'ing the patch again.  Frank and the BBs
tested it ;-)

Your patch has been applied to the master branch.

commit abed088c9bf3d6ab479dbe815d4d307b21b816b6
Author: Max Fillinger
Date:   Tue Jun 3 16:06:24 2025 +0200

     mbedtls: Allow TLS 1.3 if available

     Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20250603140631.11696-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31858.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


