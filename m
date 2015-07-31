Message-ID: <55BB5E10.70002@...1114...>
Date: Fri, 31 Jul 2015 13:37:52 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20150730233727.GW3676@...2049...>
In-Reply-To: <20150730233727.GW3676@...2049...>
Subject: Re: [Openvpn-devel] Packet loss due to radius issues
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Samuel Thibault <samuel.thibault@...1817...>, openvpn-devel@lists.sourceforge.net

On 31/07/15 01:37, Samuel Thibault wrote:
> Hello,
> 
> We've been having issues on our VPN server due to the way authentication
> is done in openvpn.  Basically, when a user would connect to the VPN
> server, no trafic would pass for a couple of seconds, thus making
> the VPN way less effective...  This was an unfortunate combination
> of several issues described below.  Our current setup is openvpn in
> multiple client mode, with the openvpn-auth-radius plugin to get
> authentication from a couple of radius servers on two other machines
> next to our VPN server.
> 
> Here is what happens:
> 
> - AIUI, when openvpn receives an authentication request, it gives hand
> to the authentication plugin, and thus while the authentication plugin
> is working on it, no trafic can be handled by openvpn.  That is, I
> believe, an important issue, and will turn that into a bug report.  The
> issue is that authentication might take time for whatever reason (see
> below for an example).

This is correct, this is the behaviour unless the auth plugin uses deferred
authentication.  That means that the auth-plugin can receive the auth request
and return OPENVPN_PLUGIN_FUNC_DEFERRED.  The auth request must then continue
in a different thread, which receives the results and returns it to OpenVPN
via a auth_control_file.  See the sample/sample-plugins/defer example for more
details.


-- 
kind regards,

David Sommerseth

