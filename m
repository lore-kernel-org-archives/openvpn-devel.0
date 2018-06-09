MIME-Version: 1.0
In-Reply-To: <20180419112313.1013-1-simon@...2293...>
References: <CAKuzo_gJjQR4-RC=FbmzNgVHRh2L57bbgJku1gchhzH1e6RFFA@...278...>
 <20180419112313.1013-1-simon@...2293...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 9 Jun 2018 12:23:27 -0400
Message-ID: <CAKuzo_jaeLOAdXwGPkUCMuBM6VJdpFSw_G7U5F88tFsYouaa_w@...278...>
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
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Thu, Apr 19, 2018 at 7:23 AM, Simon Rozman <simon@...2293...> wrote:
> The OpenVPN Interactive Service documentation from
> https://community.openvpn.net/openvpn/wiki/OpenVPNInteractiveService was
> upgraded with a description of the client-service communication flow,
> service registry configuration, and non-default instance installation.
> ---
> Thank you Selva for your review.
>
> Changes from [PATCH v4]:
>
> 1. git mv doc/interactive-service-notes.txt doc/interactive-service-notes.rst
> 2. The section headings were restyled
> 3. Selva's remark on openvpn.exe process termination has been taken into
>    consideration. The entire `openvpn.exe Termination` was reworded into a new
>    section `openvpn.exe Monitoring and Termination`.
>
> Rationale behind 1. and 2. is unification with documents located in tap-windows6
> repository.
>
> Best regards,
> Simon
>
>  doc/interactive-service-notes.rst | 330 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 330 insertions(+)
>  create mode 100644 doc/interactive-service-notes.rst

Version v5 looks good and ACK from me.

I still suggest to include in the dist tarball. As it stands one has
to clone the repo to see it.

> Giving it a second thought, there is no point into packaging this file for non-Windows distributions, since the Interactive Service is Windows-specific.

We have a common source distribution for all platforms and it includes
Windows only bits like the interactive service sources. IMO, this does
belong there.

Selva

