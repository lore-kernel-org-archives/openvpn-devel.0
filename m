From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] Pre-1.3.3 beta available for testing
Message-ID: <20030219195933.GA12705@...33...>
References: <20030219153803.GA32749@...33...> <Pine.LNX.4.44.0302191120220.12503-100000@...41...>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.44.0302191120220.12503-100000@...41...>
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
Date: Wed Feb 19 12:00:15 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Wed, 19 Feb 2003, James Yonan wrote:

> > Please also note that _* names are reserved name space. Don't use them
> > for your functions if you can avoid it, for portability -- they might
> > screw some linker.
> 
> Are __* names reserved?  What's the recommended form for naming "private"  
> variables (I'm coming from C++/Python where _* names are a common naming
> style for class-private variables to avoid collisions with similarly named
> public member functions)?

Mostly anything that starts with _ is reserved. There are some
exceptions, you may name auto variables _[a-z]*, but not functions.

You could use x_ as prefix though.

I've googled a little and found
http://oakroadsystems.com/tech/c-predef.htm#Groups to be a very useful
resource (and it's concise as well).

-- 
Matthias Andree

