Date: Fri, 19 Jan 2024 14:10:09 +0100 (CET)
Message-Id: <202401191310.40JDA9ad045809@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240119120341.22933-1-gert@...1296...>
References: <20240119120341.22933-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: buf_string_match_head_str: Fix
 Coverity issue 'Unsigned compared against 0'
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

Arguably coverity is right here :-)

Your patch has been applied to the master and release/2.6 branch (bugfix).

commit bc29bd6a3376158b73d069758122739fbf93c022 (master)
commit 68b00a54e779325f4ac9d9416b4e85261f771c23 (release/2.6)
Author: Frank Lichtenheld
Date:   Fri Jan 19 13:03:41 2024 +0100

     buf_string_match_head_str: Fix Coverity issue 'Unsigned compared against 0'

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20240119120341.22933-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28093.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


