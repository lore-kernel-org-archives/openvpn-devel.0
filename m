Message-ID: <c0e4177e-93e4-05aa-aa00-00184722233b@...1227...>
Date: Mon, 1 Aug 2022 14:55:02 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <Yt2Fdvaom94pVcOQ@...2684...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <Yt2Fdvaom94pVcOQ@...2684...>
Subject: Re: [Openvpn-devel] [PATCH] PUSH_BUNDLE_SIZE is too short
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
To: Angel Abad <angel@...334...>, openvpn-devel@lists.sourceforge.net

Am 24.07.22 um 19:46 schrieb Angel Abad:
> Description: PUSH_BUNDLE_SIZE is too short
> Author: Angel Abad <angel@...334...>
> ---
> 
> Hello, we have problem with a large used openvpn server, our server push to clients
> almos 150 routes, we havent problem with windows clients, but with linux clients push
> options are cut, and the clients fail to configure beacouse the route commmands are cut.
> 
> We look code and verify that push bundle size is only 1024, so push options on linux are cut
> on this size. We looked openvpn3 too, and there this limit is 2048
> 
> https://github.com/OpenVPN/openvpn3/blob/e1a35028a82acaf5ae6caeae321d83c36477d27c/openvpn/tun/linux/client/sitnl.hpp#L50
> 
> Could you please increase this limit on openvpn2 or provide a configuration option to
> increase it?

I created a bug in Softether for this problem since I believe that this 
is what you are using: 
https://github.com/SoftEtherVPN/SoftEtherVPN/issues/1639

This should be fixed on their side instead of creating an 
incomplete/incompatible OpenVPN fix that will break after a few more 
routes anyway.

Arne

