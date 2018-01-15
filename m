References: <20180115114728.13672-1-simon@...2293...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <aaa3dd43-04b2-7b9e-802d-0f03102bc4fd@...1227...>
Date: Mon, 15 Jan 2018 14:32:28 +0100
MIME-Version: 1.0
In-Reply-To: <20180115114728.13672-1-simon@...2293...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Document missing OpenVPN states
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

Am 15.01.2018 um 12:47 schrieb Simon Rozman:
> ---
>  doc/management-notes.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/doc/management-notes.txt b/doc/management-notes.txt
> index a9ba18a..908b981 100644
> --- a/doc/management-notes.txt
> +++ b/doc/management-notes.txt
> @@ -362,6 +362,8 @@ ADD_ROUTES    -- Adding routes to system.
>  CONNECTED     -- Initialization Sequence Completed.
>  RECONNECTING  -- A restart has occurred.
>  EXITING       -- A graceful exit is in progress.
> +RESOLVE       -- (Client only) DNS lookup
> +TCP_CONNECT   -- (Client only) Connecting to TCP server
>  
>  Command examples:
>  

Acked-by: Arne Schwabe <arne@...1227...>
Reviewed-by: Arne Schwabe <arne@...1227...>

ACK. I seen the state message often enough to that my double checking of
the code was almost pointless.

Arne


