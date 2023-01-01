From: selva.nair@...277...
Date: Sun,  1 Jan 2023 16:51:04 -0500
Message-Id: <20230101215109.1521549-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/5] Improve signals and avoid losing high
 priority ones
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
To: openvpn-devel@lists.sourceforge.net

From: Selva Nair <selva.nair@...277...>

Back to my long-forgotten signal patch -- cleaned up and rebased.
What better to do on a Jan 1st afternoon...

Commits:

1.  Preparing for better signal handling: some code refactoring
2.  Refactor signal handling in openvpn_getaddrinfo
3.  Assign and honour signal priority order
4.  Fix signal handling on Windows
5.  Improve signal handling using POSIX sigaction

Commits 1 to 4 are fairly non-intrusive and should fix trac #639 and #311
(or github #205) for most practical purposes.

Commit 5 rewrites sig.c using sigaction for proper masking of signals during
updates. May be too intrusive and too late to get well-tested for 2.6.

