From: Alberto Gonzalez Iniesta <agi@...5...>
Subject: Re: [Openvpn-devel] 2nd release candidate for 1.4.0
Message-ID: <20030430124639.GB974@...30...>
References: <200304300539.h3U5dm121322@...41...>
Mime-Version: 1.0
In-Reply-To: <200304300539.h3U5dm121322@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Apr 30 05:47:26 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Builds and works like a charm in Debian.

Building OpenVPN with FRAGMENT_ENABLE shouldn't affect tunnels against
older versions without this option, right?

In that case, I think I'll enable this option in Debian's packages so
we can get some testing/feedback on it. Good idea?

Regards,

Alberto

On Wed, Apr 30, 2003 at 05:39:48AM -0000, James Yonan wrote:
> 
> This release candidate fixes some build problems that surfaced on the outliers
> of the RedHat distribution (6.2 and 9.0).  Other minor fixes as well (see the
> change log).
> 
> Tarball is here:
> 
> http://openvpn.sourceforge.net/beta/openvpn-1.3.2.30.tar.gz
> 
> James
> 
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-- 
Alberto Gonzalez Iniesta       | They that give up essential liberty
agi@(agi.as|debian.org)        | to obtain a little temporary safety
Encrypted mail preferred       | deserve neither liberty nor safety.

Key fingerprint = 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

