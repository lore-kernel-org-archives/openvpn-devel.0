From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Plugins programming issue
In-Reply-To: <loom.20050414T234219-298@...171...>
Message-ID: <Pine.LNX.4.58.0504141931270.30252@...41...>
References: <loom.20050414T234219-298@...171...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Apr 14 18:59:58 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: RN <rn23@...160...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, 14 Apr 2005, RN wrote:

> OpenVPN issue on rc21: I experience a very big oddity when a plugin is 
> initialized with OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY flag on, but the VPN 
> config is set to TLS: on ssl.c, we get into the "if" on line 2581, but this is 
> IMO not correct. Then we go further to read_string on line 2589 and finally 
> fail.
> 
> I also wonder if something of the sort happens then the VPN is set to work 
> with U/P and the plugin is initialized with OPENVPN_PLUGIN_TLS_VERIFY.
> 
> The problem, is that the plugin may be initialized for informational purposes 
> only to handle the event. The bigger problem, is that one configuration may 
> have TLS and another one U/P, and both may use the same plugin. My plugin 
> sends all the event to an ODBC source, therefore suffering a great deal from 
> this IMO broken behaviour.
> 
> IMO, the condition on line 2581 should lead in this case directly to 
> the "else" on line 2624 to behave correctly.
> 
> Unfortunately I am not legally allowed to contribute GPL'ed fixes, so I would 
> appreciate a community fix.

If I understand you correctly, you are asking that a plugin which
registers an OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY callback should not
cause OpenVPN to trigger a key negotiation error condition if the client 
doesn't specify a U/P?

This seems like it would present a security vulnerability, because it
would allow a client to bypass the OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY
callback by simply not specifying a U/P.

If you want the condition on line 2581 to lead directly 
to the "else" on line 2624, just don't register the 
OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY callback and don't specify an 
--auth-user-pass-verify script.

The point here is that if either an OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY 
callback is registered or an --auth-user-pass-verify script is specified 
in the server config, a client MUST provide U/P authentication 
(possibly in addition to client certificate verification as well) or the 
authentication will fail.

James

