From: Arne Schwabe <arne@...1227...>
References: <20210716121848.67888-1-arne@...1227...>
Message-ID: <f3737e73-f68b-85a1-9bc8-97cf706d0024@...1227...>
Date: Fri, 16 Jul 2021 14:33:46 +0200
MIME-Version: 1.0
In-Reply-To: <20210716121848.67888-1-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Introduce webauth auth pending method
 and deprecate openurl
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
To: openvpn-devel@lists.sourceforge.net

Am 16.07.21 um 14:18 schrieb Arne Schwabe:
> The experience with openurl/OPEN_URL has shown that just sending
> a URL to a client is not enough and we often need different
> behaviour of the client depending on circumstances. Replace
> OPEN_URL with a more flexible WEBAUTH pending auth method.

Just as FYI this is more of an RFC to give other people an early
opportunity to object/remark or request changes to the protocol as we
are going to implement this very soon this way if no objections are raised.

Arne

