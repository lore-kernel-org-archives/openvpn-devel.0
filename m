From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] ARM port
In-Reply-To: <20050624033333.67000.qmail@...424...>
Message-ID: <Pine.LNX.4.58.0506240016220.10675@...41...>
References: <20050624033333.67000.qmail@...424...>
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
Date: Thu Jun 23 23:21:06 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: ov <ov2k@...109...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, 23 Jun 2005, ov wrote:

> Hi all, 
> 
> I'm new to this list, so I hope I'm posting to the right place.  I've been
> working on getting openvpn to work on an ARM system, and I've run into a
> little trouble.
> 
> A straight ./configure; make works fine, but the resulting binary fails
> the loopback self tests with an assertion failure in integer.h: 
> TESTING ENCRYPT/DECRYPT of packet length=97
> Assertion failed at integer.h:94
> 
> Oddly enough, with this code before the assert, it passes the test: 
> if(0 > x || x >= mod || -mod > y || y > mod)
>   fprintf(stderr, "x %d y %d mod %dn", x, y, mod);
> 
> Any ideas on what's going on?  Has anybody seen this before?  Should I be
> worried about this?

This is the first report I've ever seen of an assertion in this function.  
Try making the function non-inline and see if that changes anything.

Which compiler/version are you using?

James

