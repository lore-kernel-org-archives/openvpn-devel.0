MIME-Version: 1.0
In-Reply-To: <20180413142402.686-1-simon@...2293...>
References: <20180413075755.1445-1-simon@...2293...>
 <20180413142402.686-1-simon@...2293...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 18 Apr 2018 23:59:37 -0400
Message-ID: <CAKuzo_gJjQR4-RC=FbmzNgVHRh2L57bbgJku1gchhzH1e6RFFA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v4] Add Interactive Service developer
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
Content-Transfer-Encoding: quoted-printable
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Looks good now except for an error introduced by my sloppy comment. See bel=
ow:

On Fri, Apr 13, 2018 at 10:24 AM, Simon Rozman <simon@...2293...> wrote:
> The OpenVPN Interactive Service documentation from
> https://community.openvpn.net/openvpn/wiki/OpenVPNInteractiveService was
> upgraded with a description of the client-service communication flow,
> service registry configuration, and non-default instance installation.
> ---

BTW, additional comments not to be included in the commit message
could go here instead of at the bottom. Easier to read/notice, but either
way is fine by me.

>  doc/interactive-service-notes.txt | 329 ++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 329 insertions(+)
>  create mode 100644 doc/interactive-service-notes.txt
>
> diff --git a/doc/interactive-service-notes.txt b/doc/interactive-service-=
notes.txt
> new file mode 100644
> index 00000000..6f716800
> --- /dev/null
> +++ b/doc/interactive-service-notes.txt
> @@ -0,0 +1,329 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +OpenVPN Interactive Service Notes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +

..snipped..

>
>
> +
> +openvpn.exe Termination
> +-----------------------
> +
> +The pipe between the client and the service is kept open until the openv=
pn.exe
> +process terminates.
> +
> +Should the openvpn.exe process terminate with an error, the Interactive =
Service
> +sends an error message to the client before disconnecting the pipe.
> +
> +Note that Interactive Service never terminates the openvpn.exe process. =
Not even
> +when the service is stopped or restarted. Therefore, the client must mon=
itor the
> +openvpn.exe process itself. OpenVPN Management Interface is recommended =
for
> +this.

I was confused when I suggested to add this. In fact iservice does force-ki=
ll
openvpn.exe processes at service termination. The process is not killed
if the pipe client disconnects. So the above needs to be reworded --
may be revert to your original?

Sorry about that.
..

> Hi,
>
> The inclusion of the doc/interactive-service-notes.txt file in the doc/Ma=
kefile.am introduced in v2 was dropped in v3. Giving it a second thought, t=
here is no point into packaging this file for non-Windows distributions, si=
nce the Interactive Service is Windows-specific.
>
> I am reluctant to rewrite the "How It Works" section to a more formal lan=
guage. Nor do I feel a need to. Gert's easy-going language describes the bi=
g picture of the Interactive Service idea anyone can understand in ten seco=
nds. Not something you can easily achieve using a formal language. In v3 of=
 this patch, I did made it a bit more formal nevertheless.
>
> Selva, thank you for your remarks. I have updated the text.
>
> BTW, the "_" after the quoted section name is a reStructuredText markup t=
hat renders the section name as a reference/hyperlink to that section. You =
don't need to install the Docutils -- use a nice reStructuredText online ed=
itor/renderer at http://rst.ninjs.org to get the final document look. Nice =
thing with reStructuredText is that the markup clutters the original text a=
 bit less than Markdown.

I was convinced even without seeing the rendered version. But wow, it
does look good.

>
>
> I don't plan to document the service pipe between Interactive Service and=
 openvpn.exe. I am not experienced in it. The service pipe is internal Open=
VPN affair, not something you need to know when developing a custom OpenVPN=
 frontend. The target audience of doc/interactive-service-notes.txt documen=
t as it is now are developers looking to automate openvpn.exe use on Window=
s. However, I don't mind somebody extend it with service pipe documentation.

OK, leave that for another day.

ACK from me once the point mentioned above is addressed.

Thanks for doing this,

Selva

