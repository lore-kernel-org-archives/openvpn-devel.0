References: <20160623181916.GM79504@...1296...>
	<1467149700-10042-1-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <fb52831f-58d0-2c29-73cb-5ecbe7438a9b@...1227...>
Date: Wed, 6 Jul 2016 11:53:09 +0200
MIME-Version: 1.0
In-Reply-To: <1467149700-10042-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 4/5 v4] Add options to restrict cipher
 negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net



Am 28.06.16 um 23:35 schrieb Steffan Karger:
> Add --ncp-disable to completely disable cipher negotiation, and
> --ncp-ciphers to specify which ciphers to accept from the server.
>
> v2:
>  * fix --disable-crypto builds
>  * use register_signal() instead of operating directly on c->sig
>  * add man-page entry for new options
>
> v3:
>  * rebased on client-side NCP v3
>
> v4:
>  * rebased on client-side NCP v4
>
>
After going through iterations I also have no more comments and this
gets an ACK from me.

Arne

