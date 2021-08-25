References: <20210825040122.14244-1-selva.nair@...277...>
 <87212698-ffd0-3178-8b46-d3f088092eb8@...1227...>
 <CAKuzo_jZBzEpM2kbrYsui-5KDf_cv3Xjeapoa7CY+7PpFT+1Bg@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <c5aa30e6-a5f7-4ba5-1a1c-5fa980a4732b@...1227...>
Date: Wed, 25 Aug 2021 20:20:05 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jZBzEpM2kbrYsui-5KDf_cv3Xjeapoa7CY+7PpFT+1Bg@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 1/2] Add remote-count and remote-entry
 query via management
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
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> 
> 
> Actually this else could be possibly eliminated as, in this case, the
> callback is not conditionally compiled in. Unlike things like pkcs11-id
> support. Will check and simplify.

I think in client vs server mode the management interface is still
different enough that many of these are actually needed.

Arne

