Date: Wed, 18 Aug 2010 16:51:21 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100818145120.GU9777@...1296...>
References: <1282134451-21285-1-git-send-email-dazo@...384...>
	<4C6BD3E9.6060909@...68...>
Mime-Version: 1.0
In-Reply-To: <4C6BD3E9.6060909@...68...>
Subject: Re: [Openvpn-devel] [PATCH] Test framework improvment - Do not FAIL
	if	t_client.rc is missing
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

On Wed, Aug 18, 2010 at 02:36:57PM +0200, Matthias Andree wrote:
> Am 18.08.2010 14:27, schrieb David Sommerseth:
> > This is to avoid 'make check' fail if this extra test case is not
> > configured.  The patch gives a PASS, but will notify the user that
> > this test was skipped.
> 
> The other question is how t_client.rc can go missing...

It's not shipped by default.  Since you need to setup a reference server,
and this cannot be the same machine (since you can't enforce that packets
go through the tun/tap then), it's not something that can be successfully
tested "just by extracting the tarball and run make ; make check".

We ship a t_client.rc-sample that explains what goes in there and how
to enable this.

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

