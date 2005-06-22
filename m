From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] Why must PAM library be dlopened?
Message-ID: <20050622084405.GA16345@...33...>
References: <200506141234.50171.nomis80@...401...> <200506141314.54183.nomis80@...401...> <Pine.LNX.4.58.0506202032420.10675@...41...> <200506211059.31506.nomis80@...401...> <Pine.LNX.4.58.0506212216440.10675@...41...>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.58.0506212216440.10675@...41...>
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
Date: Wed Jun 22 01:45:10 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Tue, 21 Jun 2005, James Yonan wrote:

> Thanks for the analysis.  Because of the PAM bug, I think that 
> openvpn-auth-pam will need to support the dlopen workaround for some time 
> to come.  Maybe the solution would be to set up an alternative Makefile 
> target that builds according to your patch, but leave the default for now 
> as is.

This could be run and determined automatically by the autoconf/automake
couple, automake supports conditional compilation (i. e. depending on
autoconf findings, link another module into a program, or something like
that).

-- 
Matthias Andree

