From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] LZO 2.0
In-Reply-To: <20050615150556.GA11479@...33...>
Message-ID: <Pine.LNX.4.58.0506151033530.4004@...41...>
References: <loom.20050615T113921-759@...171...>
 <20050615150556.GA11479@...33...>
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
Date: Wed Jun 15 09:55:51 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Matthias Andree <ma+ovpnd@...31...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 15 Jun 2005, Matthias Andree wrote:

> On Wed, 15 Jun 2005, Hampus wrote:
> 
> > I was just wondering if anyone has been able to build openvpn 2.0 when using 
> > LZO 2.0 ? I myself get some strange errors.

> A patch with additional build instructions was posted a few days ago.
> Check the archives of this list.

I just made a new RC with LZO 2.0 support.  The configure script will
autodetect LZO 1.x or 2.0 and set appropriate #defines so that the OpenVPN
C code will know where to find the LZO .h files (this is necessary because
LZO 2.0 moves the .h files to a new directory).  I also raised the worst
case expansion function per the new guidelines.  As far as I'm aware,
there should be no interoperability issues with OpenVPN linked with LZO
1.08 talking with OpenVPN linked with LZO 2.0.

Download:

http://openvpn.net/beta/openvpn-2.0.1_rc4.tar.gz

James


