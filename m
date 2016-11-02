References: <20161102120054.ih572dflb2sisb6d@...30...>
	<6ec0e316-008a-1d77-3140-b411e840ff01@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <0a35d0c3-676d-1fc8-f48c-4ede2ff2d5e4@...2080...>
Date: Wed, 2 Nov 2016 13:22:51 +0100
MIME-Version: 1.0
In-Reply-To: <6ec0e316-008a-1d77-3140-b411e840ff01@...1227...>
Subject: Re: [Openvpn-devel] Help with bug report
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/11/16 13:13, Arne Schwabe wrote:
> 
> 
> Am 02.11.16 um 13:00 schrieb Alberto Gonzalez Iniesta:
>> Hi,
>> 
>> I got this bug report [1] on the Debian BTS a long time ago but
>> I haven't been able to debug it. Due to its severity it would be
>> nice to have it fixed for Stretch. Could anyone take a look at
>> it?
>> 
>> Any suggestions on the best procedure to deal with bugs reported
>> on the Debian BTS?
>> 
> I looked at the bug and it seems to boil down to auth-pam in
> openvpn + ldap pam in the pam leads to many /dev/urandom being
> since something in that call stack opens /dev/urandom but never
> closes it.
> 
> From a first glance it looks like problem is not really in OpenVPN 
> itself but rather in the pam libraries/pam ldap libraries.
> 
> Of course someone could write a workaround to use the new async 
> authentication that is implemented in 2.4 and fork so that the
> leaking of fds does not burden the main openvpn process.

That async authentication (if it is "deferred authentication" you
think of) has been present in OpenVPN at least since 2.2 or 2.1.

Using a deferred approach makes a lot of sense, and it will also have
other benefits of not slowing down other connected clients during the
authentication - if that takes a few seconds or more to complete.

Once I get a few reviews completed, I can surely have a look at the
auth-pam module.  Can't commit to a timeline yet, though.


- -- 
kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYGdqbAAoJEIbPlEyWcf3ymEUQAMRspDAIBoqlGdi6czPBmcLS
7XrxJ49Uen5eEwTiyZEjugWW6v8GVbNfcGff6jh4EaScIffRS1NqNKUYi3Lryp+i
WzOkRNZIQGe5mDnFGZCbBFSbDJOA48Gvx4Ez5WXAew12Q90E5ktaZG5kho4hOst9
pvX4mYiIZIvj+/v9tf+IZ2blETRTp9FD2eGBey1KJAKIfRr50XSOtJs12ny0rj6C
aQBe/JTtc99OzlXTJ5Ygi8r8ig23eVt+mZtR4xdCuZ5TI+bCgi8PtOmrES7hfF8t
d/cXI8AKUmlzomuzUYKpo1WWm6fvtAqeCXkaA5Cmw0DrteuOx8GYWSYFMBWXCBIp
W31rJjdpi8HS6R61JiF3Dm5vzokgucnFf7kwrTSoIqbdc/1S5RqWPUMhYu+oic6E
YDg7rmB5ImE+n88O6s4cT4cu5oz/GEccU12zc+p9d/Bvfa2CEhYoKiQEXUjg2U5h
w/80r3jsxN4WqIcJo4XFJcNL7PKTxmoibFuf5MbEe/YkQWuqKOrtiyls0PQ98ydO
huJhYXDM87mgZFKj+9JPGmKGan2UltaeGjT+XyS43T2QJkuV4+OAaub5LIL+ln1t
irZ+7qUFYrrnVl384Euxu7BlL6cnhckWaJZB3Ob2MD4jDFKYGBWJ1zenuVTT7ptE
tW+C41XZJJino0yEoLQD
=HpJK
-----END PGP SIGNATURE-----

