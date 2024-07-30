Message-ID: <92049e63-217f-4122-b84a-401d0f7c214a@...1227...>
Date: Wed, 31 Jul 2024 00:59:48 +0200
MIME-Version: 1.0
References: <20240730170021.1101321-1-storehouse@...2805...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20240730170021.1101321-1-storehouse@...2805...>
Subject: Re: [Openvpn-devel] [PATCH] examples: Switched to ed25519,
 nodes -> noenc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Eric Toombs <storehouse@...2805...>, openvpn-devel@lists.sourceforge.net


Am 30.07.2024 um 19:00 schrieb Eric Toombs via Openvpn-devel:
> From: Eric Toombs <not@...2806...>
We prefer real email addresses in our commits.
>
> I switched the curve to ed25519, a generally more trustworthy curve and the default in openssh.
> As a bonus, it *really* simplifies what is already a complicated command.
> The old command wouldn't even run in all shells because it used process substitution.
>
> 'nodes' is deprecated in favour of 'noenc', so I switched that too.

While ed25519 might have its advantages, its usage in X509 certificates 
is really really uncommon. I have seen more brainpoool usages in the 
wild than ed25519. It is also not allowed on hosts that use FIPS 
settings and also older OpenVPN clients/OpenSSL clients might not 
support it. Also in contrast to secp384r1, I know absolutely no secure 
certficate store that supports it (Android Keystore, YubiKey and so on 
all support secp384r1 but there is no ed25519 support).  So I don't 
think we are at the point where we want to recommend in an easy-to-setup 
guide a group/curve that is a lot less supported to the basically 
universially supported secp384r1.

So for the purpose of this guide, I think secp384r1 is a much better 
choice compared to ed25519.

Arne


