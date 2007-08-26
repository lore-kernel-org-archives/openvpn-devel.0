From: "Dave" <dev@...575...>
Date: Sun, 26 Aug 2007 16:18:47 -0500
Message-ID: <000001c7e826$b169f120$16ada8c0@...576...>
MIME-Version: 1.0
In-Reply-To: <46D12F4B.5010801@...277...>
Subject: Re: [Openvpn-devel] |PATCH] OpenVPN / OCSP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Davy Melina' <davy.melina@...277...>, openvpn-devel@lists.sourceforge.net

..
> 
> I wrote a patch for adding  the support of OCSP in OpenVPN.
> So OpenVPN can check the status of the client certificate during the 
> session.
> 
> This patch is available for OpenVPN 2.0 branch and Openvpn 
> 2.1 branch, and you can find any informations and documentation here:
> 
> http://www.block64.net
> 
...

Cool, I like it; if anyone is using OpenWRT and wants to try it out I made
an ipkg file with this patch applied at:

http://ovpnppc.ziggurat29.com/files/openvpn_2.1_rc4-1_mipsel.ipk

Now I have to find an ocsp daemon....

-Dave


