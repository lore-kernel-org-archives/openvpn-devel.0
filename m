Date: Wed, 15 Jan 2025 15:32:46 +0100 (CET)
Message-Id: <202501151432.50FEWkdg087157@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250114165206.13187-1-gert@...1296...>
References: <20250114165206.13187-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix some trivial sign-compare
 compiler warnings
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

Stared at the changes (make sense), BB confirms that no platform takes
offense either, so in it goes.

Your patch has been applied to the master branch.

commit 6d91eda5a120a4a18273d82fed6777b3efcce8cc
Author: Frank Lichtenheld
Date:   Tue Jan 14 17:52:06 2025 +0100

     Fix some trivial sign-compare compiler warnings

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250114165206.13187-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30455.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


