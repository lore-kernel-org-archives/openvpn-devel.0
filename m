From: Arne Schwabe <arne@...1227...>
References: <1467502488-31549-1-git-send-email-selva.nair@...277...>
	<1467732770-19110-1-git-send-email-selva.nair@...277...>
Message-ID: <e90e169a-2805-46fe-53bc-fd54217722d4@...1227...>
Date: Wed, 6 Jul 2016 10:59:54 +0200
MIME-Version: 1.0
In-Reply-To: <1467732770-19110-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Exponentially back off on repeated
 connect retries
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>, openvpn-devel@lists.sourceforge.net



Am 05.07.16 um 17:32 schrieb Selva Nair:
> - When the number of retries per remote exceeds a limit
>   (hard coded to 5), double the restart pause interval
>   for each additional retry per remote.
>
ACK from me. (Although I still would prefer a lower number like 3)

Arne


