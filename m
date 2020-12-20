References: <20201220105430.GP976@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <093511bd-43c0-a37c-1d8f-335d9df451d6@...1227...>
Date: Sun, 20 Dec 2020 16:00:13 +0100
MIME-Version: 1.0
In-Reply-To: <20201220105430.GP976@...1296...>
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
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net


Am 20.12.2020 um 11:54 schrieb Gert Doering:
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
>  From the server / openvpn core side, it could be something totally trivi=
al:
>
>    push "info-msg hey there!"
>
> ... and the client would then either print this on the console
> (if !management) or dump it to management, where the GUI/Tunnelblick
> could pick it up and create a popup window.
>
See --echo.=A0 That is basically what you desribe as info-msg in your mail


Arne



