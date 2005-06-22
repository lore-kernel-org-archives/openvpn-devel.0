From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Why must PAM library be dlopened?
In-Reply-To: <200506220838.36929.nomis80@...401...>
Message-ID: <Pine.LNX.4.58.0506221122430.10675@...41...>
References: <200506141234.50171.nomis80@...401...> <Pine.LNX.4.58.0506212216440.10675@...41...>
 <20050622084405.GA16345@...33...> <200506220838.36929.nomis80@...401...>
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
Date: Wed Jun 22 10:36:11 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Simon Perreault <nomis80@...401...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 22 Jun 2005, Simon Perreault wrote:

> On Wednesday 22 June 2005 04:44, Matthias Andree wrote:
> > This could be run and determined automatically by the autoconf/automake
> > couple, automake supports conditional compilation (i. e. depending on
> > autoconf findings, link another module into a program, or something like
> > that).
> 
> Yes, that would be nice. However, I personally don't have enough time to do 
> this cleanly. The edit-the-makefile-if-you-have-a-broken-PAM solution 
> satisfies me.

I would hate to lose the simplicity of the Makefile approach for the 
plugin tree.  I think one of the important reasons for the plugin tree in 
the first place is to provide a venue for extensions that doesn't inherit 
all of the build complexity of the main tree.

James


