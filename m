Message-ID: <4552F02F.9040009@...41...>
Date: Thu, 09 Nov 2006 02:09:03 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <200611081343.07350.uberlord@...594...>	<200611081421.27156.roy@...876...>
	<200611081428.16714.roy@...876...>
In-Reply-To: <200611081428.16714.roy@...876...>
Subject: Re: [Openvpn-devel] [PATCH] txqueuelen for persistent interfaces
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Roy Marples <roy@...876...>
Cc: openvpn-devel@lists.sourceforge.net

Roy Marples wrote:
> On Wednesday 08 November 2006 14:21, Roy Marples wrote:
>   
>> On Wednesday 08 November 2006 13:43, Roy Marples wrote:
>>     
>>> Hi.
>>>
>>> openvpn does not apply the --txqueuelen option to persistent interfaces
>>> made with --mktun [1]
>>>
>>> Attached are patches to 2.0.7 and 2.1_rc1 that fix the issue.
>>>
>>> Thanks!
>>>
>>> [1] http://bugs.gentoo.org/show_bug.cgi?id=150791
>>>       
>> And here are the patches - oops!
>>     
>
> mailing list appears to be stripping attachments
> Included inline
>
> diff -u /tmp/openvpn-2.0.7/init.c openvpn-2.0.7/init.c
> --- openvpn-2.0.7/init.c        2006-11-08 13:33:02.043877584 +0000
> +++ openvpn-2.0.7/init.c        2006-11-08 13:33:24.000000000 +0000
> @@ -347,7 +347,8 @@
>         msg (M_FATAL|M_OPTERR,
>              "options --mktun or --rmtun should only be used together 
> with --dev");
>        tuncfg (options->dev, options->dev_type, options->dev_node,
> -             options->tun_ipv6, options->persist_mode);
> +             options->tun_ipv6, options->persist_mode,
> +             &options->tuntap_options);
>        return true;
>      }
>  #endif
> diff -u /tmp/openvpn-2.0.7/tun.c openvpn-2.0.7/tun.c
> --- openvpn-2.0.7/tun.c 2006-11-08 13:33:02.037878496 +0000
> +++ openvpn-2.0.7/tun.c 2006-11-08 13:34:20.000000000 +0000
> @@ -1095,13 +1095,14 @@
>  #ifdef TUNSETPERSIST
>
>  void
> -tuncfg (const char *dev, const char *dev_type, const char *dev_node, bool 
> ipv6, int persist_mode)
> +tuncfg (const char *dev, const char *dev_type, const char *dev_node, bool 
> ipv6, int persist_mode, const struct tuntap_options *options)
>  {
>    struct tuntap *tt;
>
>    ALLOC_OBJ (tt, struct tuntap);
>    clear_tuntap (tt);
>    tt->type = dev_type_enum (dev, dev_type);
> +  tt->options = *options;
>    open_tun (dev, dev_type, dev_node, ipv6, tt);
>    if (ioctl (tt->fd, TUNSETPERSIST, persist_mode) < 0)
>      msg (M_ERR, "Cannot ioctl TUNSETPERSIST(%d) %s", persist_mode, dev);
> diff -u /tmp/openvpn-2.0.7/tun.h openvpn-2.0.7/tun.h
> --- openvpn-2.0.7/tun.h 2006-11-08 13:33:02.042877736 +0000
> +++ openvpn-2.0.7/tun.h 2006-11-08 13:33:50.000000000 +0000
> @@ -194,7 +194,7 @@
>  int read_tun (struct tuntap* tt, uint8_t *buf, int len);
>
>  void tuncfg (const char *dev, const char *dev_type, const char *dev_node,
> -            bool ipv6, int persist_mode);
> +            bool ipv6, int persist_mode, const struct tuntap_options 
> *options);
>
>  const char *guess_tuntap_dev (const char *dev,
>
>
>
> diff -u openvpn-2.1_rc1/init.c /tmp/openvpn-2.1_rc1/init.c
> --- openvpn-2.1_rc1/init.c      2006-10-15 23:30:20.000000000 +0100
> +++ openvpn-2.1_rc1/init.c      2006-11-08 13:25:04.136530544 +0000
> @@ -425,7 +425,8 @@
>         msg (M_FATAL|M_OPTERR,
>              "options --mktun or --rmtun should only be used together 
> with --dev");
>        tuncfg (options->dev, options->dev_type, options->dev_node,
> -             options->tun_ipv6, options->persist_mode);
> +             options->tun_ipv6, options->persist_mode,
> +             &options->tuntap_options);
>        if (options->persist_mode && options->lladdr)
>          set_lladdr(options->dev, options->lladdr, NULL);
>        return true;
> diff -u openvpn-2.1_rc1/tun.c /tmp/openvpn-2.1_rc1/tun.c
> --- openvpn-2.1_rc1/tun.c       2006-10-15 23:30:20.000000000 +0100
> +++ openvpn-2.1_rc1/tun.c       2006-11-08 13:25:04.129531608 +0000
> @@ -1163,13 +1163,14 @@
>  #ifdef TUNSETPERSIST
>
>  void
> -tuncfg (const char *dev, const char *dev_type, const char *dev_node, bool 
> ipv6, int persist_mode)
> +tuncfg (const char *dev, const char *dev_type, const char *dev_node, bool 
> ipv6, int persist_mode, const struct tuntap_options *options)
>  {
>    struct tuntap *tt;
>
>    ALLOC_OBJ (tt, struct tuntap);
>    clear_tuntap (tt);
>    tt->type = dev_type_enum (dev, dev_type);
> +  tt->options = *options;
>    open_tun (dev, dev_type, dev_node, ipv6, tt);
>    if (ioctl (tt->fd, TUNSETPERSIST, persist_mode) < 0)
>      msg (M_ERR, "Cannot ioctl TUNSETPERSIST(%d) %s", persist_mode, dev);
> diff -u openvpn-2.1_rc1/tun.h /tmp/openvpn-2.1_rc1/tun.h
> --- openvpn-2.1_rc1/tun.h       2006-10-15 23:30:20.000000000 +0100
> +++ openvpn-2.1_rc1/tun.h       2006-11-08 13:25:04.135530696 +0000
> @@ -204,7 +204,7 @@
>  int read_tun (struct tuntap* tt, uint8_t *buf, int len);
>
>  void tuncfg (const char *dev, const char *dev_type, const char *dev_node,
> -            bool ipv6, int persist_mode);
> +            bool ipv6, int persist_mode, const struct tuntap_options 
> *options);
>
>  const char *guess_tuntap_dev (const char *dev,
>                               const char *dev_type,
>
>
>   

Roy -- thanks for fixing this, I will include in 2.1_rc2.  Regarding the 
problem with attachments, I believe I have fixed it -- it was a 
misconfigured content filter in mailman.

James


