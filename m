Message-ID: <50B9F518.2020606@...1227...>
Date: Sat, 01 Dec 2012 13:16:24 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1354303076-13606-1-git-send-email-arne@...1227...>
	<1354303076-13606-10-git-send-email-arne@...1227...>
In-Reply-To: <1354303076-13606-10-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 10/10] Implement dual stack client
 support for OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 30.11.2012 20:17, Arne Schwabe wrote:
> Change meaning from udp and tcp to allow both IPv4 and IPv6. Introducue new udp4 and tcp4 to force IPv4.
The tcp4 and tcp6 should only temporary. I will later follow up with a 
patch which cleans up the protocol names and options. But I did not want 
this patch to get even bigger.

Arne

