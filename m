From: Tony <kb2wjw@...277...>
Message-ID: <op.s9rf5qftioehzu@...596...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Configuration flexibility enhancement suggestion.
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
Date: Thu May 18 11:59:24 2006
Content-Type: text/plain; format=flowed; delsp=yes; charset=koi8-r
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hello, James!

First and foremost - THANK YOU! for the great product OpenVPN is.

Some background. Often I have to connect from the LANs where the only  
outbound traffic allowed is HTTPS through their proxy. But if I'm on a  
more user-friendly environment, I use plain UDP. On my server I have the  
separate instances of OpenVPN running and waiting for it's own type of  
connection each.

So, on my laptop (winXP-SP2) as a roadwarrior, often I need to tune the  
service mode on the run. This happens when I must switch to TCP from the  
default UDP mode. In TCP mode I must remove "fragment XXXX" for example.  
Also, when in TCP, I must uncomment the proxy-related section.

This is rather inconvinient and insecure - I run OpenVPN as non-admin with  
"client.ovpn" being protected from mortals by file permissions.

The way to radically improve the configuration flexibility and convinience  
might be as follows:

rather than naming the "remote" side list where each entry is just an  
IP:port and is tryed in turn with all the rest of configuration file  
common - introduce the list of "contexts" - the logical name of the whole  
settings needed to connect to the particular remote service. If the first  
entry fails - try the next.

The possible layout of the configuration file might look like this:

[contexts]
context_name_1
context_name_2
....
context_name_N

[context_name_1]
...here go all the relevant settings to use with this particular  
connection...

[context_name_2]
...again the whole set of what must be used for that one...

[context_name_N]
...and so on...


The "context_name_N" is just a label. With this scheme it would be  
possible to have even the conflicting settings (relevant for different  
connections) in one file without a need to edit it in the field.

Further improvement could be a "context_policy" parameter that would  
switch between the round-robin and "try again from the top of the list"  
behaviour (or even have a "try context_name_K next" command). I place my  
connections in the order of preference.

Please comment on the idea.

Tony.


