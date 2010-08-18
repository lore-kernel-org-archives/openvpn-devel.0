Date: Wed, 18 Aug 2010 16:58:23 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100818145823.GV9777@...1296...>
References: <4C6BD3CB.5050009@...68...>
	<1282136643-22193-1-git-send-email-dazo@...384...>
	<4C6BDFD1.3030707@...68...>
Mime-Version: 1.0
In-Reply-To: <4C6BDFD1.3030707@...68...>
Subject: Re: [Openvpn-devel] [PATCH v2] Test framework improvment - Do not
	FAIL	if t_client.rc is missing
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

On Wed, Aug 18, 2010 at 03:27:45PM +0200, Matthias Andree wrote:
> > +if [ -r ./t_client.rc ] ; then
> > +    . ./t_client.rc
> > +elif [ -r "${srcdir}"/t_client.rc ] ; then
> > +    . "${srcdir}"/t_client.rc
> > +else
> > +    echo "$0: cannot find 't_client.rc' in current directory or" >&2
> > +    echo "$0: source dir ('${srcdir}').  SKIPPING TEST." >&2
> > +    exit 77
> > +fi
> 
> I have occasionally been bitten by such ambiguities between current working
> directory and $srcdir.  I'd propose to steer clear of such precedence rules.

I'm using this on purpose here - I have a number of machines that build
using the same $srcdir (mounted over NFS), and one of them has no working
IPv6-over-tun.  So this special machine has a t_client.rc in its 
build directory which sources $srcdir/t_client.rc and subsequently 
unsets all IPv6-related test targets.

So all machines can use the same generic t_client.rc, and if I need to
fiddle with things on individual hosts, I can do so, without having to
maintain a "nearly identical" copy on all machines.

> >  if [ -z "$CA_CERT" ] ; then
> >      echo "CA_CERT not defined in 't_client.rc'. SKIP test." >&2
> >      exit 0
> 
> I think you missed this "exit 0" - should also be 77 instead - and please check
> if there are more (I've not been looking at the source script for lack of time).

There are some more.

David, could you patch these as well?  Otherwise I need to go cherrypicking
your changes first (and this might take longer).

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

