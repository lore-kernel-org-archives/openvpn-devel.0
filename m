From: Simon Perreault <nomis80@...401...>
Subject: Re: [Openvpn-devel] Re: Re: Radius support (Authentification, Authorization and Accounting)
References: <200504291033.00667.ralfluebben@...68...> <d6l1bt$uln$1@...165...> <Pine.LNX.4.58.0505201030360.13685@...41...>
In-Reply-To: <Pine.LNX.4.58.0505201030360.13685@...41...>
MIME-Version: 1.0
Message-Id: <200505201342.13304.nomis80@...401...>
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
Date: Fri May 20 10:45:22 2005
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Friday 20 May 2005 12:36, James Yonan wrote:
> You can declare C function prototypes in C++ code with
>
> 	extern "C" {
> 	  include "openvpn-plugin.h"
> 	}
>
> to maintain compatibility between the C and C++ namespaces.

For more information, check out 
http://www.parashift.com/c++-faq-lite/mixing-c-and-cpp.html.

