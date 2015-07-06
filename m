MIME-Version: 1.0
Date: Mon, 6 Jul 2015 15:49:21 -0400
Message-ID: <CADu_VSbyM50vRDkwwLHUVSF0h0e6GqrGQWdntpP0qeCzh4Tung@...278...>
From: Matthew Karas <mkarascybi@...277...>
Subject: [Openvpn-devel] getting config information back to the openvpn
 client through the auth plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Openvpn-devel@lists.sourceforge.net

I am looking to get individualized data back to each client through
the openvpn plugin - when they're connecting.

David Sommerseth has provided some good feedback saying it would be
possible using openvpn_plugin_args_func_in pointer passed into
openvpn_plugin_func_v3().

I'm not really closing the loop on how this is done.  What do I set in
openvpn_plugin_args_func_in?  How do I get the client to retrieve that
information?

My main goal is for my client to get a number from the vpn server that
is calculated by the openvpn client while it's being authorized.

-Matt

