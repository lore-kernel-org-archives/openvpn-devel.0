From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] openvpn using matrixssl ?
In-Reply-To: <000801c494c3$cb6ae390$0e00a8c0@...267...>
Message-ID: <Pine.LNX.4.58.0409080858260.28179@...269...>
References: <000801c494c3$cb6ae390$0e00a8c0@...267...>
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
Date: Wed Sep  8 08:03:29 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: gary <linux@...266...>
Cc: openvpn-devel@lists.sourceforge.net


On Tue, 7 Sep 2004, gary wrote:

> Hi,
> 
> Anyone knows how feasible it is to use matrixssl instead of openssl ?
> The main advantage is memory footprint for embedded system like the
> linksys wrt54g.

It's possible, but development would be required.

To the extent that the matrixssl API differs from the OpenSSL API, OpenVPN
would need to be "ported" to matrixssl.

James


