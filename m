From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] First post and an alternative idea for OpenVPN
 startup on Linux
In-Reply-To: <1100764891.19571.15.camel@...318...>
Message-ID: <Pine.LNX.4.58.0411180452440.6370@...41...>
References: <1100737211.8135.32.camel@...318...> 
 <Pine.LNX.4.61.0411180705550.7280@...210...>
 <1100764891.19571.15.camel@...318...>
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
Date: Thu Nov 18 04:56:19 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Paul Iadonisi <pri.openvpn@...317...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, 18 Nov 2004, Paul Iadonisi wrote:

> On Thu, 2004-11-18 at 07:20 +0100, Mathias Sundman wrote:
> 
> [snip]
> 
> > I think it's a good idea to have simple "redhat look-alike" scripts to 
> > start / stop individual openvpn tunnels, to make life easier for users.
> > 
> > But, I hounestly dislike the idea of introducing a new config file format 
> > like this. I don't really see the purpose. Why not just refer to an 
> > OpenVPN config file instead?
> 
>   While I can understand that assessment, and even hesitated at
> implementing this myself, I'll note that Red Hat does in fact do this
> both with the built-in IPsec and with dhcp configuration.
>   I've actually seen this kind of thing as a common tension between the
> application developers' desire to make an application appear the same,
> or largely same, no matter what platform you are on, and the platform
> developers' desire to make things fit nicely into their own platform.  I
> guess I fit into the later category.

The main problem I have with this approach is that it creates a new
configuration interface for OpenVPN which must be documented and
maintained.  It also creates problems for people who want to migrate to
and from the distribution where the alternative interface is supported.

Now having said that, I do appreciate that distribution developers want to
provide a consistent interface to daemon configuration.  But I've also
observed that most distributions have a line they will not cross as far as
redefining the details of a particular daemon's configuration format.  
SuSE, for example (like most Linux distros) has a bunch of SuSE-specific
front-ends for network daemons in /etc/sysconfig, but at the same time
they would not touch a more configuration-complex daemon such as samba
which has its own tree in /etc/samba and aside from the SuSE-modified
smb.conf, exists largely unaltered from the samba.org release.  I would 
put OpenVPN in the same camp -- the configuration is too complex to be 
able to be rewritten into /etc/sysconfig as you would an ethernet adapter 
or DHCP client config.

I think the bottom line is that the portability and stability of the
configuration spec matters.  In my view one of the largest hurdles that
open source projects need to overcome in order to become viable is
achieving a critical mass of documentation.  Now that the OpenVPN project
has largely attained this, I'm going to be extremely hesistant in
embracing any kind of config file spec refactoring that would render this
documentation obsolete.

James

