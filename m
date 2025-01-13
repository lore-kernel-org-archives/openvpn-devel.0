Date: Mon, 13 Jan 2025 12:43:10 +0100 (CET)
Message-Id: <202501131143.50DBhA3q088178@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250113112226.17728-1-gert@...1296...>
References: <20250113112226.17728-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix 'uninitialized pointer
 read' in openvpn_decrypt_aead
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

"Obviously correct" :-) - not tested further (Coverity found this and
will tell us if it considers the code fixed now).

Note that this has a very limited impact - only if running very recent
master, and only if receiving more than 2^36 packets that can not
be decrypted - then we might crash due to free()ing an uninitialized
pointer.

Your patch has been applied to the master branch.

commit 5e086c08f2ce4428fd014b74441f0197a71d6da8
Author: Frank Lichtenheld
Date:   Mon Jan 13 12:22:26 2025 +0100

     Fix 'uninitialized pointer read' in openvpn_decrypt_aead

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20250113112226.17728-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30421.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


