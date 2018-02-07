MIME-Version: 1.0
In-Reply-To: <66f25180-945c-1dc9-a5ca-62d3cacdff2c@...2080...>
References: <CAFHpkQEFPO+TsXdqva=OGg_9FnErDH7Uw9fs876Co_q2A4=rmA@...278...>
 <CAKuzo_hdyx3MH5Cw=gEujHhEvQ1wnOaZ2r0n7=j3GSsv_C1Z2Q@...278...>
 <CAFHpkQFtN6jk5bNcksmoBDjjMd3UbW4sN+y5rH0zUb2sgDq=gg@...278...>
 <6febf54c-f7ab-2297-2c75-72235e14e1c5@...2080...>
 <CAKuzo_gQaniVbD2QuEBb1x+xe8wULUjJkhXMWocyxi=oDknz0w@...278...>
 <66f25180-945c-1dc9-a5ca-62d3cacdff2c@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 7 Feb 2018 16:00:02 -0500
Message-ID: <CAKuzo_juWNt9s1RpUZkbH=KtvttJF1JkX-Cv=StMrbTUXgg1Sg@...278...>
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
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Cc: "openvpn users list (openvpn-users@lists.sourceforge.net)" <openvpn-users@lists.sourceforge.net>

Hi,

On Wed, Feb 7, 2018 at 3:41 PM, David Sommerseth
<openvpn@...2080...> wrote:
> On 07/02/18 21:21, Selva Nair wrote:
>>> Selva may correct me if I'm wrong, but my understanding of it when clicking
>>> "Reconnect", the local OpenVPN process which caches the auth-token is stopped
>>> and a new OpenVPN process is started.  The client should in this case ask for
>>> username/password again.  So in this case, the server side should treat this
>>> connection as a fresh connection with no initial state.
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
> Ahh, thanks for the correction!
>
>> In my view auth-token handling in openvpn.exe is broken at multiple levels:
>>
>> Client process:
>> (i) it should not remember the token after a reconnect is issued
>
> Agreed.  This should trigger retrieving new user input in regards to SIGHUP at
> least.  Not sure yet about SIGUSR1 though.  SIGHUP has a cleared semantic
> though (hang-up).

IIRC, the server creates a new context on both SIGUSR1 and SIGHUP
(and auth-token gets wiped). So I think the client should dump it
before sending SIGUSR1 and SIGHUP.

>
>> (ii) it should not remember the auth-token when auth-nocache is in
>> effect --- without that there is no way for the GUI to take over
>> handling auth-token. In my view auth-nocache is the only way
>> openvpn.exe can stand aside and let the GUI take over all password
>> handling. Unless we introduce a --management-auth-token flag.
>
> Currently, OpenVPN will display the auth-token in the management interface
> when received.  So the management interface should be able to capture it and
> at least know that a token has been received.  But it should also have a
> chance to override it.
>
>> Else what's the use of sending the token to the management interface?
>
> After a discussion with James in regards to the opposite problem with
> NetworkManager.  NM would actually disconnect clients on each tunnel
> renegotiation, as the auth-token was not cached by the NM-openvpn plugin.
>
> We agreed the OpenVPN process was the owner of the token value, not the
> management interface.  So commit 571165360db0392f was applied.  Now we at
> least have a lot of more happy NM users :)

I see. In that case a --management-auth-token or an extra parameter to
management-auth would help. A willing GUI can then use that to
indicate that it'll handle auth-token. Otherwise, openvpn should keep
track of password and auth-token separately instead of using the same
data structure to save it. And notify the GUI whether the failure was
in auth-token or password.

One way for the GUI to handle the current situation is to not take the
first AUTH_FAILED seriously (i.e keep the saved password) when
auth-token is in use. But I would consider that a hack.

>
>> Server process
>> (iii) --gen-auth-token with an expiry just doesn't work -- we need to
>> have a mechanism for the server to tell the client that the token has
>> expired.
>
> Agreed.  We've started looking into this.  But it will require a bigger API
> overhaul to get the needed structs at the proper place where we can send the
> "auth-token expired" message back to the client.  Those code paths involved,
> both the send control channel message and the authentication functions have
> quite different view to the session related structs.

In the mean time we can just document that do not use token expiry.

Selva

