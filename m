References: <CAFHpkQEFPO+TsXdqva=OGg_9FnErDH7Uw9fs876Co_q2A4=rmA@...278...>
 <CAKuzo_hdyx3MH5Cw=gEujHhEvQ1wnOaZ2r0n7=j3GSsv_C1Z2Q@...278...>
 <CAFHpkQFtN6jk5bNcksmoBDjjMd3UbW4sN+y5rH0zUb2sgDq=gg@...278...>
 <6febf54c-f7ab-2297-2c75-72235e14e1c5@...2080...>
 <17c77ed3-840e-7624-9e23-6ae8de04bf3e@...515...>
 <CAFHpkQH4O2MueU__O8KiDp5WobAf-nPRW3dU0cCm4Tm9xh11ng@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <5551275c-281b-13b8-85b5-c00d85558a43@...515...>
Date: Thu, 8 Feb 2018 11:04:29 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQH4O2MueU__O8KiDp5WobAf-nPRW3dU0cCm4Tm9xh11ng@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [Openvpn-users] "Reconnect" button in
 openvpn-gui
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, David Sommerseth <openvpn@...2080...>, Selva Nair <selva.nair@...277...>, "openvpn users list (openvpn-users@lists.sourceforge.net)" <openvpn-users@lists.sourceforge.net>

Il 08/02/2018 10:26, Илья Шипицин ha scritto:
> 
> 
> 2018-02-08 13:15 GMT+05:00 Samuli Seppänen <samuli@...515...
> <mailto:samuli@...515...>>:
> 
>     Il 07/02/2018 21:58, David Sommerseth ha scritto:
>     > On 07/02/18 20:32, Илья Шипицин wrote:
>     >> After auth-token were introduced, when user press "Reconnect", it leads to
>     >> auth fail (saved password is forgotten), we run about 1000 users, nobody
>     >> complains.
>     >
>     > This is actually expected, I'd say - but smells like a bug on the server side
>     > authentication.
>     >
>     > Selva may correct me if I'm wrong, but my understanding of it when clicking
>     > "Reconnect", the local OpenVPN process which caches the auth-token is stopped
>     > and a new OpenVPN process is started.  The client should in this case ask for
>     > username/password again.  So in this case, the server side should treat this
>     > connection as a fresh connection with no initial state.
>     >
>     > The step of stopping the local client and starting a new and fresh one is
>     > definitely not a bad feature to have on clients.
>     >
>     >> It looks like nobody uses that button.
>     >>
>     >> So, I asked several users, they confirmed they do not use Reconnect.
>     >
>     > This is no good argument for me.  This is one specific setup with 1000 users.
>     > It would be more valuable with 50 different setups having 20 users each.  Your
>     > conclusion is based on a very homogeneous environment.
> 
>     I agree. I also agree that the underlying problem should be fixed.
> 
>     That said, Ilya's message was sent to both openvpn-users and
>     openvpn-devel and nobody has screamed "do not remove the Reconnect
>     button" :). The only additional thing we can do is post a message to the
>     forums. As usual, the only sure way to get feedback (read: complaints)
>     is to release the changes in an official build/installer.
> 
> 
> I suggest to do that after 2.4.5 installer.
> I'll write post on the forum. I think, even a good idea to place
> snapshot installer with new feature (i.e. button removed) to forum as well.
> 
> after feedback is received we can take it into account and act.
> 
> I also noticed nobody screaming "stop!!! do not remove that button!!!"
> 
> Samuli ?
>  

Posting a message to forums does not bind us to anything, so feel free
to do it. If even one person screams then I suspect at least hundreds of
people are actually using the button.

If we remove the button it should be because next to nobody is using it
and we want to clean up the GUI and its codebase. We should not remove
it because it does not work due to lower-level issues, which should be
fixed instead.

The problem with snapshot installers is that unless we actually merge
the button-removing code into OpenVPN GUI master, people will not use
it. And by announcing the snapshot installer on the mailing lists and
forums won't reach an audience any larger than your original email has.
So just asking about this on forums is probably enough.

-- 
Samuli Seppänen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

