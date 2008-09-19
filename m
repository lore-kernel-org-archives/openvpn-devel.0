From: Jose Sanchez <jose.informatica@...1125...>
Date: Fri, 19 Sep 2008 12:34:40 +0200
Message-Id: <1221820480.14052.2.camel@...1126...>
Mime-Version: 1.0
Subject: [Openvpn-devel] About making plugins for openvpn
Reply-To: jose.informatica@...1125...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hello, I am new at openvpn, I am trying to do a very simple plugin to
see connections/disconnections and to be able to notify to another
system in "real" time.

The problem is that I haven't found any documentation about the code or
about how to make plugins except on the code (I have been reading the
comments and I have some code of my plugin).

The main problem is that there are two functions: OPENVPN_PLUGIN_DEF int
OPENVPN_PLUGIN_FUNC(openvpn_plugin_func_v1)
     (openvpn_plugin_handle_t handle, const int type, const char
*argv[], const char *envp[]);
and
OPENVPN_PLUGIN_DEF int OPENVPN_PLUGIN_FUNC(openvpn_plugin_func_v2)
     (openvpn_plugin_handle_t handle,
      const int type,
      const char *argv[],
      const char *envp[],
      void *per_client_context,
      struct openvpn_plugin_string_list **return_list);

What I need is to obtain the public (inet IP) and the private (vpn ip)
when a client connects/disconnect to notify it to another program (I
know I can make a ping or similar things but it seems to be too slow
when there are a lot of clients connected (> 100)).

What I need is to know in which variable is that data and which function
I need to implement (v1 or v2) and how these functions works (Is any
documentation on any site?).

In openvpn_plugin_open_v1 I have registered the events: *type_mask =
OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_CONNECT) |
OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_DISCONNECT); and even on
openvpn_plugin_func_v1  I can know if there is if (type ==
OPENVPN_PLUGIN_CLIENT_CONNECT) or OPENVPN_PLUGIN_CLIENT_DISCONNECT but I
don't know how to recover IP information.

If somebody could help me or saying me where the documentation is would
be great.

Thanks in advance and excuse my english (I have written this too
quickly) and excuse me if what i am asking is answered on another place
that I haven't found.

-- 
Jose Sánchez <jose dot informatica at centrolamilagrosa dot org>



