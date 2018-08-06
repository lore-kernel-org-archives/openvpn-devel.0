References: <4ff9b515-b65c-ddb4-30e5-03660cd9f245@...2181...>
 <1533542553-7383-1-git-send-email-steffan.karger@...1435...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <eebe6f78-6163-4e5e-a190-c1bee764ccec@...277...>
Date: Mon, 6 Aug 2018 13:20:06 +0100
MIME-Version: 1.0
In-Reply-To: <1533542553-7383-1-git-send-email-steffan.karger@...1435...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v5 1/7] Introduce buffer_write_file()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

One typo inline


On 06/08/18 09:02, Steffan Karger wrote:
> Rewrite buf_write_string_file to buffer_write_file, which is simpler to
> use and can deal with not-null-terminated strings.  Mostly implemented so
> this can be easily reused for tls-crypt-v2 (client) key files.
> 
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
> v3: split change out of "generate client key", reuse in write_key_file()
> v4: improve doxygen and error handling (thanks to ordex)
> v5: do not print close error if open fails (thanks to ordex)
> 
>   src/openvpn/buffer.c | 31 ++++++++++++++++++++++++-------
>   src/openvpn/buffer.h | 12 ++++++++----
>   src/openvpn/crypto.c | 33 ++++++---------------------------
>   src/openvpn/crypto.h |  5 +++++
>   src/openvpn/init.c   |  4 ++++
>   5 files changed, 47 insertions(+), 38 deletions(-)
> 
> diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
> index 0972139..7630ff7 100644
> --- a/src/openvpn/buffer.c
> +++ b/src/openvpn/buffer.c
> @@ -343,16 +343,33 @@ convert_to_one_line(struct buffer *buf)
>       }
>   }
>   
> -/* NOTE: requires that string be null terminated */
> -void
> -buf_write_string_file(const struct buffer *buf, const char *filename, int fd)
> +bool
> +buffer_write_file(const char *filename, const struct buffer *buf)
>   {
> -    const int len = strlen((char *) BPTR(buf));
> -    const int size = write(fd, BPTR(buf), len);
> -    if (size != len)
> +    bool ret = false;
> +    int fd = platform_open(filename, O_CREAT | O_TRUNC | O_WRONLY,
> +                           S_IRUSR | S_IWUSR);
> +    if (fd == -1)
> +    {
> +        msg(M_ERRNO, "Cannot open file '%s' for write", filename);
> +        return false;
> +    }
> +
> +    const int size = write(fd, BPTR(buf), BLEN(buf));
> +    if (size != BLEN(buf))
>       {
> -        msg(M_ERR, "Write error on file '%s'", filename);
> +        msg(M_ERRNO, "Write error on file '%s'", filename);
> +        goto cleanup;
> +    }
> +
> +    ret = true;
> +cleanup:
> +    if (close(fd) < 0)
> +    {
> +        msg(M_ERRNO, "Close error on file %s", filename);
> +        ret = false;
>       }
> +    return ret;
>   }
>   
>   /*
> diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
> index 6b6025e..704129a 100644
> --- a/src/openvpn/buffer.h
> +++ b/src/openvpn/buffer.h
> @@ -469,11 +469,15 @@ const char *skip_leading_whitespace(const char *str);
>   
>   void string_null_terminate(char *str, int len, int capacity);
>   
> -/*
> - * Write string in buf to file descriptor fd.
> - * NOTE: requires that string be null terminated.
> +/**
> + * Write buffer contents to file.
> + *
> + * @param filename  The filename to write the buffer to.
> + * @param buf       Thu buffer to write to the file.

Thu --> The


