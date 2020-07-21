References: <59a5ef1d-3b5f-f06a-e0e7-0443f0e2313e@...2080...>
 <20200721100128.9850-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <cb803726-936f-9c5b-0816-4cfe240b1f09@...2080...>
Date: Tue, 21 Jul 2020 19:24:43 +0200
MIME-Version: 1.0
In-Reply-To: <20200721100128.9850-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 5/9] Remove key-method 1
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 21/07/2020 12:01, Arne Schwabe wrote:
> Key-method 1 is only needed to talk to pre OpenVPN 2.0 clients.
> 
> Patch V2: Fix style. Make V1 op codes illegal, remove all code handling
>           v1 op codes and give a good warning message if we encounter
>           them in the legal op codes pre-check.
> 
> Patch V3: Add a bit more comments in the existing methods.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  doc/doxygen/doc_control_processor.h |   6 +-
>  doc/doxygen/doc_key_generation.h    |   6 +-
>  doc/doxygen/doc_protocol_overview.h |   2 +-
>  src/openvpn/forward.c               |   2 +-
>  src/openvpn/helper.c                |   5 -
>  src/openvpn/init.c                  |   1 -
>  src/openvpn/options.c               |  35 +---
>  src/openvpn/options.h               |   4 -
>  src/openvpn/ssl.c                   | 240 +++++-----------------------
>  src/openvpn/ssl.h                   |  19 +--
>  src/openvpn/ssl_common.h            |   1 -
>  11 files changed, 53 insertions(+), 268 deletions(-)
> 

This LGTM now.  Thanks for the updates and adjustments!

I've done light local build testing (applying just this patch on git master
commit 08469ca1eccc).  Builds fine, 'make check' looks good.

Acked-By: David Sommerseth <davids@...515...>


-- 
kind regards,

David Sommerseth
OpenVPN Inc


