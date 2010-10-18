Message-ID: <4CBC7852.5080903@...1227...>
Date: Mon, 18 Oct 2010 18:39:46 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <4CBC6CD4.7000103@...1418...>
In-Reply-To: <4CBC6CD4.7000103@...1418...>
Subject: Re: [Openvpn-devel] Errors adding routes on Windows 7 with OpenVPN
 2.1.3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Christian Rank <christian.rank@...1418...>
Cc: openvpn-devel@lists.sourceforge.net

Am 18.10.10 17:50, schrieb Christian Rank:
> Hello,
>
> we noticed a strange problem with OpenVPN 2.1.3 on a Windows 7 client
> here: The VPN tunnel to an OpenVPN server does no longer work since the
> OpenVPN 2.1.3 software tries to insert many strange routes into the
> Windows 7 routing tables. With OpenVPN 2.1.1, all goes well. Our OpenVPN
> server is running on OpenVPN 2.1_rc15 i686-pc-linux-gnu.
>
> I have attached the Windows OpenVPN log file (with verbosity 4).
>
> Maybe this is a bug in the Windows implementation of OpenVPN 2.1.3?
>
Without looking through your log, we had similar problems and adding the
def1 option fixed it for us.

Arne

