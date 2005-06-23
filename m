From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Why must PAM library be dlopened?
In-Reply-To: <20050623083639.GA14170@...33...>
Message-ID: <Pine.LNX.4.58.0506230942080.10675@...41...>
References: <200506141234.50171.nomis80@...401...> <200506211059.31506.nomis80@...401...>
 <Pine.LNX.4.58.0506212216440.10675@...41...> <200506220836.53588.nomis80@...401...>
 <Pine.LNX.4.58.0506222324120.10675@...41...> <20050623083639.GA14170@...33...>
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
Date: Thu Jun 23 09:16:11 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Matthias Andree <ma+ovpnd@...31...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, 23 Jun 2005, Matthias Andree wrote:

> On Wed, 22 Jun 2005, James Yonan wrote:
> 
> > This will add a GNU Make requirement for the plugin which might be bad,
> > but seems reasonable for now -- at least until someone gets a serious itch
> > to set up an autoconf/automake build system.
> 
> What is your stance in this regard?
>
> On one hand, you say you want it simple,
> on the other hand, you paint auto* as viable for the auth-pam plugin.

While I certainly prefer simplicity, if this issue is going to cause 
breakage down the road, I'd rather pick the solution which is simpler for 
the users, even if it adds some complexity for the developers.

So, yes, I think auto* is viable for the auth-pam plugin if someone wants 
to do it.

One concern I would have is whether the PAM version test at build time is 
always predictive of what the PAM version will be at run time.

James

