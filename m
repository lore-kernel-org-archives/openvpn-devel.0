Message-ID: <4C90BA5F.7010702@...1147...>
Date: Wed, 15 Sep 2010 14:21:51 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
Subject: [Openvpn-devel] comp-lzo & push "comp-lzo"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: OpenVPN Users <openvpn-users@lists.sourceforge.net>, openvpn-devel@lists.sourceforge.net

hi all,

just noticed something odd with openvpn 2.1 (.1 & .3):

in the server config I specify
  comp-lzo
  push "comp-lzo"

if the client config has does NOT have a line
  comp-lzo
then this "push" is not picked up by the client. If the client has a line
  comp-lzo no
(or 'yes' or 'adaptive' ) then the pushed value DOES get picked up by 
the client.

Seems like an initialization error in init.c: it only initializes the 
LZO libs if a parameter was specified:

3179 #ifdef USE_LZO
3180   /* initialize LZO compression library. */
3181   if ((options->lzo & LZO_SELECTED) && (c->mode == CM_P2P || child))
3182     lzo_compress_init (&c->c2.lzo_compwork, options->lzo);
3183 #endif

(lzo_compress_init sets a flag which causes the macro lzo_defined() to 
return true).
When the PUSH message is received from the server it does contain the 
'comp-lzo' statement but it is not processed by init.c:

1580 #ifdef USE_LZO
1581   if (found & OPT_P_COMP)
1582     {
1583       if (lzo_defined (&c->c2.lzo_compwork))
1584     {
1585       msg (D_PUSH, "OPTIONS IMPORT: LZO parms modified");
1586       lzo_modify_flags (&c->c2.lzo_compwork, c->options.lzo);
1587     }
1588     }
1589 #endif

so if you want the client to automagically pick up the right 'comp-lzo' 
setting from the server, specify
  comp-lzo no
in the client config - that way , the server can always overrule it 
using the appropriate 'push' directive.

cheers,

JJK


