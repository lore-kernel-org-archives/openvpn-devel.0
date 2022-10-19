Date: Wed, 19 Oct 2022 11:09:35 +0200 (CEST)
Message-Id: <202210190909.29J99Zua072083@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221012145915.25810-2-gert@...1296...>
References: <20221012145915.25810-2-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: FreeBSD DCO: introduce real
 subnet mode
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

Thanks, Kristof for the review, and for merging the kernel side.

I have added the kernel commit ID to the commit message for this
patch ("if the kernel is too old, SET_IFMODE will fail and 
topology subnet will not work") - and verified that this is indeed
the result, p2p mode with net30 works, subnet fails.  And of course,
tested with a newer if_ovpn.ko, and all works :-)

I have also taken the liberty to remove the debug message printing
the ifmode to-be-set, and to add the ifmode + 'dco_set_ifmode:' to
the error message, so log file output is more useful.

Patch has been applied to the master branch.

commit 22bc63c78439ed23b974b8f822330d75ec79c7fc
Author: Gert Doering
Date:   Wed Oct 12 16:59:15 2022 +0200

     FreeBSD DCO: introduce real subnet mode

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Kristof Provost <kprovost@...2661...>
     Message-Id: <20221012145915.25810-2-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25395.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


