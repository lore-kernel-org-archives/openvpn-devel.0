Date: Sat, 4 Nov 2017 17:14:29 +0100 (CET)
Message-Id: <201711041614.vA4GET0X015349@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170221192737.24166-3-davids@...515...>
References: <20170221192737.24166-3-davids@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: lz4: Rebase compat-lz4 against
 upstream v1.7.5
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

ACK.

Based on:
 - after this patch, the compat-lz4.c and compat-lz4.h files exactly match
   the lz4.c/lz4.h files from the upstream repo, tag 1.7.5, with the
   modifications done by our tool (needed to fit the "compat" conditional
   building)
 - with 1.7.5, we can have LZ4_versionString() now [patch pending...]
 - there is newer stuff in the LZ4 repo, but as far as I could determine,
   there is nothing crucial or interesting for us in there - so for the
   time being, this jump is good enough (and I could take your patch and
   just apply it, instead of doing another round)

Of course it also passes t_client tests (built on a system with no lz4) :-)

Your patch has been applied to the master and release/2.4 branch.

commit 86614539e5ff2ca72f61a9a377130f3b403c9434 (master)
commit dd001c359ca1e1fd2181aa0da1f2074608806e0f (release/2.4)
Author: David Sommerseth
Date:   Tue Feb 21 20:27:36 2017 +0100

     lz4: Rebase compat-lz4 against upstream v1.7.5

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20170221192737.24166-3-davids@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14137.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


