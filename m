MIME-Version: 1.0
References: <20200622113022.23047-1-davids@...515...>
In-Reply-To: <20200622113022.23047-1-davids@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 22 Jun 2020 12:58:21 -0400
Message-ID: <CAKuzo_g7QxVL90ikT57H6b4+St2c860us6S3cN_6jbfeHujpzw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Change the default cipher to
 AES-256-GCM for server configs
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Mon, Jun 22, 2020 at 7:31 AM David Sommerseth <davids@...515...> wrote:
>
> This change makes the server use AES-256-GCM instead of BF-CBC as the
> default cipher for the VPN tunnel when starting OpenVPN via systemd
> and the openvpn-server@...1685... unit file.
>
> To avoid breaking existing running configurations defaulting to BF-CBC,
> the Negotiable Crypto Parameters (NCP) list contains the BF-CBC in
> addition to AES-CBC.  This makes it possible to migrate existing older
> client configurations one-by-one to use at least AES-CBC unless the
> client is updated to v2.4 or newer (which defaults to upgrade to
> AES-GCM automatically)
>
> This has been tested in Fedora 27 (released November 2017) with no
> reported issues.  By making this default for all Linux distributions
> with systemd shipping with the unit files we provide, we gradually
> expand setups using this possibility.  As we gather experience from
> this change, we can further move these changes into the defaults of
> the OpenVPN binary itself with time.
>
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  Changes.rst                               | 15 +++++++++++++++
>  distro/systemd/openvpn-server@...2221... |  2 +-
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/Changes.rst b/Changes.rst
> index 00dd6ed8..e76d3c73 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -14,6 +14,21 @@ ChaCha20-Poly1305 cipher support
>      channel.
>
>
> +User-visible Changes
> +--------------------
> +New default cipher for systemd based Linux distributions
> +    For Linux distributions with systemd which packages the systemd unit files
> +    from the OpenVPN project, the default cipher is now changed to AES-256-GCM,
> +    with BF-CBC as a fallback through the NCP feature.  This change has been
> +    tested successfully since the Fedora 27 release (released November 2017).
> +
> +    *WARNING*   This MAY break configurations where the client uses
> +                ``--disable-occ`` feature where the ``--cipher`` has
> +                not been explicitly configured on both client and
> +                server side.  It is recommended to remove the ``--disable-occ``
> +                option *or* explicitly add ``--cipher AES-256-GCM`` on the
> +                client side if ``--disable-occ`` is strictly needed.
> +
>  Overview of changes in 2.4
>  ==========================
>
> diff --git a/distro/systemd/openvpn-server@...2221... b/distro/systemd/openvpn-server@...2221...
> index d1cc72cb..f3545ff5 100644
> --- a/distro/systemd/openvpn-server@...2221...
> +++ b/distro/systemd/openvpn-server@...2221...
> @@ -10,7 +10,7 @@ Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO
>  Type=notify
>  PrivateTmp=true
>  WorkingDirectory=/etc/openvpn/server
> -ExecStart=@sbindir@/openvpn --status %t/openvpn-server/status-%i.log --status-version 2 --suppress-timestamps --config %i.conf
> +ExecStart=@sbindir@/openvpn --status %t/openvpn-server/status-%i.log --status-version 2 --suppress-timestamps --cipher AES-256-GCM --ncp-ciphers AES-256-GCM:AES-128-GCM:AES-256-CBC:AES-128-CBC:BF-CBC --config %i.conf

This is why I keep my openvpn servers out of systemd's view -- it
keeps deciding what's good for us. I want to run my configs as is.

Selva

