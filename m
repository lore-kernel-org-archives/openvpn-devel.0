Message-ID: <52D076C0.7010105@...1227...>
Date: Fri, 10 Jan 2014 23:40:00 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1389371142-26705-1-git-send-email-gert@...1296...>
In-Reply-To: <1389371142-26705-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] remove some "unused variable"
	warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 10.01.14 17:25, schrieb Gert Doering:
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/comp-lz4.c | 1 -
>  src/openvpn/options.c  | 2 ++
>  src/openvpn/ssl.c      | 3 +--
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
> index afa43b1..4651148 100644
> --- a/src/openvpn/comp-lz4.c
> +++ b/src/openvpn/comp-lz4.c
> @@ -64,7 +64,6 @@ lz4_compress (struct buffer *buf, struct buffer work,
>  	       struct compress_context *compctx,
>  	       const struct frame* frame)
>  {
> -  int result;
>    bool compressed =3D false;
>=20=20
>
ACK. I should have noticed that but it was buried under the other
warnings :(

Arne


