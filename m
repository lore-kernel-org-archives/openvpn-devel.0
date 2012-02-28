Date: Tue, 28 Feb 2012 21:34:18 +0100
From: =?utf-8?Q?Carsten_Kr=C3=BCger?= <C.Krueger@...448...>
Message-ID: <319492303.20120228213418@...449...>
In-Reply-To: <CAOazyz0x4hKsREcGi+9TGc+AO0d+i1d5qbmPJ2hQfCsUbVanNQ@...278...>
References: <4F4CE4FE.3010009@...515...>
	<1848924920.20120228183103@...449...>
	<CAOazyz0x4hKsREcGi+9TGc+AO0d+i1d5qbmPJ2hQfCsUbVanNQ@...278...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
Reply-To: =?utf-8?Q?Carsten_Kr=C3=BCger?= <C.Krueger@...448...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: 

Hello Alon,

> This is *THE* missing functionality in Windows environment.
> It seems that nobody interested in developing proper UI using
> management interface for Windows.
> Same goes to proper smartcard support.

I found that openvpn management interface works as I'd like it.

Add the following lines to client.ovpn
--------------------------------
management localhost 1000
management-query-passwords
auth-retry interact
management-hold
--------------------------------
and start the service.

Use putty to connect to localhost port 1000, format RAW

|>INFO:OpenVPN Management Interface Version 1 -- type 'help' for more info
|>HOLD:Waiting for hold release
|hold release
|SUCCESS: hold release succeeded
|>PASSWORD:Need 'Auth' username/password
|username Auth here_comes_my_username
|SUCCESS: 'Auth' username entered, but not yet verified
|password Auth here_comes_my_mypassword
|SUCCESS: 'Auth' password entered, but not yet verified

et voila openvpn connects.

I'd like to cry, how long did this works?

I found this in changelog:
2004.11.28 -- Version 2.0-beta18

* Added management interface.  See new --management-*
  options or the full management interface documentation
  in management/management-notes.txt in the tarball.


greetings
Carsten


