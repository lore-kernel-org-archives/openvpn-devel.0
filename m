References: <20180622014905.21558-1-rosenp@...277...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <24a033db-84dc-9d88-eea2-1d0700d8bf01@...2181...>
Date: Fri, 22 Jun 2018 09:58:53 +0800
MIME-Version: 1.0
In-Reply-To: <20180622014905.21558-1-rosenp@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] openvpn: Add missing OpenSSL includes
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
To: Rosen Penev <rosenp@...277...>, openvpn-devel@lists.sourceforge.net

Hi,

On 22/06/18 09:49, Rosen Penev wrote:
> These get included when deprecated APIs are enabled. This is true on at
> least version 1.0.2 and 1.1.0.
> 
> Without deprecated APIs, OpenVPN fails to compile.
> 
> Signed-off-by: Rosen Penev <rosenp@...277...>
> ---
>  ...ilation-with-deprecated-APIs-disable.patch | 148 ++++++++++++++++++

Was this patch committed by accident?

Cheers,


-- 
Antonio Quartulli

