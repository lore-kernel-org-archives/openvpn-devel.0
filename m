Message-ID: <4AF1B7F6.8040607@...1114...>
Date: Wed, 04 Nov 2009 18:20:54 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [man page] - update --keepalive
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net


Hi!

I've been looking at the keepalive option today, after having discussed
it a bit on IRC.  It seems some vital information is missing here.

The man page says:
------------------------------------------------------------------------
       --keepalive n m
              A  helper  directive  designed to simplify the expression
of --ping and
              --ping-restart in server mode configurations.

              For example, --keepalive 10 60 expands as follows:

               if mode server:
                 ping 10
                 ping-restart 120
                 push "ping 10"
                 push "ping-restart 60"
               else
                 ping 10
                 ping-restart 60
------------------------------------------------------------------------

The ping-restart in the server mode is in this example set to 120.  It
do not come clear out that this is 60*2, as I see in the source code.  A
normal user might even understand it as 120 seconds is a hard coded value.

From helper.c
------------------------------------------------------------------------
      if (o->mode == MODE_POINT_TO_POINT)
        {
          o->ping_rec_timeout_action = PING_RESTART;
          o->ping_send_timeout = o->keepalive_ping;
          o->ping_rec_timeout = o->keepalive_timeout;
        }
#if P2MP_SERVER
      else if (o->mode == MODE_SERVER)
        {
          o->ping_rec_timeout_action = PING_RESTART;
          o->ping_send_timeout = o->keepalive_ping;
          o->ping_rec_timeout = o->keepalive_timeout * 2;
          push_option (o, print_str_int ("ping", o->keepalive_ping,
					 &o->gc), M_USAGE);
          push_option (o, print_str_int ("ping-restart",
                                         o->keepalive_timeout,
					 &o->gc), M_USAGE);
        }
#endif
------------------------------------------------------------------------


Would a better explanation be like this?

              For example, --keepalive XX YY expands as follows:

               if mode server:
                 ping XX
                 ping-restart YY*2
                 push "ping XX"
                 push "ping-restart YY"
               else
                 ping XX
                 ping-restart YY

              The XX and YY markers must be integer values, defining
	      the ping time and ping-restart values in seconds.
	

This is to highlight more where those variables are used and how they
are used.



kind regards,

David Sommerseth


