From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Re: Interface with GUI agent
References: <40E18559.8020407@...244...> <Pine.LNX.4.60.0407061112170.372@...210...> <Pine.LNX.4.60.0407062329320.2886@...210...>
In-Reply-To: <Pine.LNX.4.60.0407062329320.2886@...210...>
MIME-Version: 1.0
Message-Id: <200407072255.54148.jim@...41...>
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
Date: Wed Jul  7 20:56:02 2004
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net
Cc: Mathias Sundman <mathias@...209...>, Jan Kiszka <jan.kiszka@...83...>

On Tuesday 06 July 2004 16:58, Mathias Sundman wrote:
> Some more things to consider...
>
> 1. On Windows, if the the service wrapper has started some openvpn
> processes before our gui agent is started, how should find out about
> those processes?
>
> I can think of the following ways:
>
> 1a. Ask the service wrapper via the socket interface that I'm working on
> right now. This will require the service wrapper not only start the
> processes, but keep a table over running processes.

I think it's an important point worth some discussion on whether to (a) put 
all the "intelligence" in the GUI applet and have the service wrapper just be 
a basic proxy to an admin-privileged CreateProcess, or (b) write a portable 
service wrapper that's designed to run on all the OSes which OpenVPN 
currently supports, and which would do all the "under-the-hood" work in 
starting/stopping/managing of different OpenVPN processes, and the GUI applet 
would do nothing more than export the control interface of the portable 
service wrapper to a platform-specific, lightweight GUI.

(a) is probably simpler to develop, but (b) may be a better solution long-term 
because it handles the management interface in a portable way, and makes the 
GUI itself (which probably needs a separate admin module for Win32, YaST, X, 
http, etc.) as lightweight and stateless as possible.

Now the way I would implement (b) is to design as much of the "portable 
service wrapper" code as is possible without actually coding any function 
calls to create windows or dispatch window messages or do any GUI stuff 
directly.  The service wrapper would take care of instantiating OpenVPN 
processes, managing the 127.0.0.1 port pool to communicate with the 
processes.

Now the GUI applet itself becomes very simple and stateless, it only needs to 
connect to the service wrapper, and any window message corresponding to a 
user mouse action gets encoded into a simple command that gets sent to the 
service wrapper.

I agree that this is a more complicated problem to solve because now we have 
the service wrapper which is talking to the individual OpenVPN processes, and 
we have the GUI applet talking to the service manager.

But long term (IMHO) this gives us great flexibility to easily port the GUI 
applet to other interfaces, such as even http.  It would be very cool, for 
example, if with a little bit of php programming, you could control your 
OpenVPN instances via a web interface for example.  You wouldn't need to 
rewrite a huge program which deals with all the details of 
starting/stopping/managing the pool of OpenVPN processes, because that 
program would already exist as the cross-platform service wrapper daemon.

> 1b. Scan a defined directory for config files, and require the config
> files to have a management option. Then we can try connecting to the
> specified tcp port to find if there is a running ovpn process.

No, I don't think people should explicitly put the management option in their 
config files.

> 1c. Query the system for processes with the name "openvpn", and which
> sockets this process has opened. Then we could try connecting to those
> ports to find the management socket.

I don't like the idea of querying the system for "openvpn" processes (for one 
there's no portable API for querying the system for processes).  I would 
rather see the manager deal with managing a pool of local ports.

> I dislike 1b because it would complicate for the user, that he has to have
> the management option in his config-file. If using 1a that is handled
> automaticly by the gui or service wrapper.

I agree, the management option is something that should be programmatically 
placed on the command line by the program which does the CreateProcess to 
start the OpenVPN instantiation on a given config file.

> The drawback with 1a is, how do we handle the same thing on unix? There
> could be situations where we would like start the vpn before a gui agent
> here to. Are we back to what Jan K said, we need a "service wrapper" for
> unix to, that can run at al ltime as a deamon and keep track of our
> openvpn processes? It would require some extra work writing this deamon
> to, but it would give us a consistent way of starting openvpn processes
> from a gui agent regardless of the platform.

I'm not sure that we need to add the complexity of a service wrapper on unix, 
because most unix users take it as a matter of course that touching the 
network configuration requires root privileges.

I think it's fair to say that root is required, and if someone _really_ wants 
to control tunnels from non-root, then they must SUID the binary, or change 
the permissions on the tun/tap device node.

>
>
>
> 2. How should the service wrapper know which configs to launch at
> start-up? To maintain backwords-compatibility it should launch all config
> files in the config folder. However the gui agent should be able to
> handle both processes started at boot-time and other that is started
> manually from the gui later.
>
> I've thought of two ways of doing this.
>
> 2a. Use a config file which list which configs that should be launched at
> boot-time. If that config file does not exist, it will launch all it
> finds, as it is today. A gui agent can then create this file to specify
> which configs should be launched at boot-time.
>
> 2b. Use another folder for configs that should not be started at
> boot-time.

I like 2a because it solves the problem while still being backward compatible, 
and only requires the GUI applet write a simple config file, and that the 
service wrapper test the existence of the file, and if it exists, use the 
file as an instantiation list rather than scanning the config file directory.

> Please let me know how you think we should handle these issues before I
> put anymore work into the service wrapper in a wrong direction...

I think the larger architectural issue here is:

(a) GUI Applet (Statefull) <-> openvpn.exe[1], openvpn.exe[2], ...

OR

(b) GUI Applet (Stateless) <-> Portable Service Wrapper Daemon (Statefull) <-> 
openvpn[1], openvpn[2], openvpn[3], ...

James

