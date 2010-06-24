Message-ID: <4C230CF9.10202@...1147...>
Date: Thu, 24 Jun 2010 09:44:57 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <AANLkTikEA95y8ojAyWAJoJmYbt_MZBT23dbi-IyAUa0Y@...278...>
	<4C20D014.7050802@...1147...>
	<AANLkTim766amj5ebXyzKWKKqjk2ndJiqyu-Drw26Mt1e@...278...>
	<4C21B352.1030203@...1147...> <20100623194825.GA361@...1296...>
In-Reply-To: <20100623194825.GA361@...1296...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Is it possible to access
 Windows XP shares over port 445?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net, OpenVPN Users <openvpn-users@lists.sourceforge.net>

Gert Doering wrote:
> Hi,
>
> On Wed, Jun 23, 2010 at 09:10:10AM +0200, Jan Just Keijser wrote:
>   
>> assigns a 169.254 address. If this works for you as well then maybe the 
>> tap-win32 developers can dive deeper into this and find out why windows 
>> treats the 'always connected' adapter differently from an 'application 
>> controlled' adapter .
>>     
>
> I'd assume that windows services are not "bound" to "dynamic" interfaces...
>
>   
They're not , as far as I know. 
However,
- the SMBoverIP service binds to 0.0.0.0:445 yet it refuses access from 
IPs other than the 'always connected' ones
- as Henno found out,  disabling and then enabling the "windows file 
sharing" protocol on the TAP-win32 adapter after the connection has been 
established fixes the problem ; I don't know if it is possible to do 
this using some 'netsh' magic, however
- the same thing works on windows 2000, no modifications
- on windows XP and higher it *does* work for PPTP/L2TP+IPsec VPNs


JJK

