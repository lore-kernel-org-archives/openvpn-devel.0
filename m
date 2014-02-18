From: Heiko Hund <heiko.hund@...1489...>
Date: Tue, 18 Feb 2014 15:11:29 +0100
Message-ID: <1959796.tNIKqpFhcQ@...1526...>
In-Reply-To: <530259CD.4030104@...1227...>
References: <1391000624-15092-1-git-send-email-heiko.hund@...1489...>
	<530259CD.4030104@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] grow route lists dynamically
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi Arne

On Monday 17 February 2014 19:49:49 Arne Schwabe wrote:
> ACK but with two changes
> 
> - adding a comment to the copy method that this does a shallow copy with
> two lists with the same tail
> - struct route* next should be struct route_ipv4 *next in the route_ipv4
> struct.

Thanks for the review. I will post an updated patch.

Heiko

