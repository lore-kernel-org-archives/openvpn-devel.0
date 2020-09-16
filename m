Date: Wed, 16 Sep 2020 17:15:54 +0200 (CEST)
Message-Id: <202009161515.08GFFsL9039052@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200916141956.1277-1-davids@...515...>
References: <20200916141956.1277-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: sample-plugins: Partially
 autotoolize the sample-plugins build
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

Acked-by: Gert Doering <gert@...1296...>

Works for in-tree and out-of-tree builds now, both "just gmake" and
"gmake simple/simple.so".

The gmake requirement is well documented and "good enough" for this
dusty corner where people very rarely need to build stuff.  (It might
be solvable by replacing the (foreach) stuff with "the list contains
the .so names, and the rule goes directly .c -> .so, not with an
intermediate -- but I'm not sure it's actually good spending of our
time)

Your patch has been applied to the master and release/2.5 branch.

commit 0b5141d8f946a274bf27b3592ac07dc9c6b0ee71 (master)
commit 72d89d994840e2a47b7267054e77e82a908bf693 (release/2.5)
Author: David Sommerseth
Date:   Wed Sep 16 16:19:56 2020 +0200

     sample-plugins: Partially autotoolize the sample-plugins build

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200916141956.1277-1-davids@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21020.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


