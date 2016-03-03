MIME-Version: 1.0
In-Reply-To: <1456993146-63968-9-git-send-email-james@...515...>
References: <1456993146-63968-1-git-send-email-james@...515...>
	<1456993146-63968-9-git-send-email-james@...515...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Thu, 3 Mar 2016 18:21:48 -0500
Message-ID: <CAEsd45SxnPokhHmkHe38AZghkhh=xVB-h9ODYHU1zfvkz9i=Pw@...278...>
Subject: Re: [Openvpn-devel] [PATCH 09/10] Added directive to specify HTTP
 proxy credentials in config.
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: James Yonan <james@...515...>

On Thu, Mar 3, 2016 at 3:19 AM, James Yonan <james@...515...> wrote:
>
> The inline directive http-proxy-user-pass can be used to
> specify proxy credentials in config, e.g.:
>
> http-proxy proxy.tld 3128 auto-nct
> <http-proxy-user-pass>
> foo
> bar
> </http-proxy-user-pass>
>
> This usage is already supported by OpenVPN 3.
>
> Signed-off-by: James Yonan <james@...515...>
> ---
>  src/openvpn/misc.c    |  8 ++++++++
>  src/openvpn/misc.h    |  2 ++
>  src/openvpn/options.c | 13 +++++++++++++
>  src/openvpn/proxy.c   |  2 ++
>  src/openvpn/proxy.h   |  1 +
>  5 files changed, 26 insertions(+)

No man page documentation?

