Message-Id: <200303160229.h2G2TG405668@...41...>
Subject: Re: [Openvpn-devel] New pre-1.3.3 beta
From: "James Yonan" <jim@...41...>
In-Reply-To: <20030315224500.GA24746@...33...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sat Mar 15 18:30:15 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Matthias Andree <ma+ovpnd@...31...>, openvpn-devel@lists.sourceforge.net

Matthias,

Patch looks good, though why the dummy() functions?  They generate warnings on
gcc 2.96 if you build with --disable-lzo, --disable-crypto, etc.  Some
compiler that doesn't like empty source files?

James

Matthias Andree <ma+ovpnd@...31...> said:

> On Sat, 15 Mar 2003, James Yonan wrote:
> 
> > Yes, I think we should try to fix if it's only a trivial cast involved to
> > silence the warning.
> > 
> > I don't see them on gcc 2.96, even with "-Wall -W -Wpointer-arith
> > -Wsign-compare -Winline".
> 
> Indeed, it takes the sun compiler or the even more picky splint utility
> (www.splint.org) to see them.
> 
> The patch below doesn't fix
> "crypto.c", line 228: warning: end-of-loop code not reached
> 
> also on ll. 237 259 269 273 277 281 286 299 312 327.
> 
> Fixing that would require a rewrite of crypto.c, the issue is the
> 
> do { goto ...; } while(false);
> 
> I'm not fixing this and I don't recommend changing that at this time
> (after 1.3.3 maybe, if you're to fix that at all).
> 
> Here's the patch:
> 
> # buffer.c     |   14 +++++++-------
> # crypto.c     |   12 ++++++------
> # error.c      |    2 +-
> # lzo.c        |    2 ++
> # misc.c       |    2 +-
> # packet_id.c  |    4 ++--
> # reliable.c   |    2 ++
> # session_id.c |    2 ++
> # socket.c     |    4 ++--
> # ssl.c        |    6 ++++--
> # thread.c     |    2 ++
> # tun.c        |    4 ++--
> # 12 files changed, 33 insertions(+), 23 deletions(-)
> 
> Index: buffer.c
> ===================================================================
> RCS file: /cvsroot/openvpn/openvpn/buffer.c,v
> retrieving revision 1.11
> diff -u -r1.11 buffer.c
> --- buffer.c	15 Mar 2003 07:18:00 -0000	1.11
> +++ buffer.c	15 Mar 2003 22:42:02 -0000
> @@ -115,14 +115,14 @@
>  {
>    va_list arglist;
>  
> -  char *ptr = BEND (buf);
> +  uint8_t *ptr = BEND (buf);
>    int cap = buf_forward_capacity (buf);
>  
>    va_start (arglist, format);
> -  vsnprintf (ptr, cap, format, arglist);
> +  vsnprintf ((char *)ptr, cap, format, arglist);
>    va_end (arglist);
>  
> -  buf->len += strlen (ptr);
> +  buf->len += strlen ((char *)ptr);
>  }
>  
>  /*
> @@ -137,7 +137,7 @@
>        int len = strlen (str) + 1;
>        if (len < buf_forward_capacity_total (buf))
>  	{
> -	  strncpynt (buf->data + buf->capacity - len, str, len);
> +	  strncpynt ((char *)(buf->data + buf->capacity - len), str, len);
>  	}
>      }
>  }
> @@ -148,7 +148,7 @@
>  void
>  convert_to_one_line (struct buffer *buf)
>  {
> -  char *cp = BPTR(buf);
> +  uint8_t *cp = BPTR(buf);
>    int len = BLEN(buf);
>    while (len--)
>      {
> @@ -185,7 +185,7 @@
>    struct gc_entry *e;
>    struct gc_thread* thread = &x_gc_thread[thread_number()];
>  
> -  while (e = thread->gc_stack)
> +  while ((e = thread->gc_stack))
>      {
>        if (e->level < level)
>  	break;
> @@ -235,5 +235,5 @@
>        buf_printf (&out, "%02x", data[i]);
>      }
>    buf_catrunc (&out, "[more...]");
> -  return out.data;
> +  return (char *)out.data;
>  }
> Index: crypto.c
> ===================================================================
> RCS file: /cvsroot/openvpn/openvpn/crypto.c,v
> retrieving revision 1.14
> diff -u -r1.14 crypto.c
> --- crypto.c	21 Feb 2003 16:14:05 -0000	1.14
> +++ crypto.c	15 Mar 2003 22:42:03 -0000
> @@ -184,7 +184,7 @@
>  	  HMAC_Update (ctx->hmac, BPTR (&work), BLEN (&work));
>  	  output = buf_prepend (&work, HMAC_size (ctx->hmac));
>  	  ASSERT (output);
> -	  HMAC_Final (ctx->hmac, output, &hmac_len);
> +	  HMAC_Final (ctx->hmac, output, (unsigned int *)&hmac_len);
>  	  ASSERT (hmac_len == HMAC_size (ctx->hmac));
>  	}
>  
> @@ -229,7 +229,7 @@
>  
>  	  HMAC_Update (ctx->hmac, BPTR (buf) + hmac_len,
>  		       BLEN (buf) - hmac_len);
> -	  HMAC_Final (ctx->hmac, local_hmac, &in_hmac_len);
> +	  HMAC_Final (ctx->hmac, local_hmac, (unsigned int *)&in_hmac_len);
>  	  ASSERT (hmac_len == in_hmac_len);
>  
>  	  /* Compare locally computed HMAC with packet HMAC */
> @@ -883,9 +883,9 @@
>    if (fd == -1)
>      msg (M_ERR, "Cannot open shared secret file %s", filename);
>  
> -  while (size = read (fd, in.data, in.capacity))
> +  while ((size = read (fd, in.data, in.capacity)))
>      {
> -      const char *cp = in.data;
> +      const char *cp = (char *)in.data;
>        while (size)
>  	{
>  	  const char c = *cp;
> @@ -923,7 +923,7 @@
>  		    if (hb_index == 2)
>  		      {
>  			unsigned int u;
> -			ASSERT(sscanf(hex_byte, "%x", &u) == 1);
> +			ASSERT(sscanf((const char *)hex_byte, "%x", &u) == 1);
>  			*out++ = u;
>  			hb_index = 0;
>  			if (++count == keylen)
> @@ -982,7 +982,7 @@
>    buf_printf (&out, "%s\n", static_key_foot);
>  
>    /* write data to file */
> -  len = strlen (BPTR(&out));
> +  len = strlen ((char *)BPTR(&out));
>    size = write (fd, BPTR(&out), len);
>    if (size != len)
>      msg (M_ERR, "Write error on shared secret file %s", filename);
> Index: error.c
> ===================================================================
> RCS file: /cvsroot/openvpn/openvpn/error.c,v
> retrieving revision 1.15
> diff -u -r1.15 error.c
> --- error.c	15 Mar 2003 07:18:00 -0000	1.15
> +++ error.c	15 Mar 2003 22:42:03 -0000
> @@ -177,7 +177,7 @@
>      {
>        int nerrs = 0;
>        int err;
> -      while (err = ERR_get_error ())
> +      while ((err = ERR_get_error ()))
>  	{
>  	  snprintf (m2, ERR_BUF_SIZE, "%s: %s", m1, ERR_error_string (err, NULL));
>  	  SWAP;
> Index: lzo.c
> ===================================================================
> RCS file: /cvsroot/openvpn/openvpn/lzo.c,v
> retrieving revision 1.11
> diff -u -r1.11 lzo.c
> --- lzo.c	21 Feb 2003 16:14:06 -0000	1.11
> +++ lzo.c	15 Mar 2003 22:42:03 -0000
> @@ -239,4 +239,6 @@
>    msg (M_INFO, " post-decompress bytes:" counter_format,
lzo_compwork->post_decompress);
>  }
>  
> +#else
> +static void dummy(void) {}
>  #endif /* USE_LZO */
> Index: misc.c
> ===================================================================
> RCS file: /cvsroot/openvpn/openvpn/misc.c,v
> retrieving revision 1.15
> diff -u -r1.15 misc.c
> --- misc.c	21 Feb 2003 16:14:06 -0000	1.15
> +++ misc.c	15 Mar 2003 22:42:03 -0000
> @@ -285,7 +285,7 @@
>        else
>  	buf_printf (&out, "shell command exited with error status: %d", cmd_ret);
>      }
> -  return out.data;
> +  return (const char *)out.data;
>  }
>  
>  /*
> Index: packet_id.c
> ===================================================================
> RCS file: /cvsroot/openvpn/openvpn/packet_id.c,v
> retrieving revision 1.11
> diff -u -r1.11 packet_id.c
> --- packet_id.c	21 Feb 2003 16:14:06 -0000	1.11
> +++ packet_id.c	15 Mar 2003 22:42:03 -0000
> @@ -124,7 +124,7 @@
>      }
>  
>    buf_printf (&out, " ]");
> -  return out.data;
> +  return (char *)out.data;
>  }
>  
>  /* initialize the packet_id_persist structure in a disabled state */
> @@ -265,7 +265,7 @@
>      }
>  
>    buf_printf (&out, " ]");
> -  return out.data;
> +  return (char *)out.data;
>  }
>  
>  #ifdef PID_TEST
> Index: reliable.c
> ===================================================================
> RCS file: /cvsroot/openvpn/openvpn/reliable.c,v
> retrieving revision 1.10
> diff -u -r1.10 reliable.c
> --- reliable.c	21 Feb 2003 16:14:06 -0000	1.10
> +++ reliable.c	15 Mar 2003 22:42:03 -0000
> @@ -500,4 +500,6 @@
>  
>  #endif
>  
> +#else
> +static void dummy(void) {}
>  #endif /* USE_CRYPTO && USE_SSL*/
> Index: session_id.c
> ===================================================================
> RCS file: /cvsroot/openvpn/openvpn/session_id.c,v
> retrieving revision 1.4
> diff -u -r1.4 session_id.c
> --- session_id.c	21 Feb 2003 16:14:06 -0000	1.4
> +++ session_id.c	15 Mar 2003 22:42:03 -0000
> @@ -60,4 +60,6 @@
>    return format_hex (sid->id, SID_SIZE, 0);
>  }
>  
> +#else
> +static void dummy(void) {}
>  #endif /* USE_CRYPTO && USE_SSL*/
> Index: socket.c
> ===================================================================
> RCS file: /cvsroot/openvpn/openvpn/socket.c,v
> retrieving revision 1.17
> diff -u -r1.17 socket.c
> --- socket.c	15 Mar 2003 07:18:00 -0000	1.17
> +++ socket.c	15 Mar 2003 22:42:04 -0000
> @@ -255,7 +255,7 @@
>  	    {
>  	      char command[256];
>  	      struct buffer out;
> -	      buf_set_write (&out, command, sizeof (command));
> +	      buf_set_write (&out, (uint8_t *)command, sizeof (command));
>  	      buf_printf (&out, "%s %s",
>  			  sock->ipchange_command,
>  			  print_sockaddr_ex (&usa->actual, true, " "));
> @@ -356,5 +356,5 @@
>  
>        buf_printf (&out, "%d", port);
>      }
> -  return out.data;
> +  return (char *)out.data;
>  }
> Index: ssl.c
> ===================================================================
> RCS file: /cvsroot/openvpn/openvpn/ssl.c,v
> retrieving revision 1.30
> diff -u -r1.30 ssl.c
> --- ssl.c	15 Mar 2003 07:18:00 -0000	1.30
> +++ ssl.c	15 Mar 2003 22:42:05 -0000
> @@ -228,7 +228,7 @@
>  system_safe_string (char *cp)
>  {
>    int c;
> -  while (c = *cp)
> +  while ((c = *cp))
>      {
>        if (isalnum (c)
>  	  || c == '/'
> @@ -494,7 +494,7 @@
>  
>    printf ("Available TLS Ciphers,\n");
>    printf ("listed in order of preference:\n\n");
> -  while (cipher_name = SSL_get_cipher_list (ssl, priority++))
> +  while ((cipher_name = SSL_get_cipher_list (ssl, priority++)))
>      printf ("%s\n", cipher_name);
>    printf ("\n");
>  
> @@ -2491,4 +2491,6 @@
>    return out.data;
>  }
>  
> +#else
> +static void dummy(void) {}
>  #endif /* USE_CRYPTO && USE_SSL*/
> Index: thread.c
> ===================================================================
> RCS file: /cvsroot/openvpn/openvpn/thread.c,v
> retrieving revision 1.4
> diff -u -r1.4 thread.c
> --- thread.c	21 Feb 2003 16:14:06 -0000	1.4
> +++ thread.c	15 Mar 2003 22:42:05 -0000
> @@ -175,4 +175,6 @@
>      }
>  }
>  
> +#else
> +static void dummy(void) {}
>  #endif
> Index: tun.c
> ===================================================================
> RCS file: /cvsroot/openvpn/openvpn/tun.c,v
> retrieving revision 1.25
> diff -u -r1.25 tun.c
> --- tun.c	15 Mar 2003 07:18:00 -0000	1.25
> +++ tun.c	15 Mar 2003 22:42:05 -0000
> @@ -609,7 +609,7 @@
>  {
>    struct strbuf sbuf;
>    sbuf.len = len;
> -  sbuf.buf = buf;
> +  sbuf.buf = (char *)buf;
>    return putmsg (tt->fd, NULL, &sbuf, 0) >= 0 ? sbuf.len : -1;
>  }
>  
> @@ -620,7 +620,7 @@
>    int f = 0;
>  
>    sbuf.maxlen = len;
> -  sbuf.buf = buf;
> +  sbuf.buf = (char *)buf;
>    return getmsg (tt->fd, NULL, &sbuf, &f) >= 0 ? sbuf.len : -1;
>  }
>  
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by:Crypto Challenge is now open! 
> Get cracking and register here for some mind boggling fun and 
> the chance of winning an Apple iPod:
> http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 



-- 




