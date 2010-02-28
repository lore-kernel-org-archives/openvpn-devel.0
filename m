Message-ID: <4B8A8DC9.3020502@...1114...>
Date: Sun, 28 Feb 2010 16:37:45 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20100228150546.GO9556@...1296...>
	<540A56F3-EBC5-4872-83C7-D49A1BBD28E0@...1286...>
In-Reply-To: <540A56F3-EBC5-4872-83C7-D49A1BBD28E0@...1286...>
Subject: Re: [Openvpn-devel] FreeBSD funny in the code
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/02/10 16:10, Eric F Crist wrote:
> ACK,
> 
> It's not you, that's duplicate code.
> 

ACK.  I this is indeed duplicated.


David S.

> On Feb 28, 2010, at 09:05:46, Gert Doering wrote:
> 
>> Hi,
>>
>> tun.c contains this code, in the 
>>
>> #elif defined(TARGET_FREEBSD)||defined(TARGET_DRAGONFLY)
>>
>> part of do_ifconfig() (about line 983 in the IPv6 payload branch):
>>
>> ----------------- snip ----------------
>>      else { 
>>        if (tt->topology == TOP_SUBNET)
>>            argv_printf (&argv,
>>                              "%s %s %s netmask %s mtu %d up",
>>                              IFCONFIG_PATH,
>>                              actual, 
>>                              ifconfig_local,
>>                              ifconfig_remote_netmask,
>>                              tun_mtu
>>                              );
>>        else
>>            argv_printf (&argv,
>>                          "%s %s %s netmask %s mtu %d up",
>>                          IFCONFIG_PATH,
>>                          actual,
>>                          ifconfig_local,
>>                          ifconfig_remote_netmask,
>>                          tun_mtu
>>                          );
>>      }                   
>> ----------------- snip ----------------
>>
>> Is it just me needing new glasses, or is this twice the very same code,
>> with a little bit of different indentation?
>>
>> If other people see this too, I'll send in a patch that drops the 
>> duplicate bits.  The tun.c code is still hard enough to read...
>>
>> gert
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuKjckACgkQDC186MBRfrqFfQCfdlWA8m9F37wbqwY/mfd8I2VQ
t08An2o6k1Gyp8+7i61d2iPc+OfM1SCj
=u8Uw
-----END PGP SIGNATURE-----

