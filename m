From: Alberto Gonzalez Iniesta <agi@...5...>
Subject: Re: [Openvpn-devel] Features comments/request
Message-ID: <20020627072656.GD8307@...6...>
References: <20020625142411.GC24695@...6...> <03fe01c21c61$aef36f70$1000000a@...4...>
Mime-Version: 1.0
In-Reply-To: <03fe01c21c61$aef36f70$1000000a@...4...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Thu Jun 27 00:28:02 2002
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: James Yonan <jim@...3...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, Jun 25, 2002 at 10:02:18AM -0600, James Yonan wrote:
> Hi Alberto,
> 
> > I'd like to ask for a couple of features (little ones) added to OpenVPN.
> > Comments welcomed.
> >
> > 1) OpenVPN should refuse to start a connection based on shared secret
> > when the file containing that key is world readable (or writable).
> > Paranoia won't even like group readable :-)
> Good idea, however what if someone doesn't want to deal with the protections
> on every file and instead just eliminates group/world access to the key
> directory?  Therefore, erring on the individual file protections could
> create a false sense of paranoia?

Hi James,

Yes, forcing directory security could be a better solution, but what
happens if the user wants to keep the key in a directory like /etc? or
/usr/local/etc? From my point of view (Debian's package) there's no
problem, I'll probably go for a /etc/openvpn/secrets directory, but just
wanted to note this in case you wanted to think about it.


> > 2) Each OpenVPN daemon should delete its pidfile when stoping, since it
> > was that very same daemon that created it.
> > It has no sense to have the init.d scripts deleting these files (and
> > stoping nonexistent daemons) since the daemon could have been killed
> > before the init.d script tried to stop it.
> 
> The complication here is that a lot of people will want to downgrade
> privilege using --user and/or --group.  That means that when an OpenVPN
> daemon is ready to exit, it might lack the privilege to delete its own
> pidfile.  I've seen other daemons deal with this by chowning the pid file to
> the user/group that the daemon plans to setuid/setgid to.

Didn't think of that. Good point. :-)
Thanks for your work. 

Best regards,
Alberto
 

-- 
Alberto Gonzalez Iniesta       | They that give up essential liberty
agi@...5...                     | to obtain a little temporary safety
Encrypted mail preferred       | deserve neither liberty nor safety.

Key fingerprint = 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

