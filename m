Message-ID: <9e0cf0bf0812271015q1bfcf453j8dd94f216945ad2e@...278...>
Date: Sat, 27 Dec 2008 20:15:50 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <4956551D.7030700@...1148...>
MIME-Version: 1.0
References: <48F11865.5080903@...1135...> <491F4441.7080109@...1148...>
	<495628C0.7060405@...1135...>
	<9e0cf0bf0812270738s2a248adcx6967116ee58e1edd@...278...>
	<4956551D.7030700@...1148...>
Subject: Re: [Openvpn-devel] Alternative GUI for OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Morten Christensen <mc-openvpn@...1148...>
Cc: openvpn-devel@lists.sourceforge.net

On 12/27/08, Morten Christensen <mc-openvpn@...1148...> wrote:
>  Auth-user-pass requires, that we enter both username and password each
>  time we start a connection. When we know that the username is on the
>  system in the CN-field of the certificate, it will be nice not to be
>  forced to enter it on every connection.

So you actually wish the client to set up the username automatically
based on the CN.
It looks simple enough, can you prepare a patch?

Alon.

