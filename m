Date: Thu, 5 Jan 2023 16:22:46 +0100 (CET)
Message-Id: <202301051522.305FMkZU024364@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230101215109.1521549-3-selva.nair@...277...>
References: <20230101215109.1521549-3-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Refactor signal handling in
 openvpn_getaddrinfo
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

This is basically the same thing as 1/5, just for the getaddrinfo()
related functions.  And no, I have no idea why they are treated "special",
and getaddrinfo() is not a syscall.  OTOH, getaddrinfo() spends most of
its time in "waiting for DNS packets", which might result in visible
behaviour similar to a restarted/restartable syscall on signals coming
in...  the "let's rewrite that thing" part would be 2.7 material, though.

The code changes look reasonable ("straightforward as 1/5"), the test
rigs still works  I do not have specific "test signal handling / timeout
in DNS" test cases today, though.

Your patch has been applied to the master and release/2.6 branch.

commit eff95d500481c7927c5a9edd6b5c0dfa056a0cbb (master)
commit 1ff87267f819b512c34a202b9a023c76e7031af4 (release/2.6)
Author: Selva Nair
Date:   Sun Jan 1 16:51:06 2023 -0500

     Refactor signal handling in openvpn_getaddrinfo

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230101215109.1521549-3-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25872.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


