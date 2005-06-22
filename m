From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Why must PAM library be dlopened?
In-Reply-To: <200506220836.53588.nomis80@...401...>
Message-ID: <Pine.LNX.4.58.0506222324120.10675@...41...>
References: <200506141234.50171.nomis80@...401...> <200506211059.31506.nomis80@...401...>
 <Pine.LNX.4.58.0506212216440.10675@...41...> <200506220836.53588.nomis80@...401...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Jun 22 22:56:40 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Simon Perreault <nomis80@...401...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 22 Jun 2005, Simon Perreault wrote:

> On Wednesday 22 June 2005 00:22, James Yonan wrote:
> > Thanks for the analysis.  Because of the PAM bug, I think that
> > openvpn-auth-pam will need to support the dlopen workaround for some time
> > to come.
> 
> Yes, I have been thinking the same.
> 
> > Maybe the solution would be to set up an alternative Makefile 
> > target that builds according to your patch, but leave the default for now
> > as is.
> 
> Great idea. You'll find a new patch attached that does just this. A variable 
> in the Makefile, DLOPEN_PAM, controls whether libpam.so is dlopened or linked 
> in directly. I've set it to zero by default, and I suggest that you leave it 
> that way. This makes the default Makefile work with newer, not broken PAM. 
> The rationale is that you should have more work to do when you want to use a 
> broken PAM than when you use a fixed one. And because broken PAM will be less 
> often encountered as they are obsoleted by newer distro releases, this is the 
> natural thing to do.

Simon,

Thanks for the patch.  I'm inclined to merge it in the 2.0.x series,
however I would want to set DLOPEN_PAM=1 at least initially since I would
be concerned about breaking existing behavior in a stable series.  (I
agree in theory that you should have more work to do when you want to use
a broken tool, however I tend to believe more strongly that workarounds
which are needed by a significant percentage of users need to be the
default.)

This will add a GNU Make requirement for the plugin which might be bad,
but seems reasonable for now -- at least until someone gets a serious itch
to set up an autoconf/automake build system.

James

