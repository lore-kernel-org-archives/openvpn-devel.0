From: Davide Brini <dave_br@...1278...>
Date: Sat, 12 Dec 2009 23:09:45 +0000
References: <1256844344.7529.43.camel@...1272...>
	<200912121131.20556.dave_br@...1278...> <4B23ECC3.8090904@...41...>
In-Reply-To: <4B23ECC3.8090904@...41...>
MIME-Version: 1.0
Message-Id: <200912122309.45512.dave_br@...1278...>
Subject: Re: [Openvpn-devel] 2.1 rc20 and multiple interfaces problem
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Saturday 12 December 2009, James Yonan wrote:

> Using nobind on the client for UDP client connections generates a socket
> with a dynamic source port number.  This is key because it means that
> when the client reconnects, it does so with a new source port number,
> and this allows OpenVPN to detect that the initial UDP packet represents
> a new connection, and is not part of the old connection.
> 
> The problem is that when nobind is not used, the source port on the new
> connection is recycled -- it's the same as the old connection.  So when
> OpenVPN sees the connection-initiating packet, after the client switches
> over to the secondary server address, it gets confused because it
> doesn't expect sessions from a given source address to change its
> destination address mid-session.

Quite subtle, but makes sense indeed. 
If I can make a suggestion, I'd add a note in the documentation about this 
particular interaction between the use of "multihome" on the server and not 
using "nobind" on the client (though it should be rare to see clients without 
"nobind", agreed), so other people won't be puzzled as I was when trying to 
debug it.

Thanks again!

-- 
D.

