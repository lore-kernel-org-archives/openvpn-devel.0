From: James Yonan <jim@...41...>
References: <40E18559.8020407@...244...> <40E744F9.5000700@...83...> <Pine.LNX.4.60.0407052042310.29911@...210...>
In-Reply-To: <Pine.LNX.4.60.0407052042310.29911@...210...>
MIME-Version: 1.0
Message-Id: <200407051513.29794.jim@...41...>
Subject: [Openvpn-devel] Re: Interface with GUI agent
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
Date: Mon Jul  5 12:13:10 2004
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Mathias Sundman <mathias@...209...>
Cc: Jan Kiszka <jan.kiszka@...83...>, openvpn-devel@lists.sourceforge.net

On Monday 05 July 2004 14:49, Mathias Sundman wrote:
> On Sun, 4 Jul 2004, Jan Kiszka wrote:
> > I would like to have some mechanism to fork an openvpn instance and let
> > the new process use a specific configuration file. This would allow to
> > start only certain VPN tunnels depending on what the user selects in the
> > GUI.
>
> I've been giving this some more thought... and I agree we definitly need
> something like this.
>
> Is it possible in windows to install a program as SUID in unix, so the
> application is ran as administrator even though it is started by an
> ordinary user? If yes, that would be eliminate the need to fork new
> processes (as I can think of right now atleast).

No, I don't think this is possible in Windows.

> If no, Is it only on windows we can't do this, or do we have this problem
> on other platforms too?

Most other platforms support the SUID bit.

> If it's a windows specific problem, then maybe this functionally should be
> in the service wrapper. If we add a simple interface to the service
> wrapper our gui client could tell the service wrapper to start new openvpn
> processes when we want.

Yes, this is probably a better idea.

> If it's not a windows specific problem, then I suppost it's best to add
> the functionallity in the openvpn binary so we get the portability.

I don't think the openvpn binary needs to know about this.  But the service 
wrapper probably needs a second mode of operation, where instead of getting 
its config files by scanning a directory, it listens on a local socket for a 
command from the GUI to start an openvpn.exe instance.

James

