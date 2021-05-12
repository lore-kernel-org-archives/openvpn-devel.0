References: <20210422151724.2132573-1-arne@...1227...>
 <20210510131356.968965-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <8c1983cf-712f-9341-7edd-1ac5ee639c20@...2181...>
Date: Wed, 12 May 2021 11:39:56 +0200
MIME-Version: 1.0
In-Reply-To: <20210510131356.968965-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Use exponential backoff for caching in
 tls_authentication_status
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

On 10/05/2021 15:13, Arne Schwabe wrote:
> The caching in tls_authentication_status broke the quick reaction to
> authentication status in the code paths that did not do caching like
> PUSH_REQUEST reply code path.
> 
> This patch introduces exponential backoff for the caching so we still
> retain the quick reaction while still keeping the benefit of caching.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Very simple and nice patch that removes the static caching interval and
makes it dynamic, following an exp backoff.

Logic is very simple and various latency values are hardcoded in an
array - so no need for any math.

Tests reveal that the delay introduced with the previous patch (Return
cached result in tls_authentication_status) is indeed killed.

Should the deferred auth script/plugin take a bit longer, we will see
some delay being introduced, but still very reasonable.


Acked-by: Antonio Quartulli <antonio@...515...>


Bonus: if fixes a comment and a typ0.


Regards,

-- 
Antonio Quartulli

