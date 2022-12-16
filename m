Date: Fri, 16 Dec 2022 11:54:20 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y5xOXLbRtka5Z81+@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
References: <20221216090717.1082-1-lstipakov@...277...>
MIME-Version: 1.0
In-Reply-To: <20221216090717.1082-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] git-version.py: use tag as branch name
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

On Fri, Dec 16, 2022 at 11:07:17AM +0200, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
> 
> Git magic to get branch name
> 
>   git rev-parse --symbolic-full-name HEAD
> 
> doesn't work when we're on tag, which is the case when
> we build releases. In this case, use tag name as branch name
> with another git magic:
> 
>   git describe --tags
> 
> This fixes https://github.com/OpenVPN/openvpn/issues/199.

NAK.

I would propose to invert the logic:

Do "git describe --exact-match" first.

That matches only annotated tags that point to this commit.
So it will actually use the tag consistently independent of
whether you have the commit checked out with detached HEAD
or via the release branch.

And then fall back to the previous mechanism if that doesn't
match.

Regards,
-- 
  Frank Lichtenheld

