Subject: Re: [Openvpn-devel] Re: Patch: TAP & True MAC aging
From: Marcelo Toledo <marcelo@...461...>
In-Reply-To: <434C1293.3020609@...361...>
References: <43404D99.8080309@...361...>  <434189C7.5090304@...361...>
	 <1128369731.6952.59.camel@...399...> <4342703F.90607@...361...>
	 <1128428582.7061.18.camel@...399...>
	 <4342D092.4050502@...361...>
	 <1128619301.7000.58.camel@...399...>
	 <4346A01F.4030106@...361...>
	 <1128702738.7000.97.camel@...399...>
	 <4346ED46.4040204@...361...> <43478832.9050200@...361...>
	 <Pine.LNX.4.58.0510081447170.32321@...41...> <4348E1EF.8020906@...361...>
	 <4348FD69.6010807@...361...>  <434C1293.3020609@...361...>
Message-Id: <1131360207.22650.11.camel@...399...>
Mime-Version: 1.0
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
Date: Mon Nov  7 02:43:35 2005
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Em Ter, 2005-10-11 às 21:29 +0200, Rolf Fokkens escreveu:
> Hi,
> 
> Attached the latest version of the MAC table patch. This patch allowes 
> OpenVPN to learn (and importantly forget!) MAC addresses like ethernet 
> switches. Also (like ethernet switches), OpenVPN now broadcasts packets 
> with unknown MAC addresses (without the patch these packets are dropped).

Hello,

sorry the long delay, but we now have tested this new patch. No error
appeared but the same situation still persist. Rolf if you would like to
schedule we could talk in private to solve this problem, I can even call
you if you would like to perform tests, maybe I can try to let you work
directly in our environment. Just let me know.
-- 
Marcelo Toledo <marcelo@...461...>


