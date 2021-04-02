Message-ID: <b92f02afa4d8156edd55c2126ae6352c.squirrel@...2260...>
In-Reply-To: <20210402134529.27866-1-gert@...1296...>
References: <20210402134529.27866-1-gert@...1296...>
Date: Fri, 2 Apr 2021 20:35:36 +0200
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Fix 'compress migrate' for 2.2 clients.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

> Commit 8fa8a17528c001a introduces "compress migrate" to move old clients
> that have "compress" or "comp-lzo" in their config towards a connection
> without compression.  This is done by looking at incoming OCC strings
> to see if the client has compression enabled, and at incoming IV_
> strings to see whether it can do "compress stub-v2" or needs to be sent
> "comp-lzo no".

Hi,

What I'm still wondering is why is compression so dangerous with OpenVPN
but not so with things like SSH or SCP?

Say I connect from my client to my server via SSH with compression is
fine. Doing the same trough an OpenVPN tunnel with compression using an
unencrypting tool like telnet is considered dangerous. I fail to
understand how the SSH tunnel can be considered okay and the OpenVPN
tunnel is not?

I've read a lot of the CRIME and BREACH stuff but still don't really
understand.

Thanks,
Simon

>
> That check fails for 2.2 clients that do not send *any* peer-info by
> default, so the server will not push back any "disable compression"
> command.  It works if the client connects with "--push-peer-info".
>
> Fix: turn around the order of checks, treat "no peer_info" the same
> as "peer_info does not contain IV_COMP_STUBv2".
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/multi.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 5c495036..56b4fc0d 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -2485,14 +2485,9 @@ multi_client_connect_compress_migrate(struct
> multi_context *m,
>      struct options *o =3D &mi->context.options;
>      const char *const peer_info =3D mi->context.c2.tls_multi->peer_info;
>
> -    if (!peer_info)
> -    {
> -        return CC_RET_SUCCEEDED;
> -    }
> -
>      if (o->comp.flags & COMP_F_MIGRATE &&
> mi->context.c2.tls_multi->remote_usescomp)
>      {
> -        if(strstr(peer_info, "IV_COMP_STUBv2=3D1"))
> +        if(peer_info && strstr(peer_info, "IV_COMP_STUBv2=3D1"))
>          {
>              push_option(o, "compress stub-v2", M_USAGE);
>          }
> --
> 2.26.3
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>



