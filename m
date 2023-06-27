Date: Tue, 27 Jun 2023 22:32:44 +0200 (CEST)
Message-Id: <202306272032.35RKWi9G003369@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230620135310.94455-6-frank@...2641...>
References: <20230620135310.94455-6-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: GHA: update to run-vcpkg@...2735...
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

Whatever it does... GHA and Lev agree that it's fine.

(One thing I noticed is that the "msbuild" builds now also run the
cmocka tests - this seems to be a new thing, and very welcome!)

I have extended the commit message to include the cache thing.

Your patch has been applied to the master branch.

commit 66e33ee81d1d7fa3495ae3aad6e673766e296687
Author: Frank Lichtenheld
Date:   Tue Jun 20 15:53:10 2023 +0200

     GHA: update to run-vcpkg@...2735...

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20230620135310.94455-6-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26755.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


