Message-ID: <4CF7DDE8.8090801@...515...>
Date: Thu, 02 Dec 2010 19:56:56 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <AANLkTik4eydtMdKm7un1cbf6YvLUQi70OxjXaimqELR8@...278...>
	<AANLkTimTVn5xMKhr-jo5eF3Q2dJpGVDQmVanE9_kmyi9@...278...>
In-Reply-To: <AANLkTimTVn5xMKhr-jo5eF3Q2dJpGVDQmVanE9_kmyi9@...278...>
Subject: Re: [Openvpn-devel] PATCH: floating-tls
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
To: Blaise Gassend <blaise@...1426...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Blaise,

Actually we discussed the floating-tls patch in last community meeting:

<http://thread.gmane.org/gmane.network.openvpn.devel/4189>

This week's meeting is starting in ~5 minutes on #openvpn-devel at
irc.freenode.net - perhaps you could join and discuss floating-tls in
detail with the other devs?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



> Hi,
>
> Didn't hear back from anybody. Is there really no interest at all in
> adding floating TLS?
>
> Thanks,
> Blaise
>
> On Thu, Oct 21, 2010 at 8:25 PM, Blaise Gassend <blaise@...1426...> wrote:
>=20=20=20
>> Hi,
>>
>> To allow seamless roaming of our robots at willowgarage
>> (http://willowgarage.com), I have put together a patch that allows TLS
>> connections to float. I would like to put this patch up for critique
>> and possible inclusion into mainline openvpn. The general approach has
>> been to prefix a few bytes at the start of each packet which contain
>> an opcode and a unique identifier (random number) for the session.
>> That identifier is used instead of the IP address for determining
>> which connection the packet belongs to.
>>
>> Regards,
>> Blaise
>>
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -129,6 +129,12 @@
>>    [FRAGMENT=3D"yes"]
>>  )
>>
>> +AC_ARG_ENABLE(floating-tls,
>> +   [  --disable-floating-tls  Disable floating tls support (--floating-=
tls)],
>> +   [FLOATING_TLS=3D"$enableval"],
>> +   [FLOATING_TLS=3D"yes"]
>> +)
>> +
>>  AC_ARG_ENABLE(multihome,
>>    [  --disable-multihome     Disable multi-homed UDP server support
>> (--multihome)],
>>    [MULTIHOME=3D"$enableval"],
>> @@ -791,6 +797,11 @@
>>    AC_DEFINE(ENABLE_HTTP_PROXY, 1, [Enable HTTP proxy support])
>>  fi
>>
>> +dnl compile --floating-tls option
>> +if test "$FLOATING_TLS" =3D "yes"; then
>> +   AC_DEFINE(FLOATING_TLS, 1, [Enable floating-tls UDP server capabilit=
y])
>> +fi
>> +
>>  dnl compile --multihome option
>>  if test "$MULTIHOME" =3D "yes"; then
>>    AC_DEFINE(ENABLE_MULTIHOME, 1, [Enable multi-homed UDP server capabil=
ity])
>> --- a/forward.c
>> +++ b/forward.c
>> @@ -39,6 +39,10 @@
>>  #include "occ-inline.h"
>>  #include "ping-inline.h"
>>
>> +#ifdef FLOATING_TLS
>> +#include "ssl.h"
>> +#endif
>> +
>>  /* show event wait debugging info */
>>
>>  #ifdef ENABLE_DEBUG
>> @@ -834,7 +838,11 @@
>>        *
>>        * Also, update the persisted version of our packet-id.
>>        */
>> -      if (!TLS_MODE (c))
>> +      if (!TLS_MODE (c)
>> +#ifdef FLOATING_TLS
>> +          || c->options.floating_tls
>> +#endif
>> +          )
>>        link_socket_set_outgoing_addr (&c->c2.buf, lsi, &c->c2.from, NULL=
, c->c2.es);
>>
>>       /* reset packet received timer */
>> @@ -1088,6 +1096,21 @@
>>            /* If Socks5 over UDP, prepend header */
>>            socks_preprocess_outgoing_link (c, &to_addr, &size_delta);
>>  #endif
>> +
>> +#ifdef FLOATING_TLS
>> +            if (c->c2.link_socket->info.proto =3D=3D PROTO_UDPv4 &&
>> +                c->options.floating_tls &&
>> +                c->options.tls_client)
>> +            {
>> +              if (c->floating_tls_prefix =3D=3D 0)
>> +                RAND_bytes((uint8_t *) &c->floating_tls_prefix,
>> sizeof(c->floating_tls_prefix));
>> +
>> +              struct buffer *buf =3D &c->c2.to_link;
>> +              uint8_t opcode =3D FLOATING_TLS_OPCODE |
>> sizeof(c->floating_tls_prefix);
>> +              ASSERT (buf_write_prepend (buf,
>> &c->floating_tls_prefix, sizeof (c->floating_tls_prefix)));
>> +              ASSERT (buf_write_prepend (buf, &opcode, sizeof (opcode))=
);
>> +            }
>> +#endif
>>            /* Send packet */
>>            size =3D link_socket_write (c->c2.link_socket,
>>                                      &c->c2.to_link,
>> --- a/init.c
>> +++ b/init.c
>> @@ -1826,6 +1826,10 @@
>>   to.disable_occ =3D !options->occ;
>>  #endif
>>
>> +#ifdef FLOATING_TLS
>> +  to.floating_tls =3D options->floating_tls;
>> +#endif
>> +
>>   to.verify_command =3D options->tls_verify;
>>   to.verify_x509name =3D options->tls_remote;
>>   to.crl_file =3D options->crl_file;
>> --- a/mudp.c
>> +++ b/mudp.c
>> @@ -31,6 +31,10 @@
>>
>>  #include "memdbg.h"
>>
>> +#ifdef FLOATING_TLS
>> +#include "ssl.h"
>> +#endif
>> +
>>  /*
>>  * Get a client instance based on real address.  If
>>  * the instance doesn't exist, create it while
>> @@ -44,8 +48,36 @@
>>   struct mroute_addr real;
>>   struct multi_instance *mi =3D NULL;
>>   struct hash *hash =3D m->hash;
>> +  bool ret =3D false;
>> +
>> +#ifdef FLOATING_TLS
>> +  // Check if this is a floating-tls packet
>> +  if (m->top.c2.buf.len > 0)
>> +  {
>> +    uint8_t c =3D *BPTR (&m->top.c2.buf);
>> +    if ((c & FLOATING_TLS_OPCODE_MASK) =3D=3D FLOATING_TLS_OPCODE)
>> +    {
>> +      int len =3D c & FLOATING_TLS_LENGTH_MASK;
>> +      uint8_t *id =3D BPTR (&m->top.c2.buf) + 1;
>> +
>> +      if (buf_advance(&m->top.c2.buf, len + 1))
>> +      {
>> +        int i;
>> +        real.type =3D MR_ADDR_IPV4 | MR_WITH_PORT;
>> +        real.netbits =3D 0;
>> +        real.len =3D len;
>> +        memcpy (real.addr, id, real.len);
>> +        ret =3D true;
>> +      }
>> +    }
>> +  }
>> +#endif
>> +
>> +  // Not a floating-tls packet
>> +  if (!ret)
>> +    ret =3D mroute_extract_openvpn_sockaddr (&real, &m->top.c2.from.des=
t, true);
>>
>> -  if (mroute_extract_openvpn_sockaddr (&real, &m->top.c2.from.dest, tru=
e))
>> +  if (ret)
>>     {
>>       struct hash_element *he;
>>       const uint32_t hv =3D hash_value (hash, &real);
>> --- a/openvpn.h
>> +++ b/openvpn.h
>> @@ -484,6 +484,10 @@
>>   /* persistent across SIGHUP */
>>   struct context_persist persist;
>>
>> +#ifdef FLOATING_TLS
>> +  uint64_t floating_tls_prefix;
>> +#endif
>> +
>>   /* level 0 context contains data related to
>>      once-per OpenVPN instantiation events
>>      such as daemonization */
>> --- a/options.c
>> +++ b/options.c
>> @@ -126,6 +126,7 @@
>>   "                  Set n=3D\"infinite\" to retry indefinitely.\n"
>>   "--float         : Allow remote to change its IP address/port, such
>> as through\n"
>>   "                  DHCP (this is the default if --remote is not used).=
\n"
>> +  "--floating-tls  : Allows floating in multi-tls sessions.\n"
>>   "--ipchange cmd  : Execute shell command cmd on remote ip address init=
ial\n"
>>   "                  setting or change -- execute as: cmd ip-address por=
t#\n"
>>   "--port port     : TCP/UDP port # for both local and remote.\n"
>> @@ -1334,6 +1335,10 @@
>>   SHOW_BOOL (tls_exit);
>>
>>   SHOW_STR (tls_auth_file);
>> +
>> +#ifdef FLOATING_TLS
>> +  SHOW_BOOL (floating_tls);
>> +#endif
>>  #endif
>>  #endif
>>
>> @@ -1909,6 +1914,9 @@
>>       MUST_BE_UNDEF (transition_window);
>>       MUST_BE_UNDEF (tls_auth_file);
>>       MUST_BE_UNDEF (single_session);
>> +#ifdef FLOATING_TLS
>> +      MUST_BE_UNDEF (floating_tls);
>> +#endif
>>       MUST_BE_UNDEF (tls_exit);
>>       MUST_BE_UNDEF (crl_file);
>>       MUST_BE_UNDEF (key_method);
>> @@ -2339,6 +2347,11 @@
>>          buf_printf (&out, ",no-iv");
>>       }
>>
>> +#ifdef FLOATING_TLS
>> +  if (o->floating_tls)
>> +    buf_printf (&out, ",floating-tls");
>> +#endif
>> +
>>  #ifdef USE_SSL
>>   /*
>>    * SSL Options
>> @@ -5413,6 +5426,13 @@
>>       VERIFY_PERMISSION (OPT_P_GENERAL);
>>       options->single_session =3D true;
>>     }
>> +#ifdef FLOATING_TLS
>> +  else if (streq (p[0], "floating-tls"))
>> +    {
>> +      VERIFY_PERMISSION (OPT_P_GENERAL);
>> +      options->floating_tls =3D true;
>> +    }
>> +#endif
>>   else if (streq (p[0], "tls-exit"))
>>     {
>>       VERIFY_PERMISSION (OPT_P_GENERAL);
>> --- a/options.h
>> +++ b/options.h
>> @@ -168,6 +168,10 @@
>>   bool genkey;
>>  #endif
>>
>> +#ifdef FLOATING_TLS
>> +  bool floating_tls;
>> +#endif
>> +
>>   /* Networking parms */
>>   struct connection_entry ce;
>>
>> --- a/ssl.c
>> +++ b/ssl.c
>> @@ -4160,7 +4160,12 @@
>>  #ifdef ENABLE_DEF_AUTH
>>                  && !ks->auth_deferred
>>  #endif
>> -                 && link_socket_actual_match (from, &ks->remote_addr))
>> +                 && (
>> +#ifdef FLOATING_TLS
>> +                    multi->opt.floating_tls ||
>> +#endif
>> +                    link_socket_actual_match (from, &ks->remote_addr)
>> +                  ))
>>                {
>>                  /* return appropriate data channel decrypt key in opt */
>>                  opt->key_ctx_bi =3D &ks->key;
>> @@ -4403,7 +4408,11 @@
>>              /*
>>               * Verify remote IP address
>>               */
>> -             if (!new_link && !link_socket_actual_match (&ks->remote_ad=
dr, from))
>> +             if (!new_link
>> +#ifdef FLOATING_TLS
>> +                  && !multi->opt.floating_tls
>> +#endif
>> +                  && !link_socket_actual_match (&ks->remote_addr, from))
>>                {
>>                  msg (D_TLS_ERRORS, "TLS Error: Received control packet =
from
>> unexpected IP addr: %s",
>>                      print_link_socket_actual (from, &gc));
>> @@ -4468,7 +4477,11 @@
>>                ks->remote_addr =3D *from;
>>                ++multi->n_sessions;
>>              }
>> -           else if (!link_socket_actual_match (&ks->remote_addr, from))
>> +           else if (
>> +#ifdef FLOATING_TLS
>> +                !multi->opt.floating_tls &&
>> +#endif
>> +                !link_socket_actual_match (&ks->remote_addr, from))
>>              {
>>                msg (D_TLS_ERRORS,
>>                     "TLS Error: Existing session control channel packet =
from
>> unknown IP address: %s",
>> --- a/ssl.h
>> +++ b/ssl.h
>> @@ -221,6 +221,13 @@
>>  #define P_FIRST_OPCODE                 1
>>  #define P_LAST_OPCODE                  8
>>
>> +/* Extra opcodes for floating TLS */
>> +#ifdef FLOATING_TLS
>> +#define FLOATING_TLS_OPCODE_MASK 0xF0
>> +#define FLOATING_TLS_OPCODE 0xF0
>> +#define FLOATING_TLS_LENGTH_MASK 0x0F
>> +#endif
>> +
>>  /* key negotiation states */
>>  #define S_ERROR          -1
>>  #define S_UNDEF           0
>> @@ -416,6 +423,10 @@
>>   int key_method;
>>   bool replay;
>>   bool single_session;
>> +#ifdef FLOATING_TLS
>> +  bool floating_tls;
>> +#endif
>> +
>>  #ifdef ENABLE_OCC
>>   bool disable_occ;
>>  #endif
>> --- a/openvpn.8
>> +++ b/openvpn.8
>> @@ -573,6 +573,10 @@
>>  option.
>>  .\"*********************************************************
>>  .TP
>> +.B \-\-floating-tls
>> +Allows tls connections to float.
>> +.\"*********************************************************
>> +.TP
>>  .B \-\-ipchange cmd
>>  Execute shell command
>>  .B cmd
>>
>>=20=20=20=20=20
>
> -------------------------------------------------------------------------=
-----
> Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
> Tap into the largest installed PC base & get more eyes on your game by
> optimizing for Intel(R) Graphics Technology. Get started today with the
> Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
> http://p.sf.net/sfu/intelisp-dev2dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20=20=20



