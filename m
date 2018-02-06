MIME-Version: 1.0
In-Reply-To: <1460475732-10951-1-git-send-email-fish.thss@...277...>
References: <1460475732-10951-1-git-send-email-fish.thss@...277...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Mon, 5 Feb 2018 19:52:29 -0500
Message-ID: <CAEsd45SVTP0gp0k=Pc=qDYhabZaVK6z8L4LYLrG_PH=cwAqFJQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Properly respond to SIGTERM received
 during DNS resolution.
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
To: Fish <fish.thss@...277...>, Arne Schwabe <arne@...1227...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi, I'd like to reopen this patch -- it seems to have gotten lost.

The patch is so old the line numbers are wrong but the code doesn't
seem to have changed.

I'm top-posting because this thread doesn't show up in the SourceForge
archive[1] (???) so I've extracted the relevant parts below. There was
some top-posting but nothing was really out-of-order, so I've tried to
make the thread intelligible and include everything relevant below.

On Tue, Apr 12, 2016 at 11:42 AM, Fish <fish.thss@...277...> wrote:
> In `link_socket_init_phase2`, it used to be the case that any received
> signal will be overwritten by SIGUSR1 if the socket cannot be created
> (e.g. when DNS resolution fails), which consequently prevents OpenVPN from
> responding to SIGTERM and exiting. This patch adds an additional check of
> whether the received signal during DNS resolution is SIGTERM or not, and
> prematurely exits from `link_socket_init_phase2` when receiving a SIGTERM.
> ---
>  src/openvpn/socket.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index 9bcf4d4..5e8abe1 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -1905,6 +1905,11 @@ link_socket_init_phase2 (struct link_socket *sock,
>             }
>         }
>
> +      if (sig_info->signal_received == SIGTERM)
> +       {
> +         goto done;
> +       }
> +
>        /* Socket still undefined, give a warning and abort connection */
>        if (sock->sd == SOCKET_UNDEFINED)
>         {

On Tue, Apr 12, 2016 at 11:46 AM, Gert Doering <gert@...1296...> wrote:
> That is the "on DNS failure, the client loops forever and is not killable"
> problem, right?
>
> (I'm not sure I'm reading the description right, to understand the
> actual issue this is fixing - but if I'm reading it right, then this
> makes sense :-)  - what about SIGINT?)


On Tue, Apr 12, 2016 at 11:48 AM, Fish Wang <fish.thss@...277...> wrote:
>
> Right, it's for the "on DNS failure, the client loops forever and is not killable" problem.


On Tue, Apr 12, 2016 at 12:25 PM, Jonathan K. Bullard
<jkbullard@...277...> wrote:
> Feature ACK; this should make DNS hangs much easier to deal with for
> GUIs such as Tunnelblick.
>
> The "hang forever" problem can be avoided by using --resolve-retry.
>

On Tue, Apr 12, 2016 at 1:18 PM, Arne Schwabe <arne@...1227...> wrote:
> Am 12.04.16 um 17:42 schrieb Fish:
>> In `link_socket_init_phase2`, it used to be the case that any received
>> signal will be overwritten by SIGUSR1 if the socket cannot be created
>> (e.g. when DNS resolution fails)
>
> That should not happen in the first place, doesn't register_signal keep
> care of not overwriting higher priority signals?

On Tue, Apr 12, 2016 at 10:07 PM, Fish Wang <fish.thss@...277...> wrote:
>
> No, the patch won't fix that issue. I may send out another patch later to fix that problem if I have free time this week.

On Tue, Apr 12, 2016 at 10:11 PM, Fish Wang <fish.thss@...277...> wrote:
> Check out the code in socket.c [1]. This is where the received signal is overwritten by SIGUSR1.
>
>       /* Socket still undefined, give a warning and abort connection */
>       if (sock->sd == SOCKET_UNDEFINED)
>         {
>           msg (M_WARN, "Could not determine IPv4/IPv6 protocol");
>           sig_info->signal_received = SIGUSR1;
>           goto done;
>         }
> [1] https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/socket.c#L1909

Note that theses lines are immediately below the patch. The last three
lines of the patch (which are not changed in the patch) are the same
as the first three lines shown above.

Best regards,

Jon Bullard

[1] https://sourceforge.net/p/openvpn/mailman/openvpn-devel/?viewmonth=201604&limit=250&style=threaded

