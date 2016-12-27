References: <1482835944-563-1-git-send-email-davids@...515...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <d9b8604f-2ac7-e200-ed6e-982f773e7d85@...1227...>
Date: Tue, 27 Dec 2016 11:08:33 +0000
MIME-Version: 1.0
In-Reply-To: <1482835944-563-1-git-send-email-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] build: Ensure Changes.rst is shipped
 and installed as a doc file
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
To: David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net

Am 27.12.16 um 10:52 schrieb David Sommerseth:
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  Makefile.am | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Makefile.am b/Makefile.am
> index d1a72da..1197aad 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -60,6 +60,7 @@ dist_doc_DATA = \
>  	README \
>  	README.IPv6 \
>  	README.polarssl \
> +	Changes.rst \
>  	COPYRIGHT.GPL \
>  	COPYING
>  
> 

ACK

Arne

