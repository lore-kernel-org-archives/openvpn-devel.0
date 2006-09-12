Message-ID: <4506FB97.5060807@...41...>
Date: Tue, 12 Sep 2006 12:25:27 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <GJEGKFGLCCDAOOCGDAMMOEMHCBAA.jimm@...772...>
In-Reply-To: <GJEGKFGLCCDAOOCGDAMMOEMHCBAA.jimm@...772...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.0.8 and 2.1_beta15
	released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: jimm@...772...
Cc: openvpn-announce@lists.sourceforge.net, OpenVPN devel <openvpn-devel@lists.sourceforge.net>, 'openvpn-users' <openvpn-users@lists.sourceforge.net>

James Miller wrote:
>> -----Original Message-----
>> From: openvpn-users-bounces@lists.sourceforge.net
>> [mailto:openvpn-users-bounces@lists.sourceforge.net]On Behalf Of James
>> Yonan
>> Sent: Tuesday, September 12, 2006 3:17 AM
>> To: 'openvpn-users'; OpenVPN devel;
>> openvpn-announce@lists.sourceforge.net
>> Subject: [Openvpn-users] OpenVPN 2.0.8 and 2.1_beta15 released
>>
>>
>> 2006.09.12 -- Version 2.0.8
>>
>> * Windows installer updated with OpenSSL 0.9.7k DLLs to fix
>>   RSA Signature Forgery (CVE-2006-4339).
>>
>> * No changes to OpenVPN source code between 2.0.7 and 2.0.8.
>>
>> 2006.09.12 -- Version 2.1-beta15
>>
>> * Windows installer updated with OpenSSL 0.9.7k DLLs to fix
>>   RSA Signature Forgery (CVE-2006-4339).
>>
>>     
>
>
> Hello everyone.  I see the new 2.1 beta has a fix for (CVE-2006-4339).  Does
> this mean 2.0.7 is not affected by the OpenSSL RSA Signature Forgery
> vulnerablility?
>   

Basically any version of OpenVPN that uses OpenSSL versions prior to 
0.9.7k is potentially vulnerable (including 2.0.7), however using 
"tls-auth" in the OpenVPN configuration reduces the vulnerability to a 
large extent.

Now having said that, if you are using 2.0.7 on unix, you can continue 
to use 2.0.7, just stop the OpenVPN daemon(s), upgrade the OpenSSL 
package on your system, and then restart OpenVPN.

If you are using 2.0.7 on Windows, you can do one of two things:

(1) Upgrade to 2.0.8, which automatically upgrades OpenSSL to 0.9.7k.

(2) Continue using 2.0.7, but drop in new versions of the OpenSSL DLLs 
(libeay32.dll and libssl32.dll) replacing the files in 2.0.7 of the same 
name.  They are usually stored in \Program Files\OpenVPN\bin.  You can 
download these and their related GnuPG signatures here:

http://openvpn.net/release/openssl/

James



