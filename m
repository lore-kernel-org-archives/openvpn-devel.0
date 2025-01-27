Date: Mon, 27 Jan 2025 12:39:55 +0100 (CET)
Message-Id: <202501271139.50RBdtBS054717@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250121161247.37883-1-frank@...2641...>
References: <20250121161247.37883-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove comparing username to
 NULL in tls_lock_username
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

JFTR, v2 in gerrit is "the same as v1, just rebased", so taking what is
already on the list here.

And indeed, in the only call chain to this, we have

    string_mod_remap_name(up->username);

.. so this should better be non-NULL :-)  (ASSERT(str) in string_mod()).

Your patch has been applied to the master branch.

commit d9af13e8c222cba41000202908663a6d1e2cd028
Author: Arne Schwabe
Date:   Tue Jan 21 17:12:47 2025 +0100

     Remove comparing username to NULL in tls_lock_username

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20250121161247.37883-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30520.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


