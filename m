References: <20201215164221.5995-1-arne@...1227...>
 <20210328120241.27605-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <815fbe05-8734-75d6-bbe6-4b64ea08f1f2@...2181...>
Date: Sat, 3 Apr 2021 14:02:49 +0200
MIME-Version: 1.0
In-Reply-To: <20210328120241.27605-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 1/2] Move context_auth from context_2
 to tls_multi and name it multi_state
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

On 28/03/2021 14:02, Arne Schwabe wrote:
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

Thanks a lot. Much better now!

> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

As explained in the commit message, this patch is really just a field
move and it's expected to not change any behaviour. On top of that it is
being moved between two objects sharing the same lifecycle.

Basic tests pass.
Compiled tested against my usual SSL libs zoo.

Acked-by: Antonio Quartulli <antonio@...515...>


-- 
Antonio Quartulli

