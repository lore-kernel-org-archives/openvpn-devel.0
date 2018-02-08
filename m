MIME-Version: 1.0
In-Reply-To: <17c77ed3-840e-7624-9e23-6ae8de04bf3e@...515...>
References: <CAFHpkQEFPO+TsXdqva=OGg_9FnErDH7Uw9fs876Co_q2A4=rmA@...278...>
 <CAKuzo_hdyx3MH5Cw=gEujHhEvQ1wnOaZ2r0n7=j3GSsv_C1Z2Q@...278...>
 <CAFHpkQFtN6jk5bNcksmoBDjjMd3UbW4sN+y5rH0zUb2sgDq=gg@...278...>
 <6febf54c-f7ab-2297-2c75-72235e14e1c5@...2080...>
 <17c77ed3-840e-7624-9e23-6ae8de04bf3e@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 8 Feb 2018 10:40:03 -0500
Message-ID: <CAKuzo_jrPv+=NjoEXtX+5AUjYtgRmVw2Jtens_hvbKOmidAjpQ@...278...>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, David Sommerseth <openvpn@...2080...>, =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn users list (openvpn-users@lists.sourceforge.net)" <openvpn-users@lists.sourceforge.net>

Hi,

On Thu, Feb 8, 2018 at 3:15 AM, Samuli Sepp=C3=A4nen <samuli@...515...> wro=
te:
> Il 07/02/2018 21:58, David Sommerseth ha scritto:
>> On 07/02/18 20:32, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
>>> After auth-token were introduced, when user press "Reconnect", it leads=
 to
>>> auth fail (saved password is forgotten), we run about 1000 users, nobody
>>> complains.
>>
>> This is actually expected, I'd say - but smells like a bug on the server=
 side
>> authentication.
>>
>> Selva may correct me if I'm wrong, but my understanding of it when click=
ing
>> "Reconnect", the local OpenVPN process which caches the auth-token is st=
opped
>> and a new OpenVPN process is started.  The client should in this case as=
k for
>> username/password again.  So in this case, the server side should treat =
this
>> connection as a fresh connection with no initial state.
>>
>> The step of stopping the local client and starting a new and fresh one is
>> definitely not a bad feature to have on clients.
>>
>>> It looks like nobody uses that button.
>>>
>>> So, I asked several users, they confirmed they do not use Reconnect.
>>
>> This is no good argument for me.  This is one specific setup with 1000 u=
sers.
>> It would be more valuable with 50 different setups having 20 users each.=
  Your
>> conclusion is based on a very homogeneous environment.
>
> I agree. I also agree that the underlying problem should be fixed.
>
> That said, Ilya's message was sent to both openvpn-users and
> openvpn-devel and nobody has screamed "do not remove the Reconnect
> button" :). The only additional thing we can do is post a message to the
> forums. As usual, the only sure way to get feedback (read: complaints)
> is to release the changes in an official build/installer.

Only recently we added a reconnect item to the menu (earlier it was
only available as a button in the status window) for ease of doing
reconnects and based on user requests -- though I can't now find who
asked for it.

I wouldn't take lack of response on the user's list as an indication
that no one uses it. In fact its very handy -- how else will you
restart a connection after editing the config file? Disconnect and
connect again? That would close the status window and lose all
messages in it and also takes a number of mouse clicks because of the
way tray popup menu behaves.

Anyway the purported reason to remove it is totally bogus. Its like
auth-token cant cope with SIGHUP, so let's remove that signal.

Finally, I'm an user too and I use that button all the time, though
mostly for testing. If that counts as a dissenting voice.

Selva

