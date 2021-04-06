References: <20210406162518.4075-1-arne@...1227...>
 <20210406162518.4075-4-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <28be4d13-d0a3-c2e7-8ada-0ca6d4b8be39@...2181...>
Date: Tue, 6 Apr 2021 23:10:22 +0200
MIME-Version: 1.0
In-Reply-To: <20210406162518.4075-4-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 4/5] Use EVP_CTRL_AEAD_* instead
 EVP_CTRL_GCM_*
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

On 06/04/2021 18:25, Arne Schwabe wrote:
> Use the modern names instead of the old GCM specific ones. AEAD instead
> GCM makes especially sense when using Chacha20-Poly1305.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

This looks good and does not trigger issues on my build rig.
The manpage also suggests using *AEAD* constants.

Glad we can keep all the ugliness in openssl_compat.h....

Acked-by: Antonio Quartulli <antonio@...515...>


-- 
Antonio Quartulli

