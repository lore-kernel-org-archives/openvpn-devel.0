Message-ID: <434C1293.3020609@...361...>
From: Rolf Fokkens <r.fokkens@...361...>
MIME-Version: 1.0
References: <43404D99.8080309@...361...>  <434189C7.5090304@...361...>  <1128369731.6952.59.camel@...399...> <4342703F.90607@...361...>  <1128428582.7061.18.camel@...399...>  <4342D092.4050502@...361...>  <1128619301.7000.58.camel@...399...>  <4346A01F.4030106@...361...> <1128702738.7000.97.camel@...399...> <4346ED46.4040204@...361...> <43478832.9050200@...361...> <Pine.LNX.4.58.0510081447170.32321@...41...> <4348E1EF.8020906@...361...> <4348FD69.6010807@...361...>
In-Reply-To: <4348FD69.6010807@...361...>
Subject: [Openvpn-devel] Re: Patch: TAP & True MAC aging
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
Date: Tue Oct 11 12:31:09 2005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

Hi,

Attached the latest version of the MAC table patch. This patch allowes 
OpenVPN to learn (and importantly forget!) MAC addresses like ethernet 
switches. Also (like ethernet switches), OpenVPN now broadcasts packets 
with unknown MAC addresses (without the patch these packets are dropped).

The command line has two new options:

--mac-ttl n             : Time To Live for MAC entries (default: 300)
--mac-table-size n : The number of MAC entries that can be stored 
(default: 1024)

The Admin interface command now shows the TTL (Time To Live) of each 
learnt packet, this is for debugging purposes. It may however conflict 
with adminfrontends!

This patch is work in progess, so testing is needed. I've tested it with 
UDP and TCP using certificates. I'm using it now in our production 
situation. Special testing however is needed for shared keys, as I 
received a report which suggests this may not work.

For those who are interrested, the patch can be downloaded here: 
http://adsl-dc-4dd05.adsl.wanadoo.nl/dinges/openvpn-2.0.2-fks-mac7.patch

Rolf


