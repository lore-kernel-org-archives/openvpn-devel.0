Message-ID: <03fe01c21c61$aef36f70$1000000a@...4...>
From: "James Yonan" <jim@...3...>
References: <20020625142411.GC24695@...6...>
Subject: Re: [Openvpn-devel] Features comments/request
MIME-Version: 1.0
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
Date: Tue Jun 25 09:01:07 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: Alberto Gonzalez Iniesta <agi@...5...>, openvpn-devel@lists.sourceforge.net

Hi Alberto,

> I'd like to ask for a couple of features (little ones) added to OpenVPN.
> Comments welcomed.
>
> 1) OpenVPN should refuse to start a connection based on shared secret
> when the file containing that key is world readable (or writable).
> Paranoia won't even like group readable :-)
> Really, that's an important piece (the most?) in that kind of VPN, we
> don't want it to be public. Just imagine an (non-chrooted) anonymous
> ftp server, a bad configured web server/cgi-script, a malicious user,...

Good idea, however what if someone doesn't want to deal with the protections
on every file and instead just eliminates group/world access to the key
directory?  Therefore, erring on the individual file protections could
create a false sense of paranoia?

> 2) Each OpenVPN daemon should delete its pidfile when stoping, since it
> was that very same daemon that created it.
> It has no sense to have the init.d scripts deleting these files (and
> stoping nonexistent daemons) since the daemon could have been killed
> before the init.d script tried to stop it.

The complication here is that a lot of people will want to downgrade
privilege using --user and/or --group.  That means that when an OpenVPN
daemon is ready to exit, it might lack the privilege to delete its own
pidfile.  I've seen other daemons deal with this by chowning the pid file to
the user/group that the daemon plans to setuid/setgid to.

Having said that, I think both ideas are worth doing.

Thanks,
James



