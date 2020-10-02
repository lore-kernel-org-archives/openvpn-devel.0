Date: Fri, 2 Oct 2020 13:06:12 +0200 (CEST)
Message-Id: <202010021106.092B6CNC082772@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201001154658.9798-1-davids@...515...>
References: <20201001154658.9798-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: compat/lz4: Update to v1.9.2
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master, release/2.5 and 2.4 branch.

(Even though I agree with Arne that it sounds like a good plan to
just kick out compat-lz4 in master, given that the times have changed
quite a bit compared to the initial import 6.5 years(!) ago, for
consistency reasons I prefer to have it consistent between master
and the release branches until we kick it out).

Parts of my test rig excercise LZ4 compression, so it's at least
lightly tested (on gentoo, with no system-wide lz4 installed).

commit 0f44a9080530df70410106c244e9efc7f2d8a802 (master)
commit 156db76f6670cb2645aaebf036d91ad4020d8aae (release/2.5)
commit 2c0ed08ab2e340664fda9e790c14bd6f0bb92af5 (release/2.4)
Author: David Sommerseth
Date:   Thu Oct 1 17:46:58 2020 +0200

     compat/lz4: Update to v1.9.2

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20201001154658.9798-1-davids@...515...>
     URL: https://www.mail-archive.com/search?l=mid&q=20201001154658.9798-1-davids@...515...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


