References: <D361D4D8184C40E2A8E222238EA0BE35@...2089...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <8170c580-8303-08e3-ca4c-be1aa85b64fc@...1227...>
Date: Tue, 29 Dec 2015 13:36:40 +0100
MIME-Version: 1.0
In-Reply-To: <D361D4D8184C40E2A8E222238EA0BE35@...2089...>
Subject: Re: [Openvpn-devel] man openvpn(8): --block-outside-dns
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
To: debbie10t@...277..., openvpn-devel@lists.sourceforge.net

On 29.12.2015 13:31, debbie10t@...277... wrote:
> Is this considered to be sufficient documentation:
>
> https://community.openvpn.net/openvpn/wiki/Openvpn23ManPage
>
> --block-outside-dns
>
> Block DNS servers on other network adapters to prevent DNS leaks. This 
> option prevents any application from accessing TCP or UDP port 53 except one 
> inside the tunnel. It uses Windows Filtering Platform (WFP) and works on 
> Windows Vista or later.
>
> --block-outside-dns is not an openvpn directive ... it cannot be used in a 
> config file as such.
At least as I understood it, it is.

Arne

