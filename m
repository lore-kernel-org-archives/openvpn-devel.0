From: Mathias Sundman <mathias@...209...>
Subject: Re: [Openvpn-devel] Show client IP address in status file
In-Reply-To: <Pine.LNX.4.58.0410141055550.5469@...269...>
Message-ID: <Pine.LNX.4.61.0410142055010.17905@...210...>
References: <Pine.LNX.4.61.0410141450560.17318@...210...>
 <Pine.LNX.4.58.0410141055550.5469@...269...>
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
Date: Thu Oct 14 12:08:08 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, 14 Oct 2004, James Yonan wrote:

> On Thu, 14 Oct 2004, Mathias Sundman wrote:
>
>> I have a little feature request.
>>
>> I use TAP and bridging in many roadwarrior configurations.
>>
>> I would really like to see what IP address that has been assigned to 
>> which client in the --status file.
>
> There will be a way to do this in beta12.  I've added an 
> --ifconfig-pool-persist option which will periodically output a comma 
> separated list of <common name>,<IP address> to a file.  This is 
> ostensibly used to persist the ifconfig pool data across daemon 
> instantiations but could be used for other purposes as well.

That's great! So now that we keep track of the assigned IP address 
regardless if we use TUN or TAP, couldn't we quite easily add this to the 
CLIENT list output in the status file? It would simplify things to have 
all information in one place.

The reason I want this is because I'm working on a "OpenVPN Administrator" 
GUI, and would like to list the connected users together with various 
information, including the assigned IP address.


>> How does openvpn work when a client is not a single machine, but a whole
>> bridged network? Does openvpn hand out multiple IP addresses from
>> --ifconfig-pool then?
>
> No, --ifconfig-pool is only used to allocate IPs for the actual client
> machine which is connecting to the server.  If there is a subnet behind
> the client, that subnet can be numbered however you wish.

Good, then it's a 1-to-1 relationship between a connecting client and an 
assigned IP address.

-- 
_________________________________________________________
Mathias Sundman              (^)   ASCII Ribbon Campaign
NILINGS AB                    X    NO HTML/RTF in e-mail
Tel: +46-(0)8-666 32 28      / \   NO Word docs in e-mail

