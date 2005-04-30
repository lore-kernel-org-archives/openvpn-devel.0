From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Radius support (Authentification, Authorization
 and Accounting)
In-Reply-To: <1114864741.22186.28.camel@...344...>
Message-ID: <Pine.LNX.4.58.0504301327500.25603@...41...>
References: <200504291033.00667.ralfluebben@...68...> 
 <Pine.LNX.4.58.0504291041510.24107@...41...>  <200504300904.51200.ralfluebben@...68...>
  <Pine.LNX.4.58.0504300118280.24107@...41...> <1114864741.22186.28.camel@...344...>
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
Date: Sat Apr 30 12:35:12 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Daniel Lehmann <ov_devel@...300...>
Cc: openvpn-devel@lists.sourceforge.net

On Sat, 30 Apr 2005, Daniel Lehmann wrote:

> Am Samstag, den 30.04.2005, 01:42 -0600 schrieb James Yonan:
> [snip]
> > No, you have to write configuration file directives (containing the
> > appropriate ifconfig-push directive) to the temporary file provided by the
> > caller.  This is so that we can maintain an identical interface for both
> > script and plugin calls.
> 
> Hi James,
> I've just read your mail again and wondered why script and plugin have
> to be equal in functionality.
> If there was the chance of avoiding file io, I would be much more happy.
> 
> But maybe there is another alternative. Maybe the IP adress could be the
> return value of the client connect script/plugin or something like that.
> 
> I'm just unhappy with creating files only to provide this little
> information...

I agree that this method is not perfect, but it has the two important 
properties that:

(1) it lets OpenVPN handle script or plugin calls the same
(2) it works on all OSes, including Windows

And remember that you can also optimize out the use of disk files with 
something like (on Linux):

  tmp-dir /dev/shm

James

