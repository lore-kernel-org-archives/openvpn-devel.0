From: "Doncho N. Gunchev" <mr700@...184...>
Reply-To: mr700@...184...
Subject: Re: [Openvpn-devel] First post and an alternative idea for OpenVPN startup on Linux
References: <1100737211.8135.32.camel@...318...> <1100764891.19571.15.camel@...318...> <Pine.LNX.4.58.0411180452440.6370@...41...>
In-Reply-To: <Pine.LNX.4.58.0411180452440.6370@...41...>
MIME-Version: 1.0
Message-Id: <200411181606.51256@...187...>
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
Date: Thu Nov 18 06:08:04 2004
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On 2004 11 18 (Thursday) 14:55, James Yonan wrote:
> On Thu, 18 Nov 2004, Paul Iadonisi wrote:
> 
> > On Thu, 2004-11-18 at 07:20 +0100, Mathias Sundman wrote:
> > 
> > [snip]
> > 
> > > I think it's a good idea to have simple "redhat look-alike" scripts to 
> > > start / stop individual openvpn tunnels, to make life easier for users.
> > > 
> > > But, I hounestly dislike the idea of introducing a new config file format 
> > > like this. I don't really see the purpose. Why not just refer to an 
> > > OpenVPN config file instead?
> > 
> >   While I can understand that assessment, and even hesitated at
> > implementing this myself, I'll note that Red Hat does in fact do this
> > both with the built-in IPsec and with dhcp configuration.
> >   I've actually seen this kind of thing as a common tension between the
> > application developers' desire to make an application appear the same,
> > or largely same, no matter what platform you are on, and the platform
> > developers' desire to make things fit nicely into their own platform.  I
> > guess I fit into the later category.
> 
...
> 
> I think the bottom line is that the portability and stability of the
> configuration spec matters.  In my view one of the largest hurdles that
> open source projects need to overcome in order to become viable is
> achieving a critical mass of documentation.  Now that the OpenVPN project
> has largely attained this, I'm going to be extremely hesistant in
> embracing any kind of config file spec refactoring that would render this
> documentation obsolete.
> 
> James
> 

    Just an idea, would it be acceptable to you bouth if it is done like
this:
---
TYPE=OpenVPN
DEVICETYPE=tap1 # or tun1
OpenVPNCFG=/etc/openvpn/client.conf # or /etc/openvpn/server.openvpn
USERCTL=no # yes? - use RH/FC's idea to start it
ONBOOT=yes # no
USEDIF=eth0 # what other interface is needed up to work, maybe...?
---
    This way the 'real' configuration, except giving users the right to
start/stop the vpn tunnel, is kept in openvpn's config file, but leaves
a root for managing with distro's specific configuration tool(s) or by
hand. Fedora's system-config-network can be extended with OpenVPN specific
GUI for OpenVPN config file editing too...
    Is this OK? I hope this scenario will work for most other distros too?

Just my 0.02 lv :)

-- 
Regards,
  Doncho N. Gunchev    Registered Linux User #291323 at counter.li.org
  GPG-Key-ID: 1024D/DA454F79                        http://pgp.mit.edu
  Key fingerprint = 684F 688B C508 C609 0371  5E0F A089 CB15 DA45 4F79

