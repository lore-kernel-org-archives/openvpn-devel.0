From: Mathias Sundman <mathias@...209...>
In-Reply-To: <Pine.LNX.4.60.0407061112170.372@...210...>
Message-ID: <Pine.LNX.4.60.0407062329320.2886@...210...>
References: <40E18559.8020407@...244...> <40E744F9.5000700@...83...>
 <Pine.LNX.4.60.0407052042310.29911@...210...> <200407051513.29794.jim@...41...>
 <40EA61C7.9070406@...83...> <Pine.LNX.4.60.0407061042300.372@...210...>
 <40EA6CFD.2030603@...83...> <Pine.LNX.4.60.0407061112170.372@...210...>
MIME-Version: 1.0
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
Date: Tue Jul  6 15:01:04 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: Jan Kiszka <jan.kiszka@...83...>
Cc: openvpn-devel@lists.sourceforge.net

Some more things to consider...

1. On Windows, if the the service wrapper has started some openvpn 
processes before our gui agent is started, how should find out about 
those processes?

I can think of the following ways:

1a. Ask the service wrapper via the socket interface that I'm working on 
right now. This will require the service wrapper not only start the 
processes, but keep a table over running processes.

1b. Scan a defined directory for config files, and require the config 
files to have a management option. Then we can try connecting to the 
specified tcp port to find if there is a running ovpn process.

1c. Query the system for processes with the name "openvpn", and which 
sockets this process has opened. Then we could try connecting to those 
ports to find the management socket.


I dislike 1b because it would complicate for the user, that he has to have 
the management option in his config-file. If using 1a that is handled 
automaticly by the gui or service wrapper.

The drawback with 1a is, how do we handle the same thing on unix? There 
could be situations where we would like start the vpn before a gui agent 
here to. Are we back to what Jan K said, we need a "service wrapper" for 
unix to, that can run at al ltime as a deamon and keep track of our 
openvpn processes? It would require some extra work writing this deamon 
to, but it would give us a consistent way of starting openvpn processes 
from a gui agent regardless of the platform.



2. How should the service wrapper know which configs to launch at 
start-up? To maintain backwords-compatibility it should launch all config 
files in the config folder. However the gui agent should be able to 
handle both processes started at boot-time and other that is started 
manually from the gui later.

I've thought of two ways of doing this.

2a. Use a config file which list which configs that should be launched at 
boot-time. If that config file does not exist, it will launch all it 
finds, as it is today. A gui agent can then create this file to specify 
which configs should be launched at boot-time.

2b. Use another folder for configs that should not be started at 
boot-time.


Please let me know how you think we should handle these issues before I 
put anymore work into the service wrapper in a wrong direction...


-- 
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
NILINGS AB                        X    NO HTML/RTF in e-mail
Tel: +46-(0)8-666 32 28          / \   NO Word docs in e-mail

