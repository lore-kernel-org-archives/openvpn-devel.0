Date: Tue, 28 Jan 2025 19:01:24 +0100 (CET)
Message-Id: <202501281801.50SI1O3u012251@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250128124129.109647-1-frank@...2641...>
References: <20250128124129.109647-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Haiku: change del to delete in
 route command. del is undocumented
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
To: Alexander von Gluck <alex@...2837...>
Cc: openvpn-devel@lists.sourceforge.net

Not much to test here :-) - patch only affects #ifdef TARGET_HAIKU blocks
and only "route" command line naming.

Your patch has been applied to the master branch.

commit 625b3e91b9a5b3283ae59cdab253a55e34feea7f
Author: Alexander von Gluck
Date:   Tue Jan 28 13:41:29 2025 +0100

     Haiku: change del to delete in route command. del is undocumented

     Signed-off-by: Alexander von Gluck <alex@...2837...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20250128124129.109647-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30655.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


