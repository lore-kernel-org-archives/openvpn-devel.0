Date: Sat, 2 Dec 2023 16:30:45 +0100 (CET)
Message-Id: <202312021530.3B2FUjk4084078@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231201111717.14940-1-frank@...2641...>
References: <20231201111717.14940-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove TEST_GET_DEFAULT_GATEWAY
 as it duplicates --show-gateway
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

Wasn't even aware we had a TEST_... for this - and indeed, why, if we
have a run-time-argument.  But interestingly enough, seems I even added
IPv6 default gateway handling to that dead function... thorough me.

Your patch has been applied to the master and release/2.6 branch.

commit 6158228f16836f56a564d4533e7b513dc6170854 (master)
commit 3168e1af929d7061e0ec2be049f6beea73c49a5a (release/2.6)
Author: Arne Schwabe
Date:   Fri Dec 1 12:17:17 2023 +0100

     Remove TEST_GET_DEFAULT_GATEWAY as it duplicates --show-gateway

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20231201111717.14940-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27624.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


