From: James Yonan <jim@...41...>
References: <40E18559.8020407@...244...> <40EA6CFD.2030603@...83...> <Pine.LNX.4.60.0407061112170.372@...210...>
In-Reply-To: <Pine.LNX.4.60.0407061112170.372@...210...>
MIME-Version: 1.0
Message-Id: <200407071803.14060.jim@...41...>
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
Date: Wed Jul  7 16:03:00 2004
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Mathias Sundman <mathias@...209...>
Cc: Jan Kiszka <jan.kiszka@...83...>, openvpn-devel@lists.sourceforge.net

On Tuesday 06 July 2004 04:25, Mathias Sundman wrote:
> On Tue, 6 Jul 2004, Jan Kiszka wrote:
> >>>>> If it's not a windows specific problem, then I suppost it's best to
> >>>>> add the functionallity in the openvpn binary so we get the
> >>>>> portability.
> >>>>
> >>>> I don't think the openvpn binary needs to know about this.  But the
> >>>> service wrapper probably needs a second mode of operation, where
> >>>> instead of getting its config files by scanning a directory, it
> >>>> listens on a local socket for a command from the GUI to start an
> >>>> openvpn.exe instance.
> >>>
> >>> Then don't forget that we will need a similar wrapper for unix as
> >>> well...

I'm not sure that we really need a wrapper for unix, because most unix users 
will control OpenVPN by:

(1) editing config files and starting from /etc/init.d, or
(2) using some sort of GUI-based admin tool such as YaST

and both of these methods are traditionally done as root.

> >> Why do we need a wrapper in unix? Can't the openvpn binary be run as a
> >> normal user in unix?
> >>
> >> If we need root-privs, what's wrong with installing openvpn as suid
> >> root and have it drop its privs after start-up?

Not a big problem, though some might prejudice a package which requires SUID.

> > Yes, this will work. But I'm afraid - maybe I'm wrong - that the GUI will
> > then have to be implemented quite differently on Windows and Unix. On
> > Windows, we would open a socket and both send the commands over it and
> > receive the status. On Unix, we would first start the process and then
> > connect to a socket for status information (BTW, which socket would then
> > be used when multiple instances of openvpn are running?).

Should the unix GUI be written for generic X, or should we develop admin 
modules for specific distros such as YaST?

I would go for the latter, because it will make the interface fit more 
seamlessly into a distribution's existing admin infrastructure.

> Yes and No. The way the GUI starts an openvpn process will have to
> implemented in diffrent ways for unix and windows. On Windows it will open
> a socket to the service wrapper and tell it to start an openvpn process
> with a specific config. On unix it will launch the openvpn process itself.
> This is not many lines of code so I think it can be handled with ifdefs
> quite cleanly.
>
> Then when the openvpn process has been started the gui connects to a
> socket that openvpn is listening on to receive status or send other
> commands that we can think of.
>
> The socket each openvpn process is listening on should be specified in the
> config-file with an option like "management 127.0.0.1 6001", where 6001 is
> the TCP port number. So each process should be listening on a unique port.
>
> A perhaps cleaner way is that the gui adds the manangement option when it
> starts the openvpn process, so the user don't have to bother setting the
> correct management option in his config-files.

I agree.  This is sort of like the way the current service wrapper passes 
--service to each OpenVPN process.

So the system-tray GUI manages a pool of 127.0.0.1 ports and allocates them to 
OpenVPN processes.

James

