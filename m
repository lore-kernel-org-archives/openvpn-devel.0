From: Arne Schwabe <arne@...1227...>
References: <20210418160111.1494779-1-arne@...1227...>
Message-ID: <49328264-ea4b-c9fe-ede4-7f7d18c101dc@...1227...>
Date: Sun, 18 Apr 2021 18:03:35 +0200
MIME-Version: 1.0
In-Reply-To: <20210418160111.1494779-1-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v3] Move context_auth from context_2 to
 tls_multi and name it multi_state
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
To: openvpn-devel@lists.sourceforge.net

Am 18.04.21 um 18:01 schrieb Arne Schwabe:
> context_2 and tls_multi have the same life cycle for TLS connections
> but so this move does not affect behaviour of the variable.
> 
> OpenVPN TLS multi code has a grown a lot more complex and code that
> handles multi objects needs to know the state that the object is in.
> Since not all code has access to the context_2 struct, the code that
> does not have access is often not checking the state directly but
> checks other parts of multi that have been affected from a state
> change.
> 
> This patch also renames it to multi_state as this variable represents t
> he multi state machine status rather than just the state of the connect
> authentication (more upcoming patches will move other states
> into this variable).
> 
> Patch V2: also rename context_auth to multi_state, explain a bit why this
>           change is done.

Patch V3: Add comments for c2->multi NULL check forwarding. Fix compile
 with ENABLE_ASYNC_PUSH.

Arne


