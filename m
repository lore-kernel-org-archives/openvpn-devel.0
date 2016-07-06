From: Arne Schwabe <arne@...1227...>
References: <20160623181517.GL79504@...1296...>
	<1467149771-10374-1-git-send-email-steffan@...1856...>
Message-ID: <28eb7626-60af-e081-b97b-77caeb7106dc@...1227...>
Date: Wed, 6 Jul 2016 13:09:45 +0200
MIME-Version: 1.0
In-Reply-To: <1467149771-10374-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 5/5 v4] Add server-side support for
 cipher negotiation
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



Am 28.06.16 um 23:36 schrieb Steffan Karger:
> Pushes AES-256-GCM when a connection client advertises IV_NCP=2, and
> supports serving connections to clients with different data channel
> cipher configuration simultaneously.
>
> v2:
>  * Update manpage
>  * Add Changes.rst entry
>
> v3:
>  * Do not regenerate keys if the client sends a second pull request
>  * Don't postpone key generation if client has no IV_NCP support
>
> v4:
>  * rebase on client-side NCP v4
>
ACK from me aswell.

Arne


