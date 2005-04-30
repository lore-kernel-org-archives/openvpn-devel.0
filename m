From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Radius support (Authentification, Authorization
 and Accounting)
In-Reply-To: <1114863340.22186.13.camel@...344...>
Message-ID: <Pine.LNX.4.58.0504301326180.25603@...41...>
References: <200504291033.00667.ralfluebben@...68...> 
 <Pine.LNX.4.58.0504291041510.24107@...41...>  <200504300904.51200.ralfluebben@...68...>
  <Pine.LNX.4.58.0504300118280.24107@...41...> <1114863340.22186.13.camel@...344...>
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
Date: Sat Apr 30 12:29:09 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Daniel Lehmann <ov_devel@...300...>
Cc: openvpn-devel@lists.sourceforge.net

On Sat, 30 Apr 2005, Daniel Lehmann wrote:

> Am Samstag, den 30.04.2005, 01:42 -0600 schrieb James Yonan:
> > Right now, you can only get it by reading the --status file.  For 2.1 I'm 
> > considering to add another script/callback for passing current accounting 
> > data.
> > 
> > One of the goals of the plugin interface is to allow a fully-featured
> > Radius plugin to be developed, as you are doing, so I would be happy to
> > work with you on extending the plugin interface for 2.1 if you find that
> > the current plugin API is insufficient.
> > 
> > > Another question about the IP address and OPENVPN_PLUGIN_CLIENT_CONNECT. 
> > > Is there a possibility to give the IP address direct to the OpenVPN process or 
> > > must I create the configuration files when a client connects?
> > 
> > No, you have to write configuration file directives (containing the
> > appropriate ifconfig-push directive) to the temporary file provided by the
> > caller.  This is so that we can maintain an identical interface for both
> > script and plugin calls.
> 
> Hi James,
> as I'm also working on Radius integration via a plugin, I wondered if
> there is the possibility to provide options for the scripts/plugins in
> the openvpn config.
> 
> For example, the openvpn config file could look like:
> ...
> dev tun
> pull
> option key1 value1
> option key2 value2

Take a look at the "setenv" directive.  The setenv list is passed to 
plugins.

James


