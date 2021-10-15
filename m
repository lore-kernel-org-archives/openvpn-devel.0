References: <20211015043227.10679-1-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <53398984-9b0e-505c-e077-fb00809f0c10@...1227...>
Date: Fri, 15 Oct 2021 16:04:25 +0200
MIME-Version: 1.0
In-Reply-To: <20211015043227.10679-1-selva.nair@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Fix the "default" tls-version-min
 setting
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
To: selva.nair@...277..., "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 15.10.21 um 06:32 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> commit 968569f83b1561ea4dff5b8b1f0d7768e2a18e69
> defined TLS 1.2 as the minimum version if not set
> by user. But the patch introduced two errors:
> 
> (i) ssl_flags is overwritten without regard to other
>     options set in the flags
> (ii) Any tls-version-max set by the user is not taken into
>      account.
> Makes it impossible to set tls-version-max without also setting
> tls-version-min along with loss of other bits set in ssl_flags.
> 
> Fix it.
> 
> The fix retains the original intent when possible, and tries to
> use the maximum possible value when it cannot be set to TLS 1.2
> without conflicting with user-specified tls-version-max, if any.

Makes sense and code looks correct.

Acked-By: Arne Schwabe <arne@...1227...>

