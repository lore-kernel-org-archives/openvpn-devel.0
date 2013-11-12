MIME-Version: 1.0
In-Reply-To: <52823246.6010200@...1147...>
References: <1384208842-25700-1-git-send-email-alon.barlev@...277...>
	<CAOazyz1kEYtJ8gkjGZjrB67gjKGXGzFLoegrbZc-KcJnv49LvA@...278...>
	<528212DC.5060908@...1147...>
	<CAOazyz0m+QWSgvGyVb3CJnp+DY0NVoGNL0ZGPjFFWsWzBPo25Q@...278...>
	<52823246.6010200@...1147...>
Date: Tue, 12 Nov 2013 17:00:08 +0200
Message-ID: <CAOazyz1iEh8P_ALEAwzBSrWOCkHcvcH0C=cAG68bWStryTYW0A@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] ssl: enable basic ecdsa
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Jan Just Keijser <janjust@...1147...>
Cc: "Sanaullah ." <sanaullah82@...277...>, "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

On Tue, Nov 12, 2013 at 3:51 PM, Jan Just Keijser <janjust@...1147...> wrote:
> Alon Bar-Lev wrote:
>
> On Tue, Nov 12, 2013 at 1:37 PM, Jan Just Keijser <janjust@...1147...> wrote:
>
>
> there was actually a follow-up to this patch, which was sent to the
> openvpn-devel list on Feb 7th 2012:
>
>
> Added support for Elliptic curves (ECDSA) + SHA2 family signed
> certificates.
>
>
> Great!
>
> And what is the status?
>
>
> it was not included as this patch does not provide full Elliptic curve (EC)
> support - it only allows a user to use ECDSA+SHA2 signed certs, nothing more
> , nothing less. The Control Channel will use ECDSA, the data channel is
> still encrypted and signed using AES and SHA1/SHA2.
>
> JJK
>


But this is progress compared to current inability to use EC
certificates at all, right?

