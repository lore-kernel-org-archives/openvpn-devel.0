From: JuanJo Ciarlante <jjo-ipsec@...283...>
Subject: Re: [Openvpn-devel] OpenVPN Protocol
Message-ID: <20050902165506.C10507@...283...>
References: <loom.20050902T143928-990@...171...>
Mime-Version: 1.0
In-Reply-To: <loom.20050902T143928-990@...171...>; from gervasiobernal@...447... on Fri, Sep 02, 2005 at 12:50:30PM +0000
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
Date: Fri Sep  2 12:59:01 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Fri, Sep 02, 2005 at 12:50:30PM +0000, Gervasio Bernal wrote:
> First of all, I will explain what we are trying to develop. Basically, our idea 
> is to make OpenVPN works at kernel level, not at user level, and use the linux 
> cryptoapi instead of openssl. We will not use de /dev/net/tun (that is user 
> level space) and will create some new interfaces (something like openvpn0, 
> openvpn1, etc.).

Obviously you mean to implement the actual traffic protection,
encapsulation, etc ... keeping the session mgmt and key exchange
at user level ('ala IPSec).

FYI: they are working on this project for their college thesis under my
     direction
     
> ...
>
> Gervasio Bernal, from Mendoza - Argentina
> Pedro Deis, from Mendoza - Argentina
> 

Regards ...

-- 
--Juanjo       OpenVPN udp6/tcp6 support (including MH for ipv4/ipv6)
	       http://www.irrigacion.gov.ar/juanjo/openvpn/

#  Juan Jose Ciarlante (JuanJo PGP) jjo ;at; mendoza.gov.ar              #
#  Key fingerprint = 76 60 A5 76 FD D2 53 E3  50 C7 90 20 22 8C F1 2D    #



