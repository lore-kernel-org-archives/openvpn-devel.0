Date: Fri, 20 Jan 2023 12:33:05 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y8p78WY2cU99EtEE@...2685...>
References: <20230120021841.2048791-1-selva.nair@...277...>
MIME-Version: 1.0
In-Reply-To: <20230120021841.2048791-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Warn when pkcs11-id or
 pkcs11-id-management options are ignored
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

On Thu, Jan 19, 2023 at 09:18:41PM -0500, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
> 
> - If there are no pkcs11-providers either directly specified or
>   through p11-kit-proxy made available through a build-time detection,
>   these options are ignored. Log a warning in such cases.
> 
>   Especially important on Windows where automatic loading of p11-kit
>   is not enabled in our release builds.
> 
> - Document this behaviour.
> 

Acked-By: Frank Lichtenheld <frank@...2641...>

LGTM.

I was looking at the warning messages whether they are consistent with
other similar messages. But since there is no consistency at all, that
is impossible.

Regards,
-- 
  Frank Lichtenheld

