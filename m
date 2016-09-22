References: <1474538677-23301-1-git-send-email-davids@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <c2380f42-42b5-9b38-efe1-e1a29962a672@...2080...>
Date: Thu, 22 Sep 2016 12:14:39 +0200
MIME-Version: 1.0
In-Reply-To: <1474538677-23301-1-git-send-email-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Have the same username/password length
 regardless of PKCS#11 enablement
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
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 22/09/16 12:04, David Sommerseth wrote:
> If running an OpenVPN client with --enable-pkcs11 and a server
> without and having a username and/or password with more than 128
> characters, the authentication will fail as the server truncates
> the password to 128 bytes.
> 
> This makes things easier and more predictable.  Username/passwords 
> can be up to 4096 bytes, regardless of the --enable-pkcs11 state.
> 
> Signed-off-by: David Sommerseth <davids@...515...> --- 
> src/openvpn/misc.h | 9 +++------ 1 file changed, 3 insertions(+), 6
> deletions(-)

I forgot to add the Trac ticket to the commit message, but this should
resolve ticket #712 [1]

[1] <https://community.openvpn.net/openvpn/ticket/712>


- -- 
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJX468PAAoJEIbPlEyWcf3yu6sQAJSOF3f77RCpeFKxJ96C9gJz
Ry3msuuzLceiqlISZ1iqRocaDPz6UNN/AEZSoDFA6UXWWnUvDkM4luiU8pjdxe20
dJaO1BBWm7KVVn66/QQApwFOGUzJLMw2KXGAKaKWQl0jEhxjDMpro6KB60cy+439
D7iFtFwSlFekuW5/8INVyVBNQZ925aOolI2i8GFoH4yHxN3fTSHtIwSQUJpk0UuB
2VN7Lkl5UpwrSlU+YyJtS6YoMQsQm3CEKESus3h8hOLNz8WHFg4aJLHu7M7QKXmU
ShgdF94vFq2+FvZH465gpICIOgDHRLm+TgJ6rNv2iT2G8KotczpuPXz5XxreS4jf
RorDfhnYSw+ZR20cfiFY9et1UgWD3CRHTB+xQh9OXj4qjuxiGrtYG4Y1V1ReYkrw
K0TOOtvkUyiEtqrayKQfAQOLZhVy+IW0qw+FMky8GJYqdpwAzFDMqz3ysI04B4CQ
hf4i9aYIBuEzu82aacyu890zYjFY6wSoxSjS8MyeeeC2GgNz2JvFb2X4W8oratmd
9dvVQa1UVE0okhX+2z9ka4M0+J8GRy9wH2Lagd5cnKIJxUbMDr98H9GErh10uWjU
mIBvCxCnJr01wIEIPagOX5DiLEGMy72F66fm5SZs4NMcdFfpKsf/yhIXNDXtVOhB
lkXu10lYZSIUCsj0YA12
=kTQ5
-----END PGP SIGNATURE-----

