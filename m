Date: Thu, 11 Jul 2024 11:39:07 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Zo+oO7oJvIpCpoRe@...2685...>
References: <gerrit.1720531952000.I72934e747d1ad68a7e3675afbeb1b63df7941186@...2715...>
 <20240710160306.190351-1-frank@...2641...>
 <Zo7h18ecLwg2lDdB@...1296...>
MIME-Version: 1.0
In-Reply-To: <Zo7h18ecLwg2lDdB@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] configure: Switch to C11 by default
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net, Arne Schwabe <arne-openvpn@...1227...>

On Wed, Jul 10, 2024 at 09:32:39PM +0200, Gert Doering wrote:
> Hi,
> 
> On Wed, Jul 10, 2024 at 06:03:06PM +0200, Frank Lichtenheld wrote:
> > Mostly so we can use anonymous structs without jumping through
> > hoops or relying on unofficial support.
> > 
> > Change-Id: I72934e747d1ad68a7e3675afbeb1b63df7941186
> > Signed-off-by: Frank Lichtenheld <frank@...2641...>
> > Acked-by: Arne Schwabe <arne-openvpn@...1227...>
> > ---
> > 
> > This change was reviewed on Gerrit and approved by at least one
> > developer. I request to merge it to master.
> 
> This breaks all OpenBSD 6.8 builds.  Are you intentionally ignoring
> this ("this OS is out of support, we'll discontinue this buildbot"?  If
> yes, we might want to point out that this change has fallout on older
> "build environments" - not sure what is problematic here, C compiler or
> system headers, or libc...

Yes, ignoring that intentionally. I plan to disable OpenBSD 6.8 builds for master
instead.

Basically the intent of this patch is to approve
https://gerrit.openvpn.net/c/openvpn/+/588 (Remove check for anonymous unions
from configure and cmake config) but improve it by officially switching to C11
(which implies support for anonymous unions).

We can certainly extend the messaging.

Regards,
-- 
  Frank Lichtenheld

