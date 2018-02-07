MIME-Version: 1.0
In-Reply-To: <6febf54c-f7ab-2297-2c75-72235e14e1c5@...2080...>
References: <CAFHpkQEFPO+TsXdqva=OGg_9FnErDH7Uw9fs876Co_q2A4=rmA@...278...>
 <CAKuzo_hdyx3MH5Cw=gEujHhEvQ1wnOaZ2r0n7=j3GSsv_C1Z2Q@...278...>
 <CAFHpkQFtN6jk5bNcksmoBDjjMd3UbW4sN+y5rH0zUb2sgDq=gg@...278...>
 <6febf54c-f7ab-2297-2c75-72235e14e1c5@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 7 Feb 2018 15:21:39 -0500
Message-ID: <CAKuzo_gQaniVbD2QuEBb1x+xe8wULUjJkhXMWocyxi=oDknz0w@...278...>
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Cc: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn users list (openvpn-users@lists.sourceforge.net)" <openvpn-users@lists.sourceforge.net>

Hi,

On Wed, Feb 7, 2018 at 2:58 PM, David Sommerseth
<openvpn@...2080...> wrote:
> On 07/02/18 20:32, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
>> After auth-token were introduced, when user press "Reconnect", it leads =
to
>> auth fail (saved password is forgotten), we run about 1000 users, nobody
>> complains.
>
> This is actually expected, I'd say - but smells like a bug on the server =
side
> authentication.
>
> Selva may correct me if I'm wrong, but my understanding of it when clicki=
ng
> "Reconnect", the local OpenVPN process which caches the auth-token is sto=
pped
> and a new OpenVPN process is started.  The client should in this case ask=
 for
> username/password again.  So in this case, the server side should treat t=
his
> connection as a fresh connection with no initial state.

GUI's reconnect button is wired to send a SIGHUP to the client openvpn
process. The problem is that if auth-token is in use, the client
openvpn.exe does not forget it it when restarting the connection by
SIGHUP or SIGUSR1 -- I think it should but it doesn't. That leads to
an AUTH_FAILED from server. The GUI has hard time distinguishing
between reasons for AUTH_FAILED, so it just assumes that password
verification failed and clears the saved password and prompts for a
new one. Obviously users are not happy.

In my view auth-token handling in openvpn.exe is broken at multiple levels:

Client process:
(i) it should not remember the token after a reconnect is issued
(ii) it should not remember the auth-token when auth-nocache is in
effect --- without that there is no way for the GUI to take over
handling auth-token. In my view auth-nocache is the only way
openvpn.exe can stand aside and let the GUI take over all password
handling. Unless we introduce a --management-auth-token flag. Else
what's the use of sending the token to the management interface?
In other words if a user wants auth-token and no GUI, they should not
use auth-nocache, GUI users should use it if they want the GUI to
control all password requests. No need to bend over backwards to
support auth-nocache with auth-token as we now do.

Server process
(iii) --gen-auth-token with an expiry just doesn't work -- we need to
have a mechanism for the server to tell the client that the token has
expired.

>> It looks like nobody uses that button.
>>
>> So, I asked several users, they confirmed they do not use Reconnect.
>This is no good argument for me.  This is one specific setup with 1000 use=
rs.
>It would be more valuable with 50 different setups having 20 users each.  =
Your
>conclusion is based on a very homogeneous environment.

Indeed. Actually I use that button frequently.

>> After auth-token were introduced, when user press "Reconnect", it leads =
to
>> auth fail (saved password is forgotten),

That reads as if introduction of auth-token broke reconnect. It did
not. Only those users who have 2-factor turned on and use
--gen-auth-token on the server are affected.

Selva

