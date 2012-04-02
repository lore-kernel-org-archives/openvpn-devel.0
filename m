MIME-Version: 1.0
In-Reply-To: <1333351687-3732-6-git-send-email-dejong@...1435...>
References: <1333351687-3732-1-git-send-email-dejong@...1435...>
	<1333351687-3732-6-git-send-email-dejong@...1435...>
Date: Mon, 2 Apr 2012 12:15:32 +0300
Message-ID: <CAOazyz3_WZk6xcEUr208fGUrE4QKr29d=4UgYTLpgWmCE=aHOA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 6/6] Updated README.polarssl with build
 system changes.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Adriaan de Jong <dejong@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

I think this should be merged into the README.
No need for these satellite README.*.

On Mon, Apr 2, 2012 at 10:28 AM, Adriaan de Jong <dejong@...1435...> wrote:
> Signed-off-by: Adriaan de Jong <dejong@...1435...>
> ---
> =C2=A0README.polarssl | =C2=A0 =C2=A04 ++--
> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/README.polarssl b/README.polarssl
> index 77a9575..ab7c2d7 100644
> --- a/README.polarssl
> +++ b/README.polarssl
> @@ -3,11 +3,11 @@ instructions:
>
> =C2=A0To Build and Install,
>
> - =C2=A0 =C2=A0 =C2=A0 ./configure --with-ssl-type=3Dpolarssl
> + =C2=A0 =C2=A0 =C2=A0 ./configure --with-crypto-library=3Dpolarssl
> =C2=A0 =C2=A0 =C2=A0 =C2=A0make
> =C2=A0 =C2=A0 =C2=A0 =C2=A0make install
>
> -This version depends on at least PolarSSL v0.99.
> +This version depends on at least PolarSSL v1.1.
>
> =C2=A0*******************************************************************=
******
>
> --
> 1.7.5.4
>
>
> -------------------------------------------------------------------------=
-----
> This SF email is sponsosred by:
> Try Windows Azure free for 90 days Click Here
> http://p.sf.net/sfu/sfd2d-msazure
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

