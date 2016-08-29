References: <1472413323-21723-1-git-send-email-steffan@...1856...>
	<5109e5e1-bdc9-4920-fe3e-72461a3ed546@...2080...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <22844900-214f-b69f-ef15-ace77cf56bbe@...2080...>
Date: Mon, 29 Aug 2016 23:03:00 +0200
MIME-Version: 1.0
In-Reply-To: <5109e5e1-bdc9-4920-fe3e-72461a3ed546@...2080...>
Subject: Re: [Openvpn-devel] [PATCH (master)] Drop gnu89/c89 support,
 switch to c99
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
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 29/08/16 22:45, David Sommerseth wrote:
> On 28/08/16 21:42, Steffan Karger wrote:
>> Previously, we would use the compiler's default C version, which 
>> defaults to gnu89 for GCC < 5, gnu11 for GCC > 5, and c11 for 
>> clang, but might even differ per distro.
> 
>> One of the reasons to accept the gnu89 default of GCC < 4.9, was 
>> that MSVC didn't support c99.  But in MSVC 2015, MS finanally
>> fixed that.
> 
>> Having to support c89 in the codebase occasionally forces us to 
>> write less readable code, for example by forcing all declaration
>> to be at the starting of a block (which includes 'for loop
>> initial declarations').
> 
>> Let's be clear about what standard we obey, and stop punishing 
>> ourselves with c89/gnu89.  Let's switch the master branch to
>> c99.
> 
>> Signed-off-by: Steffan Karger <steffan@...1856...> ---
>> configure.ac | 1 + 1 file changed, 1 insertion(+)
> 
>> diff --git a/configure.ac b/configure.ac index 9189c94..16cab19 
>> 100644 --- a/configure.ac +++ b/configure.ac @@ -1125,6 +1125,7
>> @@ if test "${enable_pkcs11}" = "yes"; then ) fi
> 
>> +CFLAGS="${CFLAGS} -std=c99" if test "${enable_pedantic}" =
>> "yes"; then enable_strict="yes" CFLAGS="${CFLAGS} -pedantic"
> 
> 
> I so much wants to give this an ACK.  But this breaks CentOS 5
> builds very badly.  The glibc-headers isn't prepared for C99 on
> that distro.
> 
> I took the latest git master where I could do a successful build. 
> Then I applied just this patch, and here is the explosion: 
> <http://paste.fedoraproject.org/417049/14725031/>
> 
> To move towards C99, we need to add some tricks which makes this
> not requiring users to overwrite C99 with C89.  That should happen 
> automatically.
> 
> Some CentOS 5.11 details: glibc-2.5-123.el5_11.3 
> glibc-headers-2.5-123.el5_11.3 gcc-4.1.2-55.el5 
> openssl-0.9.8e-40.el5_11 lzo-2.02-2.el5.1

Did a bit more testing.

 -std=gnu89, -std=gnu99
   Works very fine (compiles without errors).

 -std=c99
   Makes glibc-headers explode, as already described

 -std=c89
   Makes the LZ4 library we're shipping explode.


- -- 
kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJXxKMEAAoJEIbPlEyWcf3yG4cP/j9rDswKAtpOELBmULCxMng4
Y/y+zFgPNb6u8GMtyWRbeAruNMn06XLXIt0mjPx00NUmN3zhxXXp24mXQZEQu7zO
MaPM6gEYV/PbIueGHfZl0hBys0rAVYFR3NJCmP7jn4VC7jll5BKDpSdpLGYXDXrc
jBqyRBoKq0O1nJXV1KykmzGUkKtBJGPUSpDHoTN3b1ylKbdL9KU9iowyYgzWHYGZ
e1PKXiDLEpOBZHaoOn3JqiHlAAJ7LnfFHh3lY9Dy3UDtOj2xwJtuTuBoisf27rNm
M3Bjfdguq3+dSmSA7JKy5bv1IXU5zPVt3tx2vjplg8XHGF4ppISYR0lwI/WpZSTf
Lm9tb6f9AZGrOhUy1Z4uxUw2ECM5XlgDq+t8QnQ5TeN8BalC1qI/FtIOUWEHFuzF
H3jdMAa/j0Zp/cmnc3gpbh6/hdMuvmlxbn0/rTNiqPpVPYFICnokk7hoa2SbOT0p
chsQGaA6Kj5MBTtqcWuMx7i+sdij9LhF1rTq1cB2AitGMfKgk+ehjttF6aLyZsvu
sZTCQS7s7eP001bhUI6fennTNnbFaUMH6S/Y3mT9IFOElGybfemabXIfzUNOAAH3
BfwTln4+lFC37lnHEcIA8jvLCc4Svz0cGwc/HV7DDbvMt14kmk9peA03qv03NwaC
66fxkZDeTqso4q93Eav5
=cmOG
-----END PGP SIGNATURE-----

