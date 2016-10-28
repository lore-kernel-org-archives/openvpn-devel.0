From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 28 Oct 2016 18:42:36 +0200
Message-ID: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] struct argv overhaul
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi

This series is a direct outcome of the incident with my previous
patch. I've taken on struct argv and related functions and made
them like I please.

For a more detailed description what's happening see the
comments in the individual patches:

[PATCH 1/7] put argv_* functions into own file, add unit tests
[PATCH 2/7] Remove unused and unecessary argv interfaces
[PATCH 3/7] remove unused system_str from struct argv
[PATCH 4/7] Factor out %sc handling from argv_printf()
[PATCH 5/7] re-implement argv_printf_*()
[PATCH 6/7] argv: do fewer memory re-allocations
[PATCH 7/7] Add gc_arena to struct argv to save allocations


Code hase only been unit tested, so I'd really also like
feedback from someone actually running the code.
And if it be buildbot...

Cheers
Heiko


