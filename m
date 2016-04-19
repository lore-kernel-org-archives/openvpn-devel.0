MIME-Version: 1.0
In-Reply-To: <B32C1FDE-D0CF-49A7-A231-28267BB89B46@...2127...>
References: <B32C1FDE-D0CF-49A7-A231-28267BB89B46@...2127...>
From: Steffan Karger <steffan@...1856...>
Date: Tue, 19 Apr 2016 22:44:39 +0200
Message-ID: <CAA1AbxL3ZRGrig+j9uTdn17NDaM=WGbE4XgZf1nAyvXBxTwfBg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] auth-pam:Fix buffer overflow by user
 supplied data
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
To: Jens <openvpn-devel@...2127...>
Cc: openvpn-devel <Openvpn-devel@lists.sourceforge.net>

Hi,

On Tue, Apr 19, 2016 at 9:01 PM, Jens <openvpn-devel@...2127...> wrote:
> The AUTH-PAM plugin contains the function `searchandreplace`. The buffer =
allocated there can be overflown if the parameter `replace_with`  is to lon=
g (depending on the format string).
>
> E.g.:
>
>  searchandreplace(to search :=3D=E2=80=9CX=E2=80=9D, searchfor :=3D =E2=
=80=9CX=E2=80=9D, replacewith :=3D =E2=80=9C0123456789!=E2=80=9D)
>
> would overflow `temp` with the character =E2=80=98!=E2=80=99.

Good find!

> --- a/src/plugins/auth-pam/auth-pam.c
> +++ b/src/plugins/auth-pam/auth-pam.c
> @@ -123,13 +123,15 @@ static void pam_server (int fd, const char *service=
, int verb, const struct name
>  static char *
>  searchandreplace(const char *tosearch, const char *searchfor, const char=
 *replacewith)
>  {
> +  if (!tosearch || !searchfor || !replacewith) return 0;
> +  if (!strlen(tosearch) || !strlen(searchfor) || !strlen(replacewith)) r=
eturn 0;
> +
>    const char *searching=3Dtosearch;
>    char *scratch;
> -  char temp[strlen(tosearch)*10];
> +
> +  char temp[strlen(tosearch) * strlen(replacewith) + 1];

This is without a doubt an improvement, but it still leaves an
opportunity open to achieve a buffer overflow through an integer
overflow.  Consider a tosearch with len 11, and a replacewith with len
SIZE_MAX/10.  While we're fixing this code, let's fix that too.  For
example:

    size_t tosearchlen =3D strlen(tosearch);
    size_t replacewithlen =3D strlen(replacewith);
    size_t templen =3D tosearchlen * replacewithlen;
    if ((tosearchlen !=3D 0 && templen / tosearchlen !=3D replacewithlen)
|| templen =3D=3D SIZE_MAX) {
        return NULL;
    }
    char temp[templen+1];

-Steffan

