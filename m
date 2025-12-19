From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 19 Dec 2025 17:29:43 +0000
References: <gerrit.1766165378000.Ic1e84ef6fb613851861a695bfbdbc1c32970a398@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <6452df85b8afaa0028776d20a28bda5e468ad786-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GQGNEDfpdpE="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove --mtu-test
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--GQGNEDfpdpE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1454?usp=3Demail

to review the following change.


Change subject: Remove --mtu-test
......................................................................

Remove --mtu-test

This option doesn't seem to have worked right at least since
the merge of commit fb76954a232decc86e071a76861c1e4fdd2507ab
which was merged before 2.6.0. Clearly noone cares enough
about this feature maintain or even test it. So let's not
pretend and get rid of it.

Change-Id: Ic1e84ef6fb613851861a695bfbdbc1c32970a398
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M doc/man-sections/link-options.rst
M doc/man-sections/unsupported-options.rst
M src/openvpn/forward.c
M src/openvpn/init.c
M src/openvpn/occ.c
M src/openvpn/occ.h
M src/openvpn/openvpn.h
M src/openvpn/options.c
8 files changed, 5 insertions(+), 338 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/54/1454/1

diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-opti=
ons.rst
index edda1ca..062be45 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -222,13 +222,6 @@

   :code:`yes`     Always DF (Don't Fragment)

---mtu-test
-  To empirically measure MTU on connection startup, add the ``--mtu-test``
-  option to your configuration. OpenVPN will send ping packets of various
-  sizes to the remote peer and measure the largest packets which were
-  successfully received. The ``--mtu-test`` process normally takes about 3
-  minutes to complete.
-
 --nobind
   Do not bind to local address and port. The IP stack will allocate a
   dynamic port for returning packets. Since the value of the dynamic port
diff --git a/doc/man-sections/unsupported-options.rst b/doc/man-sections/un=
supported-options.rst
index f1332f3..d1bcf6e 100644
--- a/doc/man-sections/unsupported-options.rst
+++ b/doc/man-sections/unsupported-options.rst
@@ -35,6 +35,9 @@
 --max-routes
   Removed in OpenVPN 2.4.  The limit was removed.

+--mtu-test
+  This option was broken in OpenVPN 2.6 and was removed in OpenVPN 2.7.
+
 --ncp-disable
   Removed in OpenVPN 2.6.  This option mainly served a role as debug option
   when NCP was first introduced.  It should no longer be necessary.
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 492e667..586809a 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -810,9 +810,6 @@
     /* Should we send an OCC_REQUEST message? */
     check_send_occ_req(c);

-    /* Should we send an MTU load test? */
-    check_send_occ_load_test(c);
-
     /* Should we send an OCC_EXIT message to remote? */
     if (c->c2.explicit_exit_notification_time_wait)
     {
@@ -993,11 +990,6 @@
     {
         c->c2.link_read_bytes +=3D c->c2.buf.len;
         link_read_bytes_global +=3D c->c2.buf.len;
-        c->c2.original_recv_size =3D c->c2.buf.len;
-    }
-    else
-    {
-        c->c2.original_recv_size =3D 0;
     }

 #ifdef ENABLE_DEBUG
@@ -1168,8 +1160,6 @@
         if (c->c2.buf.len > 0)
         {
             c->c2.link_read_bytes_auth +=3D c->c2.buf.len;
-            c->c2.max_recv_size_local =3D
-                max_int(c->c2.original_recv_size, c->c2.max_recv_size_loca=
l);
         }

         /* Did we just receive an openvpn ping packet? */
@@ -1825,7 +1815,6 @@

             if (size > 0)
             {
-                c->c2.max_send_size_local =3D max_int(size, c->c2.max_send=
_size_local);
                 c->c2.link_write_bytes +=3D size;
                 link_write_bytes_global +=3D size;
             }
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index ee198ce..ee5b427 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1378,12 +1378,6 @@
             event_timeout_init(&c->c2.occ_interval, OCC_INTERVAL_SECONDS, =
now);
         }

-        if (c->options.mtu_test)
-        {
-            event_timeout_init(&c->c2.occ_mtu_load_test_interval, OCC_MTU_=
LOAD_INTERVAL_SECONDS,
-                               now);
-        }
-
         /* initialize packet_id persistence timer */
         if (c->options.packet_id_file)
         {
diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index 78013ae..6730c39 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -54,92 +54,6 @@
 const uint8_t occ_magic[] =3D { 0x28, 0x7f, 0x34, 0x6b, 0xd4, 0xef, 0x7a, =
0x81,
                               0x2d, 0x56, 0xb8, 0xd3, 0xaf, 0xc5, 0x45, 0x=
9c };

-static const struct mtu_load_test mtu_load_test_sequence[] =3D {
-
-    { OCC_MTU_LOAD_REQUEST, -1000 },
-    { OCC_MTU_LOAD, -1000 },
-    { OCC_MTU_LOAD_REQUEST, -1000 },
-    { OCC_MTU_LOAD, -1000 },
-    { OCC_MTU_LOAD_REQUEST, -1000 },
-    { OCC_MTU_LOAD, -1000 },
-
-    { OCC_MTU_LOAD_REQUEST, -750 },
-    { OCC_MTU_LOAD, -750 },
-    { OCC_MTU_LOAD_REQUEST, -750 },
-    { OCC_MTU_LOAD, -750 },
-    { OCC_MTU_LOAD_REQUEST, -750 },
-    { OCC_MTU_LOAD, -750 },
-
-    { OCC_MTU_LOAD_REQUEST, -500 },
-    { OCC_MTU_LOAD, -500 },
-    { OCC_MTU_LOAD_REQUEST, -500 },
-    { OCC_MTU_LOAD, -500 },
-    { OCC_MTU_LOAD_REQUEST, -500 },
-    { OCC_MTU_LOAD, -500 },
-
-    { OCC_MTU_LOAD_REQUEST, -400 },
-    { OCC_MTU_LOAD, -400 },
-    { OCC_MTU_LOAD_REQUEST, -400 },
-    { OCC_MTU_LOAD, -400 },
-    { OCC_MTU_LOAD_REQUEST, -400 },
-    { OCC_MTU_LOAD, -400 },
-
-    { OCC_MTU_LOAD_REQUEST, -300 },
-    { OCC_MTU_LOAD, -300 },
-    { OCC_MTU_LOAD_REQUEST, -300 },
-    { OCC_MTU_LOAD, -300 },
-    { OCC_MTU_LOAD_REQUEST, -300 },
-    { OCC_MTU_LOAD, -300 },
-
-    { OCC_MTU_LOAD_REQUEST, -200 },
-    { OCC_MTU_LOAD, -200 },
-    { OCC_MTU_LOAD_REQUEST, -200 },
-    { OCC_MTU_LOAD, -200 },
-    { OCC_MTU_LOAD_REQUEST, -200 },
-    { OCC_MTU_LOAD, -200 },
-
-    { OCC_MTU_LOAD_REQUEST, -150 },
-    { OCC_MTU_LOAD, -150 },
-    { OCC_MTU_LOAD_REQUEST, -150 },
-    { OCC_MTU_LOAD, -150 },
-    { OCC_MTU_LOAD_REQUEST, -150 },
-    { OCC_MTU_LOAD, -150 },
-
-    { OCC_MTU_LOAD_REQUEST, -100 },
-    { OCC_MTU_LOAD, -100 },
-    { OCC_MTU_LOAD_REQUEST, -100 },
-    { OCC_MTU_LOAD, -100 },
-    { OCC_MTU_LOAD_REQUEST, -100 },
-    { OCC_MTU_LOAD, -100 },
-
-    { OCC_MTU_LOAD_REQUEST, -50 },
-    { OCC_MTU_LOAD, -50 },
-    { OCC_MTU_LOAD_REQUEST, -50 },
-    { OCC_MTU_LOAD, -50 },
-    { OCC_MTU_LOAD_REQUEST, -50 },
-    { OCC_MTU_LOAD, -50 },
-
-    { OCC_MTU_LOAD_REQUEST, 0 },
-    { OCC_MTU_LOAD, 0 },
-    { OCC_MTU_LOAD_REQUEST, 0 },
-    { OCC_MTU_LOAD, 0 },
-    { OCC_MTU_LOAD_REQUEST, 0 },
-    { OCC_MTU_LOAD, 0 },
-
-    { OCC_MTU_REQUEST, 0 },
-    { OCC_MTU_REQUEST, 0 },
-    { OCC_MTU_REQUEST, 0 },
-    { OCC_MTU_REQUEST, 0 },
-    { OCC_MTU_REQUEST, 0 },
-    { OCC_MTU_REQUEST, 0 },
-    { OCC_MTU_REQUEST, 0 },
-    { OCC_MTU_REQUEST, 0 },
-    { OCC_MTU_REQUEST, 0 },
-    { OCC_MTU_REQUEST, 0 },
-
-    { -1, 0 }
-};
-
 void
 check_send_occ_req_dowork(struct context *c)
 {
@@ -153,8 +67,7 @@
              */
             msg(D_SHOW_OCC,
                 "NOTE: failed to obtain options consistency info from peer=
 -- "
-                "this could occur if the remote peer is running a version =
of " PACKAGE_NAME
-                " before 1.5-beta8 or if there is a network connectivity p=
roblem, and will not necessarily prevent " PACKAGE_NAME
+                "this could occur if there is a network connectivity probl=
em, and will not necessarily prevent " PACKAGE_NAME
                 " from running (" counter_format " bytes received from pee=
r, " counter_format
                 " bytes authenticated data channel traffic) -- you can dis=
able the options consistency "
                 "check with --disable-occ.",
@@ -174,45 +87,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
-void
-check_send_occ_load_test_dowork(struct context *c)
-{
-    if (connection_established(c))
-    {
-        const struct mtu_load_test *entry;
-
-        if (!c->c2.occ_mtu_load_n_tries)
-        {
-            msg(M_INFO,
-                "NOTE: Beginning empirical MTU test -- results should be a=
vailable in 3 to 4 minutes.");
-        }
-
-        entry =3D &mtu_load_test_sequence[c->c2.occ_mtu_load_n_tries++];
-        if (entry->op >=3D 0)
-        {
-            c->c2.occ_op =3D entry->op;
-            size_t payload_size =3D
-                frame_calculate_payload_size(&c->c2.frame, &c->options, &c=
->c1.ks.key_type);
-            size_t header_size =3D
-                frame_calculate_protocol_header_size(&c->c1.ks.key_type, &=
c->options, false);
-
-            c->c2.occ_mtu_load_size =3D payload_size + header_size;
-        }
-        else
-        {
-            msg(M_INFO, "NOTE: failed to empirically measure MTU (requires=
 " PACKAGE_NAME
-                        " 1.5 or higher at other end of connection).");
-            event_timeout_clear(&c->c2.occ_mtu_load_test_interval);
-            c->c2.occ_mtu_load_n_tries =3D 0;
-        }
-    }
-}
-
 void
 check_send_occ_msg_dowork(struct context *c)
 {
@@ -252,84 +126,6 @@
             doit =3D true;
             break;
=20
-        case OCC_MTU_REQUEST:
-            if (!buf_write_u8(&c->c2.buf, OCC_MTU_REQUEST))
-            {
-                break;
-            }
-            dmsg(D_PACKET_CONTENT, "SENT OCC_MTU_REQUEST");
-            doit =3D true;
-            break;
-
-        case OCC_MTU_REPLY:
-            if (!buf_write_u8(&c->c2.buf, OCC_MTU_REPLY))
-            {
-                break;
-            }
-            if (!buf_write_u16(&c->c2.buf, c->c2.max_recv_size_local))
-            {
-                break;
-            }
-            if (!buf_write_u16(&c->c2.buf, c->c2.max_send_size_local))
-            {
-                break;
-            }
-            dmsg(D_PACKET_CONTENT, "SENT OCC_MTU_REPLY");
-            doit =3D true;
-            break;
-
-        case OCC_MTU_LOAD_REQUEST:
-            if (!buf_write_u8(&c->c2.buf, OCC_MTU_LOAD_REQUEST))
-            {
-                break;
-            }
-            if (!buf_write_u16(&c->c2.buf, c->c2.occ_mtu_load_size))
-            {
-                break;
-            }
-            dmsg(D_PACKET_CONTENT, "SENT OCC_MTU_LOAD_REQUEST");
-            doit =3D true;
-            break;
-
-        case OCC_MTU_LOAD:
-        {
-            int need_to_add;
-
-            if (!buf_write_u8(&c->c2.buf, OCC_MTU_LOAD))
-            {
-                break;
-            }
-            size_t proto_hdr, payload_hdr;
-            const struct key_type *kt =3D &c->c1.ks.key_type;
-
-            /* OCC message have comp/fragment headers but not ethernet hea=
ders */
-            payload_hdr =3D frame_calculate_payload_overhead(0, &c->option=
s, kt);
-
-            /* Since we do not know the payload size we just pass 0 as siz=
e here */
-            proto_hdr =3D frame_calculate_protocol_header_size(kt, &c->opt=
ions, false);
-
-            need_to_add =3D min_int(c->c2.occ_mtu_load_size, c->c2.frame.b=
uf.payload_size)
-                          - OCC_STRING_SIZE - sizeof(uint8_t) /* occ opcod=
e */
-                          - payload_hdr - proto_hdr;
-
-            while (need_to_add > 0)
-            {
-                /*
-                 * Fill the load test packet with pseudo-random bytes.
-                 */
-                if (!buf_write_u8(&c->c2.buf, get_random() & 0xFF))
-                {
-                    break;
-                }
-                --need_to_add;
-            }
-            dmsg(D_PACKET_CONTENT, "SENT OCC_MTU_LOAD min_int(%d,%d)-%d-%d=
-%d-%d) size=3D%d",
-                 c->c2.occ_mtu_load_size, c->c2.frame.buf.payload_size, OC=
C_STRING_SIZE,
-                 (int)sizeof(uint8_t), (int)payload_hdr, (int)proto_hdr, B=
LEN(&c->c2.buf));
-            doit =3D true;
-        }
-        break;
-
         case OCC_EXIT:
             if (!buf_write_u8(&c->c2.buf, OCC_EXIT))
             {
@@ -352,10 +148,6 @@
     c->c2.occ_op =3D -1;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 process_received_occ_msg(struct context *c)
 {
@@ -367,20 +159,6 @@
             c->c2.occ_op =3D OCC_REPLY;
             break;

-        case OCC_MTU_REQUEST:
-            dmsg(D_PACKET_CONTENT, "RECEIVED OCC_MTU_REQUEST");
-            c->c2.occ_op =3D OCC_MTU_REPLY;
-            break;
-
-        case OCC_MTU_LOAD_REQUEST:
-            dmsg(D_PACKET_CONTENT, "RECEIVED OCC_MTU_LOAD_REQUEST");
-            c->c2.occ_mtu_load_size =3D buf_read_u16(&c->c2.buf);
-            if (c->c2.occ_mtu_load_size >=3D 0)
-            {
-                c->c2.occ_op =3D OCC_MTU_LOAD;
-            }
-            break;
-
         case OCC_REPLY:
             dmsg(D_PACKET_CONTENT, "RECEIVED OCC_REPLY");
             if (c->options.occ && !TLS_MODE(c) && c->c2.options_string_rem=
ote)
@@ -395,30 +173,6 @@
             event_timeout_clear(&c->c2.occ_interval);
             break;

-        case OCC_MTU_REPLY:
-            dmsg(D_PACKET_CONTENT, "RECEIVED OCC_MTU_REPLY");
-            c->c2.max_recv_size_remote =3D buf_read_u16(&c->c2.buf);
-            c->c2.max_send_size_remote =3D buf_read_u16(&c->c2.buf);
-            if (c->options.mtu_test && c->c2.max_recv_size_remote > 0
-                && c->c2.max_send_size_remote > 0)
-            {
-                msg(M_INFO,
-                    "NOTE: Empirical MTU test completed [Tried,Actual] loc=
al->remote=3D[%d,%d] remote->local=3D[%d,%d]",
-                    c->c2.max_send_size_local, c->c2.max_recv_size_remote,
-                    c->c2.max_send_size_remote, c->c2.max_recv_size_local);
-                if (!c->options.ce.fragment && (proto_is_dgram(c->options.=
ce.proto))
-                    && c->c2.max_send_size_local > TUN_MTU_MIN
-                    && (c->c2.max_recv_size_remote < c->c2.max_send_size_l=
ocal
-                        || c->c2.max_recv_size_local < c->c2.max_send_size=
_remote))
-                {
-                    msg(M_INFO,
-                        "NOTE: This connection is unable to accommodate a =
UDP packet size of %d. Consider using --fragment or --mssfix options as a w=
orkaround.",
-                        c->c2.max_send_size_local);
-                }
-            }
-            event_timeout_clear(&c->c2.occ_mtu_load_test_interval);
-            break;
-
         case OCC_EXIT:
             dmsg(D_STREAM_ERRORS, "OCC exit message received by peer");
             register_signal(c->sig, SIGUSR1, "remote-exit");
diff --git a/src/openvpn/occ.h b/src/openvpn/occ.h
index 369d94e..2b816ec 100644
--- a/src/openvpn/occ.h
+++ b/src/openvpn/occ.h
@@ -45,39 +45,12 @@
 #define OCC_INTERVAL_SECONDS 10
 #define OCC_N_TRIES          12

-/*
- * Other OCC protocol opcodes used to estimate the MTU empirically.
- */
-#define OCC_MTU_LOAD_REQUEST 2 /* Ask peer to send a big packet to us */
-#define OCC_MTU_LOAD         3 /* Send a big packet to peer */
-#define OCC_MTU_REQUEST                                           \
-    4                          /* Ask peer to tell us the largest \
-                                * packet it has received from us so far */
-#define OCC_MTU_REPLY 5        /* Send largest packet size to peer */
-
-/*
- * Process one command from mtu_load_test_sequence
- * once every n seconds, if --mtu-test is specified.
- */
-#define OCC_MTU_LOAD_INTERVAL_SECONDS 3
-
+/* 2 - 5 removed (OCC MTU Test) */
 /*
  * Send an exit message to remote.
  */
 #define OCC_EXIT 6

-/*
- * Used to conduct a load test command sequence
- * of UDP connection for empirical MTU measurement.
- */
-struct mtu_load_test
-{
-    int op;    /* OCC opcode to send to peer */
-    int delta; /* determine packet size to send by using
-                * this delta against currently
-                * configured MTU */
-};
-
 extern const uint8_t occ_magic[];

 static inline bool
@@ -90,8 +63,6 @@

 void check_send_occ_req_dowork(struct context *c);

-void check_send_occ_load_test_dowork(struct context *c);
-
 void check_send_occ_msg_dowork(struct context *c);

 /*
@@ -119,20 +90,6 @@
 }

 /*
- * Should we send an MTU load test?
- */
-static inline void
-check_send_occ_load_test(struct context *c)
-{
-    if (event_timeout_defined(&c->c2.occ_mtu_load_test_interval)
-        && event_timeout_trigger(&c->c2.occ_mtu_load_test_interval, &c->c2=
.timeval,
-                                 (!TO_LINK_DEF(c) && c->c2.occ_op < 0) ? E=
TT_DEFAULT : 0))
-    {
-        check_send_occ_load_test_dowork(c);
-    }
-}
-
-/*
  * Should we send an OCC message?
  */
 static inline void
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 9325e21..c1cdb5a 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -301,23 +301,6 @@
     struct event_timeout occ_interval;

     /*
-     * Keep track of maximum packet size received so far
-     * (of authenticated packets).
-     */
-    int original_recv_size;   /* temporary */
-    int max_recv_size_local;  /* max packet size received */
-    int max_recv_size_remote; /* max packet size received by remote */
-    int max_send_size_local;  /* max packet size sent */
-    int max_send_size_remote; /* max packet size sent by remote */
-
-
-    /* remote wants us to send back a load test packet of this size */
-    int occ_mtu_load_size;
-
-    struct event_timeout occ_mtu_load_test_interval;
-    int occ_mtu_load_n_tries;
-
-    /*
      * TLS-mode crypto objects.
      */
     struct tls_multi *tls_multi; /**< TLS state structure for this VPN
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 34af0d3..e3bcbc7 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -305,7 +305,6 @@
     "                  'no'    -- Never send DF (Don't Fragment) frames\n"
     "                  'maybe' -- Use per-route hints\n"
     "                  'yes'   -- Always DF (Don't Fragment)\n"
-    "--mtu-test      : Empirically measure and report MTU.\n"
 #ifdef ENABLE_FRAGMENT
     "--fragment max  : Enable internal datagram fragmentation so that no U=
DP\n"
     "                  datagrams are sent which are larger than max bytes.=
\n"
@@ -6479,11 +6478,6 @@
         VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTION);
         options->ce.mtu_discover_type =3D translate_mtu_discover_type_name=
(p[1]);
     }
-    else if (streq(p[0], "mtu-test") && !p[1])
-    {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->mtu_test =3D true;
-    }
     else if (streq(p[0], "nice") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_NICE);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1454?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic1e84ef6fb613851861a695bfbdbc1c32970a398
Gerrit-Change-Number: 1454
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--GQGNEDfpdpE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1454?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Remove --mtu-test<br><br>This option doesn&=
#39;t seem to have worked right at least since<br>the merge of commit fb769=
54a232decc86e071a76861c1e4fdd2507ab<br>which was merged before 2.6.0. Clear=
ly noone cares enough<br>about this feature maintain or even test it. So le=
t&#39;s not<br>pretend and get rid of it.<br><br>Change-Id: Ic1e84ef6fb6138=
51861a695bfbdbc1c32970a398<br>Signed-off-by: Frank Lichtenheld &lt;frank@...1186...=
.2641...&gt;<br>---<br>M doc/man-sections/link-options.rst<br>M doc/man-sec=
tions/unsupported-options.rst<br>M src/openvpn/forward.c<br>M src/openvpn/i=
nit.c<br>M src/openvpn/occ.c<br>M src/openvpn/occ.h<br>M src/openvpn/openvp=
n.h<br>M src/openvpn/options.c<br>8 files changed, 5 insertions(+), 338 del=
etions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2941=
8/openvpn refs/changes/54/1454/1</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/link=
-options.rst b/doc/man-sections/link-options.rst</span><br><span>index edda=
1ca..062be45 100644</span><br><span>--- a/doc/man-sections/link-options.rst=
</span><br><span>+++ b/doc/man-sections/link-options.rst</span><br><span>@@=
 -222,13 +222,6 @@</span><br><span> </span><br><span>   :code:`yes`     Alw=
ays DF (Don&#39;t Fragment)</span><br><span> </span><br><span>---mtu-test</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  To empirically measur=
e MTU on connection startup, add the ``--mtu-test``</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  option to your configuration. OpenVPN wil=
l send ping packets of various</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-  sizes to the remote peer and measure the largest packets which w=
ere</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  successfully rec=
eived. The ``--mtu-test`` process normally takes about 3</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  minutes to complete.</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> --nobind</span><br><s=
pan>   Do not bind to local address and port. The IP stack will allocate a<=
/span><br><span>   dynamic port for returning packets. Since the value of t=
he dynamic port</span><br><span>diff --git a/doc/man-sections/unsupported-o=
ptions.rst b/doc/man-sections/unsupported-options.rst</span><br><span>index=
 f1332f3..d1bcf6e 100644</span><br><span>--- a/doc/man-sections/unsupported=
-options.rst</span><br><span>+++ b/doc/man-sections/unsupported-options.rst=
</span><br><span>@@ -35,6 +35,9 @@</span><br><span> --max-routes</span><br>=
<span>   Removed in OpenVPN 2.4.  The limit was removed.</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+--mtu-test</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  This option was broken in O=
penVPN 2.6 and was removed in OpenVPN 2.7.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> --ncp-disable</span><br><span>   R=
emoved in OpenVPN 2.6.  This option mainly served a role as debug option</s=
pan><br><span>   when NCP was first introduced.  It should no longer be nec=
essary.</span><br><span>diff --git a/src/openvpn/forward.c b/src/openvpn/fo=
rward.c</span><br><span>index 492e667..586809a 100644</span><br><span>--- a=
/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</span><b=
r><span>@@ -810,9 +810,6 @@</span><br><span>     /* Should we send an OCC_R=
EQUEST message? */</span><br><span>     check_send_occ_req(c);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Should we=
 send an MTU load test? */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    check_send_occ_load_test(c);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span>     /* Should we send an OCC_EXIT message=
 to remote? */</span><br><span>     if (c-&gt;c2.explicit_exit_notification=
_time_wait)</span><br><span>     {</span><br><span>@@ -993,11 +990,6 @@</sp=
an><br><span>     {</span><br><span>         c-&gt;c2.link_read_bytes +=3D =
c-&gt;c2.buf.len;</span><br><span>         link_read_bytes_global +=3D c-&g=
t;c2.buf.len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
c-&gt;c2.original_recv_size =3D c-&gt;c2.buf.len;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c-&gt;c2.=
original_recv_size =3D 0;</span><br><span>     }</span><br><span> </span><b=
r><span> #ifdef ENABLE_DEBUG</span><br><span>@@ -1168,8 +1160,6 @@</span><b=
r><span>         if (c-&gt;c2.buf.len &gt; 0)</span><br><span>         {</s=
pan><br><span>             c-&gt;c2.link_read_bytes_auth +=3D c-&gt;c2.buf.=
len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            c-&gt=
;c2.max_recv_size_local =3D</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                max_int(c-&gt;c2.original_recv_size, c-&gt;c2.max_rec=
v_size_local);</span><br><span>         }</span><br><span> </span><br><span=
>         /* Did we just receive an openvpn ping packet? */</span><br><span=
>@@ -1825,7 +1815,6 @@</span><br><span> </span><br><span>             if (s=
ize &gt; 0)</span><br><span>             {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                c-&gt;c2.max_send_size_local =3D max_i=
nt(size, c-&gt;c2.max_send_size_local);</span><br><span>                 c-=
&gt;c2.link_write_bytes +=3D size;</span><br><span>                 link_wr=
ite_bytes_global +=3D size;</span><br><span>             }</span><br><span>=
diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index =
ee198ce..ee5b427 100644</span><br><span>--- a/src/openvpn/init.c</span><br>=
<span>+++ b/src/openvpn/init.c</span><br><span>@@ -1378,12 +1378,6 @@</span=
><br><span>             event_timeout_init(&amp;c-&gt;c2.occ_interval, OCC_=
INTERVAL_SECONDS, now);</span><br><span>         }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (c-&gt;options.mt=
u_test)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            event_timeout_=
init(&amp;c-&gt;c2.occ_mtu_load_test_interval, OCC_MTU_LOAD_INTERVAL_SECOND=
S,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
            now);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
>         /* initialize packet_id persistence timer */</span><br><span>    =
     if (c-&gt;options.packet_id_file)</span><br><span>         {</span><br=
><span>diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c</span><br><span>i=
ndex 78013ae..6730c39 100644</span><br><span>--- a/src/openvpn/occ.c</span>=
<br><span>+++ b/src/openvpn/occ.c</span><br><span>@@ -54,92 +54,6 @@</span>=
<br><span> const uint8_t occ_magic[] =3D { 0x28, 0x7f, 0x34, 0x6b, 0xd4, 0x=
ef, 0x7a, 0x81,</span><br><span>                               0x2d, 0x56, =
0xb8, 0xd3, 0xaf, 0xc5, 0x45, 0x9c };</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-static const struct mtu_load_test mtu_loa=
d_test_sequence[] =3D {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD_=
REQUEST, -1000 },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{ OCC_MTU_LOAD, -1000 },</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    { OCC_MTU_LOAD_REQUEST, -1000 },</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    { OCC_MTU_LOAD, -1000 },</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD_REQUEST, -1000 },</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD, -1000 },</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD_REQUEST, -750 },</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD, -750 },</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD_REQUEST, -=
750 },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_L=
OAD, -750 },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { OCC=
_MTU_LOAD_REQUEST, -750 },</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    { OCC_MTU_LOAD, -750 },</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { OCC_=
MTU_LOAD_REQUEST, -500 },</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    { OCC_MTU_LOAD, -500 },</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    { OCC_MTU_LOAD_REQUEST, -500 },</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD, -500 },</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD_REQUEST, -500 },</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD, -500 },</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD_REQUEST, -400 },</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD, -400 },</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD_REQU=
EST, -400 },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { OCC=
_MTU_LOAD, -400 },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 { OCC_MTU_LOAD_REQUEST, -400 },</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    { OCC_MTU_LOAD, -400 },</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{ OCC_MTU_LOAD_REQUEST, -300 },</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    { OCC_MTU_LOAD, -300 },</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    { OCC_MTU_LOAD_REQUEST, -300 },</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD, -300 },</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD_REQUEST, -300 },</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD, -30=
0 },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD_REQUEST, -200 },</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD, -200=
 },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD=
_REQUEST, -200 },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{ OCC_MTU_LOAD, -200 },</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    { OCC_MTU_LOAD_REQUEST, -200 },</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    { OCC_MTU_LOAD, -200 },</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    { OCC_MTU_LOAD_REQUEST, -150 },</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    { OCC_MTU_LOAD, -150 },</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD_REQUEST, -150 },</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD, -150 },</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD_REQUEST, -150 }=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD, =
-150 },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD_REQUEST, -100 },=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD, -=
100 },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_L=
OAD_REQUEST, -100 },</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   { OCC_MTU_LOAD, -100 },</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    { OCC_MTU_LOAD_REQUEST, -100 },</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    { OCC_MTU_LOAD, -100 },</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    { OCC_MTU_LOAD_REQUEST, -50 },</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    { OCC_MTU_LOAD, -50 },</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD_REQUEST, -50 },</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD, -50 },</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD_REQUEST, -50 },<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD, -5=
0 },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD_REQUEST, 0 },</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD, 0 },</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_LOAD_REQUE=
ST, 0 },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU=
_LOAD, 0 },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { OCC_=
MTU_LOAD_REQUEST, 0 },</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    { OCC_MTU_LOAD, 0 },</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_REQ=
UEST, 0 },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { OCC_M=
TU_REQUEST, 0 },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
 OCC_MTU_REQUEST, 0 },</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    { OCC_MTU_REQUEST, 0 },</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    { OCC_MTU_REQUEST, 0 },</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    { OCC_MTU_REQUEST, 0 },</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    { OCC_MTU_REQUEST, 0 },</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    { OCC_MTU_REQUEST, 0 },</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_REQUEST, 0 },</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    { OCC_MTU_REQUEST, 0 },</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    { -1, 0 }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> void</span><br><span> check_send_occ_req_dowork(struct contex=
t *c)</span><br><span> {</span><br><span>@@ -153,8 +67,7 @@</span><br><span=
>              */</span><br><span>             msg(D_SHOW_OCC,</span><br><s=
pan>                 &quot;NOTE: failed to obtain options consistency info =
from peer -- &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              &quot;this could occur if the remote peer is running a versio=
n of &quot; PACKAGE_NAME</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                &quot; before 1.5-beta8 or if there is a network connect=
ivity problem, and will not necessarily prevent &quot; PACKAGE_NAME</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;this =
could occur if there is a network connectivity problem, and will not necess=
arily prevent &quot; PACKAGE_NAME</span><br><span>                 &quot; f=
rom running (&quot; counter_format &quot; bytes received from peer, &quot; =
counter_format</span><br><span>                 &quot; bytes authenticated =
data channel traffic) -- you can disable the options consistency &quot;</sp=
an><br><span>                 &quot;check with --disable-occ.&quot;,</span>=
<br><span>@@ -174,45 +87,6 @@</span><br><span>     }</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if def=
ined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-check_send_occ_load_test_dowork(struct context *c)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (connection_established(c))</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        const struct mtu_load_test *entry;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (!c-&gt;c2.occ_mtu_load_n_tries)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            msg(M_INFO,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                &quot;NOTE: Beginning empirical MTU =
test -- results should be available in 3 to 4 minutes.&quot;);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        entry =3D &amp;mtu_load_test_sequence[c-&gt;c2.occ_mtu_load=
_n_tries++];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (entry-&gt;op &gt;=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     c-&gt;c2.occ_op =3D entry-&gt;op;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            size_t payload_size =3D</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                frame_calculate_payload_siz=
e(&amp;c-&gt;c2.frame, &amp;c-&gt;options, &amp;c-&gt;c1.ks.key_type);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            size_t header_=
size =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   frame_calculate_protocol_header_size(&amp;c-&gt;c1.ks.key_type, &amp;c-&=
gt;options, false);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            c-&gt;c2.oc=
c_mtu_load_size =3D payload_size + header_size;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     msg(M_INFO, &quot;NOTE: failed to empirically measure MTU (requires &q=
uot; PACKAGE_NAME</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                    &quot; 1.5 or higher at other end of connection).&quot;=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            event_t=
imeout_clear(&amp;c-&gt;c2.occ_mtu_load_test_interval);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            c-&gt;c2.occ_mtu_load_n_tries=
 =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span> void</span><br><span> check_send_occ_msg_dow=
ork(struct context *c)</span><br><span> {</span><br><span>@@ -252,84 +126,6=
 @@</span><br><span>             doit =3D true;</span><br><span>           =
  break;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        case OCC_MTU_REQUEST:</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            if (!buf_write_u8(&amp;c-&gt;c2.buf, OCC_MTU_REQUE=
ST))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                break;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            dmsg(D_PACKET_CONTEN=
T, &quot;SENT OCC_MTU_REQUEST&quot;);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            doit =3D true;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            break;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     case OCC_MTU_REPLY:</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            if (!buf_write_u8(&amp;c-&gt;c2.buf, OCC_MTU_REPLY))</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                break;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (!buf_write_u16(&amp;c-&gt;c=
2.buf, c-&gt;c2.max_recv_size_local))</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                break;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            if (!buf_write_u16(&amp;c-&gt;c2.buf, c-&gt;c2.max_send_size_l=
ocal))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                break;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            dmsg(D_PACKET_CONT=
ENT, &quot;SENT OCC_MTU_REPLY&quot;);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            doit =3D true;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            break;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     case OCC_MTU_LOAD_REQUEST:</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            if (!buf_write_u8(&amp;c-&gt;c2.buf, OCC_MTU_LOAD_REQ=
UEST))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                break;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            if (!buf_write_u16=
(&amp;c-&gt;c2.buf, c-&gt;c2.occ_mtu_load_size))</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                break;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            dmsg(D_PACKET_CONTENT, &quot;SENT OCC_MTU_LOAD_REQU=
EST&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  doit =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        case OCC_MTU_LOAD:</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            int need_to_add;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            if (!buf_write_u8(&amp;c-&gt;c2.buf, O=
CC_MTU_LOAD))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            size_t prot=
o_hdr, payload_hdr;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          const struct key_type *kt =3D &amp;c-&gt;c1.ks.key_type;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            /* OCC message have comp/fragment heade=
rs but not ethernet headers */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            payload_hdr =3D frame_calculate_payload_overhead(0, &a=
mp;c-&gt;options, kt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Since=
 we do not know the payload size we just pass 0 as size here */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            proto_hdr =3D frame_c=
alculate_protocol_header_size(kt, &amp;c-&gt;options, false);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            need_to_add =3D min_int(c-&gt;c2.occ_mtu_loa=
d_size, c-&gt;c2.frame.buf.payload_size)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                          - OCC_STRING_SIZE - sizeof(uin=
t8_t) /* occ opcode */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                          - payload_hdr - proto_hdr;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            while (need_to_add &gt; 0)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                /*</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                 * Fill the load test packet with pseudo-r=
andom bytes.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
        */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     if (!buf_write_u8(&amp;c-&gt;c2.buf, get_random() &amp; 0xFF))</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    break;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                --need_to_add;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            dmsg(D_PACKET_CONTE=
NT, &quot;SENT OCC_MTU_LOAD min_int(%d,%d)-%d-%d-%d-%d) size=3D%d&quot;,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                 c-&gt;c=
2.occ_mtu_load_size, c-&gt;c2.frame.buf.payload_size, OCC_STRING_SIZE,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                 (int)size=
of(uint8_t), (int)payload_hdr, (int)proto_hdr, BLEN(&amp;c-&gt;c2.buf));</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            doit =3D tru=
e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        break;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         case OCC_EXI=
T:</span><br><span>             if (!buf_write_u8(&amp;c-&gt;c2.buf, OCC_EX=
IT))</span><br><span>             {</span><br><span>@@ -352,10 +148,6 @@</s=
pan><br><span>     c-&gt;c2.occ_op =3D -1;</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNU=
C__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> void</span><br><span> process_received_occ_msg(struct context =
*c)</span><br><span> {</span><br><span>@@ -367,20 +159,6 @@</span><br><span=
>             c-&gt;c2.occ_op =3D OCC_REPLY;</span><br><span>             b=
reak;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        case OCC_MTU_REQUEST:</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            dmsg(D_PACKET_CONTENT, &quot;RECEIVED OCC_MTU_REQUEST=
&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            c=
-&gt;c2.occ_op =3D OCC_MTU_REPLY;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            break;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case=
 OCC_MTU_LOAD_REQUEST:</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            dmsg(D_PACKET_CONTENT, &quot;RECEIVED OCC_MTU_LOAD_REQUEST&quo=
t;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            c-&gt=
;c2.occ_mtu_load_size =3D buf_read_u16(&amp;c-&gt;c2.buf);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            if (c-&gt;c2.occ_mtu_load_=
size &gt;=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  c-&gt;c2.occ_op =3D OCC_MTU_LOAD;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            break;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span>         case OCC_REPLY:</span><br><span>             d=
msg(D_PACKET_CONTENT, &quot;RECEIVED OCC_REPLY&quot;);</span><br><span>    =
         if (c-&gt;options.occ &amp;&amp; !TLS_MODE(c) &amp;&amp; c-&gt;c2.=
options_string_remote)</span><br><span>@@ -395,30 +173,6 @@</span><br><span=
>             event_timeout_clear(&amp;c-&gt;c2.occ_interval);</span><br><s=
pan>             break;</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        case OCC_MTU_REPLY:</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            dmsg(D_PACKET_CONTENT, &quot;RECEIVED=
 OCC_MTU_REPLY&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            c-&gt;c2.max_recv_size_remote =3D buf_read_u16(&amp;c-&gt;c2.b=
uf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            c-&gt=
;c2.max_send_size_remote =3D buf_read_u16(&amp;c-&gt;c2.buf);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            if (c-&gt;options.mtu_t=
est &amp;&amp; c-&gt;c2.max_recv_size_remote &gt; 0</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                &amp;&amp; c-&gt;c2.max_sen=
d_size_remote &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        msg(M_INFO,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                  &quot;NOTE: Empirical MTU test completed [Tried,Actual] l=
ocal-&gt;remote=3D[%d,%d] remote-&gt;local=3D[%d,%d]&quot;,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                    c-&gt;c2.max_send=
_size_local, c-&gt;c2.max_recv_size_remote,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    c-&gt;c2.max_send_size_remote, c-=
&gt;c2.max_recv_size_local);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                if (!c-&gt;options.ce.fragment &amp;&amp; (proto_is_=
dgram(c-&gt;options.ce.proto))</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                    &amp;&amp; c-&gt;c2.max_send_size_local &gt; T=
UN_MTU_MIN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         &amp;&amp; (c-&gt;c2.max_recv_size_remote &lt; c-&gt;c2.max_send_s=
ize_local</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
            || c-&gt;c2.max_recv_size_local &lt; c-&gt;c2.max_send_size_rem=
ote))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
msg(M_INFO,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
              &quot;NOTE: This connection is unable to accommodate a UDP pa=
cket size of %d. Consider using --fragment or --mssfix options as a workaro=
und.&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
              c-&gt;c2.max_send_size_local);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            event_timeout_clear(&amp;c-&gt;c2.occ_mtu_load_test_=
interval);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an>         case OCC_EXIT:</span><br><span>             dmsg(D_STREAM_ERROR=
S, &quot;OCC exit message received by peer&quot;);</span><br><span>        =
     register_signal(c-&gt;sig, SIGUSR1, &quot;remote-exit&quot;);</span><b=
r><span>diff --git a/src/openvpn/occ.h b/src/openvpn/occ.h</span><br><span>=
index 369d94e..2b816ec 100644</span><br><span>--- a/src/openvpn/occ.h</span=
><br><span>+++ b/src/openvpn/occ.h</span><br><span>@@ -45,39 +45,12 @@</spa=
n><br><span> #define OCC_INTERVAL_SECONDS 10</span><br><span> #define OCC_N=
_TRIES          12</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * O=
ther OCC protocol opcodes used to estimate the MTU empirically.</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#define OCC_MTU_LOAD_REQUEST 2 /* Ask peer to send =
a big packet to us */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define OCC_MTU_LOAD         3 /* Send a big packet to peer */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#define OCC_MTU_REQUEST           =
                                \</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    4                          /* Ask peer to tell us the large=
st \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
               * packet it has received from us so far */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#define OCC_MTU_REPLY 5        /* Send =
largest packet size to peer */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * Process one command from mtu=
_load_test_sequence</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 once every n seconds, if --mtu-test is specified.</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define OCC_MTU_LOAD_INTERVAL_SECONDS 3</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* 2 - 5 removed (OCC MTU Test) */</span><br><span> /*</span><br>=
<span>  * Send an exit message to remote.</span><br><span>  */</span><br><s=
pan> #define OCC_EXIT 6</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * Used to conduct a load test command sequence</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * of UDP connection for empirical MTU measureme=
nt.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-struct mtu_load_test</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    int op;    /* OCC opcode to send to peer */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    int delta; /* determine pac=
ket size to send by using</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                * this delta against currently</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                * configured MTU */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span> extern const uint8_t occ_magic[];=
</span><br><span> </span><br><span> static inline bool</span><br><span>@@ -=
90,8 +63,6 @@</span><br><span> </span><br><span> void check_send_occ_req_do=
work(struct context *c);</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-void check_send_occ_load_test_dowork(struct context *c=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> v=
oid check_send_occ_msg_dowork(struct context *c);</span><br><span> </span><=
br><span> /*</span><br><span>@@ -119,20 +90,6 @@</span><br><span> }</span><=
br><span> </span><br><span> /*</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * Should we send an MTU load test?</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-check_send_occ_load_test(struct context *c)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (event_timeout_defined(&amp;c-&gt;c2.occ_mtu_load_test_interval)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; ev=
ent_timeout_trigger(&amp;c-&gt;c2.occ_mtu_load_test_interval, &amp;c-&gt;c2=
.timeval,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                     (!TO_LINK_DEF(c) &amp;&amp; c-&gt;c2.occ_op &lt; 0) ? =
ETT_DEFAULT : 0))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        check_send_o=
cc_load_test_dowork(c);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-/*</span><br><span>  * Should we send an OCC message?</=
span><br><span>  */</span><br><span> static inline void</span><br><span>dif=
f --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h</span><br><span>ind=
ex 9325e21..c1cdb5a 100644</span><br><span>--- a/src/openvpn/openvpn.h</spa=
n><br><span>+++ b/src/openvpn/openvpn.h</span><br><span>@@ -301,23 +301,6 @=
@</span><br><span>     struct event_timeout occ_interval;</span><br><span> =
</span><br><span>     /*</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-     * Keep track of maximum packet size received so far</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-     * (of authenticated packets).</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    int original_recv_size;   /* tempo=
rary */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int max_re=
cv_size_local;  /* max packet size received */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    int max_recv_size_remote; /* max packet size r=
eceived by remote */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   int max_send_size_local;  /* max packet size sent */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    int max_send_size_remote; /* max pack=
et size sent by remote */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    /* remote wants us to send back a =
load test packet of this size */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    int occ_mtu_load_size;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
truct event_timeout occ_mtu_load_test_interval;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    int occ_mtu_load_n_tries;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    /*</span><br><span>      * TLS-mode crypto objects.</span>=
<br><span>      */</span><br><span>     struct tls_multi *tls_multi; /**&lt=
; TLS state structure for this VPN</span><br><span>diff --git a/src/openvpn=
/options.c b/src/openvpn/options.c</span><br><span>index 34af0d3..e3bcbc7 1=
00644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src=
/openvpn/options.c</span><br><span>@@ -305,7 +305,6 @@</span><br><span>    =
 &quot;                  &#39;no&#39;    -- Never send DF (Don&#39;t Fragme=
nt) frames\n&quot;</span><br><span>     &quot;                  &#39;maybe&=
#39; -- Use per-route hints\n&quot;</span><br><span>     &quot;            =
      &#39;yes&#39;   -- Always DF (Don&#39;t Fragment)\n&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    &quot;--mtu-test      : Empir=
ically measure and report MTU.\n&quot;</span><br><span> #ifdef ENABLE_FRAGM=
ENT</span><br><span>     &quot;--fragment max  : Enable internal datagram f=
ragmentation so that no UDP\n&quot;</span><br><span>     &quot;            =
      datagrams are sent which are larger than max bytes.\n&quot;</span><br=
><span>@@ -6479,11 +6478,6 @@</span><br><span>         VERIFY_PERMISSION(OP=
T_P_MTU | OPT_P_CONNECTION);</span><br><span>         options-&gt;ce.mtu_di=
scover_type =3D translate_mtu_discover_type_name(p[1]);</span><br><span>   =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (streq=
(p[0], &quot;mtu-test&quot;) &amp;&amp; !p[1])</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        options-&gt;mtu_test =3D true;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span>     el=
se if (streq(p[0], &quot;nice&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</spa=
n><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_NICE);<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1454?usp=3Demail">change 1454</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1454?usp=3Demail"/><meta itemprop=3D"name" content=3D=
"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic1e84ef6fb613851861a695bfbd=
bc1c32970a398 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1454 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--GQGNEDfpdpE=--

