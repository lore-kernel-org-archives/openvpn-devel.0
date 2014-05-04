Message-ID: <53661960.9080704@...1856...>
Date: Sun, 04 May 2014 12:41:36 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <20140424163216.GA4403@...1907...>
In-Reply-To: <20140424163216.GA4403@...1907...>
Subject: Re: [Openvpn-devel] [PATCH] Keying Material Exporters [RFC 5705]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi Daniel,

Sorry for the delay, I've finally found some spare time to dig a bit
into your patch. I've not looked at the implementation details yet, just
the big picture for now.

First of all, I can see exported key material being useful. As a matter
of fact, OpenVPN does something similar to derive its data channel keys.

On 24-04-14 18:32, Daniel Kubec wrote:
> updated patch:
> 
> git format-patch -n HEAD^ --stdout > ./openvpn-channel-bindings.patch

It's probably easier if you create commits while doing work, and then
use 'git format-patch origin/master' or 'git format-patch HEAD~n' (with
n your number of commits). That generates patch files including your
commit message, and are easy to apply using 'git am'.

Also, your patch does a number of things to achieve you goal; abstract
some functions, add plugin calls, and do the actual export. Patches are
more easily reviewed if those separate steps are separated into several
commits (with each having a clear commit message describing the goal and
the changes of the commit).

> vpn_binding_key: 
>   - keying material derived by openvpn's crypto later (ssl.c:tls1_*)
>   - life time across negotiations (works a bit like EKM)
> 
> tls_binding_key: Exported Keying Material [RFC 5705] 
>   - derived when crypto backend support ( currently openssl >= 1.0.2 )

I'm not sure we should do the vpn_binding_key part, because:
1) I believe we should leave the crypto to the crypto libraries as much
as possible. From this perspective I'd vote for just calling
SSL_export_keying_material() if it's available (which according tot the
OpenSSL ChangeLog / git tree is since 1.0.1, not 1.0.2). PolarSSL does
not support EKM yet, so our PolarSSL builds just won't support it
either. Just put that into the manpage, and we can add it when(/if)
PolarSSL adds support too.
2) I think the exported keying material should *not* survive
negotiations; negotiations by design force the endpoints to authenticate
again, which should also be the case when using EKM.
3) As a positive side effect, the patch will add a lot less code to
OpenVPN if vpn_binding_key is not added.

The new code calls the OPENVPN_PLUGIN_TLS_FINAL plugin twice (also from
key_method_2_write() now), why is that? And (partly as a question to our
plugin meister David), will that not break stuff for current plugin
interface consumers?

Once the big picture is clear, I'll have to look more carefully at the
implementation details.

-Steffan

