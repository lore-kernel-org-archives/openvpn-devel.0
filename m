References: <20210904095629.6273-1-a@...2181...>
 <20210904095629.6273-6-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <ca8644f5-6959-8cfb-50ce-a81c5f3d3660@...1227...>
Date: Mon, 6 Sep 2021 15:23:48 +0200
MIME-Version: 1.0
In-Reply-To: <20210904095629.6273-6-a@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 5/7] compat-mode: add
 --data-cipher-fallback auomatically if requested
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
> For compatibility with OpenVPN older than 2.4.0, the
> '--data-cipher-fallback' argument is automatically added with the same
> value as specified by '--cipher'.
> 
> This happens only when the user specifies compat-mode with a version
> older than 2.4.0.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  doc/man-sections/generic-options.rst | 2 ++
>  src/openvpn/options.c                | 7 +++++++

> 
Acked-By: Arne Schwabe <arne@...1227...>

