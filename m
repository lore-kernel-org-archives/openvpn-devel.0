MIME-Version: 1.0
References: <20230830130502.1029-1-sandro.trianni@...277...>
 <ac830908-d0db-0d85-c32f-4f1a67704e1b@...2181...>
In-Reply-To: <ac830908-d0db-0d85-c32f-4f1a67704e1b@...2181...>
Reply-To: sandro.trianni@...277...
From: Sandro Trianni <sandro.trianni@...277...>
Date: Wed, 30 Aug 2023 22:56:41 +0200
Message-ID: <CAOMrfw+OH6_nMKdSNL3-+OQweyXnx45Jft3PiOGURJmz-fH1pw@...278...>
Content-Type: multipart/alternative; boundary="000000000000ea950906042a2a30"
Subject: Re: [Openvpn-devel] [PATCH] Implement server_poll_timeout for socks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

--000000000000ea950906042a2a30
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your feedback! I'm used to describing my patches in pull
requests. Submitting it via mailing list was new to me, sorry. I hope this
reply ends up in the right thread. The patch is regarding this 10 year old
Bug https://community.openvpn.net/openvpn/ticket/328
Hardcoded 5 sec timeout is too low for slow proxies, especially over Tor.
The server-poll-timeout option was supposed to fix it, but was only
implemented for http proxies.
Cheers

On Wed, Aug 30, 2023 at 10:31=E2=80=AFPM Antonio Quartulli <a@...2181...> w=
rote:

> Hi Sandro,
>
> at a first glance the patch looks reasonable.
> However, we truly need you to write some commit message explaining what
> your patch is fixing/implementing, why it is doing so and what problem
> it solves.
>
> Cheers,
>
> On 30/08/2023 15:05, 5andr0 wrote:
> > ---
> >   src/openvpn/socket.c |  2 ++
> >   src/openvpn/socks.c  | 25 ++++++++++++++-----------
> >   src/openvpn/socks.h  |  2 ++
> >   3 files changed, 18 insertions(+), 11 deletions(-)
> >
> > diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> > index 501e023e..10fd0e26 100644
> > --- a/src/openvpn/socket.c
> > +++ b/src/openvpn/socket.c
> > @@ -2075,6 +2075,7 @@ phase2_tcp_client(struct link_socket *sock, struct
> signal_info *sig_info)
> >                                              sock->sd,
> >                                              sock->proxy_dest_host,
> >                                              sock->proxy_dest_port,
> > +                                           sock->server_poll_timeout,
> >                                              sig_info);
> >           }
> >           if (proxy_retry)
> > @@ -2104,6 +2105,7 @@ phase2_socks_client(struct link_socket *sock,
> struct signal_info *sig_info)
> >                                      sock->ctrl_sd,
> >                                      sock->sd,
> >                                      &sock->socks_relay.dest,
> > +                                   sock->server_poll_timeout,
> >                                      sig_info);
> >
> >       if (sig_info->signal_received)
> > diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
> > index a29eb83a..2cb83a66 100644
> > --- a/src/openvpn/socks.c
> > +++ b/src/openvpn/socks.c
> > @@ -42,6 +42,7 @@
> >   #include "fdmisc.h"
> >   #include "misc.h"
> >   #include "proxy.h"
> > +#include "forward.h"
> >
> >   #include "memdbg.h"
> >
> > @@ -85,12 +86,12 @@ socks_proxy_close(struct socks_proxy_info *sp)
> >   static bool
> >   socks_username_password_auth(struct socks_proxy_info *p,
> >                                socket_descriptor_t sd,
> > +                             struct event_timeout *server_poll_timeout,
> >                                volatile int *signal_received)
> >   {
> >       char to_send[516];
> >       char buf[2];
> >       int len =3D 0;
> > -    const int timeout_sec =3D 5;
> >       struct user_pass creds;
> >       ssize_t size;
> >       bool ret =3D false;
> > @@ -129,7 +130,7 @@ socks_username_password_auth(struct socks_proxy_info
> *p,
> >
> >           FD_ZERO(&reads);
> >           openvpn_fd_set(sd, &reads);
> > -        tv.tv_sec =3D timeout_sec;
> > +        tv.tv_sec =3D get_server_poll_remaining_time(server_poll_timeo=
ut);
> >           tv.tv_usec =3D 0;
> >
> >           status =3D select(sd + 1, &reads, NULL, NULL, &tv);
> > @@ -185,11 +186,11 @@ cleanup:
> >   static bool
> >   socks_handshake(struct socks_proxy_info *p,
> >                   socket_descriptor_t sd,
> > +                struct event_timeout *server_poll_timeout,
> >                   volatile int *signal_received)
> >   {
> >       char buf[2];
> >       int len =3D 0;
> > -    const int timeout_sec =3D 5;
> >       ssize_t size;
> >
> >       /* VER =3D 5, NMETHODS =3D 1, METHODS =3D [0 (no auth)] */
> > @@ -216,7 +217,7 @@ socks_handshake(struct socks_proxy_info *p,
> >
> >           FD_ZERO(&reads);
> >           openvpn_fd_set(sd, &reads);
> > -        tv.tv_sec =3D timeout_sec;
> > +        tv.tv_sec =3D get_server_poll_remaining_time(server_poll_timeo=
ut);
> >           tv.tv_usec =3D 0;
> >
> >           status =3D select(sd + 1, &reads, NULL, NULL, &tv);
> > @@ -283,7 +284,7 @@ socks_handshake(struct socks_proxy_info *p,
> >                   return false;
> >               }
> >
> > -            if (!socks_username_password_auth(p, sd, signal_received))
> > +            if (!socks_username_password_auth(p, sd,
> server_poll_timeout, signal_received))
> >               {
> >                   return false;
> >               }
> > @@ -301,13 +302,13 @@ socks_handshake(struct socks_proxy_info *p,
> >   static bool
> >   recv_socks_reply(socket_descriptor_t sd,
> >                    struct openvpn_sockaddr *addr,
> > +                 struct event_timeout *server_poll_timeout,
> >                    volatile int *signal_received)
> >   {
> >       char atyp =3D '\0';
> >       int alen =3D 0;
> >       int len =3D 0;
> >       char buf[270];              /* 4 + alen(max 256) + 2 */
> > -    const int timeout_sec =3D 5;
> >
> >       if (addr !=3D NULL)
> >       {
> > @@ -326,7 +327,7 @@ recv_socks_reply(socket_descriptor_t sd,
> >
> >           FD_ZERO(&reads);
> >           openvpn_fd_set(sd, &reads);
> > -        tv.tv_sec =3D timeout_sec;
> > +        tv.tv_sec =3D get_server_poll_remaining_time(server_poll_timeo=
ut);
> >           tv.tv_usec =3D 0;
> >
> >           status =3D select(sd + 1, &reads, NULL, NULL, &tv);
> > @@ -451,12 +452,13 @@ establish_socks_proxy_passthru(struct
> socks_proxy_info *p,
> >                                  socket_descriptor_t sd,  /* already
> open to proxy */
> >                                  const char *host,        /* openvpn
> server remote */
> >                                  const char *servname,    /* openvpn
> server port */
> > +                               struct event_timeout
> *server_poll_timeout,
> >                                  struct signal_info *sig_info)
> >   {
> >       char buf[270];
> >       size_t len;
> >
> > -    if (!socks_handshake(p, sd, &sig_info->signal_received))
> > +    if (!socks_handshake(p, sd, server_poll_timeout,
> &sig_info->signal_received))
> >       {
> >           goto error;
> >       }
> > @@ -494,7 +496,7 @@ establish_socks_proxy_passthru(struct
> socks_proxy_info *p,
> >
> >
> >       /* receive reply from Socks proxy and discard */
> > -    if (!recv_socks_reply(sd, NULL, &sig_info->signal_received))
> > +    if (!recv_socks_reply(sd, NULL, server_poll_timeout,
> &sig_info->signal_received))
> >       {
> >           goto error;
> >       }
> > @@ -512,9 +514,10 @@ establish_socks_proxy_udpassoc(struct
> socks_proxy_info *p,
> >                                  socket_descriptor_t ctrl_sd,  /*
> already open to proxy */
> >                                  socket_descriptor_t udp_sd,
> >                                  struct openvpn_sockaddr *relay_addr,
> > +                               struct event_timeout
> *server_poll_timeout,
> >                                  struct signal_info *sig_info)
> >   {
> > -    if (!socks_handshake(p, ctrl_sd, &sig_info->signal_received))
> > +    if (!socks_handshake(p, ctrl_sd, server_poll_timeout,
> &sig_info->signal_received))
> >       {
> >           goto error;
> >       }
> > @@ -535,7 +538,7 @@ establish_socks_proxy_udpassoc(struct
> socks_proxy_info *p,
> >
> >       /* receive reply from Socks proxy */
> >       CLEAR(*relay_addr);
> > -    if (!recv_socks_reply(ctrl_sd, relay_addr,
> &sig_info->signal_received))
> > +    if (!recv_socks_reply(ctrl_sd, relay_addr, server_poll_timeout,
> &sig_info->signal_received))
> >       {
> >           goto error;
> >       }
> > diff --git a/src/openvpn/socks.h b/src/openvpn/socks.h
> > index 3a89245b..a7094f06 100644
> > --- a/src/openvpn/socks.h
> > +++ b/src/openvpn/socks.h
> > @@ -52,12 +52,14 @@ void establish_socks_proxy_passthru(struct
> socks_proxy_info *p,
> >                                       socket_descriptor_t sd,  /*
> already open to proxy */
> >                                       const char *host,        /*
> openvpn server remote */
> >                                       const char *servname,          /*
> openvpn server port */
> > +                                    struct event_timeout
> *server_poll_timeout,
> >                                       struct signal_info *sig_info);
> >
> >   void establish_socks_proxy_udpassoc(struct socks_proxy_info *p,
> >                                       socket_descriptor_t ctrl_sd,  /*
> already open to proxy */
> >                                       socket_descriptor_t udp_sd,
> >                                       struct openvpn_sockaddr
> *relay_addr,
> > +                                    struct event_timeout
> *server_poll_timeout,
> >                                       struct signal_info *sig_info);
> >
> >   void socks_process_incoming_udp(struct buffer *buf,
>
> --
> Antonio Quartulli
>

--000000000000ea950906042a2a30
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+VGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrISBJJiMzOTttIHVzZWQgdG8g
ZGVzY3JpYmluZyBteSBwYXRjaGVzIGluIHB1bGwgcmVxdWVzdHMuIFN1Ym1pdHRpbmcgaXQgdmlh
IG1haWxpbmcgbGlzdCB3YXMgbmV3IHRvIG1lLMKgc29ycnkuIEkgaG9wZSB0aGlzIHJlcGx5IGVu
ZHMgdXAgaW4gdGhlIHJpZ2h0IHRocmVhZC4gVGhlIHBhdGNoIGlzIHJlZ2FyZGluZyB0aGlzIDEw
IHllYXIgb2xkIEJ1Z8KgPGEgaHJlZj0iaHR0cHM6Ly9jb21tdW5pdHkub3BlbnZwbi5uZXQvb3Bl
bnZwbi90aWNrZXQvMzI4Ij5odHRwczovL2NvbW11bml0eS5vcGVudnBuLm5ldC9vcGVudnBuL3Rp
Y2tldC8zMjg8L2E+PGRpdj5IYXJkY29kZWQgNSBzZWMgdGltZW91dCBpcyB0b28gbG93IGZvciBz
bG93IHByb3hpZXMsIGVzcGVjaWFsbHkgb3ZlciBUb3IuIFRoZcKgc2VydmVyLXBvbGwtdGltZW91
dCBvcHRpb24gd2FzIHN1cHBvc2VkIHRvIGZpeCBpdCwgYnV0IHdhcyBvbmx5IGltcGxlbWVudGVk
IGZvciBodHRwIHByb3hpZXMuPC9kaXY+PGRpdj5DaGVlcnM8L2Rpdj48L2Rpdj48YnI+PGRpdiBj
bGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5PbiBX
ZWQsIEF1ZyAzMCwgMjAyMyBhdCAxMDozMeKAr1BNIEFudG9uaW8gUXVhcnR1bGxpICZsdDs8YSBo
cmVmPSJtYWlsdG86YUAuLi4yMTgxLi4uIj5hQC4uLjIxODEuLi48L2E+Jmd0OyB3cm90ZTo8YnI+
PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAw
cHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRp
bmctbGVmdDoxZXgiPkhpIFNhbmRybyw8YnI+DQo8YnI+DQphdCBhIGZpcnN0IGdsYW5jZSB0aGUg
cGF0Y2ggbG9va3MgcmVhc29uYWJsZS48YnI+DQpIb3dldmVyLCB3ZSB0cnVseSBuZWVkIHlvdSB0
byB3cml0ZSBzb21lIGNvbW1pdCBtZXNzYWdlIGV4cGxhaW5pbmcgd2hhdCA8YnI+DQp5b3VyIHBh
dGNoIGlzIGZpeGluZy9pbXBsZW1lbnRpbmcsIHdoeSBpdCBpcyBkb2luZyBzbyBhbmQgd2hhdCBw
cm9ibGVtIDxicj4NCml0IHNvbHZlcy48YnI+DQo8YnI+DQpDaGVlcnMsPGJyPg0KPGJyPg0KT24g
MzAvMDgvMjAyMyAxNTowNSwgNWFuZHIwIHdyb3RlOjxicj4NCiZndDsgLS0tPGJyPg0KJmd0O8Kg
IMKgc3JjL29wZW52cG4vc29ja2V0LmMgfMKgIDIgKys8YnI+DQomZ3Q7wqAgwqBzcmMvb3BlbnZw
bi9zb2Nrcy5jwqAgfCAyNSArKysrKysrKysrKysrKy0tLS0tLS0tLS0tPGJyPg0KJmd0O8KgIMKg
c3JjL29wZW52cG4vc29ja3MuaMKgIHzCoCAyICsrPGJyPg0KJmd0O8KgIMKgMyBmaWxlcyBjaGFu
Z2VkLCAxOCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSk8YnI+DQomZ3Q7IDxicj4NCiZn
dDsgZGlmZiAtLWdpdCBhL3NyYy9vcGVudnBuL3NvY2tldC5jIGIvc3JjL29wZW52cG4vc29ja2V0
LmM8YnI+DQomZ3Q7IGluZGV4IDUwMWUwMjNlLi4xMGZkMGUyNiAxMDA2NDQ8YnI+DQomZ3Q7IC0t
LSBhL3NyYy9vcGVudnBuL3NvY2tldC5jPGJyPg0KJmd0OyArKysgYi9zcmMvb3BlbnZwbi9zb2Nr
ZXQuYzxicj4NCiZndDsgQEAgLTIwNzUsNiArMjA3NSw3IEBAIHBoYXNlMl90Y3BfY2xpZW50KHN0
cnVjdCBsaW5rX3NvY2tldCAqc29jaywgc3RydWN0IHNpZ25hbF9pbmZvICpzaWdfaW5mbyk8YnI+
DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgc29jay0mZ3Q7c2QsPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNvY2st
Jmd0O3Byb3h5X2Rlc3RfaG9zdCw8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc29jay0mZ3Q7cHJveHlf
ZGVzdF9wb3J0LDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc29jay0mZ3Q7c2VydmVyX3BvbGxfdGltZW91
dCw8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc2lnX2luZm8pOzxicj4NCiZndDvCoCDCoCDCoCDCoCDC
oCDCoH08YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqBpZiAocHJveHlfcmV0cnkpPGJyPg0KJmd0
OyBAQCAtMjEwNCw2ICsyMTA1LDcgQEAgcGhhc2UyX3NvY2tzX2NsaWVudChzdHJ1Y3QgbGlua19z
b2NrZXQgKnNvY2ssIHN0cnVjdCBzaWduYWxfaW5mbyAqc2lnX2luZm8pPGJyPg0KJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNvY2st
Jmd0O2N0cmxfc2QsPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNvY2stJmd0O3NkLDxicj4NCiZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmYW1wO3NvY2stJmd0
O3NvY2tzX3JlbGF5LmRlc3QsPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzb2NrLSZndDtzZXJ2ZXJfcG9sbF90aW1lb3V0LDxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBzaWdfaW5mbyk7PGJyPg0KJmd0O8KgIMKgPGJyPg0KJmd0O8KgIMKgIMKgIMKgaWYg
KHNpZ19pbmZvLSZndDtzaWduYWxfcmVjZWl2ZWQpPGJyPg0KJmd0OyBkaWZmIC0tZ2l0IGEvc3Jj
L29wZW52cG4vc29ja3MuYyBiL3NyYy9vcGVudnBuL3NvY2tzLmM8YnI+DQomZ3Q7IGluZGV4IGEy
OWViODNhLi4yY2I4M2E2NiAxMDA2NDQ8YnI+DQomZ3Q7IC0tLSBhL3NyYy9vcGVudnBuL3NvY2tz
LmM8YnI+DQomZ3Q7ICsrKyBiL3NyYy9vcGVudnBuL3NvY2tzLmM8YnI+DQomZ3Q7IEBAIC00Miw2
ICs0Miw3IEBAPGJyPg0KJmd0O8KgIMKgI2luY2x1ZGUgJnF1b3Q7ZmRtaXNjLmgmcXVvdDs8YnI+
DQomZ3Q7wqAgwqAjaW5jbHVkZSAmcXVvdDttaXNjLmgmcXVvdDs8YnI+DQomZ3Q7wqAgwqAjaW5j
bHVkZSAmcXVvdDtwcm94eS5oJnF1b3Q7PGJyPg0KJmd0OyArI2luY2x1ZGUgJnF1b3Q7Zm9yd2Fy
ZC5oJnF1b3Q7PGJyPg0KJmd0O8KgIMKgPGJyPg0KJmd0O8KgIMKgI2luY2x1ZGUgJnF1b3Q7bWVt
ZGJnLmgmcXVvdDs8YnI+DQomZ3Q7wqAgwqA8YnI+DQomZ3Q7IEBAIC04NSwxMiArODYsMTIgQEAg
c29ja3NfcHJveHlfY2xvc2Uoc3RydWN0IHNvY2tzX3Byb3h5X2luZm8gKnNwKTxicj4NCiZndDvC
oCDCoHN0YXRpYyBib29sPGJyPg0KJmd0O8KgIMKgc29ja3NfdXNlcm5hbWVfcGFzc3dvcmRfYXV0
aChzdHJ1Y3Qgc29ja3NfcHJveHlfaW5mbyAqcCw8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc29ja2V0X2Rlc2NyaXB0b3JfdCBzZCw8YnI+
DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cnVj
dCBldmVudF90aW1lb3V0ICpzZXJ2ZXJfcG9sbF90aW1lb3V0LDxicj4NCiZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB2b2xhdGlsZSBpbnQgKnNpZ25h
bF9yZWNlaXZlZCk8YnI+DQomZ3Q7wqAgwqB7PGJyPg0KJmd0O8KgIMKgIMKgIMKgY2hhciB0b19z
ZW5kWzUxNl07PGJyPg0KJmd0O8KgIMKgIMKgIMKgY2hhciBidWZbMl07PGJyPg0KJmd0O8KgIMKg
IMKgIMKgaW50IGxlbiA9IDA7PGJyPg0KJmd0OyAtwqAgwqAgY29uc3QgaW50IHRpbWVvdXRfc2Vj
ID0gNTs8YnI+DQomZ3Q7wqAgwqAgwqAgwqBzdHJ1Y3QgdXNlcl9wYXNzIGNyZWRzOzxicj4NCiZn
dDvCoCDCoCDCoCDCoHNzaXplX3Qgc2l6ZTs8YnI+DQomZ3Q7wqAgwqAgwqAgwqBib29sIHJldCA9
IGZhbHNlOzxicj4NCiZndDsgQEAgLTEyOSw3ICsxMzAsNyBAQCBzb2Nrc191c2VybmFtZV9wYXNz
d29yZF9hdXRoKHN0cnVjdCBzb2Nrc19wcm94eV9pbmZvICpwLDxicj4NCiZndDvCoCDCoDxicj4N
CiZndDvCoCDCoCDCoCDCoCDCoCDCoEZEX1pFUk8oJmFtcDtyZWFkcyk7PGJyPg0KJmd0O8KgIMKg
IMKgIMKgIMKgIMKgb3BlbnZwbl9mZF9zZXQoc2QsICZhbXA7cmVhZHMpOzxicj4NCiZndDsgLcKg
IMKgIMKgIMKgIHR2LnR2X3NlYyA9IHRpbWVvdXRfc2VjOzxicj4NCiZndDsgK8KgIMKgIMKgIMKg
IHR2LnR2X3NlYyA9IGdldF9zZXJ2ZXJfcG9sbF9yZW1haW5pbmdfdGltZShzZXJ2ZXJfcG9sbF90
aW1lb3V0KTs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqB0di50dl91c2VjID0gMDs8YnI+DQom
Z3Q7wqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqBzdGF0dXMgPSBzZWxlY3Qoc2QgKyAx
LCAmYW1wO3JlYWRzLCBOVUxMLCBOVUxMLCAmYW1wO3R2KTs8YnI+DQomZ3Q7IEBAIC0xODUsMTEg
KzE4NiwxMSBAQCBjbGVhbnVwOjxicj4NCiZndDvCoCDCoHN0YXRpYyBib29sPGJyPg0KJmd0O8Kg
IMKgc29ja3NfaGFuZHNoYWtlKHN0cnVjdCBzb2Nrc19wcm94eV9pbmZvICpwLDxicj4NCiZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNvY2tldF9kZXNjcmlwdG9yX3Qgc2QsPGJyPg0K
Jmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3RydWN0IGV2ZW50X3RpbWVvdXQgKnNlcnZl
cl9wb2xsX3RpbWVvdXQsPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdm9s
YXRpbGUgaW50ICpzaWduYWxfcmVjZWl2ZWQpPGJyPg0KJmd0O8KgIMKgezxicj4NCiZndDvCoCDC
oCDCoCDCoGNoYXIgYnVmWzJdOzxicj4NCiZndDvCoCDCoCDCoCDCoGludCBsZW4gPSAwOzxicj4N
CiZndDsgLcKgIMKgIGNvbnN0IGludCB0aW1lb3V0X3NlYyA9IDU7PGJyPg0KJmd0O8KgIMKgIMKg
IMKgc3NpemVfdCBzaXplOzxicj4NCiZndDvCoCDCoDxicj4NCiZndDvCoCDCoCDCoCDCoC8qIFZF
UiA9IDUsIE5NRVRIT0RTID0gMSwgTUVUSE9EUyA9IFswIChubyBhdXRoKV0gKi88YnI+DQomZ3Q7
IEBAIC0yMTYsNyArMjE3LDcgQEAgc29ja3NfaGFuZHNoYWtlKHN0cnVjdCBzb2Nrc19wcm94eV9p
bmZvICpwLDxicj4NCiZndDvCoCDCoDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoEZEX1pFUk8o
JmFtcDtyZWFkcyk7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgb3BlbnZwbl9mZF9zZXQoc2Qs
ICZhbXA7cmVhZHMpOzxicj4NCiZndDsgLcKgIMKgIMKgIMKgIHR2LnR2X3NlYyA9IHRpbWVvdXRf
c2VjOzxicj4NCiZndDsgK8KgIMKgIMKgIMKgIHR2LnR2X3NlYyA9IGdldF9zZXJ2ZXJfcG9sbF9y
ZW1haW5pbmdfdGltZShzZXJ2ZXJfcG9sbF90aW1lb3V0KTs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAg
wqAgwqB0di50dl91c2VjID0gMDs8YnI+DQomZ3Q7wqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqAgwqAg
wqAgwqBzdGF0dXMgPSBzZWxlY3Qoc2QgKyAxLCAmYW1wO3JlYWRzLCBOVUxMLCBOVUxMLCAmYW1w
O3R2KTs8YnI+DQomZ3Q7IEBAIC0yODMsNyArMjg0LDcgQEAgc29ja3NfaGFuZHNoYWtlKHN0cnVj
dCBzb2Nrc19wcm94eV9pbmZvICpwLDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHJldHVybiBmYWxzZTs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0K
Jmd0O8KgIMKgPGJyPg0KJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgaWYgKCFzb2Nrc191c2VybmFt
ZV9wYXNzd29yZF9hdXRoKHAsIHNkLCBzaWduYWxfcmVjZWl2ZWQpKTxicj4NCiZndDsgK8KgIMKg
IMKgIMKgIMKgIMKgIGlmICghc29ja3NfdXNlcm5hbWVfcGFzc3dvcmRfYXV0aChwLCBzZCwgc2Vy
dmVyX3BvbGxfdGltZW91dCwgc2lnbmFsX3JlY2VpdmVkKSk8YnI+DQomZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqB7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJu
IGZhbHNlOzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQomZ3Q7IEBAIC0z
MDEsMTMgKzMwMiwxMyBAQCBzb2Nrc19oYW5kc2hha2Uoc3RydWN0IHNvY2tzX3Byb3h5X2luZm8g
KnAsPGJyPg0KJmd0O8KgIMKgc3RhdGljIGJvb2w8YnI+DQomZ3Q7wqAgwqByZWN2X3NvY2tzX3Jl
cGx5KHNvY2tldF9kZXNjcmlwdG9yX3Qgc2QsPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHN0cnVjdCBvcGVudnBuX3NvY2thZGRyICphZGRyLDxicj4NCiZndDsgK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RydWN0IGV2ZW50X3RpbWVvdXQgKnNlcnZlcl9wb2xsX3Rp
bWVvdXQsPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHZvbGF0aWxlIGlu
dCAqc2lnbmFsX3JlY2VpdmVkKTxicj4NCiZndDvCoCDCoHs8YnI+DQomZ3Q7wqAgwqAgwqAgwqBj
aGFyIGF0eXAgPSAmIzM5O1wwJiMzOTs7PGJyPg0KJmd0O8KgIMKgIMKgIMKgaW50IGFsZW4gPSAw
Ozxicj4NCiZndDvCoCDCoCDCoCDCoGludCBsZW4gPSAwOzxicj4NCiZndDvCoCDCoCDCoCDCoGNo
YXIgYnVmWzI3MF07wqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogNCArIGFsZW4obWF4IDI1NikgKyAy
ICovPGJyPg0KJmd0OyAtwqAgwqAgY29uc3QgaW50IHRpbWVvdXRfc2VjID0gNTs8YnI+DQomZ3Q7
wqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqAgwqBpZiAoYWRkciAhPSBOVUxMKTxicj4NCiZndDvCoCDC
oCDCoCDCoHs8YnI+DQomZ3Q7IEBAIC0zMjYsNyArMzI3LDcgQEAgcmVjdl9zb2Nrc19yZXBseShz
b2NrZXRfZGVzY3JpcHRvcl90IHNkLDxicj4NCiZndDvCoCDCoDxicj4NCiZndDvCoCDCoCDCoCDC
oCDCoCDCoEZEX1pFUk8oJmFtcDtyZWFkcyk7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgb3Bl
bnZwbl9mZF9zZXQoc2QsICZhbXA7cmVhZHMpOzxicj4NCiZndDsgLcKgIMKgIMKgIMKgIHR2LnR2
X3NlYyA9IHRpbWVvdXRfc2VjOzxicj4NCiZndDsgK8KgIMKgIMKgIMKgIHR2LnR2X3NlYyA9IGdl
dF9zZXJ2ZXJfcG9sbF9yZW1haW5pbmdfdGltZShzZXJ2ZXJfcG9sbF90aW1lb3V0KTs8YnI+DQom
Z3Q7wqAgwqAgwqAgwqAgwqAgwqB0di50dl91c2VjID0gMDs8YnI+DQomZ3Q7wqAgwqA8YnI+DQom
Z3Q7wqAgwqAgwqAgwqAgwqAgwqBzdGF0dXMgPSBzZWxlY3Qoc2QgKyAxLCAmYW1wO3JlYWRzLCBO
VUxMLCBOVUxMLCAmYW1wO3R2KTs8YnI+DQomZ3Q7IEBAIC00NTEsMTIgKzQ1MiwxMyBAQCBlc3Rh
Ymxpc2hfc29ja3NfcHJveHlfcGFzc3RocnUoc3RydWN0IHNvY2tzX3Byb3h5X2luZm8gKnAsPGJy
Pg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHNvY2tldF9kZXNjcmlwdG9yX3Qgc2QswqAgLyogYWxyZWFkeSBvcGVuIHRvIHByb3h5ICovPGJy
Pg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGNvbnN0IGNoYXIgKmhvc3QswqAgwqAgwqAgwqAgLyogb3BlbnZwbiBzZXJ2ZXIgcmVtb3RlICov
PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIGNvbnN0IGNoYXIgKnNlcnZuYW1lLMKgIMKgIC8qIG9wZW52cG4gc2VydmVyIHBvcnQgKi88
YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHN0cnVjdCBldmVudF90aW1lb3V0ICpzZXJ2ZXJfcG9sbF90aW1lb3V0LDxicj4NCiZndDvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzdHJ1Y3Qgc2ln
bmFsX2luZm8gKnNpZ19pbmZvKTxicj4NCiZndDvCoCDCoHs8YnI+DQomZ3Q7wqAgwqAgwqAgwqBj
aGFyIGJ1ZlsyNzBdOzxicj4NCiZndDvCoCDCoCDCoCDCoHNpemVfdCBsZW47PGJyPg0KJmd0O8Kg
IMKgPGJyPg0KJmd0OyAtwqAgwqAgaWYgKCFzb2Nrc19oYW5kc2hha2UocCwgc2QsICZhbXA7c2ln
X2luZm8tJmd0O3NpZ25hbF9yZWNlaXZlZCkpPGJyPg0KJmd0OyArwqAgwqAgaWYgKCFzb2Nrc19o
YW5kc2hha2UocCwgc2QsIHNlcnZlcl9wb2xsX3RpbWVvdXQsICZhbXA7c2lnX2luZm8tJmd0O3Np
Z25hbF9yZWNlaXZlZCkpPGJyPg0KJmd0O8KgIMKgIMKgIMKgezxicj4NCiZndDvCoCDCoCDCoCDC
oCDCoCDCoGdvdG8gZXJyb3I7PGJyPg0KJmd0O8KgIMKgIMKgIMKgfTxicj4NCiZndDsgQEAgLTQ5
NCw3ICs0OTYsNyBAQCBlc3RhYmxpc2hfc29ja3NfcHJveHlfcGFzc3RocnUoc3RydWN0IHNvY2tz
X3Byb3h5X2luZm8gKnAsPGJyPg0KJmd0O8KgIMKgPGJyPg0KJmd0O8KgIMKgPGJyPg0KJmd0O8Kg
IMKgIMKgIMKgLyogcmVjZWl2ZSByZXBseSBmcm9tIFNvY2tzIHByb3h5IGFuZCBkaXNjYXJkICov
PGJyPg0KJmd0OyAtwqAgwqAgaWYgKCFyZWN2X3NvY2tzX3JlcGx5KHNkLCBOVUxMLCAmYW1wO3Np
Z19pbmZvLSZndDtzaWduYWxfcmVjZWl2ZWQpKTxicj4NCiZndDsgK8KgIMKgIGlmICghcmVjdl9z
b2Nrc19yZXBseShzZCwgTlVMTCwgc2VydmVyX3BvbGxfdGltZW91dCwgJmFtcDtzaWdfaW5mby0m
Z3Q7c2lnbmFsX3JlY2VpdmVkKSk8YnI+DQomZ3Q7wqAgwqAgwqAgwqB7PGJyPg0KJmd0O8KgIMKg
IMKgIMKgIMKgIMKgZ290byBlcnJvcjs8YnI+DQomZ3Q7wqAgwqAgwqAgwqB9PGJyPg0KJmd0OyBA
QCAtNTEyLDkgKzUxNCwxMCBAQCBlc3RhYmxpc2hfc29ja3NfcHJveHlfdWRwYXNzb2Moc3RydWN0
IHNvY2tzX3Byb3h5X2luZm8gKnAsPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNvY2tldF9kZXNjcmlwdG9yX3QgY3RybF9zZCzCoCAv
KiBhbHJlYWR5IG9wZW4gdG8gcHJveHkgKi88YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc29ja2V0X2Rlc2NyaXB0b3JfdCB1ZHBfc2Qs
PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHN0cnVjdCBvcGVudnBuX3NvY2thZGRyICpyZWxheV9hZGRyLDxicj4NCiZndDsgK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RydWN0IGV2ZW50X3Rp
bWVvdXQgKnNlcnZlcl9wb2xsX3RpbWVvdXQsPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0cnVjdCBzaWduYWxfaW5mbyAqc2lnX2lu
Zm8pPGJyPg0KJmd0O8KgIMKgezxicj4NCiZndDsgLcKgIMKgIGlmICghc29ja3NfaGFuZHNoYWtl
KHAsIGN0cmxfc2QsICZhbXA7c2lnX2luZm8tJmd0O3NpZ25hbF9yZWNlaXZlZCkpPGJyPg0KJmd0
OyArwqAgwqAgaWYgKCFzb2Nrc19oYW5kc2hha2UocCwgY3RybF9zZCwgc2VydmVyX3BvbGxfdGlt
ZW91dCwgJmFtcDtzaWdfaW5mby0mZ3Q7c2lnbmFsX3JlY2VpdmVkKSk8YnI+DQomZ3Q7wqAgwqAg
wqAgwqB7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgZ290byBlcnJvcjs8YnI+DQomZ3Q7wqAg
wqAgwqAgwqB9PGJyPg0KJmd0OyBAQCAtNTM1LDcgKzUzOCw3IEBAIGVzdGFibGlzaF9zb2Nrc19w
cm94eV91ZHBhc3NvYyhzdHJ1Y3Qgc29ja3NfcHJveHlfaW5mbyAqcCw8YnI+DQomZ3Q7wqAgwqA8
YnI+DQomZ3Q7wqAgwqAgwqAgwqAvKiByZWNlaXZlIHJlcGx5IGZyb20gU29ja3MgcHJveHkgKi88
YnI+DQomZ3Q7wqAgwqAgwqAgwqBDTEVBUigqcmVsYXlfYWRkcik7PGJyPg0KJmd0OyAtwqAgwqAg
aWYgKCFyZWN2X3NvY2tzX3JlcGx5KGN0cmxfc2QsIHJlbGF5X2FkZHIsICZhbXA7c2lnX2luZm8t
Jmd0O3NpZ25hbF9yZWNlaXZlZCkpPGJyPg0KJmd0OyArwqAgwqAgaWYgKCFyZWN2X3NvY2tzX3Jl
cGx5KGN0cmxfc2QsIHJlbGF5X2FkZHIsIHNlcnZlcl9wb2xsX3RpbWVvdXQsICZhbXA7c2lnX2lu
Zm8tJmd0O3NpZ25hbF9yZWNlaXZlZCkpPGJyPg0KJmd0O8KgIMKgIMKgIMKgezxicj4NCiZndDvC
oCDCoCDCoCDCoCDCoCDCoGdvdG8gZXJyb3I7PGJyPg0KJmd0O8KgIMKgIMKgIMKgfTxicj4NCiZn
dDsgZGlmZiAtLWdpdCBhL3NyYy9vcGVudnBuL3NvY2tzLmggYi9zcmMvb3BlbnZwbi9zb2Nrcy5o
PGJyPg0KJmd0OyBpbmRleCAzYTg5MjQ1Yi4uYTcwOTRmMDYgMTAwNjQ0PGJyPg0KJmd0OyAtLS0g
YS9zcmMvb3BlbnZwbi9zb2Nrcy5oPGJyPg0KJmd0OyArKysgYi9zcmMvb3BlbnZwbi9zb2Nrcy5o
PGJyPg0KJmd0OyBAQCAtNTIsMTIgKzUyLDE0IEBAIHZvaWQgZXN0YWJsaXNoX3NvY2tzX3Byb3h5
X3Bhc3N0aHJ1KHN0cnVjdCBzb2Nrc19wcm94eV9pbmZvICpwLDxicj4NCiZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNvY2tldF9k
ZXNjcmlwdG9yX3Qgc2QswqAgLyogYWxyZWFkeSBvcGVuIHRvIHByb3h5ICovPGJyPg0KJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
Y29uc3QgY2hhciAqaG9zdCzCoCDCoCDCoCDCoCAvKiBvcGVudnBuIHNlcnZlciByZW1vdGUgKi88
YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBjb25zdCBjaGFyICpzZXJ2bmFtZSzCoCDCoCDCoCDCoCDCoCAvKiBvcGVudnBu
IHNlcnZlciBwb3J0ICovPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3RydWN0IGV2ZW50X3RpbWVvdXQgKnNlcnZlcl9wb2xs
X3RpbWVvdXQsPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RydWN0IHNpZ25hbF9pbmZvICpzaWdfaW5mbyk7PGJyPg0K
Jmd0O8KgIMKgPGJyPg0KJmd0O8KgIMKgdm9pZCBlc3RhYmxpc2hfc29ja3NfcHJveHlfdWRwYXNz
b2Moc3RydWN0IHNvY2tzX3Byb3h5X2luZm8gKnAsPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc29ja2V0X2Rlc2NyaXB0
b3JfdCBjdHJsX3NkLMKgIC8qIGFscmVhZHkgb3BlbiB0byBwcm94eSAqLzxicj4NCiZndDvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNv
Y2tldF9kZXNjcmlwdG9yX3QgdWRwX3NkLDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cnVjdCBvcGVudnBuX3NvY2th
ZGRyICpyZWxheV9hZGRyLDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0cnVjdCBldmVudF90aW1lb3V0ICpzZXJ2ZXJfcG9s
bF90aW1lb3V0LDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cnVjdCBzaWduYWxfaW5mbyAqc2lnX2luZm8pOzxicj4N
CiZndDvCoCDCoDxicj4NCiZndDvCoCDCoHZvaWQgc29ja3NfcHJvY2Vzc19pbmNvbWluZ191ZHAo
c3RydWN0IGJ1ZmZlciAqYnVmLDxicj4NCjxicj4NCi0tIDxicj4NCkFudG9uaW8gUXVhcnR1bGxp
PGJyPg0KPC9ibG9ja3F1b3RlPjwvZGl2Pg0K

--000000000000ea950906042a2a30--

