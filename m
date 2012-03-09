MIME-Version: 1.0
In-Reply-To: <9710628022.20120309180907@...449...>
References: <4F4CE4FE.3010009@...515...> <883843028.20120301125911@...449...>
	<2082061.FfdueT8x4P@...1526...> <2610535.JtY05sqIlT@...1526...>
	<9710628022.20120309180907@...449...>
Date: Fri, 9 Mar 2012 19:13:48 +0200
Message-ID: <CAOazyz1bWM3AvYi9qhtwQH=TvFjwFNF0=8M-DaA79vk6gbugzg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Carsten_Kr=C3=BCger?= <C.Krueger@...448...>
Cc: openvpn-devel@lists.sourceforge.net

2012/3/9 Carsten Kr=C3=BCger <C.Krueger@...448...>:
> Hello Heiko,
>
> HH> It is false that you cannot set a process' mandatory label to a higher
> HH> integrity level than the one in the token.
>
> That's not what I said.
> It's not possible to assign an higher level than the user have to a
> users process.
>
> Users can have low and medium, administrators can have hive high and
> system services can have system integerity level.
>
> HH> Instead I plan to secure the process (and the probably the pipe handl=
e as
> HH> well) against malicious operations by not granting the user any sophi=
sticated
> HH> access to it, i.e. you can only inject code if you can write the proc=
ess'
> HH> memory. This will be enforced by the security descriptor assigned to =
the
> HH> process by the service at creation time. The service account will own=
 the
> HH> process object, so that the user cannot sneak his way in by modifying=
 the
> HH> DACL.
>
> Could you please create an tiny example exe for testing?
> I think it didn't work either.
>
> I tried the following (disabled kernel process hacker):
> 1. run an instance of notepad as user Carsten (normal windows user, no ad=
min)
> 2. entered "testtesttest"
> 3. run an instance of process hacker as user Carsten
> 4. tried to write to memory -> worked, closed process hacker
> 5. run an instance of process hacker as admin and stripped permissions fo=
r user Carsten completly, closed process hacker
> 6. run an instance of process hacker as user Carsten
> 7. tried to write to memory -> failed as you expected
> 8. add full permissions to process for user Carsten -> works !!!!!!!
> 9. tried to write to memory -> works !!!!!!!!
>
> It's my process so it's possible for me to change the permissions !!!!!
> I think it didn't get better if a service creates a process for me.
>
> greetings
> Carsten

I truly believe that these kind of solutions tend to be very complicated.
Not sure why Heiko ignores the alternative I suggested.

Alon.

