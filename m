Message-ID: <4DAF14F4.4060403@...1114...>
Date: Wed, 20 Apr 2011 19:16:36 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <BANLkTimYEg+6zW4boLrwnFrtKOk5A91Vhw@...278...>	<20110418145411.GQ21485@...1152...>	<BANLkTi=Y=KG3UGQMBL05H=YjprNG5eqPzg@...278...>	<20110418182314.GA2449@...1152...>	<20110418184552.GD2449@...1152...>
	<4DAEFAFC.60506@...1147...>
In-Reply-To: <4DAEFAFC.60506@...1147...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN memory usage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, openvpn-users@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 20/04/11 17:25, Jan Just Keijser wrote:
> Hi *,
> 
> copying in the openvpn-devel list as they might be interested in this memory usage analysis as well....
> 
> Ralf Hildebrandt wrote:
>> * Ralf Hildebrandt <Ralf.Hildebrandt@...1152...>:
>>> * Fredrik Kers <fredrik.kers@...277...>:
>>>> I measure the memory usage by checking the VmRSS (Resident Set Size) in
>>>> /proc/[pid]/status before and after the clients connect (about 1000 of
>>>> them).
>>> So it's the same method (because that's what top and htop do).
>>>
>>>> I'm using a 64 bit system, maybe that will cause OpenVPN to consume
>>>> more memory per client then your setup
>>> Yes, that could be. It's 32Bit here.
>>
>> pmap -d pid_of_openvpn 
>>
>> is showing:
>>
>> # pmap -d 1607
>> 1607:   /usr/sbin/openvpn --writepid /var/run/openvpn.server.pid --syslog ovpn-server --cd /etc/openvpn --config /etc/openvpn/server.conf
>> Address   Kbytes Mode  Offset           Device    Mapping
>> 08048000     500 r-x-- 0000000000000000 068:00005 openvpn
>> 080c5000       4 rwx-- 000000000007d000 068:00005 openvpn
>> 080c6000      24 rwx-- 0000000000000000 000:00000   [ anon ]
>> * 08b51000   41396 rwx-- 0000000000000000 000:00000   [ anon ]
>> b7270000     132 rwx-- 0000000000000000 000:00000   [ anon ]
>> ...
>> bfef8000     132 rw--- 0000000000000000 000:00000   [ stack ]
>> mapped: 46240K    writeable/private: 42304K    shared: 0K
>>
>> The line starting with * shows the biggest chunk of memory in use.
>>
> 
> I'm running openvpn 2.1.4 on a 64bit system (CentSO 5.5 with openssl 0.9.8e). when the first client connects the openvpn server
> gets "hit" by ~ 600 Kb (as seen using pmap). The size of the 'hit' most likely depends on the encryption cipher used.
> 
> I recompiled openvpn using
>   ./configure --with-mem-check=valgrind
> and then ran the server again using
>   valgrind --tool=massif .../openvpn
> 
> this results in a nice memory report which you can view using
>   ms_print massif.out.22218
> 
> turns out that most memory is allocated by the openssl libraries : CRYPTO_malloc
> the memory trace is too large to show here, but there's tons of stuff in that 'ms_print' output.
> Note that compression was NOT used in this example, apparently the openssl libs call deflateInit internally?
> 
> Timestep 49 is when the client connects: you see the memory usage jump from 327,520 bytes to 934,688.
> 
> --------------------------------------------------------------------------------
>   n        time(i)         total(B)   useful-heap(B) extra-heap(B)    stacks(B)
> --------------------------------------------------------------------------------
>  48     36,072,833          327,520          276,102        51,418            0
>  49     36,341,762          934,688          883,126        51,562            0
> 94.48% (883,126B) (heap allocation functions) malloc/new/new[], --alloc-fns, etc.

Again, thanks a lot for wonderful reports.  It is easy to shoot OpenSSL
here.  But I'm not going to do that just yet.  There are some work in
progress of modularising the SSL layer in OpenVPN (if patches are cleaned
up in time and get a decent review, we might have this in OpenVPN 2.3
already).  This work will also add support for PolarSSL.

When we see those patches, it might be easier to see if there's something
which can be improved in OpenVPN or if it is something which is completely
into the hands of OpenSSL.  So running this test with the PolarSSL module
instead will be very interesting.

I generally think that the crypto context needs to stay in memory for some
time, especially in UDP mode, to avoid re-negotiating of the connections in
case of connectivity issues between client and server.  But when the
session is defined as closed by the OpenVPN server, this memory pool should
be released.  For TCP mode, the session is closed (afair) when the client
explicitly closes the connection.  In UDP mode it's a timeout, unless
- --explicit-exit is used.  This freeing of context memory needs to be
verified in the code.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2vFPIACgkQDC186MBRfrrjYACdFgsI9bBKA/Mp5OZ3uwvuwEH8
knwAn3TMjSl2nsiKVxJRNadLh+RAB8mY
=9D/e
-----END PGP SIGNATURE-----

