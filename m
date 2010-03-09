Message-ID: <20100309064736.18556.qmail@...1287...>
Date: Tue, 9 Mar 2010 07:47:36 +0100
From: Peter Stuge <peter@...1287...>
References: <jwvsk8aif6m.fsf-monnier+inbox@...1269...> <1268097644.11342.2@...1207...>
MIME-Version: 1.0
In-Reply-To: <1268097644.11342.2@...1207...>
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
> The boot order that makes sense to me is:
> 
> bring the interfaces up
> start dhcp client (if not triggered directly from the interfaces)
> start openvpn
> 
> The problem is that if the dhcp client is started before openvpn
> and openvpn is creating the tap interface then it's too late

At least some distributions work more like this:

foreach interface:
  set link up
  possibly start openvpn
  address add


//Peter

