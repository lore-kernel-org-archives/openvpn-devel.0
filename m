From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] OpenVPN GUI connection configuration
In-Reply-To: <Pine.LNX.4.61.0411060041150.1651@...210...>
Message-ID: <Pine.LNX.4.58.0411061934450.23521@...41...>
References: <Pine.LNX.4.61.0411060041150.1651@...210...>
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
Date: Sat Nov  6 18:54:10 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Mathias Sundman <mathias@...209...>
Cc: openvpn-devel@lists.sourceforge.net

On Sat, 6 Nov 2004, Mathias Sundman wrote:

> I'd like to start adding connection specific options to OpenVPN GUI, that 
> need to specified somewhere.
> 
> The first option I plan to add is:
> 
> * Connection name (instead of the filename)
> 
> * script to run before starting openvpn, to allow for example a telnet 
> auth session to a PIX firewall before openvpn is started.
> 
> I just wonder where the best place to put these options is.
> 
> I've thought of two ways.
> 
> 1) Use a comment prefix in the already existing openvpn config file like:
> ### connection-name Office
> 
> where ### is used to denote that this is not really a comment but a 
> openvpn-gui option.
> 
> 2) Use a new config file with the same name as the openvpn config file, 
> but a diffrent extension like .ogui that can hold openvpn gui settings for 
> each connection.
> 
> 
> I'd like to get some feedback on what method the communtity would like me 
> to use. Additional ways that I havn't thought of is of cource welcome...

The problem with embedding GUI directives in the config file using some 
kind of prefix like "###" is that the directives become statically 
embedded in the config file in a way that makes centralized management 
more difficult.

I would propose an alternative solution:

Add a new pushable option to OpenVPN called "echo".  If OpenVPN encounters
this in a config file:

  echo "gui connection-name Office"

It will output to the log file:

  ECHO: gui connection-name Office

Now since the GUI is already inhaling OpenVPN log output, it can grep out 
the ECHO options and treat them as control directives if they start with 
"gui".

The advantage of using something like echo is that it could be pushed from 
the server, allowing centralized management of the GUI options.

James

