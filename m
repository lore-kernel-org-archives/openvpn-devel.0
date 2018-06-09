MIME-Version: 1.0
In-Reply-To: <CAKuzo_jaeLOAdXwGPkUCMuBM6VJdpFSw_G7U5F88tFsYouaa_w@...278...>
References: <CAKuzo_gJjQR4-RC=FbmzNgVHRh2L57bbgJku1gchhzH1e6RFFA@...278...>
 <20180419112313.1013-1-simon@...2293...>
 <CAKuzo_jaeLOAdXwGPkUCMuBM6VJdpFSw_G7U5F88tFsYouaa_w@...278...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Sat, 9 Jun 2018 12:41:23 -0400
Message-ID: <CAEsd45S6K8ovQB6w=8N+16S+FVnjsoh48BTB+njMs1aOCPQOcQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH v5] Add Interactive Service developer
 documentation
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
To: Selva Nair <selva.nair@...277...>
Cc: Simon Rozman <simon@...2293...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Sat, Jun 9, 2018 at 12:23 PM, Selva Nair <selva.nair@...277...> wrote:
>
> Hi,
>
> On Thu, Apr 19, 2018 at 7:23 AM, Simon Rozman <simon@...2293...> wrote:
> > The OpenVPN Interactive Service documentation from
> > https://community.openvpn.net/openvpn/wiki/OpenVPNInteractiveService was
> > upgraded with a description of the client-service communication flow,
> > service registry configuration, and non-default instance installation.

<snip>

> > Giving it a second thought, there is no point into packaging this file for non-Windows distributions, since the Interactive Service is Windows-specific.
>
> We have a common source distribution for all platforms and it includes
> Windows only bits like the interactive service sources. IMO, this does
> belong there.

+1: It should be included. It is of interest to non-Windows folks like
me, too, even if we don't use it directly.

Best regards,

Jon Bullard

