From: Heiko Hund <heiko.hund@...1489...>
Date: Tue, 17 Jul 2012 17:15:21 +0200
Message-ID: <2989627.j049xi4nqB@...1526...>
In-Reply-To: <CAOazyz1eUXu-a=k9q+AvbD25swq=iBD7Okc18jBp0gZeRxojkA@...278...>
References: <1342533472-30873-1-git-send-email-heiko.hund@...1489...>
	<21316332.O9di4uRdZn@...1526...>
	<CAOazyz1eUXu-a=k9q+AvbD25swq=iBD7Okc18jBp0gZeRxojkA@...278...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] don't treat socket related errors
	special anymore
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On Tuesday 17 July 2012 18:11:25 Alon Bar-Lev wrote:
> #define EWOULDBLOCK WSAWOULDBLOCK

EWOULDBLOCK is already defined in errno.h (also in Windows) and shouldn't be 
redefined in my opinion.

Heiko
-- 
Heiko Hund | Sr. Software Engineer | Tel +49-721-25516-237 | Fax -200
SOPHOS NSG | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germany


