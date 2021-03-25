References: <20210325000121.10331-1-arne@...1227...>
 <214c73d3-e650-8766-b97d-fb14c5367673@...68...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <7d61106d-8c69-e67c-cdc2-f69165813f90@...2181...>
Date: Thu, 25 Mar 2021 20:57:33 +0100
MIME-Version: 1.0
In-Reply-To: <214c73d3-e650-8766-b97d-fb14c5367673@...68...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/2] Deprecate non TLS mode in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Matthias Andree <matthias.andree@...68...>, openvpn-devel@lists.sourceforge.net

Hi,

On 25/03/2021 20:29, Matthias Andree wrote:
> I find the reasons you present to withdraw the symmetric non-TLS mode
> too weak to justify its deprecation or removal. Yes, TLS-based
> configurations may be more feature-rich, but those are not mandatory and
> we should not paternalize the users here. Is there a considerable
> technical debt to keeping the --secret option?  WireGuard seems to be
> becoming quite popular and it provides low-ceremony setups - just as
> openvpn --secret does. 
> 

The new --peer-fingerprint option offers a similar "quick setup" feature
that old users of --secret may want to switch to.

> And to make a blunt point, it's not useless just because it's old, else
> we should nuke DNS and SMTP.

It's not about being old. It's about being insecure.

With --secret (i.e. PSK encryption) there is no key renegotiation/rotation.
This means IVs will be eventually re-used, which translates to
encryption losing part of its strength.

This is unacceptable and users should be prevented from hitting this
situation.

Regards,

-- 
Antonio Quartulli

