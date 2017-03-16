Date: Thu, 16 Mar 2017 09:00:07 +0100 (CET)
Message-Id: <201703160800.v2G807Cq096517@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <df273b9b-6ca4-a539-cdf5-d4f9f991896b@...1918...>
References: <df273b9b-6ca4-a539-cdf5-d4f9f991896b@...1918...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix Building Using MSVC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Eric Thorpe <eric@...1918...>
Cc: openvpn-devel@lists.sourceforge.net

ACK, thanks.

Your patch has been applied to the master and release/2.4 branch.

I've taken the commit message from v1 so there's a bit more explanation.

Also, I had to fix quite a bit of whitespace changes - lines in the
config-msvc-version.h patch got wrapped, and all context lines got a
extra blank in front.  So whatever client you used to send the patch
with, please use "git send-email" instead :-)

Patch from Antonio for the "timespec" issue is coming in...

commit 5ab106db7b091c6409fd0a7e43f557a7931c200f (master)
commit 3fa863100033e7d6d0cbb19361a52efbe097e69d (release/2.4)
Author: Eric Thorpe
Date:   Thu Mar 16 09:40:31 2017 +1100

     Fix Building Using MSVC

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <df273b9b-6ca4-a539-cdf5-d4f9f991896b@...1918...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14268.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


