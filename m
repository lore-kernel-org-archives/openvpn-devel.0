Date: Wed, 2 Nov 2016 20:41:12 +0100 (CET)
Message-Id: <201611021941.uA2JfCls015655@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1474105652-5672-1-git-send-email-lstipakov@...277...>
References: <1474105652-5672-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Drop recursively routed packets
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

ACK, thanks.  Took us long enough.

Tested on Linux, does what it says (--verb 4 shows nice log messages,
with --allow-recursive-routing (and UDP), you get the expected CPU 
explosion instead).  

Passes all my t_client tests on client AND server, including --inetd
and p2p server.

I had to apply two of your changes manually - the option check in 
options.c and Changes.rst had changes in the preceding lines due to
other patches, so "git am" refused to apply it "just so".   Also, 
a small whitespace change was applied to proto.h

Your patch has been applied to the master and release/2.3 branch
(2.3 had conflicts in Changes.rst and options.[ch] - easily solved,
again by fixing contextual lines).

commit fa3e730e19a71419cb88a021b9a0333f088b39ac (master)
commit 7c930767c0b4ae38c4d886678f091a6077ed55a9 (release/2.3)
Author: Lev Stipakov
Date:   Sat Sep 17 12:47:32 2016 +0300

     Drop recursively routed packets

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1474105652-5672-1-git-send-email-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg12476.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


