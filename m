Message-ID: <523fde112159f8583eb7963b16acd85e.squirrel@...2257...>
In-Reply-To: <20170410222828.23612-1-davids@...515...>
References: <20170410222828.23612-1-davids@...515...>
Date: Tue, 11 Apr 2017 06:26:10 +0200
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Make --cipher/--auth none more explicit
 on the risks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

> The warning provided to --cipher and --auth using the 'none' setting may
> not have been too clearly understandable to non-developers or people not
> fully understanding encryption and cryptography.  This tries to improve
> that.
>
> While at it, also break up the long source lines.
>
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  src/openvpn/crypto.c | 11 +++++++++--
>  src/openvpn/init.c   |  5 ++++-
>  2 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index 909f725..8a5c723 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -784,7 +784,10 @@ init_key_type(struct key_type *kt, const char
> *ciphername,
>      {
>          if (warn)
>          {
> -            msg(M_WARN, "******* WARNING *******: null cipher specified,
> no encryption will be used");
> +            msg(M_WARN, "******* WARNING *******: '--cipher none' was
> specified. "
> +                "This means NO encryption will be performed and tunnelled
> "
> +                "data WILL be transmitted in clear text over the network!
> "
> +                "PLEASE DO RECONIDER THIS SETTING!");

Hi

Small typos, you may want to 's/RECONIDER/RECONSIDER/g' the patches.

Regards,
Simon



