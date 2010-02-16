Date: Tue, 16 Feb 2010 17:59:21 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100216165921.GG9556@...1296...>
References: <20100118220952.GA6704@...1293...>
	<4B79D4D6.9050905@...384...>
Mime-Version: 1.0
In-Reply-To: <4B79D4D6.9050905@...384...>
Subject: Re: [Openvpn-devel] [ANNOUNCE] IPv6 payload patch
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
To: David Sommerseth <dazo@...384...>
Cc: Bernhard Schmidt <berni@...376...>, openvpn-devel@lists.sourceforge.net

Hi,

On Tue, Feb 16, 2010 at 12:12:22AM +0100, David Sommerseth wrote:
> On 18/01/10 23:09, Bernhard Schmidt wrote:
[..]
> As a newly appointed maintainer for the openvpn-testing repository, I 
> tried to merge in these changes into the testing repository.  But I got 
> an enormous amount of merge conflicts, which was not too much trivial to 
> solve some places.

Just for the record - this got sorted out, the problem was not with the
IPv6 patch but with the way two different git repositories where built
from SVN.

Bernhard has rebuilt his git repository now, and David has integrated
the IPv6-payload patch into the "testing" OpenVPN git repository (thanks!).

> The openvpn-testing.git tree can be found here: 
> <git://openvpn.git.sourceforge.net/gitroot/openvpn/openvpn-testing.git>


The IPv6-payload patch has been tested in a number of networks for the
last 6 weeks, and so far, it has done what was configured, and not broken
anything else.

Nevertheless I do not consider it ready for inclusion into the mainstream
tree yet - it lacks full documentation, testing of other scenarios than
"server-to-client tun", and I would very much like to get more feedback and
review on the way it is currently implemented, and whether something
should be done in a fundamentally different way.

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

