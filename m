Date: Mon, 1 Aug 2022 17:39:19 +0200 (CEST)
Message-Id: <202208011539.271FdJev052327@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220801150812.32561-1-a@...2181...>
References: <20220801150812.32561-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: disable DCO if no --dev was
 specified
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

The broken bit was added quite a few patches ago, but wasn't caught by
my testing, because it needed --enable-dco *and* DCO-in-kernel - otherwise,
the DCO paths would disable themselves, and not crash :-)

Tested on ubuntu 20 with DCO kernel support - without this,

  $ openvpn --test-crypto

segfaults - with the patch, it complains :-)

Your patch has been applied to the master branch.

commit b8b0a95efff0184cebacc43a6e751fa8f9092cd8
Author: Antonio Quartulli
Date:   Mon Aug 1 17:08:12 2022 +0200

     disable DCO if no --dev was specified

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220801150812.32561-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24772.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


