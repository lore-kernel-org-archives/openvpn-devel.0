Message-ID: <4162C7B9.8010305@...255...>
From: Didier Conchaudron <didier@...255...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Pass log and passphrase between OpenVPN and OpenVPN
 GUI
References: <Pine.LNX.4.60.0410012147580.18074@...210...> <Pine.LNX.4.58.0410020309540.22850@...269...>
In-Reply-To: <Pine.LNX.4.58.0410020309540.22850@...269...>
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
Date: Tue Oct  5 09:14:19 2004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi all,

I agree with James for including several things such as monitoring 
stdin/out/err into the wrapper.

But I'm not very ok for the idea of creating a socket for each 
connection because our users will probably only use one GUI so this GUI 
may have to discuss throught a unique socket to make things simpler. Now 
I agree that they're problems when we run several tunnels. I think of a 
system where each starting tunnel can ask, throught the same socket, a 
password or user/pass data just by adding a header like:

foo.ovpn: asking private key password
foo2.ovpn: asking extended auth. username

This way the GUI will have to handle just one socket, it could be then 
simpler to add features to GUI, ITOA it's harder for wrapper to add those.

An other point is security. Actually the service wrapper need to run as 
SYSTEM/Admin rights, we have to limit the features and commands which 
will run as SYSTEM.

Didier

James Yonan wrote:
> On Fri, 1 Oct 2004, Mathias Sundman wrote:
> 
> 
>>Didier announced a first release of an improved version of the OpenVPN 
>>Service Wrapper earlier this week. The goal with this is to allow a non 
>>admin user on Windows to start/stop openvpn processes.
>>
>>It does this by listening on a local TCP socket for commands like "START 
>>config.ovpn" or "STOP config.ovpn".
>>
>>I've started working on OpenVPN GUI 2.0 that will use this service 
>>wrapper to control openvpn.
>>
>>There is two things that remain unsolved though that I'd like to bring up 
>>for some discussion.
>>
>>1. How do we pass the private key passphrase from the GUI to the openvpn 
>>process?
>>
>>2. How do we get the openvpn log to the GUI so we can show it in real time 
>>in the status window?
>>
>>
>>I can see a couple of solutions:
>>
>>A) We create a pipe between the openvpn process and the service wrapper. 
>>The service can then watch the openvpn output for the passphrase prompt, 
>>and pass on the request to the GUI over the TCP socket.
>>
>>The log is then written to the log file by the service. The GUI will have 
>>to monitor this file for changes to be able to show the log in real-time.
>>
>>
>>B) We create another TCP socket for every launched process, and creates a 
>>pipe between this socket and the openvpn process. The GUI can then connect 
>>to this socket to recieve the log in real-time, and can monitor this for 
>>the passphrase prompt itself.
> 
> 
> I like the idea of having the service wrapper control the 
> stdin/stdout/stderr which is passed to the openvpn process, then have it 
> send password(s) over stdin.
> 
> So the communication between the service wrapper and the openvpn processes 
> would be via standard i/o handles and the communication between the 
> service wrapper and the GUI would be over the management socket.
> 
> That means the service wrapper would need to be a proxy of sorts, passing 
> passwords and possibly log file output as well between the GUI and openvpn 
> processes.
> 
> James
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
> Use IT products in your business? Tell us what you think of them. Give us
> Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
> http://productguide.itmanagersjournal.com/guidepromo.tmpl
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


