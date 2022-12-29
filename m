MIME-Version: 1.0
References: <20221229040717.1471276-1-selva.nair@...277...>
In-Reply-To: <20221229040717.1471276-1-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 29 Dec 2022 13:13:48 +0200
Message-ID: <CAGyAFMUTdG9+nKzwoSge88P5U7=u4Pk_sHz2SiEhgAXWjbkUXA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Properly unmap ring buffer file-map in
 interactive service
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
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

Hi,

> The return value of MapViewOfFile must be passed to UnmapViewofFile,
> instead of the file handle.

Good catch!

> Fixes #206

Strangely enough, I am not able to reproduce this bug - I posted logs
to the GitHub issue.

Fix indeed makes sense. Indeed, according to docs, UnmapViewOfFile()
accepts return value from MapViewOfFile(),
not from CreateFileMapping(), like it is implemented in interactive
service. Interesting that in tun.c implementation
is correct.

> -    if (handle && *handle && *handle != INVALID_HANDLE_VALUE)
> +    if (ring && *ring)
>      {
> -        UnmapViewOfFile(*handle);
> -        *handle = INVALID_HANDLE_VALUE;
> +        UnmapViewOfFile(*ring);
>      }
> -    return INVALID_HANDLE_VALUE;
> +    *ring = NULL;

It makes sense to move NULL assignment inside if { } to handle
unlikely case when the passed "ring" is NULL.

