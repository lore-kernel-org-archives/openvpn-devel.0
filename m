References: <1b0416f4-f929-f4a6-17de-41848bdff601@...515...>
 <20190917121039.13791-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <d27959e1-8b2d-b3d5-a683-3002317642f6@...2080...>
Date: Sat, 28 Sep 2019 00:30:19 +0200
MIME-Version: 1.0
In-Reply-To: <20190917121039.13791-1-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v7 5/7] Implement a permanent session id
 in auth-token
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Cc: Arne Schwabe <arne@...515...>

On 17/09/2019 14:10, Arne Schwabe wrote:
> From: Arne Schwabe <arne@...515...>
> 
> This allows an external authentication method
> (e.g. management interface) to track the connection and distinguish a
> reconnection from multiple connections.
> 
> Addtionally this now also checks to workaround a problem with
> OpenVPN 3 core that sometimes uses a username hint from the config
> instead of using an empty username if the token would be valid
> with an empty username. Accepting such token can be only done
> explicitly when the external-auth keyword to auth-gen-token is present.
> 
> Patch V2: Add Empty variants to work around behaviour in openvpn 3
> Patch V3: document the behaviour of external-auth better in the man page,
>           rename 'auth' parameter to 'external-auth'
> Patch V4: Rebase on current master
> Patch V6: Fix tls_lock_username rejecting clients with empty username
>           when explicitly accepting them with external-auth
> Patch V7: Fix compiling with disable-server
> ---
>  doc/openvpn.8            |  37 +++++++++-
>  src/openvpn/auth_token.c | 156 ++++++++++++++++++++++++++++++++++++---
>  src/openvpn/auth_token.h |  15 +++-
>  src/openvpn/init.c       |   1 +
>  src/openvpn/manage.c     |   4 +-
>  src/openvpn/options.c    |  14 +++-
>  src/openvpn/options.h    |   4 +-
>  src/openvpn/ssl_common.h |  10 ++-
>  src/openvpn/ssl_verify.c |  70 ++++++++++++------
>  9 files changed, 270 insertions(+), 41 deletions(-)
This patch works ... but there are some comments which got ignored from the
previous patch review.  I will send a patch for this, as this is mostly
documentation errors, not code errors.

So, I'll approve this now; these patches needs to be completed now.

Acked-By: David Sommerseth <davids@...515...>


-- 
kind regards,

David Sommerseth
OpenVPN Inc


