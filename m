References: <20210904095629.6273-1-a@...2181...>
 <20210904095629.6273-5-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <beb7acf4-e82c-57f9-12de-527b9dc007ce@...1227...>
Date: Mon, 6 Sep 2021 15:22:01 +0200
MIME-Version: 1.0
In-Reply-To: <20210904095629.6273-5-a@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 4/7] do not include --cipher value in
 data-ciphers
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Am 04.09.21 um 11:56 schrieb Antonio Quartulli:
> The --cipher option has been there since a while, but it became more and
> more confusing since the introduction of NCP (data cipher negotiation).
> 
> The fallback cipher can now be specified via --data-cipher-fallback,
> while the list of accepted ciphers is specified via --data-ciphers.
> 
> --cipher can still be used for compatibility reasons, but won't affect
> the cipher negotiation.
> 

Acked-By: Arne Schwabe <arne@...1227...>


