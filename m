References: <20201220105430.GP976@...1296...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <5172d81a-ed11-60d1-c546-52de35946ef7@...277...>
Date: Mon, 21 Dec 2020 01:49:15 +0000
MIME-Version: 1.0
In-Reply-To: <20201220105430.GP976@...1296...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] wanted: mechanism to send text messages to
 client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Gert,

using server side scripting, I can push *literally* anything I want to 
the server via --push-peer-info and setenv UV_*

Example:
setenv UV_PING 10
setenv UV_PINGRESTART 60

My server side script allows the client to effectively configure 
--keepalive (and a LOT more)

My guess would be to push some expected and custom variables to the 
client at logon.

And the user can fend for themselves.

No --up .. no --issue

I guess something like --pull-peer-info would be suitable. That way, 
what ever is received can be vetted.



If computers Did have sense of humour then you lot would probably have 
gone insane by now.



On 20/12/2020 10:54, Gert Doering wrote:
> Hi,
> 
> I find myself looking for a mechanism by which I could send informational
> messages ("your cert expires in two weeks, go refresh!" - "your openvpn
> client needs an upgrade") from the openvpn server to incoming clients.
> 
> Of course this should work with all connecting clients, that is, "text
> clients", windows GUI, Tunnelblick, iOS Connect, Android.
> 
> As far as I am aware, there is no such mechanism today.
> 
> Do we want to make one?
> 
> 
>  From the server / openvpn core side, it could be something totally trivial:
> 
>    push "info-msg hey there!"
> 
> ... and the client would then either print this on the console
> (if !management) or dump it to management, where the GUI/Tunnelblick
> could pick it up and create a popup window.
> 
> What do you think?
> 
> gert
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

