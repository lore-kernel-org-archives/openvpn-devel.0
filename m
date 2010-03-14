Date: Sun, 14 Mar 2010 12:19:49 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100314111949.GC25238@...1296...>
References: <4B8ADF36.3050201@...1114...>
	<20100301105856.GY9556@...1296...> <4B9C1C16.8080107@...68...>
Mime-Version: 1.0
In-Reply-To: <4B9C1C16.8080107@...68...>
Subject: Re: [Openvpn-devel]
	=?iso-8859-1?q?=5BFeedback_needed=5D=A0Fix_cross_?=
	=?iso-8859-1?q?compile_support?=
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Sun, Mar 14, 2010 at 12:13:26AM +0100, Matthias Andree wrote:
> No offense, but do you think it's within objective discussion to call the patch
> "mostly-religious change" (which is a non-objective comment in my book) if you
> "don't really understand the subtleties of autoconf and friends"?

Well, there's two parts to the original patch.

One is the functional patches in configure.ac - I can't say anything about
that, so I'm not doing so.

The other part is changing all TARGET_* defines to HOST_* defines.  This 
is not changing functionality or portability, as the very defines are 
explicitely set in configure.ac, and they could be MySystemIs_* as far as 
functionality is concerned.  So the change is because people believe it 
to be "the right way" - which makes it "mostly-religious" in my book: not 
based on functional changes, but because "it's the right way".

Whitespace changes to cleanup broken formatting fall into the same category
for me - quite often, there are very good reasons to do so, but if the
circumstances are such that it conflicts with other development work, it 
might be prudent to postpone them until after other stuff has been merged.

... and this is exactly what I proposed: don't include the larger chunk
of the changes right *now*.  Wait for the multiple branches to settle
down, and then decide how to adjust the TARGET_* definitions.

[..]
> WRT practical merge concerns around TARGET_*, git knows the "rerere" sub-command
> to track merge conflict resolutions (see the manual); and since the required
> edits can be scripted, that could happen on the feature branches before
> attempting a merge. No big deal.

Well, this is putting extra work on David Sommerseth's lap.  If he is willing
to handle that, I won't object.

As for now, I have been operating under the premises that different branches
in the openvpn-devel tree should avoid to cause merge conflicts (unless 
unavoidable for required functionality, see ipv6 payload vs. ipv6 transport).

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

