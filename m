From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] ARM port
In-Reply-To: <20050624201824.19628.qmail@...426...>
Message-ID: <Pine.LNX.4.58.0506250000270.10675@...41...>
References: <20050624201824.19628.qmail@...426...>
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
Date: Fri Jun 24 23:22:13 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: ov <ov2k@...109...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, 24 Jun 2005, ov wrote:

> * What are the values of x, y, and mod when the assertion is hit?
> 32, -1, 64

This is quite strange because these values are nominal -- they shouldn't 
have triggered the assertion.

The assertion statement says:

  ASSERT (0 <= x && x < mod && -mod <= y && y <= mod);

substitution gives:

  0 <= 32 && 32 < 64 && -64 <= -1 && -1 <= 64

which is a true statement when x, y, and mod are integers, as they are
declared to be.

For example, when I do the same test on x86 
with modulo_add instrumentation added, I see the same 32/-1/64 parameter 
set.

Fri Jun 24 23:58:21 2005 TESTING ENCRYPT/DECRYPT of packet length=97
Fri Jun 24 23:58:21 2005 modulo_add(int x=92, int y=1, int mod=100)
Fri Jun 24 23:58:21 2005 modulo_add(int x=32, int y=-1, int mod=64)
Fri Jun 24 23:58:21 2005 modulo_add(int x=93, int y=1, int mod=100)
Fri Jun 24 23:58:21 2005 modulo_add(int x=31, int y=0, int mod=64)
Fri Jun 24 23:58:21 2005 modulo_add(int x=94, int y=1, int mod=100)

Combine this with your observation that making the function inline or 
turning off -O2 optimization fixes the problem, and it's starting to smell 
like a compiler bug.

James

