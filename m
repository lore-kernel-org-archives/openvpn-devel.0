From: Denis Vlasenko <vda@...216...>
Subject: Re: [Openvpn-devel] OpenVPN 2.0 Yo-Yo effect...
References: <40C1BE37.9030606@...199...> <200406052100.34514.vda@...216...> <40C214EF.9010403@...199...>
In-Reply-To: <40C214EF.9010403@...199...>
MIME-Version: 1.0
Message-Id: <200406052152.45137.vda@...216...>
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
Date: Sat Jun  5 11:56:03 2004
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Mike Auty <m.auty@...199...>
Cc: openvpn-devel@lists.sourceforge.net

On Saturday 05 June 2004 21:46, Mike Auty wrote:
> Thanks for the super fast reply,
> 	Sadly I don't have the facilities to build a new windows version.
> Would you mind exaplaining briefly what it does?  It only seems to
> change the order of two checks, but I'm not sure what they do.  Thank
> again, Mike  5:)

If there happens to be a packet to send when openvpn checks whether
it needs to send a ping, openvps erroneously decide to set ping
interval timeout to 365 days.
--
vda


