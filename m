Resent-To: "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>
Resent-Message-ID: <44fc5c99-c00f-8f19-d934-ee906b75a182@...2162...>
References: <efe4c17a-1d4d-d20f-cc77-cf7564ea1184@...2080...>
	<CAKuzo_jGAdGqeMTm6JWRpZgpk+Q0DTq6NFS=3MS73k+jntrL3Q@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <5e0dc59d-b8e7-e215-a0a4-94eaa5280f22@...2080...>
Date: Sat, 27 Aug 2016 12:08:47 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jGAdGqeMTm6JWRpZgpk+Q0DTq6NFS=3MS73k+jntrL3Q@...278...>
Subject: Re: [Openvpn-devel] [RFC] - Enable 2FA to be used with
	renegotiations
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 27/08/16 04:58, Selva Nair wrote:
> Hi,
> 
> On Thu, Aug 25, 2016 at 9:45 AM, David Sommerseth 
> <openvpn@...2080... 
> <mailto:openvpn@...2080...>> wrote:
> 
> The patch-set can be found here: 
> <https://gitlab.com/dazo/openvpn/compare/master...dev%2Fauth-gen-token
>
>
>  And the git tree can be found here: 
> <https://gitlab.com/dazo/openvpn.git> (Check out the
> dev/auth-gen-token branch)
> 
> 
> I posted some quick comments against the commits in your gitlab
> repo. Its only the other day I saw the auth-token code for the
> first time, so I may have more to say after another look when you
> submit it to the list.
> 

Thank you very much!

I've already responded to most of your comments on gitlab, and others
may provide feedback as well too.  I am incredibly thankful for your
reviews and insightful comments, Selva!

There are quite a few things which should be improved before I post it
to the ML.  I'll keep this feature branch buildable and up-to-speed to
the master branch, so this can truly be tested.

My goal is to have all this sorted out before the next 2.3 release, as
I believe this will be important for other changes coming to 2.3 as
well.


- -- 
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJXwWavAAoJEIbPlEyWcf3yvg8P/idH8HwqOGv+TAmvYi3MRgNX
3STktN02ljyXTfdIu1G2xB5fm0+xvaO0brQ811mmTXPb6RXpQe2rnrKmfuJZAUE2
p8f0jm7unkhwQGaPkeByGDU95I/r1gCnX+8EPFRNTgMyQ+CSYtOO8NJYWar9xJPI
rNBfIhAiBXay7cReBGm2zHuiOMgymZR3V1vUNQCT+uUa7NcFdo3Kej2fl8MmqbW8
nZghSt5BSkcdzsOko0we0htqqFU445XVOfYqMZAX7sVuo5YvCYBjC9qW+6TYNy4I
nx8oxoh2S68FzFUHphaNGko4h5oxD960aSKjiTRuchGlVpTB97Bann325Votf4KK
75hWs0HIPL6/QPc3UmZwgslomrz2JuDVl9P82lE7Cibbljo1vayUUbNIch/mXOR4
izHIXHmqzc5TQ5uZfUBDPFG2oXGOhCia3hOOPLBYiYvpA5RkdYo0wA7S6XGhrqEm
8ljLVBipw2KD1wKiS+yKbXKqewbM+0sp+RMHIq5Zs3b3ReH0TtbutJtM1T052msx
h7ZV4yEuovqgmmBkWmNokTRCNzjvhWsM4mrjvGBvDlq2ZJjSUhNlKvNqDbTMfCgb
xCfsIghXOXUNUOPnHhCqJCkSTyEGemjXTFubJ7bnFSHi+08qY5SPM59DDFfXo8Ot
8XcgADaXM3bVbt2TqXPk
=pse0
-----END PGP SIGNATURE-----

