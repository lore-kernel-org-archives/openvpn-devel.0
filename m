Message-ID: <4BA2191E.1080601@...1147...>
Date: Thu, 18 Mar 2010 13:14:22 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <20100317225325.GE25238@...1296...>
In-Reply-To: <20100317225325.GE25238@...1296...>
Subject: Re: [Openvpn-devel] Windows, OpenVPN-GUI, disconnect
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
Cc: openvpn-devel@lists.sourceforge.net

Hi Gert,

Gert Doering wrote:
> Hi,
>
> can one of you tell me what happens "under the hood" if I click the
> "disconnect" button of the openvpn-gui under Windows XP?
>
> Why am I asking?  I managed to get my windows build environment working
> well enough that I can now build a complete installer package with the
> IPv6 patches, and with the adapted tun/tap driver - but it breaks in
> funny ways.
>
>  - Installation works fine
>  - running the openvpn-gui (precompiled) works fine
>  - (client) connection to a TUN server works fine
>    [initiated by pressing the "connect..." button of the GUI in the 
>     windowsstatus bar]
>  - IPv4 and IPv6 connectivity works
>
>  - pressing the "disconnection" button of the GUI doesn't seem to do 
>    anything.  Well, the status window says "disconnecting..." and the
>    button is greyed out - but no update in the log file or the status 
>    window, no nothing.
>
> I assume that "something is miscompiled" or "a newer version of mingw
> has some surprising side effects" - but to know where to start looking,
> it would be helpful to understand what signalling is used 
>
>   openvpn-gui --> openvpn.exe
>
> to signal disconnect.
>
> (Since I didn't touch any of the signal handling stuff, I'm fairly sure
> that it wasn't one of my changes, but I still want to have a working
> Windows bundle to get people to test it)
>   
took me a while to figure this one out:
the openvpn gui codes sets an 'exit event' (using a win32 API call 
CreateEvent) before starting the actual openvpn process; when the user 
chooses 'disconnect' this 'exit event' is triggered, which causes the 
process to be terminated (using the appropriate win32 signal).

The question now becomes: what does openvpn do when it receives a 
terminate signal? actually, is there a signal being sent to the server 
to say "client X is disconnecting" ?

cheers,

JJK


