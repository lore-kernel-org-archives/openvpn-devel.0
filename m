MIME-Version: 1.0
In-Reply-To: <1472413323-21723-1-git-send-email-steffan@...1856...>
References: <1472413323-21723-1-git-send-email-steffan@...1856...>
From: Steffan Karger <steffan@...1856...>
Date: Sun, 28 Aug 2016 21:46:02 +0200
Message-ID: <CAA1AbxLe+Gj3JDz=yhO-L63sqhojOtXd6ZMEiP+61E7=7rnVwA@...278...>
Subject: Re: [Openvpn-devel] [PATCH (master)] Drop gnu89/c89 support,
	switch to c99
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 28 August 2016 at 21:42, Steffan Karger <steffan@...1856...> wrote:
> Previously, we would use the compiler's default C version, which defaults
> to gnu89 for GCC < 5, gnu11 for GCC > 5, and c11 for clang, but might even
> differ per distro.
>
> One of the reasons to accept the gnu89 default of GCC < 4.9, was that MSVC
> didn't support c99.  But in MSVC 2015, MS finanally fixed that.
>
> Having to support c89 in the codebase occasionally forces us to write less
> readable code, for example by forcing all declaration to be at the starting
> of a block (which includes 'for loop initial declarations').
>
> Let's be clear about what standard we obey, and stop punishing ourselves
> with c89/gnu89.  Let's switch the master branch to c99.

To be clear:  I'm aware we never really decided to switch to c99, so
this patch is partly meant to start discussion.  Anyone who cares for
gnu89 support, please speak up :)

-Steffan

