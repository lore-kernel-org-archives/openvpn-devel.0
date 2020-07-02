MIME-Version: 1.0
References: <20200702125224.13516-1-arne@...1227...>
In-Reply-To: <20200702125224.13516-1-arne@...1227...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 2 Jul 2020 16:16:23 +0300
Message-ID: <CAGyAFMWy3izmMjUhpSnwM+C5fiy51XjytMr5r9T=o7SheiKHag@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Remove push_reply_deferred variable
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Explanation makes sense - double checked that this is indeed the case.

Compiled and smoke-tested.

Acked-by: Lev Stipakov <lstipakov@...277...>

to 2. hein=C3=A4k. 2020 klo 15.53 Arne Schwabe (arne@...1227...) kirjoitti:
>
> The variable has no useful function (anymore?).
>
> There is only one place where this variable was checked
>
>     else if (!c->c2.push_reply_deferred && c->c2.context_auth =3D=3D CAS_=
SUCCEEDED)
>
> This condition also depends on context_auth =3D=3D CAS_SUCCEEDED but the =
only
> code path that sets context_auth =3D CAS_SUCCEEDED also sets
> push_reply_deferred =3D false;
>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/multi.c   | 7 -------
>  src/openvpn/openvpn.h | 1 -
>  src/openvpn/push.c    | 2 +-
>  3 files changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 95b16744..138701a9 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -828,8 +828,6 @@ multi_create_instance(struct multi_context *m, const =
struct mroute_addr *real)
>      mi->did_cid_hash =3D true;
>  #endif
>
> -    mi->context.c2.push_reply_deferred =3D true;
> -
>  #ifdef ENABLE_ASYNC_PUSH
>      mi->context.c2.push_request_received =3D false;
>      mi->inotify_watch =3D -1;
> @@ -2109,11 +2107,6 @@ script_failed:
>
>          gc_free(&gc);
>      }
> -
> -    /*
> -     * Reply now to client's PUSH_REQUEST query
> -     */
> -    mi->context.c2.push_reply_deferred =3D false;
>  }
>
>  #ifdef ENABLE_ASYNC_PUSH
> diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
> index 1afc3a92..4609af3e 100644
> --- a/src/openvpn/openvpn.h
> +++ b/src/openvpn/openvpn.h
> @@ -432,7 +432,6 @@ struct context_2
>  #if P2MP
>
>      /* --ifconfig endpoints to be pushed to client */
> -    bool push_reply_deferred;
>  #ifdef ENABLE_ASYNC_PUSH
>      bool push_request_received;
>  #endif
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index 369cd6a4..56d652a3 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -803,7 +803,7 @@ process_incoming_push_request(struct context *c)
>          send_auth_failed(c, client_reason);
>          ret =3D PUSH_MSG_AUTH_FAILURE;
>      }
> -    else if (!c->c2.push_reply_deferred && c->c2.context_auth =3D=3D CAS=
_SUCCEEDED)
> +    else if (c->c2.context_auth =3D=3D CAS_SUCCEEDED)
>      {
>          time_t now;
>
> --
> 2.26.2
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



--=20
-Lev

