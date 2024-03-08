Date: Fri, 8 Mar 2024 12:51:33 +0100 (CET)
Message-Id: <202403081151.428BpXTq026459@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240308102818.9249-1-gert@...1296...>
References: <20240308102818.9249-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: t_client.sh: Allow to skip tests
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

Thanks.  This is a welcome addition for CI tests where we test functionality
that might fail "if built with the wrong SSL library" (like, NTLM proxy) -
and I could see a few more of this ("compression variants", etc)

The test looks larger than the actual t_client.sh(.in) + doc change as
it brings an actual "can NTLM proxy work?" test program - as we discussed
the handling of mock_msg.c/mock_msg.h could be improved, but we all 
haven't been able to come up with a really nice way.

Tested ntlm_support with an mbedTLS build, works as designed...

openvpn$ tests/ntlm_support
FATAL ERROR:MD4 not supported
openvpn$ echo $?
1


(Building this on top of a tree that has already been built without this
patch leads to confused Makefiles and failures to build "ntlm_support" -
but this goes away on a fresh checkout / autoreconf, so will not normally
hit users)

Your patch has been applied to the master branch.

commit 0c7cf0694ee6f878168330e9a084c255c51a9e8b
Author: Frank Lichtenheld
Date:   Fri Mar 8 11:28:18 2024 +0100

     t_client.sh: Allow to skip tests

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240308102818.9249-1-gert@...1296...>
     URL: https://www.mail-archive.com/search?l=mid&q=20240308102818.9249-1-gert@...1296...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


