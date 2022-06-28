MIME-Version: 1.0
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-23-a@...2181...>
In-Reply-To: <20220624083809.23487-23-a@...2181...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 28 Jun 2022 11:36:21 +0300
Message-ID: <CAGyAFMXO48aOzzEgTpn63WcH=hha1sT6bUr+Cv3DaAOB6Fcajg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 22/25] dco-win: introduce low-level code
 for handling ovpn-dco-win in Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

I did some review / testing and suggest following changes to this patch:

> +    if (!DeviceIoControl(tt->hand, OVPN_IOCTL_START_VPN, NULL, 0, NULL, 0,
> +                         &bytes_returned, NULL))
> +    {
> +        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_START_VPN) failed with code %lu",
> +            GetLastError());
> +    }

Since recently openvpn correctly handles Win32 errors (doesn't mix
them with CRT errors)
so this could be simplified like:

  msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_START_VPN) failed");

M_ERR prints error message along with error code.

<snip>

> +            /* dco reported connection error */
> +            struct gc_arena gc = gc_new();
> +            msg(M_NONFATAL, "%s: %s", __func__, strerror_win32(err, &gc));
> +            *signal_received = SIGUSR1;
> +            gc_free(&gc);

Ditto, so

  msg(M_NONFATAL | M_ERRNO, "dco connect error");

(no need to instantiate gc_arena)

<snip>

> +    /* we end up here when timeout occurs in userspace */
> +    msg(M_NONFATAL, "%s: dco connect timeout", __func__);

I would just use

  msg(M_NONFATAL, "dco connect timeout");

<snip>

> +        if (err != ERROR_IO_PENDING)
> +        {
> +            msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_NEW_PEER) failed with code %lu", err);
> +        }

Ditto:

  msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_NEW_PEER) failed");

<snip>

> +    DWORD bytes_returned = 0;
> +    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_SET_PEER, &peer,
> +                         sizeof(peer), NULL, 0, &bytes_returned, NULL))
> +    {
> +        msg(M_WARN, "DeviceIoControl(OVPN_IOCTL_SET_PEER) failed with code %lu", GetLastError());
> +        return -1;
> +    }

Ditto:

  msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_SET_PEER) failed");

<snip>

> +        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_NEW_KEY) failed with code %lu",
> +            GetLastError());

Same as above:

  msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_NEW_KEY) failed");

<snip>

> +        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_SWAP_KEYS) failed with code %lu",
> +            GetLastError());

Ditto:

  msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_SWAP_KEYS) failed");

We have discussed all those changes in chat and a new version with the
changes is pushed to the dco branch.

-Lev

