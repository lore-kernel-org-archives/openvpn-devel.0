From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Pre-1.3.3 beta available for testing
In-Reply-To: <20030219153803.GA32749@...33...>
Message-ID: <Pine.LNX.4.44.0302191120220.12503-100000@...41...>
MIME-Version: 1.0
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
Date: Wed Feb 19 10:27:09 2003
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Matthias Andree <ma+ovpnd@...31...>
Cc: openvpn-devel@lists.sourceforge.net

> Please also note that _* names are reserved name space. Don't use them
> for your functions if you can avoid it, for portability -- they might
> screw some linker.

Are __* names reserved?  What's the recommended form for naming "private"  
variables (I'm coming from C++/Python where _* names are a common naming
style for class-private variables to avoid collisions with similarly named
public member functions)?

James


