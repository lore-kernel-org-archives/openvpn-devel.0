References: <20171111161122.30087-1-gert@...2298...>
 <20171111161122.30087-2-gert@...2298...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <36d79632-6548-2d72-7d25-376d188ecea9@...1227...>
Date: Sun, 12 Nov 2017 21:09:48 +0100
MIME-Version: 1.0
In-Reply-To: <20171111161122.30087-2-gert@...2298...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH 2/2] Add negotiated cipher to status
 file format 2 and 3
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
To: Gert van Dijk <gert@...2298...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 11.11.17 um 17:11 schrieb Gert van Dijk:
> With NCP turned off, this will still display the cipher used.
> 
> Trac: #814
> 
> Signed-off-by: Gert van Dijk <gert@...2298...>
> ---
>  doc/openvpn.8       |  2 +-
>  src/openvpn/multi.c | 11 +++++++----
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 267497fd..00dbff6f 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -2477,7 +2477,7 @@ Connected Since.
>  .B 2
>  \-\- a more reliable format for external processing. Compared to version 1, the
>  client list contains some additional fields: Virtual Address, Virtual IPv6
> -Address, Username, Client ID, Peer ID.
> +Address, Username, Client ID, Peer ID, Data Channel Cipher.
>  Future versions may extend the number of fields.
>  .br
>  .B 3


This part of the patch is okay but does not apply cleanly for me. Might
need some on the fly fixing on apply.

> @@ -940,8 +942,8 @@ multi_print_status(struct multi_context *m, struct status_output *so, const int
>               */
>              status_printf(so, "TITLE%c%s", sep, title_string);
>              status_printf(so, "TIME%c%s%c%u", sep, time_string(now, 0, false, &gc_top), sep, (unsigned int)now);
> -            status_printf(so, "HEADER%cCLIENT_LIST%cCommon Name%cReal Address%cVirtual Address%cVirtual IPv6 Address%cBytes Received%cBytes Sent%cConnected Since%cConnected Since (time_t)%cUsername%cClient ID%cPeer ID",
> -                          sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep);
> +            status_printf(so, "HEADER%cCLIENT_LIST%cCommon Name%cReal Address%cVirtual Address%cVirtual IPv6 Address%cBytes Received%cBytes Sent%cConnected Since%cConnected Since (time_t)%cUsername%cClient ID%cPeer ID%cData Channel Cipher",



Extremely long line, but not your fault, so I will let it pass.


Works for me and code is good so:

Acked-by: Arne Schwabe <arne@...1227...>
Tested-by: Arne Schwabe <arne@...1227...>


Arne

