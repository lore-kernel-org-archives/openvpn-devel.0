MIME-Version: 1.0
References: <20200630095443.7188-1-cschenk@...2502...>
 <202007061543.066Fh1vv046421@...2054...>
In-Reply-To: <202007061543.066Fh1vv046421@...2054...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Mon, 6 Jul 2020 12:43:58 -0400
Message-ID: <CAEsd45QWiRvaUzwGZh=dJJ4zAB_pabTyXMTH6y8UszN+AV195A@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Unified success messages
 for setting mtu
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: Christopher Schenk <cschenk@...2502...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Mon, Jul 6, 2020 at 11:43 AM Gert Doering <gert@...1296...> wrote:
>
> Acked-by: Gert Doering <gert@...1296...>
>
> Thanks :-) - given that this is somewhat trivial, I have not actually
> run a binary to look at the messages.  I have counted arguments and done
> a test build to see if new warnings show up (no).
>
> I *do* see an old warning...
>
> tun.c: In function 'windows_set_mtu':
> tun.c:5523:21: warning: format '%u' expects argument of type 'unsigned int', but argument 5 has type 'DWORD {aka long unsigned int}' [-Wformat=]
>          msg(M_WARN, "TUN: Setting %s mtu failed: %s [status=%u if_index=%d]",

It's ok if this is only for Windows code (I assume it is because of
the name of the function) because x86 and ARM have the same
endian-ness and are the only Windows platforms (that I know of).
However, it would still be better to use "%lu" to avoid the warning
and to future-proof it for any _new_ Windows platform that's
different. (Although I admit Microsoft is unlikely to do that.)

Best regards,

Jon

