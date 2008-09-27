Message-ID: <48DDF993.8000409@...1114...>
Date: Sat, 27 Sep 2008 11:14:59 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN plugin - OPENVPN_PLUGIN_LEARN_ADDRESS
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


Hi folks!

I've been writing a plug-in for OpenVPN for quite some time now, and today I found a new trigger in
openvpn_plugin_func_v1(...) with a OPENVPN_PLUGIN_LEARN_ADDRESS call, which I've never seen before.

I know this function can be called with 'add' and 'delete' arguments.  But today I experienced
'update', which I am not sure how to handle.  Are there any documentation on the arguments and
environment variables available for this call?

And when is this actually called?  I've been running OpenVPN connection both with "short time"
connections (<1 minute) and "long time" connections (>48 hours), and today I experience this one.
How can I reproduce this action?

My OpenVPN server which is running this plug-in is updating the iptables firewall based on the VPN
clients MAC address, so it's kind of crucial for me to understand how this update works.

I also see (since my handler returned the update with an error), that OpenVPN tried to call this
function 5 times, and then did a delete and add.  Is this the "plan B" solution for OpenVPN, when
update fails?


PS! A public wiki would be lovely for OpenVPN (I know there are some wiki functionality at
SourceForge, if you don't want to set it up by yourself) ... I know I would be able to contribute
with some things regarding OpenVPN plug-in and configuration of OpenVPN.


kind regards,

David Sommerseth

