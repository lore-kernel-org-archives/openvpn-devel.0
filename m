From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] CVS out-of-date
Message-ID: <20040519190600.GA26263@...33...>
References: <08c401c43dd0$a873cdb0$0200000a@...139...>
Mime-Version: 1.0
In-Reply-To: <08c401c43dd0$a873cdb0$0200000a@...139...>
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
Date: Wed May 19 12:07:04 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Wed, 19 May 2004, Gisle Vanem wrote:

> What's the situation with the Sourgeforge CVS server?
> Seems the OpenVPN-2.0 beta 2 isn't in CVS (in tar-ball
> only). 
> 
> I used these commands to checkout
>   cvs -z3 -d:pserver:anonymous@...116...:/cvsroot/openvpn login
>   cvs -z3 -d:pserver:anonymous@...116...:/cvsroot/openvpn co openvpn

You need to tell CVS to check out the branch, i. e.
use cvs -z3 -d:pserver:anonymous@...116...:/cvsroot/openvpn checkout -rBETA20 openvpn


-- 
Matthias Andree

Encrypted mail welcome: my GnuPG key ID is 0x052E7D95

