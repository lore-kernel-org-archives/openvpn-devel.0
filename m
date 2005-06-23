From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] Why must PAM library be dlopened?
Message-ID: <20050623083639.GA14170@...33...>
References: <200506141234.50171.nomis80@...401...> <200506211059.31506.nomis80@...401...> <Pine.LNX.4.58.0506212216440.10675@...41...> <200506220836.53588.nomis80@...401...> <Pine.LNX.4.58.0506222324120.10675@...41...>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.58.0506222324120.10675@...41...>
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
Date: Thu Jun 23 01:39:32 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Wed, 22 Jun 2005, James Yonan wrote:

> This will add a GNU Make requirement for the plugin which might be bad,
> but seems reasonable for now -- at least until someone gets a serious itch
> to set up an autoconf/automake build system.

What is your stance in this regard?

On one hand, you say you want it simple,
on the other hand, you paint auto* as viable for the auth-pam plugin.

I don't yet have a reasonable test to stuff into autoconf though, lack
of time. Perhaps tomorrow.

-- 
Matthias Andree

