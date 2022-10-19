Date: Wed, 19 Oct 2022 09:20:04 +0200 (CEST)
Message-Id: <202210190720.29J7K47N065148@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221012145915.25810-1-gert@...1296...>
References: <20221012145915.25810-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: FreeBSD: for topology subnet,
 put tun interface into IFF_BROADCAST mode
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for the review, Kristof.

Just to be sure, I've run this through extensive client/server tests
on FreeBSD 14 + 12.3 again.  Still works :-)

(Except that this patch, as documented, breaks "topology subnet with DCO"
- to be fixed in the next commit)

Patch has been applied to the master branch.

commit 94db32616597497e57eb2fa6fab05297da314a53
Author: Gert Doering
Date:   Wed Oct 12 16:59:14 2022 +0200

     FreeBSD: for topology subnet, put tun interface into IFF_BROADCAST mode

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Kristof Provost <kprovost@...2661...>
     Message-Id: <20221012145915.25810-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25396.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


