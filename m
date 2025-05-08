Message-ID: <5738dcfa-3fbc-484c-9e32-d125368d6433@...1227...>
Date: Thu, 8 May 2025 13:46:56 +0200
MIME-Version: 1.0
References: <20250421214434.83431-1-klemens@...2010...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20250421214434.83431-1-klemens@...2010...>
Subject: Re: [Openvpn-devel] [SPAM] [PATCH 1/1] Accept "issuer" in
 `x509-username-field` for the peer certificate's issuer name
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
To: Klemens Nanni <klemens@...2010...>, openvpn-devel@lists.sourceforge.net

Am 21.04.25 um 23:44 schrieb Klemens Nanni:
> This allows for accepting clients based on their certificate authority:
> 	x509-username-field issuer CN
> 	verify-x509-name    ...CA=ExampleCA_ match-prefix
> 
> `tls-verify` or `plugin` can do the equivalent, but require additional code
> execution and always incur overhead or may not be an option when running with
> reduced privileges, e.g. `chroot`

I am trying to understand the use case for this patch. Issuer is only 
something you can trust and verify if you verified the fingerprint of 
the certificate or that the certificate is issued by a given CA. But if 
it is already verified to belong to a trusted CA, then you don't need 
issuer CN anymore.

I would also be good to try to add a unit test. Since is is probably a 
quite exotic use case, this will not be tested regularly and as such is 
in danger to be become broken and since this an auth related option that 
might then be an authentication bypass. We really want to avoid that.

Arne

