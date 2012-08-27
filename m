References: <1345727389.42365.YahooMailNeo@...1744...>
	<50364E1E.7000109@...1114...>
	<1345828643.55420.YahooMailNeo@...1750...>
	<503A8633.5090308@...1114...>
	<1346030651.69898.YahooMailNeo@...1752...>
	<503B48EB.5090406@...1114...>
Message-ID: <1346073113.9302.YahooMailNeo@...1755...>
Date: Mon, 27 Aug 2012 21:11:53 +0800 (SGT)
From: Amm Vpn <ammdispose-vpn@...109...>
In-Reply-To: <503B48EB.5090406@...1114...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] patch for 2.2.2 to include --script-dir
Reply-To: Amm Vpn <ammdispose-vpn@...109...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>



----- Original Message -----
> From: David Sommerseth <openvpn.list@...1114...>
> To: Amm Vpn <ammdispose-vpn@...109...>
> Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@...1483...=
e.net>
> Sent: Monday, 27 August 2012 3:46 PM
> Subject: Re: [Openvpn-devel] patch for 2.2.2 to include --script-dir
>=20


Hi,

First of all thanks for taking time out to reply.

But based on your replies, I believe you have not understood why I am
proposing this patch. The cases you are talking appear completely
irrelevant to my (and many other) situations.

Let me explain the situation.
1) We are evaluating OpenVPN for connecting 15-20 locations.

2) We liked it, seems quite convenient.
[SIde note: Even if you do not accept the patch we will still go ahead
and patch our own copy of OpenVPN. But we believe in contributing
back. We thought this is any important patch so we are proposing
(but not trying to force) this patch]

3) I am the one who verifies about how secure the code is and if it
insecure, then I try to patch it. If it can not be easily patched, we drop =
it.

4) Noone has root access to system. Noone can change anything by
directly modifying the file on the system via shell.

5) There is password protected web frontend (a textarea HTML field)
where select files can be directly edited by those having password.

This situation (point 4-5) will be true for many other companies as well.
Where people have separate account for accessing frontend. Not just
for OpenVPN but for many other daemons running. Webmin is perfect
example for such a system. (Though we are not using webmin for OpenVPN)

Webmin also specifies which admin has access to what module. For now
please assume that we are using system somewhat similar to webmin.
But an inhouse developed system.

I hope I have explained the situations. So now lets go ahead to your
reasons for not including the patch. And why I think the reasons are
irrelevant.


> a) The user can after having established a connection do a 'ps' and
> list all openvpn processes and it's arguments.=A0 Save this and disconnec=
t.

Not possible in situation I have explained.

> b) Download it's own source code of OpenVPN, and compile it.=A0 Either
> on the same box (if all needed tools are needed) or another one with
> same libraries and copy over the new executable.

Again not possible in situation I have explained.

> c) Modify the $PATH variable ... or try different approaches to run
> its own compiled OpenVPN binary with a modified configuration file
> (without --script-dir).

Again not possible in situation I have explained. But you mentioned
without --script-dir which indirectly means that script-dir would have
made it secure.(which is why I am proposing this)

> And if that doesn't work ... the user can boot the box into
> single-user mode, or with a rescue disk ... and forcefully replace
> your openvpn binary on the filesystem.

Again no physical access. I wonder why are you talking about
this and why you have made this as base for rejecting script-dir??

With this argument, I can simply reject all the security code that has
ever been written in whole world. I can even say we dont need
file permissions that UNIX system gives. We dont need SELINUX
and blah blah.. because user can boot the box in single user mode
and do whatever?

I hope I make some sense here.

> And how does --script-dir change anything in regards to security in here?
>=20
> A more sane approach to avoid users from execute random scripts as
> root is to:
>=20
> =A0 1. have openvpn somewhere on the disk where only root can access and
> =A0 =A0  execute the binary.

Yes this is what we have.

> =A0 2. Save configs in a directory where only root can read/write and do
> =A0 =A0  not allow the user to even read these config files at all.

Yes this is what we have.

> =A0 3. Have a "kick-off" service running, which just takes a reference
> =A0 =A0  to a configuration file, which can start the openvpn process
> =A0 =A0  with the appropriate config - and nothing more.=A0 This needs to=
 be
> =A0 =A0  run with root privileges.

Ok ...

> =A0 4. Have a front-end which the user runs completely unprivileged, which
> =A0 =A0  contacts the "kick-off" service with info about which config to
> =A0 =A0  start.

Ok ...

> Point 3 and 4 is outside the core part of OpenVPN.

Agreed ...

> Bottom line is, you need to ensure that your configuration files are
> to be trusted.=A0 Telling OpenVPN to bailout if one of the paths in the
> config file is wrong, won't add much to improve this situation.=A0 That's
> more an annoyance than anything else.

Ok now let me tell you how many things I will have to check IF I DONT
patch with script-dir. (this will be true for any frontend developer not
just me)

1) I will have to verify for each types of script that openvpn can run.
Currently, it can be one of the following: (taken from man page)
up, down, ipchange, route-up, tls-verify, auth-user-pass-verify, client-con=
nect,
client-disconnect, or learn-address.

2) Tomorrow if new type of script comes, I will have to modify frontend
to check that too and then update all the machines with new frontend.

3) Other way is to write a full-fledged key-value based form (instead of te=
xtarea)
where only allowed config parameters are modify-able. But then this itself
will be big code and every time a modify-able item is to be added or
removed, frontend needs to be changed at all sites. Like if new feature
is added, I will have to enable that in frontend at all sites. If I need to=
 remove
deprecated feature I will have to delete that in front end in all locations.


There can be few other ways which I am not sure. Like I am not sure
if I should check for "--cd" and "--chroot". I need to think if this can be
used to bypass things in frontend. But that later.

As you can see its not easy to write a front end which considers all the
cases of security. One slip in check and hostile admin can trigger
"rm -rf /" on system. I would never ASSUME that my code is fool-proof.

And writing such a frontend itself will run into writing 100-125 lines of c=
ode
whereas patch I submitted is just 25 lines or so and it will always be futu=
re
compatible whatever new types of script is added in future.


With my idea of simple textarea HTML field, local admin himself (without ne=
eding me)
can enable a feature or remove deprecated feature by simply adding/removing
related line. All I have to make sure that disallow word "script-dir" in fr=
ontend.
And may be few other keywords like "chroot".


My idea is to keep things simple and future compatible. Instead of thinking,
re-evaluating everytime a new version of OpenVPN comes.

If you just implement "script-dir", "rm -rf /" will simply never run.


> In general, you can't trust any clients.=A0 Security needs to be tackled
> on the places you fully control and where the clients have no
> possibility to gain root access.=A0 In the moment the user can get root
> access somehow, you're out of control.

Exactly my point security needs to be tackled on place you fully control.
You think frontend is what we control. I think OpenVPN is what we control.

With my patch *no matter* what happens on frontend, even if you forget to
check something else, no matter what new script-type is added. User will
never be able to trigger "rm -rf /" because its been controlled right at
OpenVPN level.

So please give a thought again.

Thanks,

AMM.


