Message-ID: <20100309173030.20202.qmail@...1287...>
Date: Tue, 9 Mar 2010 18:30:30 +0100
From: Peter Stuge <peter@...1287...>
References: <4B967465.3070909@...1114...> <1268152860.24740.8@...1207...>
MIME-Version: 1.0
In-Reply-To: <1268152860.24740.8@...1207...>
Subject: Re: [Openvpn-devel] Supporting "route-gateway dhcp" on non-Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Karl O. Pinc wrote:
> I'm not at all sure it solves the core issues, which is that
> an already running dhcp client won't have auto-detected
> the tap interface that OpenVPN creates -- iff OpenVPN is 
> started after the dhcp client.

Note that several DHCP clients only handle one interface per DHCP
client process..


//Peter

