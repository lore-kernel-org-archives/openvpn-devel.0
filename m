MIME-Version: 1.0
References: <20181219202611.2144-1-simon@...2293...>
In-Reply-To: <20181219202611.2144-1-simon@...2293...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 19 Dec 2018 16:48:49 -0500
Message-ID: <CAKuzo_iTTMtNMoDvkjXaADmTtEDAbpDDSmDxaQhbaDSSLvk1Pg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/4] Make DriverCertification MSI
 property public
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
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Wed, Dec 19, 2018 at 3:27 PM Simon Rozman <simon@...2293...> wrote:
>
> Making DriverCertification public (containing only upper-case letters)
> allows the property set by FindSystemInfo custom action to be passed
> from InstallUISequence sequence to InstallExecuteSequence. This
> eliminates the need to execute FindSystemInfo in both sequences.
> ---
>  src/openvpnmsica/openvpnmsica.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

It seems I'm behind times and cant figure out where these patches apply. Are
these for openvpn, openvpn-build or something else?

Thanks,

Selva

