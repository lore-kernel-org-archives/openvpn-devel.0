References: <20210422151724.2132573-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <446de687-7049-ca3b-66e8-bb02e3c7aeac@...2181...>
Date: Tue, 27 Apr 2021 11:54:11 +0200
MIME-Version: 1.0
In-Reply-To: <20210422151724.2132573-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/7] Move tls_select_primary_key into
 its own function
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

On 22/04/2021 17:17, Arne Schwabe wrote:
> tls_pre_encrypt mainly performs the task of selecting the primary
> encryption key but also performs other minor tasks. To allow only
> querying for the key that should be used for encryption extract this
> part of the function into its own function.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

The patch is basically isolating a portion of code in a new helper
function and then invoking it where it once was.

No functional change involved, no code change involved either (except
for removing useless parenthesis in an if condition).

All compile tests passed.
Basic connectivity tests and basic renegotiation tests passed.

Acked-by: Antonio Quartulli <antonio@...515...>

Regards,


-- 
Antonio Quartulli

