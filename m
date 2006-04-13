Message-ID: <443EB8B6.1010305@...41...>
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Default route metric
References: <200604072035.49898.uberlord@...594...>
In-Reply-To: <200604072035.49898.uberlord@...594...>
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
Date: Thu Apr 13 13:47:12 2006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Roy Marples <uberlord@...594...>
Cc: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

Roy Marples wrote:
> Hi
>
> Using route metrics is a great way to get around default route issues whilst 
> preserving the original routes. Attached are patches to 2.0 and 2.1_beta12 
> that allow a default metric to be applied to all routes.
>
> IMO, this is a better option than redirecting the local route.
>   
Roy,

Thanks for the patches -- I will be merging this one and the link layer 
patch in 2.1.

The route interface association patch is good, but I think it needs to 
be off unless explicitly enabled (see previous email).

James


