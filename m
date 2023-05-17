From: Kristof Provost <kp@...1376...>
Date: Wed, 17 May 2023 16:43:01 -0400
Message-ID: <02835E0F-FA73-4722-83EB-17A33A3A8DA5@...1376...>
In-Reply-To: <20230517200143.216-1-chipitsine@...277...>
References: <20230517200143.216-1-chipitsine@...277...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] src/openvpn/dco_freebsd.c: handle
 malloc failure
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
To: Ilya Shipitsin <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On 17 May 2023, at 16:01, Ilya Shipitsin wrote:
> malloc was not checked against NULL, I was able
> to get core dump in case of failure
>
> Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
> ---
>  src/openvpn/dco_freebsd.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
> index 1111abeb..adbd1120 100644
> --- a/src/openvpn/dco_freebsd.c
> +++ b/src/openvpn/dco_freebsd.c
> @@ -594,6 +594,11 @@ dco_available(int msglevel)
>      }
>
>      buf =3D malloc(ifcr.ifcr_total * IFNAMSIZ);
> +    if (buf =3D=3D NULL)
> +    {

I=E2=80=99d =E2=80=98goto out;=E2=80=99 instead, because that=E2=80=99s how=
 we handle other errors in this function.
(free(NULL) is guaranteed to be safe, so we can just do that.)

Fwiw: I usually don=E2=80=99t bother handling malloc failure in userspace, =
because modern systems all overallocate anyway, so the first thing you know=
 about lack of memory is the out-of-memory killer terminating you. It=E2=80=
=99s a policy choice for the project, so I don=E2=80=99t object to handling=
 it either.

Best regards,
Kristof

