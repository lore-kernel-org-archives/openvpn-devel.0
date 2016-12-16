References: <20161216163218.25449-1-jm@...1926...>
From: Julien Muchembled <jm@...1926...>
Message-ID: <34dd18d1-a2fb-7e89-7a19-43603f0491ba@...1926...>
Date: Fri, 16 Dec 2016 17:42:30 +0100
MIME-Version: 1.0
In-Reply-To: <20161216163218.25449-1-jm@...1926...>
Subject: [Openvpn-devel] What about adding -Werror=implicit -Werror=format
 -Werror=format-security ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: kirr@...1926...

To avoid issues like https://community.openvpn.net/openvpn/ticket/792 to happen again, I wanted to also submit a patch that adds a few -Werror= flags. However, I wonder what would be your preferred way to only add flags that are supported by the compiler.

One solution is with
  https://www.gnu.org/software/autoconf-archive/ax_check_compile_flag.html
which means:
- copy ax_check_compile_flag.m4 from the autoconf archive to the openvpn repository
- include it in configure.ac
- and for example:

AX_CHECK_COMPILE_FLAG([ -Werror=implicit ], [
    CFLAGS_EXTRA="$CFLAGS_EXTRA -Werror=implicit"
])

Julien

