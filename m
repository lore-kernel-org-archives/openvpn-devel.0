MIME-Version: 1.0
In-Reply-To: <1337035323-27465-1-git-send-email-alon.barlev@...277...>
References: <1337035323-27465-1-git-send-email-alon.barlev@...277...>
Date: Tue, 15 May 2012 01:50:33 +0300
Message-ID: <CAOazyz0bWXnXkzU+d4Da0h+KtVuJysZjH5kPd_b1Z0=8qgtQHw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] build: integrate plugins build into
	core build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

On Tue, May 15, 2012 at 1:42 AM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> As disucssed[1], keep plugins in repository.
>
> 1, Proper automake/libtool build.
>
> 2. Move example plugins to samples/sample-plugins.
>
> 3. Plugins are installed at LIBDIR/openvpn/plugins.
>
> [1] http://comments.gmane.org/gmane.network.openvpn.devel/6436
>
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>

Hello,

At least finish the build system and reach to a sane state.

This is on top of my build[1] branch, which is waiting...
Also unicode[2] branch is waiting.
This one is at[3].

Alon.

[1] https://github.com/alonbl/openvpn/compare/build
[2] https://github.com/alonbl/openvpn/compare/master...unicode
[3] https://github.com/alonbl/openvpn/compare/master...plugins2

