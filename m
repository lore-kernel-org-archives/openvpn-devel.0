Message-ID: <54462713.9030300@...1147...>
Date: Tue, 21 Oct 2014 11:27:47 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <54450921.30501@...515...> <54461F20.5060908@...1147...>
	<20141021091159.GY396@...1296...>
In-Reply-To: <20141021091159.GY396@...1296...>
Subject: Re: [Openvpn-devel] New OpenVPN Windows installers (I004 and I604)
 released
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
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

Hi,

Gert Doering wrote:
> Hi,
>
> On Tue, Oct 21, 2014 at 10:53:52AM +0200, Jan Just Keijser wrote:
>   
>> Running the gui with elevated privileges fixes this issue. Shouldn't the 
>> installer have created this registry key?
>>     
>
> The GUI need to run with elevated privileges anyway, because otherwise 
> OpenVPN cannot install routes...
>
> This will hopefully be fixed in 2.4 with the interactive service, we just
> need to find time for Heiko to find the code and send it to us :-) (but
> I've already seen it last year)
>
>   
so I guess the installer needs to set up the OpenVPN GUI entries with 
the "Run as Administrator" bit set - the GUI does not fully function 
without it anyways
- cannot create reg keys
- cannot create log file when starting a connection
- cannot add routes to the system

All of which makes perfect sense when elevated privileges are not set - 
it's just that it would be handier if the installer created the 
OpenVPN-GUI.exe entries with the admin bit set, if at all possible.

JJK


