From: Mathias Sundman <mathias@...209...>
Subject: Re: [Openvpn-devel] Windows Command Prompt vs. Systray Icon
In-Reply-To: <1087085913.40cb9d593793a@...238...>
Message-ID: <Pine.LNX.4.60.0406132016470.4959@...210...>
References: <1087017394.40ca91b21df0c@...238...>
 <200406130001.48507.vda@...216...>
 <1087085913.40cb9d593793a@...238...>
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
Date: Sun Jun 13 11:43:02 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Quoting Denis Vlasenko <vda@...216...>:

>> I had a few of my users ask why the Windows OpenVPN connection was in a
>> Command Prompt window and not just a Systray Icon with a status window.
>
> It can be run as a service. It is documented.

I think implementing a systray icon to controll OpenVPN would be a great 
feature.

Running OpenVPN as a service does not make it much easier or more 
userfriendly than the normal way, except that you don't have to see the 
console window.

As a technician I love the way OpenVPN is designed and operate today, but 
my users also ask for a gui to controll OpenVPN as the console window just 
scares them!

I think it would be cleanest if such a gui could be created as a 
standalone application that just calls the openvpn binary. What I'm not 
clear about with such a setup is how the gui should be able to communicate 
with openvpn to check it's status, and recieve error messages?

-- 
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
NILINGS AB                        X    NO HTML/RTF in e-mail
Tel: +46-(0)8-666 32 28          / \   NO Word docs in e-mail

