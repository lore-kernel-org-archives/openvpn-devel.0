Date: Fri, 22 Aug 2025 22:55:57 +0200 (CEST)
Message-Id: <202508222055.57MKtvmF096757@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250822205223.3492-1-gert@...1296...>
References: <20250822205223.3492-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: options: Fix --hash-size
 virtual argument
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

Trivially correct.  And amazing that this oversight is in the code
since before the dawn of git...

I have not tested this, nor am I going to build a test rig that 
tests --hash-size variants.  Anyone feels like a unit test? ;-)

Your patch has been applied to the master branch.

commit 4f7ae8acdecf2ad45319270a0045af92d610264c
Author: Frank Lichtenheld
Date:   Fri Aug 22 22:52:16 2025 +0200

     options: Fix --hash-size virtual argument

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250822205223.3492-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32658.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


