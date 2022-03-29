Message-ID: <67b47c41-7af6-31ca-4ad8-4c3bcd8baba9@...2669...>
Date: Wed, 30 Mar 2022 01:45:53 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220329192934.1415-1-timo@...2669...>
From: Timo Rothenpieler <timo@...2669...>
In-Reply-To: <20220329192934.1415-1-timo@...2669...>
Subject: Re: [Openvpn-devel] [PATCH] Retain CAP_NET_ADMIN when dropping
 privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 29.03.2022 21:29, Timo Rothenpieler wrote:
> +static bool
> +do_keep_caps(bool prepare)
> +{
> +    struct __user_cap_header_struct cap_hdr = { _LINUX_CAPABILITY_VERSION_3 };
> +    struct __user_cap_data_struct cap_data[_LINUX_CAPABILITY_U32S_3] = {};
> +
> +    if (syscall(SYS_capget, &cap_hdr, cap_data) < 0)
> +    {
> +        msg(M_NONFATAL | M_ERRNO, "failed getting capabilities");
> +        return false;
> +    }
> +
> +    if (prepare)
> +    {
> +        SET_CAP_HELPER(cap_data, permitted, CAP_NET_ADMIN);
> +    }
> +    else
> +    {
> +        SET_CAP_HELPER(cap_data, effective, CAP_NET_ADMIN);

This is missing something like the following:

>         /* Clamp permitted capabilities to effective ones.
>          * Without doing this, the process can give itself root-like caps at any time. */
>         for (int i = 0; i < sizeof(cap_data)/sizeof(cap_data[0]); i++)
>         {
>             cap_data[i].permitted = cap_data[i].effective;
>         }

Without that, the permitted caps stay the full set of root caps, and the 
process can make them effective at any time.

Patch on GitHub is updated with that.

> +    }
> +
> +    if (syscall(SYS_capset, &cap_hdr, cap_data) < 0)
> +    {
> +        msg(M_NONFATAL | M_ERRNO, "failed setting %s capabilities", prepare ? "permitted" : "effective");
> +        return false;
> +    }
> +
> +    if (prepare && prctl(PR_SET_KEEPCAPS, 1) < 0)
> +    {
> +        msg(M_NONFATAL | M_ERRNO, "failed setting keepcaps");
> +        return false;
> +    }
> +
> +    return true;
> +}

