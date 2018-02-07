MIME-Version: 1.0
In-Reply-To: <CAFHpkQF7qhc+4coTN5Tf=Ez5nioUyQG1N8GW6mzQPy4gWoY_XQ@...278...>
References: <CAFHpkQEFPO+TsXdqva=OGg_9FnErDH7Uw9fs876Co_q2A4=rmA@...278...>
 <CAKuzo_hdyx3MH5Cw=gEujHhEvQ1wnOaZ2r0n7=j3GSsv_C1Z2Q@...278...>
 <CAFHpkQFtN6jk5bNcksmoBDjjMd3UbW4sN+y5rH0zUb2sgDq=gg@...278...>
 <6febf54c-f7ab-2297-2c75-72235e14e1c5@...2080...>
 <CAKuzo_gQaniVbD2QuEBb1x+xe8wULUjJkhXMWocyxi=oDknz0w@...278...>
 <CAFHpkQF7qhc+4coTN5Tf=Ez5nioUyQG1N8GW6mzQPy4gWoY_XQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 7 Feb 2018 15:43:20 -0500
Message-ID: <CAKuzo_hYfnm3G_zNJ4iX_ONAJkR_=0L4GWhSMqi9NV17+u7n1Q@...278...>
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
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, "openvpn users list (openvpn-users@lists.sourceforge.net)" <openvpn-users@lists.sourceforge.net>

Hi,

On Wed, Feb 7, 2018 at 3:30 PM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:
>
>
> 2018-02-08 1:21 GMT+05:00 Selva Nair <selva.nair@...277...>:
>>
>> Hi,
>>
>> On Wed, Feb 7, 2018 at 2:58 PM, David Sommerseth
>> <openvpn@...2080...> wrote:
>> > On 07/02/18 20:32, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=
=D1=86=D0=B8=D0=BD wrote:
>> >> After auth-token were introduced, when user press "Reconnect", it lea=
ds
>> >> to
>> >> auth fail (saved password is forgotten), we run about 1000 users,
>> >> nobody
>> >> complains.
>> >
>> > This is actually expected, I'd say - but smells like a bug on the serv=
er
>> > side
>> > authentication.
>> >
>> > Selva may correct me if I'm wrong, but my understanding of it when
>> > clicking
>> > "Reconnect", the local OpenVPN process which caches the auth-token is
>> > stopped
>> > and a new OpenVPN process is started.  The client should in this case
>> > ask for
>> > username/password again.  So in this case, the server side should treat
>> > this
>> > connection as a fresh connection with no initial state.
>>
>> GUI's reconnect button is wired to send a SIGHUP to the client openvpn
>> process. The problem is that if auth-token is in use, the client
>> openvpn.exe does not forget it it when restarting the connection by
>> SIGHUP or SIGUSR1 -- I think it should but it doesn't. That leads to
>> an AUTH_FAILED from server. The GUI has hard time distinguishing
>> between reasons for AUTH_FAILED, so it just assumes that password
>> verification failed and clears the saved password and prompts for a
>> new one. Obviously users are not happy.
>
>
> users don't care :)
>
> if they we ever unhappy, we should fix it.
>
> currently, I'm open to ideas how to perform a (proper) investigation in
> order to actually remove "Reconnect" button

I do not understand why you keep harping about removing the reconnect butto=
n.

If you are angry with auth-token do not take it out on the wrong
victim. Its not reconnect button's fault. In fact if your users do not
use it, why bother?

Selva

