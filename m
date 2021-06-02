References: <20210602034253.19984-1-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <60d34cf1-ed54-8125-1209-a003aa778c7b@...1227...>
Date: Wed, 2 Jun 2021 13:59:12 +0200
MIME-Version: 1.0
In-Reply-To: <20210602034253.19984-1-selva.nair@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 0/2] AUTH_PENDING docs and related
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
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

Am 02.06.21 um 05:42 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> I couldn't figure out the details of how to use CR_TEXT or OPEN_URL
> from the docs. This is an attempt to improve the documentation based
> on my reading of the sources and some guess-work.
> 
> I might have edited somethings wrongly. If so, please correct.
> 
> Also found a minor parsing bug that will trigger only if the
> client announces more than two keywords in IV_SSO.
> 
> Question: is the IV_SSO the keyword for PROXY_URL named proxy_url
> or proxyurl or url_proxy? I would ahve guessed "proxyurl" based on
> crtext and openurl but have settled for proxy_url. If there is
> no established convention as yet, I suggest proxyurl without
> the _.

So far proxyurl openurl_proxy or whatever we call it has not yet
implemented anywhere yet. So we can still change the name.

Arne

