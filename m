Message-ID: <16db716c-2b8d-7289-c119-6f05fc1a9c5b@...68...>
Date: Tue, 28 Mar 2023 20:51:09 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20230328151233.217296-1-frank@...2641...>
From: Matthias Andree <matthias.andree@...68...>
In-Reply-To: <20230328151233.217296-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH] buffer: use memcpy in buf_catrunc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Am 28.03.23 um 17:12 schrieb Frank Lichtenheld:
> Since we use strlen() to determine the length
> and then check it ourselves, there is really
> no point in using strncpy.
>
> But the compiler might complain that we use
> the output of strlen() for the length of
> strncpy which is usually a sign for bugs:
>
> error: =E2=80=98strncpy=E2=80=99 specified bound depends
>   on the length of the source argument
>   [-Werror=3Dstringop-overflow=3D]
>
> Warning was at least triggered for
> mingw-gcc version 10-win32 20220113.
>
> Signed-off-by: Frank Lichtenheld <frank@...2641...>
> ---
>   src/openvpn/buffer.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
> index d099795b..de40d690 100644
> --- a/src/openvpn/buffer.c
> +++ b/src/openvpn/buffer.c
> @@ -317,9 +317,9 @@ buf_catrunc(struct buffer *buf, const char *str)
>       if (buf_forward_capacity(buf) <=3D 1)
>       {
>           int len =3D (int) strlen(str) + 1;
> -        if (len < buf_forward_capacity_total(buf))
> +        if ((len > 0) && (len < buf_forward_capacity_total(buf)))

I hope you don't mind but there are a few things I would like to bring
to attention.

1. The first is clamping and wrapping around:

strlen(someptr) returns size_t, and this can be >=3D INT_MAX. Add +1 and
this wraps to INT_MIN.
While you now trap this with the new "len > 0", there does not seem to
be any error handling, in that the function silently skips its actual
function.
Is this what such a function should do? Or should it be "complain an
give up"?

>           {
> -            strncpynt((char *)(buf->data + buf->capacity - len), str, le=
n);
> +            memcpy((void *)(buf->data + buf->capacity - len), (void *)st=
r, (size_t)len);

2. This opens the door for another compiler warning, which is that you
are casting away the const-ness of "str". It is const char * when passed
in, but you cast it to void * (non-const). The 2nd argument of memcpy
would need to be cast to (const void *) to avoid that. memcpy is
declared (..., const void *restrict src, ...), so that's safe.

3. However, strncpynt would set buf->data[buf->capacity] =3D '\0', which
is now missing.

So: NAK, please revise on #3.

Cheers,
Matthias


