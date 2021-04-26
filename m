References: <20210421234908.12817-1-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <450d7818-3d0c-813f-6a8d-85a624b59471@...1227...>
Date: Mon, 26 Apr 2021 12:59:25 +0200
MIME-Version: 1.0
In-Reply-To: <20210421234908.12817-1-a@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] options: check for blanks in
 fingerprints and reject string if found
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <antonio@...515...>

Am 22.04.21 um 01:49 schrieb Antonio Quartulli:
> From: Antonio Quartulli <antonio@...515...>
> 
> A fingerprint is not expected to contains any blank (white space),
> howeveri, the parser routine will still attempt parsing the octect
> and ignore the space.
> 
> This means that a fingerprint like
> 5 :F0:A8:75:70:46:6E:0B:A2:31:53:88:0B:0E:8C:E4:8A:5E:BF:1E:08:16:16:41:63:2C:B5:F4:D2:73:9F:E5
> will be parsed successfully.
> 
> Explcitly check for spaces in the various octects, before conversion,
> and error out if any is found.

Explicitly

> 
> Signed-off-by: Antonio Quartulli <antonio@...515...>
> ---
>  src/openvpn/options.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 817a1533..264fe383 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -1099,6 +1099,18 @@ parse_hash_fingerprint(const char *str, int nbytes, int msglevel, struct gc_aren
>          bs[0] = *cp++;
>          bs[1] = *cp++;
>          bs[2] = 0;
> +
> +        /* the format string "%x" passed to sscanf will ignore any space and
> +         * will still try to parse the other character. However, this is not
> +         * expected format for a fingerprint, therefore explcitly check for

explicitly

> +         * blanks in the string and error out if any is found
> +         */
> +        if (bs[0] == ' ' || bs[1] == ' ')
> +        {
> +            msg(msglevel, "format error in hash fingerprint unexpected blank: %s",
> +                str);
> +        }
> +
>          byte = 0;
>          if (sscanf(bs, "%x", &byte) != 1)
>          {
> 

I would not have spend the time to fix this but since Antonio done it:

Acked-By: Arne Schwabe <arne@...1227...>

