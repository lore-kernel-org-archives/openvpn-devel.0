Date: Sun, 20 Jun 2010 18:11:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100620161133.GE361@...1296...>
References: <4C19ED93.50202@...1380...>
	<4C1A0941.5000808@...515...>
	<AANLkTinkGgRbX7tY0QZzoC-ru5jhKFdpiEgn-proJecI@...278...>
	<4C1A1AE1.5090305@...1380...>
	<AANLkTimpz7YASaTfmQ5DItwiMrplAx_G93ez2vHxAWW5@...278...>
	<4C1A3658.6090501@...1380...>
	<4C1A7E26.4010206@...1114...>
	<20100618000120.28120.qmail@...1287...>
Mime-Version: 1.0
In-Reply-To: <20100618000120.28120.qmail@...1287...>
Subject: Re: [Openvpn-devel] [PATCH] Choose a different field in X509 to
	be	username
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
To: openvpn-devel@lists.sourceforge.net

Hi,

On Fri, Jun 18, 2010 at 02:01:20AM +0200, Peter Stuge wrote:
> David Sommerseth wrote:
> > > 3) "sizeof(common_name)" is useless... Line 745: char
> > > common_name[TLS_USERNAME_LEN]; we can use directly TLS_USERNAME_LEN.
> > 
> > Thanks a lot for the patch and all rework done.  (Also: thank you to all
> > reviewers!)
> > 
> > The third and last patch looks very good!  I've applied it to the
> > feat_misc branch and merged it into allmerged.
> 
> I strongly agree with Alon about sizeof() rather than a second
> reference to the same define. It is the defensive way.

I'm a bit late, but I also want to second this :-)

That way, if the definition of "common_name" is ever changed to a
different size, e.g "TLS_USERNAME_LEN+3" or whatever, all(!) references 
automatically get the correct size.  Defensive coding, less surprises
later on.

gert

-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

