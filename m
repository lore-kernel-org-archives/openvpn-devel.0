Date: Mon, 9 Jun 2025 19:46:04 +0200 (CEST)
Message-Id: <202506091746.559Hk4he079725@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250609100216.3997-1-gert@...1296...>
References: <20250609100216.3997-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco_linux: enable extended
 netlink error reporting
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
To: Antonio Quartulli <antonio@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Tested, makes sense - I intentionally broke some code parts in dco_linux.c
that set up a peer, and instead of a not very helpful "-7" userspace now
gets a proper error string.  Discovered the extra "\n" testing this, so
thanks for the v2 fix :-)

Your patch has been applied to the master branch.

commit ddbfbeca603eedddc12556b28e5cd9b022e9ea63
Author: Antonio Quartulli
Date:   Mon Jun 9 12:02:10 2025 +0200

     dco_linux: enable extended netlink error reporting

     Signed-off-by: Antonio Quartulli <antonio@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250609100216.3997-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31885.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


