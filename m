MIME-Version: 1.0
In-Reply-To: <1331052472905814500@...1315...>
References: <4F4CE4FE.3010009@...515...>
	<1848924920.20120228183103@...449...>
	<CAOazyz0x4hKsREcGi+9TGc+AO0d+i1d5qbmPJ2hQfCsUbVanNQ@...278...>
	<319492303.20120228213418@...449...>
	<1331052472905814500@...1315...>
Date: Tue, 6 Mar 2012 19:12:06 +0200
Message-ID: <CAOazyz0K7NONN9uFsqD5_uF_xmApF7BUmE8Wg_tarejrf5aVbw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] OpenVPN Management Interface
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
To: Russell Morris <openvpn@...1315...>
Cc: =?UTF-8?Q?Carsten_Kr=C3=BCger?= <C.Krueger@...448...>, openvpn-devel@lists.sourceforge.net

This exactly what we discuss at the privilege separation thread...
Currently to change configuration you need to start a process.

2012/3/6 Russell Morris <openvpn@...1315...>:
> Hi,
>
>
>
> Taking off from the thread below - is it possible in Windows to start
> openvpn, but only as a sort of local server (for lack of a better term)? I
> would like to start it up, and then be able to initiate connections, tear
> them down, change proxy, etc. - all via the mangement interface.
>
>
>
> Is this possible?
>
>
>
> Thanks!
>
>
>
> ... Russell
>
>
>
>
>
> On Tue, 02/28/2012 02:34 PM, Carsten=C2=A0Kr=C3=BCger=C2=A0<C.Krueger@...493...=
448...> wrote:
>
> Hello Alon,
>
>> This is *THE* missing functionality in Windows environment.
>> It seems that nobody interested in developing proper UI using
>> management interface for Windows.
>> Same goes to proper smartcard support.
>
> I found that openvpn management interface works as I'd like it.
>
> Add the following lines to client.ovpn
> --------------------------------
> management localhost 1000
> management-query-passwords
> auth-retry interact
> management-hold
> --------------------------------
> and start the service.
>
> Use putty to connect to localhost port 1000, format RAW
>
> |>INFO:OpenVPN Management Interface Version 1 -- type 'help' for more info
> |>HOLD:Waiting for hold release
> |hold release
> |SUCCESS: hold release succeeded
> |>PASSWORD:Need 'Auth' username/password
> |username Auth here_comes_my_username
> |SUCCESS: 'Auth' username entered, but not yet verified
> |password Auth here_comes_my_mypassword
> |SUCCESS: 'Auth' password entered, but not yet verified
>
> et voila openvpn connects.
>
> I'd like to cry, how long did this works?
>
> I found this in changelog:
> 2004.11.28 -- Version 2.0-beta18
>
> * Added management interface. See new --management-*
> options or the full management interface documentation
> in management/management-notes.txt in the tarball.
>
>
> greetings
> Carsten
>
>
> -------------------------------------------------------------------------=
-----
> Keep Your Developer Skills Current with LearnDevNow!
> The most comprehensive online learning library for Microsoft developers
> is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
> Metro Style Apps, more. Free future releases when you subscribe now!
> http://p.sf.net/sfu/learndevnow-d2d
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>
> -------------------------------------------------------------------------=
-----
> Keep Your Developer Skills Current with LearnDevNow!
> The most comprehensive online learning library for Microsoft developers
> is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
> Metro Style Apps, more. Free future releases when you subscribe now!
> http://p.sf.net/sfu/learndevnow-d2d
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

