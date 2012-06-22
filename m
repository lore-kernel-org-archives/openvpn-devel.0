Message-ID: <4FE447BF.1040004@...515...>
Date: Fri, 22 Jun 2012 13:23:59 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1336462203-20226-1-git-send-email-adrien@...1716...>
	<1336462203-20226-2-git-send-email-adrien@...1716...>
In-Reply-To: <1336462203-20226-2-git-send-email-adrien@...1716...>
Subject: Re: [Openvpn-devel] [PATCH] management: Don't require
 DAF_INITIAL_AUTH to send ADDRESS/DISCONNECT messages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Adrien Bustany <adrien@...1716...>
Cc: Adrien Bustany <adrien.bustany@...1719...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> From: Adrien Bustany <adrien.bustany@...1719...>
>
> DAF_INITIAL_AUTH will only be set if a password was needed for client
> authentication. This means that for password-less certificate
> authentication, no DISCONNECT/ADDRESS messages would be sent.
> ---
>  src/openvpn/manage.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
> index 1dddd41..4148f7c 100644
> --- a/src/openvpn/manage.c
> +++ b/src/openvpn/manage.c
> @@ -2474,7 +2474,7 @@ management_notify_client_close (struct management *=
management,
>  				struct man_def_auth_context *mdac,
>  				const struct env_set *es)
>  {
> -  if ((mdac->flags & DAF_INITIAL_AUTH) && !(mdac->flags & DAF_CONNECTION=
_CLOSED))
> +  if (!(mdac->flags & DAF_CONNECTION_CLOSED))
>      {
>        msg (M_CLIENT, ">CLIENT:DISCONNECT,%lu", mdac->cid);
>        man_output_env (es, true, management->connection.env_filter_level,=
 "CLIENT");
> @@ -2489,7 +2489,7 @@ management_learn_addr (struct management *managemen=
t,
>  		       const bool primary)
>  {
>    struct gc_arena gc =3D gc_new ();
> -  if ((mdac->flags & DAF_INITIAL_AUTH) && !(mdac->flags & DAF_CONNECTION=
_CLOSED))
> +  if (!(mdac->flags & DAF_CONNECTION_CLOSED))
>      {
>        msg (M_CLIENT, ">CLIENT:ADDRESS,%lu,%s,%d",
>  	   mdac->cid,
Hi Adrien,

We discussed this patch in our IRC meeting yesterday, and couple of
questions popped up... First, what is the benefit of this patch? Is it
just to see if the clients connect even if they're not using password
authentication? Second, what's the impact on existing management
interface clients, i.e. can this patch break compatibility?

Best regards,

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


