Message-ID: <a3c3c24b-d9e0-4599-5050-4790e76c8790@...1227...>
Date: Tue, 29 Mar 2022 12:22:41 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220329053709.19462-1-info@...2666...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220329053709.19462-1-info@...2666...>
Subject: Re: [Openvpn-devel] [PATCH] Enable usage of TLS groups not
 identified by a NID in OpenSSL 3
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
To: Michael Baentsch <info@...2666...>, openvpn-devel@lists.sourceforge.net
Cc: Michael <57787676+baentsch@...2243...>

Am 29.03.22 um 07:37 schrieb Michael Baentsch:
> From: Michael <57787676+baentsch@...2243...>
> 
> OpenSSL3 prefers to specify groups (including EC groups) with names
> instead of NID to allow also groups provided by providers.
> This commit also removes the mapping of secp256r1 to prime256v1 for
> the OpenSSL3 code path as OpenSSL 3.0 recognises secp256r1.

Acked-By: Arne Schwabe <arne@...1227...>

