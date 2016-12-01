References: <1480545687-19365-1-git-send-email-davids@...515...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <a2f41141-898c-d317-0481-3ce6ce6a9082@...1227...>
Date: Thu, 1 Dec 2016 13:31:31 +0100
MIME-Version: 1.0
In-Reply-To: <1480545687-19365-1-git-send-email-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] push: Provide a warning if
 --ifconfig-push have argument mismatch with --topology
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
To: David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net



Am 30.11.16 um 23:41 schrieb David Sommerseth:
> This adds a warning to the log file if --topology is configured to use
> subnet or net30 and the 'subnet mask' argument of an --ifconfig-push option
> is not an subnet mask.  The check done is to ensure the first octet is 0xff (255)
>
>
But way you actually want to test is

if topology == subnet or net30:
   if gateway not in net(ip, mask):
      print ("Your gw and ip and netmask disagree!)

right? And isn't there code that gets executed for the client side that
can be disabled by ifconfig-nowarn. Can we reuse that code?

Arne

