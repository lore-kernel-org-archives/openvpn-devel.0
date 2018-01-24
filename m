MIME-Version: 1.0
In-Reply-To: <184564da-92d3-7bb5-21f1-8b7c7ddb201f@...515...>
References: <57da8cf7-0162-7798-7ae5-5851e36cca4a@...515...>
 <184564da-92d3-7bb5-21f1-8b7c7ddb201f@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 24 Jan 2018 10:45:12 -0500
Message-ID: <CAKuzo_hF2VK_-7XuRLTyJPu2OssqaM2Z+BdN7S6tCigvxEEatg@...278...>
Subject: Re: [Openvpn-devel] Summary of the community meeting (Wed,
 24th Jan 2018)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Wed, Jan 24, 2018 at 9:50 AM, Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:
> Hi,
>
> Here's the summary of the IRC meeting.
> ---
>
..

> Discussed the OpenVPN 2.4.5 release. The release was postponed to next
> Wednesday (31st Jan) to get some fixes and enhancements in.
>
> # openvpn
>
> Ensure strings read from registry are null-terminated:
>
> <https://patchwork.openvpn.net/project/openvpn2/list/?series=3D59>
>
> Plug memory leak if push is interrupted:
>
> <https://patchwork.openvpn.net/patch/195>
>
> TLS v1.2 support for cryptoapicert -- RSA only:
>
> <https://patchwork.openvpn.net/patch/202/>

This has already been ack-ed, so its a "simple matter of merging"
right? Also tested by the two most seemingly conscientious people
(including self :)

Others need review --- the hardest part of review is testing, and at
least for me it takes ages as nothing is automated here, and when
Windows is involved its  just pure pain .. Full disclosure:
although I test every patch on my Linux desktop and a WIn10 laptop
before ACK, never test the 32 bit Windows binary these days. It would
be prudent to do a quick test of the 32 bit version before release.

I understand why Gert has stopped reviewing my Windows-related patches :)

Selva

