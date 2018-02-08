References: <CAFHpkQEFPO+TsXdqva=OGg_9FnErDH7Uw9fs876Co_q2A4=rmA@...278...>
 <CAKuzo_hdyx3MH5Cw=gEujHhEvQ1wnOaZ2r0n7=j3GSsv_C1Z2Q@...278...>
 <CAFHpkQFtN6jk5bNcksmoBDjjMd3UbW4sN+y5rH0zUb2sgDq=gg@...278...>
 <6febf54c-f7ab-2297-2c75-72235e14e1c5@...2080...>
 <17c77ed3-840e-7624-9e23-6ae8de04bf3e@...515...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <e7c270fe-17b1-da00-3a28-603492b945c5@...1147...>
Date: Thu, 8 Feb 2018 09:40:11 +0100
MIME-Version: 1.0
In-Reply-To: <17c77ed3-840e-7624-9e23-6ae8de04bf3e@...515...>
Content-Language: nl-NL
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
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, openvpn-devel@lists.sourceforge.net, David Sommerseth <openvpn@...2080...>, =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, Selva Nair <selva.nair@...277...>
Cc: "openvpn users list (openvpn-users@lists.sourceforge.net)" <openvpn-users@lists.sourceforge.net>

Hi,

On 08/02/18 09:15, Samuli Seppänen wrote:
> Il 07/02/2018 21:58, David Sommerseth ha scritto:
>> On 07/02/18 20:32, Илья Шипицин wrote:
>>> After auth-token were introduced, when user press "Reconnect", it leads to
>>> auth fail (saved password is forgotten), we run about 1000 users, nobody
>>> complains.
>> This is actually expected, I'd say - but smells like a bug on the server side
>> authentication.
>>
>> Selva may correct me if I'm wrong, but my understanding of it when clicking
>> "Reconnect", the local OpenVPN process which caches the auth-token is stopped
>> and a new OpenVPN process is started.  The client should in this case ask for
>> username/password again.  So in this case, the server side should treat this
>> connection as a fresh connection with no initial state.
>>
>> The step of stopping the local client and starting a new and fresh one is
>> definitely not a bad feature to have on clients.
>>
>>> It looks like nobody uses that button.
>>>
>>> So, I asked several users, they confirmed they do not use Reconnect.
>> This is no good argument for me.  This is one specific setup with 1000 users.
>> It would be more valuable with 50 different setups having 20 users each.  Your
>> conclusion is based on a very homogeneous environment.
> I agree. I also agree that the underlying problem should be fixed.
>
> That said, Ilya's message was sent to both openvpn-users and
> openvpn-devel and nobody has screamed "do not remove the Reconnect
> button" :). The only additional thing we can do is post a message to the
> forums. As usual, the only sure way to get feedback (read: complaints)
> is to release the changes in an official build/installer.
>
I won't be screaming "Don't remove that button" as I don't use OpenVPN 
on Windows that often, but I __DO__ find that button to be quite handy 
in the Windows GUI. I remember writing an OpenVPN book where I had to 
test and debug an OpenVPN setup on Windows and I found myself hitting 
that 'reconnect' button over and over. Of course, this was (probably?) 
all before auth tokens and I certainly did not use things like one-time 
passwords, but removing that button would have made the GUI much more 
annoying to me.

JM2CW,

JJK


