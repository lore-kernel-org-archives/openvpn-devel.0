From: Mathias Sundman <mathias@...209...>
Subject: Re: [Openvpn-devel] Re: Interface with GUI agent
In-Reply-To: <200407082328.32017.vda@...216...>
Message-ID: <Pine.LNX.4.60.0407082318240.6520@...210...>
References: <40E18559.8020407@...244...>
 <Pine.LNX.4.60.0407080941160.5287@...210...> <200407081043.25501.jim@...41...>
 <200407082328.32017.vda@...216...>
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
Date: Thu Jul  8 14:38:01 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

On Thu, 8 Jul 2004, Denis Vlasenko wrote:

>>>>> 1. On Windows, if the the service wrapper has started some openvpn
>>>>> processes before our gui agent is started, how should find out about
>>>>> those processes?
>>>>
>>>> I think it's an important point worth some discussion on whether to (a)
>>>> put all the "intelligence" in the GUI applet and have the service
>>>> wrapper just be a basic proxy to an admin-privileged CreateProcess, or
>>>> (b) write a portable service wrapper that's designed to run on all the
>>>> OSes which OpenVPN currently supports, and which would do all the
>>>> "under-the-hood" work in starting/stopping/managing of different
>>>> OpenVPN processes, and the GUI applet would do nothing more than export
>>>> the control interface of the portable service wrapper to a
>>>> platform-specific, lightweight GUI.
>
> (b) already exists. It's daemontools. (Does not exist on NT, though).
> Daemontools' license is not open enough, but there is a opensource clone
> at http://smarden.org/runit/.
>
> ...
>
> What I am trying to say? I am very happy that you guys are actively
> working on openvpn. Really.
>
> Just please do not OVERdesign it.
>
> Maybe it's better to try to port daemontools to Windows
> and run openvpn daemon(s) under it.

I agree that we must watch out so we don't overdesign it. It's easily 
done. However, one thing to keep in mind is that we're not talking about 
adding complexity to the openvpn binary (except for an interface to get 
status information), and we're not talking about removing current 
functionallity.

Which means that it will still be perfectly possible to run openvpn just 
like we have always done from the cmd-line or from the init-scripts, and I 
think this will continue to be the most-used method on unix platforms.

Windows users on the other hand tends to want automatic graphical 
installation packages and a nice gui to click on, and get afraid if they 
need to edit a textfile! So we need to keep the whole chain from 
installation to operating really simple.

Do you think we can achive this using deamon tools?

-- 
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
NILINGS AB                        X    NO HTML/RTF in e-mail
Tel: +46-(0)8-666 32 28          / \   NO Word docs in e-mail

