Message-ID: <4F836709.8030501@...1227...>
Date: Tue, 10 Apr 2012 00:47:37 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <CA+3tv22Xq447J_EXKM4SYP-45V7LN0NJfH6o9skUNPPij3PDuQ@...278...>	<1CED409804E2164C8104F9E623B08B90129328AD5E@...1436...>	<20120208080953.GS13929@...1296...>	<CA+3tv2064zxi_v1hJPWaF+bd5FUrXYm+h+qYDnorHz8OrpxyGQ@...278...>	<4F5000C2.5020902@...1400...>	<4F7DF054.8070002@...1400...>
	<CA+3tv20M85ai_XKtAZQ5HodPA+ybh9srbBuhaoBZGaohy4-8xA@...278...>
In-Reply-To: <CA+3tv20M85ai_XKtAZQ5HodPA+ybh9srbBuhaoBZGaohy4-8xA@...278...>
Subject: Re: [Openvpn-devel] OpenVPN and Android 4.0 VPN API
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
To: James Ring <sjr@...1546...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 06.04.12 20:12, schrieb James Ring:
> Hey Arne,
>
> On Thu, Apr 5, 2012 at 12:19 PM, Arne Schwabe<schwabe@...1400...>  wrote:
>> I have managed to hack a proof of concept together. (Screen shot here:
>> http://plai.de/android/Bildschirmfoto%202012-04-05%20um%2021.00.57.png)
>>
>> The core VPN functionality already works. What needs to be done is proper
>> error handling and configuration, espically integeration of Androids
>> certificate Managment).
> This looks excellent! When can I try it out/hack on it? :)
>
For all the impatient:

http://plai.de/android/icsopenvpn.apk

But remember this has pre alpha status. Connecting should work, but 
closing the connection or trying to connect a second time will probably 
not work. And don't look too close at the patch in the same directory 
there are still some hacks in the code I need to remove.

Arne


