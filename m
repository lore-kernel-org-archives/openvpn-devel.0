From: James Yonan <jim@...41...>
References: <40E18559.8020407@...244...> <40EA61C7.9070406@...83...> <Pine.LNX.4.60.0407061042300.372@...210...>
In-Reply-To: <Pine.LNX.4.60.0407061042300.372@...210...>
MIME-Version: 1.0
Message-Id: <200407071737.06756.jim@...41...>
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
Date: Wed Jul  7 15:37:03 2004
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Mathias Sundman <mathias@...209...>
Cc: Jan Kiszka <jan.kiszka@...83...>, openvpn-devel@lists.sourceforge.net

On Tuesday 06 July 2004 03:46, Mathias Sundman wrote:
> On Tue, 6 Jul 2004, Jan Kiszka wrote:
> > James Yonan wrote:
> >> ...
> >>
> >>> If it's not a windows specific problem, then I suppost it's best to add
> >>> the functionallity in the openvpn binary so we get the portability.
> >>
> >> I don't think the openvpn binary needs to know about this.  But the
> >> service wrapper probably needs a second mode of operation, where instead
> >> of getting its config files by scanning a directory, it listens on a
> >> local socket for a command from the GUI to start an openvpn.exe
> >> instance.
> >
> > Then don't forget that we will need a similar wrapper for unix as well...
>
> Why do we need a wrapper in unix? Can't the openvpn binary be run as a
> normal user in unix?

The sticking point for running in user mode is opening the tun/tap device node 
and adding routes.

James

