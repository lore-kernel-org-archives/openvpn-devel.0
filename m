References: <20210408140229.31824-1-arne@...1227...>
 <20210408140229.31824-3-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <69386b79-eb17-bde1-0402-d04ffe786813@...2181...>
Date: Thu, 22 Apr 2021 01:38:36 +0200
MIME-Version: 1.0
In-Reply-To: <20210408140229.31824-3-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 2/3] Remove --ncp-disable option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 08/04/2021 16:02, Arne Schwabe wrote:
> NCP has proven to be stable and apart from the one VPN Provider doing
> hacky things with homebrewed NCP we have not had any reports about
> ncp-disable being required. Remove ncp-disable to simplify code paths.
> 
> Note: This patch breaks client without --pull. The follow up patch
> for P2P NCP will restore that. But to avoid all the NCP/non-NCP special
> cases to be implemented in P2P. P2P will directly switch from always
> non-NCP to always NCP.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

The patch looks good to me and passes my basic connectivity tests.
Also I got no compile-time complain from any platform I could build on.

However, there is a comment that still talk about NCP being
disabled/enabled. I think it should be changed too as we don't have the
two cases anymore (the if-condition below is modified by this patch):

src/openvpn/init.c:2726:        * as NCP-fallback or when NCP has been
disabled or explicitly


Cheers,


-- 
Antonio Quartulli

