Date: Tue, 26 Apr 2022 11:32:54 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <185655137.411206.1650965574357@...2642...>
In-Reply-To: <20220422142953.3805364-3-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
 <20220422142953.3805364-3-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 12/28] Extract session_move_pre_start as
 own function, use local buffer variable
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Acked-By: Frank Lichtenheld <frank@...2641...>

Verified visually that this only moves code around and doesn't change behavior.
Only compile/UT tested.

> Arne Schwabe <arne@...1227...> hat am 22.04.2022 16:29 geschrieben:
> 
>  
> This changes the C90 struct buffer declaration to a C99 style one. Also
> move the state transition from S_INITIAL to S_PE_START into its own
> function.
> ---
>  src/openvpn/ssl.c | 84 ++++++++++++++++++++++++++++-------------------
>  1 file changed, 50 insertions(+), 34 deletions(-)

Regards,
--
Frank Lichtenheld

