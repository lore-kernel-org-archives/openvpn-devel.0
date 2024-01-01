Message-ID: <cc4a5e26-78ae-45f6-a603-9291353b97fc@...1227...>
Date: Mon, 1 Jan 2024 14:50:41 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20240101094054.38869-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20240101094054.38869-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] OpenBSD: repair --show-gateway
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 01.01.24 um 10:40 schrieb Gert Doering:
> OpenBSD route sockets do not want to be passed RTA_IFP on RTM_GET
> - if we do this, we get back EINVAL.
> 
> On other platforms, if we do not request RTA_IFP, we will not get
> back interface information for queried routes - on OpenBSD, RTA_IFP
> comes back always...
> 
> So we need to #ifdef this, RTA_IFP on all platforms except OpenBSD.
> 
> (Found this fix in OpenBSD's ports tree, in their patches for OpenVPN
> 2.6.8 - but they just remove RTA_IFP, no #ifdef, so we can't just apply
> their patch)
> 
> While at it, add M_ERRNO to the "write to routing socket" error message.

Acked-By: Arne Schwabe <arne@...1227...>


