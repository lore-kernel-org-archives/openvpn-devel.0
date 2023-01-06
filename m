MIME-Version: 1.0
References: <20230105022718.1641751-1-selva.nair@...277...>
 <20230105022718.1641751-2-selva.nair@...277...>
In-Reply-To: <20230105022718.1641751-2-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 6 Jan 2023 16:16:03 +0200
Message-ID: <CAGyAFMWxzUXCZNuwOr1=ngPH5Eyb0YAWNYT46Gx-FnBc7E3hVw@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] Distinguish route addition errors
 from route already exists
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
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

Hi,

>          else if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_IPAPI)
>          {
>              status = add_route_ipapi(r, tt, ai);
> -            msg(D_ROUTE, "Route addition via IPAPI %s", status ? "succeeded" : "failed");
> +            msg(D_ROUTE, "Route addition via IPAPI %s", (status == 1) ? "succeeded/skipped" : "failed");
>          }

Under what conditions we might get "skipped"?

-Lev

