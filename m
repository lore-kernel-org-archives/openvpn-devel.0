Message-ID: <a6589cd604110609422df836b8@...278...>
From: Hans Fugal <fugalh@...277...>
Reply-To: Hans Fugal <fugalh@...277...>
Subject: Re: [Openvpn-devel] CreateFile failed on TAP device
In-Reply-To: <Pine.LNX.4.61.0411061639340.3607@...210...>
Mime-Version: 1.0
References: <a6589cd6041105091611d082c6@...278...>
	 <Pine.LNX.4.61.0411061639340.3607@...210...>
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
Date: Sat Nov  6 09:47:02 2004
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Mathias Sundman <mathias@...209...>, openvpn-devel@lists.sourceforge.net

Ahh, well now I know what that error means if someone accidentally
disables the TAP device in the future.

BTW is there a command-line way to rename the tap device to something
like OpenVPN TAP Device N or something, rather than Local Area
Connection N? It would make it easier for phone support. I ask for
command-line because that could be done automatically in my installer.


On Sat, 6 Nov 2004 16:41:54 +0100 (CET), Mathias Sundman
<mathias@...209...> wrote:
> 
> 
> On Fri, 5 Nov 2004, Hans Fugal wrote:
> 
> > A user is getting this error. She's using XP
> >
> > Fri Nov 05 09:07:24 2004 us=747770 CreateFile failed on TAP device:
> > \\.\Global\{A3B605BE-B118-49BA-92C3-C6ADFD7A364C}.tap: The system
> > cannot find the file specified.   (errno=2)
> >
> > Attached is her full log. She was connecting just fine yesterday. I've
> > had her stop and start via openvpn gui, with the same results (this
> > log file is from the start after the stop)
> >
> > I don't know what to tell her, other than to uninstall, reboot, and
> > reinstall. Does anyone have any other advice?
> 
> Ahh, now I remember. This was asked a few weeks ago, and then someone gave
> the tip to check if the TAP device had misstakenly been disabled.
> 
> I just checked, and you do get exactly that message if the device is
> disabled.
> 
> I guess reinstalling openvpn re-enables the interface, so that explains
> why that would solve the problem.
> 
> 
> 
> --
> _________________________________________________________
> Mathias Sundman              (^)   ASCII Ribbon Campaign
> NILINGS AB                    X    NO HTML/RTF in e-mail
> Tel: +46-(0)8-666 32 28      / \   NO Word docs in e-mail
> 


-- 
De gustibus non disputandum est.

