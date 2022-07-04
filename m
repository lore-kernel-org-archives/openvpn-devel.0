Message-ID: <0f37a675-519a-8223-70c1-23c1ef477347@...1227...>
Date: Mon, 4 Jul 2022 11:50:25 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220704025840.2558-1-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220704025840.2558-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Fix auth-token usage with
 management-def-auth
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
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

Am 04.07.22 um 04:58 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> When auth-token verify succeeds during a reauth, other auth
> methods (plugin, script, management) are skipped unless
> external-auth is in effect (skip_auth gets set to true).
> 
> However, in this case, the status of management-def-auth
> (ks->mda_satus) stays at its default value of ACF_PENDING

ks->mda_status

> and will never change. This causes TLS keys to go out of sync
> and an eventual client disconnect.
> 
> Further, a message saying username/password authentication is
> "deferred" gets logged which is misleading.
> For example:
> 
> test/127.0.0.1:35874 TLS: Username/auth-token authentication
>      succeeded for username 'test'
> 
> followed by
> 
> test/127.0.0.1:35874 TLS: Username/Password authentication
>      deferred for username 'test' [CN SET]
> 
> Fix by setting ks->mda_status to ACF_DISABLED, and do not
> set ks->authenticated = KS_AUTH_DEFERRED when skip_auth is true.
> 
> Also log a warning message when token is marked as expired on
> missing the reneg window.
> 
> Reported by: Connor Edwards <connor.edwards@...2680...>
> 

Acked-By: Arne Schwabe <arne@...1227...>

Note that you need have management enabled for this bug to trigger. If 
you go through all the effort to talk to management like this, you 
probably want to use external-auth anyway.

Basically currently AS is the only management+server mode application 
that active developer use, bugs like this tend to slip.

Arne

